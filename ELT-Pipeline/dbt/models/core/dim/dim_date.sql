WITH date_spine AS (
    SELECT 
        DATE('2019-01-01') + INTERVAL i DAY AS date_day
    FROM 
        UNNEST(GENERATE_ARRAY(0, 3650)) AS i  
)

SELECT
    CAST(FORMAT_DATE('%Y%m%d', date_day) AS INT64) AS date_id,
    date_day AS date,
    EXTRACT(YEAR FROM date_day) AS year,
    EXTRACT(QUARTER FROM date_day) AS quarter,
    EXTRACT(MONTH FROM date_day) AS month,
    FORMAT_DATE('%A', date_day) AS day_name,
    EXTRACT(DAYOFWEEK FROM date_day) AS day_of_week,
    FORMAT_DATE('%Y-%m', date_day) AS month_year
FROM 
    date_spine