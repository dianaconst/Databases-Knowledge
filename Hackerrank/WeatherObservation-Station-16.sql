/*
https://www.hackerrank.com/challenges/weather-observation-station-16/problem*/
select 
round(lat_n, 4) as result
from station
where lat_n = (select min(lat_n) from station where lat_n > 38.7780);