create database sales_project;
use sales_project;

select * 
from superstore 
limit 10;

-- 1) Total Sales & Profit
select 
sum(Sales) as total_sales,
sum(Profit) as total_profit
from superstore;

-- 2) Total Orders 
select 
count(distinct Order_ID) as total_order
from superstore;

-- 3) Total Customers
select 
count(distinct Customer_Name) as total_customer
from superstore;

-- 4) Category-wise Sales
select Category,
sum(Sales) as total_sales
from superstore
group by Category;

-- 5) Region- Wise Profit
select region,
sum(Profit) as total_profit
from superstore
group by region
order by total_profit desc;

-- 6) Highest Selling Products
select Product_Name,
sum(Sales) as total_sales
from superstore
group by Product_Name
order by total_sales desc
limit 10;

-- 7) Highest Profitable Products 
select Product_Name,
sum(Profit) as total_profit
from superstore
group by Product_Name
order by total_profit desc
limit 10;

-- 8) Loss Making Products
select Product_Name,
sum(Profit) total_loss
from superstore
group by Product_Name
having sum(profit) < 0
order by total_loss;

-- 9) Discount Impact on Profit
select Discount,
sum(Sales),
sum(Profit)
from superstore
group by Discount
order by Discount;

-- 10) Most Loss-Making Sub- Category
select Sub_Category,
sum(Profit) as total_profit
from superstore
group by Sub_Category
order by total_profit asc;

-- 11) Monthly Sales Trend
select month(Order_Date) as month_no,
sum(sales) as total_sales
from superstore
group by month(Order_Date)
order by month_no ;

-- 12) Year - Wise Profit
select year(Order_Date) as year_no,
sum(Profit) as total_profit
from superstore
group by year(Order_Date);

-- 13) Top Customer By profit
select Customer_Name,
sum(Profit) as total_profit
from superstore
group by Customer_Name
order by total_profit desc
limit 10;

-- 14) State-wise Sales
select State ,
sum(Sales) as total_sales
from superstore 
group by State
order by total_sales desc;

-- 15) State-Wise sales
select State,
sum(Profit) as total_profit
from superstore
group by State
having sum(Profit) < 0;

-- 16) Profit Margin by Category 
select category,
round(sum(profit)/sum(sales)*100,2) profit_margin
from superstore
group by category;

-- 17) Average Order Value 
select 
round(sum(sales)/count(distinct order_id),2) avg_order_value
from superstore;

-- 18) Top 5 Cities by Sales
select city,
sum(sales) total_sales
from superstore
group by city
order by total_sales desc
limit 5;

-- 19) Segment-Wise Profit
select segment,
sum(profit) total_profit
from superstore
group by segment;

-- 20) Orders With Negative Profit
select *
from superstore
where profit < 0;

-- 21) Rank Products By Profit
select product_name,
sum(profit) total_profit,
rank() over(order by sum(profit) desc) profit_rank
from superstore
group by product_name;

-- 22) Running Sales Total
select order_date,
sales,
sum(sales) over(order by order_date) running_sales
from superstore;

-- 23) Top Product in Each Category
with cte as (
select category,
product_name,
sum(sales) total_sales,
rank() over(partition by category order by sum(sales) desc) rnk
from superstore
group by category, product_name
)
select *
from cte
where rnk = 1;