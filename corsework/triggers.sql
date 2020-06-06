use kinopoisk;

-- в премии не может быть одновременно пустог person_id и film_id

DROP TRIGGER IF EXISTS check_award_for_receiver_on_insert;
DELIMITER //
CREATE TRIGGER check_award_for_receiver_on_insert BEFORE INSERT ON awards
FOR EACH ROW BEGIN 
	DECLARE flag INT;
    SET flag = (
               NEW.film_id IS NOT NULL 
               OR NEW.person_id IS NOT NULL
      );
   IF flag = 0 THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INSERT canceled, person_id or film_id have to be not NULL';
   END IF;
END//

DELIMITER ;


DROP TRIGGER IF EXISTS check_award_for_receiver_on_update;
DELIMITER //
CREATE TRIGGER check_award_for_receiver_on_update BEFORE UPDATE ON awards
FOR EACH ROW BEGIN 
	DECLARE flag INT;
    SET flag = (
               NEW.film_id IS NOT NULL 
               OR NEW.person_id IS NOT NULL
      );
   IF flag = 0 THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'UPDATE canceled, person_id or film_id have to be not NULL';
   END IF;
END//

DELIMITER ;

-- должны присутствовать оба значения в films_persons и фильм и персона

DROP TRIGGER IF EXISTS check_new_person_film_for_exists_on_insert;
DELIMITER //
CREATE TRIGGER check_new_person_film_for_exists_on_insert BEFORE INSERT ON films_persons
FOR EACH ROW BEGIN 
	DECLARE flag INT;
    SET flag = (
               NEW.film_id IS NOT NULL 
               AND NEW.person_id IS NOT NULL
      );
   IF flag = 0 THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INSERT canceled, person_id and film_id have to be not NULL';
   END IF;
END//

DELIMITER ;

DROP TRIGGER IF EXISTS check_new_person_film_for_exists_on_update;
DELIMITER //
CREATE TRIGGER check_new_person_film_for_exists_on_update BEFORE UPDATE ON films_persons
FOR EACH ROW BEGIN 
	DECLARE flag INT;
    SET flag = (
               NEW.film_id IS NOT NULL 
               AND NEW.person_id IS NOT NULL
      );
   IF flag = 0 THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'UPDATE canceled, person_id and film_id have to be not NULL';
   END IF;
END//

DELIMITER ;

-- проверяем нового человека на на дату смерти, если она есть то должна быть позже рождения.

DROP TRIGGER IF EXISTS check_death_before_birthday_on_insert;
DELIMITER //
CREATE TRIGGER check_death_before_birthday_on_insert BEFORE INSERT ON persons
FOR EACH ROW BEGIN 
	DECLARE flag INT;
    SET flag = (
               NEW.death > NEW.birthday 
               OR NEW.death IS NULL
      );
   IF flag = 0 THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INSERT canceled, person has to birth before death';
   END IF;
END//

DELIMITER ;

DROP TRIGGER IF EXISTS check_death_before_birthday_on_update;
DELIMITER //
CREATE TRIGGER check_death_before_birthday_on_update BEFORE UPDATE ON persons
FOR EACH ROW BEGIN 
	DECLARE flag INT;
    SET flag = (
               NEW.death > NEW.birthday 
               OR NEW.death IS NULL
      );
   IF flag = 0 THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'UPDATE canceled, person has to birth before death';
   END IF;
END//

DELIMITER ;

-- рейтинг должен быть от 1 до 10
 
DROP TRIGGER IF EXISTS check_rating_size_on_insert;
DELIMITER //
CREATE TRIGGER check_rating_size_on_insert BEFORE INSERT ON films
FOR EACH ROW BEGIN 
	DECLARE flag INT;
    SET flag = (
               NEW.rating BETWEEN 1 AND 10
      );
   IF flag = 0 THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INSERT canceled, rating has to be between 1 and 10';
   END IF;
END//

DELIMITER ;



DROP TRIGGER IF EXISTS check_rating_size_on_update;
DELIMITER //
CREATE TRIGGER check_rating_size_on_update BEFORE UPDATE ON films
FOR EACH ROW BEGIN 
	DECLARE flag INT;
    SET flag = (
               NEW.rating BETWEEN 1 AND 10
      );
   IF flag = 0 THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'UPDATE canceled, rating has to be between 1 and 10';
   END IF;
END//

DELIMITER ;




