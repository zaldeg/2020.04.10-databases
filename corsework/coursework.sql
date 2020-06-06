CREATE DATABASE kinopoisk;

USE kinopoisk;


DROP TABLE IF EXISTS films;
CREATE TABLE films(
       PRIMARY KEY(id),
	   id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	   title VARCHAR(255),
	   country_id INT UNSIGNED NOT NULL,
	   made_in DATE,
	   premiere_date DATE,
	   duration TIME NOT NULL,
	   rating DOUBLE(2,1),
	   budget INT UNSIGNED
) COMMENT = 'Таблица фильмов';


DROP TABLE IF EXISTS genres;
CREATE TABLE genre(
       PRIMARY KEY(id),
       id INT UNSIGNED NOT NULL AUTO_INCREMENT,
       name VARCHAR(255)
) COMMENT = 'виды жанров';


DROP TABLE IF EXISTS persons;
CREATE TABLE persons(
       PRIMARY KEY(id),
       id INT UNSIGNED NOT NULL AUTO_INCREMENT ,
       first_name VARCHAR(255),
       second_name VARCHAR(255),
       birthday DATE,
       death DATE,
       country_id INT UNSIGNED NOT NULL,
       gendre ENUM('male','female'),
       height INT UNSIGNED      
) COMMENT = 'таблица всех личностей';


DROP TABLE IF EXISTS countries;
CREATE TABLE countries(
       PRIMARY KEY(id),
       id INT UNSIGNED NOT NULL AUTO_INCREMENT,
       name VARCHAR(255)
) COMMENT = 'Список стран';


DROP TABLE IF EXISTS person_types;
CREATE TABLE person_type(
       PRIMARY KEY(id),
       id INT UNSIGNED NOT NULL AUTO_INCREMENT,
       type_name VARCHAR(255)
) COMMENT = 'Таблица типов персон(режисеры, актеры, операторы...)';


DROP TABLE IF EXISTS films_persons;
CREATE TABLE films_persons(
       film_id INT UNSIGNED NOT NULL,
       person_id INT UNSIGNED NOT NULL,
       person_type_id INT UNSIGNED NOT NULL,
       name_in_film VARCHAR(255),
       royalties INT UNSIGNED
) COMMENT = 'таблица связности фильмов и личностей';

DROP TABLE IF EXISTS films_genres;
CREATE TABLE films_genre(
       film_id INT UNSIGNED NOT NULL,
       genre_id INT UNSIGNED      
) COMMENT = 'Таблица связности фильмов и жанров';


DROP TABLE IF EXISTS awards;
CREATE TABLE award(
       PRIMARY KEY(id),
       id INT UNSIGNED NOT NULL AUTO_INCREMENT,
       award_title_id INT UNSIGNED NOT NULL, 
       award_name_id INT UNSIGNED NOT NULL,
       person_id INT UNSIGNED,
       film_id INT UNSIGNED
) COMMENT = 'таблица наград';


DROP TABLE IF EXISTS award_names;
CREATE TABLE award_name(
       PRIMARY KEY(id),
       id INT UNSIGNED NOT NULL AUTO_INCREMENT,
       name VARCHAR(255),
       country_id INT UNSIGNED,
       recived DATE       
) COMMENT = 'виды премий(оскар, эмми...)';


DROP TABLE IF EXISTS award_titles;
CREATE TABLE award_title(
       PRIMARY KEY(id),
       id INT UNSIGNED NOT NULL AUTO_INCREMENT,
       title_name VARCHAR(255)
) COMMENT = 'за что дается премия(главная роль, лучший фильмм...)';


DROP TABLE IF EXISTS media;
CREATE TABLE media(
       PRIMARY KEY(id),
       id INT UNSIGNED NOT NULL AUTO_INCREMENT,
       media_type_id INT UNSIGNED,
       person_id INT UNSIGNED,
       film_id INT UNSIGNED,
       file_name VARCHAR(255),
       file_size INT UNSIGNED NOT NULL,
       meta_data LONGTEXT
) COMMENT = 'таблица медиа';


DROP TABLE IF EXISTS media_types;
CREATE TABLE media_type(
       PRIMARY KEY(id),
       id INT UNSIGNED NOT NULL AUTO_INCREMENT,
       name VARCHAR(255)
) COMMENT = 'виды медиа(трейлеры, фото, кадры из фильмов...)';

