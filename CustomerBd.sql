CREATE DATABASE CustomerDb;

-- created database
USE CustomerDb;

-- Create a table
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    username NVARCHAR(50) NOT NULL,
    email NVARCHAR(100) NOT NULL UNIQUE,
    password NVARCHAR(255) NOT NULL,
	-- check constraint for age
    age INT CHECK (age >= 18), 
    registration_date DATE DEFAULT GETDATE()
);

alter table users 
alter column user_id int IDENTITY(1,1) primary key,
-- Create an 'orders' table with a foreign key reference to 'users'
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    user_id INT,
    order_total DECIMAL(10, 2) CHECK (order_total > 0),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

select * from users
select * from orders

INSERT INTO users (user_id, username, email, password, age)
VALUES
    (2, 'jacob', 'jacob@example.com', 'jacob_password', 25),
    (3, 'Alex', 'alex@example.com', 'alex_password', 30),
    (4, 'Sai', 'sai@example.com', 'sai_password', 23),
    (5, 'Teja', 'tej@example.com', 'Teja_password', 22),
    (6, 'rahul', 'rahul@example.com', 'Rahul_password', 31),
    (7, 'Rohith', 'rohith@example.com', 'rohith_password', 35),
    (8, 'Deelip', 'deelip@example.com', 'deelip_password', 25),
    (9, 'Deepak', 'deepak@example.com', 'deepak_password', 27),
    (10, 'Sheik', 'sheik@example.com', 'sheik_password', 29),
    (11, 'Azar', 'azar@example.com', 'azar_password', 32),
	(12, 'Karan', 'Karan@example.com', 'karan_password', 21),
    (13, 'Sandeep', 'sandeep@example.com', 'sandeep_password', 20)



-- Insert values into the 'orders' table
INSERT INTO orders (order_id, user_id, order_total)
VALUES
    (104, 3, 150.00),
    (105, 4, 175.25),
    (106, 5, 500.50),
	 (107, 6, 250.00),
    (108, 6, 475.25),
    (109, 7, 300.50), 
    (110, 8, 275.25),
    (111, 9, 600.50),  
    (112, 10, 375.25),
    (113, 11, 800.50),
	(114, 12, 1000.50), 
    (115, 13, 1175.25),
    (116, 11, 550.50),  
    (117, 13, 475.25);

	--using select--
	select username,age from users;

	select username,age from users where age<25;

	select  username  from users where age <30 group by username order by username;

	select username,email,age from users order by age desc;

	--orderby using len-uses the lengthof name for sorting
   select username,email,age from users order by len(username) desc;

   --fetch and offset---
   	select user_id,username,email from users order by user_id
	OFFSET 5 rows;

	--fetch--
	select user_id,username,email,age from users order by age desc offset 0 rows fetch first 9 rows only

	--select Top---
	select top 8
	order_id,user_id,order_total
	from orders
	order by order_total desc

	select top 50 percent
	order_id,user_id,order_total
	from orders
	order by order_total desc

	
	
