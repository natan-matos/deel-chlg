
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with all_values as (

    select
        currency as value_field,
        count(*) as n_records

    from DEEL.analytics.fct_globepay__transactions
    group by currency

)

select *
from all_values
where value_field not in (
    'USD','EUR','GBP','CAD','MXN'
)



  
  
      
    ) dbt_internal_test