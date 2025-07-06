--properties where the average rating is greater than 4.0
SELECT
    property.property_id,
    property.name,
    review.rating
FROM
    property
INNER JOIN
(
    SELECT
        property_id,
        AVG(review.rating) AS avg_rating
    FROM
        review
    GROUP BY
        property_id
) AS ratings ON property.property_id = ratings.property_id -- End of the subquery
WHERE
    ratings.avg_rating > 4;

--correlated subquery
SELECT
    user_id,
    first_name,
    last_name
FROM
    users AS u -- The "Outer Query" table
WHERE
    3 < ( -- Check if 3 is less than the number returned by the subquery
        SELECT
            COUNT(*)
        FROM
            booking AS b
        WHERE
            b.user_id = u.user_id -- <-- The "Correlation"
    );


