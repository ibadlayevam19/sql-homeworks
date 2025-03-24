use homework15;

--task2

drop table if exists items;
create table items
(
	ID varchar(10),
	CurrentQuantity int,
	QuantityChange int,
	ChangeType varchar(10),
	Change_datetime datetime
);
insert into items
values 
	('A0013', 278,   99 ,   'out', '2020-05-25 0:25'), 
	('A0012', 377,   31 ,   'in',  '2020-05-24 22:00'),
	('A0011', 346,   1  ,   'out', '2020-05-24 15:01'),
	('A0010', 347,   1  ,   'out', '2020-05-23 5:00'),
	('A009',  348,   102,   'in',  '2020-04-25 18:00'),
	('A008',  246,   43 ,   'in',  '2020-04-25 2:00'),
	('A007',  203,   2  ,   'out', '2020-02-25 9:00'),
	('A006',  205,   129,   'out', '2020-02-18 7:00'),
	('A005',  334,   1  ,   'out', '2020-02-18 6:00'),
	('A004',  335,   27 ,   'out', '2020-01-29 5:00'),
	('A003',  362,   120,   'in',  '2019-12-31 2:00'),
	('A002',  242,   8  ,   'out', '2019-05-22 0:50'),
	('A001',  250,   250,   'in',  '2019-05-20 0:45');
select * from items order by ChangeType, Change_datetime;

--the table to make the final table
drop table if exists #visual;
create table #visual
(
	 [quantity change] int,
	 days int
);

--the table containing only out items
drop table if exists #out;
create table #out 
(
	num int identity(1,1),
	ID varchar(10),
	CurrentQuantity int,
	QuantityChange int,
	ChangeType varchar(10),
	Change_datetime datetime
);
insert into #out(ID, Currentquantity, quantitychange, changetype, change_datetime)
select * from items where ChangeType='out' order by change_datetime asc;

--the table containing only in items
drop table if exists #in;
create table #in 
(
	num int identity(1,1),
	ID varchar(10),
	CurrentQuantity int,
	QuantityChange int,
	ChangeType varchar(10),
	Change_datetime datetime
);
insert into #in(ID, Currentquantity, quantitychange, changetype, change_datetime)
select * from items where ChangeType='in' order by change_datetime asc;

select * from #out;
select * from #in;

--actual process
declare @first int;
declare @second int;
declare @third int;
declare @fourth int;
declare @fifth int;
declare @in int;
declare @out int=0;
declare @i int=1;
declare @j int=1;
declare @outcount int =(select count(*) from items where ChangeType='out')
declare @incount int=(select count(*) from items where ChangeType='in')

set @out=(select QuantityChange from #out where num=1);


while @i<=@incount
begin
	set @in=(
	select QuantityChange from #in where num=@i);

	--we start to decrease 'in' items relative to 'out'
	while @out<@in --when 'in' items are not enough to out, it exits
	begin 
		insert into #visual
		values
			(@out, datediff(day, (select change_datetime from #in where num=@i), (select change_datetime from #out where num=@j)));
		set @in=@in-@out;
		set @j=@j+1;
		--when there is no 'out' item left, it should stop looping in '#out' table
		if @j>@outcount
			break;
		set @out=(select QuantityChange from #out where num=@j);
	end
	--when there is no 'out' item left, it should stop looping in '#in' table too
	if @j>@outcount
	break;
	  
	insert into #visual
	values
		(@in, datediff(day, (select change_datetime from #in where num=@i), (select change_datetime from #out where num=@j)));
	set @out=@out-@in
	set @i=@i+1
end

--we should insert the last value we came to in '#in' table
insert into #visual 
values
	(@in, datediff(day, (select change_datetime from #in where num=@i), (select max(change_datetime) from items)));
--now, inserting other not changed 'in' items in '#in' table
while @i<@incount
begin
	set @i=@i+1;
	insert into #visual
	values
		((select quantitychange from #in where num=@i), datediff(day, (select change_datetime from #in where num=@i), (select max(change_datetime) from items)));
end;

select * from #visual;

--only for this specific case
select
(select sum([quantity change]) from #visual where days between 1 and 90) as [1-90 days old], 
(select sum([quantity change]) from #visual where days between 91 and 180) as [91-180 days old],
(select sum([quantity change]) from #visual where days between 181 and 270) as [181-270 days old],
(select sum([quantity change]) from #visual where days between 271 and 360) as [271-360 days old],
(select sum([quantity change]) from #visual where days between 361 and 450) as [361-450 days old];

--select max(days)/90+1 from #visual;


select * from #visual;
declare @num int=0
declare @finalsql nvarchar(max)='select'
while @num<(select max(days)/90+1 from #visual)
begin
if (select sum([quantity change]) from #visual where days between 90*@num+1 and 90*(@num+1)) is null
begin
set @num=@num+1
continue
end
else
set @finalsql=@finalsql+'(select sum([quantity change]) from #visual where days between '+cast(@num*90+1 as nvarchar(max))+' and '+cast((@num+1)*90 as nvarchar(max))+') 
as ['+cast(@num*90+1 as nvarchar(max))+'-'+cast((@num+1)*90 as nvarchar(max))+' days old],'
set @num=@num+1;
end
set @finalsql= (select left(@finalsql, len(@finalsql)-1)+';' where right(@finalsql, 1)=',')

exec sp_executesql @finalsql;

--to check
/*insert into #visual
values
(12, 542);*/
