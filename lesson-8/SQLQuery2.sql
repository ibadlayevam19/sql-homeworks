create database class8;
use class8;
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE
);
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10,2)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50)
);

INSERT INTO Customers (CustomerID, CustomerName) VALUES
(1, 'Alice Johnson'),
(2, 'Bob Smith'),
(3, 'Charlie Brown');

INSERT INTO Orders (OrderID, CustomerID, OrderDate) VALUES
(101, 1, '2024-02-01'),
(102, 2, '2024-02-05'),
(103, 3, '2024-02-10'),
(104, 1, '2024-02-12');

INSERT INTO Products (ProductID, ProductName, Category) VALUES
(1, 'Laptop', 'Electronics'),
(2, 'Headphones', 'Accessories'),
(3, 'Smartphone', 'Electronics'),
(4, 'Backpack', 'Bags');

INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, Price) VALUES
(1, 101, 1, 1, 899.99),
(2, 101, 2, 2, 49.99),
(3, 102, 3, 1, 599.99),
(4, 103, 4, 1, 79.99),
(5, 104, 1, 1, 899.99),
(6, 104, 3, 1, 599.99);

--subquery
--if we use the result set inside of other query
select 'a'[1], 2 b, 'c' c;
select * from Orderdetails;
select sum(price) from orderdetails where productid=1;
--only one column and one row can be added to the table from other table inside of subquery
--subquery should return one value
select * from products;
select * from orderdetails od join products p on od.productid=p.productid;
 
select * from string_split('Kate,John', ',');

select ordinal as num into numbers from string_split(replicate(',',9), ',', 1)
select num, sum(num) over(order by num ) from numbers;

 
