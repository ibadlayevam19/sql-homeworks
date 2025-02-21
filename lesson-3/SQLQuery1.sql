use AdventureWorks2019;
select 
*
from Person.Address;
select top 10 
*
from Person.Address;
select top 10 percent
*
from Person.Address;
 
select 1 as ID from Person.Address;
select 1 as ID, * from Person.Address;
select 1 as num, AddressID as ID, * from Person.Address;
select 
ID=AddressID, * from Person.Address;
select *,
 2*StateProvinceID as code
from Person.Address;
select *,
code=2*StateProvinceID 
from Person.Address;

select * from Production.Product;

select SafetyStockLevel, ReorderPoint from Production.Product;

select distinct SafetyStockLevel, ReorderPoint from Production.Product;

select distinct ReorderPoint from Production.Product where ReorderPoint<600 and MakeFlag<>1;
select distinct ReorderPoint from Production.Product where ReorderPoint between 300 and 600;
select distinct ReorderPoint from Production.Product;
select top 10 * from Production.Product;
select top 10 *  from Production.Product order by ReorderPoint desc;

