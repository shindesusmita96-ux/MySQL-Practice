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

-- =====================================================================================================================================
-- Find values that cannot be converted to a numeric type
-- Purpose: Detect invalid numeric values stored as text (NVARCHAR)
--          Useful before changing a column to DECIMAL, FLOAT, or INT
-- ======================================================================================================================================

SELECT
    Profit
FROM superstore
WHERE TRY_CAST(Profit AS DECIMAL(18,4)) IS NULL
      AND Profit IS NOT NULL;

SELECT
    column_name
FROM table_name
WHERE TRY_CAST(column_name AS DECIMAL(18,4)) IS NULL
      AND column_name IS NOT NULL;

/* Example invalid values:
- N/A
- Unknown
- -
- 9,331.20
- 1e-04 (depending on the target data type)
*/





