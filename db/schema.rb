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

ActiveRecord::Schema[8.1].define(version: 2025_10_27_223454) do
  create_table "courses", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.integer "teacher_id", null: false
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["teacher_id"], name: "index_courses_on_teacher_id"
  end

  create_table "learning_notes", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.integer "lesson_id", null: false
    t.integer "student_id", null: false
    t.datetime "updated_at", null: false
    t.index ["lesson_id"], name: "index_learning_notes_on_lesson_id"
    t.index ["student_id"], name: "index_learning_notes_on_student_id"
  end

  create_table "learning_plans", force: :cascade do |t|
    t.boolean "completed"
    t.datetime "created_at", null: false
    t.integer "lesson_id", null: false
    t.datetime "scheduled_at"
    t.integer "student_id", null: false
    t.datetime "updated_at", null: false
    t.index ["lesson_id"], name: "index_learning_plans_on_lesson_id"
    t.index ["student_id"], name: "index_learning_plans_on_student_id"
  end

  create_table "learning_records", force: :cascade do |t|
    t.boolean "completed"
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.integer "duration"
    t.integer "lesson_id", null: false
    t.integer "student_id", null: false
    t.datetime "updated_at", null: false
    t.index ["lesson_id"], name: "index_learning_records_on_lesson_id"
    t.index ["student_id"], name: "index_learning_records_on_student_id"
  end

  create_table "lessons", force: :cascade do |t|
    t.text "content"
    t.integer "course_id", null: false
    t.datetime "created_at", null: false
    t.text "description"
    t.integer "order_index"
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_lessons_on_course_id"
  end

  create_table "materials", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.integer "lesson_id", null: false
    t.integer "material_type"
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["lesson_id"], name: "index_materials_on_lesson_id"
  end

  create_table "questions", force: :cascade do |t|
    t.text "content"
    t.text "correct_answer"
    t.datetime "created_at", null: false
    t.integer "lesson_id", null: false
    t.integer "question_type"
    t.datetime "updated_at", null: false
    t.index ["lesson_id"], name: "index_questions_on_lesson_id"
  end

  create_table "student_questions", force: :cascade do |t|
    t.text "answer"
    t.datetime "answered_at"
    t.datetime "created_at", null: false
    t.integer "lesson_id", null: false
    t.text "question"
    t.integer "student_id", null: false
    t.datetime "updated_at", null: false
    t.index ["lesson_id"], name: "index_student_questions_on_lesson_id"
    t.index ["student_id"], name: "index_student_questions_on_student_id"
  end

  create_table "test_results", force: :cascade do |t|
    t.text "answer"
    t.boolean "correct"
    t.datetime "created_at", null: false
    t.integer "question_id", null: false
    t.integer "score"
    t.integer "student_id", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_test_results_on_question_id"
    t.index ["student_id"], name: "index_test_results_on_student_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.integer "role", default: 0, null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "videos", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.integer "duration"
    t.integer "lesson_id", null: false
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["lesson_id"], name: "index_videos_on_lesson_id"
  end

  add_foreign_key "courses", "users", column: "teacher_id"
  add_foreign_key "learning_notes", "lessons"
  add_foreign_key "learning_notes", "users", column: "student_id"
  add_foreign_key "learning_plans", "lessons"
  add_foreign_key "learning_plans", "users", column: "student_id"
  add_foreign_key "learning_records", "lessons"
  add_foreign_key "learning_records", "users", column: "student_id"
  add_foreign_key "lessons", "courses"
  add_foreign_key "materials", "lessons"
  add_foreign_key "questions", "lessons"
  add_foreign_key "student_questions", "lessons"
  add_foreign_key "student_questions", "users", column: "student_id"
  add_foreign_key "test_results", "questions"
  add_foreign_key "test_results", "users", column: "student_id"
  add_foreign_key "videos", "lessons"
end
