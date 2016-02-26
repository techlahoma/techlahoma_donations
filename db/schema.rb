# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160226033933) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "donations", force: :cascade do |t|
    t.string   "first_name",      limit: 255
    t.string   "last_name",       limit: 255
    t.string   "email",           limit: 255
    t.decimal  "amount",                      precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "guid",            limit: 255
    t.string   "name",            limit: 255
    t.string   "token_id",        limit: 255
    t.string   "stripe_id",       limit: 255
    t.string   "stripe_status",   limit: 255
    t.text     "stripe_response"
  end

  create_table "plans", force: :cascade do |t|
    t.integer  "amount"
    t.string   "interval",       limit: 255
    t.integer  "interval_count",             default: 1
    t.string   "name",           limit: 255
    t.string   "stripe_id",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.string   "email",                  limit: 255
    t.integer  "plan_id"
    t.integer  "amount"
    t.string   "token_id",               limit: 255
    t.string   "guid",                   limit: 255
    t.text     "stripe_response"
    t.string   "stripe_id",              limit: 255
    t.string   "stripe_customer_id",     limit: 255
    t.string   "stripe_subscription_id", limit: 255
    t.datetime "current_period_start"
    t.datetime "current_period_end"
    t.datetime "ended_at"
    t.datetime "trial_start"
    t.datetime "trial_end"
    t.datetime "canceled_at"
    t.integer  "quantity"
    t.string   "stripe_status",          limit: 255
    t.boolean  "cancel_at_period_end"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "stripe_plan_id"
    t.string   "interval"
    t.integer  "interval_count"
    t.string   "plan_name"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.string   "tee_shirt_size"
    t.string   "tee_shirt_color"
    t.boolean  "accept_gift",                        default: true
    t.string   "polo_size"
    t.string   "polo_color"
    t.string   "hoodie_size"
    t.string   "hoodie_color"
    t.string   "gift_selected"
  end

  add_index "subscriptions", ["plan_id"], name: "index_subscriptions_on_plan_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
