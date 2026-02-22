
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select external_ref
from DEEL.analytics.fct_globepay__missing_chargebacks
where external_ref is null



  
  
      
    ) dbt_internal_test