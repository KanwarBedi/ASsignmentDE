-- WITH buy_sell_data AS (
--     SELECT 
--         Container_Number,
--         type,
--         priceQuantity AS price,
--         quantity,
--         logisticCostPerTon,
--         name AS customer_supplier
    
--     FROM dataset
-- )
-- SELECT 
--     b.Container_Number,
   
--     b.customer_supplier AS customer,
--     s.customer_supplier AS supplier,
--     b.price AS sell_price,
--     s.price AS buy_price,
--     b.quantity,
--     COALESCE(b.logisticCostPerTon, 0) AS logistic_cost,
--     (b.price - s.price - COALESCE(b.logisticCostPerTon, 0)) AS margin
-- FROM buy_sell_data b
-- JOIN buy_sell_data s ON b.Container_Number = s.Container_Number
-- WHERE b.type = 'SELL' AND s.type = 'BUY';

WITH CTE AS (
    SELECT 
        Container_Number,
        type,
        priceQuantity,
        quantity,
        logisticCostPerTon,
        name AS customer_supplier
    FROM dataset
)

SELECT 
    Container_Number,
    SUM(CASE WHEN type = 'SELL' THEN priceQuantity * quantity ELSE 0 END) AS total_sale_amount,
    SUM(CASE WHEN type = 'BUY' THEN priceQuantity * quantity ELSE 0 END) AS total_purchase_amount,
    SUM(CASE WHEN type = 'SELL' THEN priceQuantity * quantity ELSE 0 END) - SUM(CASE WHEN type = 'BUY' THEN priceQuantity * quantity ELSE 0 END) - SUM(logisticCostPerTon * quantity) AS total_margin,
    customer_supplier
FROM CTE
GROUP BY Container_Number, customer_supplier