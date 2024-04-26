--Temporary Table in SQL

with sales_history as (
  SELECT
    EXTRACT(YEAR FROM Date) AS YEAR --time grouping
  , EXTRACT(MONTH FROM Date) AS MONTH --time grouping
  , ProductId --need to know which products are sold
  , StoreID --need to know which stores are selling
  , SUM(quantity) AS UnitsSold --how many (impacts inventory)
  , AVG(UnitPrice) AS UnitPriceProxy --can be interesting
  , COUNT(DISTINCT salesID) AS NumTransactions --unique transactions can be interesting
  FROM `data-anlytics-419117.imported_datasets.sales` 
  GROUP BY   YEAR,   MONTH, ProductId, StoreID
)
SELECT
 inventory.*
 , (SELECT AVG(UnitsSold) FROM sales_history
      WHERE inventory.ProductID=sales_history.ProductID
      AND inventory.StoreID=sales_history.StoreID) AS avg_quantity_sold_in_a_month
FROM `data-anlytics-419117.imported_datasets.inventory`  AS inventory