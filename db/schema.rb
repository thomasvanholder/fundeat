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

ActiveRecord::Schema.define(version: 2020_03_02_202858) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "campaigns", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "repayment_capacity"
    t.string "financial_health"
    t.string "company_history"
    t.string "risk_level"
    t.integer "min_target"
    t.integer "max_target"
    t.integer "loan_duration"
    t.float "return_rate"
    t.datetime "expiry_date"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_campaigns_on_company_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "type"
    t.string "address"
    t.float "longitude"
    t.float "latitude"
    t.integer "num_employees"
    t.string "instagram_url"
    t.string "tripadvisor_url"
    t.string "googlereview_url"
    t.string "description"
    t.bigint "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "investments", force: :cascade do |t|
    t.integer "amount"
    t.string "status"
    t.datetime "payment_date"
    t.string "stripe_session_id"
    t.bigint "investor_id"
    t.bigint "campaign_id"
    t.bigint "reward_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campaign_id"], name: "index_investments_on_campaign_id"
    t.index ["reward_id"], name: "index_investments_on_reward_id"
  end

  create_table "rewards", force: :cascade do |t|
    t.string "description"
    t.integer "investment_amount"
    t.bigint "campaign_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campaign_id"], name: "index_rewards_on_campaign_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "campaigns", "companies"
  add_foreign_key "investments", "campaigns"
  add_foreign_key "investments", "rewards"
  add_foreign_key "rewards", "campaigns"
end
