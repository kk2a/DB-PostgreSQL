SELECT
  id,
  name,
  level,
  created_on
FROM
  s_characters
WHERE
  created_on BETWEEN '2021-01-01' AND '2022-12-31'
ORDER BY
  created_on;