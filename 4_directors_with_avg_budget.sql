SELECT 
    people.id,
    CONCAT(first_name, ' ', last_name) AS director_name,
    AVG(budget)
FROM
    people
        JOIN
    movies ON movies.director_id = people.id
GROUP BY people.id