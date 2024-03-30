/*
Assignment: Homework Chapter 5
Assignemtn description: 
1. Calculates total number of products and their price.
2. Retrieves category name, product count, and average price. Orders by count.
3. Calculates total price and discount for each customer's order. Orders by price.
4. Adjusted to include order count and total amount spent. Orders by total amount.
5. Computes total amount spent on orders with item price over 400. Orders by total amount.
6. Calculates total amount spent on each product, including subtotals and grand totals.
7. Counts distinct product IDs for each customer with multiple orders. Orders by email.

Course: CMSC246
Student: Nebil Sherif
Instructor: Professor G Grinberg
Due Date: 2/18
LATE

*/
/*1.Write a SELECT statement that returns these columns:
The count of the number of orders in the Orders table
The sum of the tax_amount columns in the Orders table
*/

SELECT 
    COUNT(*) AS number_of_products,
    SUM(list_price) AS Total_Price
FROM
    products;
    /*10	8418.95*/
 
/*2.Write a SELECT statement that returns one row for each category that has products with these columns:
The category_name column from the Categories table
The count of the products in the Products table
The list price of the most expensive product in the Products table
*/   
SELECT 
    c.category_name,
    COUNT(p.product_id) AS product_count,
    ROUND(AVG(p.list_price), 2) as average_price
FROM
    categories c
        JOIN
    products p ON c.category_id = p.category_id
GROUP BY c.category_name
ORDER BY product_count DESC;
/*Guitars	6	936.5
Basses	2	649.99
Drums	2	749.99*/

/*3.	Write a SELECT statement that returns one row for each customer that has orders with these columns:
The email_address column from the Customers table
The sum of the item price in the Order_Items table multiplied by the quantity in the Order_Items table
The sum of the discount amount column in the Order_Items table multiplied by the quantity in the Order_Items table
*/
SELECT 
    c.email_address ,
    SUM(oi.item_price * quantity) AS Total_Price,
    SUM(oi.discount_amount * quantity) AS discount_total
FROM
    customers c
        JOIN
    orders o ON c.customer_id = o.customer_id
        JOIN
    order_items oi ON o.order_id = oi.order_id
GROUP BY c.email_address
ORDER BY total_price DESC;
/*allan.sherwood@yahoo.com	4131	1830.39
christineb@solarone.com	2398	719.4
frankwilson@sbcglobal.net	2198.98	659.7
david.goldstein@hotmail.com	998	209.7
gary_hernandez@yahoo.com	799.99	120
barryz@gmail.com	489.99	186.2
erinv@gmail.com	299	0*/


/*4.	Write a SELECT statement that returns one row for each customer that has orders with these columns:
The email_address from the Customers table
A count of the number of orders
The total amount for each order (Hint: First, subtract the discount amount from the price. Then, multiply by the quantity.)
*/

SELECT c.email_address,
    COUNT(o.order_id) ,
    SUM((oi.item_price - oi.discount_amount) * oi.quantity) AS Total_Amount
FROM
    customers c
        JOIN
    orders o ON c.customer_id = o.customer_id
        JOIN
    order_items oi ON o.order_id = oi.order_id
GROUP BY c.email_address
HAVING (COUNT(o.order_id))>1
ORDER BY Total_Amount DESC;

/*allan.sherwood@yahoo.com	3	2300.61
frankwilson@sbcglobal.net	3	1539.28
david.goldstein@hotmail.com	2	788.3*/

/*5.Modify the solution to exercise 4 so it only counts and totals line items that have an item_price value that’s greater than 400.*/

SELECT 
    c.email_address ,
    COUNT(o.order_id),
    SUM((oi.item_price - oi.discount_amount) * oi.quantity) AS Total_amount
FROM
    customers c
        JOIN
    orders o ON c.customer_id = o.customer_id
        JOIN
    order_items oi ON o.order_id = oi.order_id
WHERE oi.item_price > 400
GROUP BY c.email_address
HAVING (COUNT(o.order_id)) > 1
ORDER BY Total_amount DESC;
/*allan.sherwood@yahoo.com	3	2300.61
frankwilson@sbcglobal.net	3	1539.28*/

/*6.Write a SELECT statement that answers this question: What is the total amount ordered for each product? Return these columns:
The product name from the Products table
The total amount for each product in the Order_Items */
SELECT 
    p.product_name,
    SUM((oi.item_price - oi.discount_amount) * oi.quantity) AS total_amount
FROM
    products p
        JOIN
    order_items oi ON p.product_id = oi.product_id
GROUP BY ROLLUP(p.product_name);
/*
Fender Precision	559.99
Fender Stratocaster	978.6
Gibson Les Paul	2517.9
Gibson SG	1208.16
Ludwig 5-piece Drum Set with Cymbals	489.99
Rodriguez Caballero 11	253.15
Tama 5-Piece Drum Set with Cymbals	679.99
Washburn D10S	598
Yamaha FG700S	303.79
	7589.57
*/

/*7.	Write a SELECT statement that answers this question: Which customers have ordered more than one product? Return these columns:
The email address from the Customers table
The count of distinct products from the customer’s order
*/
SELECT 
    c.email_address, 
    COUNT(DISTINCT oi.product_id)
FROM
    customers c
INNER JOIN
    orders o ON c.customer_id = o.customer_id
INNER JOIN
    order_items oi ON o.order_id = oi.order_id
GROUP BY c.email_address
HAVING (count (oi.product_id)) > 1;
/*
david.goldstein@hotmail.com	2
allan.sherwood@yahoo.com	3
frankwilson@sbcglobal.net	3
*/
