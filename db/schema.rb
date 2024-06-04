# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_06_04_111701) do
  create_table "consumptions", force: :cascade do |t|
    t.integer "count"
    t.integer "participant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["participant_id"], name: "index_consumptions_on_participant_id"
  end

# Could not dump table "invitations" because of following StandardError
#   Unknown type 'uuid' for column 'id'

  create_table "participants", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uid"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

# Could not dump table "users" because of following StandardError
#   Unknown type 'uuid' for column 'invitation_id'

  add_foreign_key "consumptions", "participants"
  add_foreign_key "invitations", "users", column: "created_by_id"
  add_foreign_key "users", "invitations"

  create_view "participant_scores", sql_definition: <<-SQL
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
  SQL
end
