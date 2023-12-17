-- Schema DesignAndModeling
CREATE SCHEMA IF NOT EXISTS DesignAndModeling;

-- Table DesignAndModeling.Course
CREATE TABLE IF NOT EXISTS DesignAndModeling.Course (
  CourseID VARCHAR(10) PRIMARY KEY,
  CourseName VARCHAR(100)
);

-- Domain to only accept Kenyan Numbers
CREATE DOMAIN phone_number AS VARCHAR(10)
  NOT NULL
  CHECK (VALUE ~ '^\+254\d{9}$');

-- Table DesignAndModeling.Student
CREATE TABLE IF NOT EXISTS DesignAndModeling.Student (
  StudentID SERIAL PRIMARY KEY,
  StudentName VARCHAR(100),
  DateOfBirth DATE,
  Major VARCHAR(100),
  Phone phone_number
);

-- Table DesignAndModeling.StudentCourses
CREATE TABLE IF NOT EXISTS DesignAndModeling.StudentCourses (
  EnrollmentID SERIAL PRIMARY KEY,
  StudentID BIGINT REFERENCES DesignAndModeling.Student (StudentID),
  CourseID VARCHAR(10) REFERENCES DesignAndModeling.Course (CourseID)
);

 -- Inserting data into the Student table 

INSERT INTO DesignAndModeling.Student (StudentName, DateOfBirth, Major, Phone) 
VALUES  
('John Doe', '2000-05-15', 'Computer Science', '+254705467890'), 
('Jane Smith', '2001-03-12', 'Physics', '+254745678913'), 
('Jim Bean', '1999-07-25', 'Mathematics', '+254700678925'); 

-- Inserting data into the Course table 

INSERT INTO DesignAndModeling.Course (CourseID, CourseName) 
VALUES  
('CS101', 'Introduction to Programming'), 
('PH102', 'Advanced Physics'), 
('MA103', 'Calculus II'), 
('DSC101', 'Introduction to Data Science'); 

-- Insert data into the StudentCourses table
INSERT INTO DesignAndModeling.StudentCourses (StudentID, CourseID)
VALUES
    (1, 'CS101'),
    (2, 'PH102'),
    (3, 'MA103'),
    (1, 'DSC101'),
    (2, 'MA103');

-- SELECT * data in the Student.Courses table

SELECT StudentID
FROM DesignAndModeling.StudentCourses;