SELECT  
    area_id,
    zip_code
FROM    
    {{ source('raw', 'service_area_zip_codes') }}