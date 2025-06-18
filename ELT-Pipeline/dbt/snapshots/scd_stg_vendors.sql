{% snapshot scd_stg_vendors %}

{{
   config(
       unique_key='vendor_id',
       strategy='timestamp',
       updated_at='contract_end_date',
       invalidate_hard_deletes=True
   )
}}

SELECT  *
FROM    {{ ref('vendors') }}

{% endsnapshot %}