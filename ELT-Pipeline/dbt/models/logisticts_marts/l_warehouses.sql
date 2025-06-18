{{ 
    config(name='logistics_dim_warehouses') 
}}

SELECT  
    warehouse_id,
    warehouse_name,
    warehouse_address,
    warehouse_city,
    square_footage,
    temperature_controlled
FROM    
    {{ ref('dim_warehouses') }}