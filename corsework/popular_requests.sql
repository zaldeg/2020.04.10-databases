use kinopoisk;



-- top 10 актеров с лучшим средним рейтингом фильмов.
-- данный запрос выдает не очень адекватную статистику на такой маленькой базе данных,
-- из за большого числа типов людей работающиъ над фильмом получается что почти каждый актер снимался только 1-2 раза в фильме.
-- на большой базе данных такого не будет.

SELECT DISTINCT CONCAT(persons.first_name, ' ', persons.second_name) as name,
	   AVG(films.rating) AS avarage
  FROM persons
       INNER JOIN films_persons
       ON films_persons.person_id = persons.id 
          AND films_persons.person_type_id = 
              (SELECT id 
                 FROM person_types 
                WHERE type_name = 'актер')
       INNER JOIN films 
       ON films.id = films_persons.film_id
 GROUP BY (name)
 ORDER BY avarage desc
 LIMIT 10;



-- все фильмы режисера Seth Reilly упорядоченные по рейтингу по возрастанию(она должна быть режисером в этом фильме)


SELECT DISTINCT CONCAT(persons.first_name, ' ', persons.second_name) as name,
       films.title AS film_tittle,
       films.rating AS film_rating
  FROM persons
       INNER JOIN films_persons 
       ON films_persons.person_id = persons.id
          AND persons.id = 
              (SELECT id 
                 FROM persons 
                WHERE persons.first_name = 'Seth'
                  AND persons.second_name = 'Reilly')
          AND films_persons.person_type_id =
              (SELECT id 
                 FROM person_types
                WHERE type_name = 'режиссер')
        INNER JOIN films 
        ON films_persons.film_id = films.id
  ORDER BY film_rating desc;

              
-- top 10 фильмов в 2010 году по бюджету

SELECT films.title,
       CONCAT(films.budget, '$')
  FROM films
 WHERE YEAR(films.premiere_date) = 2010
 ORDER BY budget desc
 LIMIT 10;



-- все фотографии конретной персоны

SELECT CONCAT(first_name,' ', second_name) as name,
       media.file_name      
  FROM media
       INNER JOIN persons 
       ON media.person_id = persons.id
          AND persons.id = 
              (SELECT id 
                 FROM persons 
                WHERE persons.first_name = 'Adell'
                  AND persons.second_name = 'Jarrod')
       INNER JOIN media_types 
       ON media.media_type_id = media_types.id
          AND media.media_type_id = 
              (SELECT id FROM media_types WHERE name = 'фото');
             
             
-- список людей участввовавших при сьемкефильма, и кем они в нем были получали ли премию.

-- запрос написан вроде как правильно, но из за того что в нем есть две таблицы с film_id, person_id
-- и эти данные рандомилисьто пересечения очень редки, я вручную исправил в премиях человека, чтобы у него была премия.
-- в иотоге он появился. при правильном заполнении все будет работать.


SELECT CONCAT(first_name,' ', second_name) as name,
	   (SELECT type_name
	      FROM person_types
	      WHERE person_types.id = films_persons.person_type_id) as in_film,
       films.title,
       (SELECT name 
          FROM award_names 
         WHERE awards.award_name_id = award_names.id) AS award_name,
       (SELECT title_name 
          FROM award_titles 
         WHERE awards.award_title_id = award_titles.id) AS award_title
  FROM persons
       INNER JOIN films_persons 
       ON films_persons.person_id = persons.id
       INNER JOIN films
       ON films.id = films_persons.film_id
          AND films.id = 
              (SELECT id
                 FROM films
                WHERE title = 'Repellat autem aut ipsum illo.')
       LEFT JOIN awards 
       ON films.id = awards.film_id
          AND persons.id = awards.person_id;
       
              