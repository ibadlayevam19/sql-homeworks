use class14;
CREATE TABLE TestMax
(
	Year1 INT
	,Max1 INT
	,Max2 INT
	,Max3 INT
)
 INSERT INTO TestMax 
VALUES
 (2001,10,101,87)
,(2002,103,19,88)
,(2003,21,23,89)
,(2004,27,28,91)

Select Year1,Max1,Max2,Max3 FROM TestMax
select * from testmax
unpivot(
years for maxes in
(max1, max2, max3)
)pvt