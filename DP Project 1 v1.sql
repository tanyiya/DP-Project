CREATE DATABASE car_rental;
USE car_rental;

DROP TABLE IF EXISTS vehicles;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS payments;

CREATE TABLE vehicles (
	vehicle_id INT AUTO_INCREMENT PRIMARY KEY,
    class VARCHAR(20) NOT NULL,						-- vehicle category eg.sedan,SUV,van
    plate_no VARCHAR(20) UNIQUE NOT NULL,
    vin VARCHAR(17) UNIQUE NOT NULL,				-- Vehicle Identification Number
    make VARCHAR(50) NOT NULL,						-- Manufacturer eg.Toyota,Honda
    model VARCHAR(50) NOT NULL,						-- Specific model name eg.Myvi, Civic
    year INT NOT NULL CHECK (year >= 1990),			-- must >= 1990
	vehicle_status VARCHAR(20) DEFAULT 'available', -- eg. available, rented, maintenance
    odometer_km INT DEFAULT 0,						-- Total kilometers driven.
    vehicle_location TEXT,							-- location where the vehicle is stored
    vehicle_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE customers (
	customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_no VARCHAR(20),
    license_no VARCHAR(50) UNIQUE NOT NULL,
    address TEXT,
    register_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE bookings (
	booking_id INT AUTO_INCREMENT PRIMARY KEY,
    pickup_date DATE NOT NULL,
    return_date DATE NOT NULL,
    pickup_location TEXT,
    return_location TEXT,
    booking_status VARCHAR(20) DEFAULT 'booked',		-- eg.booked, completed,cancelled
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE payments (
	payment_id INT AUTO_INCREMENT PRIMARY KEY,
    amount DECIMAL(10,2) NOT NULL CHECK (amount >= 0),		-- total amount
    method VARCHAR(50),										-- eg. cash, credit card, TNG
    payment_date DATE NOT NULL,
    payment_status VARCHAR(50), 							-- eg. paid, pending
    deposit_amount DECIMAL(10,2) NOT NULL CHECK (deposit_amount >= 0),
    deposit_refund_status VARCHAR(50),						-- eg. refunded, forfeited, processing
    deposit_refund_date DATE
);
    
ALTER TABLE bookings
ADD customer_id INT NOT NULL,
ADD vehicle_id INT NOT NULL,
ADD FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
ADD FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id);

ALTER TABLE payments
ADD booking_id INT NOT NULL,
ADD FOREIGN KEY (booking_id) REFERENCES bookings(booking_id);
