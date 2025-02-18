create database NEWDB;
use NEWDB;
/*select @@VERSION;*/
use firstDB;
drop table if exists department;
create table department(
    ID int not null,
	NAME nvarchar(50) not null,
	description nvarchar(50) null
);
select * from department;
insert into department
values
(3,'marketing', 'just department'),
(4, 'demo', NULL);