-- models/staging/stg_globepay_chargeback.sql
--
-- Cleans and type-casts the raw Globepay Chargeback Report.
-- One row per transaction with chargeback status.

with source as (
    select * from {{source('globepay', 'globepay_chargeback')}}
),

renamed as (
    select
        -- identifiers
        external_ref                                     as external_ref,
        status::boolean                                  as is_active,
        source                                           as payment_source,
        (upper(trim(chargeback)) = 'TRUE')::boolean       as has_chargeback
    from source
)

select * from renamed