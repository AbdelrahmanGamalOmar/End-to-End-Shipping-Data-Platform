SELECT  
    ticket_id,
    customer_id,
    shipment_id,
    employee_id,
    ticket_date,
    issue_type,
    description AS issue_description,
    resolution AS issue_resolution,
    status AS ticket_status,
    priority AS ticket_priority,
    resolution_time_minutes,
    customer_satisfaction_rating
FROM    
    {{ source('raw', 'customer_service_tickets') }}