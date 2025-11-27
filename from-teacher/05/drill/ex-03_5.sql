SELECT
  MIN(buff) AS "min_buff",
  MAX(buff) AS "max_buff",
  MAX(buff) - MIN(buff) AS "max-min"
FROM
  s_characters;