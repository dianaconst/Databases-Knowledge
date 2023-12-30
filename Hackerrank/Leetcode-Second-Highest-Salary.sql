https://leetcode.com/problems/second-highest-salary/ 
-- 1
WITH cte as (
    select 
        id,
        salary,
        dense_rank() over(order by salary desc) as ranking
    from Employee
)
select
    case 
        when max(ranking) < 2 then null 
        else salary
    end as SecondHighestSalary
from cte
where ranking = 2;

-- 2
SELECT
    IFNULL(
      (SELECT DISTINCT Salary
       FROM Employee
       ORDER BY Salary DESC
        LIMIT 1 OFFSET 1),
    NULL) AS SecondHighestSalary

