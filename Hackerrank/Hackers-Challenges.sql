/*
https://www.hackerrank.com/challenges/challenges/problem?isFullScreen=true
*/
-- 1
with cte as (
    select
        h.hacker_id, 
        h.name,
        count(c.challenge_id) as total,
        row_number() over(partition by count(c.challenge_id) order by count(c.challenge_id) desc, hacker_id asc) as priority,
        max(count(c.challenge_id)) over() as max_total
    from hackers as h
    left join challenges as c
    on h.hacker_id = c.hacker_id
    group by h.hacker_id, h.name
    order by total desc, hacker_id
)
select 
    hacker_id, 
    name,
    total
from cte 
where total not in (select total from cte where priority > 1 and max_total > total);

-- 2
SELECT 
    c.hacker_id, 
    h.name, 
    count(c.challenge_id) AS cnt 
FROM Hackers AS h 
JOIN Challenges AS c 
ON h.hacker_id = c.hacker_id
GROUP BY c.hacker_id, h.name
HAVING cnt = (SELECT count(c1.challenge_id) FROM Challenges AS c1 GROUP BY c1.hacker_id 
              ORDER BY count(*) desc limit 1) or -- maxim count
cnt NOT IN (SELECT count(c2.challenge_id) FROM Challenges AS c2 GROUP BY c2.hacker_id 
            HAVING c2.hacker_id <> c.hacker_id) -- this takes all other rows different from my current row. And if my current row's total value is here, then I need to 
ORDER BY cnt DESC, c.hacker_id;