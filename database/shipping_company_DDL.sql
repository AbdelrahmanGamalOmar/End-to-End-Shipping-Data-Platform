CREATE DATABASE shipping_management;
USE shipping_management;

CREATE TABLE customers (
	customer_id BIGINT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(50) UNIQUE,
    phone VARCHAR(20) UNIQUE,
    address_line1 VARCHAR(50) NOT NULL,
    address_line2 VARCHAR(50),
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    postal_code VARCHAR(50),
    created_at DATETIME,
    customer_type ENUM('individual', 'business'),
    preferred_contact_method ENUM('email', 'sms'),
    loyalty_points SMALLINT
);

CREATE TABLE service_areas (
	area_id BIGINT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(100),
    base_delivery_fee DECIMAL(10,2) NOT NULL,
    estimated_transit_time_hours SMALLINT,
    service_level ENUM('standard', 'expedited', 'same-day')
);

CREATE TABLE service_area_zip_codes (
	area_id BIGINT,
    zip_code VARCHAR(50) UNIQUE,
    
    FOREIGN KEY (area_id) REFERENCES service_areas(area_id)
);

CREATE TABLE employees (
	employee_id BIGINT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) UNIQUE,
    phone VARCHAR(50) UNIQUE,
    hire_date DATE NOT NULL,
    job_title VARCHAR(50) NOT NULL,
    department VARCHAR(50) NOT NULL,
    manager_id BIGINT,
    monthly_salary DECIMAL(10,2),
    address VARCHAR(50),
    emergency_contact VARCHAR(50),
    driver_license_number VARCHAR(50),
    
    FOREIGN KEY (manager_id) REFERENCES employees(employee_id) ON DELETE SET NULL
);

CREATE TABLE warehouses (
	warehouse_id BIGINT PRIMARY KEY,
    name VARCHAR(50) UNIQUE,
    address VARCHAR(50) UNIQUE,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    postal_code VARCHAR(50),
    created_at DATE NOT NULL,
    updated_at DATE,
    square_footage SMALLINT,
    dock_doors_count SMALLINT,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    manager_id BIGINT,
    temperature_controlled BOOLEAN,
    hazardous_material_allowed BOOLEAN,
    
    FOREIGN KEY (manager_id) REFERENCES employees(employee_id) ON DELETE SET NULL
);

CREATE TABLE vendors (
	vendor_id BIGINT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    contact_person VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    phone VARCHAR(50),
    service_type ENUM('fuel', 'maintenance', 'insurance'),
    contract_start_date DATE NOT NULL,
    contract_end_date DATE,
    preferred_vendor_status VARCHAR(50)
);

CREATE TABLE vehicles (
	vehicle_id BIGINT PRIMARY KEY,
    license_plate VARCHAR(50) UNIQUE,
    make VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    year SMALLINT,
    vehicle_type ENUM('van', 'box-truck'),
    max_weight_capacity SMALLINT NOT NULL,
    max_volume_capacity SMALLINT NOT NULL,
    current_status ENUM('available', 'in-maintenance', 'out-of-service') NOT NULL,
    acquisition_date DATE NOT NULL,
    last_inspection_date DATE,
    next_inspection_date DATE,
    fuel_type ENUM('gasoline', 'diesel', 'electric', 'hybrid') NOT NULL,
    average_mpg SMALLINT,
    current_mileage INT,
    
    CHECK (year >= 2010)
);

CREATE TABLE maintenance_records (
	maintenance_id BIGINT PRIMARY KEY,
    vehicle_id BIGINT,
    vendor_id BIGINT,
    maintenance_type VARCHAR(50),
    description VARCHAR(100),
    date_performed DATE NOT NULL,
    mileage_at_service DECIMAL,
    cost DECIMAL NOT NULL,
    part_used VARCHAR(50),
    next_service_date DATE, 
    technician_note VARCHAR(100),
    
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id) ON DELETE CASCADE,
    FOREIGN KEY (vendor_id) REFERENCES vendors(vendor_id) ON DELETE SET NULL
);

