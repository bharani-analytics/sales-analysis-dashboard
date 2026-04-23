use  superstore;

-- understanding dataset
select * from train limit 10;
-- data cleaning and preparation

-- checking duplicates
select 'order ID','Product ID', COUNT(*)AS COUNT
FROM train
group by 'order ID','Product ID'
having COUNT(*)>1;

-- Renaming columns
alter table train

change  `product ID` product_id varchar(100),
change `Row ID` row_id int;


-- Removing duplicates
delete s1 from train s1
join train s2
on s1.order_id =s2.order_id and s1.product_id = s2.Product_id AND s1.row_id>s2.row_id;

-- checking null values
select * from train 
where sales is null;

-- fix data types i) check strcture
describe train;
-- CONVERT STRING DATE VALUR TO DATE FORMAT
alter table train add order_date_new date;
UPDATE train set order_date_new =str_to_date(`Order Date`,'%d-%m-%Y');
select`Order Date`,str_to_date(`Order Date`,'%d-%m-%Y')as order_date_new from train;
-- ii) convert data types
alter table train 
modify 	Country varchar(100),
modify City varchar(100),
modify Region varchar(100),
modify Category varchar(100),
modify order_date_new DATE;

select distinct Category from train;

-- create useful columns
select order_date_new,
YEAR(order_date_new) AS YR,
MONTH(order_date_new)AS MTH,
monthname(order_date_new)AS MTHNAME
 FROM train;
 
 --- sql analysis ----
 select * from train;
 
 -- KPIs
 -- TOTAL SALES,total customers,total orders
 select round(sum(sales),2) as total_sales,
 count(distinct`Customer ID`) as total_customers,
 count(distinct order_id) as total_orders
 from train;
 
 -- sales by region
 select round(sum(sales),2)as total_sales,Region
 from train
 group by Region order by total_sales desc;
 
-- sales by category
select Category,round(sum(sales),2) as total_sales
from train
group by category order by total_sales desc;

-- sales by sub category
select `sub-category`,round(sum(sales),2) as total_sales
from train
group by `sub-category` order by total_sales desc;

-- sales trend
select YEAR(order_date_new) AS yr,
MONTH (order_date_new)AS MTH,round(sum(sales),2) as total_sales from train
group by yr,mth order by yr,mth;

-- Top products
select `sub-category`,round(sum(sales),2)as total_sales
from train 
group by `sub-category` order by total_sales desc
limit 10;

-- order distribution
select year(order_date_new)as yr,count(distinct order_id)as total_orders
from train group by yr order by yr desc;

