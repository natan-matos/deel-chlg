
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select total_transactions
from DEEL.analytics.agg_globepay__declined_by_country
where total_transactions is null



  
  
      
    ) dbt_internal_test