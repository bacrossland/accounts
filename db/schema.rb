# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171024053434) do

  create_table "transaction_logs", force: :cascade do |t|
    t.string "name", limit: 4
    t.string "version", limit: 11
    t.integer "record_count", limit: 4
    t.text "contents"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "transaction_log_id"
    t.integer "user_id"
    t.string "record_type", limit: 13
    t.datetime "processed_at"
    t.decimal "amount", precision: 53, scale: 17
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["transaction_log_id"], name: "index_transactions_on_transaction_log_id"
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.integer "username", limit: 8
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
