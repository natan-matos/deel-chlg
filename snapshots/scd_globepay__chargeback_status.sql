{% snapshot scd_globepay__chargeback_status %}

{{
    config(
        target_schema='snapshots',
        unique_key='external_ref',
        strategy='check',
        check_cols=['has_chargeback'],
    )
}}

select
    external_ref,
    is_active,
    has_chargeback
from {{ ref('stg_globepay__chargeback') }}

{% endsnapshot %}