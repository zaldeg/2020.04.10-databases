1)
SELECT 
  users.name, COUNT(orders.user_id) purchases
FROM 
  users
JOIN
  orders
ON 
  users.id = orders.user_id
GROUP BY users.name
ORDER BY purchases DESC;
``````````````````````````````````````````````````````````

2)
SELECT products.name prod_name, catalogs.name catalog_name 
FROM
  products
JOIN
  catalogs 
ON 
  products.catalog_id = catalogs.id;
````````````````````````````````````````````````````````````

3)

-- вроде создавать такие имена столбцов не принято, делаю это только из-за формулировки домашнего задания =).
DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `from` VARCHAR(255) NOT NULL,
  `to` VARCHAR(255) NOT NULL
);


INSERT INTO flights(`from`, `to`) VALUES
('moscow', 'omsk'),
('novgorod', 'kazan'),
('irkutsk', 'moscow'),
('omsk', 'irkutsk'),
('moscow', 'kazan');



DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
  lable VARCHAR(255),
  name VARCHAR(255)
);

INSERT INTO cities(lable, name) VALUES 
('moscow', 'Москва'),
('kazan', 'Казань'),
('omsk', 'Омск'),
('irkutsk', 'Иркутск'),
('novgorod', 'Новгород');



SELECT f.id, f.name AS `from`, t.name AS `to`
FROM
  (SELECT 
     flights.id, cities.name
  FROM 
    flights
  JOIN
    cities
  ON 
    flights.`from` = cities.lable
  ORDER BY flights.id) as f
JOIN
  (SELECT 
    flights.id, cities.name
  FROM 
    flights
  JOIN
    cities
  ON 
    flights.`to` = cities.lable
  ORDER BY flights.id) as t
ON 
  f.id = t.id
ORDER BY 
  f.id;