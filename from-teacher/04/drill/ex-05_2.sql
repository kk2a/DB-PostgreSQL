SELECT
  id,
  name,
  level,
  created_on
FROM
  s_characters
WHERE
  name LIKE 'T%'
ORDER BY
  name;