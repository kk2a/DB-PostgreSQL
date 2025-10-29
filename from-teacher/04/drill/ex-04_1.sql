SELECT
  id,
  name,
  job,
  level
FROM
  s_characters
ORDER BY
  RANDOM()
LIMIT
  3;
