/*=============================================================
  WEEK 3: SQL & DATA QUERYING
  DATASET: Chinook Database
  FILE: 02_Core_SQL_Queries.sql

  AUTHOR: Eliud Kigen Kipkorir

  DESCRIPTION
  This script demonstrates the core SQL concepts required
  for Week 3 of the Data Analytics Internship.

  Concepts Covered
  ----------------
  1. SELECT
  2. WHERE
  3. ORDER BY
  4. GROUP BY
  5. HAVING
  6. Aggregate Functions

==============================================================*/

USE Chinook;
GO

/*=============================================================
                SECTION 1 : SELECT STATEMENTS
==============================================================*/

/*-------------------------------------------------------------
Query 1
Display all artists in the database.
--------------------------------------------------------------*/

SELECT *
FROM Artist;


/*-------------------------------------------------------------
Query 2
Display all customers.
--------------------------------------------------------------*/

SELECT *
FROM Customer;


/*-------------------------------------------------------------
Query 3
Display only the First Name, Last Name and Country
for every customer.
--------------------------------------------------------------*/

SELECT
    FirstName,
    LastName,
    Country
FROM Customer;


/*=============================================================
                SECTION 2 : WHERE CLAUSE
==============================================================*/

/*-------------------------------------------------------------
Query 4
Display customers from Brazil.
--------------------------------------------------------------*/

SELECT
    CustomerId,
    FirstName,
    LastName,
    Country
FROM Customer
WHERE Country = 'Brazil';


/*-------------------------------------------------------------
Query 5
Display invoices whose total is greater than $10.
--------------------------------------------------------------*/

SELECT
    InvoiceId,
    CustomerId,
    Total
FROM Invoice
WHERE Total > 10;


/*-------------------------------------------------------------
Query 6
Display tracks longer than 5 minutes.
Milliseconds are used for duration.
5 minutes = 300000 milliseconds.
--------------------------------------------------------------*/

SELECT
    Name,
    Milliseconds
FROM Track
WHERE Milliseconds > 300000;


/*=============================================================
                SECTION 3 : ORDER BY
==============================================================*/

/*-------------------------------------------------------------
Query 7
Display artists alphabetically.
--------------------------------------------------------------*/

SELECT *
FROM Artist
ORDER BY Name ASC;


/*-------------------------------------------------------------
Query 8
Display invoices from highest amount to lowest.
--------------------------------------------------------------*/

SELECT
    InvoiceId,
    Total
FROM Invoice
ORDER BY Total DESC;


/*=============================================================
                SECTION 4 : AGGREGATE FUNCTIONS
==============================================================*/

/*-------------------------------------------------------------
Query 9
Count the total number of artists.
--------------------------------------------------------------*/

SELECT COUNT(*) AS TotalArtists
FROM Artist;


/*-------------------------------------------------------------
Query 10
Calculate total sales.
--------------------------------------------------------------*/

SELECT SUM(Total) AS TotalRevenue
FROM Invoice;


/*-------------------------------------------------------------
Query 11
Calculate average invoice amount.
--------------------------------------------------------------*/

SELECT AVG(Total) AS AverageInvoice
FROM Invoice;


/*-------------------------------------------------------------
Query 12
Find the highest invoice amount.
--------------------------------------------------------------*/

SELECT MAX(Total) AS HighestInvoice
FROM Invoice;


/*-------------------------------------------------------------
Query 13
Find the lowest invoice amount.
--------------------------------------------------------------*/

SELECT MIN(Total) AS LowestInvoice
FROM Invoice;


/*=============================================================
                SECTION 5 : GROUP BY
==============================================================*/

/*-------------------------------------------------------------
Query 14
Count customers in each country.
--------------------------------------------------------------*/

SELECT
    Country,
    COUNT(*) AS NumberOfCustomers
FROM Customer
GROUP BY Country
ORDER BY NumberOfCustomers DESC;


/*-------------------------------------------------------------
Query 15
Calculate total sales by billing country.
--------------------------------------------------------------*/

SELECT
    BillingCountry,
    SUM(Total) AS Revenue
FROM Invoice
GROUP BY BillingCountry
ORDER BY Revenue DESC;


/*=============================================================
                SECTION 6 : HAVING
==============================================================*/

/*-------------------------------------------------------------
Query 16
Display countries having more than five customers.
--------------------------------------------------------------*/

SELECT
    Country,
    COUNT(*) AS TotalCustomers
FROM Customer
GROUP BY Country
HAVING COUNT(*) > 5
ORDER BY TotalCustomers DESC;


/*-------------------------------------------------------------
END OF CORE SQL QUERIES
--------------------------------------------------------------*/