START TRANSACTION;

INSERT INTO
    s_users (id, name, age)
VALUES
    (3, 'Carol', 18),
    (4, 'Dave', NULL),
    (5, 'Ellen', 17);

SELECT
    *
FROM
    s_users;

-- 確認
ROLLBACK;
