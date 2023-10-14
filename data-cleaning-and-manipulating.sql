------------
-- COALESCE:
------------
    -- takes 2 or more expressions and returns the first expression that is non null
    -- ordering is important
    -- if all expressions are null, then the result is null
    -- the datatypes must be the same datatype!
    -- coalesce(expression1, expression2, ...)
select store_name, web_address, coalesce(web_address, store_name) from stores; -- coalesce will return the first non-null value for each row. The ordering matters.

--------
-- NVL:
--------
    -- takes null values from an expressions and replaces them all with a specified string
    -- if the expression in the first parameter is:
        --> a character: then it converts the replacement string to a character
        --> numeric: the oracle database detects which argument has the highest numeric precedence, then converts the other argument to that datatype, and returns that datatype.
    -- nvl(expression, replacement_string)
select emp.*, nvl(comm, 0) from emp;

    -- WARNING: select emp.*, nvl(Comm, 'something') from emp; won't work. BECAUSE we need to have the same datatype.
    -- insert into emp values(0, null, 'test', 0, sysdate, 100, null, 10);
select ename, nvl(ename, 'no name') from emp;
    -- delete from emp where ename is null; 

--------
-- TRIM:
--------
    -- trims leading or trailing (or both) characters 
    -- TRIM([LEADING|TRAILING|BOTH] trim_character FROM trim_source) 
    -- if trim_character or trim_source is a character literal, you must enclose it in single quotes. The default trim_character is a whitespace. By default, BOTH are removed
select ename, trim('K' FROM ename) from emp;
select trim(' ' from '   whitespace   ') from dual;
select length(trim(' ' from '   whitespace   ')) from dual;
select length(trim(leading ' ' from '   whitespace   ')) from dual;

-------------
-- LPAD, RPAD
-------------
    -- ensuring all values are of the same length. 
    -- LPAD: pads the left side of an expression with a specific set of characters until it reaches its padded length
    -- RPAD: pads the right side of an expression with a specific set of characters until it reaches its padded length
    -- LPAD|RPAD(EXPRESSION, PADDED_LENGTH, PAD_CHARACTER)
select lpad(empno, 8, 0) from emp;
select job, rpad(job, 6, 'X') from emp; -- if the string has more than padded_length (in this case, 6) characters, then it will be concatenated
select sal, rpad(sal, length(sal) + 3, 0) from emp; -- length() + 3 will add 3 more zeros at the end of a number

------------------
-- GREATEST, LEAST
------------------
    -- return the greatest/lowest value in a list of expressions
    -- the first expression is used to determine the datatype
    -- GREATEST|LEAST(EXPRESSION1, EXPRESSION2...EXPRESSIONZ);

    -- Return a column that does not allow the salary to be > 3000. If it is, then it caps it to that value of 3k
    -- 1.
    select sal, 
    case 
        when greatest(3000, sal) > 3000 then 3000
        else sal
    end as new_sal
    from emp;

    -- 2.
    select emp.*, least(sal, 3000) from emp;

--------
-- PIVOT
--------
    -- Transposes row values into columns
    -- You must ensure you select all the columns you wish to retain in your query, along with the column used in the aggregation and the column that holds the values in the list.
    -- SELECT * FROM (SELECT COL1, COL2, ..., COL_N FROM TABLE) PIVOT (AGG_FUNCTION(COL_N) FOR COL_N IN (LIST)); 
    select * from 
    (select region_id, sub_region_id, population from eba_countries)
    pivot(sum(population) for region_id in (10, 20, 30, 40));
    -- We can see that, for region 30, subregion 110 has a population of ~ 3 billion

    select * from 
    (select region_id, country_id, name, population from eba_countries)
    pivot (sum(population) for region_id in (10, 20, 30, 40, 50))
    order by country_id asc;

----------
-- UNPIVOT
----------
    -- Transforms columns into rows of two new columns
    -- Column 1: previous column names
    -- Column 2 : aggregated values:
    -- SELECT * FROM TABLE 
    -- UNPIVOT (MEASURE_COL FOR NEW_COL_NAME_HOLDS_EXISTING_PIVOTED_COL_NAMES IN (PIVOT_COL_LIST));
    create table avg_test_scores (class varchar(10), maths number, science number, english number);
    insert into avg_test_scores values ('7A', 70, 50, 80);
    insert into avg_test_scores values ('7B', 80, 80, 90);
    insert into avg_test_scores values ('7C', 70, 50, 80);

