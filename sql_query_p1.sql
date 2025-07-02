SELECT * FROM retail_sales;
SELECT * FROM retail_sales LIMIT 10
SELECT
	COUNT(*)
FROM retail_sales

-- DATA CLEANING
SELECT * FROM retail_sales
WHERE 
	sale_date IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	category IS NULL
	OR
	quantity IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL;
--
DELETE FROM retail_sales
WHERE 
	sale_date IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	category IS NULL
	OR
	quantity IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL;

-- Data Exploration

--How many sales we have?
SELECT COUNT(*) as total_sales FROM retail_sales

--How many unique customers we have?
SELECT COUNT(DISTINCT customer_id) as customers FROM retail_sales

--How many category we have?
SELECT COUNT(DISTINCT category) as no_of_Category FROM retail_sales

--List the Category.
SELECT DISTINCT category FROM retail_sales

--Data Analysis & Business Key Problems & Answers

--Q1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'

SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05'

--Q2 write a SQL query to retrieve all transaction where category is Clothing and the quantity sold is more than equal to 4 in the month of Nov-2022  
SELECT * FROM retail_sales
WHERE 
	category IN ('Clothing')
	AND
	quantity >= 4
	AND
	sale_date BETWEEN '2022-11-01' AND '2022-11-30';

--Q3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT 
	category, 
	SUM(total_sale) as total_sales,
	COUNT(*) as total_orders
	FROM retail_sales
GROUP BY category

--Q4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT
	ROUND(AVG(age),2) as average_age
	FROM  retail_sales
WHERE category = 'Beauty';

--Q5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * FROM retail_sales
WHERE total_sale > 1000;

--Q6 Write a SQL query to find the total number of transactions(transaction_id) made by gender in each category.
SELECT 
	gender,
	category,
	COUNT(transactions_id) as no_of_transaction 
	FROM retail_sales
GROUP BY gender, Category
ORDER BY gender

--Q7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT
	year,
	month,
	avg_sale
FROM
(
SELECT
	EXTRACT (YEAR FROM sale_date) as year,
	EXTRACT (MONTH FROM sale_date) as month,
	AVG(total_sale) as avg_sale,
	RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1,2
) as t1
WHERE rank = 1

-- ORDER BY 1, 3 DESC

--Q.8 Write a SQL query to find the top 5 customers based on the highest total sales
SELECT 
	customer_id,
	SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5

--Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT
	category,
	COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales
GROUP BY category

--Q.10 Write a SQL query to create each shift and nunmber of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
SELECT
	shift,
	COUNT(*) as total_orders
FROM
(
SELECT *,
	CASE
		WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
		WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	END as shift
FROM retail_sales
) as hourly_sale
GROUP BY shift

-- End of project


