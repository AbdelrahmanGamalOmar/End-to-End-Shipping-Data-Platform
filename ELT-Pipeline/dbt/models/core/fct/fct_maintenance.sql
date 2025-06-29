{{
  config(
    materialized = 'incremental',
    unique_key = 'maintenance_id',
    on_schema_change = 'fail'
    )
}}

SELECT
    m.maintenance_id,
    d.date_id,
    m.vehicle_id,
    m.vendor_id,
    m.maintenance_description,
    m.maintenance_cost,
    m.part_used,
    m.technician_note
FROM
    {{ ref('maintenance_records') }} m 
LEFT JOIN 
    {{ ref('dim_date') }} d 
ON
    m.date_performed = d.date

{% if is_incremental() %}
  WHERE m.maintenance_id > (SELECT MAX(maintenance_id) FROM {{ this }})
{% endif %} 