USE car_rental;

-- Full Text Index
-- Before Indexing
EXPLAIN SELECT * FROM bookings 
WHERE pickup_location LIKE '%KL%';

CREATE FULLTEXT INDEX ft_pickup_location ON bookings(pickup_location);

-- After Indexing
EXPLAIN SELECT * FROM bookings
WHERE MATCH(pickup_location) AGAINST('KL' IN NATURAL LANGUAGE MODE);
