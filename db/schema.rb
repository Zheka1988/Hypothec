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

ActiveRecord::Schema[7.0].define(version: 2022_10_04_051752) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "calculations", force: :cascade do |t|
    t.integer "apartment_price"
    t.integer "accumulation"
    t.integer "rental_cost"
    t.integer "monthly_savings"
    t.integer "mortgage_ids", default: [], array: true
    t.jsonb "calculated_values", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "addition_mortgage_term"
    t.string "addition_initial_fee"
    t.integer "addition_income"
    t.boolean "addition_proof_of_income", default: false
    t.integer "addition_age"
    t.boolean "addition_pledge", default: false
    t.integer "addition_operating_loans"
    t.string "addition_type_of_housing", default: [], array: true
    t.string "addition_city"
    t.string "addition_bank", default: [], array: true
    t.boolean "enable_default_mortgage_term", default: true
    t.boolean "enable_default_initial_fee", default: true
    t.bigint "author_id"
    t.index ["author_id"], name: "index_calculations_on_author_id"
  end

  create_table "conditions", force: :cascade do |t|
    t.string "interest_rate"
    t.string "max_loan_amount"
    t.string "max_loan_term"
    t.string "max_age"
    t.text "income"
    t.text "note"
    t.string "an_initial_fee"
    t.text "experience_and_registration"
    t.string "type_of_housing"
    t.bigint "mortgage_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "value_interest_rate_with_commision"
    t.float "value_interest_rate_without_commision"
    t.float "value_interest_rate_with_proof_of_income"
    t.float "value_interest_rate_without_proof_of_income"
    t.float "value_interest_rate_with_commision_with_proof_of_income"
    t.float "value_interest_rate_with_commision_without_proof_of_income"
    t.float "value_interest_rate_without_commision_with_proof_of_income"
    t.float "value_interest_rate_without_commision_without_proof_of_income"
    t.integer "value_max_loan_amount"
    t.integer "value_max_loan_term"
    t.integer "value_max_age"
    t.integer "value_min_an_initial_fee"
    t.integer "value_max_an_initial_fee"
    t.integer "value_income"
    t.float "value_loan_processing_fee"
    t.float "value_application_fee"
    t.float "value_arly_redemption_fee"
    t.string "additional_expenses"
    t.float "value_additional_expenses"
    t.string "pledge"
    t.string "insurance"
    t.float "value_insurance"
    t.float "value_interest_rate_for_payroll_project"
    t.index ["mortgage_id"], name: "index_conditions_on_mortgage_id"
  end

  create_table "mortgages", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "type_mortgage", default: 0
    t.string "title_banks_partners", default: [], array: true
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.boolean "admin", default: false
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "calculations", "users", column: "author_id"
  add_foreign_key "conditions", "mortgages"
end
