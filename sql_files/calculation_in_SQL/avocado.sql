SELECT 
  Date,
  Region,
  Small_Bags,
  Large_Bags,
  XLarge_Bags,
  Total_Bags ,
  Small_Bags + Large_Bags + XLarge_Bags AS Total_Bags_Calc ,
  (Small_Bags / Total_Bags)*100 AS Small_Bags_Percent
FROM `data-anlytics-419117.imported_datasets.avocado` 