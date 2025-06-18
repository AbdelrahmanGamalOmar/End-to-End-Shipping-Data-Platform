{% snapshot scd_stg_warehouses %}

{{
   config(
       unique_key='warehouse_id',
       strategy='timestamp',
       updated_at='updated_at',
       invalidate_hard_deletes=True
   )
}}

SELECT  *
FROM    {{ ref('warehouses') }}


{% endsnapshot %}