-- Schema DesignAndModeling
CREATE SCHEMA IF NOT EXISTS "DesignAndModeling";

-- Table DesignAndModeling.Course
CREATE TABLE IF NOT EXISTS "DesignAndModeling"."Course" (
  "CourseID" VARCHAR(10) PRIMARY KEY,
  "CourseName" VARCHAR(100)
);

-- Table DesignAndModeling.Student
CREATE TABLE IF NOT EXISTS "DesignAndModeling"."Student" (
  "StudentID" SERIAL PRIMARY KEY,
  "StudentName" VARCHAR(100),
  "DateOfBirth" DATE,
  "Major" VARCHAR(100),
  "ContactNumber" VARCHAR(15)
);

-- Table DesignAndModeling.StudentCourses
CREATE TABLE IF NOT EXISTS "DesignAndModeling"."StudentCourses" (
  "EnrollmentID" SERIAL PRIMARY KEY,
  "StudentID" BIGINT REFERENCES "DesignAndModeling"."Student" ("StudentID"),
  "CourseID" VARCHAR(10) UNIQUE REFERENCES "DesignAndModeling"."Course" ("CourseID")
);

 -- Inserting data into the Student table 

INSERT INTO Student (StudentName, DateOfBirth, Major, ContactNumber) 
VALUES  
('John Doe', '2000-05-15', 'Computer Science', '+1234567890'), 
('Jane Smith', '2001-03-12', 'Physics', '+1234567891'), 
('Jim Bean', '1999-07-25', 'Mathematics', '+1234567892'); 

-- Inserting data into the Course table 

INSERT INTO Course (CourseID, CourseName) 
VALUES  
('CS101', 'Introduction to Programming'), 
('PH102', 'Advanced Physics'), 
('MA103', 'Calculus II'), 
('DSC101', 'Introduction to Data Science'); 

-- Insert data into the StudentCourses table
INSERT INTO StudentCourses (StudentID, CourseID)
VALUES
    (1, 'CS101'),
    (2, 'PH102'),
    (3, 'MA103'),
    (1, 'DSC101'),
    (2, 'MA103');

