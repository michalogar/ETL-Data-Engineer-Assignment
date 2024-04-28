--Remove duplicated rows in Table MAP
WITH distinct_Table_MAP AS (
	SELECT 
		DISTINCT *
	FROM
		Table_MAP
),
--Combine Table A and B
combined_tables AS (
	SELECT
		A.dimension_1,
		M.correct_dimension_2 AS dimension_2,
		A.measure_1 AS measure_1,
		0 AS measure_2
	FROM
        	Table_A A
    	LEFT JOIN
        	distinct_Table_MAP M ON A.dimension_1 = M.dimension_1

UNION

	SELECT
		B.dimension_1,
		M.correct_dimension_2 AS dimension_2,
		0 AS measure_1,
		B.measure_2 AS measure_2
	FROM
        	Table_B B
    	LEFT JOIN
        	distinct_Table_MAP M ON B.dimension_1 = M.dimension_1
)
--Sum measure 1 and 2
SELECT
	dimension_1,
	dimension_2,
	SUM(measure_1) AS measure_1,
	SUM(measure_2) AS measure_2
FROM
	combined_tables
GROUP BY
	dimension_1,
	dimension_2
