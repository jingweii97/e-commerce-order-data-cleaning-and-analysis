-- This Query mainly for one-time use, after creating tables, adding necessary constraints

--CREATE PRIMARY KEY FOR SHOPEE INCOME
SELECT *
  FROM [Kaizen_db].[dbo].[Shopee_Income]

ALTER TABLE [Kaizen_db].[dbo].[Shopee_Income]
ALTER COLUMN [ORDER ID] varchar(255) NOT NULL

ALTER TABLE [Kaizen_db].[dbo].[Shopee_Income]
ADD PRIMARY KEY ([Order ID])

--CREATE PRIMARY KEY FOR LAZADA INCOME
SELECT *
  FROM [Kaizen_db].[dbo].[Lazada_Income]

ALTER TABLE [Kaizen_db].[dbo].[Lazada_Income]
ALTER COLUMN [Order Line ID] BIGINT NOT null


ALTER TABLE [Kaizen_db].[dbo].[Lazada_Income]
ADD PRIMARY KEY ([Order Line ID])
SELECT [Kaizen_db].dbo.OrderData.[Marketplace Order ID]

-- CREATE PRIMARY KEY FOR MISC COST
ALTER TABLE [Kaizen_db].[dbo].[MiscCost]
ALTER COLUMN [DATE] DATETIME NOT null

ALTER TABLE [Kaizen_db].[dbo].[MiscCost]
ADD PRIMARY KEY ([DATE])
