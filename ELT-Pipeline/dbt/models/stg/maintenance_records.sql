SELECT  
    maintenance_id,
    vehicle_id,
    vendor_id,
    maintenance_type,
    maintenance_description,
    date_performed,
    mileage_at_service,
    cost AS maintenance_cost,
    part_used,
    next_service_date,
    technician_notes
FROM    
    {{ source('raw', 'maintenance_records') }}