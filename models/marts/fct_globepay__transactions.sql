-- models/marts/fct_globepay__transactions.sql
--
-- Production fact table joining acceptance + chargeback data.
-- Grain: one row per transaction (external_ref).
--
-- Materialization: incremental with upsert on external_ref.
-- In production, Globepay generates high transaction volumes daily —
-- incremental materialisation avoids reprocessing full history on every run,
-- reducing warehouse compute and run time significantly.


{{
    config(
        materialized='incremental',
        unique_key='external_ref',
        on_schema_change='sync_all_columns'
    )
}}

with acceptance as (
    select * from {{ ref('stg_globepay__acceptance') }}
    {% if is_incremental() %}
        where transaction_at > (select max(transaction_at) from {{ this }})
    {% endif %}
),

chargeback as (
    select * from {{ ref('stg_globepay__chargeback') }}
),

joined as (
    select
        -- identifiers
        a.external_ref,
        a.merchant_ref,
        -- dimensions
        a.transaction_at,
        a.transaction_month,
        date_trunc('week',  a.transaction_at)   as transaction_week,
        date_trunc('day',   a.transaction_at)   as transaction_date,
        year(a.transaction_at)                  as transaction_year,
        month(a.transaction_at)                 as transaction_month_num,
        a.country,
        a.currency,
        a.payment_source,
        a.cvv_provided,
        -- transaction outcome
        a.state,
        a.is_accepted,
        (not a.is_accepted)                     as is_declined,
        -- amounts
        a.amount,
        a.amount_usd,
        -- chargeback
        c.has_chargeback,
        -- flag rows where chargeback data is absent (left-join guard)
        (c.external_ref is null)                as is_missing_chargeback_data

    from acceptance a
    left join chargeback c
        on a.external_ref = c.external_ref
)

select * from joined