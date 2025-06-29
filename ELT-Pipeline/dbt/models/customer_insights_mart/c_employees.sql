{{ 
    config(
        name='customer_insights_dim_employees'
    ) 
}}

SELECT  
    employee_id, 
    employee_first_name, 
    employee_last_name, 
    department, 
    job_title,
    manager_id
FROM    
    {{ ref('dim_employees') }}