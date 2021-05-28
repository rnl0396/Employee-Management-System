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

CREATE TABLE team_role (
  -- Create a numeric column called "id" which automatically increments and cannot be null --
  ID INT NOT NULL AUTO_INCREMENT,
  -- Make a string column called "title" which cannot contain null --
  TITLE VARCHAR (30) NOT NULL,
  -- Make an integer column called "salary" --
  SALARY DECIMAL(8,2) NULL,
  -- Set the primary key of the table to id --
  PRIMARY KEY (ID)
);

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
