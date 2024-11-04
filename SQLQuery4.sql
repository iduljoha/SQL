ALTER TABLE WalmartSalesData
ADD time_of_day VARCHAR(10);

UPDATE  WalmartSalesData
SET time_of_day = 
    CASE 
        WHEN DATEPART(HOUR, time) < 12 THEN 'Morning'
        WHEN DATEPART(HOUR, time) < 18 THEN 'Afternoon'
        ELSE 'Evening'
    END;


	ALTER TABLE WalmartSalesData
   ALTER COLUMN day_name VARCHAR(3);

	



UPDATE  WalmartSalesData
SET day_name = 
    CASE 
        WHEN DATENAME(WEEKDAY, date) = 'Monday' THEN 'Mon'
        WHEN DATENAME(WEEKDAY, date) = 'Tuesday' THEN 'Tue'
        WHEN DATENAME(WEEKDAY, date) = 'Wednesday' THEN 'Wed'
        WHEN DATENAME(WEEKDAY, date) = 'Thursday' THEN 'Thu'
        WHEN DATENAME(WEEKDAY, date) = 'Friday' THEN 'Fri'
        ELSE NULL  -- Assuming we only want weekdays; you could handle Sat/Sun if needed.
    END;


ALTER TABLE  WalmartSalesData
ADD month_name VARCHAR(3);

UPDATE WalmartSalesData
SET month_name = 
    CASE 
        WHEN MONTH(date) = 1 THEN 'Jan'
        WHEN MONTH(date) = 2 THEN 'Feb'
        WHEN MONTH(date) = 3 THEN 'Mar'
        WHEN MONTH(date) = 4 THEN 'Apr'
        WHEN MONTH(date) = 5 THEN 'May'
        WHEN MONTH(date) = 6 THEN 'Jun'
        WHEN MONTH(date) = 7 THEN 'Jul'
        WHEN MONTH(date) = 8 THEN 'Aug'
        WHEN MONTH(date) = 9 THEN 'Sep'
        WHEN MONTH(date) = 10 THEN 'Oct'
        WHEN MONTH(date) = 11 THEN 'Nov'
        WHEN MONTH(date) = 12 THEN 'Dec'
        ELSE NULL  -- This case should not occur, but it's good to include.
    END;

select* from WalmartSalesData

SELECT COUNT(DISTINCT city) AS UniqueCityCount
FROM WalmartSalesData;

SELECT DISTINCT branch, city
FROM WalmartSalesData;

SELECT COUNT(DISTINCT product_line) AS UniqueProductLineCount
FROM WalmartSalesData;

SELECT TOP 1 payment, COUNT(*) AS Count
FROM WalmartSalesData
GROUP BY payment
ORDER BY Count DESC;

SELECT TOP 1 product_line, SUM(total) AS TotalSales
FROM WalmartSalesData
GROUP BY product_line
ORDER BY TotalSales DESC;

SELECT 
    FORMAT(date, 'MMMM') AS MonthName,
    SUM(total) AS TotalRevenue
FROM 
    WalmartSalesData
GROUP BY 
    FORMAT(date, 'MMMM')


	SELECT TOP 1 
    FORMAT(date, 'MMMM') AS MonthName,
    SUM(cogs) AS TotalCOGS
FROM 
    WalmartSalesData
GROUP BY 
    FORMAT(date, 'MMMM')
ORDER BY 
    TotalCOGS DESC;

	SELECT TOP 1 
    product_line, 
    SUM(total) AS TotalRevenue
FROM 
    WalmartSalesData
GROUP BY 
    product_line
ORDER BY 
    TotalRevenue DESC;

	SELECT TOP 1 
    city, 
    SUM(total) AS TotalRevenue
FROM 
    WalmartSalesData
GROUP BY 
    city
ORDER BY 
    TotalRevenue DESC;

	WITH AverageSales AS (
    SELECT 
        AVG(total) AS AvgSales
    FROM 
        WalmartSalesData
)

SELECT 
    product_line,
    SUM(total) AS TotalSales,
    CASE 
        WHEN SUM(total) > (SELECT AvgSales FROM AverageSales) THEN 'Good'
        ELSE 'Bad'
    END AS SalesStatus
FROM 
    WalmartSalesData
GROUP BY 
    product_line
