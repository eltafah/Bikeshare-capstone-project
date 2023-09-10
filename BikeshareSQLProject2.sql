--find the duration of every ride

select member_casual, started_at,
 ended_at, 
 DATEDIFF(minute, started_at, ended_at) AS duration
 from bikeride$

--insert the values of the duration to the column ride_duration
UPDATE bikeride$
SET ride_duration = duration.duration FROM bikeride$
JOIN (select member_casual, started_at, ended_at,
DATEDIFF(minute, started_at, ended_at) AS duration 
from bikeride$) AS duration 
ON bikeride$.member_casual = duration.member_casual 
AND bikeride$.started_at = duration.started_at 
AND bikeride$.ended_at = duration.ended_at;

-- Select the month and the number of rides for each month
SELECT DATEPART(month, started_at) AS month, COUNT(*) AS rides
FROM bikeride$
GROUP BY DATEPART(month, started_at)
ORDER BY rides DESC;

-- Get the number of rides in the dataset
SELECT COUNT(*) AS total_rides
FROM bikeride$;

-- Get the average duration of the rides in minutes
SELECT AVG(ride_duration) AS average_duration
FROM bikeride$;

-- Get the most popular start stations and the number of rides starting from there
SELECT TOP 5 start_station_id, COUNT(*) AS rides
FROM bikeride$
GROUP BY start_station_id
ORDER BY rides DESC;


-- Select the month and the number of rides for each month
-- Rank the months by the number of rides in descending order
-- Filter only the top-ranked month
SELECT month, rides
FROM (
  SELECT DATEPART(month, started_at) AS month, COUNT(*) AS rides,
  RANK() OVER (ORDER BY COUNT(*) DESC) AS rank
  FROM bikeride$
  GROUP BY DATEPART(month, started_at)
) AS subquery
WHERE rank = 1;
 

 To find the months with the lowest rides, you can use a similar approach as the previous query, but with some modifications. For example:

```sql
-- Select the month and the number of rides for each month
-- Rank the months by the number of rides in ascending order
-- Filter only the bottom-ranked month
SELECT month, rides
FROM (
  SELECT DATEPART(month, started_at) AS month, COUNT(*) AS rides,
  RANK() OVER (ORDER BY COUNT(*)) AS rank
  FROM bikeride$
  GROUP BY DATEPART(month, started_at)
) AS subquery
WHERE rank = 1;


