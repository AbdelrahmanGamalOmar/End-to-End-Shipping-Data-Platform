{{ 
    config(
        name='logistics_dim_date'
) 
}}

SELECT  *
FROM    {{ ref('dim_date') }}