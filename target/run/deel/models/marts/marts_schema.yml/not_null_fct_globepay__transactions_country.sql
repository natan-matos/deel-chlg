
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select country
from DEEL.analytics.fct_globepay__transactions
where country is null



  
  
      
    ) dbt_internal_test