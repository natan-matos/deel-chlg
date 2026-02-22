
    
    

with all_values as (

    select
        state as value_field,
        count(*) as n_records

    from DEEL.staging.stg_globepay__acceptance
    group by state

)

select *
from all_values
where value_field not in (
    'ACCEPTED','DECLINED'
)