CREATE TABLE fuel_purchases (
	purchase_id BIGINT PRIMARY KEY,
    vehicle_id BIGINT,
    vendor_id BIGINT,
    purchase_date DATETIME,
    gallons DECIMAL(10,2) NOT NULL,
    price_per_gallon DECIMAL(10,2) NOT NULL,
    total_cost DECIMAL(10,2),
    odometer_reading DECIMAL(10,2),
    payment_method ENUM('cash', 'credit-cards', 'debit-cards', 'fuel-cards'),
    receipt_number VARCHAR(50),
    driver_id BIGINT,
    
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id) ON DELETE CASCADE,
    FOREIGN KEY (vendor_id) REFERENCES vendors(vendor_id) ON DELETE SET NULL,
    FOREIGN KEY (driver_id) REFERENCES employees(employee_id) ON DELETE SET NULL
);

CREATE TABLE shipments (
	shipment_id BIGINT PRIMARY KEY,
    customer_id BIGINT NOT NULL,
    origin_warehouse_id BIGINT NOT NULL,
    destination_address VARCHAR(50) NOT NULL,
    destination_city VARCHAR(50) NOT NULL,
    destination_state VARCHAR(50) NOT NULL,
    destination_postal_code VARCHAR(50),
    service_area_id BIGINT,
    pickup_date DATE NOT NULL,
    estimated_delivery_date DATETIME NOT NULL, 
    actual_delivery_date DATETIME NOT NULL,
    status ENUM('pending', 'in-transit', 'delivered', 'delayed', 'cancelled'),
    priority_level ENUM('low', 'medium', 'high', 'urgent'),
    special_instructions VARCHAR(100),
    dispatcher_id BIGINT,
    billing_notes VARCHAR(100),
    
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE,
    FOREIGN KEY (origin_warehouse_id) REFERENCES warehouses(warehouse_id) ON DELETE CASCADE,
    FOREIGN KEY (service_area_id) REFERENCES service_areas(area_id) ON DELETE SET NULL,
    FOREIGN KEY (dispatcher_id) REFERENCES employees(employee_id) ON DELETE SET NULL
);

CREATE TABLE delivery_routes (
	route_id BIGINT PRIMARY KEY,
    driver_id BIGINT NOT NULL,
    vehicle_id BIGINT NOT NULL,
    start_warehouse_id BIGINT NOT NULL,
    start_at DATETIME NOT NULL,
    end_at DATETIME NOT NULL,
    status ENUM('scheduled','in-progress', 'paused', 'completed', 'cancelled'),
    total_stops_planned SMALLINT,
    total_stops_completed SMALLINT,
    miles_estimated DECIMAL(10,2),
    miles_actual DECIMAL(10,2),
    fuel_consumed_gallons DECIMAL(10,2),
    route_score_by_driver DECIMAL (10,2),
    
    FOREIGN KEY (driver_id) REFERENCES employees(employee_id) ON DELETE SET NULL,
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id) ON DELETE CASCADE,
    FOREIGN KEY (start_warehouse_id) REFERENCES warehouses(warehouse_id) ON DELETE CASCADE,
    CHECK (end_at > start_at),
    CHECK (route_score_by_driver BETWEEN 1 AND 5)
);

CREATE TABLE insurance_claims (
    claim_id BIGINT PRIMARY KEY,
    shipment_id BIGINT NOT NULL,
    customer_id BIGINT NOT NULL,
    claim_date DATE NOT NULL,
    claim_amount DECIMAL(10,2) NOT NULL,
    damage_description VARCHAR(100) NOT NULL,
    claim_status ENUM('pending', 'approved', 'denied') NOT NULL,
    settlement_date DATE,
    settlement_amount DECIMAL(10,2),
    adjuster_id BIGINT,
    investigation_notes VARCHAR(100),

    FOREIGN KEY (shipment_id) REFERENCES shipments(shipment_id) ON DELETE CASCADE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE,
    FOREIGN KEY (adjuster_id) REFERENCES employees(employee_id) ON DELETE SET NULL
);

