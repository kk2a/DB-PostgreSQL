SELECT
  id,
  name,
  created_on
FROM
  s_characters
ORDER BY
  created_on
OFFSET
  10
LIMIT
  5;