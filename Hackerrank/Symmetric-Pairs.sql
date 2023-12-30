-- https://www.hackerrank.com/challenges/symmetric-pairs/problem?isFullScreen=true 
with cte1 as (
    select 
        row_number() over(order by t1.x asc) as id,
        t1.x,
        t1.y
    from functions t1
)
select distinct 
    case when cte1.x > cte1.y then cte1.y else cte1.x end as X,
    case when cte1.x > cte1.y then cte1.x else cte1.y end as Y
from cte1
join cte1 as t
on cte1.x = t.y and cte1.y = t.x and cte1.id != t.id;