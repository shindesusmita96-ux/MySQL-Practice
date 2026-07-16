-- =======================================================================================================================================
-- Query: Find Inconsistent Text Values (Case & Accent Variations)
-- Purpose: This query identifies text values that appear to be the samewhen ignoring differences in letter casing and accent marks.
-- =======================================================================================================================================

SELECT
    city COLLATE Latin1_General_CI_AI,
    COUNT(DISTINCT city)
FROM orders
GROUP BY city COLLATE Latin1_General_CI_AI
HAVING COUNT(DISTINCT city) > 1;

/*
CI = Case Insensitive
AI = Accent Insensitive

Example:
'NEW YORK' = 'new york'
'São Paulo' = 'Sao Paulo'
*/
