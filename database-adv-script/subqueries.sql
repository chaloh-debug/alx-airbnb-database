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
