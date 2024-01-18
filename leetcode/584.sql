-- 584.Find customer Referee

-- Create customer table
CREATE TABLE customer(
    id int PRIMARY KEY,
    name varchar(255),
    referee_id int
);
-- Insert data into customers table

INSERT INTO customer(id,name,referee_id)
VALUES
(1,'Will',null),
(1,'Jane',null),
(1,'Alex',2),
(1,'Bill',null),
(1,'Zack',1),
(1,'Mark',2);

-- Find the names of the customer that are not referred by the customer with id = 2

SELECT name
FROM customer 
WHERE referee_id NOT IN (2);