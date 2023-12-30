-- https://www.hackerrank.com/challenges/placements/problem?isFullScreen=true

with t1 as (
    select 
        s.id,
        s.name,
        p.salary
    from students s
    join packages p
    using(id)
), 
t2 as (
    select 
        f.id,
        f.friend_id,
        p.salary as friend_salary
    from friends f
    left join packages p
    on p.id = f.friend_id
)
select
    t1.name
from t1
join t2 
using(id)
where t2.friend_salary > t1.salary
order by t2.friend_salary asc;


-- 2
SELECT A.name 
FROM 
    (SELECT 
        s.id, 
        s.name, 
        p.salary, 
        f.friend_id 
    FROM students s 
    JOIN packages p 
    ON p.id = s.id 
    JOIN friends f 
    ON f.id = s.id 
) A 
JOIN packages p1 
ON p1.id = A.friend_id 
WHERE A.salary < p1.salary 
ORDER BY p1.salary ASC;

-- 3
SELECT NAME 
FROM Students AS S
    JOIN Friends AS F using (id)
    JOIN PACKAGES AS P using (id)
    JOIN PACKAGES AS P2 ON F.FRIEND_ID =P2.ID
WHERE p2.salary > p.salary
order by p2.salary;