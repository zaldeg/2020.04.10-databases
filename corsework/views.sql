
-- представление фильмы вс люди визуализированная таблица films_persons c названиями 
-- фильмов и именами людей и роли котороую они в этом фильме играют.


CREATE OR REPLACE VIEW films_persons_view AS 
SELECT films.title AS film_title,
       CONCAT(first_name, ' ', second_name) as person_name,
       (SELECT type_name
          FROM person_types
         WHERE person_types.id = person_type_id) as 'role'
  FROM films_persons
       left JOIN persons
       ON films_persons.person_id = persons.id
       LEFT JOIN films
       ON films.id = films_persons.film_id
 ORDER BY films.title;
      
SELECT * FROM films_persons_view;

      
      
-- люди и премии которые они получили и за что.
CREATE OR REPLACE VIEW persons_awards_view AS 
SELECT CONCAT(first_name, ' ', second_name) AS person_name,
       (SELECT title
          FROM films
         WHERE films.id = awards.film_id) AS film_title,
       (SELECT title_name 
          FROM award_titles 
         WHERE awards.award_title_id = award_titles.id) AS award_title,
       (SELECT name 
          FROM award_names
         WHERE awards.award_name_id = award_names.id) AS award_name
  FROM persons
       LEFT JOIN awards
       ON awards.person_id = persons.id
 ORDER BY second_name;
      
SELECT * FROM persons_awards_view;



