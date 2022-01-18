CREATE TABLE new_student (
    student_id INT,
    name VARCHAR(20),
    major VARCHAR(20) DEFAULT 'undecided',
    PRIMARY KEY(student_id)
);
-- DROP TABLE student;
-- ALTER TABLE new_student ADD gpa DECIMAL(3,2); 
-- -- ALTER TABLE new_student DROP COLUMN gpa;
-- ALTER TABLE new_student ADD cgpa DECIMAL(5,4);
DESCRIBE new_student;
SELECT * FROM new_student;
INSERT INTO new_student VALUES(2, 'Amola', 'CSE');
INSERT INTO new_student VALUES(4, 'Sahaj', 'EnTC');
INSERT INTO new_student VALUES(5, 'Vanshika', 'Mech');
INSERT INTO new_student VALUES(6, 'Rehan', 'Mech');

DROP TABLE new_student;
CREATE TABLE stud_data(
    student_id INT,
    name VARCHAR(20) UNIQUE NOT NULL,
    major VARCHAR(20) NOT NULL,
    PRIMARY KEY(student_id)
);
DESCRIBE stud_data;
SELECT * FROM stud_data;
INSERT INTO stud_data VALUES(1, 'Piyush', 'CSE');
INSERT INTO stud_data VALUES(2, 'Amola', 'CSE');
INSERT INTO stud_data VALUES(3, 'Agat', 'Mech');
INSERT INTO stud_data VALUES(4, 'Anam', 'CSE');
INSERT INTO stud_data VALUES(5, 'Sahaj', 'Mech');
INSERT INTO stud_data VALUES(6, 'Vanshika', 'Mech');

UPDATE stud_data
SET major = 'Computer Science'
WHERE major = 'CSE';

UPDATE stud_data
SET major = 'Civil'
WHERE student_id%3=0;

INSERT INTO stud_data VALUES(7, 'Rishi', 'Bakchodi');
INSERT INTO stud_data VALUES(8, 'Raghav', 'Stalker');

UPDATE stud_data
SET major = 'Chutiyapa'
WHERE major = 'Bakchodi' OR major = 'Stalker';

UPDATE stud_data
SET name = 'BhomRishi', major = 'Bakchodi'
WHERE student_id = 7;

DELETE FROM stud_data
WHERE name = "Agat";

SELECT name, major
FROM stud_data;

SELECT stud_data.name, stud_data.major
FROM stud_data
ORDER BY name;

INSERT INTO stud_data VALUES(9, 'Nushka', 'Maushi');
INSERT INTO stud_data VALUES(10, 'Simnu', 'Maa');

SELECT stud_data.name, stud_data.major
FROM stud_data
ORDER BY name DESC;

SELECT stud_data.name, stud_data.major
FROM stud_data
ORDER BY student_id ASC;

SELECT * 
FROM stud_data
WHERE major <> "Computer Science";

-- <, >, <=, >=, =, <>(not equal to), AND, OR

SELECT *
FROM stud_data
ORDER BY name ASC;

SELECT *
FROM stud_data
WHERE name IN ('Piyush', 'Anam', 'Sahaj') AND student_id > 3;

DROP TABLE stud_data;

CREATE TABLE employee(
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    birth_day DATE,
    sex VARCHAR(1),
    salary INT,
    super_id INT,
    branch_id INT
);

DESCRIBE employee;
SELECT * FROM employee;

CREATE TABLE branch(
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(20),
    mgr_id INT,
    mgr_start_date DATE,
    FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL
);

ALTER TABLE employee
ADD FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL;

ALTER TABLE employee
ADD FOREIGN KEY(super_id) REFERENCES employee(emp_id) ON DELETE SET NULL;

CREATE TABLE client(
    client_id INT PRIMARY KEY,
    client_name VARCHAR(40),
    branch_id INT, 
    FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL
);

CREATE TABLE works_with(
    emp_id INT, 
    client_id INT,
    total_sales INT,
    PRIMARY KEY(emp_id, client_id),
    FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
    FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE
);

CREATE TABLE branch_supplier (
  branch_id INT,
  supplier_name VARCHAR(40),
  supply_type VARCHAR(40),
  PRIMARY KEY(branch_id, supplier_name),
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);

-- Corporate
INSERT INTO employee VALUES(100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL);

INSERT INTO branch VALUES(1, 'Corporate', 100, '2006-02-09');

UPDATE employee
SET branch_id = 1
WHERE emp_id = 100;

INSERT INTO employee VALUES(101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);

-- Scranton
INSERT INTO employee VALUES(102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL);

INSERT INTO branch VALUES(2, 'Scranton', 102, '1992-04-06');

UPDATE employee
SET branch_id = 2
WHERE emp_id = 102;

