-- Customers who visited but did not make any transactions

CREATE TABLE visits(
    visit_id int,
    customer_id int
);

CREATE TABLE transactions(
    transaction_id int,
    visit_id int,
    amount int
);

INSERT INTO visits(visit_id,customer_id)
VALUES
(1,23),
(2,9),
(4,30),
(5,54),
(6,96),
(7,54),
(8,54);

INSERT INTO transactions(transaction_id,visit_id,amount)
VALUES
(2,5,310),
(3,5,300),
(9,5,200),
(12,1,910),
(13,2,970);

-- Write a solution to find the IDs of the users who visited without making any transactions
-- and the number of times they made these types of visits

SELECT v.customer_id, COUNT(DISTINCT v.visit_id) AS count_no_trans
FROM Visits v
LEFT JOIN Transactions t ON v.visit_id = t.visit_id
WHERE t.transaction_id IS NULL
GROUP BY v.customer_id;
