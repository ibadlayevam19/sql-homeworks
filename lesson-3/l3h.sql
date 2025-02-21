--hey chatgpt, check all my codes knowing that we have not covered sub queries yet, so we are not using any subquery
use homework3;
/*task1*/
drop table if exists Employees;
create table Employees(
    EmployeeID int primary key,
	Firstname varchar(50),
	Lastname varchar(50),
	Department varchar(50),
	Salary decimal(10,2),
	HireDate Date
);
INSERT INTO Employees (EmployeeID, Firstname, Lastname, Department, Salary, HireDate) VALUES
(1, 'John', 'Doe', 'IT', 75000.00, '2020-06-15'),
(2, 'Jane', 'Smith', 'HR', 60000.00, '2019-03-10'),
(3, 'Michael', 'Johnson', 'Finance', 82000.00, '2021-09-22'),
(4, 'Emily', 'Davis', 'Marketing', 72000.00, '2018-11-30'),
(5, 'David', 'Martinez', 'IT', 78000.00, '2022-01-05'),
(6, 'Sarah', 'Brown', 'Sales', 65000.00, '2017-07-14'),
(7, 'Daniel', 'Wilson', 'HR', 62000.00, '2020-08-19'),
(8, 'Laura', 'Anderson', 'Finance', 90000.00, '2016-05-23'),
(9, 'James', 'Thomas', 'Marketing', 71000.00, '2019-12-01'),
(10, 'Olivia', 'Taylor', 'IT', 85000.00, '2023-04-11'),
(11, 'Robert', 'Moore', 'Sales', 67000.00, '2021-06-25'),
(12, 'Sophia', 'Harris', 'HR', 63000.00, '2018-10-07'),
(13, 'William', 'Clark', 'Finance', 88000.00, '2015-09-17'),
(14, 'Isabella', 'Lewis', 'Marketing', 73000.00, '2020-02-14'),
(15, 'Ethan', 'Young', 'IT', 76000.00, '2021-08-09'),
(16, 'Mia', 'Allen', 'Sales', 64000.00, '2017-04-05'),
(17, 'Alexander', 'King', 'HR', 61000.00, '2022-12-18'),
(18, 'Charlotte', 'Scott', 'Finance', 91000.00, '2016-07-21'),
(19, 'Benjamin', 'Adams', 'Marketing', 74000.00, '2019-05-29'),
(20, 'Amelia', 'Baker', 'IT', 77000.00, '2023-01-12'),
(21, 'Henry', 'Gonzalez', 'Sales', 66000.00, '2020-11-09'),
(22, 'Grace', 'Nelson', 'HR', 62500.00, '2018-08-30'),
(23, 'Lucas', 'Carter', 'Finance', 89500.00, '2015-12-15'),
(24, 'Ava', 'Mitchell', 'Marketing', 72500.00, '2021-03-07'),
(25, 'Elijah', 'Perez', 'IT', 79000.00, '2022-09-27');

select * from Employees;
select top 10 percent * from Employees;

select Department, avg(Salary)  as AverageSalary, iif(avg(Salary)>80000, 'High', iif(avg(Salary) between 50000 and 80000, 'Medium', 'Low')) as SalaryCategory  from Employees group by Department
order by AverageSalary desc
offset 2 rows fetch next 5 rows only; 



