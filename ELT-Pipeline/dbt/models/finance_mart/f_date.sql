{{ 
    config(
        name='finance_dim_date'
    ) 
}}

SELECT  *
FROM    {{ ref('dim_date') }}