{{ 
    config(
        name='logistics_fct_shipments',
        materialized = 'incremental',
        unique_key = 'shipment_id',
        on_schema_change = 'fail'
    ) 
}}

SELECT
    shipment_id,
    date_id,
    employee_id, 
    package_id, 
    warehouse_id, 
    insurance_claim_id, 
    amount_paid, 
    discount_amount, 
    payment_method, 
    late_fee_amount
FROM 
    {{ ref('fct_shipments') }}

{% if is_incremental() %}
  WHERE shipment_id > (SELECT MAX(shipment_id) FROM {{ this }})
{% endif %}