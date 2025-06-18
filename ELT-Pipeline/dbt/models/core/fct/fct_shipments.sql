{{
  config(
    materialized = 'incremental',
    unique_key = 'shipment_id',
    on_schema_change = 'fail'
  )
}}

WITH shipments AS (
    SELECT * FROM {{ ref('shipments') }}
),
invoices AS (
    SELECT * FROM {{ ref('invoices') }}
),
claims AS (
    SELECT * FROM {{ ref('insurance_claims') }}
),
packages AS (
    SELECT * FROM {{ ref('packages') }}
),
dates AS (
    SELECT * FROM {{ ref('dim_date') }}
)

SELECT
    s.shipment_id,
    d.date_id,
    s.customer_id,
    p.package_id,
    i.invoice_id,
    s.dispatcher_id,
    s.origin_warehouse_id AS warehouse_id,
    claims.claim_id AS insurance_claim_id,
    i.tax_amount,
    i.discount_amount,
    i.amount_paid,
    i.payment_method,
    i.late_fee_amount

FROM shipments s
LEFT JOIN invoices i ON s.shipment_id = i.shipment_id
LEFT JOIN claims ON s.shipment_id = claims.shipment_id
LEFT JOIN packages p ON s.shipment_id = p.shipment_id
LEFT JOIN dates d ON s.pickup_date = d.date 

{% if is_incremental() %}
  WHERE s.shipment_id > (SELECT MAX(shipment_id) FROM {{ this }})
{% endif %}