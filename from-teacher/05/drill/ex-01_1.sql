START TRANSACTION;

-- 削除前の確認
SELECT
  id,
  name,
  last_login_at,
  DATE '2025-10-15' - CAST(last_login_at AS DATE) || ' days ago' AS "Days Since Last Login"
FROM
  s_characters
ORDER BY
  last_login_at;

-- 削除処理
DELETE FROM s_characters
WHERE
  DATE '2025-10-15' - CAST(last_login_at AS DATE) >= 60;

-- 削除後の確認
SELECT
  id,
  name,
  last_login_at,
  DATE '2025-10-15' - CAST(last_login_at AS DATE) || ' days ago' AS "Days Since Last Login"
FROM
  s_characters
ORDER BY
  last_login_at;

ROLLBACK;
