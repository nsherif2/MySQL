/*
Assignment: Homework Chapter 4
Assignemtn description: Join tables, select specific columns, utilized joins to combine customers
and address data, filtering based on email address and shipping address.
employed UNION operators to merge date from multiple queries and generate comprehenesive result.
Course: CMSC246
Student: Nebil Sherif
Instructor: Professor G Grinberg
Due Date: Late
*/

/*1.Write a SELECT statement that joins the Categories table to the Products table and returns these columns: category_name, product_name, list_price.*/

SELECT c.category_name, p.product_name, p.list_price FROM categories c
JOIN products p ON c.category_id= p.category_id
ORDER BY c.category_name, p.product_name;
/*
Basses	Fender Precision	799.99
Basses	Hofner Icon	499.99
Drums	Ludwig 5-piece Drum Set with Cymbals	699.99
Drums	Tama 5-Piece Drum Set with Cymbals	799.99
Guitars	Fender Stratocaster	699
Guitars	Gibson Les Paul	1199
Guitars	Gibson SG	2517
Guitars	Rodriguez Caballero 11	415
Guitars	Washburn D10S	299
Guitars	Yamaha FG700S	489.99
*/

/*2.Write a SELECT statement that joins the Customers table to the Addresses table and returns these columns: first_name, last_name, line1, city, state, zip_code.*/

SELECT c.first_name, c.last_name, a.line1, a.city, a.state, a.zip_code FROM customers c
JOIN addresses a ON c.customer_id= a.customer_id
WHERE c.email_address = 'allan.sherwood@yahoo.com'
ORDER BY a.zip_code;
/*
Allan	Sherwood	100 East Ridgewood Ave.	Paramus	NJ	07652
Allan	Sherwood	21 Rosewood Rd.	Woodcliff Lake	NJ	07677
*/

/*3.Write a SELECT statement that joins the Customers table to the Addresses table and returns these columns: first_name, last_name, line1, city, state, zip_code.*/
SELECT c.first_name, c.last_name, a.line1, a.city, a.state, a.zip_code FROM Customers c
JOIN addresses a ON c.shipping_address_id = a.address_id;
/*
Allan	Sherwood	100 East Ridgewood Ave.	Paramus	NJ	07652
Barry	Zimmer	16285 Wendell St.	Omaha	NE	68135
Christine	Brown	19270 NW Cornell Rd.	Beaverton	OR	97006
David	Goldstein	186 Vermont St.	San Francisco	CA	94110
Erin	Valentino	6982 Palm Ave.	Fresno	CA	93711
Frank Lee	Wilson	23 Mountain View St.	Denver	CO	80208
Gary	Hernandez	7361 N. 41st St.	New York	NY	10012
Heather	Esway	2381 Buena Vista St.	Los Angeles	CA	90023
*/

/*4.Write a SELECT statement that joins the Customers, Orders, Order_Items, and Products tables. This statement should return these columns: last_name, first_name, order_date, product_name, item_price, discount_amount, and quantity.*/

SELECT c.last_name, c.first_name, o.order_date, p.product_name, 
oi.item_price, oi.discount_amount, oi.quantity FROM Customers C
JOIN Orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
ORDER BY c.last_name, o.order_date, p.product_name;
/*
Brown	Christine	30-MAR-12	Gibson Les Paul	1199	359.7	2
Goldstein	David	31-MAR-12	Washburn D10S	299	0	1
Goldstein	David	03-APR-12	Fender Stratocaster	699	209.7	1
Hernandez	Gary	02-APR-12	Tama 5-Piece Drum Set with Cymbals	799.99	120	1
Sherwood	Allan	28-MAR-12	Gibson Les Paul	1199	359.7	1
Sherwood	Allan	29-MAR-12	Gibson SG	2517	1308.84	1
Sherwood	Allan	29-MAR-12	Rodriguez Caballero 11	415	161.85	1
Valentino	Erin	31-MAR-12	Washburn D10S	299	0	1
Wilson	Frank Lee	01-APR-12	Fender Precision	799.99	240	1
Wilson	Frank Lee	01-APR-12	Fender Stratocaster	699	209.7	1
Wilson	Frank Lee	01-APR-12	Ludwig 5-piece Drum Set with Cymbals	699.99	210	1
Zimmer	Barry	28-MAR-12	Yamaha FG700S	489.99	186.2	1
*/

/*5.Write a SELECT statement that returns the product_name and list_price columns from the Products table.*/

SELECT DISTINCT p1.product_name, p1.list_price
FROM Products p1
JOIN Products p2 ON p1.list_price = p2.list_price 
AND p1.product_id <> p2.product_id
ORDER BY p1.product_name;
/*
Fender Precision	799.99
Tama 5-Piece Drum Set with Cymbals	799.99
*/

/*6.Write a SELECT statement that returns these two columns: 
category_name	The category_name column from the Categories table
product_id	The product_id column from the Products table
*/

SELECT c.category_name, p.product_id
FROM Categories c
LEFT JOIN Products p ON c.category_id = p.category_id
WHERE p.product_id IS NULL;
/*
Keyboards	
*/

/*7.Use the UNION operator to generate a result set consisting of three columns from the Orders table: 
ship_status	A calculated column that contains a value of SHIPPED or NOT SHIPPED
order_id	The order_id column
order_date	The order_date column
*/

SELECT 'SHIPPED' AS ship_status, order_id, order_date
FROM Orders 
WHERE ship_date IS NOT NULL
UNION 
SELECT 'NOT SHIPPED' AS ship_status, order_id, order_date
FROM Orders 
WHERE ship_date IS NULL
ORDER BY order_date;
/*
SHIPPED	1	28-MAR-12
SHIPPED	2	28-MAR-12
SHIPPED	3	29-MAR-12
SHIPPED	4	30-MAR-12
SHIPPED	5	31-MAR-12
NOT SHIPPED	6	31-MAR-12
SHIPPED	7	01-APR-12
NOT SHIPPED	8	02-APR-12
NOT SHIPPED	9	03-APR-12
*/