
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with all_values as (

    select
        state as value_field,
        count(*) as n_records

    from DEEL.analytics.fct_globepay__transactions
    group by state

)

select *
from all_values
where value_field not in (
    'ACCEPTED','DECLINED'
)



  
  
      
    ) dbt_internal_test