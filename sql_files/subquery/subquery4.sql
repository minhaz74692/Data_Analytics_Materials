SELECT 
  Warehouse.warehouse_id,
  CONCAT(Warehouse.state, ":", Warehouse.warehouse_alias) as warehouse_name,
  COUNT(Orders.order_id) as number_of_order,
  (
    SELECT COUNT(*) FROM `data-anlytics-419117.imported_datasets.warehouse_orders`  as order_count
  )as total_orders,
   CASE
    WHEN COUNT(Orders.order_id)/(SELECT COUNT(*) FROM `data-anlytics-419117.imported_datasets.warehouse_orders` AS Orders) <= 0.20
    THEN 'Fulfilled 0-20% of Orders'
    WHEN COUNT(Orders.order_id)/(SELECT COUNT(*) FROM `data-anlytics-419117.imported_datasets.warehouse_orders` AS Orders) > 0.20
    AND COUNT(Orders.order_id)/(SELECT COUNT(*) FROM `data-anlytics-419117.imported_datasets.warehouse_orders` AS Orders) <= 0.60
    THEN 'Fulfilled 21-60% of Orders'
    ELSE 'Fulfilled more than 60% of Orders'
  END AS fulfillment_summary
FROM 
  `data-anlytics-419117.imported_datasets.warehouse_datatable` as Warehouse 
LEFT JOIN `data-anlytics-419117.imported_datasets.warehouse_orders` as Orders
ON Warehouse.warehouse_id = Orders.warehouse_id
GROUP BY 
  Warehouse.warehouse_id,
  warehouse_name
LIMIT 25