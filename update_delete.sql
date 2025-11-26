USE car_rental;

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




