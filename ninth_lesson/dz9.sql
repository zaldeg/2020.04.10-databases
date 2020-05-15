
-- Практическое задание по теме “Транзакции, переменные, представления”
-- 1)В базе данных shop и sample присутствуют одни и те же таблицы, учебной 
--  базы данных. Переместите запись id = 1 из таблицы shop.users в таблицу 
--  sample.users. Используйте транзакции.

START TRANSACTION;
INSERT sample.users(name, birthday_at, created_at, updated_at)
SELECT name, birthday_at, created_at, updated_at 
  FROM shop.users 
 WHERE shop.users.id = 1;
COMMIT;

-- 2) Создайте представление, которое выводит название name товарной позиции 
--   из таблицы products и соответствующее название каталога name из таблицы catalogs.

CREATE VIEW something as
       SELECT products.name as prod_name,
              catalogs.name as cat_name
         FROM products
              INNER JOIN catalogs
              ON products.catalog_id = catalogs.id;
             
             
-- Практическое задание по теме “Хранимые процедуры и функции, триггеры"
-- 1)Создайте хранимую функцию hello(), которая будет возвращать приветствие,
--   в зависимости от текущего времени суток. С 6:00 до 12:00 функция должна 
--   возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать
--   фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — 
--   "Доброй ночи".
DROP FUNCTION IF EXISTS hello;
DELIMITER //
CREATE FUNCTION hello ()
RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
	DECLARE greeting text;
	IF (HOUR(NOW()) BETWEEN 6 AND 11) THEN SET greeting = 'Доброе утро';
	ELSEIF (HOUR(NOW()) BETWEEN 12 AND 17) THEN SET greeting = 'Добрвый день';
	ELSEIF (HOUR(NOW()) BETWEEN 18 AND 23) THEN SET greeting = 'Добрый вечер';
	ELSE SET greeting = 'Доброй ночи';
    END IF;
    RETURN greeting;
END//
DELIMITER ;

-- 2)
-- В таблице products есть два текстовых поля: name с названием товара и description 
-- с его описанием. Допустимо присутствие обоих полей или одно из них. Ситуация, когда 
-- оба поля принимают неопределенное значение NULL неприемлема. Используя триггеры, 
-- добейтесь того, чтобы одно из этих полей или оба поля были заполнены. При попытке 
-- присвоить полям NULL-значение необходимо отменить операцию

-- один триггер на изменение:
DELIMITER //
CREATE TRIGGER check_not_null_product_update BEFORE UPDATE ON products
FOR EACH ROW BEGIN
  DECLARE flag INT; 
  SET flag = (
               NEW.description IS NOT NULL 
               OR NEW.name IS NOT NULL
      );
   IF flag = 0 THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'UPDATE canceled';
   END IF;
END//

DELIMITER ;

-- один триггер на добавление:
DELIMITER //
CREATE TRIGGER check_not_null_product_insert BEFORE INSERT ON products
FOR EACH ROW BEGIN
  DECLARE flag INT; 
  SET flag = (
               NEW.description IS NOT NULL 
               OR NEW.name IS NOT NULL
      );
   IF flag = 0 THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INSERT canceled';
   END IF;
END//

DELIMITER ;



              
