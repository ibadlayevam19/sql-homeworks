use class4;
--Aggregate functions
--1.COUNT()

--select count(*) from products; --will count all columns
--select count(Productname) from products --wont count null
--select count(distinct somecolumn) from table --will count distinct values in that column

--2. SUM()
--3. AVG()
--4. MIN()
--5. MAX()
--6. STRING_AGG()

--select
--category
--from profuct
--group by category
--here we will use first 4 functions for category groups

--select
--category, STRING_AGG(PRoductname, '*')
--from product
--group by category


--this will print all productnames like list


use homework3;
select * from Products;

select
STRING_AGG(productName, '--')
from Products

create table agents
(
    name varchar(50),
    office varchar(50),
    isheadoffice varchar(3)
);
insert into agents
values
    ('Rich', 'UK', 'yes'),
    ('Rich', 'US', 'no'),
    ('Rich', 'NZ', 'no'),
    ('Brandy', 'US', 'yes'),
    ('Brandy', 'UK', 'no'),
    ('Brandy', 'AUS', 'no'),
    ('Karen', 'NZ', 'yes'),
    ('Karen', 'UK', 'no'),
    ('Karen', 'RUS', 'no'),
    ('Mary', 'US', 'yes'),
    ('Mary', 'UK', 'no'),
    ('Mary', 'CAN', 'no'),
    ('Charles', 'US', 'yes'),
    ('Charles', 'UZB', 'no'),
    ('Charles', 'AUS', 'no');
	select * from Agents;
select name from agents where (office='US' and isheadoffice='yes') or (office='UK' and isheadoffice='no') group by name having count(*)=2 

create table parent
(
    pname varchar(50),
    cname varchar(50),
    gender char(1)
);
insert into parent
values
    ('Karen', 'John', 'M'),
    ('Karen', 'Steve', 'M'),
    ('Karen', 'Ann', 'F'),
    ('Rich', 'Cody', 'M'),
    ('Rich', 'Stacy', 'F'),
    ('Rich', 'Mike', 'M'),
    ('Tom', 'John', 'M'),
    ('Tom', 'Ross', 'M'),
    ('Tom', 'Rob', 'M'),
    ('Roger', 'Brandy', 'F'),
    ('Roger', 'Jennifer', 'F'),
    ('Roger', 'Sara', 'F')
select distinct pname from parent group by pname, gender  having count(*)=2 or count(*)=1





--Number Functions
--1.SQRT
select sqrt(4)

--2.ABS
select ABS(-10)

--3.ROUND
select *, round(sqrt(price), 2) from Products;

--4.Ceiling
select ceiling(1.1)--2

--5.FLOOR
select floor(2.9)--2

--6. POWER
select POWER(2, 5)--32

--7. EXP
select EXP(1)--e^1

--8. LOG
select log(exp(1))--natural logarithm

--9. LOG10
select log10(100)--2

--10.SIGN
select sign(-10), sign(0), sign(100)--(-1),(0),(1)

--11.RAND
select rand()--just random number

select ceiling(100*rand())--random number between 0 and 100

--Window Functions
--String Functions

--1.LEN
select *, len(productname) from Products

--2.LEFT/RIGHT
select productname,
len(productname),
left(productname, 3),
right(productname, 3)
from Products;

--3.SUBSTRING
select productname,
len(productname),
left(productname, 3),
right(productname, 3),
substring(productname, 2,3)
from Products;

--4. REVERSE
select productname, reverse(substring(productname,2,2)) from products;

--5.CHARINDEX
select productname, charindex('o',productname) from Products;

select 'demo office', charindex('o', 'demo office'), charindex('o', 'demo office', 5);--where to start
select 'demo office', charindex('o', 'demo office', charindex('o', 'demo office')+1);

--6.REPLACE
select replace('sql server 2019', '2019', '2020');

select productname, replace(productname, 'o', '0') from Products;

--7. TRIM, LTRIM, RTRIM
select '    something     ',
ltrim('    something     '),
rtrim('    something     '),
trim('    something     ');

--8.UPPER/LOWER
select productname, upper(productname), lower(productname) from products;

--9.CONCAT
select concat('Hello', 'World', 'Another');

select concat('Hello', null, 'Another');--HelloAnother
select 'Hello'+null+'World'--null

--10.STRING_AGG()

--11.SPACE
select 'Hello'+space(10)+'World';

--12.REPLICATE
select 'apple'*10--conversion failed
select replicate('apple ', 10);

--13.SPLIT
select string
--Date and/or Time Functions
