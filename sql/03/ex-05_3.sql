SELECT
    id,
    name,
    level,
    created_on,
    CASE
        WHEN level >= 50 AND
        created_on <= date '2022/12/31' THEN 'Master'
        WHEN level >= 30 AND
        created_on <= date '2023/12/31' THEN 'Veteran'
        ELSE 'Rookie'
    END AS "class"
FROM
    s_characters;