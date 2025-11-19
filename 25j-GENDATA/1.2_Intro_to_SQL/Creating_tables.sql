CREATE DATABASE school;
USE school;

CREATE TABLE student(
	student_id INT PRIMARY KEY,
    name VARCHAR(20),
    major VARCHAR(20)
);

DESCRIBE student;

DROP TABLE student;

ALTER TABLE student ADD gpa DECIMAL(3,2);

ALTER TABLE student DROP COLUMN gpa;

-- Insert a single record
INSERT INTO student VALUES(1, 'Susan', 'GENDATA');

-- Insert Multiple records
INSERT INTO student(student_id, name, major) VALUES
(2, 'Susan', 'GENDATA'),
(3, 'Azadi', 'Python'),
(4, 'Teddy', 'Pydata'),
(5, 'Arafat', 'GENDATA');

UPDATE student
SET major = 'Pydata'
WHERE student_id = 2;

SELECT * FROM student;
