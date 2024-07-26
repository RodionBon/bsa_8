SELECT 
    id, title, COUNT(all_chars.movie_id) AS actors_count
FROM
    a.movies
        LEFT JOIN
    (SELECT 
        movie_id
    FROM
        characters UNION ALL SELECT 
        movie_id
    FROM
        no_char_actor_movie) all_chars ON all_chars.movie_id = movies.id
WHERE
    a.movies.release_date > DATE_SUB(CURDATE(), INTERVAL 5 YEAR)
GROUP BY id;
