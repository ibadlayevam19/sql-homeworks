use homewrok7;
drop table if exists lagt;
CREATE TABLE lagt
(
	BusinessEntityID INT
	,SalesYear   INT
	,CurrentQuota  DECIMAL(20,4)
)

 
INSERT INTO lagt
SELECT 275 , 2005 , '367000.00'
UNION ALL
SELECT 275 , 2006 , '556000.00'
UNION ALL
SELECT 275 , 2007 , '502000.00'
UNION ALL
SELECT 275 , 2008 , '550000.00'
UNION ALL
SELECT 275 , 2009 , '1429000.00'
UNION ALL
SELECT 275 , 2010 ,  '1324000.00'
UNION ALL
SELECT 276 , 2005 , '367000.00'
UNION ALL
SELECT 276 , 2006 , '556000.00'
UNION ALL
SELECT 276 , 2007 , '502000.00'
UNION ALL
SELECT 276 , 2008 , '550000.00'
UNION ALL
SELECT 276 , 2009 , '1429000.00'
UNION ALL
SELECT 276 , 2010 ,  '1324000.00'
select * from lagt;
select 
	*,
	lag(CurrentQuota, 1, 0) over(partition by BusinessEntityId order by SalesYear)
from lagt;

select *,
	isnull((
		select currentquota 
		from lagt t2 
		where t1.BusinessEntityID = t2.BusinessEntityID
			and t1.SalesYear = t2.SalesYear + 1
	), 0)
from lagt t1