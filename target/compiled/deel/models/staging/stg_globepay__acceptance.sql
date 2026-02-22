-- models/staging/stg_globepay_acceptance.sql
--
-- Cleans and type-casts the raw Globepay Acceptance Report.
-- One row per transaction attempt.

with source as (
    select * from DEEL.RAW.globepay_acceptance
),

renamed as (
    select
        -- identifiers
        external_ref                                     as external_ref,
        ref                                              as merchant_ref,

        -- metadata
        status::boolean                                  as is_active,
        source                                           as payment_source,

        -- temporal
        to_timestamp_ntz(date_time)                      as transaction_at,
        date_trunc('month', transaction_at)              as transaction_month,

        -- transaction details
        upper(trim(state))                               as state,
        (upper(trim(state)) = 'ACCEPTED')::boolean       as is_accepted,
        amount::float                                    as amount,
        upper(trim(currency))                            as currency,
        upper(trim(country))                             as country,
        cvv_provided::boolean                            as cvv_provided,

        -- exchange rates stored as JSON string → parse key fields
        try_parse_json(rates)                            as rates_json,
         -- derived: normalise amount to USD
        case currency
            when 'USD' then amount
            when 'EUR' then amount / nullif(rates_json['EUR']::float, 0)
            when 'GBP' then amount / nullif(rates_json['GBP']::float, 0)
            when 'CAD' then amount / nullif(rates_json['CAD']::float, 0)
            when 'MXN' then amount / nullif(rates_json['MXN']::float, 0)
            else null
        end                                              as amount_usd

    from source
)

select * from renamed