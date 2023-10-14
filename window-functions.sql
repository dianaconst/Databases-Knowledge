-- WINDOW/ANALYTIC FUCNTIONS
    -- Calculate an aggregate value based on a group of rows
    -- Unlike aggregate functions, analytic functions can return multiple rows for each group.
    -- We can use window functions to compute aggregated values, moving averages, running totals, percentages or top-N results within a group and much, much more.
    -- use the OVER() clause

    -- To get the total region population for each country:
    -- We will first get the total region population
    select 
    a.name, 
    a.country_id, 
    total_pop_region, 
    a.region_id, 
    a.population,
    round(a.population / b.total_pop_region * 100, 3) as pop_region_percentage
    from eba_countries a
    left join 
    (select region_id, sum(population) as total_pop_region
    from eba_countries
    group by region_id) b
    on a.region_id = b.region_id
    order by name;

    -- The way with window functions is: 
    select 
    a.name, 
    a.country_id, 
    a.region_id, 
    a.population,
    sum(population) over(partition by a.region_id order by a.region_id) as sum_pop_region, 
    round(population / (sum(population) over(partition by a.region_id order by a.region_id)) * 100, 3) as pop_region_percentage
    from eba_countries a
    order by country_id