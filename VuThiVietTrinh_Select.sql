Create database Superstore_Global
--Q1.Sub category of Technology Category
select distinct [Sub-Category]
from Orders
where Category='Technology'
--Q2.Grand total: Number of Orders, Sum Sales, Sum Quantity, Sum profit, sum Shipping cost, Sum Discount
select COUNT(*) from Orders
-- 
select sum (Sales) from Orders
--
select sum (Quantity) from Orders
--
select sum (profit) from Orders
--
select sum ([Shipping Cost]) from Orders
--
select sum (Discount) from Orders
--Q3.Number of Orders, Sum Sales, Sum Quantity, Sum profit, sum Shipping cost, Sum Discount By category
Select category, count(*) as [Number of Orders],
Sum(Sales) as [Sum Sales],
Sum(Quantity) as [Sum Quantity] ,
Sum(Profit) as [Sum Profit],
Sum([Shipping Cost]) as [Sum Shipping Cost],
Sum(Discount) as [Sum Discount]
from Orders
Group by Category
--Q4.Sum profit by category in Europe Market
Select category, Sum(Profit) as [Sum Profit]
from Orders
Where Market= 'Europe'
Group by Category
--Q5. Sum Profit, sum sales by Category and Sub category
Select Category, [Sub-Category],
 Sum(Profit) as [Sum Profit],
Sum(Sales) as [Sum Sales]
from Orders
Group by Category, [Sub-Category]
order by category
--Q6. Product names with negative profit in 2017 
SELECT [Product Name], sum(profit)
From Orders
where YEAR([Order Date]) = 2017
group by [Product Name]
having sum(profit) <0 
--Q7.Top 10 products with the highest profit in Europe market in 2017
Select top 10 [Product Name], sum(profit)
from Orders
where Market= 'Europe' and YEAR([Order Date])= 2017
group by [Product Name]
Order by sum(Profit) DESC
--Q8.Top 5 countries with the highest phones profit in Southeastern Asia in 2017
select top 5 Country, sum(profit)
from Orders
where [Sub-Category]= 'phones' and Region= 'Southeastern Asia' and YEAR([Order Date])= 2017
group by Country
Order by sum(Profit) DESC
--Q9. Number of Orders, Sum Quantity, profit, Sales, AVG sales by Sub category in 2nd Quarter and 2017 in Vietnam
Select count(*) as [Number of Orders], 
Sum(Quantity) as [Sum Quantity], 
Sum(Profit) as [Sum Profit], 
Sum(Sales) as [Sum Sales],
avg(Sales) as [Avg Sales]
from Orders
where Country= 'VietNam' and [Order Date] BETWEEN '2017/04/01' and '2017/06/30'
Group by [Sub-Category]
--Q10.Product names with profit>1000 in 10/2017 in Asia Pacific market
Select [Product Name], sum (Profit)
from Orders
where Year([Order Date]) =2017
and month([Order Date])=10
and Market= 'Asia Pacific'
group by [Product Name]
having sum(profit)>1000