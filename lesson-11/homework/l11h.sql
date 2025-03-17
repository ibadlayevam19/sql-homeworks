use homework11;
--task1
drop table if exists Employees;
create table Employees(
	EmployeeID int primary key,
	Name varchar(50),
	Department varchar(50),
	Salary int
);
insert into Employees
values 
	(1, 'Alice', 'HR', 5000),
	(2, 'Bob', 'IT', 7000),
	(3, 'Charlie', 'Sales', 6000),
	(4, 'David', 'HR', 5500),
	(5, 'Emma', 'IT', 7200);
create table #EmployeeTransfers(
	EmployeeID int primary key,
	Name varchar(50),
	Department varchar(50),
	Salary int
);
update Employees
set Department=(
case 
	when department='HR' then 'IT'
	when department='IT' then 'Sales'
	when department='Sales' then 'HR'
end
);

insert into #EmployeeTransfers
select * from Employees;

select * from #EmployeeTransfers;

--task2
drop table if exists Orders_DB1;
create table Orders_DB1(
	OrderID int primary key,
	CustomerName varchar(50),
	Product varchar(50),
	Quantity int
);
insert into Orders_DB1
values 
	(101, 'Alice', 'Laptop', 1),
	(102, 'Bob', 'Phone', 2),
	(103, 'Charlie', 'Tablet', 1),
	(104, 'David', 'Monitor', 1);

drop table if exists Order_DB2;
create table Orders_DB2(
	OrderID int primary key,
	CustomerName varchar(50),
	Product varchar(50),
	Quantity int
);
insert into Orders_DB2
values
	(101, 'Alice', 'Laptop', 1),
	(103, 'Charlie', 'Tablet', 1);

declare @MissingOrders table(
    OrderID int primary key,
	CustomerName varchar(50),
	Product varchar(50),
	Quantity int
);
insert into @MissingOrders
select OrderID, CustomerName, Product, Quantity from (
select d1.OrderID, d1.CustomerName, d1.Product, d1.Quantity 
from Orders_DB1 d1 left join Orders_DB2 d2
on d1.OrderID=d2.OrderID
where d2.OrderID is null)tbl;

select * from @MissingOrders;

--task3
drop table if exists WorkLog;
create table WorkLog(
EmployeeID int,
EmployeeName varchar(50),
Department varchar(50),
WorkDate date,
HoursWorked int
);
insert into WorkLog
values 
(1, 'Alice', 'HR', '2024-03-01', 8),
(2, 'Bob', 'IT', '2024-03-01', 9),
(3, 'Charlie', 'Sales', '2024-03-02', 7),
(1, 'Alice', 'HR', '2024-03-03', 6),
(2, 'Bob', 'IT', '2024-03-03', 8),
(3, 'Charlie', 'Sales', '2024-03-04', 9);

alter view vw_MonthlyWorkSummary as
with WorkSum as(
	select distinct db.EmployeeID, db.EmployeeName, db.Department, sum(HoursWorked) as TotalHoursWorked
	from homework11.dbo.WorkLog db
	group by db.EmployeeID, db.EmployeeName, db.Department),
DeptSum as (
	select distinct Department, sum(HoursWorked) as TotalHoursDepartment,
	avg(Hoursworked) as AvgHoursDepartment
	from Worklog
	group by Department
)
select 
	ws.EmployeeID,
	ws.EmployeeName,
	ws.Department,
	ws.TotalHoursWorked,
	ds.TotalhoursDepartment,
	ds.AvgHoursDepartment
from WorkSum ws join DeptSum ds
on ws.department=ds.department;


select * from vw_MonthlyWorkSummary;

