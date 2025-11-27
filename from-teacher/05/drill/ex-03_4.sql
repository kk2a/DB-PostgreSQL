SELECT
  COUNT(*) AS "前衛職人数",
  ROUND(AVG(level), 1) AS "前衛職平均Lv"
FROM
  s_characters
WHERE
  job IN ('Fighter', 'Monk', 'Samurai', 'Ninja');

SELECT
  COUNT(*) AS "後衛職人数",
  ROUND(AVG(level), 1) AS "後衛職平均Lv"
FROM
  s_characters
WHERE
  job IN ('Wizard', 'Priest');