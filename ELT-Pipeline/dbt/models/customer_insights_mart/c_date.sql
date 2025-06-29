{{ 
    config(
        name='customer_insights_dim_date'
    ) 
}}

SELECT  *
FROM    {{ ref('dim_date') }}