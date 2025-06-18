SELECT  
    warehouse_id,
    name AS warehouse_name,
    address AS warehouse_address,
    city AS warehouse_city,
    state AS warehouse_state,
    postal_code AS warehouse_postal_code,
    created_at,
    updated_at,
    square_footage,
    dock_doors_count,
    start_time,
    end_time,
    manager_id,
    temperature_controlled,
    hazardous_material_allowed
FROM    
    {{ source('raw', 'warehouses') }}