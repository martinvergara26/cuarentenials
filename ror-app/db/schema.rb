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

ActiveRecord::Schema.define(version: 2021_02_16_194944) do

  create_table "births", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.date "estimated_date"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "phase_id", null: false
    t.bigint "user_id", null: false
    t.index ["phase_id"], name: "index_births_on_phase_id"
    t.index ["user_id"], name: "index_births_on_user_id"
  end

  create_table "gifts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "phase_id"
    t.index ["phase_id"], name: "index_gifts_on_phase_id"
  end

  create_table "given_gifts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: true
    t.bigint "gift_id", null: false
    t.bigint "birth_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["birth_id"], name: "index_given_gifts_on_birth_id"
    t.index ["gift_id"], name: "index_given_gifts_on_gift_id"
    t.index ["user_id"], name: "index_given_gifts_on_user_id"
  end

  create_table "interactions", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.integer "allowed_attendees", default: 1
    t.string "csv_not_allowed_days", default: ""
    t.integer "allowed_times_a_day", default: 1
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "phase_id", null: false
    t.index ["phase_id"], name: "index_interactions_on_phase_id"
  end

  create_table "jwt_blacklist", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["jti"], name: "index_jwt_blacklist_on_jti"
  end

  create_table "phases", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_phases_on_user_id"
  end

  create_table "timeslot_users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "timeslot_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["timeslot_id"], name: "index_timeslot_users_on_timeslot_id"
    t.index ["user_id"], name: "index_timeslot_users_on_user_id"
  end

  create_table "timeslots", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "from"
    t.datetime "to"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "birth_id", null: false
    t.bigint "interaction_id"
    t.index ["birth_id"], name: "index_timeslots_on_birth_id"
    t.index ["interaction_id"], name: "index_timeslots_on_interaction_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_pmc"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "births", "phases"
  add_foreign_key "births", "users"
  add_foreign_key "gifts", "phases"
  add_foreign_key "given_gifts", "births"
  add_foreign_key "given_gifts", "gifts"
  add_foreign_key "given_gifts", "users"
  add_foreign_key "interactions", "phases"
  add_foreign_key "phases", "users"
  add_foreign_key "timeslot_users", "timeslots"
  add_foreign_key "timeslot_users", "users"
  add_foreign_key "timeslots", "births"
  add_foreign_key "timeslots", "interactions"
end
