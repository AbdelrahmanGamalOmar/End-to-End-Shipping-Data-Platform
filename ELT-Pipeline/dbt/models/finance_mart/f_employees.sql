{{
    config(name="finance_dim_employees")
}}

SELECT  
    employee_id, 
    employee_first_name, 
    employee_last_name, 
    department, 
    job_title,
    monthly_salary,
    manager_id
FROM    
    {{ ref('dim_employees') }}