-- 1378. Replace Employee ID with the unique identifier
-- Write a solution to show the unique ID of each iser, if a user does not have
-- a unique ID replace just show null. Return the result table in any order.

-- Create Employees table
CREATE TABLE employees(
    id int,
    name varchar
);

-- Insert data into Employees table

INSERT INTO employees(id,name)
VALUES
(1,'Alice'),
(7,'Bob'),
(11,'Meir'),
(90,'Winston'),
(3,'Jonathan');

-- Create EmployeeUNI table

CREATE TABLE EmployeeUNI(
    id int,
    unique_id int
);

-- Insert data into the EmployeeUNI table

INSERT INTO EmployeeUNI(id,unique_id)
VALUES
(3,1),
(11,2),
(90,3);

-- Query

SELECT unique_id,name
FROM Employee e
LEFT JOIN EmployeeUNI eu ON e.id = eu.id;