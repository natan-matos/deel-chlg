
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  -- tests/assert_acceptance_rate_in_range.sql
--
-- Data quality guard: acceptance rate per month must be between 50% and 100%.
-- Fires if a month looks implausibly low (possible data load issue).

select
    transaction_month,
    acceptance_rate_pct

from DEEL.analytics.agg_globepay__acceptance_by_month

where acceptance_rate_pct < 50
   or acceptance_rate_pct > 100
  
  
      
    ) dbt_internal_test