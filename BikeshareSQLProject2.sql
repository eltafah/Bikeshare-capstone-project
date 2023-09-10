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

select member_casual, started_at, ended_at, ride_duration
from bikeride$

