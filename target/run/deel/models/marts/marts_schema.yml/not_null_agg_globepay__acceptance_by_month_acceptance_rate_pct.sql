
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select acceptance_rate_pct
from DEEL.analytics.agg_globepay__acceptance_by_month
where acceptance_rate_pct is null



  
  
      
    ) dbt_internal_test