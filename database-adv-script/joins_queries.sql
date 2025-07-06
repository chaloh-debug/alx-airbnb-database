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
select property.property_id, name from property left join review on property.property_id = review.property_id;

--right join
select users.user_id, first_name, last_name from users full outer join booking on users.user_id = booking.user_id;
