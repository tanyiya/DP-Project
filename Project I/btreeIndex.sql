USE car_rental;

-- BTree Index
-- Before Indexing
EXPLAIN SELECT * FROM bookings
WHERE pickup_date = '2025-03-15';

CREATE INDEX idx_pickup_date
ON bookings(pickup_date);

-- After Indexing
EXPLAIN SELECT * FROM bookings
WHERE pickup_date = '2025-03-15';
