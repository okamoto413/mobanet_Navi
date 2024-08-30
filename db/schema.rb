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

ActiveRecord::Schema.define(version: 2024_08_28_154732) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "plans", force: :cascade do |t|
    t.integer "carrier", limit: 2, null: false
    t.decimal "monthly_fee", precision: 10, scale: 2, default: "0.0", null: false
    t.float "data_capacity", null: false
    t.decimal "call_fee", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "plan_type", limit: 2, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "plan_name"
    t.string "official_url"
    t.string "name"
    t.index ["plan_type"], name: "index_plans_on_plan_type"
  end

  create_table "recommended_plans", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "plan_id", null: false
    t.text "reason", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["plan_id"], name: "index_recommended_plans_on_plan_id"
    t.index ["user_id"], name: "index_recommended_plans_on_user_id"
  end

  create_table "user_inputs", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.decimal "data_usage", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "call_time", default: 0, null: false
    t.integer "sms_usage", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "monthly_fee", default: "0.0", null: false
    t.decimal "other_monthly_fee"
    t.bigint "carrier"
    t.string "plan_name"
    t.string "priority"
    t.index ["user_id"], name: "index_user_inputs_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.boolean "admin", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "recommended_plans", "plans"
  add_foreign_key "recommended_plans", "users"
  add_foreign_key "user_inputs", "users"
end
