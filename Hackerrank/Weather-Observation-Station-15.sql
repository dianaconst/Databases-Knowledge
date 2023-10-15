-- A link on why you can't do aggregates in the WHERE clause: https://learnsql.com/blog/aggregate-functions-in-where-clause/#:~:text=Aggregate%20functions%20are%20not%20allowed,for%20filtering%20data%20before%20aggregation.

/*
https://www.hackerrank.com/challenges/weather-observation-station-15/problem
*/
select 
round(long_w, 4) as western_long
from station
where lat_n = (select max(lat_n) from station where lat_n < 137.2345);