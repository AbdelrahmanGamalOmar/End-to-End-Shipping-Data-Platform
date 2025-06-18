SELECT  
    purchase_id,
    vehicle_id,
    vendor_id,
    purchase_date,
    gallons_purchased,
    price_per_gallon,
    fuel_total_cost,
    odometer_reading,
    payment_method,
    receipt_number,
    driver_id
FROM    
    {{ source('raw', 'fuel_purchases') }}