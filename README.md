# bsa_8
erDiagram
    character {
        BIGINT id
        TIMESTAMP created_at
        TIMESTAMP updated_at
        VARCHAR char_name
        TEXT char_description
        ENUM char_role
        BIGINT person_id
        BIGINT movie_id
    }
    favorites {
        TIMESTAMP created_at
        TIMESTAMP updated_at
        BIGINT user_id
        BIGINT movie_id
    }
    files {
        BIGINT id
        TIMESTAMP created_at
        TIMESTAMP updated_at
        VARCHAR file_name
        VARCHAR mime_type
        VARCHAR file_key
        VARCHAR url
    }
    genre_movie {
        TIMESTAMP created_at
        TIMESTAMP updated_at
        BIGINT genre_id
        BIGINT movie_id
    }
    genres {
        BIGINT id
        TIMESTAMP created_at
        TIMESTAMP updated_at
        VARCHAR genre_name
    }
    movies {
        BIGINT id
        TIMESTAMP created_at
        TIMESTAMP updated_at
        VARCHAR tutke
        TEXT movie_description
        DECIMAL budget
        DATE release_date
        TIME duration
        INT country
        BIGINT director_id
        BIGINT poster_id
    }
    no_char_actor_movie {
        TIMESTAMP created_at
        TIMESTAMP updated_at
        BIGINT person_id
        BIGINT movie_id
    }
    people {
        BIGINT id
        TIMESTAMP created_at
        TIMESTAMP updated_at
        VARCHAR first_name
        VARCHAR last_name
        TEXT biography
        DATE date_of_birth
        ENUM gender
        INT country
        BIGINT main_picture_id
    }
    secondary_pictures {
        BIGINT id
        TIMESTAMP created_at
        TIMESTAMP updated_at
        BIGINT user_id
        BIGINT file_id
    }
    users {
        BIGINT id
        TIMESTAMP created_at
        TIMESTAMP updated_at
        VARCHAR username
        VARCHAR first_name
        VARCHAR last_name
        VARCHAR login
        VARCHAR pass
        BIGINT avatar_id
    }

    character }o--|| people:has
    character }o--|| movies:has

    people |o--||files:has
    
    movies |o--||files:has
    movies |o--||people:has

    favorites }o--o{ users:has
    favorites }o--o{ movies:has

    genre_movie }o--o{ movies:has
    genre_movie }o--o{ genres:has

    no_char_actor_movie }o--o{ people:has
    no_char_actor_movie }o--o{ movies:has

    secondary_pictures }o--o{ users:has
    secondary_pictures }o--o{ files:has
