-- Drops the employee_tracker if it exists currently --
DROP DATABASE IF EXISTS employee_tracker;
-- Creates the "employee_tracker" database --
CREATE DATABASE employee_tracker;

-- Make it so all of the following code will affect employee_tracker --
USE employee_tracker;

-- Creates the table "department" within employee_tracker --
CREATE TABLE department (
  -- Create a numeric column called "id" which automatically increments and cannot be null --
  ID INT NOT NULL AUTO_INCREMENT,
  -- Make a string column called "department name" which cannot contain null --
  DEPARTMENT_NAME VARCHAR (30) NOT NULL,
  -- Set the primary key of the table to id --
  PRIMARY KEY (ID)
);

INSERT INTO department (DEPARTMENT_NAME) VALUES ("Legal"); 
INSERT INTO department (DEPARTMENT_NAME) VALUES ("Finance");
INSERT INTO department (DEPARTMENT_NAME) VALUES ("Human Resources");
INSERT INTO department (DEPARTMENT_NAME) VALUES ("Communications");

CREATE TABLE team_role (
  -- Create a numeric column called "id" which automatically increments and cannot be null --
  ID INT NOT NULL AUTO_INCREMENT,
  -- Make a string column called "title" which cannot contain null --
  TITLE VARCHAR (30) NOT NULL,
  -- Make an integer column called "salary" --
  SALARY DECIMAL(8,2) NULL,
  -- Department
  DEPARTMENT_ID INT,
  -- Set the primary key of the table to id --
  PRIMARY KEY (ID)
);

INSERT INTO team_role (TITLE, SALARY, DEPARTMENT_ID) VALUES ("Senior Vice President",110000,4); 
INSERT INTO team_role (TITLE, SALARY, DEPARTMENT_ID) VALUES ("Counsel",50000,1); 
INSERT INTO team_role (TITLE, SALARY, DEPARTMENT_ID) VALUES ("Auditor",90000,2); 
INSERT INTO team_role (TITLE, SALARY, DEPARTMENT_ID) VALUES ("Manager",70000,3); 
INSERT INTO team_role (TITLE, SALARY, DEPARTMENT_ID) VALUES ("Accountant",80000,2); 
INSERT INTO team_role (TITLE, SALARY, DEPARTMENT_ID) VALUES ("Designer",75000,4); 




CREATE TABLE employee (
   -- Create a numeric column called "id" which automatically increments and cannot be null --
  ID INT NOT NULL AUTO_INCREMENT,
  -- Make a string column called "first name" which cannot contain null --
  FIRST_NAME VARCHAR (30) NOT NULL,
  -- Make a string column called "last name" which cannot contain null --
  LAST_NAME VARCHAR (30) NOT NULL,
  -- Make an integer column called "role id" --
  ROLE_ID INT,
  -- Make an integer column called "manager id" --
  MANAGER_ID INT,
  -- Set the primary key of the table to id --
  PRIMARY KEY (ID)
);

INSERT INTO employee (FIRST_NAME, LAST_NAME, ROLE_ID, MANAGER_ID) VALUES ("Christina","Kolbjornsen",4,3016); 
INSERT INTO employee (FIRST_NAME, LAST_NAME, ROLE_ID, MANAGER_ID) VALUES ("John","Smith",1,4567); 
INSERT INTO employee (FIRST_NAME, LAST_NAME, ROLE_ID, MANAGER_ID) VALUES ("Karla","Cobreiro",2,3421); 
INSERT INTO employee (FIRST_NAME, LAST_NAME, ROLE_ID, MANAGER_ID) VALUES ("Daniel","Tapia",2,1256); 
INSERT INTO employee (FIRST_NAME, LAST_NAME, ROLE_ID, MANAGER_ID) VALUES ("Gus","Escobar",4,null); 
INSERT INTO employee (FIRST_NAME, LAST_NAME, ROLE_ID, MANAGER_ID) VALUES ("Rob","Lemus",3,3454); 
INSERT INTO employee (FIRST_NAME, LAST_NAME, ROLE_ID, MANAGER_ID) VALUES ("Alex","Fischer",3,5643); 


SELECT  employee.ID, employee.FIRST_NAME, employee.LAST_NAME,employee.MANAGER_ID, role.title, role.salary, department.name
FROM employee 
LEFT JOIN role ON employee.role_id=role.id
LEFT JOIN department ON role.department_id=department.id
ORDER BY employee.id;


--BY MANAGER 
SELECT employee.id, employee.first_name, employee.last_name, employee.manager_id, team_role.title, team_role.SALARY, team_role.DEPARTMENT_ID AS Department, CONCAT(m.first_name, " ", m.last_name) AS Manager 
FROM employee
LEFT JOIN role ON employee.ROLE_ID = role.ID
INNER JOIN department ON role.DEPARTMENT_ID = department.ID 
INNER JOIN employee m ON employee.MANAGER_ID = m.id WHERE CONCAT(m.first_name, " ", m.last_name) IN ('Christina Kolbjornsen')
GROUP BY employee.ID;

--BY DEPARTMENT--
SELECT employee.ID, CONCAT(employee.first_name," ", employee.last_name) AS FullName, department.DEPARTMENT_NAME AS department
 FROM employee 
 LEFT JOIN role on employee.ROLE_ID = role.ID
 LEFT JOIN department on role.DEPARTMENT_ID = department.ID