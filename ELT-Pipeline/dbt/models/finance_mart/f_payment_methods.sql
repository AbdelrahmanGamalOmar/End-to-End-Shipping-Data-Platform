{{ 
    config(
        name='finance_dim_payment_methods'
    ) 
}}

WITH payments AS 
(
    SELECT 
        CASE 
            WHEN payment_method = 'credit_card' THEN 1
            WHEN payment_method = 'bank_transfer' THEN 2
            WHEN payment_method = 'paypal' THEN 3
            WHEN payment_method = 'cash' THEN 4
            ELSE NULL
        END AS payment_method_id,
        
        payment_method AS payment_method_name
    FROM 
        {{ ref('fct_shipments') }}
)

SELECT  
    CAST(payment_method_id AS INT64) AS payment_method_id,
    payment_method_name
FROM    
    payments