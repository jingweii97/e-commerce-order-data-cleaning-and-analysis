-- Data Loading

-- Load the data from different marketplace income
SELECT*FROM VShopeeIncome
SELECT*FROM VLazadaIncome

INSERT INTO SalesReport ([OrderId],[Marketplace],[TransactionDate],[OrderIncome],[Cost],[NettIncome])
SELECT [Order ID], 'Shopee',[Payout Completed Date], [Total Released Amount (RM)], [CostPerOrder],[NettIncome]
FROM VShopeeIncome
WHERE NOT EXISTS (
    SELECT 1 
    FROM SalesReport
    WHERE SalesReport.[OrderId] = VShopeeIncome.[Order ID]
);

INSERT INTO SalesReport ([OrderId],[Marketplace],[TransactionDate],[OrderIncome],[Cost],[NettIncome])
SELECT [Order Number], 'Lazada',[Release Date],[Released_Amount], [CostPerOrder],[NettIncome]
FROM VLazadaIncome
WHERE NOT EXISTS (
    SELECT 1 
    FROM SalesReport
    WHERE SalesReport.[OrderId] = CAST(VLazadaIncome.[Order Number] as varchar(50))
);

-- Manually check if order is returned and stock is still sellable
UPDATE SalesReport
SET [IsReturnOrder] = 'True'
WHERE [OrderId] = 'DUMMY_SHOPEE_1' OR [OrderId] = 'DUMMY_SHOPEE_2'

UPDATE SalesReport
SET [ReturnedStockHasDefect] = 'True'
WHERE [OrderId] = 'DUMMY_SHOPEE_1'

UPDATE SalesReport
SET [ReturnedStockHasDefect] = 'False'
WHERE [OrderId] = 'DUMMY_SHOPEE_2'