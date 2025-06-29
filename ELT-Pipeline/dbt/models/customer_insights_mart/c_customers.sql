{{ 
    config(
        name='customer_insights_dim_customers'
    ) 
}}

SELECT  *
FROM    {{ ref('dim_customers') }}