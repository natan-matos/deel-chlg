-- models/marts/agg_globepay__declined_by_country.sql
--
-- Total declined transaction value by country (USD).
-- Answers Q2: "Countries where declined transactions went over $25M"

with base as (
    select * from DEEL.staging.stg_globepay__acceptance
),

by_country as (
    select
        country,
        count(*) as total_transactions,
        sum((not is_accepted)::int) as declined_transactions,
        round(sum(case when not is_accepted then amount_usd end), 2) as declined_amount_usd,
        round(sum((not is_accepted)::int)::float / nullif(count(*), 0) * 100, 2) as decline_rate_pct
    from base
    group by 1
),

flagged as (
    select
        *,
        (declined_amount_usd > 25000000) as exceeds_25m_threshold
    from by_country
    order by declined_amount_usd desc
)

select * from flagged