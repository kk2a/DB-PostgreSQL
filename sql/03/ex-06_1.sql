SELECT
    id,
    name,
    guild,
    COALESCE(guild, '(' || name || ')') AS "guild or (name)"
FROM
    s_characters;