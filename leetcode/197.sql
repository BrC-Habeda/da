-- 197. Rising Temperature

CREATE TABLE weather(
    id int,
    recordDate date,
    temperature int
);

INSERT INTO weather(id,recordDate,temperature)
VALUES
(1,'2015-01-01',10),
(2,'2015-01-02',25),
(3,'2015-01-03',20),
(4,'2015-01-04',30);

-- Write a solution to find all the dates' Id with higher
--temperature compared to its previous dates (yesterday)

SELECT w1.id
FROM weather w1
JOIN weather w2 ON w1.recordDate = w2.recordDate + INTERVAL '1 day'
WHERE w1.temperature > w2.temperature;

