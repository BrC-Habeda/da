-- Immediate Food Delivery II
CREATE TABLE delivery (
    delivery_id int,
    customer_id int,
    order_date date,
    customer_pref_delivery_date date
);

INSERT INTO delivery(delivery_id,customer_id,order_date,customer_pref_delivery_date)
VALUES
(1,1,'2019-08-01','2019-08-02'),
(2,2,'2019-08-02','2019-08-02'),
(3,1,'2019-08-11','2019-08-11'),
(4,3,'2019-08-24','2019-08-24'),
(5,3,'2019-08-21','2019-08-22'),
(6,2,'2019-08-11','2019-08-13'),
(7,4,'2019-08-09','2019-08-09');

-- Write a solution to find the percentage of immediate orders of all customers,
-- rounded to 2 decimal places
WITH FirstOrders AS (
    SELECT 
        customer_id,
        MIN(order_date) AS first_order_date
    FROM delivery
    GROUP BY customer_id
),
ImmediateOrders AS (
    SELECT
        d.customer_id,
        d.delivery_id,
        d.order_date,
        d.customer_pref_delivery_date
    FROM delivery d
    JOIN FirstOrders fo
    ON d.customer_id = fo.customer_id AND d.order_date = fo.first_order_date
    WHERE d.order_date = d.customer_pref_delivery_date
),
TotalFirstOrders AS (
    SELECT COUNT(*) AS total_first_orders
    FROM FirstOrders
),
ImmediateFirstOrders AS (
    SELECT COUNT(*) AS immediate_first_orders
    FROM ImmediateOrders
)
SELECT 
    ROUND(
        (SELECT immediate_first_orders FROM ImmediateFirstOrders)::numeric / 
        (SELECT total_first_orders FROM TotalFirstOrders)::numeric * 100, 
        2
    ) AS immediate_percentage;
