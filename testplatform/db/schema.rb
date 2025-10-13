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

ActiveRecord::Schema[8.0].define(version: 2025_01_10_102542) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "attempts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "test_id", null: false
    t.datetime "started_at"
    t.datetime "submitted_at"
    t.integer "score", default: 0
    t.integer "total_points", default: 0
    t.string "status", default: "in_progress"
    t.integer "time_taken_seconds"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["test_id"], name: "index_attempts_on_test_id"
    t.index ["user_id"], name: "index_attempts_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.string "color", default: "#3498db"
    t.integer "position", default: 0
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "options", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.text "content", null: false
    t.boolean "is_correct", default: false
    t.integer "position", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_options_on_question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "test_id", null: false
    t.string "question_text", null: false
    t.string "option_a"
    t.string "option_b"
    t.string "option_c"
    t.string "option_d"
    t.string "correct_option"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["test_id"], name: "index_questions_on_test_id"
  end

  create_table "responses", force: :cascade do |t|
    t.bigint "attempt_id", null: false
    t.bigint "question_id", null: false
    t.bigint "option_id"
    t.text "answer_text"
    t.boolean "is_correct"
    t.integer "points_earned", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attempt_id"], name: "index_responses_on_attempt_id"
    t.index ["option_id"], name: "index_responses_on_option_id"
    t.index ["question_id"], name: "index_responses_on_question_id"
  end

  create_table "test_categories", force: :cascade do |t|
    t.bigint "test_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_test_categories_on_category_id"
    t.index ["test_id"], name: "index_test_categories_on_test_id"
  end

  create_table "tests", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.integer "duration_minutes", default: 30
    t.integer "total_questions", default: 0
    t.boolean "published", default: false
    t.datetime "published_at"
    t.bigint "created_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_tests_on_created_by_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "role", default: "student"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  #add_foreign_key "attempts", "tests"
  #add_foreign_key "attempts", "users"
  #add_foreign_key "options", "questions"
  #add_foreign_key "questions", "tests"
  #add_foreign_key "responses", "attempts"
  #add_foreign_key "responses", "options"
  #add_foreign_key "responses", "questions"
  #add_foreign_key "test_categories", "categories"
  #add_foreign_key "test_categories", "tests"
  #add_foreign_key "tests", "users", column: "created_by_id"
  
end