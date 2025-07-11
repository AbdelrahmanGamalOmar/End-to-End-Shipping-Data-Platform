SELECT  
    maintenance_id,
    vehicle_id,
    vendor_id,
    maintenance_type,
    description AS maintenance_description,
    date_performed,
    mileage_at_service,
    cost AS maintenance_cost,
    part_used,
    next_service_date,
    technician_note
FROM    
    {{ source('raw', 'maintenance_records') }}