
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select is_accepted
from DEEL.analytics.fct_globepay__transactions
where is_accepted is null



  
  
      
    ) dbt_internal_test