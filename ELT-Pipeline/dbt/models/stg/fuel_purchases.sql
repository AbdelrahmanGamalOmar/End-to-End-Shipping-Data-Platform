SELECT  
    purchase_id,
    vehicle_id,
    vendor_id,
    purchase_date,
    gallons AS gallons_purchased,
    price_per_gallon,
    total_cost AS fuel_total_cost,
    odometer_reading,
    payment_method,
    receipt_number,
    driver_id
FROM    
    {{ source('raw', 'fuel_purchases') }}