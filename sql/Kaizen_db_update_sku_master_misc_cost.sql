-- Query to update new sku and respective cost price
SELECT * FROM SkuMaster ORDER BY SkuId
INSERT INTO SkuMaster (SkuId,CostPrice)
VALUES 
('ARM_REST_BLACK',10),
('ARM_REST_BLACK_SET',20) 

-- Query to update misc cost
SELECT * FROM Kaizen_db.dbo.MiscCost

INSERT INTO Kaizen_db.dbo.MiscCost ([Date],[FulfillmentCost],[ShopeeAds])
VALUES 
('2024-8-31',700.5,220.3),
('2024-9-30',595.63,260.4)