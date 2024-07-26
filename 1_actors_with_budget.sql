SELECT 
    people.id,
    first_name,
    last_name,
    SUM(movies.budget) AS total_movies_budget
FROM
    people
        INNER JOIN
    characters ON characters.person_id = people.id
        INNER JOIN
    movies ON characters.movie_id = movies.id
GROUP BY person_id