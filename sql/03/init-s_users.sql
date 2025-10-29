-- 既に同名のテーブルがあれば削除する
DROP TABLE IF EXISTS s_users;

-- ユーザ情報を保持するテーブルを作成する
CREATE TABLE s_users (id INT PRIMARY KEY, name TEXT NOT NULL, age INT);

-- テーブルにレコード（ユーザ情報）を挿入する
INSERT INTO
  s_users (id, name, age)
VALUES
  (1, 'Alice', 20),
  (2, 'Bob', 25);

-- すべてのレコードを抽出する
SELECT * FROM s_users;