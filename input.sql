-- Task1
SELECT
    od.id AS order_detail_id,
    od.order_id,
    od.product_id,
    od.quantity,
    (SELECT o.customer_id
     FROM orders o
     WHERE o.id = od.order_id) AS customer_id
FROM
    order_details od;

-- Task2
SELECT
    od.id AS order_detail_id,
    od.order_id,
    od.product_id,
    od.quantity
FROM
    order_details od
WHERE
    od.order_id IN (
        SELECT o.id
        FROM orders o
        WHERE o.shipper_id = 3
    );

-- Task3
SELECT
    tmp.order_id,
    AVG(tmp.quantity) AS avg_quantity
FROM
    (SELECT
         order_id,
         quantity
     FROM
         order_details
     WHERE
         quantity > 10
    ) AS tmp
GROUP BY
    tmp.order_id;

-- Task4
WITH temp AS (
    SELECT
        order_id,
        quantity
    FROM
        order_details
    WHERE
        quantity > 10
)
SELECT
    temp.order_id,
    AVG(temp.quantity) AS avg_quantity
FROM
    temp
GROUP BY
    temp.order_id;

-- Task5
DROP FUNCTION IF EXISTS divide_numbers;

CREATE FUNCTION divide_numbers(param1 FLOAT, param2 FLOAT)
    RETURNS FLOAT
    DETERMINISTIC
BEGIN
    IF param2 = 0 THEN
        RETURN NULL;
END IF;
RETURN param1 / param2;
END;

SELECT
    id,
    order_id,
    product_id,
    quantity,
    divide_numbers(quantity, 2.0) AS divided_result
FROM
    order_details;

