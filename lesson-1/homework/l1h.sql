create database homework1;

/*task1*/
use homework1;
drop table if exists student;
create table student(
    id int null,
	name varchar(50),
	age int
);
alter table student
alter column id int NOT NULL;

/*task2*/
use homework1;
drop table if exists product;
create table product(
     product_id int constraint UQ_constraint unique,
	 product_name varchar(50),
	 price dec(10,2)
);
--insert into product
--values (1, 'milk', null),
--(1, 'flour', 16.5);
--select * from product;
alter table product
drop constraint UQ_constraint;

alter table product
add unique(product_id);

alter table product
add unique(product_id, product_name);

/*task3*/
use homework1;
drop table if exists orders;
create table orders(
        order_id int constraint PM primary key,
		customer_name varchar(50),
		order_date date
);
alter table orders
drop constraint PM;

--insert into orders
--values (1,'ice-cream','2020-06-04'),
--(1,'pizza','2021-08-09');
--select * from orders;

alter table orders
add primary key(order_id);

/*task4*/
use homework1;
drop table if exists category;
create table category(
   category_id int primary key,
   category_name varchar(50)
);
drop table if exists item;
create table item(
    item_id int primary key,
	itme_name varchar(50),
	category_id int constraint FK foreign key references category(category_id)
);
alter table item
drop constraint FK;

alter table item
add foreign key(category_id) references category(category_id);

/*task5*/
use homework1;
drop table if exists account;
create table account(
   account_id int primary key,
   balance dec(20,5) check(balance>=0),
   account_type varchar(50) constraint Type_ch check(account_type='Saving' or account_type='Checking')
);
alter table account
drop constraint Type_ch;

alter table account
add check(account_type='Saving' or account_type='Checking');

/*task6*/
use homework1;
drop table if exists customer;
create table customer(
   customer_id int primary key,
   name varchar(50),
   city varchar(50) constraint city_d default 'Unknown'
);
alter table customer
drop constraint city_d;

alter table customer
add constraint city_d default 'Unknown' for city;

/*task7*/
use homework1;
drop table if exists invoice;
create table invoice(
    invoice_id int identity(1,1),
	amount dec(10,3)
);
insert into invoice
values (17.93),
(43.94),
(65.940),
(45.382),
(573.023);
select * from invoice;

set identity_insert invoice off;
insert into invoice(invoice_id, amount)
values (100, 847.29)
set identity_insert invoice on;
insert into invoice(invoice_id, amount)
values (100, 847.29)

/*task8*/
use homework1;
drop table if exists books;
create table books(
    book_id int primary key identity(1,1),
	title varchar(50) not null,
	price dec(10,2) check(price>0),
	genre varchar(10) default 'Unknown'
);
--on checking purpose
insert into books(title, price)
values ('Suv hidi', 54.93);
insert into books(price, genre)
values (54.93, 'story');
insert into books(title, price)
values ('Midnight Library', -736);
insert into books(title, price)
values (89, 'Almond', 54.93);

/*task9*/
use homework1;
drop table if exists Book;
create table Book(
    book_id int primary key,
	title varchar(20) not null,
	author varchar(20),
	published_year int
);
drop table if exists Member;
create table Member(
    member_id int primary key,
	name varchar(20) not null,
	email varchar (50),
	phone_number varchar(20) not null
);
drop table if exists Loan;
create table Loan (
    loan_id int primary key,
	book_id int foreign key references Book(book_id),
	member_id int foreign key references Member(member_id),
	loan_date Date not null,
	return_date Date
);
insert into Book
values (1, 'Suv hidi', 'Marziya Saydam', null),
(2, 'Fesleen', 'Hikmat Anil O', null);
insert into Member
values(1, 'Malika', null, '937292419'),
(2, 'Bill', null, '99239824');
insert into Loan
values(1, 1, 1, '2025-10-19', null),
(2,2,1,'2025-10-19', '2025-12-17');
select * from Book;
select * from Member;
select * from Loan;
 
