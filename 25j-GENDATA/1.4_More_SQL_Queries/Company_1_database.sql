CREATE DATABASE Company_1;

USE Company_1;

CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(40),
    last_name VARCHAR(40),
    birth_day DATE,
    sex VARCHAR(1),
    salary INT,
    super_id INT,
    branch_id INT
);

CREATE TABLE branch (
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(40),
    mgr_id INT,
    mgr_start_date DATE,
    FOREIGN KEY (mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL
);

ALTER TABLE employee
ADD CONSTRAINT fk_branch
FOREIGN KEY (branch_id)
REFERENCES branch(branch_id)
ON DELETE SET NULL;

ALTER TABLE employee
ADD CONSTRAINT fk_supervisor
FOREIGN KEY (super_id)
REFERENCES employee(emp_id)
ON DELETE SET NULL;

CREATE TABLE client (
    client_id INT PRIMARY KEY,
    client_name VARCHAR(40),
    branch_id INT,
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL
);

CREATE TABLE works_with (
    emp_id INT,
    client_id INT,
    total_sales INT,
    PRIMARY KEY(emp_id, client_id),
    FOREIGN KEY (emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
    FOREIGN KEY (client_id) REFERENCES client(client_id) ON DELETE CASCADE
);

CREATE TABLE branch_supplier (
    branch_id INT,
    supplier_name VARCHAR(40),
    supply_type VARCHAR(40),
    PRIMARY KEY(branch_id, supplier_name),
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);

-- Insert Data
-- Corporate Branch and Employees
INSERT INTO employee VALUES (100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL);

INSERT INTO branch VALUES (1, 'Corporate', 100, '2006-02-09');

-- ALTER TABLE employee
UPDATE employee SET branch_id = 1 WHERE emp_id = 100;

INSERT INTO employee VALUES (101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);

SELECT * FROM Employee;

-- Scranton Branch and Employees
INSERT INTO employee VALUES (102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL);
INSERT INTO branch VALUES (2, 'Scranton', 102, '1992-04-06');
UPDATE employee SET branch_id = 2 WHERE emp_id = 102;

INSERT INTO employee VALUES (103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO employee VALUES (104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
INSERT INTO employee VALUES (105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);

-- -- Stamford Branch & Employees
INSERT INTO employee VALUES (106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL);
INSERT INTO branch VALUES (3, 'Stamford', 106, '1998-02-13');
UPDATE employee SET branch_id = 3 WHERE emp_id = 106;

INSERT INTO employee VALUES (107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO employee VALUES (108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);

-- Insert Branch Suppliers
INSERT INTO branch_supplier (branch_id, supplier_name, supply_type) VALUES
(2, 'Hammer Mill', 'Paper'),
(2, 'Uni-ball', 'Writing Utensils'),
(2, 'J.T. Forms & Labels', 'Custom Forms'),
(3, 'Patriot Paper', 'Paper'),
(3, 'Uni-ball', 'Writing Utensils'),
(3, 'Hammer Mill', 'Paper'),
(3, 'Stamford Lables', 'Custom Forms');

-- Insert Clients
INSERT INTO client (client_id, client_name, branch_id) VALUES
(400, 'Dunmore Highschool', 2),
(401, 'Lackawana Country', 2),
(402, 'FedEx', 3),
(403, 'John Daly Law, LLC', 3),
(404, 'Scranton Whitepages', 2),
(405, 'Times Newspaper', 3),
(406, 'FedEx', 2);

-- Insert Works_With Data
INSERT INTO works_with (emp_id, client_id, total_sales) VALUES
(105, 400, 55000),
(102, 401, 267000),
(108, 402, 22500),
(107, 403, 5000),
(108, 403, 12000),
(105, 404, 33000),
(107, 405, 26000),
(102, 406, 15000),
(105, 406, 130000);

SELECT * FROM employee;
SELECT * FROM branch;
SELECT * FROM client;
SELECT * FROM works_with;
SELECT * FROM branch_supplier;

#1. Find all employees odered by salary
SELECT * FROM employee
ORDER BY salary DESC;

#2. Find all employees ordered by sex and name
SELECT * FROM employee
ORDER BY sex, first_name;

#3. Find all distict values for gender
SELECT DISTINCT sex
FROM employee;

-- 4. Find all the employees born after 1969
SELECT emp_id, first_name, last_name
FROM employee
WHERE birth_day >= 1970-01-01;

-- 5. Find all employees who are female and born after 1969 or earn more than 80,000
SELECT * FROM employee
WHERE (birth_day >= 1970-01-01 AND sex = 'F') OR salary > 80000;

#Aggregate functions
-- 1. Find the number of employees
SELECT COUNT(emp_id)
FROM employee;

-- 2. How many males and females do we have
SELECT COUNT(sex) Gender
FROM employee
GROUP BY sex;

-- 3. Find the average salary of all employees
SELECT AVG(salary)
FROM employee
WHERE sex = 'M';

-- 4. Total sales of each salesman
SELECT SUM(total_sales), emp_id
FROM works_with
GROUP BY emp_id;

-- 5. Total sales for each client
SELECT SUM(total_sales), client_id
FROM works_with
GROUP BY client_id;

#Wildcards
-- % any # of characters , _ = one character
-- 1. Find any client's who are an LLC
SELECT * FROM client
WHERE client_name LIKE '%LLC';

-- 2. Any branch supplier in the label business
SELECT * FROM branch_supplier
WHERE supplier_name LIKE '%labels';

-- 3. Any employee born in October
SELECT * FROM employee
WHERE birth_day LIKE '____-10%';

-- 4. Find any clients who are schools
SELECT * FROM client
WHERE client_name LIKE 'Times%';

#UNION
-- 1. Find a list of all employees and their branch names
SELECT first_name AS Company_Names
FROM employee
UNION
SELECT branch_name 
FROM branch;

-- 2. All clients and the branch supplier names
SELECT client_name AS Client_Supplier, branch_id
FROM client
UNION
SELECT supplier_name, branch_id
FROM branch_supplier;

-- 3. List of all money spent or earned by the company
SELECT salary
FROM employee
UNION
SELECT total_sales
FROM works_with;

# JOINS
-- Add the extra branch
INSERT INTO branch VALUES(4, "Buffalo", NULL, NULL);
SELECT * FROM branch;

-- 1. List all branches and the names of their managers
SELECT e.emp_id, e.first_name, b.branch_name
FROM employee e
RIGHT JOIN branch b
ON e.emp_id = b.mgr_id;

-- 2. List all employees and the branches they work in
SELECT e.first_name, e.last_name, b.branch_name
FROM employee e
JOIN branch b
ON e.branch_id = b.branch_id;






