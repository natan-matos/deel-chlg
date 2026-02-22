
    
    

select
    country as unique_field,
    count(*) as n_records

from DEEL.analytics.agg_globepay__declined_by_country
where country is not null
group by country
having count(*) > 1


