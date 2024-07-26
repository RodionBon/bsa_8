SELECT 
    movies.id,
    title,
    release_date,
    duration,
    movie_description,
    JSON_OBJECT('id',
            files.id,
            'file_name',
            files.file_name,
            'mime_type',
            files.mime_type,
            'file_key',
            files.file_key,
            'url',
            files.url) AS poster,
    JSON_OBJECT('id',
            people.id,
            'first_name',
            people.first_name,
            'last_name',
            people.last_name) AS director
FROM
    movies
        LEFT JOIN
    genre_movie ON movies.id = genre_movie.movie_id
        LEFT JOIN
    genres ON genre_movie.genre_id = genres.id
        LEFT JOIN
    people ON movies.director_id = people.id
        LEFT JOIN
    files ON files.id = movies.poster_id
WHERE
    movies.country = '070'
        AND release_date >= '2022-01-01'
        AND duration > '2:15'
        AND (genres.genre_name = 'Action'
        OR genres.genre_name = 'Drama')
GROUP BY movies.id