DROP TABLE IF EXISTS reviews;
CREATE TABLE reviews(
       PRIMARY KEY(id),
       id INT UNSIGNED NOT NULL AUTO_INCREMENT,
       film_id INT UNSIGNED NOT NULL,
       review_body TEXT
) COMMENT = 'отзывы на фильм';

use kinopoisk;

-- ALTER TABLE films DROP FOREIGN KEY films_country_id_fk;

ALTER TABLE films
  ADD CONSTRAINT films_country_id_fk
      FOREIGN KEY (country_id) REFERENCES countries(id);

     
-- ALTER TABLE persons DROP FOREIGN KEY persons_type_of_person_id_fk;
-- ALTER TABLE persons DROP FOREIGN KEY persons_country_id_fk;

ALTER TABLE persons
  ADD CONSTRAINT persons_type_of_person_id_fk
      FOREIGN KEY (person_type_id) REFERENCES person_type(id),
  ADD CONSTRAINT persons_country_id_fk
      FOREIGN KEY (country_id) REFERENCES countries(id);
     
     
-- ALTER TABLE films_persons DROP FOREIGN KEY films_film_id_fk;
-- ALTER TABLE films_persons DROP FOREIGN KEY films_person_id_fk;
-- ALTER TABLE films_persons DROP FOREIGN KEY films_person_type_id_fk;

ALTER TABLE films_persons
  ADD CONSTRAINT films_film_id_fk
      FOREIGN KEY (film_id) REFERENCES films(id),
  ADD CONSTRAINT films_person_id_fk
      FOREIGN KEY (person_id) REFERENCES persons(id),
  ADD CONSTRAINT films_person_type_id_fk
      FOREIGN KEY (person_type_id) REFERENCES person_type(id);

     
-- ALTER TABLE films_genre DROP FOREIGN KEY films_genre_film_id_fk;
-- ALTER TABLE films_genre DROP FOREIGN KEY films_genre_genre_id_fk;     
     
ALTER TABLE films_genre
  ADD CONSTRAINT films_genre_film_id_fk
      FOREIGN KEY (film_id) REFERENCES films(id),      
  ADD CONSTRAINT films_genre_genre_id_fk
      FOREIGN KEY (genre_id) REFERENCES genre(id);

     
-- ALTER TABLE award DROP FOREIGN KEY awards_award_title_id_fk;
-- ALTER TABLE award DROP FOREIGN KEY awards_award_name_id_fk;
-- ALTER TABLE award DROP FOREIGN KEY awards_film_id_fk;
-- ALTER TABLE award DROP FOREIGN KEY awards_person_id_fk;

ALTER TABLE awards
  ADD CONSTRAINT awards_award_title_id_fk
      FOREIGN KEY (award_title_id) REFERENCES award_titles(id),      
  ADD CONSTRAINT awards_award_name_id_fk
      FOREIGN KEY (award_name_id) REFERENCES award_names(id),       
  ADD CONSTRAINT awards_film_id_fk
      FOREIGN KEY (film_id) REFERENCES films(id),   
  ADD CONSTRAINT awards_person_id_fk
      FOREIGN KEY (person_id) REFERENCES persons(id);  

     
-- ALTER TABLE media DROP FOREIGN KEY media_person_id_fk;
-- ALTER TABLE media DROP FOREIGN KEY media_media_type_id_fk;
-- ALTER TABLE media DROP FOREIGN KEY media_film_id_fk;
     
ALTER TABLE media
  ADD CONSTRAINT media_person_id_fk
      FOREIGN KEY (person_id) REFERENCES persons(id),
  ADD CONSTRAINT media_media_type_id_fk
      FOREIGN KEY (media_type_id) REFERENCES media_type(id),
  ADD CONSTRAINT media_film_id_fk
      FOREIGN KEY (film_id) REFERENCES films(id);
     
     
-- ALTER TABLE reviews DROP FOREIGN KEY reviews_film_id_fk;

ALTER TABLE reviews 
  ADD CONSTRAINT reviews_film_id_fk
      FOREIGN KEY (film_id) REFERENCES films(id); 

-- индексы

CREATE INDEX persons_birthday_idx ON persons(birthday);
CREATE INDEX iflms_premiere_date_idx ON films(premiere_date);
CREATE INDEX films_persons_royalties_idx ON films_persons(royalties);
CREATE INDEX films_budget_idx ON films(budget);
