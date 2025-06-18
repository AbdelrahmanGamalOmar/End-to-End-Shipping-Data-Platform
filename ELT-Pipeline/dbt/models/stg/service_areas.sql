SELECT  
    area_id,
    name AS area_name,
    description AS area_description,
    base_delivery_fee,
    estimated_transit_time_hours,
    service_level
FROM    
    {{ source('raw', 'service_areas') }}