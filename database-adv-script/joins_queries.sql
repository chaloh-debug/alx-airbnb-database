--inner join
select user.user_id, first_name, last_name from users join booking on users.user_id = booking.user_id;


--left join
select property.property_id, name from property left join review on property.property_id = review.property_id;

--right join
select users.user_id, first_name, last_name from users full outer join booking on users.user_id = booking.user_id;
