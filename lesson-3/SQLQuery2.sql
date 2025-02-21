create database class3;
use class3;
drop table if exists nums;
create table nums(
num int
);
insert into nums
values (1), (2), (3), (4), (5), (6);

select* from nums;

select *, null as Col1
from nums
where num%2!=0 and num%3!=0
union all
select *, 'Hi' as Col1
from nums
where num%2=0 and not num%3=0
union all
select *, 'Bye' as Col1
from nums
where num%3=0 and not num%2=0
union all
select *, 'Hi Bye' as col1
from nums
where num%6=0
order by num;