SELECT
    id,
    name,
    last_login_at,
    ((date '2025-10-15') - last_login_at::date) || '日前え' AS "最終ログイン"
FROM
    s_characters;