select 
    h.hacker_id, 
    h.name
from hackers h
join submissions s 
on h.hacker_id = s.hacker_id
join challenges c
on c.challenge_id = s.challenge_id
join difficulty d
on c.difficulty_level = d.difficulty_level
where s.score = d.score
group by h.hacker_id, h.name
having count(h.hacker_id) > 1
order by count(s.score) desc, h.hacker_id asc;
