SELECT
  id,
  job,
  level,
  name
FROM
  s_characters
ORDER BY
  job,
  level DESC,
  name;

-- 別解 ASC を明示

SELECT
  id,
  job,
  level,
  name
FROM
  s_characters
ORDER BY
  job ASC,
  level DESC,
  name ASC;
