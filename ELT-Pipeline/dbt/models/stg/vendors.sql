SELECT  
    vendor_id,
    name AS vendor_name,
    contact_person,
    email AS vendor_email,
    phone AS vendor_phone,
    service_type,
    contract_start_date,
    contract_end_date,
    preferred_vendor_status AS preferred_vendor_contact_method
FROM    
    {{ source('raw', 'vendors') }}