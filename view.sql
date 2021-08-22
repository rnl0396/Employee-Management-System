CREATE VIEW v_allEmployees AS 
SELECT  employee.ID, employee.FIRST_NAME, employee.LAST_NAME,employee.MANAGER_ID, team_role.TITLE, team_role.SALARY, department.DEPARTMENT_NAME
FROM employee
LEFT JOIN role ON employee.ROLE_ID=team_role.ID
LEFT JOIN department ON team_role.DEPARTMENT_ID=department.ID
ORDER BY employee.ID;


SELECT * FROM v_allEmployees;