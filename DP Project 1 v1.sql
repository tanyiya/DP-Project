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

INSERT INTO vehicles (class, plate_no, vin, make, model, year, vehicle_status, odometer_km, vehicle_location)
VALUES
('Sedan',   'ABC123', '1HGCM82633A004352', 'Toyota',   'Vios',     2020, 'available', 25000, 'Kuala Lumpur'),
('SUV',     'BDF456', '2HGFA16578H311789', 'Honda',    'CR-V',     2019, 'rented',    40000, 'Selangor'),
('Hatchback','GHT789','3N1BC13E58L530294', 'Perodua',  'Myvi',     2022, 'available', 12000, 'Penang'),
('Sedan',   'JKL111', '5YJ3E1EA7JF000111', 'Honda',    'City',     2021, 'maintenance',31000, 'Johor Bahru'),
('Van',     'POI222', '4T1BF1FK5EU365555', 'Toyota',   'Hiace',    2018, 'available', 66000, 'Melaka'),
('SUV',     'TYU333', '1FTRX18L4XKA34567', 'Proton',   'X70',      2023, 'available', 8000,  'Ipoh'),
('Sedan',   'QWE444', '3VWFE21C04M000999', 'BMW',      '320i',     2017, 'rented',    55000, 'Kuala Lumpur'),
('Hatchback','RTY555','2G1WF55KX89345670', 'Perodua',  'Axia',     2020, 'available', 30000, 'Sabah'),
('SUV',     'ZXC666', '1HGCG1659WA035678', 'Mazda',    'CX-5',     2019, 'maintenance',42000, 'Sarawak'),
('Sedan',   'MNB777', '2HGFB2F50DH123456', 'Mercedes', 'C200',     2021, 'rented', 21000, 'Kuala Lumpur');
select * from vehicles;

INSERT INTO customers (name, email, phone_no, license_no, address)
VALUES
('Nur Aisyah Binti Ahmad',       'aisyah.ahmad@example.com',     '0123456789', 'L1234567', 'Selangor'),
('Lim Wei Jian',                 'weijian.lim@example.com',      '0134567890', 'L9876543', 'Kuala Lumpur'),
('A/L Arjun Kumar',              'arjun.kumar@example.com',      '0145678901', 'L4567891', 'Penang'),
('Siti Nur Farhana',             'farhana.siti@example.com',     '0156789012', 'L2222333', 'Johor'),
('Tan Mei Ling',                 'meiling.tan@example.com',      '0167890123', 'L4444555', 'Melaka'),
('Muhammad Iqbal Bin Rashid',    'iqbal.rashid@example.com',     '0178901234', 'L6666777', 'Perak'),
('Kavitha A/P Mani',             'kavitha.mani@example.com',     '0189012345', 'L1111222', 'Selangor'),
('Chong Kai Wen',                'kaiwen.chong@example.com',     '0190123456', 'L5555666', 'Sabah'),
('Harish A/L Rajendran',         'harish.raj@example.com',       '0112345678', 'L3333444', 'Sarawak'),
('Nurul Huda Binti Zulkifli',    'nurul.huda@example.com',       '0198765432', 'L8888999', 'Kelantan');
select * from customers;

INSERT INTO bookings (pickup_date, return_date, pickup_location, return_location, booking_status, customer_id, vehicle_id)
VALUES
('2025-01-01', '2025-01-03', 'KL TRX', 'KL TRX', 'completed', 1, 2),
('2025-01-04', '2025-01-06', 'Selangor Sunway Pyramid', 'Selangor Sunway Pyramid', 'completed', 2, 1),
('2025-02-01', '2025-02-05', 'Penang Airport', 'KL Sentral', 'cancelled', 3, 3),
('2025-02-10', '2025-02-12', 'Johor Mid Valley Southkey', 'KLIA Terminal 1', 'completed', 4, 4),
('2025-03-15', '2025-03-17', 'KL Pavilion', 'KL Pavilion', 'completed', 5, 5),
('2025-03-20', '2025-03-22', 'Ipoh Amanjaya Terminal', 'Penang Queensbay Mall', 'cancelled', 6, 6),
('2025-04-01', '2025-04-04', 'KL KLCC', 'Sarawak Kuching Waterfront', 'completed', 7, 7),
('2025-04-05', '2025-04-10', 'KL Bukit Bintang', 'KL Bukit Bintang', 'cancelled', 8, 8),
('2025-04-12', '2025-04-13', 'Sabah KKIA Airport', 'Sabah KKIA Airport', 'completed', 9, 9),
('2025-04-15', '2025-04-18', 'KL IOI City Mall', 'KL IOI City Mall', 'booked', 10, 10);
select * from bookings;

