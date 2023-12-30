-- https://www.hackerrank.com/challenges/the-report/problem?isFullScreen=true
with cte1 as (
select 
    s.name,
    s.marks,
    g.grade,
    case 
        when s.marks >= g.min_mark and s.marks <= g.max_mark then g.grade
        else NULL
    end as final_mark
from students s, grades g
order by g.grade desc, s.name asc
)
select 
    case when c1.final_mark < 8 then NULL
    else c1.name
    end as final_name,
    c1.final_mark,
    c1.marks
from cte1 c1
where final_mark is not NULL;


-- Other solutions:

--1
SELECT
IF (Grade >= 8, Name, NULL),
Grade,
Marks
FROM
    (SELECT
        Name,
        (SELECT Grade 
        FROM Grades 
        WHERE (Min_Mark <= Marks) AND (Marks <= Max_Mark)) AS Grade,
        Marks
    FROM Students) As MyStudents
ORDER BY Grade DESC, Name;

--2
select 
    case when g.Grade >= 8 then s.Name else 'NULL' 
    end, 
    g.Grade, 
    s.Marks 
from Students s 
inner join Grades g 
on (s.Marks >= g.Min_Mark and s.Marks <= g.Max_Mark) 
order by g.Grade desc, s.Name asc;
