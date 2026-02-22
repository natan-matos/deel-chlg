
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select transaction_month
from DEEL.analytics.agg_globepay__acceptance_by_month
where transaction_month is null



  
  
      
    ) dbt_internal_test