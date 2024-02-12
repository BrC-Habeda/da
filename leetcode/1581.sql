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
