
DROP TABLE IF EXISTS #Cart1;
DROP TABLE IF EXISTS #Cart2;
GO

CREATE TABLE #Cart1
(
Item  VARCHAR(100) PRIMARY KEY
);


CREATE TABLE #Cart2
(
Item  VARCHAR(100) PRIMARY KEY
);


INSERT INTO #Cart1 (Item) VALUES
('Sugar'),('Bread'),('Juice'),('Soda'),('Flour');


INSERT INTO #Cart2 (Item) VALUES
('Sugar'),('Bread'),('Butter'),('Cheese'),('Fruit');

select isnull(c1.item, ''), isnull(c2.item, '') from (select *, 1 as n1 from #Cart1) c1 full 
outer join (select *, 1 as n2 from #Cart2) c2 on c1.item=c2.item order by c1.n1+c2.n2 desc;

--Create table
drop table if exists TestMax;
CREATE TABLE TestMax
(
Year1 INT
,Max1 INT
,Max2 INT
,Max3 INT
)
GO
 
--Insert data
INSERT INTO TestMax 
VALUES
 (2001,10,101,87)
,(2002,103,19,88)
,(2003,21,23,89)
,(2004,27,28,91)
 
--Select data
Select Year1,Max1,Max2,Max3 FROM TestMax

select Year1, greatest(max1, max2, max3) from TestMax;

select year1, (case
when max1>max2 and max1>max3 then max1
when max2>max1 and max2>max3 then max2
else max3
end
) from TestMax;


DROP TABLE IF EXISTS #Employees;
GO

CREATE TABLE #Employees
(
EmployeeID  INTEGER PRIMARY KEY,
ManagerID   INTEGER NULL,
JobTitle    VARCHAR(100) NOT NULL
);
GO

INSERT INTO #Employees (EmployeeID, ManagerID, JobTitle) VALUES
(1001,NULL,'President'),(2002,1001,'Director'),
(3003,1001,'Office Manager'),(4004,2002,'Engineer'),
(5005,2002,'Engineer'),(6006,2002,'Engineer');
GO
select * from #Employees;

with cte as(
 select *, 0 as Depth from #Employees where managerid is null  
 union all
 select  e.* , Depth+1 from #employees e join cte on e.managerid=cte.employeeid
)select * from cte

select EmployeeID, isnull(cast(ManagerID as varchar), '') as ManagerID, JobTitle, isnull((ManagerID-1001)%10+1, 0) as Depth from #Employees;







