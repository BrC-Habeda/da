-- Create the departments table
CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(50)
);

-- Insert dummy data into the departments table
INSERT INTO departments (department_name) VALUES
    ('HR'),
    ('Finance'),
    ('Engineering'),
    ('Marketing');

-- Create the employees table
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    department_id INT REFERENCES departments(department_id),
    hire_date DATE,
    active_employee BOOLEAN
);

-- Insert dummy data into the employees table
INSERT INTO employees (department_id, hire_date, active_employee) VALUES
    (1, '2021-01-01', true),
    (1, '2020-02-01', true),
    (2, '2022-03-01', true),
    (3, '2023-04-01', true),
    (2, '2019-05-01', false),
    (3, '2020-06-01', false),
    (1, '2023-07-01', true),
    (4, '2023-08-01', true),
    (4, '2011-09-01', false),
    (3, '2012-10-01', false);

-- Query
SELECT
    d.department_id,
    COUNT(e.employee_id) AS total_employees,
    COUNT(departures.employee_id) AS attrition_count,
    COUNT(departures.employee_id) * 1.0 / COUNT(e.employee_id) AS attrition_rate
FROM
    departments d
LEFT JOIN LATERAL (
    SELECT employee_id
    FROM employees
    WHERE employees.department_id = d.department_id
      AND employees.active_employee = false
) AS departures ON true
JOIN employees e ON e.department_id = d.department_id
WHERE e.active_employee = true
GROUP BY d.department_id
ORDER BY attrition_rate DESC
LIMIT 1;