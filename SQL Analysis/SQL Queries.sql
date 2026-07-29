CREATE DATABASE superstore_db;
USE superstore_db;

Select * from orders;

SELECT City, Sales, Profit
FROM orders
WHERE City = 'Newark' AND Sales > 10000
ORDER BY Sales DESC; 

/*aggergations*/
SELECT 
    SUM(Sales) AS Total_Sales,
    AVG(Sales) AS Average_Sales,
    COUNT(Order_ID) AS Total_Orders,
    MAX(Profit) AS Highest_Profit,
    MIN(Profit) AS Lowest_Profit
FROM orders;

/*group by*/
SELECT Category,
       SUM(Sales) AS Total_Sales,
       SUM(Profit) AS Total_Profit
FROM orders
GROUP BY Category; 

/*having*/
SELECT Region,
       SUM(Sales) AS Total_Sales,
       SUM(Profit) AS Total_Profit
FROM orders
GROUP BY Region
HAVING SUM(Profit) > 100000; 

/*like, in, between*/
SELECT Customer_Name, Region, Sales
FROM orders      
where Region IN ('Central', 'east')
AND Sales BETWEEN 5000 AND 15000 
AND Customer_Name like 'A%'
ORDER BY Sales DESC; 

/*case statement*/
SELECT Customer_Name, Region, Sales,
       CASE
           WHEN Sales > 10000 THEN 'High Sales'
           WHEN Sales BETWEEN 5000 AND 10000 THEN 'Medium Sales'
           ELSE 'Low Sales'
       END AS Sales_Category
FROM orders
ORDER BY Sales DESC;

/*checking null and not null*/
SELECT *
FROM orders
WHERE State IS NULL; 

/*Count Non-NULL values*/ 
SELECT COUNT(*)
FROM orders
WHERE State IS NOT NULL; 

/* Replace NULL with a value using IFNULL()*/
SELECT
Customer_Name,
IFNULL(State,'Unknown') AS State
FROM orders; 

/* distinct*/
SELECT
COUNT(DISTINCT Customer_Name) AS Unique_Customers,
COUNT(DISTINCT City) AS Unique_Cities,
COUNT(DISTINCT Product_Name) AS Unique_Products
FROM orders; 

/*Limit*/
SELECT Order_ID,
       Customer_Name,
       Sales
FROM orders
ORDER BY Sales DESC
LIMIT 10; 
/*highest profit transactions*/
SELECT Order_ID,
       Product_Name,
       Profit
FROM orders
ORDER BY Profit DESC
LIMIT 10; 

/* String Functions*/ 
SELECT Customer_Name,
       UPPER(Customer_Name) AS Upper_Name, 
       LOWER(Customer_Name) AS Lower_Name,
       LENGTH(Customer_Name) AS Name_Length,
       CONCAT(Customer_Name,' - ',Region) AS Customer_Details
FROM orders
LIMIT 5;  

/* date functions*/
UPDATE orders                                                /*updating of date from text to date format*/
SET Order_Date_New = STR_TO_DATE(Order_Date,'%m/%d/%Y'); 

SELECT Order_Date_New,
       YEAR(Order_Date_New) AS Order_Year,
       MONTH(Order_Date_New) AS Order_Month,
       DAY(Order_Date_New) AS Order_Day
FROM orders
LIMIT 5;
SELECT YEAR(Order_Date_New) AS Order_Year,   -- Sales by Year
       ROUND(SUM(Sales),2) AS Total_Sales
FROM orders
GROUP BY YEAR(Order_Date_New)
ORDER BY Order_Year; 

/* Which category generated the highest sales? */
SELECT Category, ROUND(SUM(Sales),2) AS Total_Sales
FROM orders
GROUP BY Category
ORDER BY Total_Sales DESC; 
/* Which region generated the highest profit?*/
SELECT Region, ROUND(SUM(Profit),2) AS Total_Profit
FROM orders
GROUP BY Region
ORDER BY Total_Profit DESC; 
/* Which customer segment contributed the most sales?*/
SELECT Segment, ROUND(SUM(Sales),2) AS Total_Sales
FROM orders
GROUP BY Segment
ORDER BY Total_Sales DESC; 

/*subquery*/ 
SELECT Product_Name, Sales FROM orders
WHERE Sales >
(
    SELECT AVG(Sales)
    FROM orders
)
ORDER BY Sales DESC;