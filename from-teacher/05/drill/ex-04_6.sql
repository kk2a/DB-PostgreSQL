SELECT
  TO_CHAR(DATE_TRUNC('year', created_on), 'YYYY') AS "year",
  COUNT(*) AS "num",
  ROUND(AVG(level), 1) AS "avg_lv"
FROM
  s_characters
GROUP BY
  DATE_TRUNC('year', created_on)
ORDER BY
  "year";