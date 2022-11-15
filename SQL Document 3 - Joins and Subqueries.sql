-- 1. List all customers who live in Texas (use JOINS)
-- 5
SELECT *
FROM customer 
FULL JOIN address 
ON customer.address_id = address.address_id 
WHERE district = 'Texas';

-- 2. Get all payments above $6.99 with the Customer's Full Name
-- 1423
SELECT customer.first_name, customer.last_name 
FROM customer 
FULL JOIN payment 
ON customer.customer_id = payment.customer_id 
WHERE amount > 6.99

-- How to verify the count 
SELECT COUNT(payment.customer_id)
FROM customer 
FULL JOIN payment 
ON customer.customer_id = payment.customer_id 
WHERE amount > 6.99;

-- 3. Show all customers names who have made payments over $175(use subqueries)
-- 7 customers
SELECT store_id, first_name, last_name
FROM customer 
WHERE customer_id IN (
	SELECT customer_id 
	FROM payment 
	GROUP BY customer_id 
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount) DESC 
)
GROUP BY store_id, first_name, last_name; 


-- 4. List all customers that live in Nepal (use the city table)
-- 1 customer Kevin Schuler
SELECT store_id, first_name, last_name, address, country
FROM customer 
INNER JOIN address 
ON customer.address_id = address.address_id 
INNER JOIN city 
ON address.city_id = city.city_id 
INNER JOIN country 
ON city.country_id = country.country_id 
WHERE country = 'Nepal'; 

-- 5. Which staff member had the most transactions?
-- Jon Stephens
SELECT staff.first_name, staff.last_name, COUNT(payment.payment_id)
FROM staff 
FULL JOIN payment 
ON staff.staff_id = payment.staff_id 
GROUP BY staff.staff_id; 

-- 6. How many movies of each rating are there?
-- 195 R, 209 NC-17, 178 G, 223 PG-13, 194 PG
SELECT COUNT(film_id), rating
FROM film 
GROUP BY rating; 

-- 7.Show all customers who have made a single payment above $6.99 (Use Subqueries)
-- 130 customers 
SELECT customer.customer_id, last_name, first_name
FROM customer 
FULL JOIN payment 
ON customer.customer_id = payment.customer_id
WHERE payment.amount IN(
	SELECT payment.amount 
	FROM payment
	WHERE amount > 6.99 
	GROUP BY amount 
)
GROUP BY customer.customer_id 
HAVING COUNT(amount) =1;

-- 8. How many free rentals did our stores give away?
-- 24
SELECT COUNT(rental_id)
FROM payment
WHERE amount = 0;