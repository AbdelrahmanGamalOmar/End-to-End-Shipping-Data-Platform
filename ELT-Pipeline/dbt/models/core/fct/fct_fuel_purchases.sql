{{
  config(
    materialized='incremental',
    on_schema_change='fail',
    unique_key='purchase_id'
    )
}}

SELECT 
    f.purchase_id,
    d.date_id,
    f.vehicle_id,
    f.vendor_id,
    f.drive_id,
    f.gallons_purchased AS gallons,
    f.price_per_gallon,
    f.odometer_reading,
FROM 
    {{ ref('fuel_purchases') }} f 
LEFT JOIN 
    {{ ref('dim_date') }} d 
ON 
    f.purchase_date = d.date

{% if is_incremental() %}
  WHERE f.purchase_id > (SELECT MAX(purchase_id) from {{ this }})
{% endif %}