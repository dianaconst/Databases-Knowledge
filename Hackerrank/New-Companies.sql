/*
https://www.hackerrank.com/challenges/the-company/problem?isFullScreen=true
New-Companies
*/
-- select 
-- company_code,
-- founder_name,
-- total_nr_lead_managers,
-- total_nr_senior_managers,
-- total_nr_managers,
-- total_nr_employees
-- order by company_code not numeric

-- 1
select 
    c.company_code,
    c.founder,
    count(distinct lm.lead_manager_code) as total_nr_lead_managers,
    count(distinct sm.senior_manager_code) as total_nr_senior_managers,
    count(distinct m.manager_code) as total_nr_managers,
    count(distinct e.employee_code) as total_nr_employees
from company c
left join
lead_manager lm
on c.company_code = lm.company_code
join
senior_manager sm
on lm.lead_manager_code = sm.lead_manager_code
join 
manager m
on m.senior_manager_code = sm.senior_manager_code
join 
employee e
on e.manager_code = m.manager_code
group by c.company_code, c.founder
order by c.company_code;

-- 2
/*
Enter your query here.
*/
-- This one joins only by the company id
select 
    c.company_code,
    c.founder,
    count(distinct lm.lead_manager_code) as total_nr_lead_managers,
    count(distinct sm.senior_manager_code) as total_nr_senior_managers,
    count(distinct m.manager_code) as total_nr_managers,
    count(distinct e.employee_code) as total_nr_employees
from company c
left join
lead_manager lm
on c.company_code = lm.company_code
join
senior_manager sm
on lm.company_code = sm.company_code
join 
manager m
on m.company_code = sm.company_code
join 
employee e
on e.company_code = m.company_code
group by c.company_code, c.founder
order by c.company_code;

-- 3
-- A very simple solution
select 
company_code, 
founder, 
(select count(*) from lead_manager a where a.company_code = z.company_code), 
(select count(*) from senior_manager c where c.company_code = z.company_code), 
(select count(*) from manager d where d.company_code = z.company_code), 
(select count(*) from employee b where b.company_code = z.company_code) 
from company z order by company_code;