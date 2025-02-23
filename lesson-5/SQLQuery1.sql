CREATE TABLE Nobel_Prizes (
    Year INT,
    Subject VARCHAR(50),
    Winner VARCHAR(100),
    Country VARCHAR(50),
    Category VARCHAR(50)
);

INSERT INTO Nobel_Prizes (Year, Subject, Winner, Country, Category) VALUES
(1970, 'Physics', 'Hannes Alfven', 'Sweden', 'Scientist'),
(1970, 'Physics', 'Louis Neel', 'France', 'Scientist'),
(1970, 'Chemistry', 'Luis Federico Leloir', 'France', 'Scientist'),
(1970, 'Physiology', 'Ulf von Euler', 'Sweden', 'Scientist'),
(1970, 'Physiology', 'Bernard Katz', 'Germany', 'Scientist'),
(1970, 'Literature', 'Aleksandr Solzhenitsyn', 'Russia', 'Linguist'),
(1970, 'Economics', 'Paul Samuelson', 'USA', 'Economist'),
(1970, 'Physiology', 'Julius Axelrod', 'USA', 'Scientist'),
(1971, 'Physics', 'Dennis Gabor', 'Hungary', 'Scientist');
select * from Nobel_prizes;

select * from Nobel_Prizes where year=1970 
order by 
 case 
    when subject='economics' or subject='chemistry' then 1
	else 0
end, subject
select product_name from sales where year(date_sold)=2020 group by product_name having count(year)=1 and year=2020


--window functions
use class5;
CREATE TABLE Sales (    SaleID INT IDENTITY(1,1) PRIMARY KEY,    SaleDate DATE NOT NULL,    Amount DECIMAL(10,2) NOT NULL);INSERT INTO Sales (SaleDate, Amount) VALUES('2024-01-01', 100),('2024-01-02', 200),('2024-01-03', 150),('2024-01-04', 300),('2024-01-05', 250),('2024-01-06', 400),('2024-01-07', 350),('2024-01-08', 450),('2024-01-09', 500),('2024-01-10', 100);select * from Sales;--order requiredselect *, row_number() over(order by amount asc) as rn_asc,row_number() over(order by amount desc) as rn_descfrom salesorder by saleID;select *, dense_rank() over (order by amount) as rn_samefrom sales order by saleID;select *, rank() over(order by amount) as rn_un from sales order by saleid;select *, (select sum(amount)  from sales) from sales;select *, sum(amount) over() as summ from sales;select * from sales;select *, cast(amount/sum(amount) over() *100 as dec(10,2))from salesselect *, avg(amount) over(order by saledate rows between 1 preceding and 1 following) as percentage from sales; 