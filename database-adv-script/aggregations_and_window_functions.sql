SELECT
    u.user_id,
    u.first_name,
    COUNT(b.booking_id) AS total_bookings -- Count the bookings for each user
FROM
    users AS u
INNER JOIN
    booking AS b ON u.user_id = b.user_id -- Link users to their bookings
GROUP BY
    u.user_id, u.first_name; -- Bundle all bookings by user


WITH PropertyBookings AS (
    SELECT
        p.property_id,
        p.name,
        COUNT(b.booking_id) AS total_bookings
    FROM
        property AS p
    INNER JOIN
        booking AS b ON p.property_id = b.property_id
    GROUP BY
        p.property_id,
        p.name
)
-- Step 2: Select from the CTE and apply window functions to rank the results
SELECT
    name,
    total_bookings,
    ROW_NUMBER() OVER (ORDER BY total_bookings DESC) AS row_num_rank
FROM
    PropertyBookings
ORDER BY
    total_bookings DESC;
