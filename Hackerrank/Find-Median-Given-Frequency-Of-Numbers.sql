-- https://leetcode.com/problems/find-median-given-frequency-of-numbers/description/ 
WITH CTE AS (
    SELECT 
        num,
        generate_series(1, frequency) AS index,
        frequency,
        CAST(sum(frequency) over() AS INT) AS total_num
    FROM Numbers
    ORDER BY num ASC
),
CTE2 AS (
    SELECT
        num,
        index,
        total_num,
        NTH_VALUE(num, total_num/2) over(RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS N1,
        NTH_VALUE(num, total_num/2+1) over(RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS N2
    FROM CTE
)
SELECT
    CASE WHEN total_num % 2 = 0 THEN ROUND((N1 + N2) / CAST(2 AS DECIMAL), 1) 
    ELSE ROUND(CAST(N2 AS DECIMAL),1) 
    END AS median
FROM CTE2
LIMIT 1;
