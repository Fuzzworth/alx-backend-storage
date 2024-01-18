-- Docs
SELECT
    band_name,
    YEAR(COALESCE(split, 2022)) - formed AS lifespan
FROM
    metal_bands
WHERE
    style = 'Glam rock'
ORDER BY
    lifespan DESC;
