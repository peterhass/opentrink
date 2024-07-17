SELECT * 
FROM participant_scores
LEFT JOIN (
	SELECT group_concat(hash, '-') as board_id
	FROM (
		SELECT concat(
 			'id:' || id,
 			',total:' || total,
 			',last_hour:' || last_hour, 
 			',last_two_hours:' || last_two_hours, 
 			',last_three_hours:' || last_three_hours, 
 			',total_rank' || total_rank, 
 			',last_hour_rank' || last_hour_rank, 
 			',last_two_hours_rank' || last_two_hours_rank, 
 			',last_three_hours_rank' || last_three_hours_rank) AS hash
 		FROM participant_scores
		WHERE total_rank is not null
		ORDER BY total_rank asc
		LIMIT 5
 	)
 )
 ON id is not null
 WHERE total_rank is not null
 ORDER BY total_rank asc
 LIMIT 5
