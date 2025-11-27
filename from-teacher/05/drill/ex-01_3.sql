START TRANSACTION;

-- 削除前の確認
SELECT
  id,
  name
FROM
  s_characters
ORDER BY
  id;

-- 削除処理
DELETE FROM s_characters
WHERE
  id IN (3, 5, 8, 9, 10, 14);

-- 削除後の確認
SELECT
  id,
  name
FROM
  s_characters
ORDER BY
  id;

ROLLBACK;
