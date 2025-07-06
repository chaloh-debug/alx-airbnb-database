--properties where the average rating is greater than 4.0
SELECT
    property.property_id,
    property.name,
    review.rating
WHERE
    review.rating > 4
FROM
    property
INNER JOIN
    review ON property.property_id = review.property_id;
