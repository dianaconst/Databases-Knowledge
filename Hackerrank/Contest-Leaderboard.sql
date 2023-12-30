-- https://www.hackerrank.com/challenges/contest-leaderboard/problem
with cte as (
select
    h.hacker_id,
    h.name,
    s.challenge_id,
    max(s.score) as score --over(partition by h.hacker_id, s.challenge_id order by h.hacker_id)
from hackers h
join submissions s
on h.hacker_id = s.hacker_id
group by s.challenge_id, h.hacker_id, h.name
)
select 
    c.hacker_id,
    c.name,
    sum(c.score)
from cte c
group by c.hacker_id, c.name
having sum(c.score) != 0
order by sum(c.score) desc, c.hacker_id asc;

-- 2
SELECT 
    H.hacker_id, 
    H.name, 
    T.tot_score 
FROM Hackers H 
JOIN 
(SELECT 
    S.hacker_id, 
    SUM(S.max_score) as tot_score
    FROM 
        (SELECT hacker_id, challenge_id, MAX(score) as max_score 
        FROM Submissions 
        GROUP BY hacker_id, challenge_id) S 
    GROUP BY S.hacker_id 
    HAVING tot_score > 0) T 
ON H.hacker_id = T.hacker_id 
ORDER BY T.tot_score DESC, H.hacker_id;
    