CREATE TABLE customer_service_tickets (
    ticket_id BIGINT PRIMARY KEY,
    customer_id BIGINT NOT NULL,
    shipment_id BIGINT,
    employee_id BIGINT,
    ticket_date DATE NOT NULL,
    issue_type ENUM('delivery_delay', 'damaged_package', 'missing_item', 'billing_issue') NOT NULL,
    description VARCHAR(100),
    resolution VARCHAR(50),
    status ENUM('open', 'in-progress', 'resolved', 'escalated') NOT NULL,
    priority ENUM('low', 'medium', 'high', 'urgent') NOT NULL,
    resolution_time_minutes INT,
    customer_satisfaction_rating DECIMAL(2,1),

    CHECK (customer_satisfaction_rating BETWEEN 1 AND 5),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE,
    FOREIGN KEY (shipment_id) REFERENCES shipments(shipment_id) ON DELETE SET NULL,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE SET NULL
);

CREATE TABLE packages (
    package_id BIGINT PRIMARY KEY,
    shipment_id BIGINT NOT NULL,
    description VARCHAR(100),
    weight DECIMAL(10,2) NOT NULL,
    height DECIMAL(10,2) NOT NULL,
    width DECIMAL(10,2) NOT NULL,
    length DECIMAL(10,2) NOT NULL,
    package_type VARCHAR(50) NOT NULL,
    tracking_number VARCHAR(50) UNIQUE NOT NULL,
    is_fragile BOOLEAN DEFAULT FALSE,
    is_perishable BOOLEAN DEFAULT FALSE,
    requires_signature BOOLEAN DEFAULT FALSE,
    declared_value DECIMAL(10,2),
    customs_info VARCHAR(100),
    handling_instructions VARCHAR(100),

    FOREIGN KEY (shipment_id) REFERENCES shipments(shipment_id) ON DELETE CASCADE
);

CREATE TABLE route_stops (
    stop_id BIGINT PRIMARY KEY,
    route_id BIGINT NOT NULL,
    sequence_number BIGINT NOT NULL,
    shipment_id BIGINT NOT NULL,
    estimated_arrival DATETIME NOT NULL,
    actual_arrival DATETIME,
    departure_time DATETIME,
    stop_duration_minutes TINYINT,
    stop_status ENUM('pending', 'completed', 'skipped', 'failed') NOT NULL,
    delivery_notes VARCHAR(100),
    recipient_signature VARCHAR(50),
    proof_of_delivery_url VARCHAR(100),

    FOREIGN KEY (route_id) REFERENCES routes(route_id) ON DELETE CASCADE,
    FOREIGN KEY (shipment_id) REFERENCES shipments(shipment_id) ON DELETE CASCADE
);

CREATE TABLE inventory (
    inventory_id BIGINT PRIMARY KEY,
    warehouse_id BIGINT NOT NULL,
    package_id BIGINT NOT NULL,
    location_code VARCHAR(50) UNIQUE NOT NULL,
    date_received DATETIME NOT NULL,
    date_shipped DATETIME,
    current_status ENUM('received', 'staged', 'loaded', 'delivered') DEFAULT 'received',
    handled_by BIGINT,
    temperature_log DECIMAL(10,2),

    FOREIGN KEY (warehouse_id) REFERENCES warehouses(warehouse_id) ON DELETE CASCADE,
    FOREIGN KEY (package_id) REFERENCES packages(package_id) ON DELETE CASCADE,
    FOREIGN KEY (handled_by) REFERENCES employees(employee_id) ON DELETE SET NULL
);

CREATE TABLE invoices (
    invoice_id BIGINT PRIMARY KEY,
    shipment_id BIGINT NOT NULL,
    customer_id BIGINT NOT NULL,
    issue_date DATETIME NOT NULL,
    due_date DATETIME NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    tax_amount DECIMAL(10,2),
    discount_amount DECIMAL(10,2),
    amount_paid DECIMAL(10,2),
    payment_date DATETIME,
    payment_method ENUM('credit_card', 'bank_transfer', 'paypal', 'cash') NOT NULL,
    payment_status ENUM('pending', 'paid', 'overdue', 'refunded') DEFAULT 'pending',
    late_fee_amount DECIMAL(10,2),

    FOREIGN KEY (shipment_id) REFERENCES shipments(shipment_id) ON DELETE CASCADE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);