
/*Question 1*/
SELECT product_code, product_name, list_price, discount_percent
FROM Products
ORDER BY list_price DESC;

/*Question 2*/

SELECT last_name || ', ' || first_name AS full_name
FROM Customers
WHERE last_name BETWEEN 'M' AND 'Z'
ORDER BY last_name ASC;


/*Question 3*/
SELECT product_name, list_price, date_added
FROM Products
WHERE list_price BETWEEN 500 AND 2000
ORDER BY date_added DESC;

/*Question 4*/

SELECT product_name, list_price, discount_percent, 
    (list_price * discount_percent) AS discount_amount,
    (list_price - (list_price * discount_percent)) AS discount_price
FROM Products
WHERE ROWNUM <= 5
ORDER BY discount_price DESC;


/*Question 5*/

SELECT item_id, item_price, discount_amount, quantity,
    (item_price * quantity) AS price_total,
    (discount_amount * quantity) AS discount_total,
    (item_price - discount_amount) * quantity AS item_total
FROM Order_Items
WHERE item_total > 500
ORDER BY item_total DESC;

/*Question 6*/
SELECT order_id, order_date, ship_date
FROM Orders
WHERE ship_date IS NULL;


/*Question 7*/
SELECT SYSDATE AS today_unformatted,
    TO_CHAR(SYSDATE, 'MM-DD-YYYY') AS today_formatted
FROM DUAL;

/*Question 8*/
SELECT c.category_name, p.product_name, p.list_price
FROM Categories c
JOIN Products p ON c.category_id = p.category_id
ORDER BY c.category_name, p.product_name;

/*Question 9*/

SELECT c.first_name, c.last_name, a.line1, a.city, a.state, a.zip_code
FROM Customers c
INNER JOIN Addresses a ON c.customer_id = a.customer_id
WHERE c.email_address = 'allan.sherwood@yahoo.com';

/*Question 10*/


SELECT c.first_name, c.last_name, a.line1, a.city, a.state, a.zip_code
FROM Customers c
INNER JOIN Addresses a ON c.customer_id = a.customer_id
WHERE a.address_id = 'shipping';

/*Question 11*/

SELECT c.last_name, c.first_name, o.order_date, p.product_name, oi.item_price, oi.discount_amount, oi.quantity
FROM Customers c
INNER JOIN Orders o ON c.customer_id = o.customer_id
INNER JOIN Order_Items oi ON o.order_id = oi.order_id
INNER JOIN Products p ON oi.product_id = p.product_id
ORDER BY c.last_name, o.order_date, p.product_name;

/*Question 12*/


SELECT p1.product_name, p1.list_price
FROM Products p1
INNER JOIN Products p2 ON p1.list_price = p2.list_price
WHERE p1.product_id != p2.product_id
ORDER BY p1.product_name;

/*Question 13*/


SELECT c.category_name, p.product_id
FROM Categories c
LEFT OUTER JOIN Products p ON c.category_id = p.category_id
WHERE p.product_id IS NULL;

/*Question 14*/


SELECT
    (CASE
        WHEN o.ship_date IS NULL THEN 'NOT SHIPPED'
        ELSE 'SHIPPED'
     END) AS ship_status,
     o.order_id,
     o.order_date
FROM Orders o
UNION
SELECT
    (CASE
        WHEN o.ship_date IS NULL THEN 'NOT SHIPPED'
        ELSE 'SHIPPED'
     END) AS ship_status,
     o.order_id,
     o.order_date
FROM Orders o
ORDER BY order_date ASC;