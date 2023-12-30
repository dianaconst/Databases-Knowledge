-- https://leetcode.com/problems/game-play-analysis-iv/
SELECT 
    ROUND(SUM(CASE WHEN num_logins = 2 AND AGE(event_date, prev_date) <= '1 DAY' THEN 1 ELSE 0 END) / (1.0 * COUNT(DISTINCT player_id)), 2) AS fraction
FROM 
    (SELECT 
        *,
        ROW_NUMBER() OVER(PARTITION BY player_id ORDER BY event_date) AS num_logins,
        LAG(event_date, 1) OVER(PARTITION BY player_id ORDER BY player_id, event_date) AS prev_date 
    FROM Activity
    ORDER BY player_id, event_date) AS t