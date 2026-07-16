-- Find inconsistent values ignoring case and accents

SELECT
    city COLLATE Latin1_General_CI_AI,
    COUNT(DISTINCT city)
FROM orders
GROUP BY city COLLATE Latin1_General_CI_AI
HAVING COUNT(DISTINCT city) > 1;
