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
SELECT
    ROUND(
        100.0 * SUM(
            CASE
                WHEN order_date = customer_pref_delivery_date
                THEN 1
                ELSE 0
            END
            ) / COUNT(*)
        ,2
        ) immediate_percentage
FROM delivery;