--Assignment: Homework Chapter 8
--Short Description: This SQL homework involves six exercises focusing on SQL queries to manipulate and format data from "Products" and "Orders" tables. Tasks include formatting prices, converting date types, calculating discounts, and masking credit card numbers. Each exercise is designed to practice specific SQL functions like TO_CHAR, CAST, ROUND, and SUBSTR for data presentation and manipulation.
--File: ExampleCh8.sql
--Course: CMSC246
--Student: Nebil Sherif
--Professor G Grinberg
--Due Date: 10/11/21


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
  /*
699	              $699.00
1199	            $1,199.00
2517	            $2,517.00
489.99	              $489.99
299	              $299.00
415	              $415.00
799.99	              $799.99
499.99	              $499.99
699.99	              $699.99
799.99	              $799.99
  */

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
30-OCT-11	30-OCT-11
05-DEC-11	05-DEC-11
04-FEB-12	04-FEB-12
01-JUN-12	01-JUN-12
30-JUL-12	30-JUL-12
30-JUL-12	30-JUL-12
01-JUN-12	01-JUN-12
30-JUL-12	30-JUL-12
30-JUL-12	30-JUL-12
30-JUL-12	30-JUL-12
  */


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
  /*
699	30	209.7
1199	30	359.7
2517	52	1308.84
489.99	38	186.2
299	0	0
415	39	161.85
799.99	30	240
499.99	25	125
699.99	30	210
799.99	15	120
  */


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
28-MAR-12	2012	MAR-28-2012	09:40 AM	03/28/12 09:40
28-MAR-12	2012	MAR-28-2012	11:23 AM	03/28/12 11:23
29-MAR-12	2012	MAR-29-2012	09:44 AM	03/29/12 09:44
30-MAR-12	2012	MAR-30-2012	03:22 PM	03/30/12 15:22
31-MAR-12	2012	MAR-31-2012	05:43 AM	03/31/12 05:43
31-MAR-12	2012	MAR-31-2012	06:37 PM	03/31/12 18:37
01-APR-12	2012	APR-01-2012	11:11 PM	04/01/12 23:11
02-APR-12	2012	APR-02-2012	11:26 AM	04/02/12 11:26
03-APR-12	2012	APR-03-2012	12:22 PM	04/03/12 12:22
  */

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
4111111111111111	16	1111	XXXX-XXXX-XXXX-1111
4012888888881881	16	1881	XXXX-XXXX-XXXX-1881
4111111111111111	16	1111	XXXX-XXXX-XXXX-1111
378282246310005 	16	005 	XXXX-XXXX-XXXX-005 
4111111111111111	16	1111	XXXX-XXXX-XXXX-1111
6011111111111117	16	1117	XXXX-XXXX-XXXX-1117
5555555555554444	16	4444	XXXX-XXXX-XXXX-4444
4012888888881881	16	1881	XXXX-XXXX-XXXX-1881
4111111111111111	16	1111	XXXX-XXXX-XXXX-1111
  */

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
 /*
1	28-MAR-12	30-MAR-12	30-MAR-12	2.24471064814814814814814814814814814815
2	28-MAR-12	30-MAR-12	29-MAR-12	1.06173611111111111111111111111111111111
3	29-MAR-12	31-MAR-12	31-MAR-12	1.97688657407407407407407407407407407407
4	30-MAR-12	01-APR-12	03-APR-12	4.04849537037037037037037037037037037037
5	31-MAR-12	02-APR-12	02-APR-12	2.3597337962962962962962962962962962963
6	31-MAR-12	02-APR-12		
*/
