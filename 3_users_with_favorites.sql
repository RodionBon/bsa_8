SELECT 
    id,
    username,
    GROUP_CONCAT(favorites.movie_id) AS favorite_movies_ids
FROM
    users
        LEFT JOIN
    favorites ON favorites.user_id = users.id
GROUP BY id