-- 1934. Confirmation Rate

CREATE TABLE signups(
    user_id int,
    time_stamp date
);

--Create custom ENUM type
CREATE TYPE confirmation_type_enum AS ENUM ('confirmed', 'timeout');

CREATE TABLE confirmations(
    user_id int,
    time_stamp date,
    action confirmation_type_enum
);

INSERT INTO signups(user_id,time_stamp)
VALUES
(3,'2020-03-21 10:16:13'),
(7,'2020-01-04 13:57:59'),
(2,'2020-07-29 23:09:44'),
(3,'2020-12-09 10:39:37');

INSERT INTO confirmations(user_id,time_stamp,action)
VALUES
(3,'2021-01-06 03:30:46','timeout'),
(3,'2021-07-14 14:00:00','timeout'),
(7,'2021-06-12 11:57:29','confirmed'),
(7,'2021-06-13 12:58:28','confirmed'),
(7,'2021-06-14 13:59:27','confirmed'),
(2,'2021-01-22 00:00:00','confirmed'),
(2,'2021-02-28 23:59:59','timeout');

--Write a solution to find the confirmation rate of each user
--The confirmation rate of a user is the number of 'confirmed' messages
--divided by the total number of requested confirmation messages. The
--confirmation rate of a user that did not request any confirmation messages
-- is '0'. Round the confirmation rate to two decimal places.

SELECT 
    s.user_id,
    ROUND(
        COALESCE(
            SUM(CASE WHEN c.action = 'confirmed' THEN 1 ELSE 0 END)::NUMERIC
            /NULLIF(COUNT(c.user_id),0),0
        ),2
    ) AS confirmation_rate
FROM signups s
LEFT JOIN confirmations c
    ON s.user_id = c.user_id
GROUP BY s.user_id;
