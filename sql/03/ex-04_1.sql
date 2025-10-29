SELECT
    id,
    name || ' (' || job || ' Lv.' || level || ')' AS "summary"
FROM
    s_characters;