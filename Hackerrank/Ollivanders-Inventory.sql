/*
https://www.hackerrank.com/challenges/harry-potter-and-wands/problem?isFullScreen=true
*/
-- 1
WITH Wand_Cost_Ranks AS (
    SELECT 
        W.id, 
        WP.age, 
        W.coins_needed, 
        W.power, 
        ROW_NUMBER() OVER (PARTITION BY W.power, WP.age ORDER BY W.coins_needed) AS cost_rank
    FROM 
        Wands W
        JOIN Wands_Property WP ON W.code = WP.code
    WHERE 
        WP.is_evil = 0
)
SELECT 
    id, 
    age, 
    coins_needed, 
    power
FROM 
    Wand_Cost_Ranks
WHERE 
    cost_rank = 1
ORDER BY 
    power DESC, 
    age DESC;


-- 2
SELECT W.id, WP.age, W.coins_needed, W.power
FROM Wands W
JOIN Wands_Property WP ON W.code = WP.code
WHERE WP.is_evil = 0 AND W.coins_needed = (
    SELECT MIN(coins_needed)
    FROM Wands
    JOIN Wands_Property ON Wands.code = Wands_Property.code
    WHERE Wands.power = W.power AND Wands_Property.age = WP.age
)
ORDER BY W.power DESC, WP.age DESC;