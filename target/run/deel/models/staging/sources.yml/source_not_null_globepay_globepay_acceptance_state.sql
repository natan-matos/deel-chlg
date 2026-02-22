
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select state
from DEEL.RAW.globepay_acceptance
where state is null



  
  
      
    ) dbt_internal_test