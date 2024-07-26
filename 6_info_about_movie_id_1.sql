SELECT 
    movies.id,
    title,
    release_date,
    duration,
    movie_description,
    JSON_OBJECT('id',
            poster.id,
            'file_name',
            poster.file_name,
            'mime_type',
            poster.mime_type,
            'file_key',
            poster.file_key,
            'url',
            poster.url) AS poster,
    JSON_OBJECT('id',
            director.id,
            'first_name',
            director.first_name,
            'last_name',
            director.last_name,
            'primary_photo',
            JSON_OBJECT('id',
                    primary_photo.id,
                    'file_name',
                    primary_photo.file_name,
                    'mime_type',
                    primary_photo.mime_type,
                    'file_key',
                    primary_photo.file_key,
                    'url',
                    primary_photo.url)) AS director,
    actors.actors,
    genre_movie.genres
FROM
    movies
        LEFT JOIN
    (SELECT 
        characters.movie_id,
            CASE
                WHEN COUNT(actors.id) = 0 THEN NULL
                ELSE JSON_ARRAYAGG(JSON_OBJECT('id', actors.id, 'first_name', actors.first_name, 'last_name', actors.last_name))
            END AS actors
    FROM
        characters
    LEFT JOIN people actors ON actors.id = characters.person_id
    GROUP BY characters.movie_id) AS actors ON actors.movie_id = movies.id
        LEFT JOIN
    (SELECT 
        movie_id,
            CASE
                WHEN COUNT(genres.id) = 0 THEN NULL
                ELSE JSON_ARRAYAGG(JSON_OBJECT('id', genres.id, 'genre_name', genres.genre_name))
            END AS genres
    FROM
        genre_movie
    LEFT JOIN genres ON genres.id = genre_movie.genre_id
    GROUP BY movie_id) AS genre_movie ON genre_movie.movie_id = movies.id
        LEFT JOIN
    files poster ON poster.id = movies.poster_id
        LEFT JOIN
    people director ON movies.director_id = director.id
        LEFT JOIN
    files primary_photo ON director.main_picture_id = primary_photo.id
WHERE
    movies.id = 1


