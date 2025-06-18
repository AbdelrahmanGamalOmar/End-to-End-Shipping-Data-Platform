SELECT  
    shipment_id,
    customer_id,
    origin_warehouse_id,
    destination_address,
    destination_city,
    destination_state,
    destination_postal_code,
    service_area_id,
    pickup_date,
    estimated_delivery_date,
    actual_delivery_date,
    status AS shipment_status,
    priority_level,
    special_instructions,
    dispatcher_id,
    billing_notes
FROM    
    {{ source('raw', 'shipments') }}