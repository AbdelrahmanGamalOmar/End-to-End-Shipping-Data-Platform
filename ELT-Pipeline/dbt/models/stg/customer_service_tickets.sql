SELECT  
    ticket_id,
    customer_id,
    shipment_id,
    employee_id,
    ticket_date,
    issue_type,
    issue_description,
    issue_resolution,
    ticket_status,
    ticket_priority,
    resolution_time_minutes,
    customer_satisfaction_rating
FROM    
    {{ source('raw', 'customer_service_tickets') }}