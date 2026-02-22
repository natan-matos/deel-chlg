
    
    

with all_values as (

    select
        chargeback as value_field,
        count(*) as n_records

    from DEEL.RAW.globepay_chargeback
    group by chargeback

)

select *
from all_values
where value_field not in (
    'TRUE','FALSE','True','False'
)


