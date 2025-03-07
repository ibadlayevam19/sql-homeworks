use class6;
CREATE TABLE t
(
ID INT
,Typ VARCHAR(1)
,Value1 VARCHAR(1)
,Value2 VARCHAR(1)
,Value3 VARCHAR(1)
)
 

INSERT INTO t(ID,Typ,Value1,Value2,Value3)
VALUES
(1,'I','a','b',''),
(2,'O','a','d','f'),
(3,'I','d','b',''),
(4,'O','g','l',''),
(5,'I','z','g','a'),
(6,'I','z','g','a')
select * from t;
select  sum(type_i) over(partition by typ) from(
select *, 
iif(Value1=Value2 and value2=value3 and value3='a', 3, 
iif(value1=value2 and value2='a' or value2=value3 and value3='a' or value1=value3 and value3='a', 2,
iif((value1!=value2 and value2!=value3 and value1!=value3) and (value1='a' or value2='a' or value3='a'), 1, 0))) as type_i) tbl;

create table pq
(
    id int,
	name varchar(10),
	typed varchar(10)
);
insert into pq
values(1, 'P', Null), (1, Null, 'Q');
select * from pq;
select id,  concat(id,min(name), max(typed)) from pq group by id ;

select row_number() over (order by value) as numbers from string_split(replicate(',', 99), ',');

select *, LAG(currentquota) over(order by salesyear) from sales;
select*, lag(currentquota, 1, 0) over(order by salesyear) prevquota,
LEAD(currentquota, 1, 0) over (order by salesyear) nextquota from sales;

select *, lag(salary) over(partition by department order by hiredate) from Employees;

--first_value, last_value

select *,
     first_value(name) over(partition by department order by hiredate) from Employees;
select *,
    last_value(name) over(partition by department order by hiredate rows between unbounded preceding and unbounded following) from Employees;

	-- though we can duplicate column names in select, but not creating, we will have errors



--========
--joins
--=======

--1.Inner join
--2.outer join:
     --2.1 left outer join
	 --2.2 right outer join
	 --2.3 full outer join
--3. cross join
--(self Join)
select employee.id as empid,
       department.id as deptid,
	   e.dept_id,
	   e.name as Empname,
	   d.name as deptname
from employee as e --left table
inner join department as d--right table
   on e.dept_id=d.id -- order doesn't matter

--ambiguous column name 'id' means we do have duplicate columns

