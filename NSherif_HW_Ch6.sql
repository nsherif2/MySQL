/*
Assignment: Homework Chapter 6

*/

/*1.Write a SELECT statement that returns the same result set as this SELECT statement, but don’t use a join. Instead, use a subquery in a WHERE clause that uses the IN keyword.*/
SELECT DISTINCT
    category_name
FROM
    categories
WHERE
    category_id IN (
        SELECT DISTINCT
            category_id
        FROM
            products
    )
ORDER BY
    category_name;
        
    

/*2.Write a SELECT statement that answers this question: Which products have a list price that’s greater than the average list price for all products?*/

SELECT
    product_name,
    list_price
FROM
    products
WHERE
    list_price > (
        SELECT
            AVG(list_price)
        FROM
            products
    )
ORDER BY
    list_price DESC;
    


/*3.	Write a SELECT statement that returns the category_name column from the Categories table*/

SELECT
    category_name
FROM
    categories
WHERE
    NOT EXISTS (
        SELECT
            *
        FROM
            products
        WHERE
            category_id = categories.category_id
    );

/*4.Write a SELECT statement that returns three columns: email_address, order_id, and the order total for each customer. To do this, you can group the result set by the email_address and order_id columns. In addition, you must calculate the order total from the columns in the Order_Items table.
Write a second SELECT statement that uses the first SELECT statement in its FROM clause. The main query should return two columns: the customer’s email address and the largest order for that customer. To do this, you can group the result set by the email_address.
*/

SELECT
    c.email_address,
    o.order_id,
    SUM((oi.item_price - oi.discount_amount) * quantity) AS order_total
FROM
         customers c
    JOIN orders      o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY
    c.email_address,
    o.order_id;
  
    

SELECT
    t_3.email_address AS email,
    t_3.order_id      AS the_order_id,
    t_2.max_order     AS max_order_total
FROM
         (
        SELECT
            t_1.email_address,
            MAX(t_1.order_total) AS max_order
        FROM
            (
                SELECT
                    c.email_address,
                    o.order_id,
                    SUM((oi.item_price - oi.discount_amount) * oi.quantity) AS order_total
                FROM
                         customers c
                    INNER JOIN orders      o ON c.customer_id = o.customer_id
                    INNER JOIN order_items oi ON o.order_id = oi.order_id
                GROUP BY
                    c.email_address,
                    o.order_id
            ) t_1
        GROUP BY
            t_1.email_address
    ) t_2
    INNER JOIN (
        SELECT
            c.email_address,
            o.order_id,
            SUM((oi.item_price - oi.discount_amount) * oi.quantity) AS order_total
        FROM
                 customers c
            INNER JOIN orders      o ON c.customer_id = o.customer_id
            INNER JOIN order_items oi ON o.order_id = oi.order_id
        GROUP BY
            c.email_address,
            o.order_id
    ) t_3 ON t_3.email_address = t_2.email_address
             AND t_3.order_total = t_2.max_order;


/*5.	Write a SELECT statement that returns the name and discount percent of each product that has a unique discount percent. In other words, don’t include products that have the same discount percent as another product.*/


SELECT p.product_name, p.discount_percent
FROM Products p
JOIN (
    SELECT discount_percent
    FROM Products
    GROUP BY discount_percent
    HAVING COUNT(*) = 1
) unique_discounts
ON p.discount_percent = unique_discounts.discount_percent
ORDER BY p.product_name;




/*6.Use a correlated subquery to return one row per customer, representing the customer’s oldest order (the one with the earliest date). Each row should include these three columns: email_address, order_id, and order_date.*/

SELECT
    c.email_address,
    o.order_id,
    o.order_date
FROM
         customers c
    INNER JOIN orders o ON o.customer_id = c.customer_id
WHERE
    o.order_date IN (
        SELECT
            MIN(o.order_date)
        FROM
            orders o
        GROUP BY
            o.customer_id
    );

