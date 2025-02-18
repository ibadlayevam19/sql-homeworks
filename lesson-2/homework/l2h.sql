create database homework2;

/*task1*/
use homework2;
drop table if exists test_identity;
create table test_identity(
    id int identity(1,1),
	name varchar(10)
);
insert into test_identity
values('first'),('second'),('third');

select * from test_identity;

delete from test_identity;
truncate table test_identity;
drop table test_identity;
--when we use delete, all insertions are deleted, but iteration of identity column will not be affected. It continues the iteration.
--when we use truncate, all insertions are deleted, iteration of identity column will start all over again, it doesn't continue.
--when we use drop, not only insertions, but headers will also be deleted, which entire table will dissappear

/*task2*/
use homework2;

drop table if exists data_types_demo;
create table data_types_demo(
     test1 tinyint,
	 test2 smallint,
	 test3 int,
	 test4 bigint,
	 test5 dec(10,3),
	 test6 float,
	 test7 char(10),
	 test8 varchar(10),
	 test9 text,
	 test10 ntext,
	 test11 date,
	 test12 time,
	 test13 datetime,
	 test14 uniqueidentifier,
	 test15 varbinary(max)
);
insert into data_types_demo
select 45, -8462, 209323, 90123120121, 93.222913, 93.222913, 'chars', 'characters', 'should be text', 'more texts', '2005-10-19', '18:39:38', getdate(), newid(), * from openrowset(
BULK 'C:\Users\ASUS\OneDrive\Рабочий стол\icecream.jpg', single_blob) as img;
select * from data_types_demo;

/*task3*/
use homework2;
drop table if exists photos;
create table photos(
     id int primary key,
	 name varchar(10),
	 photo varbinary(max)
);
insert into photos
select 1, 'ice-cream', * from openrowset(BULK 'C:\Users\ASUS\OneDrive\Рабочий стол\icecream.jpg', single_blob) as img;
select * from photos;

/*task4*/
use homework2;
drop table if exists student;
create table student(
     id int identity(1,1),
	 classes int not null,
	 tuition_per_class float not null,
	 total_tuition as classes*tuition_per_class
);
insert into student
values (10, 50.5), (4, 40.5);
select * from student;

/*task5*/
use homework2;
drop table if exists worker;
create table worker(
   id int primary key identity,
   name varchar(40)
);
bulk insert worker
from 'D:\SQL\sql-homeworks\workers.csv'
with(
    firstrow=2,
	fieldterminator=',',
	rowterminator='\n'
);
select * from worker;


	 


