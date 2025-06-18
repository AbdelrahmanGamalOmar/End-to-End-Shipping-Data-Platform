SELECT  
    customer_id,
    name AS customer_name,
    email AS customer_email,
    phone AS customer_phone,
    address_line1 AS customer_address_line1,
    address_line2 AS customer_address_line2,
    city AS customer_city,
    state AS customer_state,
    postal_code AS customer_postal_code,
    created_at,
    customer_type,
    preferred_contact_method,
    loyalty_points
FROM    
    {{ source('raw', 'customers') }}