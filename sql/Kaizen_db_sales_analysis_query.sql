-- OVERVIEW
SELECT * FROM Kaizen_db.dbo.SalesReport


--Income Analysis
DECLARE @month int, @year int, @marketplace nvarchar(50)
SET @month = 9;
SET @year = 2024;

EXEC Kaizen_db.dbo.GetIncomeOverview @Year = 2024, @Month = 9;


