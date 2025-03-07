use homework8;
/*task1*/
drop table if exists Groupings;
create table Groupings(
  [Step number] int ,
  Status varchar(20)
);
insert into Groupings
values
      (1, 'Passed'),
(2	,'Passed'),
(3	,'Passed'),
(4	,'Passed'),
(5	,'Failed'),
(6	,'Failed'),
(7	,'Failed'),
(8	,'Failed'),
(9	,'Failed'),
(10	,'Passed'),
(11	,'Passed'),
(12	,'Passed');
select * from groupings;


select min([step number]) as [Min Step Number], max([step number]) as [Max Step Number], Status, count(*) as [Consecutive Count] from (
select *, sum(num) over(order by [step number] rows between unbounded preceding and 0 following) 
as groups 
from (select *, (case when status=lag(status) over (order by [step number]) then 0 else 1 end) 
as num from groupings) t1) t2 group by groups, status order by [Min Step Number];

/*task2*/
drop table if exists Employees_N;
CREATE TABLE [dbo].[EMPLOYEES_N]
(
    [EMPLOYEE_ID] [int] NOT NULL,
    [FIRST_NAME] [varchar](20) NULL,
    [HIRE_DATE] [date] NOT NULL
);
INSERT INTO [dbo].[EMPLOYEES_N] ([EMPLOYEE_ID], [FIRST_NAME], [HIRE_DATE])
VALUES 
    (1, 'Alice', '1975-06-15'),
    (2, 'Bob', '1976-09-20'),
    (3, 'Charlie', '1977-03-12'),
    (4, 'David', '1979-01-25'),
    (5, 'Emma', '1980-07-14'),
    (6, 'Frank', '1982-11-30'),
    (7, 'Grace', '1983-05-05'),
    (8, 'Henry', '1984-12-10'),
    (9, 'Ivy', '1985-08-22'),
    (10, 'Jack', '1990-03-18'),
    (11, 'Kelly', '1997-06-09'),
	(12, 'Leo', '2025-01-01'); 
select * from Employees_N;
select concat(year(hire_date)-diff+1, '-', year(hire_date)-1) from(
select *, isnull(year(Hire_date)-year(lag(hire_date) over(order by hire_date)), 0) as diff from employees_N) t1 where diff>1 and year(hire_date)-diff+1>1974;


