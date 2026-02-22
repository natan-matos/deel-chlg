
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select rates
from DEEL.RAW.globepay_acceptance
where rates is null



  
  
      
    ) dbt_internal_test