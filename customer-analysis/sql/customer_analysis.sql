-- Customer Analysis | Microsoft SQL Server (T-SQL)
SELECT COUNT(*) AS CustomerCount, SUM(Orders) AS TotalOrders,
       SUM(TotalSpend) AS TotalCustomerSpend,
       AVG(TotalSpend) AS AverageSpendPerCustomer
FROM dbo.CustomerAnalysis;

SELECT Segment, COUNT(*) AS Customers, SUM(TotalSpend) AS TotalSpend,
       AVG(TotalSpend) AS AverageCustomerSpend
FROM dbo.CustomerAnalysis
GROUP BY Segment ORDER BY TotalSpend DESC;

SELECT Region, COUNT(*) AS Customers, SUM(TotalSpend) AS TotalSpend
FROM dbo.CustomerAnalysis
GROUP BY Region ORDER BY TotalSpend DESC;

SELECT CustomerID, CustomerName, Orders, TotalSpend
FROM dbo.CustomerAnalysis
WHERE Orders >= 4 ORDER BY Orders DESC, TotalSpend DESC;

SELECT CustomerID, CustomerName, Region, Segment, LastPurchaseDaysAgo, TotalSpend
FROM dbo.CustomerAnalysis
WHERE LastPurchaseDaysAgo > 30 ORDER BY LastPurchaseDaysAgo DESC;

SELECT CustomerID, CustomerName, Region, TotalSpend
FROM dbo.CustomerAnalysis
WHERE TotalSpend > (SELECT AVG(TotalSpend) FROM dbo.CustomerAnalysis)
ORDER BY TotalSpend DESC;

WITH RankedCustomers AS (
    SELECT CustomerID, CustomerName, Region, TotalSpend,
           DENSE_RANK() OVER (PARTITION BY Region ORDER BY TotalSpend DESC) AS SpendRank
    FROM dbo.CustomerAnalysis
)
SELECT CustomerID, CustomerName, Region, TotalSpend, SpendRank
FROM RankedCustomers ORDER BY Region, SpendRank;
