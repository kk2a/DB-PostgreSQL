SELECT
  job,
  COUNT(level) AS "num",
  ROUND(AVG(level), 1) AS "avg_lv"
FROM
  s_characters
GROUP BY
  job
ORDER BY
  AVG(level) DESC;
