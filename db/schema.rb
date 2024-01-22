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

ActiveRecord::Schema[7.0].define(version: 2024_01_21_211515) do
  create_table "active_sessions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_agent"
    t.string "ip_address"
    t.string "remember_token", null: false
    t.index ["remember_token"], name: "index_active_sessions_on_remember_token", unique: true
    t.index ["user_id"], name: "index_active_sessions_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transfers", force: :cascade do |t|
    t.string "title"
    t.float "amount"
    t.integer "sender_id", null: false
    t.integer "receiver_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "sender_code"
    t.string "receiver_code"
    t.string "receiver_name", null: false
    t.index ["receiver_code"], name: "index_transfers_on_receiver_code"
    t.index ["receiver_id"], name: "index_transfers_on_receiver_id"
    t.index ["sender_code"], name: "index_transfers_on_sender_code"
    t.index ["sender_id"], name: "index_transfers_on_sender_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "confirmed_at"
    t.string "password_digest", null: false
    t.string "unconfirmed_email"
    t.string "code"
    t.decimal "balance", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "variation_number", default: 0
    t.string "password_letter_1_digest", limit: 1
    t.string "password_letter_2_digest", limit: 1
    t.string "password_letter_3_digest", limit: 1
    t.string "password_letter_4_digest", limit: 1
    t.string "password_letter_5_digest", limit: 1
    t.string "password_letter_6_digest", limit: 1
    t.string "password_letter_7_digest", limit: 1
    t.string "password_letter_8_digest", limit: 1
    t.string "password_letter_9_digest", limit: 1
    t.string "password_letter_10_digest", limit: 1
    t.string "password_letter_11_digest", limit: 1
    t.string "password_letter_12_digest", limit: 1
    t.string "password_letter_13_digest", limit: 1
    t.string "password_letter_14_digest", limit: 1
    t.string "password_letter_15_digest", limit: 1
    t.string "password_letter_16_digest", limit: 1
    t.integer "login_attempts", default: 0
    t.string "next_password"
    t.text "encrypted_credit_card"
    t.text "encrypted_personal_id"
    t.index ["code"], name: "index_users_on_code", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "active_sessions", "users", on_delete: :cascade
  add_foreign_key "transfers", "users", column: "receiver_id"
  add_foreign_key "transfers", "users", column: "sender_id"
end
