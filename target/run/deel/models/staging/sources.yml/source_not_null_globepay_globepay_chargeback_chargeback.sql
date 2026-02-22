
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select chargeback
from DEEL.RAW.globepay_chargeback
where chargeback is null



  
  
      
    ) dbt_internal_test