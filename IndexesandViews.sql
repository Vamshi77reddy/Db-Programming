create database IndexDb
use indexDb
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY CLUSTERED,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2)
);
select * from orders

INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount)
VALUES
    (1, 101, '2023-09-01', 100.00),
    (2, 102, '2023-09-02', 150.00),
    (3, 101, '2023-09-03', 75.00),
    (4, 103, '2023-09-04', 200.00),
    (5, 102, '2023-09-05', 125.00);
	select * from orders where 
	OrderID=2


	CREATE TABLE Orders1 (
    OrderID INt,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2)
);
select * from orders1

INSERT INTO Orders1 (OrderID, CustomerID, OrderDate, TotalAmount)
VALUES
    (1, 101, '2023-09-01', 100.00),
    (3, 102, '2023-09-02', 150.00),
    (2, 101, '2023-09-03', 75.00),
    (5, 103, '2023-09-04', 200.00),
    (4, 102, '2023-09-05', 125.00);

	create clustered index XL_id_clustered
	on orders1(orderid)

	select * from orders1




	---non clustered index----

create nonclustered index NIX_nonclustered
on orders1(TotalAmount)


sp_helpindex orders1


select * from orders1 
where TotalAmount=125



----View-------------------------------------

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    department_id INT,
    salary DECIMAL(10, 2) NOT NULL,
);

INSERT INTO employees (employee_id, first_name, last_name, department_id, salary)
VALUES
    (1, 'John', 'Doe', 1, 55000.00),
    (2, 'Jane', 'Smith', 1, 60000.00),
    (3, 'Bob', 'Johnson', 2, 65000.00),
    (4, 'Alice', 'Brown', 2, 70000.00),
    (5, 'Eve', 'Davis', 3, 60000.00),
    (6, 'Mike', 'Wilson', 3, 55000.00),
    (7, 'David', 'Lee', 4, 75000.00),
    (8, 'Sarah', 'Anderson', 4, 80000.00);

	select * from employees

	create view viewEmployee
	as 	select * from employees
		select * from viewEmployee

create view rowlevel
as select first_name,salary from employees

    
create view rowlevel1
as select * from employees where employee_id<5

select * from rowlevel1
