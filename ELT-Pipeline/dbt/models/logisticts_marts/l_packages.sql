{{ 
    config(name='logistics_dim_packages') 
}}

SELECT  
    package_id,
    package_description,
    package_weight,
    package_length,
    package_width,
    package_height,
    package_type,
    is_perishable,
    is_fragile
FROM    {{ ref('dim_packages') }}