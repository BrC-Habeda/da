-- 1193. Monthly Transactions I

--Create custom ENUM type
CREATE TYPE state_type_enum AS ENUM ('approved', 'declined');

CREATE TABLE transactions(
    id int,
    country varchar,
    state state_type_enum,
    amount int,
    trans_date date
);

INSERT INTO transactions(id,country,state,amount,trans_date)
VALUES
(121,'US','approved',1000,'2018-12-18'),
(122,'US','declined',2000,'2018-12-19'),
(123,'US','approved',2000,'2019-01-01'),
(124,'DE','approved',2000,'2019-01-07');

-- Write a query to find each month and country, the number of transactions and their
-- total amount, the number of approved transactions and their total amount

SELECT 
    TO_CHAR(DATE_TRUNC('MONTH',trans_date),'YYYY-MM') month,
    country,
    COUNT(*) trans_count,
    SUM(amount) trans_total_amount,
    COUNT(*) FILTER(WHERE state = 'approved') approved_count,
    SUM(amount) FILTER (WHERE state = 'approved') approved_total_amount
FROM
    transactions
GROUP BY
    month, country;