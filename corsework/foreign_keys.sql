use kinopoisk;

-- ALTER TABLE films DROP FOREIGN KEY films_country_id_fk;

ALTER TABLE films
  ADD CONSTRAINT films_country_id_fk
      FOREIGN KEY (country_id) REFERENCES countries(id);

     
-- ALTER TABLE persons DROP FOREIGN KEY persons_country_id_fk;

ALTER TABLE persons
  ADD CONSTRAINT persons_country_id_fk
      FOREIGN KEY (country_id) REFERENCES countries(id);
     
     
-- ALTER TABLE films_persons DROP FOREIGN KEY films_persons_film_id_fk;
-- ALTER TABLE films_persons DROP FOREIGN KEY films_persons_person_id_fk;
-- ALTER TABLE films_persons DROP FOREIGN KEY films_persons_person_type_id_fk;

ALTER TABLE films_persons
  ADD CONSTRAINT films_persons_film_id_fk
      FOREIGN KEY (film_id) REFERENCES films(id),
  ADD CONSTRAINT films_persons_person_id_fk
      FOREIGN KEY (person_id) REFERENCES persons(id),
  ADD CONSTRAINT films_persons_person_type_id_fk
      FOREIGN KEY (person_type_id) REFERENCES person_type(id);

     
-- ALTER TABLE films_genres DROP FOREIGN KEY films_genres_film_id_fk;
-- ALTER TABLE films_genres DROP FOREIGN KEY films_genres_genre_id_fk;     
     
ALTER TABLE films_genres
  ADD CONSTRAINT films_genres_film_id_fk
      FOREIGN KEY (film_id) REFERENCES films(id),      
  ADD CONSTRAINT films_genres_genre_id_fk
      FOREIGN KEY (genre_id) REFERENCES genre(id);

     
ALTER TABLE awards DROP FOREIGN KEY awards_award_title_id_fk;
ALTER TABLE awards DROP FOREIGN KEY awards_award_name_id_fk;
ALTER TABLE awards DROP FOREIGN KEY awards_film_id_fk;
ALTER TABLE awards DROP FOREIGN KEY awards_person_id_fk;


ALTER TABLE awards
  ADD CONSTRAINT awards_award_titles_id_fk
      FOREIGN KEY (award_title_id) REFERENCES award_titles(id),      
  ADD CONSTRAINT awards_award_names_id_fk
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
      
      
   

      


  