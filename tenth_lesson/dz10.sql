USE vk;
-- DZ lesson # 10

-- 1)1. Проанализировать какие запросы могут выполняться наиболее часто в процессе 
-- работы приложения и добавить необходимые индексы.

CREATE INDEX users_email_idx ON users(email);
CREATE INDEX media_filename_idx ON media(filename);
CREATE INDEX profiles_birthday_idx ON profiles(birthday);
CREATE INDEX media_user_id_filename_idx ON media(user_id, filename);
CREATE INDEX posts_community_user_id_idx ON posts(community, user_id);
CREATE INDEX messages_community_id_from_user_id_idx ON messages(community_id, from_user_id);
CREATE INDEX messages_from_user_to_user_id_idx ON messages(from_user_id, to_user_id);
CREATE INDEX likes_user_id_idx ON likes(user_id);
CREATE INDEX posts_user_id_idx ON posts(user_id);

-- 2)2. Задание на оконные функции
-- Построить запрос, который будет выводить следующие столбцы:
-- имя группы
-- среднее количество пользователей в группах
-- самый молодой пользователь в группе
-- самый старший пользователь в группе
-- общее количество пользователей в группе
-- всего пользователей в системе
-- отношение в процентах (общее количество пользователей в группе / всего пользователей в системе) * 100



-- Хотел навчале объединить правым джойном юзеров что бы были все юзеры в таблице которых даже нету в комсьюнити, что бы посчитать их для total_users,
-- но потом выяснил, что не работает DISTINCT и пришлось искать все тотал величины с помощью вложеных запросов.

SELECT distinct communities.name,       
	   COUNT(communities.name) OVER() / (SELECT COUNT(*) from communities) AS avg,
	   MIN(profiles.birthday) OVER w AS youngest,
	   max(profiles.birthday) OVER w AS oldest,
	   COUNT(communities.name) OVER w AS total_in_group,
	   (SELECT count(*) FROM users) as total_users,
	   COUNT(communities.name) OVER w / (SELECT count(*) FROM users) * 100 as '%%'
  FROM communities
  	   LEFT JOIN communities_users 
  	   ON communities.id = communities_users.community_id
  	   LEFT JOIN users
  	   ON communities_users.user_id = users.id
  	   LEFT JOIN profiles
  	   ON users.id = profiles.user_id
  	   WINDOW w AS (PARTITION BY communities.name);
 WHERE communities.id IS NOT NULL;