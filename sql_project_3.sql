--Задание 6. С помощью explain analyze проведите анализ стоимости выполнения запросов из предыдущих заданий и ответьте на вопросы:
--С каким оператором или функцией языка SQL, используемыми при выполнении домашнего задания, поиск значения в массиве затрачивает меньше ресурсов системы;
SELECT
	film_id,
	title AS "Название фильма",
	special_features AS "Столбец со специальными атрибутами"
FROM
	film
WHERE
	special_features @> ARRAY['Behind the Scenes']::text[];
--cost 67.50
--Какой вариант вычислений затрачивает меньше ресурсов системы: с использованием CTE или с использованием подзапроса.
---Они одинаково затрачивают ресурсов - 693.86
explain analyze
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
-- 693.86
	
explain analyze

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
-- 693.86
