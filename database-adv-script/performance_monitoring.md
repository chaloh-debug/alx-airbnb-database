## Initial sample query
- - Get all booking details for a specific user, joining to get the property name.
```
EXPLAIN ANALYZE
SELECT b.booking_id, p.name, b.start_date, b.end_date
FROM bookings b
JOIN properties p ON b.property_id = p.property_id
WHERE b.user_id = 1234;
```
## query after indexing
```
EXPLAIN ANALYZE
SELECT b.booking_id, p.name, b.start_date, b.end_date
FROM bookings b
JOIN properties p ON b.property_id = p.property_id
WHERE b.user_id = 1234;

CREATE INDEX idx_bookings_user_id ON bookings(user_id);
```


## Analysis
Execution time improved from 180ms to 30ms after adding indexing o find the user's bookings.
