CREATE DATABASE school;
USE school;

CREATE TABLE student(
	student_id INT PRIMARY KEY,
    name VARCHAR(30), 
    major VARCHAR(30)
);

INSERT INTO student VALUES(2, 'Arafat', 'Databases');

INSERT INTO student(student_id, name, major) VALUES
(3, 'Anthony', 'Biology'),
(4, 'Sonia', 'Chemistry'),
(5, 'Melody', 'Physics');

INSERT INTO student(student_id, name) VALUES
(6, 'Alice');

SELECT * FROM student;

CREATE TABLE students(
	student_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(30) NOT NULL, 
    last_name VARCHAR(30) NOT NULL,
    department VARCHAR(50) NOT NULL, 
    email VARCHAR(50) UNIQUE
);

CREATE TABLE Courses(
	course_id INT PRIMARY KEY,
    course_name VARCHAR(50) NOT NULL,
    category VARCHAR(50) DEFAULT 'General'
);

CREATE TABLE Enrollments(
	enrollment_id INT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE, 
    FOREIGN KEY (student_id) REFERENCES students (student_id),
    FOREIGN KEY (course_id) REFERENCES Courses (course_id)
);

ALTER TABLE Enrollments DROP enrollment_date;

INSERT INTO students(first_name, last_name, department, email) VALUES
('John', 'Kimani', 'IT', 'john123@gmail.com'),
('Alice', 'Murengi', 'Business', 'Alice123@gmail.com'),
('Joy', 'Mwaura', 'Social', 'joy123@gmail.com'),
('Melody', 'Bonareri', 'Computer Science', 'melody123@gmail.com');

INSERT INTO Courses(course_id, course_name, category) VALUES
(101, 'Databases', 'IT'),
(102, 'Statistics', 'Business'),
(103, 'Web_Dev', 'IT'), 
(104, 'Communications', 'General');

INSERT INTO Enrollments(enrollment_id, student_id, course_id) VALUES
(1, 1, 101),
(2, 2, 103),
(3, 1, 102),
(4, 3, 104);

SELECT * FROM students;
SELECT * FROM Courses;
SELECT * FROM Enrollments;



