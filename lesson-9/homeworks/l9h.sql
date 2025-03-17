use homework9;
--task1
drop table if exists Employees;
create table Employees(
	EmployeeID int primary key,
	ManagerID int null,
	JobTitle varchar(100) not null
);
insert into Employees (EmployeeiD, ManagerID, JobTitle)
values
    (1001, NULL, 'President'),
	(2002, 1001, 'Director'),
	(3003, 1001, 'Office Manager'),
	(4004, 2002, 'Engineer'),
	(5005, 2002, 'Engineer'),
	(6006, 2002, 'Engineer'); 
with cte as (
select *, 0 as Depth from Employees where managerid is null 
union all
select e.*, Depth+1 from cte join Employees e on cte.employeeid=e.managerid
)
select * from cte;

--task2
with cte as(
select 1 as Num, 1 as Factorial
union all
select Num+1 , Factorial*(Num+1) from cte
where Num<10
)
select Num, Factorial from cte;

--task3
with cte(n, prev, Fibonacci_Number) as(
select 1 as n, 0 as prev, 1 as Fibonacci_Number
union all
select n+1, Fibonacci_Number, Fibonacci_Number+prev from cte
where  n<10
)
select n, Fibonacci_Number from cte;

