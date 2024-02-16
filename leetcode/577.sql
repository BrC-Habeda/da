-- 577. Employee Bonus

CREATE TABLE employee(
    empId int,
    name varchar,
    supervisor int,
    salary int
);

INSERT INTO employee (empId,name,supervisor,salary)
VALUES
(3,'Brad',null),
(1,'John',3),
(2,'Dan',3)
(4,'Thomas',3);

CREATE TABLE bonus(
    empId int,
    bonus int
);

INSERT INTO bonus(empId,bonus)
VALUES
(2,500),
(4,2000);

-- Write a solution to report the name and bonus of each employee with a bonus less than 1000

SELECT name,bonus
FROM employee e
LEFT JOIN bonus b ON e.empId = b.empId
WHERE bonus < 1000;