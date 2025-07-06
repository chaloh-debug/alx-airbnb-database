-- initial query and performance test
EXPLAIN ANALYZE
SELECT *
FROM
    booking b
JOIN
    users u ON b.user_id = u.user_id
JOIN
    property p ON b.property_id = p.property_id
JOIN
    payments py ON b.booking_id = py.booking_id
WHERE
    py.status = 'completed';

-- refactored query and performance test
EXPLAIN ANALYZE
SELECT
    b.booking_id,
    b.start_date,
    p.name AS property_name,
    p.location,
    u.first_name,
    u.email AS user_email,
    py.amount,
    py.payment_date
FROM
    booking b
JOIN
    users u ON b.user_id = u.user_id
JOIN
    property p ON b.property_id = p.property_id
JOIN
    payments py ON b.booking_id = py.booking_id
WHERE
    py.status = 'completed';

