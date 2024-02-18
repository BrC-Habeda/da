--1280 Students and Examinations

CREATE TABLE students(
    student_id int,
    student_name varchar
);

CREATE TABLE subjects(
    subject_name varchar
);

CREATE TABLE examinations(
    student_id int,
    subject_name varchar
);

INSERT INTO students(student_id,student_name)
VALUES
(1,'Alice'),
(2,'Bob'),
(13,'John'),
(6,'Alex');

INSERT INTO subjects(subject_name)
VALUES
('Math'),
('Physics'),
('Programming');

INSERT INTO examinations(student_id,subject_name)
VALUES
(1,'Math'),
(1,'Physics'),
(1,'Programming'),
(2,'Programming'),
(1,'Physics'),
(1,'Math'),
(13,'Math'),
(13,'Programming'),
(13,'Physics'),
(2,'Math'),
(1,'Math');

-- Write a solution to find the number of times each student attended each exam.

SELECT 
    s.student_id,
    s.student_name,
    sub.subject_name,
    COALESCE(COUNT(e.subject_name), 0) AS attended_exams
FROM 
    (SELECT student_id, student_name FROM Students) s
CROSS JOIN 
    (SELECT subject_name FROM Subjects) sub
LEFT JOIN 
    Examinations e 
    ON s.student_id = e.student_id 
    AND sub.subject_name = e.subject_name
GROUP BY 
    s.student_id, s.student_name, sub.subject_name
ORDER BY 
    s.student_id, sub.subject_name;
