SELECT  
    route_id,
    driver_id,
    vehicle_id,
    start_warehouse_id,
    start_at AS route_start_at,
    end_at AS route_end_at,
    status AS route_status,
    total_stops_planned,
    total_stops_completed,
    miles_estimated,
    miles_actual,
    fuel_consumed_gallons,
    route_score_by_driver
FROM    
    {{ source('raw', 'delivery_routes') }}