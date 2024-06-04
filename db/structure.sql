CREATE TABLE IF NOT EXISTS "schema_migrations" ("version" varchar NOT NULL PRIMARY KEY);
CREATE TABLE IF NOT EXISTS "ar_internal_metadata" ("key" varchar NOT NULL PRIMARY KEY, "value" varchar, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE TABLE sqlite_sequence(name,seq);
CREATE TABLE IF NOT EXISTS "consumptions" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "count" integer, "participant_id" integer NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, CONSTRAINT "fk_rails_bdfe5b80f0"
FOREIGN KEY ("participant_id")
  REFERENCES "participants" ("id")
);
CREATE INDEX "index_consumptions_on_participant_id" ON "consumptions" ("participant_id");
CREATE TABLE IF NOT EXISTS "participants" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar DEFAULT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, "uid" varchar);
CREATE VIEW "participant_scores" AS SELECT *,
	
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
/* participant_scores(id,name,created_at,updated_at,uid,total,last_hour,last_two_hours,last_three_hours,total_rank,last_hour_rank,last_two_hours_rank,last_three_hours_rank) */;
CREATE TABLE IF NOT EXISTS "invitations" ("id" uuid NOT NULL PRIMARY KEY, "deactivated" boolean DEFAULT 0, "created_by_id" integer, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, "role" varchar DEFAULT 'bar' NOT NULL, CONSTRAINT "fk_rails_1e69da856c"
FOREIGN KEY ("created_by_id")
  REFERENCES "users" ("id")
);
CREATE INDEX "index_invitations_on_created_by_id" ON "invitations" ("created_by_id");
CREATE TABLE IF NOT EXISTS "users" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar NOT NULL, "crypted_password" varchar, "salt" varchar, "invitation_id" uuid NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, "deactivated" boolean DEFAULT 0, CONSTRAINT "fk_rails_3fd4c741e5"
FOREIGN KEY ("invitation_id")
  REFERENCES "invitations" ("id")
);
CREATE INDEX "index_users_on_invitation_id" ON "users" ("invitation_id");
CREATE TABLE IF NOT EXISTS "sessions" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "session_id" varchar NOT NULL, "data" text, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE UNIQUE INDEX "index_sessions_on_session_id" ON "sessions" ("session_id");
CREATE INDEX "index_sessions_on_updated_at" ON "sessions" ("updated_at");
INSERT INTO "schema_migrations" (version) VALUES
('20240604111701'),
('20240602112125'),
('20240528213533'),
('20240525194949'),
('20240521195936'),
('20240511114735'),
('20240511113818'),
('20240511110857');

