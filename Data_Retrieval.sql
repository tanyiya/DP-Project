USE car_rental;

-- C. Data Retrieval (DQL/SELECT)
-- 1.0 Filtering
-- 1.1 Car available for rental (WHERE)
SELECT * 
FROM vehicles
WHERE vehicle_status = 'available';

-- 1.2 Vehichle between 2020 and 2023 (BETWEEN, AND)
SELECT *
FROM vehicles
WHERE year BETWEEN 2020 AND 2023;

-- 1.3 Honda or Toyata Car (OR)
SELECT *
FROM vehicles
WHERE make = 'Honda' OR make = 'Toyota';

-- 1.4 Successful paid payment (NOT)
SELECT *
FROM payments
WHERE NOT payment_status = 'pending';

-- 1.5 Bookings that picked up in KL (LIKE)
SELECT *
FROM bookings
WHERE pickup_location LIKE '%KL%';

-- 1.6 Payments where deposit_refund_date is NULL (NULL)
SELECT *
FROM payments
WHERE deposit_refund_date IS NULL;

-- 2.0 Sorting
-- 2.1 Sort the vehichle by year (ORDER BY)
SELECT vehicle_id, make, model, year
FROM vehicles
ORDER BY year DESC;

-- 2.2 Top 5 highest deposit amount (LIMIT)
SELECT booking_id, deposit_amount, deposit_refund_status, deposit_refund_date
FROM payments
ORDER BY deposit_amount DESC
LIMIT 5;

-- 3.0 Aggregation 
-- 3.1 The number of customer (COUNT)
SELECT COUNT(*) AS total_customers
FROM customers;

-- 3.2 Total payment collected (SUM)
SELECT SUM(amount) AS total_payment
FROM payments
WHERE payment_status = 'paid';

-- 3.3 Average vehichle odometer reading (AVG)
SELECT AVG(odometer_km) AS avg_odometer
FROM vehicles;

-- 3.4 Maximum and Minimum odometer reading (MAX & MIN)
SELECT 
    MAX(odometer_km) AS highest_odometer,
    MIN(odometer_km) AS lowest_odometer
FROM vehicles;

-- 4.0 Grouping and Filtering Groups
-- 4.1 Count bookings per vehicle (GROUP BY)
SELECT vehicle_id, COUNT(*) AS total_bookings
FROM bookings
GROUP BY vehicle_id;

-- 4.2 Vechile with more that 40000km odometer reading
SELECT vehicle_id, make, model, odometer_km
FROM vehicles
GROUP BY vehicle_id, make, model, odometer_km
HAVING odometer_km > 40000;

-- 5.0 Numeric and String Functions
-- 5.1 Round Payment Amount and Remove Demical Places (ROUND & TRUNCATE)
SELECT payment_id, amount, ROUND(amount, 0) AS rounded_amount, 
	TRUNCATE(amount, 0) AS truncated_amount
FROM payments;

-- 5.2 Change Customer Name to UPPERCASE and count the length (UPPER & LENGTH)
SELECT customer_id, UPPER(name) AS uppercase_name, LENGTH(name) AS name_length
FROM customers;

-- 5.3 Combine the vehicle's model (CONCAT)
SELECT vehicle_id, CONCAT(make, ' ', model) AS full_model
FROM vehicles;

-- 5.4 The Car Plate No. for the vehicle (SUBSTR)
SELECT plate_no, SUBSTR(plate_no, -3) AS car_plate_no
FROM vehicles;

-- 6.0 Conditional Logic
-- 6.1 Categorize payments (CASE WHEN)
SELECT payment_id, amount, payment_status,
       CASE
           WHEN payment_status = 'paid' THEN 'Completed'
           WHEN payment_status = 'pending' THEN 'Pending'
           ELSE 'Unknown'
       END AS current_status
FROM payments;

-- 7.0 Subqueries
-- 7.1 Vehicle the newer than average year (Single-row)
SELECT *
FROM vehicles
WHERE year > (SELECT AVG(year) FROM vehicles);

-- 7.2 Customer that booked a 'SUV' vehicle (Multi-row)
SELECT *
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM bookings
    WHERE vehicle_id IN (
        SELECT vehicle_id
        FROM vehicles
        WHERE class = 'SUV'
    )
);

-- 7.3 Latest booking date for each customer (Correlated)
SELECT c.customer_id, c.name,
       (SELECT MAX(b.booking_date)
        FROM bookings b
        WHERE b.customer_id = c.customer_id) AS latest_booking
FROM customers c;

-- 8.0 Set Operations
-- 8.1 List all pickup and return locations (UNION)
SELECT pickup_location AS location
FROM bookings
UNION
SELECT return_location
FROM bookings;

-- 8.2 Customer with no completed bookings (NOT EXIST)
SELECT *
FROM customers c
WHERE NOT EXISTS (
    SELECT *
    FROM bookings b
    WHERE b.customer_id = c.customer_id
      AND b.booking_status = 'completed'
);

-- 9.0 Joins
-- 9.1 Combine bookings and payments (NATURAL)
SELECT *
FROM bookings
NATURAL JOIN payments;

-- 9.2 Booking with customer's name (INNER)
SELECT b.booking_id, c.name AS customer_name, b.pickup_date, b.return_date
FROM bookings b
INNER JOIN customers c
    ON b.customer_id = c.customer_id;

-- 9.3 Vehicle with booking (LEFT)
SELECT v.vehicle_id, v.make, v.model, b.booking_id
FROM vehicles v
LEFT JOIN bookings b
    ON v.vehicle_id = b.vehicle_id;

-- 9.4 Customer that live in same state (SELF)
SELECT c1.name AS customer1, c2.name AS customer2, c1.address
FROM customers c1
JOIN customers c2
    ON c1.address = c2.address
   AND c1.customer_id < c2.customer_id;
