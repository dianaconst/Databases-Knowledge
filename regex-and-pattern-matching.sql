-- REGEXES and metacharacters

-- WHERE:
    -- Searches for exact matches
    -- SELECT * FROM TABLE WHERE CONDITION;

-- Metahcaracters are not wildcards. They have distinct usages
-- Pattern matching with .+?*:
    -- . => matches any character (including space)
    -- + => matches 1 or more occurrences of the preceding subexpression
    -- ? => can match 0 or 1 occurrences of the preceding subexpression
    -- * => -"-  0 or more -"-
    -- pattern = '.ab', string = 2ab => matches.