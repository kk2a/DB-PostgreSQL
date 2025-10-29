SELECT
    id,
    name,
    last_login_at::date AS "Last Login",
    ((date '2025-10-15') - last_login_at::date) || ' days ago' AS "Days Since Last Login",
    CASE
        WHEN ((date '2025-10-15') - last_login_at::date) <= 50 THEN 'Yes'
        ELSE 'No'
    END AS "Is Active User?"
FROM
    s_characters;
