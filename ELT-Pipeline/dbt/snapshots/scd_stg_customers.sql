{% snapshot scd_stg_customers %}

{{
   config(
       unique_key='customer_id',
       strategy='check',
       check_cols = 'all',
       invalidate_hard_deletes=True
   )
}}

SELECT  *
FROM    {{ ref('customers') }}

{% endsnapshot %}