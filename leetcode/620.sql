-- 620. Not Boring movies

CREATE TABLE cinema(
    id int,
    movie varchar,
    description varchar,
    rating float
);

INSERT INTO cinema(id,movie,description,rating)
VALUES
(1,'War','great 3D',8.9),
(2,'Science','fiction',8.5),
(3,'Irish','boring',6.2),
(4,'Ice song','Fantasy',8.6),
(5,'House card','Interesting',9.1);

-- Write a solution to report the movies with an off-numbered ID and a description that
-- is not 'boring'
-- Return the result table ordered by rating in descending order.

WITH CTE AS (
    SELECT *, id % 2 t
    FROM cinema
)

SELECT id,movie,description,rating
FROM CTE
WHERE t != 0
    AND description != 'boring'
ORDER BY rating DESC;

