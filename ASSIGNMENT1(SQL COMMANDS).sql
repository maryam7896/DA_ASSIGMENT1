use mavenmovies;
-- Question 1 :Identify the primary keys and foreign keys in mavenmovies db.Discuss the differences?
-- PRIMARY KEY: primary key identifies and focuses a column in a table to be unique ,not null.
-- a table have only one primary key
-- FOREIGN KEY: foreign key is used to build relationship betweeen two tables, by referencing the primary key of another table
-- A foreign can contain null values, a table can have more than one foreign key.
-- LIST ALL DETAILS OF ACTORS
show tables;
describe actor;
-- actor_id is a primary key and last_name is a foreign key.
describe actor_award;
-- actor_award_id is a primary key and last_name is a foreign key.
describe address;
-- address_id is a primary key and city_id is a foreign key.
describe advisor;
-- advisor_id is a primary key.
describe category;
-- category_id is a primary key.
describe city;
-- city_id is a primary key and country_id is a foreign key.
describe country;
-- country_id is a primary key.
describe customer;
-- customer_id is a primary key and store_id , last_name are foreign keys.
describe film;
-- film_id is a primary key and title , language_id , original_language_id are foreign keys.
describe film_actor;
-- actor_id and film_id are primary keys.
describe film_category;
-- film_id and category_id are primary keys.
describe film_text;
-- film_id is a primary key and title is foreign key.
describe inventory;
-- inventory_id is a primary key and film_id , store_id are foreign keys.
describe investor;
-- investor_id is a primary key.
describe language;
-- language_id is a primary key.
describe payment;
-- payment_id is a primary key and customer_id, staff_id, rental_id are foreign keys.
describe rental;
-- rental_id is a primary key and rental_date, inventory_id, customer_id, staff_id are foreign keys.
describe staff;
-- staff_id is a primary key and address_id, store_id are foreign keys.
describe store;
-- store_id is a primary key and address_id is a foreign key.

-- QUESTION 2:List all details of actors.
select * from actor;

-- QUESTION 3:List all customer information from db.
select * from customer;

-- QUESTION 4:list different countries.
SELECT DISTINCT COUNTRY  FROM COUNTRY;

-- QUESTION 5:Display all active customers.
SELECT * FROM CUSTOMER WHERE ACTIVE = 1;

-- QUESTION 6:list all rental IDs for customer with ID 1.
SELECT CUSTOMER_ID , RENTAL_ID FROM RENTAL WHERE CUSTOMER_ID = 1;

-- QUESTION 7:Display all the films whose rental duration is greater than 5.
SELECT FILM_ID , TITLE , RENTAL_DURATION FROM FILM WHERE RENTAL_DURATION > 5;

-- QUESTION 8:list the total number of films whose replacement cost is greater than $15 and less than $20.
SELECT COUNT(*) AS TOTAL_NUMBER_OF_FILMS FROM FILM WHERE REPLACEMENT_COST BETWEEN 15 AND 20;

-- QUESTION 9:Find the number of films whose rental rate is less than $1.
SELECT COUNT(*) AS NO_OF_FILMS FROM FILM WHERE RENTAL_RATE < 1;
SELECT COUNT(TITLE) FROM FILM WHERE RENTAL_RATE < 1;

-- QUESTION 10:display the count of unique first names of actors.
SELECT COUNT(DISTINCT FIRST_NAME) AS UNIQUE_FIRST_NAME FROM ACTOR;

-- QUESTION 11:Display the first 10 records from the customer table.
SELECT * FROM CUSTOMER LIMIT 10;

-- QUESTION 12:Display the first 3 records from the customer table whose first name starts with a.
SELECT FIRST_NAME FROM CUSTOMER WHERE FIRST_NAME LIKE "B%" LIMIT 3;

-- QUESTION 13:Display the names of first 5 movies which are rated as G.
SELECT TITLE , RATING FROM FILM WHERE RATING = 'G' LIMIT 5;

-- QUESTION 14:Find all the customers whose first names starts with a.
SELECT FIRST_NAME FROM CUSTOMER WHERE FIRST_NAME LIKE "A%";

-- QUESTION 15:Find all the customers whose first names ends with a.
SELECT FIRST_NAME FROM CUSTOMER WHERE FIRST_NAME LIKE "%A";

-- QUESTION 16:dispaly the list of first 4 cities which starts and ends with a.
SELECT CITY FROM CITY WHERE CITY LIKE "A%A" LIMIT 4;

-- QUESTION 17:find all the customers whose first name have NI in any position.
SELECT FIRST_NAME FROM CUSTOMER WHERE FIRST_NAME LIKE "%NI%";

-- QUESTION 18:find all the customers whose first name have R in the second position.
SELECT FIRST_NAME FROM CUSTOMER WHERE FIRST_NAME LIKE "_R%";

-- QUESTION 19:find all customers whose first name starts with A and are atleast 5 characters in length.
SELECT FIRST_NAME FROM CUSTOMER WHERE FIRST_NAME LIKE "A%" AND LENGTH(FIRST_NAME)>=5;

-- QUESTION 20:find all customers whose first name starts with a and ends with o.
SELECT FIRST_NAME FROM CUSTOMER WHERE FIRST_NAME LIKE "A%0";

-- QUESTION 21:get the films with pg and pg-13 rating using IN operator.
SELECT TITLE , RATING FROM FILM WHERE RATING IN  ( 'PG' , 'PG-13' );

-- QUESTION 22:get the films with length between 50 & 100 using between operator.
SELECT TITLE , LENGTH FROM FILM WHERE LENGTH BETWEEN 50 AND 100;

-- QUESTION 23:get the top 50 actors using limit operator.
SELECT * FROM ACTOR ORDER BY ACTOR_ID DESC LIMIT 50;

-- QUESTION 24:get the distinct film IDs from inventory table.
SELECT DISTINCT FILM_ID FROM INVENTORY;













