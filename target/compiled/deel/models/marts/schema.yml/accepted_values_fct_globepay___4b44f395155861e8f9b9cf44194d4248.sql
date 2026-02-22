
    
    

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


