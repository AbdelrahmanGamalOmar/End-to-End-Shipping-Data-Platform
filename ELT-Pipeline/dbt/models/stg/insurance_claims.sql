SELECT  
    claim_id,
    shipment_id,
    customer_id,
    claim_date,
    claim_amount,
    damage_description,
    claim_status,
    settlement_date,
    settlement_amount,
    adjuster_id,
    investigation_notes
FROM    
    {{ source('raw', 'insurance_claims') }}