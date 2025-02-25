use homework6;
drop table if exists Departments;
create table Departments(
   DepartmentID int primary key,
   DepartmentName varchar(50)
);
insert into departments
values
   (101, 'IT'),
   (102, 'HR'),
   (103, 'Finance'),
   (104, 'Marketing');

drop table if exists Employees;
create table Employees(
   EmployeeID int primary key,
   Name varchar(20),
   DepartmentID int foreign key references Departments(DepartmentID),
   Salary int
);
insert into Employees
values
   (1, 'Alice', 101, 60000),
   (2, 'Bob', 102, 70000),
   (3, 'Charlie', 101, 65000),
   (4, 'David', 103, 72000),
   (5, 'Eva', null, 68000);

drop table if exists Projects;
create table Projects(
   ProjectID int primary key,
   ProjectName varchar(50),
   EmployeeID int foreign key references Employees(EmployeeID)
);
insert into Projects
values
   (1, 'Alpha', 1),
   (2, 'Beta', 2),
   (3, 'Gamma', 1),
   (4, 'Delta', 4),
   (5, 'Omega', null);
--inner join
select Employees.Name as Name,
Departments.DepartmentName as Department
from Employees inner join Departments
on Employees.departmentID=Departments.departmentID;

--left join
select Employees.Name as Name,
Departments.DepartmentName as Department
from Employees left join Departments
on Employees.departmentID=departments.departmentID;

--right join
select Departments.DepartmentName as Department,
Employees.Name as Name
from Employees right join Departments
on Employees.DepartmentID=departments.departmentId;

--full outer join
select Employees.Name as Name,
Departments.departmentName as Department
from Employees full outer join Departments
on employees.departmentID=departments.departmentID;

--join with aggregation
select distinct Departments.DepartmentName as Department,
sum(salary) over(partition by departments.departmentName) as Total_for_dep
from Employees right join Departments
on Employees.DepartmentID=departments.departmentId;

--cross join
select departments.departmentName as Department,
projects.projectname as Project
from Departments cross join projects;

--multiple joins
select Employees.Name  as Name,
Projects.ProjectName as Project,
Departments.DepartmentName as Department
from Employees  left join Projects
on Employees.EmployeeID=Projects.EmployeeID left join Departments on 
employees.DepartmentId=Departments.DepartmentId;


