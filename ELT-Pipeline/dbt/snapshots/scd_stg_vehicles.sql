{% snapshot scd_stg_vehicles %}

{{
  config(
    unique_key='vehicle_id',
    strategy='check',
    check_cols=['current_status', 'last_inspection_date', 'next_inspection_due', 'current_mileage', 'average_mpg'],
    invalidate_hard_deletes=True
  )
}}

SELECT  * 
FROM    {{ ref('vehicles') }}

{% endsnapshot %}
