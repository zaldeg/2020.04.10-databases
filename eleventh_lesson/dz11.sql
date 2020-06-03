USE shop;

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
       id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
       table_name_id INT UNSIGNED NOT NULL,
       id_in_table INT UNSIGNED NOT NULL,
       name VARCHAR(255),
       created_at TIMESTAMP default CURRENT_TIMESTAMP()
) ENGINE = ARCHIVE;
      
-- что бы небыло повторений названий таблиц создал таблицу с их именами. теперь результаты можно будет легко упорядочить по типу таблицы.

DROP TABLE IF EXISTS table_names;
CREATE TABLE table_names (
       id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
       name VARCHAR(255)
);

INSERT INTO table_names(name) VALUES ('users'), ('products'), ('catalogs');


DROP TRIGGER  IF EXISTS add_to_logs_new_user;
DELIMITER //

CREATE TRIGGER add_to_logs_new_user AFTER INSERT ON users
FOR EACH ROW
BEGIN
      INSERT INTO logs (table_name_id, id_in_table, name) VALUES (
      (SELECT id FROM table_names WHERE name = 'users'),
      NEW.id,
      NEW.name
      );
END//

DELIMITER ;

DROP TRIGGER  IF EXISTS add_to_logs_new_product;
DELIMITER //

CREATE TRIGGER add_to_logs_new_product AFTER INSERT ON products
FOR EACH ROW
BEGIN
      INSERT INTO logs (table_name_id, id_in_table, name) VALUES (
      (SELECT id FROM table_names WHERE name = 'products'),
      NEW.id,
      NEW.name
      );
END//

DELIMITER ;

DROP TRIGGER  IF EXISTS add_to_logs_new_catalog;
DELIMITER //

CREATE TRIGGER add_to_logs_new_catalog AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
      INSERT INTO logs (table_name_id, id_in_table, name) VALUES (
      (SELECT id FROM table_names WHERE name = 'catalogs'),
      NEW.id,
      NEW.name
      );
END//

DELIMITER ;

