
CREATE TABLE IF NOT EXISTS files (
	id SERIAL PRIMARY KEY,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    file_name VARCHAR(255) NOT NULL,
    mime_type VARCHAR(255) NOT NULL,
    file_key VARCHAR(255) NOT NULL,
    url VARCHAR(255) NOT NULL
 );
 
 CREATE TABLE IF NOT EXISTS users (
	id SERIAL PRIMARY KEY,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    username VARCHAR(50) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    login VARCHAR(50) NOT NULL,
    pass VARCHAR(50) NOT NULL,
    avatar_id BIGINT  NOT NULL,
    FOREIGN KEY (avatar_id)
    REFERENCES files(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS people (
	id SERIAL PRIMARY KEY,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    biography TEXT,
	date_of_birth DATE,
    gender ENUM('m', 'f', 'non_binary', 'unspecified'),
	country INT,
    main_picture_id BIGINT ,
    FOREIGN KEY (main_picture_id)
    REFERENCES files(id)
);

CREATE TABLE IF NOT EXISTS movies (
	id SERIAL PRIMARY KEY,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	title VARCHAR(50) NOT NULL,
    movie_descripttion TEXT,
    budget DECIMAL(12, 2),
    release_date DATE,
    duration TIME,
    director_id BIGINT  NOT NULL,
    country INT,
    poster_id BIGINT  NOT NULL,
    FOREIGN KEY (director_id)
    REFERENCES people(id) ON DELETE CASCADE,
    FOREIGN KEY (poster_id)
    REFERENCES files(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS characters (
	id SERIAL PRIMARY KEY,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    char_name VARCHAR(50),
    char_description TEXT,
    char_role ENUM('leading','supporting','background'),
    person_id BIGINT ,
    movie_id BIGINT  NOT NULL,
    FOREIGN KEY (movie_id)
    REFERENCES movies(id),
    FOREIGN KEY (person_id)
    REFERENCES people(id)
);

CREATE TABLE IF NOT EXISTS no_char_actor_movie (
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	person_id BIGINT  NOT NULL,
    movie_id BIGINT  NOT NULL,
    PRIMARY KEY (person_id, movie_id),
    FOREIGN KEY (person_id) REFERENCES people(id),
    FOREIGN KEY (movie_id) REFERENCES movies(id)
);


CREATE TABLE IF NOT EXISTS secondary_pictures (
	id SERIAL PRIMARY KEY,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    user_id BIGINT  NOT NULL,
    file_id BIGINT  NOT NULL UNIQUE,
    FOREIGN KEY (user_id)
    REFERENCES users(id),
    FOREIGN KEY (file_id)
    REFERENCES files(id)
);

CREATE TABLE IF NOT EXISTS favorites (
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	user_id BIGINT  NOT NULL,
    movie_id BIGINT  NOT NULL,
    PRIMARY KEY (user_id, movie_id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (movie_id) REFERENCES movies(id)
);

CREATE TABLE IF NOT EXISTS genres (
	id SERIAL PRIMARY KEY,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    genre_name VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS genre_movie (
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	genre_id BIGINT  NOT NULL,
    movie_id BIGINT  NOT NULL,
    PRIMARY KEY (genre_id, movie_id),
    FOREIGN KEY (genre_id) REFERENCES genres(id),
    FOREIGN KEY (movie_id) REFERENCES movies(id)
);