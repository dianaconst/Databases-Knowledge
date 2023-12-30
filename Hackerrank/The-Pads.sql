/*
https://www.hackerrank.com/challenges/the-pads/problem*/

select
    case 
        when lower(occupation) like 'd%' then concat(name,'(D)')
        when lower(occupation) like 's%' then concat(name,'(S)')
        when lower(occupation) like 'a%' then concat(name, '(A)')
        when lower(occupation) like 'p%' then concat(name, '(P)')
    end as res
from occupations
order by res asc;

with cte as 
(select 
    count(*) as ct,
    occupation
from occupations
group by occupation)
select
    case 
        when occupation like 'D%' then concat('There are a total of ', ct, ' doctors.')
        when occupation like 'S%' then concat('There are a total of ', ct, ' singers.')
        when occupation like 'A%' then concat('There are a total of ', ct, ' actors.')
        when occupation like 'P%' then concat('There are a total of ', ct, ' professors.')
    end as res
from
    cte
order by ct, occupation;


-- 2
select 
    CONCAT(Name,'(', SUBSTR(Occupation,1,1) ,')') 
from OCCUPATIONS 
order by Name asc;

select 
    CONCAT ('There are a total of ', count(Occupation),' ', lower(Occupation), 's.') 
from OCCUPATIONS 
GROUP BY Occupation 
order by count(Occupation), Occupation;
