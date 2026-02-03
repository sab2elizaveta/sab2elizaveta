--Напишите SQL-запрос, который выводит всю информацию о фильмах со специальным атрибутом “Behind the Scenes”.
--В результирующей таблице должны быть следующие столбцы: Название фильма, столбец со специальными атрибутами.
SELECT
	film_id,
	title AS "Название фильма",
	special_features AS "Столбец со специальными атрибутами"
FROM
	film
WHERE
	special_features @> ARRAY['Behind the Scenes']::text[];
--Напишите ещё 2 варианта поиска фильмов с атрибутом “Behind the Scenes”, используя другие функции или операторы языка SQL для поиска значения в массиве.
--В результирующей таблице должны быть следующие столбцы: Название фильма, столбец со специальными атрибутами.
---Вариант 1

SELECT
	film_id,
	title AS "Название фильма",
	special_features AS "Столбец со специальными атрибутами"
FROM
	film
WHERE
	'Behind the Scenes' = ANY(special_features);
---Вариант 2
SELECT
	film_id,
	title AS "Название фильма",
	special_features AS "Столбец со специальными атрибутами"
FROM
	film
WHERE
	EXISTS (
	SELECT
		1
	FROM
		UNNEST(special_features) AS sp
	WHERE
		sp = 'Behind the Scenes'
    );
