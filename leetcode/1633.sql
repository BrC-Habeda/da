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