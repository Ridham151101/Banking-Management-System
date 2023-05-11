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

ActiveRecord::Schema.define(version: 2023_05_11_035602) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_requests", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "customer_id", null: false
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_account_requests_on_customer_id"
    t.index ["user_id"], name: "index_account_requests_on_user_id"
  end

  create_table "accounts", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.string "account_number"
    t.string "account_type"
    t.decimal "balance"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_accounts_on_customer_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "phone"
    t.string "address"
    t.date "birthdate"
    t.string "gender"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_customers_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource"
  end

  create_table "transaction_logs", force: :cascade do |t|
    t.decimal "transaction_amount"
    t.decimal "starting_balance"
    t.decimal "ending_balance"
    t.integer "transaction_type"
    t.bigint "customer_id", null: false
    t.bigint "transaction_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_transaction_logs_on_customer_id"
    t.index ["transaction_id"], name: "index_transaction_logs_on_transaction_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.decimal "amount"
    t.string "description"
    t.integer "transaction_type"
    t.decimal "starting_balance"
    t.decimal "ending_balance"
    t.string "recipient_account_number"
    t.bigint "account_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_transactions_on_account_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "account_requests", "customers"
  add_foreign_key "account_requests", "users"
  add_foreign_key "accounts", "customers"
  add_foreign_key "customers", "users"
  add_foreign_key "transaction_logs", "customers"
  add_foreign_key "transaction_logs", "transactions"
  add_foreign_key "transactions", "accounts"
end
