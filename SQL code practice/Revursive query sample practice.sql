WITH RECURSIVE CB AS(
	SELECT
		id,
		name,
		manager_id,
		'ALICE' AS manager_name
	FROM
		employees
		WHERE
			manager_id = 1

	UNION ALL

	SELECT
		e.id,
		e.name,
		e.manager_id,
		CASE
			WHEN e.manager_id = 1 THEN 'ALICE'
			WHEN e.manager_id = 2 THEN 'BOB'
			WHEN e.manager_id = 3 THEN 'CHARLIE'
			WHEN e.manager_id = 4 THEN 'DAVID'
			WHEN e.manager_id = 5 THEN 'EVE'
			WHEN e.manager_id = 6 THEN 'FRANK'
			WHEN e.manager_id = 7 THEN 'GRACE'
			ELSE 'UNKNOWN'
		END AS manager_name
	FROM
		employees AS e
		INNER JOIN CB AS c ON e.manager_id = c.id
)

SELECT * FROM CB;