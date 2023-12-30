/*
Enter your query here.
Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
*/
-- 1
select
    c1.contest_id,
    c1.hacker_id,
    c1.name,
    c2.college_id, 
    c3.challenge_id, 
    COALESCE(vs.total_views, 0) AS total_views,
    COALESCE(vs.total_unique_views, 0) AS total_unique_views, 
    COALESCE(ss.total_submissions, 0) AS total_submissions,
    COALESCE(ss.total_accepted_submissions, 0) AS total_accepted_submissions
from contests c1 
left join colleges c2
on c1.contest_id = c2.contest_id
left join challenges c3
on c2.college_id = c3.college_id
left join (
    SELECT
        challenge_id,
        sum(total_views) as total_views,
        sum(total_unique_views) AS total_unique_views,
    FROM View_Stats
    GROUP BY challenge_id
) AS vs
on c3.challenge_id = vs.challenge_id
left join (
    SELECT
        challenge_id,
        sum(total_submissions) AS total_submissions,
        sum(total_accepted_submissions) AS total_accepted_submissions
    FROM Submission_Stats 
    GROUP BY challenge_id
) AS ss
on c3.challenge_id = ss.challenge_id
GROUP BY c1.contest_id, c1.hacker_id, c1.name
HAVING total_submissions != 0
ORDER BY c1.contest_id ASC;



-- NOT CORRECT: 
-- WITH Cte AS (
--     select
--         c1.contest_id,
--         c1.hacker_id,
--         c1.name,
--         c2.college_id, 
--         c3.challenge_id, 
--         COALESCE(vs.total_views, 0) AS total_views,
--         COALESCE(vs.total_unique_views, 0) AS total_unique_views, 
--         COALESCE(ss.total_submissions, 0) AS total_submissions,
--         COALESCE(ss.total_accepted_submissions, 0) AS total_accepted_submissions
--     from contests c1 
--     left join colleges c2
--     on c1.contest_id = c2.contest_id
--     left join challenges c3
--     on c2.college_id = c3.college_id
--     left join view_stats vs
--     on c3.challenge_id = vs.challenge_id
--     left join submission_stats ss
--     on c3.challenge_id = ss.challenge_id
-- )
-- ,
-- FinalCte AS (
--     SELECT
--         contest_id,
--         sum(total_submissions)AS sum_total_submissions,
--         sum(total_accepted_submissions)AS sum_tot_acc_sub,
--         sum(total_views) AS sum_total_views,
--         sum(total_unique_views) AS sum_tot_unique_views
--     FROM Cte
--     GROUP BY contest_id
--     ORDER BY contest_id
-- )
-- SELECT 
--     fc.contest_id,
--     c.hacker_id,
--     c.name,
--     fc.sum_total_submissions,
--     sum_tot_acc_sub,
--     sum_total_views,
--     sum_tot_unique_views
-- FROM FinalCte fc
-- JOIN contests c
-- ON c.contest_id = fc.contest_id
-- WHERE sum_total_submissions != 0 AND sum_tot_acc_sub != 0 AND sum_total_views != 0 AND sum_tot_unique_views != 0
-- ORDER BY fc.contest_id ASC;


-- 2
SELECT C.contest_id, C.hacker_id, C.name,
       SUM(SS.total_submissions) AS total_submissions,
       SUM(SS.total_accepted_submissions),
       SUM(VS.total_views),
       SUM(VS.total_unique_views)
FROM Contests C
LEFT JOIN Colleges COL ON C.contest_id = COL.contest_id
LEFT JOIN Challenges CH ON COL.college_id = CH.college_id
LEFT JOIN (SELECT challenge_id, 
                SUM(total_submissions) AS total_submissions,
                SUM(total_accepted_submissions) AS total_accepted_submissions
            FROM Submission_Stats GROUP BY challenge_id) SS
        ON CH.challenge_id = SS.challenge_id
LEFT JOIN (SELECT challenge_id,
                SUM(total_views) AS total_views,
                SUM(total_unique_views) AS total_unique_views
            FROM View_Stats GROUP BY challenge_id) VS
        ON CH.challenge_id = VS.challenge_id
GROUP BY C.contest_id, C.hacker_id, C.name
HAVING total_submissions IS NOT NULL
ORDER BY C.contest_id;