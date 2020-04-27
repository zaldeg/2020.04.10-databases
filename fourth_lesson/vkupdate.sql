USE vk;

SHOW TABLES;

SELECT * FROM users LIMIT 10;

SELECT @@VERSION;
SELECT VERSION();

SELECT * FROM users LIMIT 10;

UPDATE users SET updated_at = CURRENT_TIMESTAMP WHERE created_at > updated_at; 

DESC profiles;

SELECT * FROM profiles LiMIT 10;

SELECT * FROM messages LIMIT 10;

SELECT COUNT(*) FROM messages;

DESCRIBE profiles ;

ALTER TABLE profiles DROP COLUMN photo_id;

ALter TABLE profiles ADD COlUMN photo_id INT UNSIGNED AFTER country;

SELECT * FROM messages LIMIT 10;

SELECT RAND();

SELECT FLOOR(1 + RAND() * 200);

UPDATE messages SET
  from_users_id = FLOOR(1 + RAND() * 100),
  to_user_id = FLOOR(1 + RAND() * 100);

 
DESC media;
ALTER TABLE media DROP COLUMN filename;
ALTER TABLE media ADD COLUMN filename VARCHAR(255) NOT NULL AFTER user_id;

SELECT * FROM media LIMIT 10;
SELECT * FROM media_types LIMIT 10;

DELETE FROM media_types;

TRUNCATE media_types;

INSERT INTO media_types (name) VALUES
  ('photos'),
  ('video'),
  ('audio');

 
 
 SELECT * FROM media LIMIT 10;
 
UPDATE media SET
  media_type_id = FLOOR(1 + RAND() * 3)
  
UPDATE media SET
  user_id = FLOOR(1 + RAND() * 100); 
  
SELECT COUNT(*) FROM media;

UPDATE media SET filename = CONCAT('https:// dropbox.com/vk/', filename)

SELECT * FROM messages WHERE from_users_id = to_user_id;

ALTER TABLE messages CHANGE COLUMN from_users_id  from_user_id INT UNSIGNED NOT NULL;

SELECT * FROM messages LIMIT 10;

CREATE TEMPORARY TABLE exts (name VARCHAR(10));

INSERT INTO exts VALUES ('gif'), ('avi'), ('jpeg');

SELECT * FROM exts;

SELECT * FROM exts ORDER BY RAND() LIMIT 1;

UPDATE media SET filename =
  CONCAT(
  'https://dropbox.com/vk/',
  FLOOR(10000 + RAND() * 20000),
  '.',
  (SELECT name FROM exts ORDER BY RAND() LIMIT 1));
 
  SELECT * FROM media LIMIT 10;

ALTER TABLE `media` CHANGE COLUMN `size`  `file_size` INT UNSIGNED NOT NULL;

UPDATE media SET file_size = FLOOR(10000 + RAND() * 1000000) WHERE file_size < 1000;

UPDATE media SET metadata = CONCAT('{"owner":"',
  (SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = user_id),
  '"}');

DESC TABLE media MODIFY COLUMN metadata JSON
 
SELECT * FROM friendship  LIMIT 10;

SELECT COUNT(*) FROM friendship;

SELECT * FROM friendship_statuses;

TRUNCATE friendship_statuses;

INSERT INTO friendship_statuses (name) VALUES
  ('Requested'),
  ('Confirmed'),
  ('Rejected');
 
UPDATE friendship SET
  status_id = FLOOR(1 + rand() * 3);
 
SELECT * FROM communities;


DELETE FROM communities WHERE id > 20;

SELECT * FROM communities_users;

UPDATE communities_users SET
   community_id = FLOOR(1 + RAND() * 20) WHERE community_id > 20;
  
SELECT COUNT(*) FROM communities_users;
TRUNCATE communities_users;

ALTER TABLE messages change COLUMN communite_id community_id INT UNSIGNED;
DESCRIBE messages;

ALTER TABLE messages MODIFY COLUMN to_user_id INT UNSIGNED;


   

 
