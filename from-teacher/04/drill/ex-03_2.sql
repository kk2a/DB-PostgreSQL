SELECT
  id,
  name,
  level,
  job
FROM
  s_characters
ORDER BY
  CASE
    WHEN job = 'Samurai' THEN 1
    WHEN job = 'Ninja' THEN 2
    WHEN job = 'Fighter' THEN 3
    WHEN job = 'Monk' THEN 4
    WHEN job = 'Priest' THEN 5
    WHEN job = 'Wizard' THEN 6
    ELSE 7
  END,
  level DESC;
