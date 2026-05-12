SELECT *
FROM fang_info AS I
LEFT JOIN fang_sic AS S
ON I.sic_code = S.SIC
INNER JOIN fang_prices AS P
ON I.ticker = P.ticker;


SELECT *
FROM fang_info AS I, fang_prices AS P
LEFT JOIN fang_sic AS S
ON I.sic_code = S.SIC
WHERE I.ticker = P.ticker;


-- not quite identical.
-- the order of the columns is not the same.
-- not important and we could control this.

-- when comparing in R
--   reorder
--   and recognize that ticker is the name of 2 columns so b[names(a)] is incorrect.


