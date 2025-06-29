{{ 
    config(
        name='customer_insights_dim_packages'
    ) 
}}

SELECT  
    package_id, 
    tracking_number, 
    requires_signature, 
    handling_instructions
FROM    
    {{ ref('dim_packages') }}