SELECT
  MAX(LENGTH(COALESCE(guild,'Freelancer'))) AS "最大文字数"
FROM
  s_characters;