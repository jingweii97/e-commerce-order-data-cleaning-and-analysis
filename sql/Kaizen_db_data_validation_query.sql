-- Data validation query

-- Check which orderline has no cost, need to update the cost in sku master
SELECT*FROM VCostPerOrderline WHERE Cost IS NULL