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

ActiveRecord::Schema.define(version: 20141214131950) do

  create_table "competitions", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "country_id"
    t.string   "kind"
    t.string   "scope"
    t.string   "zone"
  end

  create_table "countries", force: true do |t|
    t.string  "name"
    t.string  "code"
    t.integer "priority", limit: 1, default: 0
  end

  create_table "goals", force: true do |t|
    t.integer  "match_id"
    t.integer  "minute"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "player_id"
    t.boolean  "own_goal",   default: false
  end

  create_table "matches", force: true do |t|
    t.integer  "home_score",     limit: 1, null: false
    t.integer  "away_score",     limit: 1, null: false
    t.date     "playing_date"
    t.integer  "home_team_id"
    t.integer  "away_team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "competition_id"
    t.string   "venue"
    t.string   "language"
    t.string   "stage"
    t.string   "season"
    t.integer  "user_id"
  end

  add_index "matches", ["user_id"], name: "index_matches_on_user_id"

  create_table "player_participations", force: true do |t|
    t.integer  "match_id"
    t.integer  "player_id"
    t.string   "role"
    t.string   "side"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "team_number", limit: 1
  end

  create_table "players", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "full_name"
    t.integer  "country_id"
    t.date     "birthday"
  end

  create_table "teams", force: true do |t|
    t.string   "name",       null: false
    t.string   "nick_names"
    t.string   "logo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "country_id"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
    t.string   "country"
    t.string   "avatar"
    t.string   "nickname"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "videos", force: true do |t|
    t.string   "source_file"
    t.integer  "match_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
