-- 1633. Percentage of users attended a contest.

CREATE TABLE users(
    user_id int,
    user_name varchar
);

CREATE TABLE register(
    contest_id int,
    user_id int
);

INSERT INTO users(user_id,user_name)
VALUES
(6,'Alice'),
(2,'Bob'),
(7,'Alex');

INSERT INTO register(contest_id,user_id)
VALUES
(215,6),
(209,2),
(208,2),
(210,6),
(208,6),
(209,7),
(209,6),
(215,7),
(208,7),
(210,2),
(207,2),
(210,7);

-- Write a solution to find the users registered in each contest rounded to 2 decimals
-- Return the result table ordered by percentage in descending order. In case of a tie,
-- order it by contest_id in ascending order

WITH ContestUserCounts AS (
    SELECT contest_id, COUNT(DISTINCT user_id) AS user_count
    FROM Register
    GROUP BY contest_id
),
TotalUsers AS (
    SELECT COUNT(DISTINCT user_id) AS total_users
    FROM Users
)
SELECT c.contest_id, 
       ROUND((c.user_count * 100.0 / t.total_users), 2) AS percentage
FROM ContestUserCounts c, TotalUsers t
ORDER BY percentage DESC, c.contest_id;