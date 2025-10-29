SELECT
  id,
  name,
  last_login_at
FROM
  s_characters
ORDER BY
  last_login_at NULLS FIRST
LIMIT
  5;
