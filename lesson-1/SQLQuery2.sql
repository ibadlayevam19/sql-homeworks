--create database class1;
--go
use class1;
drop table if exists test;
create table test(
     id int,
	 name varchar(100)
);
insert into test
values
     (1, 'demo'),
	 (2, 'demo2');
select * from test;

select 1 as id, 'John' as name;
print 1;
select 1 id, 'john' name;
select id, name from test;
select id as MyID, name from test;
select id MyID, name from test;

insert into test
select 3, 'demo3';
select * from test;

insert into test
select 4, 'demo4'
union 
select 5, 'demo5';

/* 1. Unique constraint */
use class1;
drop table if exists person;
create table person(
      id int unique,
	  name varchar(50)
);
insert into person
values
     (1, 'John'),
	 (2, 'Adam');
select * from person;
insert into person
select NULL, 'Kate';

drop table if exists person;
create table person(
     id int not null,
	 name varchar(50)
);
alter table person
add constraint UC_person_id unique(id);




drop table if exists department;
create table department(
     id int primary key,
	 name varchar(50)
);
insert into department
values
    (1, 'IT'),
	(2, 'HR'),
	(3, 'Marketing');
drop table if exists person;
create table person(
      id int primary key,
	  name varchar(50),
	  department int foreign key references department(id)
);
insert into person
values
    (1,'John', 1),
	(2, 'Kate', 2),
	(3, 'Milly', 1);
select * from department;
select * from person;

/* check constraint */
use class1;
drop table if exists person;
create table person(
     id int primary key,
	 name varchar(50),
	 age int check(age>0)
);
insert into person
select 1, 'Bella', 17
union
select 2, 'Kate', -1;


/* default constraint */
use class1;
drop table if exists person;
create table person(
     id int primary key,
	 name varchar(50),
	 age int check(age>0),
	 email varchar(50) default 'No email'
);
insert into person(id, name, age)
select 1, 'Bella', 17
union
select 2, 'Kate', 1;
select * from person;


/* identity constraint */
use class1;
drop table if exists person;
create table person(
     id int primary key identity(1,1),
	 name varchar(50)
);
insert into person
select 'Bella';
select * from person;

SET IDENTITY_INSERT person ON ;
insert into person(id, name)
values(2, 'Kate');

