/*
Short Description: The output of these exercises involves executing various SELECT statements in SQL to retrieve specific data from different tables.
Each exercise presents a unique query task, such as retrieving columns from the Products or Customers table, applying formatting to columns like full names, 
filtering rows based on certain criteria, performing calculations on columns, handling null values, and utilizing functions like SYSDATE.
Through these exercises, users practice constructing SQL queries to manipulate and extract data according to specific requirements, 
enhancing their understanding of SQL syntax and functionality. Additionally, the exercises encourage iterative testing and refinement of queries to ensure
accuracy and effectiveness in retrieving the desired dataset.*/

/* 1. Write a SELECT statement that returns four columns from the Products table*/

SELECT product_code, product_name, list_price, discount_percent
FROM Products
ORDER BY list_price DESC;

/*2. Write a SELECT statement that returns one column from the Customers table named full_name that joins the last_name and first_name columns.*/

SELECT Last_Name, ', ', First_Name AS FullName
FROM Customers
WHERE Last_Name > 'M'
ORDER BY Last_Name;


/*3.Write a SELECT statement that returns these columns from the Products table:
product_name	The product_name column
list_price	The list_price column
date_added	The date_added column */


SELECT product_name, list_price, date_added
FROM Products
WHERE list_price > 500 AND list_price < 2000
ORDER BY date_added DESC;



/*4.Write a SELECT statement that returns these column names and data from the Products table */

SELECT product_name, list_price, discount_percent,
    (list_price * discount_percent / 100) AS discount_amount,
    (list_price - (list_price * discount_percent / 100)) AS discount_price
FROM Products
WHERE ROWNUM <= 5
ORDER BY discount_price DESC;



/*5.Write a SELECT statement that returns these column names and data from the Order_Items table*/

SELECT item_id, item_price, discount_amount, quantity,
    (item_price * quantity) AS price_total,
    (discount_amount * quantity) AS discount_total,
    ((item_price - discount_amount) * quantity) AS item_total
FROM Order_Items
WHERE ((item_price - discount_amount) * quantity) > 500
ORDER BY item_total DESC;



/*6.	Write a SELECT statement that returns these columns from the Orders table:
order_id	The order_id column
order_date	The order_date column
ship_date	The ship_date column
Return only the rows where the ship_date column contains a null value.
*/

SELECT order_id, order_date, ship_date
FROM Orders
WHERE ship_date IS NULL;


/*7.Write a SELECT statement that uses the SYSDATE function to create a row with these columns*/

SELECT SYSDATE AS today_unformatted,
       TO_CHAR(SYSDATE, 'MM-DD-YYYY') AS today_formatted
FROM Dual;


/*8.Write a SELECT statement that creates a row with these columns:
price	      100 (dollars)
tax_rate	.07 (7 percent)
tax_amount	The price multiplied by the tax
total	     The price plus the tax
*/

SELECT 100 AS price,
       0.07 AS tax_rate,
       (100 * 0.07) AS tax_amount,
       (100 + (100 * 0.07)) AS total
FROM Dual;
