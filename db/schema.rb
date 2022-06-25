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

ActiveRecord::Schema.define(version: 2022_06_25_080538) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "feedbacks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "survey_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["survey_id"], name: "index_feedbacks_on_survey_id"
  end

  create_table "options", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "question_id", null: false
    t.text "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_id"], name: "index_options_on_question_id"
  end

  create_table "questions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "survey_id", null: false
    t.string "title"
    t.integer "type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["survey_id"], name: "index_questions_on_survey_id"
  end

  create_table "responses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "feedback_id", null: false
    t.uuid "question_id"
    t.uuid "option_id"
    t.text "body"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["feedback_id"], name: "index_responses_on_feedback_id"
    t.index ["option_id"], name: "index_responses_on_option_id"
    t.index ["question_id"], name: "index_responses_on_question_id"
  end

  create_table "surveys", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "feedbacks", "surveys"
  add_foreign_key "options", "questions"
  add_foreign_key "questions", "surveys"
  add_foreign_key "responses", "feedbacks"
  add_foreign_key "responses", "options"
  add_foreign_key "responses", "questions"
end
