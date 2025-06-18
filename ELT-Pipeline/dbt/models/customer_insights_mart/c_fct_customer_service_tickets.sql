{{ 
    config(
        name='customer_insights_fct_customers_service_tickets',
        materialized= 'incremental',
        unique_key= 'ticket_id',
        on_schema_change= 'fail'
    ) 
}}

SELECT  
    *
FROM 
    {{ ref('customer_service_tickets') }}

{% if is_incremental() %}
  WHERE ticket_id > (SELECT MAX(ticket_id) FROM {{ this }})
{% endif %}