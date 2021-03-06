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

ActiveRecord::Schema.define(version: 20170807023312) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "charities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "donations", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "tweet_id"
    t.bigint "charity_id"
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "complete", default: false
    t.index ["charity_id"], name: "index_donations_on_charity_id"
    t.index ["tweet_id"], name: "index_donations_on_tweet_id"
    t.index ["user_id"], name: "index_donations_on_user_id"
  end

  create_table "preferences", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "charity_id"
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["charity_id"], name: "index_preferences_on_charity_id"
    t.index ["user_id"], name: "index_preferences_on_user_id"
  end

  create_table "tweets", force: :cascade do |t|
    t.string "tweet_id"
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_tweets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "twitter_token"
    t.string "twitter_secret"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "donations", "charities"
  add_foreign_key "donations", "tweets"
  add_foreign_key "donations", "users"
  add_foreign_key "preferences", "charities"
  add_foreign_key "preferences", "users"
  add_foreign_key "tweets", "users"
end
