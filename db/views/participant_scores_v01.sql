SELECT *,
	
	CASE WHEN total IS NOT NULL
		THEN RANK() OVER (ORDER BY total DESC)
		ELSE NULL
	END as total_rank,
	
	CASE WHEN last_hour IS NOT NULL
		THEN RANK() OVER (ORDER BY last_hour DESC)
		ELSE  NULL 
	END as last_hour_rank,
	
	CASE WHEN last_two_hours IS NOT NULL
		THEN RANK() OVER (ORDER BY last_two_hours DESC)
		ELSE  NULL 
	END as last_two_hours_rank,
	
	CASE WHEN last_three_hours IS NOT NULL
		THEN RANK() OVER (ORDER BY last_three_hours DESC)
		ELSE  NULL 
	END as last_three_hours_rank
FROM (
	SELECT 
		participants.*, 
		SUM(consumptions.count) AS total,
		SUM(consumptions.count) FILTER (WHERE consumptions.created_at >= datetime('now', '-1 hour')) as last_hour,
		SUM(consumptions.count) FILTER (WHERE consumptions.created_at >= datetime('now', '-2 hour')) as last_two_hours,
		SUM(consumptions.count) FILTER (WHERE consumptions.created_at >= datetime('now', '-3 hour')) as last_three_hours

		FROM "participants" LEFT OUTER JOIN "consumptions" ON "consumptions"."participant_id" = "participants"."id" 
		GROUP BY "participants"."id"
)
