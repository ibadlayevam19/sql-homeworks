use homework8;

drop table if exists Groupings;
create table Groupings(
  Step_number int ,
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
select *, isnull((
select status from groupings t1 where t1.Step_number+1=t2.step_number), status)
from groupings t2;

select *, sum(num) over(order by step_number rows between unbounded preceding and 0 following) 
as groups 
from (select *, (case when status=lag(status) over (order by step_number) then 0 else 1 end) 
as num from groupings) t1;

