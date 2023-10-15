-- 1) Find the population difference between the countries in the current row vs the country with the highest population
-- a)
select 
country_id,
name,
population,
max(population) over() as max_pop,
(select max(population) from eba_countries) - population as difference
from eba_countries;
-- b) Not in ORacle
select 
country_id,
name,
population,
max(population) over() - coalesce(population, 0) as max_pop,
from eba_countries;
-- c) Apparently reversing them worked
select 
country_id,
name,
population,
abs(coalesce(population, 0) - max(population) over()) as diff
from eba_countries;


-- 2) Arrange the countries in order of population frm largest to smallest and find the difference between the population of the current rows country and the country immediately following it
-- a)
select 
country_id,
name,
population,
coalesce(lag(population) over(order by population), 0) as next_smallest,
population - coalesce(lag(population) over(order by population), 0) as diff
from eba_countries
order by population desc;
-- b)
select 
country_id,
name,
population,
coalesce(lead(population, 1) over(order by population desc), 0) as next_smallest,
population - coalesce(lead(population, 1) over(order by population desc), 0) as variance
from eba_countries;


-- 3. Flag a country that is in the top 10 percentile for its region in terms of population
select 
country_id,
name,
population,
region_id,
percent_rank() over(partition by region_id order by population desc) as percentiles_per_region,
case when 
    percent_rank() over(partition by region_id order by population desc) <= 0.1 then 1
    else 0
end as top10_percentile
from eba_countries
order by percentiles_per_region asc;


-- 4. Order the countries by population in ascending order and create a running total field for the population.
select 
country_id,
name,
population,
sum(population) over(order by population rows unbounded preceding)
from eba_countries
order by population;



