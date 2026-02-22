
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  -- tests/assert_no_missing_chargeback.sql
--
-- Singular test: asserts every transaction in the acceptance report
-- has a corresponding row in the chargeback report.
-- The test PASSES when this query returns 0 rows.

select
    external_ref,
    transaction_at,
    country,
    amount_usd

from DEEL.analytics.fct_globepay__transactions

where is_missing_chargeback_data = true
  
  
      
    ) dbt_internal_test