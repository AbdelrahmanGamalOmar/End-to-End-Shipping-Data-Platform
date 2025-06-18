SELECT  
    employee_id,
    first_name AS employee_first_name,
    last_name AS employee_last_name,
    email AS employee_email,
    phone AS employee_phone,
    hire_date,
    job_title,
    department,
    manager_id,
    monthly_salary,
    employee_address,
    emergency_contact,
    driver_license_number
FROM    
    {{ source('raw', 'employees') }}