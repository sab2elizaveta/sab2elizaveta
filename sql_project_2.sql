--Для каждого покупателя посчитайте, сколько он брал в аренду фильмов со специальным атрибутом “Behind the Scenes”.
--Обязательное условие для выполнения задания: используйте запрос из задания 1, помещённый в CTE.
--В результирующей таблице должны быть следующие столбцы: Фамилия и имя пользователя в виде одного значения, количество арендованных фильмов.

WITH Behind_the_Scenes_cte AS (
SELECT
	film_id,
	title AS "Название фильма",
	special_features AS "Столбец со специальными атрибутами"
FROM
	film
WHERE
	special_features @> ARRAY['Behind the Scenes']::text[]

)
 
SELECT
	c.last_name || ' ' || c.first_name AS "Имя покупателя",
	count(b.film_id) AS "Количество арендованных фильмов"
FROM
	customer c
JOIN rental r ON
	c.customer_id = r.customer_id
JOIN inventory i ON
	i.inventory_id = r.inventory_id
JOIN Behind_the_Scenes_cte b ON
	b.film_id = i.film_id
GROUP BY
	c.customer_id;
--Задание 4. Для каждого покупателя посчитайте, сколько он брал в аренду фильмов со специальным атрибутом “Behind the Scenes”.
--Обязательное условие для выполнения задания: используйте запрос из задания 1, помещённый в подзапрос, который необходимо использовать для решения задания.
--В результирующей таблице должны быть следующие столбцы: Фамилия и имя пользователя в виде одного значения, количество арендованных фильмов.

SELECT
	c.last_name || ' ' || c.first_name AS "Имя покупателя",
	count(b.film_id) AS "Количество арендованных фильмов"
FROM
	customer c
JOIN rental r ON
	c.customer_id = r.customer_id
JOIN inventory i ON
	i.inventory_id = r.inventory_id
JOIN (
	SELECT
		film_id,
		title AS "Название фильма",
		special_features AS "Столбец со специальными атрибутами"
	FROM
		film
	WHERE
		special_features @> ARRAY['Behind the Scenes']::text[]

) AS b ON
	b.film_id = i.film_id
GROUP BY
	c.customer_id;
--Задание 5. Создайте материализованное представление с запросом из предыдущего задания и напишите запрос для обновления материализованного представления.
CREATE materialized VIEW Behind_the_Scenes_2 AS 
SELECT
		film_id,
		title AS "Название фильма",
		special_features AS "Столбец со специальными атрибутами"
FROM
		film
WHERE
		special_features @> ARRAY['Behind the Scenes']::text[];

REFRESH MATERIALIZED VIEW Behind_the_Scenes_2;
