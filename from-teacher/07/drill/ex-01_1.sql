-- トランザクションの開始
START TRANSACTION;

-- テーブルの作成 (一例です)
CREATE TABLE p_users (
  user_id INTEGER PRIMARY KEY,
  name VARCHAR(16) NOT NULL,
  is_admin BOOLEAN NOT NULL,
  height_cm DECIMAL(4, 1),
  birthday DATE
);

-- レコードの挿入
INSERT INTO
  p_users
VALUES
  (1, 'Alice', TRUE, 162.3, DATE '2003-10-20'),
  (2, 'Bob', FALSE, 181.9, DATE '2002-05-05'),
  (3, 'Charlie', FALSE, NULL, NULL),
  (4, 'Ellen', TRUE, 172.7, NULL),
  (5, 'Eve', FALSE, NULL, DATE '2024-06-30');

-- テーブルの確認
SELECT
  *
FROM
  p_users;

-- テーブルの集計
SELECT
  COUNT(*) AS "user_count",
  ROUND(AVG(height_cm), 2) AS "height_avg",
  SUM(
    CASE
      WHEN is_admin THEN 1
      ELSE 0
    END
  ) AS "admin_count"
FROM
  p_users;

-- ロールバックによる処理の取り消し
ROLLBACK;