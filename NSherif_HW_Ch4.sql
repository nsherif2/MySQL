/*

Assignment description: Join tables, select specific columns, utilized joins to combine customers
and address data, filtering based on email address and shipping address.
employed UNION operators to merge date from multiple queries and generate comprehenesive result.

*/

/*1.Write a SELECT statement that joins the Categories table to the Products table and returns these columns: category_name, product_name, list_price.*/

SELECT c.category_name, p.product_name, p.list_price FROM categories c
JOIN products p ON c.category_id= p.category_id
ORDER BY c.category_name, p.product_name;


/*2.Write a SELECT statement that joins the Customers table to the Addresses table and returns these columns: first_name, last_name, line1, city, state, zip_code.*/

SELECT c.first_name, c.last_name, a.line1, a.city, a.state, a.zip_code FROM customers c
JOIN addresses a ON c.customer_id= a.customer_id
WHERE c.email_address = 'allan.sherwood@yahoo.com'
ORDER BY a.zip_code;


/*3.Write a SELECT statement that joins the Customers table to the Addresses table and returns these columns: first_name, last_name, line1, city, state, zip_code.*/
SELECT c.first_name, c.last_name, a.line1, a.city, a.state, a.zip_code FROM Customers c
JOIN addresses a ON c.shipping_address_id = a.address_id;


/*4.Write a SELECT statement that joins the Customers, Orders, Order_Items, and Products tables. This statement should return these columns: last_name, first_name, order_date, product_name, item_price, discount_amount, and quantity.*/

SELECT c.last_name, c.first_name, o.order_date, p.product_name, 
oi.item_price, oi.discount_amount, oi.quantity FROM Customers C
JOIN Orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
ORDER BY c.last_name, o.order_date, p.product_name;


/*5.Write a SELECT statement that returns the product_name and list_price columns from the Products table.*/

SELECT DISTINCT p1.product_name, p1.list_price
FROM Products p1
JOIN Products p2 ON p1.list_price = p2.list_price 
AND p1.product_id <> p2.product_id
ORDER BY p1.product_name;


/*6.Write a SELECT statement that returns these two columns: 
category_name	The category_name column from the Categories table
product_id	The product_id column from the Products table
*/

SELECT c.category_name, p.product_id
FROM Categories c
LEFT JOIN Products p ON c.category_id = p.category_id
WHERE p.product_id IS NULL;


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
