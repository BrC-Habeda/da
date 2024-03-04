-- 1075. Project Employees I

CREATE TABLE project(
    project_id int,
    employee_id int
);

CREATE TABLE employee(
    employee_id int,
    name varchar,
    experience_years int
);

INSERT INTO project (project_id,employee_id)
VALUES
(1,1),
(1,2),
(1,3),
(2,1),
(2,4);

INSERT INTO employee(employee_id,name,experience_years)
VALUES
(1,'Khaled',3),
(2,'Ali',2),
(3,'John',1),
(4,'Doe',2);

-- Write a SQL Query that reports the average experience years of all the employees 
-- for each project, rounded to 2 digits

SELECT
    p.project_id,
    ROUND(AVG(experience_years),2) average_years
FROM project p
JOIN employee e 
    ON p.employee_id = e.employee_id
GROUP BY project_id;