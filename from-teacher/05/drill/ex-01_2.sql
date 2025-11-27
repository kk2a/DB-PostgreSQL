START TRANSACTION;

-- 削除前の確認
SELECT
  id,
  name,
  last_login_at,
  created_on
FROM
  s_characters
WHERE
  last_login_at IS NULL
ORDER BY
  created_on;

-- 削除処理
DELETE FROM s_characters
WHERE
  last_login_at IS NULL AND
  created_on <= '2023-12-31';

-- 削除後の確認
SELECT
  id,
  name,
  last_login_at,
  created_on
FROM
  s_characters
WHERE
  last_login_at IS NULL
ORDER BY
  created_on;

ROLLBACK;
