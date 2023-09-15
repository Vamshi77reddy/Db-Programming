create database SubQueries
use  subqueries
create table customers(
customer_id int identity primary key,
first_name varchar(100) not null,
last_name varchar(100) not null,
age int,
country varchar(100)
)

insert into customers values ('John','Doe',31,'USA'),
('Robert','Luna',22,'USA'),
('David','Robinson',22,'UK'),
('John','Reinhardt',25,'UK'),
('Betty','Doe',28,'UAE')


create table orders(
order_id integer identity primary key,
item varchar(100),
amount integer,
customer_id integer
foreign key (customer_id) references customers(customer_id)
)

insert  into orders values ('Keyboard',400,4),
('Mouse',300,4),
('Monitor',12000,3),
('Keyboard',400,1),
('Mousepad',250,2)

select * from customers
select * from orders


SELECT first_name
FROM Customers
WHERE age= (
SELECT MAX(age)
FROM CUSTOMERS
);


SELECT *
FROM Customers
WHERE customer_id= (
SELECT MAX(customer_id)
FROM CUSTOMERS
);


SELECT *
FROM Customers
WHERE age= (
SELECT min(age)
FROM CUSTOMERS
);

select customer_id,first_name
from customers
where customer_id in(
select customer_id from orders
)


----multi-row querue------
select * from customers where country in (select country from customers where first_name='robert' )
select * from customers where age in (select age from customers where age=22)


---CTE - common table expression ---

with cte1 as (select first_name,country from customers)
select * from cte1

with customerinusa as (
select * from customers where country='usa'
)
select * from customerinusa

select * from customers

WITH CustomerAges AS (
    SELECT age
    FROM customers
)
-- Query to calculate the average age of customers
SELECT AVG(age) AS AverageAge
FROM CustomerAges;




