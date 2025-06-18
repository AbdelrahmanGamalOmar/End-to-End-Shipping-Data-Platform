SELECT  
    *
FROM   
    {{ source('raw', 'invoices') }}