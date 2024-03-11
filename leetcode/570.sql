-- 570. Managers with at least 5 direct Reports

CREATE TABLE employee(
    id int,
    name varchar,
    department varchar,
    managerId int
);

INSERT INTO employee(int,name,department,managerId)
VALUES
(101,'John','A',),
(102,'Dan','A',101),
(103,'James','A',101),
(104,'Amy','A',101),
(105,'Anne','A',101),
(106,'Ron','B',101);

-- Write a solution to find managers with atleast five direct reports

SELECT name 
FROM Employee 
WHERE id IN 
(
    SELECT managerId 
    FROM Employee 
    GROUP BY managerId 
    HAVING COUNT(*) >= 5
);

