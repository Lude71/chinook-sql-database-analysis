/*=============================================================
  WEEK 3: SQL & DATA QUERYING
  DATASET: Chinook Database
  FILE: 04_Business_Analysis.sql

  AUTHOR: Eliud Kigen Kipkorir

  DESCRIPTION
  This script answers business questions using SQL queries.
  The analysis helps management understand customer behavior,
  revenue trends and product performance.

==============================================================*/

USE Chinook;
GO

/*=============================================================
BUSINESS QUESTION 1
Who are the Top 10 Customers by Total Spending?
==============================================================*/

SELECT TOP 10
    c.CustomerId,
    c.FirstName,
    c.LastName,
    c.Country,
    SUM(i.Total) AS TotalSpent
FROM Customer c
INNER JOIN Invoice i
    ON c.CustomerId = i.CustomerId
GROUP BY
    c.CustomerId,
    c.FirstName,
    c.LastName,
    c.Country
ORDER BY TotalSpent DESC;


/*=============================================================
BUSINESS QUESTION 2
Which Countries Generate the Highest Revenue?
==============================================================*/

SELECT
    BillingCountry,
    SUM(Total) AS Revenue
FROM Invoice
GROUP BY BillingCountry
ORDER BY Revenue DESC;


/*=============================================================
BUSINESS QUESTION 3
Which Customers Have Made the Most Purchases?
==============================================================*/

SELECT
    c.CustomerId,
    c.FirstName,
    c.LastName,
    COUNT(i.InvoiceId) AS NumberOfPurchases
FROM Customer c
INNER JOIN Invoice i
    ON c.CustomerId = i.CustomerId
GROUP BY
    c.CustomerId,
    c.FirstName,
    c.LastName
ORDER BY NumberOfPurchases DESC;


/*=============================================================
BUSINESS QUESTION 4
Which Music Genres Generate the Most Sales?
==============================================================*/

SELECT
    g.Name AS Genre,
    COUNT(il.InvoiceLineId) AS TracksSold
FROM InvoiceLine il
INNER JOIN Track t
    ON il.TrackId = t.TrackId
INNER JOIN Genre g
    ON t.GenreId = g.GenreId
GROUP BY g.Name
ORDER BY TracksSold DESC;


/*=============================================================
BUSINESS QUESTION 5
Which Artists Sell the Most Tracks?
==============================================================*/

SELECT TOP 10
    ar.Name AS Artist,
    COUNT(il.InvoiceLineId) AS TracksSold
FROM InvoiceLine il
INNER JOIN Track t
    ON il.TrackId = t.TrackId
INNER JOIN Album al
    ON t.AlbumId = al.AlbumId
INNER JOIN Artist ar
    ON al.ArtistId = ar.ArtistId
GROUP BY ar.Name
ORDER BY TracksSold DESC;


/*=============================================================
BUSINESS QUESTION 6
Which Albums Sell the Most Tracks?
==============================================================*/

SELECT TOP 10
    al.Title AS Album,
    COUNT(il.InvoiceLineId) AS TracksSold
FROM InvoiceLine il
INNER JOIN Track t
    ON il.TrackId = t.TrackId
INNER JOIN Album al
    ON t.AlbumId = al.AlbumId
GROUP BY al.Title
ORDER BY TracksSold DESC;


/*=============================================================
BUSINESS QUESTION 7
What is the Average Customer Spending?
==============================================================*/

SELECT
    AVG(CustomerTotal) AS AverageCustomerSpending
FROM
(
    SELECT
        CustomerId,
        SUM(Total) AS CustomerTotal
    FROM Invoice
    GROUP BY CustomerId
) AS CustomerSales;


/*=============================================================
BUSINESS QUESTION 8
Which Employee Supports the Highest Number of Customers?
==============================================================*/

SELECT
    e.FirstName,
    e.LastName,
    COUNT(c.CustomerId) AS CustomersSupported
FROM Employee e
INNER JOIN Customer c
    ON e.EmployeeId = c.SupportRepId
GROUP BY
    e.FirstName,
    e.LastName
ORDER BY CustomersSupported DESC;


/*=============================================================
BUSINESS QUESTION 9
Monthly Revenue Trend
==============================================================*/

SELECT
    YEAR(InvoiceDate) AS SalesYear,
    MONTH(InvoiceDate) AS SalesMonth,
    SUM(Total) AS Revenue
FROM Invoice
GROUP BY
    YEAR(InvoiceDate),
    MONTH(InvoiceDate)
ORDER BY
    SalesYear,
    SalesMonth;


/*=============================================================
BUSINESS QUESTION 10
Highest Value Invoices
==============================================================*/

SELECT TOP 10
    InvoiceId,
    CustomerId,
    InvoiceDate,
    Total
FROM Invoice
ORDER BY Total DESC;


/*=============================================================
BUSINESS QUESTION 11
Most Popular Media Types
==============================================================*/

SELECT
    mt.Name AS MediaType,
    COUNT(il.InvoiceLineId) AS Purchases
FROM InvoiceLine il
INNER JOIN Track t
    ON il.TrackId = t.TrackId
INNER JOIN MediaType mt
    ON t.MediaTypeId = mt.MediaTypeId
GROUP BY mt.Name
ORDER BY Purchases DESC;


/*=============================================================
BUSINESS QUESTION 12
Playlists with the Highest Number of Tracks
==============================================================*/

SELECT
    p.Name AS Playlist,
    COUNT(pt.TrackId) AS NumberOfTracks
FROM Playlist p
INNER JOIN PlaylistTrack pt
    ON p.PlaylistId = pt.PlaylistId
GROUP BY p.Name
ORDER BY NumberOfTracks DESC;


/*=============================================================
BUSINESS QUESTION 13
Most Expensive Tracks
==============================================================*/

SELECT TOP 10
    Name,
    UnitPrice
FROM Track
ORDER BY UnitPrice DESC;


/*=============================================================
BUSINESS QUESTION 14
Countries with the Highest Number of Customers
==============================================================*/

SELECT
    Country,
    COUNT(*) AS Customers
FROM Customer
GROUP BY Country
ORDER BY Customers DESC;


/*=============================================================
BUSINESS QUESTION 15
Top Customers Ranked by Spending
==============================================================*/

SELECT
    c.CustomerId,
    c.FirstName,
    c.LastName,
    SUM(i.Total) AS TotalSpent,

    RANK() OVER
    (
        ORDER BY SUM(i.Total) DESC
    ) AS SpendingRank

FROM Customer c
INNER JOIN Invoice i
    ON c.CustomerId = i.CustomerId

GROUP BY
    c.CustomerId,
    c.FirstName,
    c.LastName

ORDER BY SpendingRank;

GO

/*=============================================================
END OF BUSINESS ANALYSIS
==============================================================*/