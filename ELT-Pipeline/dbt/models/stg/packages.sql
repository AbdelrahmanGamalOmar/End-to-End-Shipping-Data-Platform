SELECT  
    package_id,
    shipment_id,
    description AS package_description,
    weight AS package_weight,
    height AS package_height,
    width AS package_width,
    length AS package_length,
    package_type,
    tracking_number,
    is_fragile,
    is_perishable,
    requires_signature,
    declared_value,
    customs_info,
    handling_instructions
FROM    
    {{ source('raw', 'packages') }}