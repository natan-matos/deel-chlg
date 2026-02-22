
    
    

select
    external_ref as unique_field,
    count(*) as n_records

from DEEL.RAW.globepay_acceptance
where external_ref is not null
group by external_ref
having count(*) > 1


