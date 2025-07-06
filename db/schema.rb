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

ActiveRecord::Schema[7.2].define(version: 2025_06_22_080300) do
  create_table "training_menus", force: :cascade do |t|
    t.string "name"
    t.text "rule"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "training_records", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "training_menu_id", null: false
    t.integer "count"
    t.datetime "recorded_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["training_menu_id"], name: "index_training_records_on_training_menu_id"
    t.index ["user_id"], name: "index_training_records_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.integer "role", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

  add_foreign_key "training_records", "training_menus"
  add_foreign_key "training_records", "users"
end