UPDATE bookings SET booking_date = '2024-12-20 10:15:00' WHERE booking_id = 1;
UPDATE bookings SET booking_date = '2024-12-28 09:45:00' WHERE booking_id = 2;
UPDATE bookings SET booking_date = '2025-01-20 14:30:00' WHERE booking_id = 3;
UPDATE bookings SET booking_date = '2025-01-31 11:10:00' WHERE booking_id = 4;
UPDATE bookings SET booking_date = '2025-03-01 16:00:00' WHERE booking_id = 5;
UPDATE bookings SET booking_date = '2025-03-08 13:25:00' WHERE booking_id = 6;
UPDATE bookings SET booking_date = '2025-03-18 08:50:00' WHERE booking_id = 7;
UPDATE bookings SET booking_date = '2025-03-25 17:40:00' WHERE booking_id = 8;
UPDATE bookings SET booking_date = '2025-03-30 09:00:00' WHERE booking_id = 9;
UPDATE bookings SET booking_date = '2025-04-01 15:35:00' WHERE booking_id = 10;
SELECT * FROM bookings;


INSERT INTO payments (amount, method, payment_date, payment_status, deposit_amount, deposit_refund_status, deposit_refund_date, booking_id)
VALUES
(300.00, 'Credit Card', '2025-01-01', 'paid',     100.00, 'refunded',   '2025-01-03', 1),
(250.00, 'Cash',        '2025-01-04', 'paid',     80.00,  'refunded',   '2025-01-06', 2),
(500.00, 'TNG',         NULL, 'pending',  150.00, 'processing', NULL,         3),
(280.00, 'Credit Card', '2025-02-10', 'paid',     90.00,  'forfeited',  NULL,         4),
(400.00, 'Cash',        '2025-03-15', 'paid',     120.00, 'refunded',   '2025-03-17', 5),
(350.00, 'TNG',         NULL, 'pending',  110.00, 'processing', NULL,         6),
(600.00, 'Credit Card', '2025-04-01', 'paid',     200.00, 'refunded',   '2025-04-04', 7),
(260.00, 'Cash',        '2025-04-05', 'refunded',     85.00,  NULL,   '2025-04-10', 8),
(500.00, 'TNG',         '2025-04-12', 'paid',     170.00, 'refunded',   '2025-04-13', 9),
(320.00, 'Credit Card', NULL, 'pending',  95.00,  'processing', NULL,         10);
select * from payments;

-- Updates with conditions
UPDATE payments
SET method = 'Credit Card',
    payment_date = '2025-04-12',
    payment_status = 'paid'
WHERE booking_id = 10;

UPDATE bookings
SET booking_status = 'completed'
WHERE booking_id = 10;

UPDATE payments
SET deposit_refund_status = 'refunded',
    deposit_refund_date = '2025-04-19'
WHERE booking_id = 10;

UPDATE vehicles
SET vehicle_status = 'available'
WHERE vehicle_id = (
    SELECT vehicle_id
    FROM bookings
    WHERE booking_id = 10
);

-- Delete with conditions
-- Delete payments linked to cancelled bookings before 2025-03-01
DELETE FROM payments
WHERE booking_id IN (
    SELECT booking_id
    FROM (
        SELECT booking_id
        FROM bookings
        WHERE booking_status = 'cancelled'
          AND pickup_date < '2025-03-01'
    ) AS temp_bookings
);

-- Delete cancelled bookings before 2025-03-01
DELETE FROM bookings
WHERE booking_id IN (
    SELECT booking_id
    FROM (
        SELECT booking_id
        FROM bookings
        WHERE booking_status = 'cancelled'
          AND pickup_date < '2025-03-01'
    ) AS temp_bookings
);




