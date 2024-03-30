--Assignment: Homework Chapter 8
--Short Description: This SQL homework involves six exercises focusing on SQL queries to manipulate and format data from "Products" and "Orders" tables. Tasks include formatting prices, converting date types, calculating discounts, and masking credit card numbers. Each exercise is designed to practice specific SQL functions like TO_CHAR, CAST, ROUND, and SUBSTR for data presentation and manipulation.
--File: ExampleCh8.sql



/*
1.Write a SELECT statement that returns these columns from the Products table:
The list_price column
A column that uses the TO_CHAR function to return the list_price column with currency formatting
*/
SELECT
  list_price,
  TO_CHAR(list_price, 'L999G999D99') AS formatted_price
FROM
  Products;


/*2.Write a SELECT statement that returns these columns from the Products table:
The date_added column
A column that uses the CAST function to return the date_added column as the VARCHAR2 data type with 9 characters
*/
SELECT
  date_added,
  CAST(date_added AS VARCHAR2(9)) AS date_added_varchar
FROM
  Products;
 

/*
3.Write a SELECT statement that returns these columns from the Products table:
The list_price column
The discount_percent column
A column named discount_amount that uses the previous two columns to calculate the discount amount and uses the ROUND function to round the result so it has 2 decimal digits

*/
SELECT
  list_price,
  discount_percent,
  ROUND((list_price * (discount_percent / 100)), 2) AS discount_amount
FROM
  Products;
 


/*4.	Write a SELECT statement that returns these columns from the Orders table:
The order_date column
A column that uses the TO_CHAR function to return the four-digit year that’s stored in the order_date column
*/

SELECT
  order_date,
  TO_CHAR(order_date, 'YYYY') AS year,
  TO_CHAR(order_date, 'MON-DD-YYYY') AS formatted_date,
  TO_CHAR(order_date, 'HH:MI AM') AS time_12hr,
  TO_CHAR(order_date, 'MM/DD/YY HH24:MI') AS formatted_date_time
FROM
  Orders;
 

/*
5.	Write a SELECT statement that returns these columns from the Orders table:
The card_number column

*/
SELECT
  card_number,
  LENGTH(card_number) AS card_length,
  SUBSTR(card_number, -4) AS last_four,
  'XXXX-XXXX-XXXX-' || SUBSTR(card_number, -4) AS masked_card_number
FROM
  Orders;
 

/*
6.Write a SELECT statement that returns these columns from the Orders table:
The order_id column
*/
SELECT
  order_id,
  order_date,
  order_date + INTERVAL '2' DAY AS approx_ship_date,
  ship_date,
  ship_date - order_date AS days_to_ship
FROM
  Orders
WHERE
  EXTRACT(YEAR FROM order_date) = 2012 AND EXTRACT(MONTH FROM order_date) = 3;

