-- Coalesce:
    -- takes 2 or more expressions and returns the first expression that is non null
    -- ordering is important
    -- if all expressions are null, then the result is null
    -- the datatypes must be the same datatype!
    -- coalesce(expression1, expression2, ...)
select store_name, web_address, coalesce(web_address, store_name) from stores; -- coalesce will return the first non-null value for each row. The ordering matters.

-- NVL:
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

-- TRIM:
    -- trims leading or trailing (or both) characters 
    -- TRIM([LEADING|TRAILING|BOTH] trim_character FROM trim_source) 
    -- if trim_character or trim_source is a character literal, you must enclose it in single quotes. The default trim_character is a whitespace. By default, BOTH are removed
select ename, trim('K' FROM ename) from emp;