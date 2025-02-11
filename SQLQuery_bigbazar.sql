create database bigbazar

use bigbazar

select * from customers
select * from sales

ALTER TABLE Customers
ADD CONSTRAINT PK_Customers PRIMARY KEY (CustomerID);

--Business Questions for Analysis



--Total Sales Analysis - What is the total revenue generated per category?
select category, cast(sum(total_Sales)as decimal(10,2)) as net_revenue
from sales group by category



--Top Selling Products - Which products have the highest total sales?
select product_name, sum(total_Sales) as total_sales
from sales
group by product_name order by total_sales desc



--City-Based Sales Trends - Which city generates the most revenue?
select c.city, sum(s.total_Sales) as highest_city_revenue
from sales as s join customers as c
on c.customer_id = s.customer_id
group by c.city order by highest_city_revenue desc



--Customer Purchase Behavior - What is the average spending of customers based on their membership type?
select membership_status, avg(total_spent) as avergae_spending_status
from customers group by membership_status
--OR
SELECT membership_status, 
       CAST(SUM(total_spent) / COUNT(customer_id) AS DECIMAL(10,2)) AS average_spending_status
FROM customers 
GROUP BY membership_status;



--Seasonal Trends - How do sales vary by month?
select month(purchase_date) as month,  datename(month, purchase_date) as month_name,
round(sum(total_sales),2) as sales_vary_by_month
from sales group by datename(month, purchase_date),month(purchase_date)
order by sales_vary_by_month desc


--Payment Preference - What are the most common payment methods used?
select top 3 payment_method, count(sale_id) as payment_method_count from sales
group by payment_method order by payment_method_count desc

select top 3 * from customers
select top 3 * from sales


--Customer Segmentation - How does spending behavior differ between different age groups?
select age, sum(total_spent) as total_spending_by_age
from customers
group by age
order by total_spending_by_age desc

--or

select case
			when age between 18 and 26 then '18-26'
			when age between 27 and 34 then '27-34'
			when age between 35 and 42 then '35-42'
			when age between 43 and 50 then '43-50'
			when age between 51 and 58 then '51-58'
		    when age > 58 then '58+' 
		end as age_group,
sum(total_spent) as total_spending_by_age
from customers group by 
		case
			when age between 18 and 26 then '18-26'
			when age between 27 and 34 then '27-34'
			when age between 35 and 42 then '35-42'
			when age between 43 and 50 then '43-50'
			when age between 51 and 58 then '51-58'
		    when age > 58 then '58+'
		end
order by total_spending_by_age desc



--High-Value Customers - Who are the top 10 customers based on total spending?
select top 10 customer_name, round(sum(total_spent),2) as top_10_customer_spending
from customers
group by customer_name order by 
top_10_customer_spending



--Discount Analysis - What is the average discount given per product category?
SELECT category, 
       AVG(DATEPART(HOUR, discount) * 60 + DATEPART(MINUTE, discount)) AS average_discount_percentage
FROM sales
GROUP BY category;



--Inventory Management - Which products have the lowest stock and need restocking?

SELECT Product_Name, SUM(Quantity) AS total_sold
FROM sales
GROUP BY Product_Name
ORDER BY total_sold ASC;  -- Products with the least sales


--Repeat Customers - How many customers have made multiple purchases?
SELECT customer_name, COUNT(sale_id) AS total_purchases
FROM sales as s join customers as c
on s.customer_id = c.customer_id
GROUP BY customer_name
HAVING COUNT(sale_id) > 1
ORDER BY total_purchases DESC;


--Order Trends - How do order quantities vary across different product categories?


select top 3 * from customers
select top 3 * from sales

--Profitability Analysis - Which category contributes the highest margin after discounts?
--Membership Benefits - Do Platinum members spend significantly more than Regular members?
--Region-Wise Trends - How do different regions compare in terms of sales volume?
