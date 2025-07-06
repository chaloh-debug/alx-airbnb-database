--inner join
SELECT
    booking.booking_id,
    booking.property_id,
    booking.user_id,
    booking.start_date,
    booking.end_date,
    users.first_name,
    users.last_name
FROM booking

INNER JOIN
    users ON booking.user_id = users.user_id;

--left join
SELECT
    property.property_id,
    property.name,
    review.review_id,
    review.rating,
    review.comment
FROM property

LEFT JOIN
    review ON property.property_id = review.property_id;


--full outer join
SELECT
    users.user_id,
    users.first_name,
    users.last_name,
    booking.booking_id,
    booking.property_id,
FROM users

FULL OUTER JOIN
    booking ON users.user_id = booking.user_id;
