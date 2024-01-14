-- QUESTION 1:RANK THE CUSTOMERS BASED ON THE TOTAL AMOUNT THEY'VE SPENT ON RENTALS
select * from rental;
select * from payment;
select customer_id, sum(amount) AS total_amount, rank() over(order by sum(amount) desc) as rank_of_customer from payment 
group by customer_id;

-- output with CTE query
WITH CUSTOMER_RANKING AS (
select customer_id , sum(amount) AS total_amount, rank() over(order by sum(amount) desc) as Rank_of_customer from payment
group by customer_id)
select customer_id, total_amount, rank_of_customer from customer_ranking;

-- QUESTION 2:calculate the cumulative revenue generated by each film over time.
select f.film_id, f.title, p.payment_date, sum(p.amount) over(partition by f.film_id order by p.payment_date) AS cumulative_revenue
from payment p inner join rental r on p.rental_id=r.rental_id inner join inventory i on r.inventory_id=i.inventory_id
inner join film f on i.film_id=f.film_id order by f.film_id;

-- QUESTION 3:Determine the average rental duration for each film, considering films with similar lengths.
select film_id, title, rental_duration, avg(rental_duration) over(partition by length) AS AVG_RENTAL_DURATION from film;

-- QUESTION 4:Identify the top 3 films in each category based on their rental counts.
with topranking as (
select fc.category_id, fc.film_id, f.title, count(r.rental_id), row_number() over(partition by fc.category_id order by count(r.rental_id) desc) as ranks 
from film_category fc join rental r on fc.film_id=r.inventory_id
join film f on f.film_id=fc.film_id
group by fc.category_id, fc.film_id, f.title
)
select category_id, film_id, title, ranks from topranking 
where ranks <= 3;

-- QUESTION 5:Calculate the difference in rental counts between each customer's total rentals and the average rentals
-- across all customers.
with customerrentaldiff AS (
select customer_id, count(rental_id) as total_rentals, avg(count(rental_id)) over() as avg_rentals,
count(rental_id) - avg(count(rental_id)) over() as rental_difference from rental group by customer_id)
select customer_id, total_rentals, avg_rentals, rental_difference from customerrentaldiff;

-- QUESTION 6:Find the monthly revenue trend for the entire rental store over time.
with monthlyrevenue AS (
select date_format(payment_date, '%y-%m') AS month, sum(amount) AS total_revenue from payment
 group by date_format(payment_date, '%y-%m')
 )
select month, total_revenue, sum(total_revenue) over(order by month) as monthlytrend from monthlyrevenue;

-- QUESTION 7:Identify the customers whose total spending on rentals falls within the top 20% of all customers.
WITH customerRevenue AS (
select customer_id, sum(amount) as total_spending, rank() over(order by sum(amount) desc)
 as customer_rank from payment group by customer_id)
select customer_id, total_spending, customer_rank from customerRevenue
where customer_rank<=(select 0.2* count(customer_id) + 1 from customerRevenue);

-- QUESTION 8:Calculate the running total of rentals per category, ordered by rental count.
WITH TotalRentalCategory AS (
select fc.category_id, count(r.rental_id) AS rental_count, rank() over(partition by fc.category_id order by count(r.rental_id) DESC) 
as rental_rank from film_category fc JOIN Rental r on fc.film_id=r.inventory_id group by fc.category_id)
select trc.category_id, trc.rental_count, sum(trc.rental_count) over(order by trc.rental_rank) AS running_total from totalrentalcategory trc order by trc.category_id;

-- QUESTION 9: Find the films that have been rented less than the average rental count for their respective categories.  
WITH RentedFilms AS (
select fc.film_id, fc.category_id, count(r.rental_id) AS rental_count, AVG(count(r.rental_id))  over(partition by fc.category_id) as avg_rental_count from film_category fc 
JOIN rental r on fc.film_id=r.inventory_id group by fc.film_id, fc.category_id)
select rf.film_id, rf.rental_count, rf.avg_rental_count  from rentedfilms rf 
where rf.rental_count < rf.avg_rental_count;

-- QUESTION 10: Identify the top 5 months with the highest revenue and display the revenue generated in each month.
-- ANS1
WITH MONTHREVENUE AS (
select month(payment_date) as month, sum(amount) as revenue, rank() over(partition by month(payment_date)) as ranking from payment group  by month(payment_date))
select month, revenue, ranking from monthrevenue
where ranking <=5 order by revenue desc;
-- ANS2 
WITH MONTHREVENUE AS (
    select DATE_FORMAT(payment_date, '%Y-%m') AS month, SUM(amount) AS total_revenue from payment GROUP BY DATE_FORMAT(payment_date, '%Y-%m')
)
SELECT month, total_revenue FROM MonthRevenue ORDER BY total_revenue DESC LIMIT 5; 
 