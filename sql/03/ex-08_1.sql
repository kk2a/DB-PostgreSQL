SELECT
    id,
    name,
    created_on AS "created_on_1",
    '令和' || DATE_PART('year', created_on) - 2018 || '年' || TO_CHAR(DATE_PART('month', created_on), 'FM00') || '月' || TO_CHAR(DATE_PART('day', created_on), 'FM00') || '日' AS "created_on_2"
FROM
    s_characters;