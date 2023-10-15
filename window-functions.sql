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

    -- FRAMES EXAMPLES

    -- ROWS
    -- ROWS 1 PRECEDING = previous row
    select 
    sum(population) over (
        partition by region_id
        order by sub_region_id
        ROWS UNBOUNDED PRECEDING AND 1 FOLLOWING-- This means that it will get the sum of all preceding rows + itself + 1 after itself(= current row) 
    )

    -- RANGE
    -- RANGE 1 PRECEDING = if we have subregion_id = 20, then 1 preceding is 19.
    select 
    sum(population) over (
        partition by region_id
        order by sub_region_id
        RANGE BETWEEN UNBOUNDED PRECEDING AND 10 FOLLOWING -- IT CONSIDERS a range of numerical values and compares them to the column value for the column that has been used in the ORDER BY clause. If you do not have anything in your ORDER BY clause, you cannot use range.
    )

    -- Difference between using order by and not using it:
    select 
    name,
    region_id,
    sub_region_id,
    population,
    sum(population) over(partition by region_id order by sub_region_id) as a, -- by default, the range is between unbounded preceding and current row, where in the next window function, the rande covers all rows
    sum(population) over(partition by region_id) as b
    from eba_countries;

    -- AGGREGATES:
    -- SUM
    -- AVG
    -- COUNT
    -- MIN
    -- MAX
    select 
    name,
    region_id, 
    sum(population) over(partition by region_id),
    max(population) over(partition by region_id),
    min(population) over(partition by region_id),
    count(population) over(partition by region_id),
    avg(population) over()
    from eba_countries;


    -- LAG
    select
    name,
    population,
    lag(name) over(order by name),
    lag(name, 2) over(order by name), 
    lag(name, 2, 'blank') over(order by name)
    from eba_countries;
    -- LEAD
    select
    name,
    population,
    lead(name) over(order by name),
    lead(name, 2) over(order by name), 
    lead(name, 2, 'blank') over(order by name)
    from eba_countries;
    -- NTILE
    select 
    country_id,
    name,
    population,
    ntile(20) over(order by name),
    ntile(3) over(order by population desc),
    ntile(5) over(order by region_id) -- 5 groups evenly distributed for each region
    from eba_countries;
    -- NTH_VALUE
    select 
    country_id,
    name,
    population,
    nth_value(name, 2) over(),
    nth_value(name, 2) over(partition by region_id)
    from eba_countries;

    -- ROW_NUMBER
    -- RANK
    -- DENSE_RANK
    select 
    country_id,
    name,
    population,
    row_number() over(order by population),
    rank() over (order by population),
    dense_rank() over(order by population)
    from eba_countries;
    -- NOTE:
    select 
    country_id,
    name,
    population,
    row_number() over(order by population),
    rank() over (order by population),
    dense_rank() over(order by population)
    from eba_countries
    order by country_id; -- DOES NOT CHANGE RESULT!! order by is executed last maybe? -> you need to check order in which clauses are executed
    -- partitioning:
    select 
    country_id,
    name,
    population,
    region_id,
    row_number() over(partition by region_id order by population),
    rank() over (partition by region_id order by population),
    dense_rank() over(order by population)
    from eba_countries;

    -- PERCENT_RANK
    -- CUME_DIST
    select 
    country_id,
    name,
    population,
    percent_rank() over(partition by region_id order by population), 
    cume_dist() over(order by population)
    from eba_countries;

-- ORDER OF EXECUTION OF SQL QUERIES:
    -- 1. FROM
    -- 2. JOIN
    -- 3. WHERE 
    -- 4. GROUP BY
    -- 5. HAVING
    -- 6. WINDOW 
    -- 7. SELECT 
    -- 8. ORDER BY 
    -- 9. LIMIT / FETCH / TOP
