
    
    

with all_values as (

    select
        currency as value_field,
        count(*) as n_records

    from DEEL.staging.stg_globepay__acceptance
    group by currency

)

select *
from all_values
where value_field not in (
    'USD','EUR','GBP','CAD','MXN'
)