/*task2*/
drop table if exists Orders;
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    Status VARCHAR(20) CHECK (Status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled'))
);
INSERT INTO Orders (OrderID, CustomerName, OrderDate, TotalAmount, Status) VALUES
(1, 'Alice Johnson', '2023-01-15', 120.50, 'Pending'),
(2, 'Bob Smith', '2023-01-16', 250.00, 'Shipped'),
(3, 'Charlie Brown', '2023-01-17', 75.99, 'Delivered'),
(4, 'David Wilson', '2023-01-18', 300.40, 'Cancelled'),
(5, 'Emma Davis', '2023-01-19', 220.00, 'Pending'),
(6, 'Frank Thomas', '2023-01-20', 180.75, 'Shipped'),
(7, 'Grace Martinez', '2023-01-21', 95.30, 'Delivered'),
(8, 'Hannah White', '2023-01-22', 450.60, 'Cancelled'),
(9, 'Ian Harris', '2023-01-23', 130.00, 'Pending'),
(10, 'Jack Lewis', '2023-01-24', 275.45, 'Shipped'),
(11, 'Katie Clark', '2023-01-25', 199.99, 'Delivered'),
(12, 'Leo Rodriguez', '2023-01-26', 420.75, 'Cancelled'),
(13, 'Mia Walker', '2023-01-27', 85.00, 'Pending'),
(14, 'Nathan Hall', '2023-01-28', 305.60, 'Shipped'),
(15, 'Olivia Allen', '2023-01-29', 110.25, 'Delivered'),
(16, 'Paul King', '2023-01-30', 555.80, 'Cancelled'),
(17, 'Quinn Scott', '2023-01-31', 275.00, 'Pending'),
(18, 'Rachel Adams', '2023-02-01', 95.40, 'Shipped'),
(19, 'Samuel Carter', '2023-02-02', 310.90, 'Delivered'),
(20, 'Tina Gonzalez', '2023-02-03', 650.30, 'Cancelled'),
(21, 'Umar Perez', '2023-02-04', 145.75, 'Pending'),
(22, 'Vera Young', '2023-02-05', 210.20, 'Shipped'),
(23, 'Walter Mitchell', '2023-02-06', 320.99, 'Delivered'),
(24, 'Xavier Collins', '2023-02-07', 440.50, 'Cancelled'),
(25, 'Yasmin Murphy', '2023-02-08', 135.85, 'Pending'),
(26, 'Zane Baker', '2023-02-09', 250.90, 'Shipped'),
(27, 'Aaron Reed', '2023-02-10', 500.00, 'Delivered'),
(28, 'Bella Foster', '2023-02-11', 750.60, 'Cancelled'),
(29, 'Caleb Sanders', '2023-02-12', 185.30, 'Pending'),
(30, 'Diana Howard', '2023-02-13', 290.45, 'Shipped');

select * from Orders;
select 
case 
    when status='Shipped' or status='Delivered' then 'Completed'
    when status='Pending' then 'Pending'
    when status='Cancelled' then 'Cancelled' 
end as OrderStatus, 
count(*) as TotalOrders, sum(TotalAmount) as TotalRevenue
from Orders
where OrderDate between '2023-01-01' and '2023-12-31'
group by
case 
    when status='Shipped' or status='Delivered' then 'Completed'
    when status='Pending' then 'Pending'
    when status='Cancelled' then 'Cancelled'
end 
having sum(TotalAmount)>5000
order by TotalRevenue desc;
--it will be free of values according to my insertions

 

/*task3*/
use homework3;
drop table if exists Products;
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT
);
INSERT INTO Products (ProductID, ProductName, Category, Price, Stock) VALUES
(1, 'Laptop', 'Electronics', 1200.50, 15),
(2, 'Smartphone', 'Electronics', 850.75, 25),
(3, 'Headphones', 'Electronics', 150.99, 50),
(4, 'Keyboard', 'Electronics', 60.40, 40),
(5, 'Office Chair', 'Furniture', 250.00, 20),
(6, 'Desk', 'Furniture', 180.00, 10),
(7, 'Table Lamp', 'Furniture', 45.99, 30),
(8, 'Notebook', 'Stationery', 5.50, 100),
(9, 'Pen Set', 'Stationery', 12.75, 200),
(10, 'Backpack', 'Accessories', 55.30, 35),
(11, 'Running Shoes', 'Clothing', 95.00, 22),
(12, 'T-Shirt', 'Clothing', 25.99, 60),
(13, 'Winter Jacket', 'Clothing', 120.75, 15),
(14, 'Watch', 'Accessories', 180.50, 18),
(15, 'Sunglasses', 'Accessories', 80.90, 40),
(16, 'Coffee Maker', 'Appliances', 130.00, 12),
(17, 'Microwave', 'Appliances', 200.00, 8),
(18, 'Refrigerator', 'Appliances', 850.00, 5),
(19, 'Book - Python Programming', 'Books', 40.99, 75),
(20, 'Book - Data Science Basics', 'Books', 50.49, 60);
select * from products;
select category,  max(price) as max_price, IIF(sum(stock)=0, 'Out of Stock', IIF(sum(stock) between 1 and 10, 'Low Stock', 'In Stock')) as InventoryStatus from Products group by category order by max(price) ; 