ORDER BY 
    TotalSales DESC;


	WITH AverageSales AS (
    SELECT 
        AVG(quantity) AS AvgQuantity
    FROM 
        WalmartSalesData
)

SELECT 
    branch,
    SUM(quantity) AS TotalQuantity
FROM 
    WalmartSalesData
GROUP BY 
    branch
HAVING 
    SUM(quantity) > (SELECT AvgQuantity FROM AverageSales)
ORDER BY 
    TotalQuantity DESC;


	SELECT 
    gender,
    product_line,
    COUNT(*) AS ProductLineCount
FROM 
    WalmartSalesData
GROUP BY 
    gender, product_line
ORDER BY 
    gender, ProductLineCount DESC;


	SELECT 
    product_line,
    AVG(rating) AS AverageRating
FROM 
    WalmartSalesData
GROUP BY 
    product_line
ORDER BY 
    AverageRating DESC;

	SELECT 
    day_name,
    time_of_day,
    COUNT(*) AS NumberOfSales
FROM 
    WalmartSalesData
GROUP BY 
    day_name, time_of_day
ORDER BY 
    day_name, time_of_day;


	SELECT 
    customer_type,
    SUM(total) AS TotalRevenue
FROM 
    WalmartSalesData
GROUP BY 
    customer_type
ORDER BY 
    TotalRevenue DESC;



	SELECT 
    COUNT(DISTINCT customer_type) AS UniqueCustomerTypes
FROM 
    WalmartSalesData;

	SELECT 
    COUNT(DISTINCT payment) AS UniquePaymentMethods
FROM 
    WalmartSalesData;

	SELECT top 1
    customer_type,
    COUNT(*) AS CustomerCount
FROM 
    WalmartSalesData
GROUP BY 
    customer_type
ORDER BY 
    CustomerCount DESC
 -- Use TOP 1 instead of LIMIT for SQL Server


 SELECT top 1
    customer_type,
    SUM(quantity) AS TotalPurchases
FROM 
    WalmartSalesData
GROUP BY 
    customer_type
ORDER BY 
    TotalPurchases DESC
  -- Use TOP 1 instead of LIMIT for SQL Server

  SELECT top 1
    gender,
    COUNT(*) AS CustomerCount
FROM 
    WalmartSalesData
GROUP BY 
    gender
ORDER BY 
    CustomerCount DESC



	SELECT 
    branch,
    gender,
    COUNT(*) AS CustomerCount
FROM 
    WalmartSalesData
GROUP BY 
    branch, gender
ORDER BY 
    branch, CustomerCount DESC;



	SELECT 
    CASE 
        WHEN DATEPART(HOUR, time) < 12 THEN 'Morning'
        WHEN DATEPART(HOUR, time) < 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS TimeOfDay,
    SUM(rating) AS TotalRatings
FROM 
    WalmartSalesData
GROUP BY 
    CASE 
        WHEN DATEPART(HOUR, time) < 12 THEN 'Morning'
        WHEN DATEPART(HOUR, time) < 17 THEN 'Afternoon'
        ELSE 'Evening'
    END
ORDER BY 
    TotalRatings DESC;


	SELECT 
    branch,
    CASE 
        WHEN DATEPART(HOUR, time) < 12 THEN 'Morning'
        WHEN DATEPART(HOUR, time) < 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS TimeOfDay,
    SUM(rating) AS TotalRatings
FROM 
    WalmartSalesData
GROUP BY 
    branch,
    CASE 
        WHEN DATEPART(HOUR, time) < 12 THEN 'Morning'
        WHEN DATEPART(HOUR, time) < 17 THEN 'Afternoon'
        ELSE 'Evening'
    END
ORDER BY 
    branch, TotalRatings DESC;



	SELECT 
    DATENAME(WEEKDAY, date) AS DayOfWeek,
    AVG(rating) AS AverageRating
FROM 
    WalmartSalesData
GROUP BY 
    DATENAME(WEEKDAY, date)
ORDER BY 
    AverageRating DESC;



	SELECT 
    branch,
    DATENAME(WEEKDAY, date) AS DayOfWeek,
    AVG(rating) AS AverageRating
FROM 
    WalmartSalesData
GROUP BY 
    branch,
    DATENAME(WEEKDAY, date)
ORDER BY 
    branch, AverageRating DESC;


