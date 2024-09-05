--Fetch data in employees table with sale date ordered ascending
SELECT * FROM employees
ORDER BY sale_date ASC;

--Query for getting the MIN and MAX value per job_position
SELECT 
MIN(sales) AS lowest_sales, MAX(sales) AS highest_sales, last_name
FROM employees;

--Query for getting the highest and lowest sales employee
SELECT
	first_name, last_name, sales
FROM
	employees
ORDER BY 
	sales DESC;

--query for getting the average of sales field
SELECT
	AVG(sales) AS avg_sales
FROM employees;

--Query for viewing persons per job position and their salary
SELECT
	employee_id, first_name, last_name, job_position, sales
FROM
	employees
ORDER BY job_position;

--Query fot getting the employee with lowest and highest sales using window function
SELECT
	employee_id,
	last_name,
	sales,
	FIRST_VALUE(last_name) OVER (ORDER BY sales ASC) AS employee_with_lowest_sales,
	FIRST_VALUE(last_name) OVER (ORDER BY sales DESC) AS employee_with_highest_sales
FROM employees
ORDER BY sales DESC;

--Getting the previous sales and their difference to sales
SELECT
	employee_id,
	last_name,
	job_position,
	sale_date,
	sales,
	LAG(sales, 1, 0) OVER(ORDER BY sale_date) AS previous_sales,
	sales - LAG(sales, 1, 0) OVER(ORDER BY sale_date) AS sales_difference
FROM
	employees;

--Getting the average sales per department ordered by sales date
SELECT
	employee_id,
	last_name,
	job_position,
	sale_date,
	sales,
	AVG(sales) OVER(PARTITION BY job_position ORDER BY sale_date ASC) AS avg_sales_per_dep
FROM employees;