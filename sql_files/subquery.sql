SELECT
  subquery.id, subquery.avg_duration
FROM
  (
    SELECT 
      start_station_id as id, AVG(tripduration) as avg_duration
    FROM 
      bigquery-public-data.new_york_citibike.citibike_trips
    GROUP BY 
      start_station_id 
    ) as subquery
    order by avg_duration DESC
    