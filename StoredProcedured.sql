create database StoredProcedures
use storedprocedures

CREATE TABLE users (
    user_id INT identity PRIMARY KEY,
    username NVARCHAR(50) NOT NULL,
	salary int,
	-- check constraint for age
    age INT CHECK (age >= 18), 
    year int,
	country varchar(50)
);
select * from users

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    user_id INT,
    order_total DECIMAL(10, 2) CHECK (order_total > 0),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);


INSERT INTO users (username,salary , age,year,country)
VALUES
    ( 'jacob', 35000,25,2005,'India'),
    ('Alex',40000,30,2010,'USA'),
    ('Sai', 50000,23,2015,'USA'),
    ('Teja',45000,22,2016,'India'),
    ('rahul', 35000,31,2005,'India'),
    ('Rohith',30000,35,2015,'USA'),
    ('Deelip',35000,25,2010,'UAE'),
    ('Deepak',50000,27,2016,'UK'),
    ('Sheik',45000,29,2018,'UK'),
    ('Azar',30000,32,2014,'India'),
	('Karan',40000,21,2019,'UAE'),
    ('Sandeep',20000,20,2019,'India')

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
    (116, 11, 550.50)



	----stored procedures----

	create procedure spGetallusers
	as
	begin 
	select * from users;
	end

	execute spGetallusers

	create procedure getUserbyId(@User_id int)
	as begin 
	select * from users where user_id=@User_id;
	end

	execute getUserbyId 2;

	create procedure getuserbyidandname
	@user_id int,@username varchar(50)
	as begin 
	select * from users where user_id=@user_id and username=@username
	end

	execute getuserbyidandname 2,'alex'

	create procedure getbycountry
	@country varchar (50)
	as begin
	select * from users where country=@country
	end

	execute getbycountry 'USA'


	create procedure avgsalary(@avg_salary int)
	as begin 
	select * from users where salary=@avg_salary
	end

	execute avgsalary=30000

	create procedure avgsalarycount(@avg_salary int,@count int output)
	
	as begin 
	select * from users where salary>=@avg_salary;
	select @count=@@ROWCOUNT
	end

	declare @counts int;
	execute avgsalarycount 35000,@counts output;

	select @counts as 'number of rows found'


	create procedure insertdata
   @username NVARCHAR(50),
	@salary int,
	-- check constraint for age
    @age INT, 
	@year int,
	@country varchar(50)

	as 
	insert into users(
   username,
	salary ,
	age , 
	year,
	country
	)
	values(
   @username,
	@salary,
    @age, 
	@year,
	@country
	)

	execute insertdata  'Alexstar',20000,20,2019,'Africa';
	select * from users

	CREATE PROCEDURE UpdateUser
    @user_id INT,
    @username NVARCHAR(255),
    @Salary DECIMAL(10, 2),
    @Age INT,
    @Country NVARCHAR(255)
AS
BEGIN
    UPDATE users
    SET username = @username, Salary = @Salary, Age = @Age, Country = @Country
    WHERE user_id = @user_id;
END;

execute UpdateUser  @user_id=13,@username= 'alex',@salary=32000,@age=24,@country='Australia'

create procedure deleteuser 
@user_id int
as begin 
delete from users
where user_id=@user_id
end

execute deleteuser 13

	select * from users
