use homework13;

declare @date date=getdate();
--we can insert any date here

with cte as(
  select 1 as n, datename(weekday, datefromparts(year(@date), month(@date), 1)) as  DayofWeek,
  datepart(weekday, datefromparts(year(@date), month(@date), 1)) as whichday,
  1 as whichweek
  union all
  select n+1, datename(weekday, datefromparts(year(@date), month(@date), n+1)), 
  datepart(weekday, datefromparts(year(@date), month(@date), n+1)),
  (case when datepart(weekday, datefromparts(year(@date), month(@date), n+1))>whichday then whichweek else whichweek+1 end)
  from cte
  where n<day(eomonth(@date))
)
select
max(case when DayofWeek='Sunday' then n end) as Sunday,
max(case when DayofWeek='Monday' then n end) as Monday,
max(case when DayofWeek='Tuesday' then n end) as Tuesday,
max(case when DayofWeek='Wednesday' then n end) as Wednesday,
max(case when DayofWeek='Thursday' then n end) as Thursday,
max(case when DayofWeek='Friday' then n end) as Friday,
max(case when Dayofweek='Saturday' then n end) as Saturday
from cte 
group by whichweek;


