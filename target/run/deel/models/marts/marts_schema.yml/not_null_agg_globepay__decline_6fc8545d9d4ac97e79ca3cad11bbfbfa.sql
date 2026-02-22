
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select exceeds_25m_threshold
from DEEL.analytics.agg_globepay__declined_by_country
where exceeds_25m_threshold is null



  
  
      
    ) dbt_internal_test