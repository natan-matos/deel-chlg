-- models/marts/agg_globepay__acceptance_by_month.sql
--
-- Monthly acceptance rate summary.
-- Answers Q1: "What is the acceptance rate over time?"

with base as (
    select * from {{ ref('stg_globepay__acceptance') }}
),

monthly as (
    select
        transaction_month,
        count(*) as total_transactions,
        sum(is_accepted::int) as accepted_transactions,
        round(sum(is_accepted::int) / count(*) * 100, 2) as acceptance_rate_pct,
        sum(amount_usd) as total_amount_usd,
        sum(case when is_accepted then amount_usd end) as accepted_amount_usd,
        sum(case when not is_accepted then amount_usd end) as declined_amount_usd
    from base
    group by 1
)

select * from monthly