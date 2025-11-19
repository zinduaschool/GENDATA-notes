CREATE DATABASE zindua;
USE zindua;

-- 1. CREATE STUDENTS TABLE
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30),
    email VARCHAR(50) UNIQUE,
    major VARCHAR(30),
    age INT CHECK (age >= 16)
);

-- 2. CREATE COURSES TABLE
CREATE TABLE courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(50) NOT NULL,
    course_code VARCHAR(10) UNIQUE,
    credit_hours INT CHECK (credit_hours > 0)
);

-- INSERT STUDENT RECORDS
INSERT INTO students (first_name, last_name, email, major, age)
VALUES
('Alice', 'Karimi', 'alice@example.com', 'Computer Science', 20),
('Brian', 'Mutua', 'brian@example.com', 'Business', 22),
('Cynthia', 'Wanjiru', 'cynthia@example.com', 'Engineering', 19),
('Daniel', 'Omondi', 'daniel@example.com', 'Mathematics', 21),
('Esther', 'Naliaka', 'esther@example.com', 'Computer Science', 23),
('Irene', 'Chebet', 'irene@example.com', 'Chemistry', 19),
('James', 'Muriuki', 'james@example.com', 'Engineering', 25);

-- INSERT COURSE RECORDS
INSERT INTO courses (course_name, course_code, credit_hours)
VALUES
('Database Systems', 'DB101', 3),
('Web Development', 'WD201', 4),
('Accounting Basics', 'AC100', 3);

-- BASIC SELECT QUERIES
-- View all students
SELECT * FROM students;

-- View student names and majors
SELECT first_name, major FROM students;

-- View all courses
SELECT * FROM courses;

-- UPDATE EXAMPLE
UPDATE students
SET major = 'Information Technology'
WHERE student_id = 1;

-- DELETE EXAMPLE
DELETE FROM students
WHERE student_id = 3;

-- 1. Filter students by a single major
SELECT * FROM students
WHERE major = 'Computer Science';

-- 2. Filter students by multiple majors using IN
SELECT first_name, last_name, major 
FROM students
WHERE major IN('Computer Science', 'Engineering');

-- 3. Filter students by age using AND
SELECT first_name, last_name, major 
FROM students
WHERE major = 'Business' AND age > 21;

-- 5. Combine AND and OR
SELECT first_name, last_name, major 
FROM students
WHERE (major = 'Engineering' AND age > 22) OR ( major = 'Computer Science' AND age < 22);

-- 6. Use LIMIT to restrict results
SELECT * FROM students
LIMIT 3;




