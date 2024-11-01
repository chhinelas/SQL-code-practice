/*
this database is use to store the customer information, products,
and their purchase history. It contains 3 tables namely customers,
products, and purchases. They have realationship to each other.
*/
CREATE DATABASE [supermarket];



USE [supermarket];


/*this table stores basic information about the supermarket's
customers. It has 4 fields: customer_id (PRIMARY KEY), customer_name VARCHAR,
age, and customer_address VARCHAR
*/
CREATE TABLE customers(
	customer_id INT PRIMARY KEY IDENTITY (1, 1),
	customer_name VARCHAR(100) NOT NULL,
	age INT NOT NULL,
	customer_address VARCHAR(200) NOT NULL
);


/*this table stores the poduct's information that are sold
in the supermarket. It contains 3 fields namely product_id(PRIMARY KEY),
prodcut_name (VARCHAR), and price (DECIMAL).
*/
CREATE TABLE products(
	product_id INT PRIMARY KEY,
	product_name VARCHAR(200) NOT NULL,
	price DECIMAL(10, 2) NOT NULL
);


/*this table stores customer purchases of products of
the supermarket. It has 6 fields namely purchase_id (PRIMARY KEY),
product_id (INT), customer_id (INT), quantity (INT), total_price (DECIMAL),
purchase_date (DATE)
*/
CREATE TABLE purchases(
	purchase_id INT PRIMARY KEY,
	product_id INT NOT NULL,
	customer_id INT NOT NULL,
	quantity INT NOT NULL,
	total_price DECIMAL (10, 2),
	purchased_date DATE NOT NULL,
	FOREIGN KEY (product_id) REFERENCES products(product_id),
	FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);


/*I created a trigger in the purchases table,
specifically in the total_price field. The logic behind
this trigger is that it mutiplies the quantity and
price column of table purchases and products tables
respectively to get the total price of the purchased
item of our customers in our supermarket. It 
automatically calculates the total_price field whenever
a new customer purchased a product.
*/
CREATE TRIGGER trg_CalculateTotalPrice
ON purchases
AFTER INSERT
AS
BEGIN
	UPDATE p
	SET total_price = i.quantity * pr.price
	FROM purchases AS p
	INNER JOIN inserted i ON p.purchase_id = i.purchase_id
	INNER JOIN products pr ON pr.product_id = i.product_id;
END;



/*
in this code block, I am inserting values in
the respective fields of customers table.
*/
INSERT INTO customers(
	customer_name,
	age,
	customer_address
)
VALUES
('Reymark', 20, 'Camiling'),
('Hanabi', 22, 'Gerona'),
('Lancelot', 30, 'Mayantoc'),
('Aldous', 28, 'Paniqui'),
('Terizla', 60, 'Moncada'),
('Kagura', 18, 'Bamban'),
('Alucard', 25, 'Capas'),
('Rafaela', 29, 'Tarlac city'),
('Yanyan', 25, 'Concepcion'),
('Karrie', 40, 'Victoria');


/*In this code block, I am inserting values in the
products fields.
*/
INSERT INTO products(
	product_id,
	product_name,
	price
)
VALUES
(1, 'Vinegar', 22.01),
(2, 'Broom', 75.60),
(3, 'Sardines', 18.00),
(4, 'Corned Tuna', 30),
(5, 'Candle set', 40.00),
(6, 'Pepper', 20.00),
(7, 'Candy', 35.50),
(8, '1 rim cigarette', 200.00),
(9, 'Coke litro', 45.05),
(10, 'Gulaman', 15.00);


/*
I am also inserting values in the purchases tables
*/
INSERT INTO purchases(
	purchase_id,
	product_id,
	customer_id,
	quantity,
	purchased_date
)
VALUES
(1, 3, 10, 2, '2024-12-12'),
(2, 4, 5, 3, '2024-12-11'),
(3, 5, 6, 1, '2024-11-28'),
(4, 2, 3, 4, '2024-12-31'),
(5, 6, 2, 8, '2024-11-10'),
(6, 9, 7, 10, '2024-12-15'),
(7, 8,9, 5, '2024-10-13'),
(8, 7, 4, 6, '2024-12-3'),
(9, 1, 8, 7, '2024-12-20'),
(10, 10, 1, 9, '2024-12-1');

--I made a query here to view the tables
SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM purchases;


/*
I made a common table expression here.
I join the 3 related tables to display 
their values accurately and precisely
to avoid confusion and data inaccuracy.
We can easily change the query to get the
information that we want for data analysis
and reporting.
*/
WITH receipt AS (
SELECT
	c.customer_name, c.age, c.customer_address,
	p.product_name, p.price,
	pur.quantity, pur.total_price, pur.purchased_date
FROM
	customers AS c
INNER JOIN purchases AS pur
	ON c.customer_id = pur.customer_id
INNER JOIN products AS p
	ON pur.product_id = p.product_id
)
										--the bottom query can be change depending on the user
										--to retrieve data for insight.
SELECT TOP 5 *
FROM receipt
ORDER BY total_price DESC;