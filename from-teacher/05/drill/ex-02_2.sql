START TRANSACTION;

-- 更新前のレコードを確認
SELECT
  id,
  name,
  job
FROM
  s_characters
ORDER BY
  id;

-- 更新処理 Wizard を Mage に更新
UPDATE s_characters
SET
  job = 'Mage'
WHERE
  job = 'Wizard';

-- 更新後のレコードを確認
SELECT
  id,
  name,
  job
FROM
  s_characters
ORDER BY
  id;

ROLLBACK;