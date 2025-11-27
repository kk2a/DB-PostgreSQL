SELECT
  ROUND(AVG(level),2) AS "無所属平均Lv",
  SUM(level) AS "無所属合計Lv"
FROM
  s_characters
WHERE
  guild IS NULL;