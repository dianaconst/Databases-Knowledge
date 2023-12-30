-- https://leetcode.com/problems/game-play-analysis-v/description/
WITH CTE1 AS (
    select 
        *,
        lead(event_date, 1) over(partition by player_id order by event_date asc) AS day_1_retention,
        row_number() over(partition by player_id order by event_date) AS install_date
    from Activity
    order by player_id, event_date
),
CTE2 AS (
    SELECT
        SUM(CASE WHEN AGE(day_1_retention, event_date) = '1 DAY' AND install_date = 1 THEN 1 ELSE 0 END) AS retention,
        SUM(CASE WHEN install_date = 1 THEN 1 ELSE 0 END) AS total_players,
        event_date
    FROM CTE1
    GROUP BY event_date
    ORDER BY event_date
)
SELECT
    event_date AS install_dt,
    total_players AS installs,
    CASE WHEN total_players = 0 THEN NULL ELSE ROUND(retention / (1.0 * total_players), 2) END AS Day1_retention
FROM CTE2
WHERE total_players != 0
ORDER BY event_date;