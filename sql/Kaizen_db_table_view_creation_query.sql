-- Canvas to execute all necessary modification query, inc creation/alter of table, view and procedures

-- VIEW CREATION/ALTER
CREATE VIEW VCostPerOrderline AS
SELECT  [Marketplace Order ID] , [Shipping Note],[Marketplace],[SKU],[Quantity], (sm.CostPrice * od.Quantity) AS [Cost]
	FROM [Kaizen_db].dbo.OrderData as od LEFT JOIN [Kaizen_db].dbo.SkuMaster as sm
	ON od.SKU = sm.SkuId

CREATE VIEW VCostPerOrder AS
SELECT [Marketplace Order ID], [Shipping Note],[Marketplace] ,SUM([Cost]) AS [CostPerOrder] 
FROM VCostPerOrderline GROUP BY [Marketplace Order ID], [Shipping Note],[Marketplace]


-- Insert all the necessary data from shopee to income analysis (only those that are not in report)

-- Store the necessary data and calculated aggregation in view
-- Such that we can directly import to sales report later

-- Do this for each marketplace
-- VShopeeIncome
CREATE VIEW VShopeeIncome AS 
SELECT SI.[Order ID], SI.[Payout Completed Date], SI.[Total Released Amount (RM)],
CAST(VCOST.CostPerOrder AS DECIMAL(10,2)) AS CostPerOrder, 
CAST((SI.[Total Released Amount (RM)] - VCOST.CostPerOrder) AS DECIMAL(10,2)) AS NettIncome
FROM Kaizen_db.dbo.Shopee_Income as SI LEFT JOIN VCostPerOrder as VCOST
ON SI.[Order ID] = VCOST.[Marketplace Order ID]

-- VLazadaIncome
CREATE VIEW VLazadaIncome AS 
WITH Lzd_Income_Cte AS
(
	SELECT LI.[Order Number], LI.[Release Date] ,SUM (LI.[Amount(Include Tax)]) AS Released_Amount
	FROM Kaizen_db.dbo.Lazada_Income as LI
	GROUP BY LI.[Order Number], LI.[Release Date]
)
SELECT LI.[Order Number], LI.[Release Date] ,LI.Released_Amount, CAST(VCOST.CostPerOrder AS DECIMAL(10,2)) AS CostPerOrder
,CAST((Released_Amount - VCOST.CostPerOrder) AS DECIMAL(10,2)) AS NettIncome
FROM Lzd_Income_Cte as LI LEFT JOIN VCostPerOrder as VCOST
ON CAST(LI.[Order Number] as VARCHAR) = VCOST.[Marketplace Order ID]

---- CREATE VIEW FOR Platform income and cost
--CREATE VIEW VPlatformIncomeCost
--SELECT [Marketplace], SUM(OrderIncome) as Total_Order_Income, SUM(Cost) as Total_Cost, 
--SUM(NettIncome) as Total_Nett_Income
--FROM Kaizen_db.dbo.SalesReport
--WHERE ((IsReturnOrder = 1 AND ReturnedStockHasDefect =1) OR IsReturnOrder is NULL)
--GROUP BY [Marketplace]

-- TABLE CREATION/ALTER
----Create table
--CREATE TABLE SalesReport (
--    OrderId varchar(255) NOT NULL PRIMARY KEY,
--	Marketplace varchar(255),
--	TransactionDate DateTime,
--	OrderIncome float,
--	Cost float,
--	NettIncome float 
--);

----Create table
CREATE TABLE Kaizen_db.dbo.MiscCost (
    [Date] DateTime,
	[FulfillmentCost] DECIMAL(10,2),
	[ShopeeAds] DECIMAL(10,2)
);

-- Add column here if necessary
--ALTER TABLE IncomeAnalysis 
--ADD ColumnName type
--;

--ALTER TABLE SalesReport 
--ADD IsReturnOrder BIT
--;

--ALTER TABLE SalesReport 
--ADD ReturnedStockHasDefect BIT
--;

-- PROCEDURE CREATION
CREATE PROCEDURE GetIncomeOverview
    @year INT,
    @month INT
AS
BEGIN
	WITH Order_Income_CTE AS
	(
		SELECT @month as [Month], SUM(SR.OrderIncome) as Total_Order_Income, SUM(SR.Cost) as Total_Cost, 
		SUM(SR.NettIncome) as Total_Nett_Income
		FROM Kaizen_db.dbo.SalesReport as SR 
		WHERE MONTH(SR.TransactionDate) = @month AND YEAR(SR.TransactionDate) = @year
		AND ((IsReturnOrder = 1 AND ReturnedStockHasDefect =1) OR IsReturnOrder is NULL)
	),
	Misc_Cost_CTE AS
	(
		SELECT @month as [Month], * FROM Kaizen_db.dbo.MiscCost
		WHERE MONTH([Date]) = @month AND YEAR([Date]) = @year
	)

	SELECT OI.*, MC.FulfillmentCost,MC.ShopeeAds, 
	(OI.Total_Nett_Income - MC.FulfillmentCost - MC.ShopeeAds)AS [Nett_Profit] 
	FROM Order_Income_CTE as OI CROSS JOIN Misc_Cost_CTE as MC

END;




