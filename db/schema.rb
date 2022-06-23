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

ActiveRecord::Schema.define(version: 2022_06_23_102513) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "documents", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "source"
    t.integer "status"
    t.index ["user_id"], name: "index_documents_on_user_id"
  end

  create_table "payment_details", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "company"
    t.string "address_line_one"
    t.string "address_line_two"
    t.string "postal_code"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "card_number"
    t.string "exp"
    t.string "cvc"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_payment_details_on_user_id"
  end

  create_table "properties", force: :cascade do |t|
    t.string "city"
    t.string "state"
    t.string "bed_one"
    t.string "bed_two"
    t.string "country"
    t.string "postal_code"
    t.integer "property_type"
    t.string "address_line_one"
    t.string "address_line_two"
    t.string "landlord_contact_name"
    t.string "landlord_contact_phone"
    t.string "landlord_contact_email"
    t.boolean "saved_landlord", default: false
    t.boolean "currently_leased", default: false
    t.boolean "property_for_notice", default: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_properties_on_user_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "company"
    t.string "address_line_one"
    t.string "address_line_two"
    t.string "city"
    t.string "zip_code"
    t.string "country"
    t.string "state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.integer "plan", default: 0
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "uid"
    t.string "google_token"
    t.string "google_refresh_token"
    t.string "last_name"
    t.string "first_name"
    t.string "phone_number"
    t.string "company_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "documents", "users"
  add_foreign_key "payment_details", "users"
  add_foreign_key "properties", "users"
end
