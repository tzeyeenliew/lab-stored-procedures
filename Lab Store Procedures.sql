Use sakila;

#1. In the previous lab we wrote a query to find first name, last name, and emails of all the customers who rented Action movies. Convert the query into a simple stored procedure. Use the following query:

drop procedure if exists action_movies;

DELIMITER //
Create procedure action_movies()
BEGIN
  select first_name, last_name, email
  from customer
  join rental on customer.customer_id = rental.customer_id
  join inventory on rental.inventory_id = inventory.inventory_id
  join film on film.film_id = inventory.film_id
  join film_category on film_category.film_id = film.film_id
  join category on category.category_id = film_category.category_id
  where category.name = "Action"
  group by first_name, last_name, email;
END //
DELIMITER ;

CALL action_movies();

#2. Now keep working on the previous stored procedure to make it more dynamic. Update the stored procedure in a such manner that it can take a string argument for the category name and return the results for all customers that rented movie of that category/genre. For eg., it could be action, animation, children, classics, etc.

drop procedure if exists genre_movies;

DELIMITER //

Create procedure genre_movies(IN categoryName VARCHAR(50))
BEGIN
  select first_name, last_name, email
  from customer
  join rental on customer.customer_id = rental.customer_id
  join inventory on rental.inventory_id = inventory.inventory_id
  join film on film.film_id = inventory.film_id
  join film_category on film_category.film_id = film.film_id
  join category on category.category_id = film_category.category_id
  where category.name = categoryName
  group by first_name, last_name, email;
END //
DELIMITER ;

call genre_movies('children');

#3. Write a query to check the number of movies released in each movie category. Convert the query in to a stored procedure to filter only those categories that have movies released greater than a certain number. Pass that number as an argument in the stored procedure.

SELECT name, COUNT(*) as film_count #to get a feel of the types of film categories and their respective counts
FROM film_category AS fc
JOIN category AS C 
ON c.category_id= fc.category_id
GROUP BY c.name;


drop procedure if exists check_number;

DELIMITER //

Create procedure check_number(IN filmcount INT(4))
BEGIN
SELECT name as Category_Name, COUNT(*) as Film_Count
FROM film_category AS fc
JOIN category AS C 
ON c.category_id= fc.category_id
GROUP BY c.name
HAVING COUNT(*) > filmcount;
END //
DELIMITER ;

Call check_number(70);



