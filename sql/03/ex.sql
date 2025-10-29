-- SELECT
--     8 AS "RegionID", -- 定数値のカラム
--     'Zipangu' AS "World", -- 定数値のカラム
--     id AS "ID",
--     name AS "名前"
-- FROM
--     s_characters;
-- SELECT
--     LOCALTIMESTAMP(0) AS "LOCALTIMESTAMP",
--     CURRENT_TIMESTAMP(0) AS "CURRENT_TIMESTAMP";
-- SELECT
--     LOCALTIME(0) AS "LOCALTIME",
--     CURRENT_TIME(0) AS "CURRENT_TIME";
-- SELECT
--     CURRENT_DATE AS "CURRENT_DATE";
SELECT
    id,
    name,
    last_login_at,
    LOCALTIMESTAMP - last_login_at AS "Elapsed Time Since Last Login"
FROM
    s_characters;