-- 1.
SELECT 
    name 
FROM Employee
WHERE id IN (
    SELECT DISTINCT
        e.id
    FROM Employee e
    JOIN Employee m
    ON e.id = m.managerId
    WHERE m.managerId IN (
        SELECT 
            managerId
        FROM Employee
        GROUP BY managerId
        HAVING count(managerId) >= 5 
    )
)


-- 2
WITH cte1 AS (
        SELECT 
            managerId
        FROM Employee
        GROUP BY managerId
        HAVING count(managerId) >= 5 
),
CorrectIds AS (
    SELECT DISTINCT
        e.id
    FROM Employee e
    JOIN Employee m
    ON e.id = m.managerId
    WHERE m.managerId IN (TABLE cte1)
)
SELECT 
    emp.name 
FROM Employee as emp
JOIN CorrectIds cid
ON emp.id = cid.id;