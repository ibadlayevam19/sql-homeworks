use homework7;
drop table if exists Customers;
create table Customers(
   CustomerID int primary key,
   CustomerName varchar(100)
);
drop table if exists Orders;
create table Orders(
   OrderID int primary key,
   CustomerID int,
   OrderDate Date
);
drop table if exists OrderDetails;
create table OrderDetails(
   OrderDetailID int primary key,
   OrderID int foreign key references Orders(orderid),
   ProductID int,
   Quantity int,
   Price Decimal(10,2)
);
drop table if exists Products;
create table Products(
    ProductID int primary key,
	ProductName varchar(100),
	Category varchar(50)
);

INSERT INTO Customers (CustomerID, CustomerName) VALUES
(1, 'Alice Johnson'),
(2, 'Bob Smith'),
(3, 'Charlie Brown'),
(4, 'David White'),
(5, 'Eva Green'),
(6, 'Frank Black'),
(7, 'Grace Hall'),
(8, 'Hannah Lewis'),
(9, 'Ian Scott'),
(10, 'Jack Turner'),
(11, 'Bella Swan');

INSERT INTO Orders (OrderID, CustomerID, OrderDate) VALUES
(1, 1, '2024-02-01'),
(2, 2, '2024-02-02'),
(3, 3, '2024-02-03'),
(4, 4, '2024-02-04'),
(5, 5, '2024-02-05'),
(6, 6, '2024-02-06'),
(7, 7, '2024-02-07'),
(8, 8, '2024-02-08'),
(9, 9, '2024-02-09'),
(10, 10, '2024-02-10');

INSERT INTO Products (ProductID, ProductName, Category) VALUES
(1, 'Laptop', 'Electronics'),
(2, 'Smartphone', 'Electronics'),
(3, 'Headphones', 'Electronics'),
(4, 'Tablet', 'Electronics'),
(5, 'Desk Chair', 'Furniture'),
(6, 'Office Desk', 'Stationery'),
(7, 'Bookcase', 'Furniture'),
(8, 'Backpack', 'Accessories'),
(9, 'Watch', 'Accessories'),
(10, 'Water Bottle', 'Accessories');

INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, Price) VALUES
(1, 1, 1, 2, 1200.00),
(2, 2, 2, 1, 800.00),
(3, 3, 3, 3, 150.00),
(4, 4, 4, 1, 500.00),
(5, 5, 5, 2, 200.00),
(6, 6, 6, 1, 450.00),
(7, 7, 7, 1, 300.00),
(8, 8, 8, 3, 90.00),
(9, 9, 9, 1, 250.00),
(10, 10, 10, 5, 75.00);

/*task1*/
select c.*, o.orderid, o.orderdate from customers c left join orders o on c.customerid=o.customerid;
/*task2*/
select c.* from customers c left join orders o on c.customerid=o.customerid where o.orderid is null;
/*task3*/
select o.orderid, p.productname ,od.quantity from orders o join orderdetails od on o.orderid=od.orderid join products p on p.productid=od.productid; 
/*task4*/
select c.customername from customers c join orders o on c.customerid=o.customerid group by c.customername having count(*)>1;
/*task5*/
select o.orderid, o.orderdate, p.productname, od.price from orders o join orderdetails od on o.orderid=od.orderid join products p on od.productid=p.productid where od.price=(select max(price) from orderdetails where orderid=o.orderid) order by o.orderid;
/*task6*/
select c.customername, o.orderid, o.orderdate as Latest_order 
from customers c 
join orders o on c.customerid=o.customerid 
where o.orderdate=(select max(o.orderdate) from orders where customerid=c.customerid); 
/*task7*/
 select c.customername 
 from customers c 
 join orders o on c.customerid=o.customerid 
 join orderdetails od on od.orderid=o.orderid
 join products p on p.productid=od.productid
 group by c.customerid having count(case when p.category!='Electronics' then p.productid end)=0;
/*task8*/
select  distinct c.customerid ,c.customername from customers c join orders o on c.customerid=o.customerid
join orderdetails od on o.orderid=od.orderid 
join products p on p.productid=od.productid where p.category='Stationery';
/*task9*/
select c.customername, sum(od.price*od.quantity) as spent_total 
from customers c 
join orders o on c.customerid=o.customerid
join orderdetails od on o.orderid=od.orderid 
join products p on p.productid=od.productid
group by c.customername;

