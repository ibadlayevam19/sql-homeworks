use homework5;
drop table if exists Employees;
create table Employees(
  EmployeeID int,
  Name varchar(50),
  Department varchar(50),
  Salary decimal(10,2),
  HireDate date
);
INSERT INTO Employees (EmployeeID, Name, Department, Salary, HireDate) VALUES
(1, 'Alice Johnson', 'IT', 75000.00, '2020-06-15'),
(2, 'Bob Smith', 'HR', 60000.00, '2019-03-10'),
(3, 'Charlie Brown', 'Finance', 82000.00, '2021-09-22'),
(4, 'David Wilson', 'Marketing', 72000.00, '2018-11-30'),
(5, 'Emma Davis', 'IT', 73000.00, '2022-01-05'),
(6, 'Frank Thomas', 'Sales', 65000.00, '2017-07-14'),
(7, 'Grace Martinez', 'HR', 62000.00, '2020-08-19'),
(8, 'Hannah White', 'Finance', 90000.00, '2016-05-23'),
(9, 'Ian Harris', 'Marketing', 73000.00, '2019-12-01'),
(10, 'Jack Lewis', 'IT', 85000.00, '2023-04-11'),
(11, 'Katie Clark', 'Sales', 67000.00, '2021-06-25'),
(12, 'Leo Rodriguez', 'HR', 63000.00, '2018-10-07'),
(13, 'Mia Walker', 'Finance', 88000.00, '2015-09-17'),
(14, 'Nathan Hall', 'Marketing', 73000.00, '2020-02-14'),
(15, 'Olivia Allen', 'IT', 76000.00, '2021-08-09'),
(16, 'Paul King', 'Sales', 64000.00, '2017-04-05'),
(17, 'Quinn Scott', 'HR', 64000.00, '2022-12-18'),
(18, 'Rachel Adams', 'Finance', 91000.00, '2016-07-21'),
(19, 'Samuel Carter', 'Marketing', 74000.00, '2019-05-29'),
(20, 'Tina Gonzalez', 'IT', 77000.00, '2023-01-12');

select* from Employees;
--task1
select *, row_number() over(order by salary) as Salary_rank from Employees order by employeeID;
--task2
select *, dense_rank() over(order by salary desc) as same_sal from  Employees order by EmployeeID;
--task3
--this code finds 2 highest salary, they can have dublicates
select * from (select *, dense_rank() over(partition by department order by salary desc) as s_rank from employees) tbl where s_rank=1 or s_rank=2;
--task4
select * from (select *, dense_rank() over(partition by department order by salary) as s_rank from employees) tbl where s_rank=1;
--task5
select name,department, salary,  sum(salary) over(partition by department order by EmployeeID) as total from Employees;
--task6
select distinct department, sum(salary) over(partition by department) as total from Employees;
--task7
select distinct department, cast(avg(salary)  over(partition by department) as dec(10,2))as average from Employees;
--task8
select *, abs(salary-avg(salary) over(partition by department)) as difference from Employees;
--task9
select *, cast(avg(salary) over(order by salary rows between 1 preceding and 1 following) as dec(10,2)) as moving_avg from Employees;
--task10
select sum(salary) from (select * from Employees order by HireDate desc offset 0 row fetch next 3 rows only)tbl; 
--task11
select *, cast(avg(salary) over(order by EmployeeID) as dec(10,2)) as running_avg from Employees;
--task12
select *, max(salary) over(order by EmployeeID rows between 2 preceding and 2 following) as maximumof5 from Employees;
--task13
select*, cast(salary/sum(salary) over(partition by department) as dec(10,2)) as portion_to_department from Employees;