INSERT INTO employee VALUES(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO employee VALUES(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
INSERT INTO employee VALUES(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);

-- Stamford
INSERT INTO employee VALUES(106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL);

INSERT INTO branch VALUES(3, 'Stamford', 106, '1998-02-13');

UPDATE employee
SET branch_id = 3
WHERE emp_id = 106;

INSERT INTO employee VALUES(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO employee VALUES(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);


-- BRANCH SUPPLIER
INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'J.T. Forms & Labels', 'Custom Forms');
INSERT INTO branch_supplier VALUES(3, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(3, 'Stamford Lables', 'Custom Forms');

-- CLIENT
INSERT INTO client VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES(401, 'Lackawana Country', 2);
INSERT INTO client VALUES(402, 'FedEx', 3);
INSERT INTO client VALUES(403, 'John Daly Law, LLC', 3);
INSERT INTO client VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES(405, 'Times Newspaper', 3);
INSERT INTO client VALUES(406, 'FedEx', 2);

-- WORKS_WITH
INSERT INTO works_with VALUES(105, 400, 55000);
INSERT INTO works_with VALUES(102, 401, 267000);
INSERT INTO works_with VALUES(108, 402, 22500);
INSERT INTO works_with VALUES(107, 403, 5000);
INSERT INTO works_with VALUES(108, 403, 12000);
INSERT INTO works_with VALUES(105, 404, 33000);
INSERT INTO works_with VALUES(107, 405, 26000);
INSERT INTO works_with VALUES(102, 406, 15000);
INSERT INTO works_with VALUES(105, 406, 130000);

SELECT * FROM employee;

SELECT * 
FROM employee
ORDER BY salary;

SELECT * 
FROM employee
ORDER BY sex, first_name, last_name;

SELECT * 
FROM employee
LIMIT 5;

SELECT first_name, last_name
FROM employee;

SELECT DISTINCT sex, branch_id
FROM employee;

-- functions
SELECT COUNT(emp_id)
FROM employee;

SELECT COUNT(emp_id)
FROM employee
WHERE sex = 'F' AND birth_day > '1970-01-01';

SELECT AVG(salary)
FROM employee;

SELECT AVG(salary)
FROM employee
WHERE sex = 'M';

SELECT SUM(salary)
FROM employee;

SELECT COUNT(sex), sex
FROM employee
GROUP BY sex;

SELECT SUM(total_sales), emp_id
FROM works_with
GROUP BY emp_id;

-- wildcards
-- % = any # characters, _ = one character 

--find any client's who are an llc
SELECT *
FROM client
WHERE client_name LIKE '%LLC';

SELECT *
FROM branch_supplier 
WHERE supplier_name LIKE '% Lable%';

SELECT * 
FROM employee 
WHERE birth_day LIKE '____-10-__';

--UNION
--find the list of employee and branch name
SELECT first_name 
FROM employee 
UNION 
SELECT branch_name 
FROM branch
UNION 
SELECT client_name 
FROM client;

--find the list of all money spent or earned by the company
SELECT salary 
FROM employee 
UNION 
SELECT total_sales
FROM works_with;

--JOIN
--it is used to join two tables which have a single column similar

--find all the branches and the name of their managers
SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee
JOIN branch
ON employee.emp_id = branch.mgr_id;

SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee
LEFT JOIN branch --from LEFT JOIN, we included all the employees from the employee table, as its the left table
ON employee.emp_id = branch.mgr_id;

SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee
RIGHT JOIN branch
ON employee.emp_id = branch.mgr_id;

--nested queries
--Find name of all the employees who have sold over 30000 to a single client
SELECT employee.first_name, employee.last_name
FROM employee
WHERE employee.emp_id IN (
    SELECT works_with.emp_id
    FROM works_with
    WHERE works_with.total_sales > 30000
);

--find all the clients who are handeled by the branch that Micheal Scott manages
--Assume you know Scott's id
SELECT client.client_name
FROM client
WHERE client.branch_id = (
    SELECT branch.branch_id
    FROM branch
    WHERE branch.mgr_id = 102
    LIMIT 1 --if micheal was handeling multiple branches and we want the data of only single branch
);

--On Delete
--Two Types 
--On Delete set value to Null
--On Delete Cascade

--Remember while joining foreign key of employee with branch table 
--we set on delete set null
DELETE FROM employee
WHERE emp_id = 102;

SELECT * FROM branch; --after deleting Micheal Scott there is a null at Scranton
SELECT * FROM employee;

--Remember while joining branch supplier with branch we setted ON DELETE CASCADE
DELETE FROM branch
WHERE branch_id = 2;
SELECT * from branch_supplier;
--when the foreign key is also a primary key then there must be on delete cascade otherwise there will be trouble

--TRIGGERS
-- DELIMITER $$
-- CREATE
--     TRIGGER my_trigger BEFORE INSERT
--     ON employee
--     FOR EACH ROW BEGIN
--         INSERT INTO trigger_test VALUES('added new employee');
--     END$$
-- DELIMITER ;

SELECT * FROM employee;

--study triggers