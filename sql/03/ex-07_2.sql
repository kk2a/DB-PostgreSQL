SELECT DISTINCT
    COALESCE(guild, '未所属') AS "ギルド",
    job AS "ジョブ"
FROM
    s_characters;