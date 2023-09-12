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

-- Create an 'orders' table with a foreign key reference to 'users'
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    user_id INT,
    order_total DECIMAL(10, 2) CHECK (order_total > 0),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

select * from users
select * from orders

