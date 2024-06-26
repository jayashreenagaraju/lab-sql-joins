use sakila;

-- 1. List the number of films per category.
select * from film_category;
select * from film;
select * from category;

select count(distinct f.film_id) as number_of_films,c.name
from film as f
join film_category as fc
on f.film_id = fc.film_id
join category as c
on c.category_id = fc.category_id
group by c.name 
order by number_of_films desc;

-- 2.Retrieve the store ID, city, and country for each store.
select * from store;
select * from address;
select * from city;
select * from country;

select s.store_id,c.city,co.country
from store as s
join address as a
on s.address_id = a.address_id
join city as c
on c.city_id = a.city_id
join country as co
on co.country_id =c.country_id;

-- 3. Calculate the total revenue generated by each store in dollars.
select * from store;
select * from  staff;
select * from payment;

select s.store_id,sum(p.amount) as total_revenue
from store as s
join staff as st 
on s.store_id = st.store_id
join payment as p
on p.staff_id = st.staff_id
group by s.store_id;

-- 4. Determine the average running time of films for each category.
select * from film;
select * from film_category;
select * from category;

select c.name, round(avg(f.length),2)as average_running_time 
from film as f
join film_category as fc
on f.film_id = fc.film_id
join category as c
on c.category_id = fc.category_id
group by c.name;


-- Bonus
-- 5.Identify the film categories with the longest average running time.
select c.name, avg(f.length) as average_running_time from film as f
join film_category as fc
on f.film_id = fc.film_id
join category as c
on c.category_id = fc.category_id
group by c.name
order by average_running_time desc;



-- 6. Display the top 10 most frequently rented movies in descending order.
select * from rental;
select * from inventory;
select * from film;

select f.title,count(distinct r.rental_id) as rentals_num
from rental as r
join inventory as i
on r.inventory_id = i.inventory_id
join film as f
on f.film_id =i.film_id
group by f.title
order by rentals_num desc
limit 10;

-- 7.Determine if "Academy Dinosaur" can be rented from Store 1.
select * from rental;
select * from inventory;
select * from film;

select * 
from  rental as r
join inventory as i
on r.inventory_id = i.inventory_id
join film as f
on f.film_id =i.film_id
where f.title = 'Academy Dinosaur' and i.store_id =1;

-- 8. Provide a list of all distinct film titles, along with their availability status in the inventory. Include a column indicating whether each title is 'Available' or 'NOT available.' Note that there are 42 titles that are not in the inventory, and this information can be obtained using a CASE statement combined with IFNULL."
SELECT distinct f.title,
       CASE 
           WHEN IFNULL(i.inventory_id, 0) = 0 THEN 'NOT available'
           ELSE 'Available'
       END AS availability_status
FROM film AS f
LEFT JOIN inventory AS i 
ON f.film_id = i.film_id;



