{{ 
    config(name='customer_insights_dim_warehouses') 
}}

SELECT  
    warehouse_id, 
    warehouse_name, 
    warehouse_city,
    warehouse_state,
    start_time,
    end_time,
    manager_id
FROM    
    {{ ref('dim_warehouses') }}