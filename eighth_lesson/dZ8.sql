1)вроде нужен left join для молодого пользователя без лайков.


SELECT CONCAT(users.first_name,' ',  users.last_name) AS name,
       profiles.birthday, COUNT(likes.target_id) AS total_likes
  FROM users
       LEFT JOIN profiles
       ON users.id = profiles.user_id
       LEFT JOIN likes
       ON likes.target_id = users.id
          AND target_type_id = 2
 GROUP BY users.id
 ORDER BY birthday DESC
 LIMIT 10;

2)

SELECT CASE profiles.gender
            WHEN 'f' THEN 'Female'
            WHEN 'm' THEN 'Male'
       END AS gender,
       COUNT(likes.id) AS total_likes
  FROM users
       JOIN profiles
       ON users.id = profiles.user_id 
       JOIN likes 
       ON likes.user_id = users.id
 GROUP BY gender
 ORDER BY total_likes DESC
 LIMIT 1;

3) Наименьшая активность.
   сумма лайков, постов и сообщений.

SELECT DISTINCT CONCAT(users.first_name, ' ', users.last_name),
       COUNT(DISTINCT likes.id) + COUNT(DISTINCT posts.id) + COUNT(DISTINCT messages.id) AS activity
  FROM users
       LEFT JOIN likes 
       ON users.id = likes.user_id 
       INNER JOIN posts 
       ON users.id = posts.user_id 
       INNER JOIN messages 
       ON users.id = messages.from_user_id 
 GROUP BY users.id 
 ORDER BY activity 
 LIMIT 10;

