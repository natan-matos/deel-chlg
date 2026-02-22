
    
    

select
    transaction_month as unique_field,
    count(*) as n_records

from DEEL.analytics.agg_globepay__acceptance_by_month
where transaction_month is not null
group by transaction_month
having count(*) > 1


