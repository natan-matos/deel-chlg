
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select transaction_at
from DEEL.analytics.fct_globepay__transactions
where transaction_at is null



  
  
      
    ) dbt_internal_test