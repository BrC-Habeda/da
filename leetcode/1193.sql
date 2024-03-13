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
