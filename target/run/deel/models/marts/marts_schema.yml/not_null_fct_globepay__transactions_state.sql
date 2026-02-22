
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select state
from DEEL.analytics.fct_globepay__transactions
where state is null



  
  
      
    ) dbt_internal_test