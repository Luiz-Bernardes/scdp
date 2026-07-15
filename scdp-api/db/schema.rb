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

ActiveRecord::Schema[7.2].define(version: 2026_07_15_003748) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "pause_queues", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "team_id", null: false
    t.bigint "pause_type_id", null: false
    t.integer "position"
    t.string "status"
    t.datetime "requested_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "selected_duration_minutes"
    t.index ["pause_type_id"], name: "index_pause_queues_on_pause_type_id"
    t.index ["team_id"], name: "index_pause_queues_on_team_id"
    t.index ["user_id", "pause_type_id"], name: "index_unique_queue_per_user_pause_type", unique: true
    t.index ["user_id"], name: "index_pause_queues_on_user_id"
  end

  create_table "pause_types", force: :cascade do |t|
    t.bigint "team_id", null: false
    t.string "name"
    t.boolean "has_time_limit", default: false, null: false
    t.integer "max_concurrent"
    t.boolean "requires_queue", default: false, null: false
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "max_duration_minutes"
    t.index ["team_id", "name"], name: "index_pause_types_on_team_id_and_name", unique: true
    t.index ["team_id"], name: "index_pause_types_on_team_id"
    t.check_constraint "max_concurrent > 0", name: "check_positive_max_concurrent"
  end

  create_table "pauses", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "team_id", null: false
    t.bigint "pause_type_id", null: false
    t.integer "selected_duration_minutes"
    t.datetime "started_at"
    t.datetime "ended_at"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "expires_at"
    t.index ["pause_type_id"], name: "index_pauses_on_pause_type_id"
    t.index ["team_id"], name: "index_pauses_on_team_id"
    t.index ["user_id"], name: "index_pauses_on_user_id"
    t.index ["user_id"], name: "index_unique_running_pause_per_user", unique: true, where: "(status = ANY (ARRAY[0, 1, 2]))"
    t.check_constraint "selected_duration_minutes IS NULL OR selected_duration_minutes > 0", name: "check_positive_selected_duration"
  end

  create_table "team_memberships", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "team_id", null: false
    t.string "email"
    t.integer "team_role"
    t.boolean "pending", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email", "team_id"], name: "index_team_memberships_on_email_and_team_id", unique: true
    t.index ["team_id"], name: "index_team_memberships_on_team_id"
    t.index ["user_id", "team_id"], name: "index_team_memberships_on_user_id_and_team_id", unique: true
    t.index ["user_id"], name: "index_team_memberships_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.boolean "active", default: true, null: false
    t.bigint "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_teams_on_created_by_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "role", default: 3
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "provider_uid"
    t.boolean "active", default: true, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["provider", "provider_uid"], name: "index_users_on_provider_and_provider_uid", unique: true
  end

  add_foreign_key "pause_queues", "pause_types"
  add_foreign_key "pause_queues", "teams"
  add_foreign_key "pause_queues", "users"
  add_foreign_key "pause_types", "teams"
  add_foreign_key "pauses", "pause_types"
  add_foreign_key "pauses", "teams"
  add_foreign_key "pauses", "users"
  add_foreign_key "team_memberships", "teams"
  add_foreign_key "team_memberships", "users"
  add_foreign_key "teams", "users", column: "created_by_id"
end
