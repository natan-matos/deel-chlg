
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select accepted_transactions
from DEEL.analytics.agg_globepay__acceptance_by_month
where accepted_transactions is null



  
  
      
    ) dbt_internal_test