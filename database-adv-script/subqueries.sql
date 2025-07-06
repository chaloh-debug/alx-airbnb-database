--properties where the average rating is greater than 4.0
SELECT
    property.property_id,
    property.name,
    AVG(review.rating) as avg_rating
FROM
    property
INNER JOIN
    review ON property.property_id = review.property_id
GROUP BY
    property.property_id
HAVING
    AVG(review.rating) > 4;
