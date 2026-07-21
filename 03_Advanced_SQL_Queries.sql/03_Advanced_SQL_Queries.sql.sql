/*=============================================================
  WEEK 3: SQL & DATA QUERYING
  DATASET: Chinook Database
  FILE: 03_Advanced_SQL_Queries.sql

  AUTHOR: Eliud Kigen Kipkorir

  DESCRIPTION
  This script demonstrates advanced SQL concepts using the
  Chinook Music Store Database.

  Concepts Covered
  ----------------
  1. INNER JOIN
  2. LEFT JOIN
  3. RIGHT JOIN
  4. Subqueries
  5. Window Functions
==============================================================*/

USE Chinook;
GO

/*=============================================================
                    SECTION 1 : INNER JOIN
==============================================================*/

/*-------------------------------------------------------------
Query 1
Display every customer together with their invoices.

Business Purpose:
Determine which invoices belong to which customers.
--------------------------------------------------------------*/

SELECT
    c.CustomerId,
    c.FirstName,
    c.LastName,
    i.InvoiceId,
    i.InvoiceDate,
    i.Total
FROM Customer c
INNER JOIN Invoice i
    ON c.CustomerId = i.CustomerId
ORDER BY i.InvoiceDate;


/*-------------------------------------------------------------
Query 2
Display each track together with its album.

Business Purpose:
Identify which album each song belongs to.
--------------------------------------------------------------*/

SELECT
    t.TrackId,
    t.Name AS TrackName,
    a.Title AS AlbumName
FROM Track t
INNER JOIN Album a
    ON t.AlbumId = a.AlbumId
ORDER BY AlbumName;


/*-------------------------------------------------------------
Query 3
Display tracks together with their artist.

Business Purpose:
Identify the artist who performed each track.
--------------------------------------------------------------*/

SELECT
    t.Name AS TrackName,
    ar.Name AS ArtistName,
    al.Title AS Album
FROM Track t
INNER JOIN Album al
    ON t.AlbumId = al.AlbumId
INNER JOIN Artist ar
    ON al.ArtistId = ar.ArtistId
ORDER BY ArtistName;


/*=============================================================
                    SECTION 2 : LEFT JOIN
==============================================================*/

/*-------------------------------------------------------------
Query 4
Display every artist and their albums.

Business Purpose:
Show all artists, including those without albums.
--------------------------------------------------------------*/

SELECT
    ar.Name AS Artist,
    al.Title AS Album
FROM Artist ar
LEFT JOIN Album al
    ON ar.ArtistId = al.ArtistId
ORDER BY Artist;


/*=============================================================
                    SECTION 3 : RIGHT JOIN
==============================================================*/

/*-------------------------------------------------------------
Query 5
Display all albums and their artists.

Business Purpose:
Demonstrate RIGHT JOIN.
--------------------------------------------------------------*/

SELECT
    ar.Name AS Artist,
    al.Title AS Album
FROM Artist ar
RIGHT JOIN Album al
    ON ar.ArtistId = al.ArtistId
ORDER BY Artist;


/*=============================================================
                    SECTION 4 : SUBQUERIES
==============================================================*/

/*-------------------------------------------------------------
Query 6
Find customers who spent more than the average customer.

Business Purpose:
Identify high-value customers.
--------------------------------------------------------------*/

SELECT
    CustomerId,
    FirstName,
    LastName
FROM Customer
WHERE CustomerId IN
(
    SELECT CustomerId
    FROM Invoice
    GROUP BY CustomerId
    HAVING SUM(Total) >
    (
        SELECT AVG(CustomerTotal)
        FROM
        (
            SELECT SUM(Total) AS CustomerTotal
            FROM Invoice
            GROUP BY CustomerId
        ) AS AvgSales
    )
);


/*-------------------------------------------------------------
Query 7
Find tracks that are longer than the average duration.

Business Purpose:
Identify unusually long songs.
--------------------------------------------------------------*/

SELECT
    Name,
    Milliseconds
FROM Track
WHERE Milliseconds >
(
    SELECT AVG(Milliseconds)
    FROM Track
);


/*=============================================================
                SECTION 5 : WINDOW FUNCTIONS
==============================================================*/

/*-------------------------------------------------------------
Query 8
Rank customers based on total spending.

Business Purpose:
Identify VIP customers.
--------------------------------------------------------------*/

SELECT
    c.CustomerId,
    c.FirstName,
    c.LastName,
    SUM(i.Total) AS TotalSpent,

    RANK() OVER
    (
        ORDER BY SUM(i.Total) DESC
    ) AS CustomerRank

FROM Customer c
INNER JOIN Invoice i
    ON c.CustomerId = i.CustomerId

GROUP BY
    c.CustomerId,
    c.FirstName,
    c.LastName;


/*-------------------------------------------------------------
Query 9
Assign row numbers to invoices.

Business Purpose:
Demonstrate ROW_NUMBER().
--------------------------------------------------------------*/

SELECT
    InvoiceId,
    CustomerId,
    Total,

    ROW_NUMBER() OVER
    (
        ORDER BY Total DESC
    ) AS RowNumber

FROM Invoice;


/*-------------------------------------------------------------
Query 10
Rank invoices within each country.

Business Purpose:
Find the highest-value invoice in every country.
--------------------------------------------------------------*/

SELECT
    BillingCountry,
    InvoiceId,
    Total,

    RANK() OVER
    (
        PARTITION BY BillingCountry
        ORDER BY Total DESC
    ) AS CountryRank

FROM Invoice
ORDER BY BillingCountry;


/*=============================================================
END OF ADVANCED SQL QUERIES
==============================================================*/