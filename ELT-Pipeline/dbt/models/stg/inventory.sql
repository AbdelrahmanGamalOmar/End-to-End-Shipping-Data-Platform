SELECT  
    inventory_id,
    warehouse_id,
    package_id,
    location_code,
    date_received,
    date_shipped,
    current_status AS inventory_status,
    handled_by AS handled_by_employee_id,
    temperature_log
FROM    
    {{ source('raw', 'inventory') }}