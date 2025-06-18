{{ 
    config(
        name= 'finance_fct_insurance',
        materialized= 'incremental',
        on_schema_change= 'fail',
        unique_key= 'claim_id'
    ) 
}}

SELECT 
    i.claim_id,
    d.date_id,
    i.shipment_id,
    i.customer_id,
    i.claim_amount,
    i.damage_description,
    i.claim_status,
    i.settlement_date,
    i.settlement_amount,
    i.adjuster_id AS employee_id
FROM 
    {{ ref('dim_insurance') }} i 
LEFT JOIN 
    {{ ref('dim_date') }} d 
ON 
    i.claim_date = d.date

{% if is_incremental() %}
    WHERE i.claim_id > (SELECT MAX(claim_id) FROM {{ this }})
{% endif %}