SELECT  
    vehicle_id,
    license_plate,
    make AS vehicle_make,
    model AS vehicle_model,
    year AS vehicle_year,
    vehicle_type,
    max_weight_capacity,
    max_volume_capacity,
    current_status,
    acquisition_date,
    last_inspection_date,
    next_inspection_date,
    fuel_type,
    average_mpg,
    current_mileage
FROM    
    {{ source('raw', 'vehicles') }}