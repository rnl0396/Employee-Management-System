const mysql = require('mysql');
const inquirer = require('inquirer');

var connection = mysql.createConnection({
  host     : 'localhost',
  port: 3306,
  user     : 'root',
  password : 'CoderRob2021!Moch',
  database : 'employee_tracker.db'
});
 
connection.connect();



function start() {

    inquirer.prompt({
        name: "action",
        type: "list",
        message: "Hello, please select an action from the following list of items",
        choices: [
            "View Employees",
            "View Departments",
            "Add Department",
            "Add Employee",
            "Remove Department",
            "Remove Employee",
            "Update Employee Role",
            "Update Employee Salary",
            "Update Employee Department",
            "Quit"
        ]
    }).then(function (answer) {
        switch(answer.action) {
            case "View Employees":
                viewEmployees();
                break;

            case "View Departments":
                viewDepartments();
                break;

            case "Add Department":
                addDepartment();
                break;

            case "Add Employee":
                addEmployee();
                break;
            
            case "Remove Department":
                removeDepartment();
                break;

            case "Remove Employee":
                removeEmployee();
                break;

            case "Update Employee Role":
                updateEmployeeRole();
                break;

            case "Quit":
                quit();
                break;

            default:
                return "Nothing to see here"
        }
    });
}



connection.query((err) => {
  if (error) throw error;
  console.log("Connected as ID " + connection.threadId);
  start();
});


const viewEmployees = () => {
    var query = "SELECT employee.ID, employee.FIRST_NAME, employee.LAST_NAME, team_role.TITLE, department.DEPARTMENT_NAME AS department, team_role.SALARY, CONCAT(manager.FIRST_NAME, ' ', manager.LAST_NAME) AS manager FROM employee";
    query += " LEFT JOIN team_role on employee.ROLE_ID = role.ID";
    query += " LEFT JOIN department on team_role.DEPARTMENT_ID = department.ID";
    query += " LEFT JOIN employee manager on manager.ID = employee.MANAGER_ID";
    connection.query(query, function (err, res) {
        if (err) throw err;
        console.log("Employees View")
        console.table(res);
        start();
    });
};


const viewDepartments = () => {
    var query = "SELECT * FROM department";
    connection.query(query, function(err, res) {
        if (err) throw err;
        console.log("Departments")
        console.table(res);
        start();
    });
}


function addDepartment() {
    inquirer.prompt([{
        message: "Please indicate which department you wish to add",
        type: "input",
        name: "newDepartment"
    }]).then(answer => {
        connection.query(`INSERT INTO department (DEPARTMENT_NAME) VALUES ("${answer.newDepartment}")`, function (err, res) {
            if (err) throw err;
            console.log(`New department ${answer.newDepartment} has been successfully added`);
            start();
        });
    })
}

function addEmployee() {
    connection.query(`SELECT CONCAT(FIRST_NAME, " ", LAST_NAME) AS Manager, ID FROM employee`, function (err, res) {
        connection.query(`SELECT DISTINCT TITLE, ID from team_role`, function (err, data) {
            inquirer.prompt([{
                message: "Please indicate the employee's first name",
                type: "input",
                name: "FIRST_NAME"
            }, {
                message: "Please indicate the employee's last name",
                type: "input",
                name: "LAST_NAME"
            }, {
                message: "Please indicate the new employee's role",
                type: "list",
                name: 'team_role.ID',
                choices: data.map(o => ({ NAME: o.TITLE, value: o.ID }))
  
            }, {
                message: "Please indiciate who will be the employee's Manager",
                type: "list",
                name: 'manager_ID',
                choices: res.map(o => ({ NAME: o.manager, value: o.ID }))
  
            }]).then(answer => {
                connection.query(`INSERT INTO employee(FIRST_NAME, LAST_NAME, team_role_ID, manager_ID) VALUES ('${answer.FIRST_NAME}', '${answer.LAST_NAME}', ${answer.team_role_ID}, ${answer.manager_ID})`, function (err, res) {
                    if (err) throw err;
                    console.log("------------")
                    console.log(`New employee ${answer.FIRST_NAME} ${answer.LAST_NAME} has been successfully added`);
                    console.log("------------")
                    start();
                });
            });
        });
    });
  };


  function removeDepartment() {
    connection.query("SELECT NAME, ID FROM department", function (err, res) {

        const departmentChoices = res.map(item => {
            return {
                name: item.NAME,
                value: item.ID
            }
        });

        inquirer.prompt([{
            message: "Please indicate which department you wish to remove",
            type: "list",
            name: "removeDepartment",
            choices: departmentChoices
        }]).then(function (answer) {

            const chooseDepartment = departmentChoices.filter(item => item.value === answer.removeDepartment);
            var query = `DELETE FROM department WHERE ID = "${answer.removeDepartment}"`;
            connection.query(query, function (err, res) {
                if (err) throw err;
                console.log(`Department ${chooseDepartment[0].name} has been successfully removed`.red);
                start();
            });
        });
    });
};

function removeEmployee() {
    var query = "SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS fullName, ID FROM employee";
    connection.query(query, async function (err, res) {

        const employeeChoices = res.map(item => {
            return {
                name: item.fullName,
                value: item.id
            }
        });

        inquirer.prompt([{

            type: "list",
            name: "employee",
            message: "Please indicate which employee you want to remove",
            choices: employeeChoice
        }]).then(function (answer) {

            const chooseUser = employeeChoices.filter(item => item.value === answer.employee);
            var query = `DELETE FROM employee WHERE id = "${answer.employee}"`;
            connection.query(query, function (err, res) {
                if (err) throw err;
                console.log(`Employee ${chooseUser[0].name} has been successfully removed`);
                start();
            });
        })
    });
};

function updateEmployeeRole() {
    connection.query(`SELECT CONCAT(FIRST_NAME, " ", LAST_NAME) AS employee, ID FROM employee`, function (err, res) {
        connection.query(`SELECT TITLE, ID from team_role`, function (err, data) {
            inquirer.prompt([{
                message: "Please indicate the name of the employee that you would like to update the role of",
                type: "list",
                name: "updateEmployee",
                choices: res.map(o => ({ name: o.Employee, value: o.id }))
            }, {
                message: "Please indicate the employee's new role",
                type: "list",
                name: 'role_ID',
                choices: data.map(o => ({ name: o.title, value: o.id }))

            }]).then(answer => {
                connection.query(`UPDATE employee SET role_id = "${answer.role_ID}" WHERE id= "${answer.updateEmployee}"`, function (err, res) {
                    if (err) throw err;
                    console.log("Employee's role has been successfully updated")

                    start();
                });
            });
        });
    });
}







connection.end();