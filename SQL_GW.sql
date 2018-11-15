SET SQL_SAFE_UPDATES = 0;
USE sakila;

SELECT first_name, last_name FROM actor;

UPDATE actor 
	SET actor_name = CONCAT(first_name, '  ', last_name); 

SELECT actor_name FROM actor;

SELECT actor_id, first_name, last_name FROM actor
	WHERE first_name = 'Joe';
    
SELECT actor_id, first_name, last_name FROM actor
	WHERE last_name LIKE '%GEN%'; 
    
SELECT last_name, first_name FROM actor
	WHERE last_name LIKE '%LI%';
    
SELECT country_id, country FROM country
	WHERE country IN ('Afghanistan', 'Bangladesh', 'China');
    
ALTER TABLE actor
	ADD COLUMN Description BLOB;

ALTER TABLE actor
	DROP COLUMN Description; 

SELECT last_name, COUNT(last_name) FROM actor
    GROUP BY last_name;
    
SELECT last_name, COUNT(last_name) FROM actor
    GROUP BY last_name
    HAVING COUNT(last_name) >= 2;  

UPDATE actor 
	SET first_name = 'HARPO'
	WHERE first_name = 'GROUCHO' AND last_name = 'WILLIAMS'; 

UPDATE actor
	SET first_name = 'GROUCHO'
	WHERE first_name = 'HARPO'; 

SHOW CREATE TABLE address;

SELECT s.first_name, s.last_name, a.address FROM staff s
	JOIN address a
	ON s.address_id = a.address_id; 
    
SELECT s.first_name, s.last_name, SUM(p.amount) AS 'Total Amount'
FROM staff s 
	JOIN payment p 
	ON s.staff_id = p.staff_id
    WHERE p.payment_date >= '2005-08-01 00:00:00' AND p.payment_date <= '2005-08-31 23:59:59'
    GROUP BY s.first_name, s.last_name;

SELECT f.title, COUNT(a.actor_id) AS 'Total Actors'
FROM film f
	INNER JOIN film_actor a
    ON f.film_id = a.film_id
    GROUP BY f.title;
    
SELECT f.title, COUNT(i.film_id) AS 'Total Copies'
FROM film f
	JOIN inventory i
    ON f.film_id = i.film_id
    WHERE f.title = 'Hunchback Impossible'
    GROUP BY f.title;
 
SELECT c.first_name, c.last_name, SUM(p.amount) AS 'Total Amount Paid'
FROM customer c
	JOIN payment p 
	ON c.customer_id = p.customer_id
    GROUP BY c.first_name, c.last_name
    ORDER BY c.last_name;

SELECT title, language_id FROM film
WHERE SUBSTR(title, 1, 1) = 'K' OR SUBSTR(title, 1, 1) = 'Q' AND language_id IN 
(
	SELECT language_id FROM language
    WHERE name IN
	(
		SELECT name FROM language
        WHERE name = 'English'
    )
);

-- 7
SELECT first_name, last_name FROM actor
WHERE actor_id IN
(
	SELECT actor_id FROM film_actor
	WHERE film_id IN
	(	
		SELECT film_id FROM film
		WHERE title = 'Alone Trip'
	)
);

SELECT c.first_name, c.last_name, c.email FROM customer c
	INNER JOIN address a
    ON c.address_id = a.address_id
    INNER JOIN city ct
    ON a.city_id = ct.city_id
    INNER JOIN country ctr
    ON ct.country_id = ctr.country_id
    WHERE country = 'Canada';
    

SELECT f.title FROM film f
	INNER JOIN film_category fc
    ON f.film_id = fc.film_id
    INNER JOIN category c
    ON fc.category_id = c.category_id
    WHERE c.name = 'Family';

SELECT f.title, COUNT(f.title) AS 'Number of Times Rented' FROM film f
	INNER JOIN inventory i
    ON f.film_id = i.film_id
    INNER JOIN rental r
    ON i.inventory_id = r.inventory_id
    GROUP BY f.title
    ORDER BY COUNT(f.title) DESC;

SELECT s.store_id, SUM(p.amount) AS 'Total Revenue' FROM staff s 
	INNER JOIN payment p
	ON s.staff_id = p.staff_id
	GROUP BY s.store_id;