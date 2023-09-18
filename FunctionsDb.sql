create database functions
use functions

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(255) NOT NULL
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    department_id INT,
    salary DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

INSERT INTO departments (department_id, department_name)
VALUES
    (1, 'HR'),
    (2, 'Finance'),
    (3, 'Sales'),
    (4, 'Engineering');

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



SELECT 
    d.department_name,
    ROUND(AVG(e.salary), 0) AS avg_salary
FROM
    employees AS e
INNER JOIN
    departments AS d
ON
    e.department_id = d.department_id
GROUP BY
    d.department_name
ORDER BY
    d.department_name;


	SELECT 
    d.department_name,
    MAX(e.salary) AS max_salary
FROM
    employees AS e
INNER JOIN
    departments AS d
ON
    e.department_id = d.department_id
GROUP BY
    d.department_name
ORDER BY
    d.department_name;

	select d.department_name,
	sum(salary) as total_salary
	from employees as e
	inner join 
	departments as d
	on 
	d.department_id=e.department_id
	group by d.department_name
	order by d.department_name

	

	SELECT 
    SUM(salary) AS total_salary_sum
FROM
    employees;

	SELECT 
    max(salary) AS total_salary_max
FROM
    employees;

	SELECT 
    avg(salary) AS total_salary_avg
FROM
    employees;

	SELECT 
    department_id,
    AVG(CASE WHEN salary > 50000 THEN salary ELSE NULL END) AS avg_salary_above_50k
FROM
    employees
GROUP BY
    department_id;

		SELECT 
    d.department_name,
    min(e.salary) AS min_salary
FROM
    employees AS e
INNER JOIN
    departments AS d
ON
    e.department_id = d.department_id
GROUP BY
    d.department_name
ORDER BY
    d.department_name;



	SELECT 
    CURRENT_TIMESTAMP AS current_date_time;


		---string function--

	SELECT 
    first_name, 
    last_name, 
    CONCAT(last_name , first_name) full_name
FROM 
employees ORDER BY 
    first_name, 
    last_name;

	SELECT 
    d.department_name,
    SUM(e.salary) AS total_salary_sum
FROM
    employees AS e
INNER JOIN
    departments AS d
ON
    e.department_id = d.department_id
GROUP BY
    d.department_name;


	--ascii--

	SELECT 
    CHAR(65) char_65, 
    CHAR(90) char_90;

	--len fun---
	SELECT
    first_name,
    LEN(first_name) product_name_length
FROM
employees ORDER BY
    LEN(first_name) DESC;



	------user defined fumctions---

	---scalar functions which take one or more parameters and return single value---
CREATE FUNCTION CalculateTotalSalaryByDepartment (@dept_id INT)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @total_salary DECIMAL(10, 2);

    SELECT @total_salary = SUM(salary)
    FROM employees
    WHERE department_id = @dept_id;

    RETURN @total_salary;
END;

DECLARE @hr_department_id INT = 1;
DECLARE @total_hr_salary DECIMAL(10, 2);
SELECT @total_hr_salary = dbo.CalculateTotalSalaryByDepartment(@hr_department_id);

PRINT 'Total Salary for HR Department: ' + CAST(@total_hr_salary AS VARCHAR(20));


DECLARE @hr_department_id INT = 2;
DECLARE @total_hr_salary DECIMAL(10, 2);
SELECT @total_hr_salary = dbo.CalculateTotalSalaryByDepartment(@hr_department_id);

PRINT 'Total Salary for Finance Department: ' + CAST(@total_hr_salary AS VARCHAR(20));


---year salary--
CREATE FUNCTION CalculateAnnualSalary (@monthly_salary DECIMAL(10, 2))
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @annual_salary DECIMAL(10, 2);

    SET @annual_salary = @monthly_salary * 12;

    RETURN @annual_salary;
END;

SELECT 
    employee_id,
    first_name,
    last_name,
    salary AS monthly_salary,
    dbo.CalculateAnnualSalary(salary) AS annual_salary
FROM
    employees;


	--- Create a TVF -----
alter FUNCTION GetEmployeesAboveSalary (@salary_threshold DECIMAL(10, 2))
RETURNS TABLE
AS
RETURN (
    SELECT 
       *
    FROM
        employees
    WHERE
        salary > @salary_threshold
);

DECLARE @min_salary DECIMAL(10, 2) = 65000.00;

SELECT * FROM dbo.GetEmployeesAboveSalary(@min_salary);


-- Create a multi-statement TVF named "CalculateAverageSalaryByDepartment"
CREATE FUNCTION CalculateAverageSalaryByDepartment ()
RETURNS @result TABLE (
    department_id INT,
    department_name VARCHAR(255),
    avg_salary DECIMAL(10, 2)
)
AS
BEGIN
    INSERT INTO @result (department_id, department_name, avg_salary)
    SELECT 
        d.department_id,
        d.department_name,
        AVG(e.salary) AS avg_salary
    FROM
        departments AS d
    INNER JOIN
        employees AS e
    ON
        d.department_id = e.department_id
    GROUP BY
        d.department_id, d.department_name;

    RETURN;
END;

SELECT * FROM dbo.CalculateAverageSalaryByDepartment();


-- Create a multi-statement TVF named "GetEmployeesByDepartment"
CREATE FUNCTION GetEmployeesByDepartment (@dept_id INT)
RETURNS @result TABLE (
    employee_id INT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    department_id INT,
    salary DECIMAL(10, 2)
)
AS
BEGIN
    INSERT INTO @result (employee_id, first_name, last_name, department_id, salary)
    SELECT 
        employee_id,
        first_name,
        last_name,
        department_id,
        salary
    FROM
        employees
    WHERE
        department_id = @dept_id;

    RETURN;
END;

DECLARE @dept_id INT = 2; -- Specify the department ID

SELECT * FROM dbo.GetEmployeesByDepartment(@dept_id);

