-- Dual table is a special table with one row and one value which is X. We can perform any calculation using this table with only one entry.
select 12 * 5.6 from dual;
select sysdate from dual; -- selects today's date and time
select length('hello bonjour') from dual; -- you must put a constant value inside the brackets!