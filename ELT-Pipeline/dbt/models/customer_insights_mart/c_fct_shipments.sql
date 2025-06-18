{{ 
    config(
        name= 'customer_insights_fact_shipments',
        materialized= 'incremental',
        unique_key= 'shipment_id',
        on_schema_change= 'fail'
    ) 
}}

WITH normalized_payment_method AS 
(
    SELECT
        shipment_id,
        date_id,
        customer_id,
        package_id,
        dispatcher_id,
        warehouse_id,
        tax_amount,
        discount_amount,
        amount_paid,
        CASE 
            WHEN payment_method = 'credit_card' THEN 1
            WHEN payment_method = 'bank_transfer' THEN 2
            WHEN payment_method = 'paypal' THEN 3
            WHEN payment_method = 'cash' THEN 4
            ELSE NULL
        END AS payment_method_id
        late_fee_amount
    FROM 
        {{ ref('fct_shipments') }}
)
SELECT
    shipment_id,
    date_id,
    customer_id,
    package_id,
    dispatcher_id AS employee_id,
    warehouse_id,
    CAST(payment_method_id AS INT64) AS payment_method_id,
    tax_amount,
    discount_amount,
    amount_paid,
    late_fee_amount
FROM 
    normalized_payment_method

{% if is_incremental() %}
  WHERE shipment_id > (SELECT MAX(shipment_id) FROM {{ this }})
{% endif %}