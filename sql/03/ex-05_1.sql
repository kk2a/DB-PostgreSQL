SELECT
    id,
    name,
    job,
    CASE
        WHEN job = 'Fighter' OR
        job = 'Samurai' OR
        job = 'Monk' OR
        job = 'Ninja' THEN 'frontline'
        ELSE 'backline'
    END AS "battle_position"
FROM
    s_characters;