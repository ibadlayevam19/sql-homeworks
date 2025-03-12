use homework10;
drop table if exists shipments;
create table Shipments(
   N int primary key,
   Num int
);
insert into Shipments
values 
    (1, 1), (2, 1), (3, 1), (4, 1), (5, 1), (6, 1), (7, 1), (8, 1),
	(9, 2), (10, 2), (11, 2), (12, 2), (13, 2), (14, 4), (15, 4), (16, 4),
	(17, 4), (18, 4), (19, 4), (20, 4), (21, 4), (22, 4), (23, 4), (24, 4),
	(25, 4), (26, 5), (27, 5), (28, 5), (29, 5), (30, 5), (31, 5), (32, 6), (33, 7);

;WITH cte as(
     select 1 as days
	 union all
	 select days+1 from cte
	 where days<40
),
table1 as (
     select c.days as days, isnull(s.num, 0) as numbers, count(c.days) over() as total,
	 row_number() over(order by isnull(s.num, 0)) rnk
	  from cte c left join shipments s 
	 on c.days=s.n
)
select avg(numbers*1.0) as median from table1 where rnk in ((total+1)/2, total/2+1);

