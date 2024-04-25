SELECT 
EXTRACT(YEAR FROM starttime) as year,
COUNT(*) as number_of_rides
FROM `bigquery-public-data.new_york.citibike_trips` 
GROUP BY year
ORDER BY year DESC