use class11;
-- SQL variables
declare @txt varchar(max);
set @txt='Test';
select @txt;
 
declare @num int;
select @num;
set @num=1;
select @num;

select @num=2;
select @num;

go
--after go num will disappear
with cte as(
  select 1 as n
  union all
  select n+1 from cte 
  where n<10
)
select * into numbers from cte;
select * from numbers;
declare @num int;
select @num=n from numbers order by n desc;
select @num;
go
declare @num int=0;
select @num=@num+n from numbers;
select @num;

select @@servername;
select @@identity
create table emp(
   id int primary key identity,
   name varchar(50)
);
insert into emp 
values('josh');
select @@identity 
--identity value increases everytime insert the value
select @@rowcount; --it will return the number of rows last affected
select @@version; 
select @@trancount;

select * from emp;
begin tran t1
insert into emp(name)
values('adam')
commit tran t1
rollback tran t1;

--table variable
declare @dept table(
  id int,
  name varchar(50)
);
insert into @dept
values (1, 'it');
select * from @dept;

--SQL Server Temporary Tables
create table #sales
(
	id int,
	product varchar(50),
	price int
);
insert into #sales
values(1, 'apple', 10);
select * from #sales;
--it will be deleted after this query closed
--it can not be used in other query

--SQL Server Global Temp Tables
create table ##temp
(
  id int,
  name varchar(50)
);
insert into ##temp
values(1, 'John');
select * from ##temp;
--deleted after the query closed
--it can be used in other query

--SQL View



















