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

ActiveRecord::Schema.define(version: 20131208105425) do

  create_table "countries", force: true do |t|
    t.string  "name"
    t.string  "code"
    t.integer "priority", limit: 1, default: 0
  end

  create_table "matches", force: true do |t|
    t.integer  "home_score",   limit: 1, null: false
    t.integer  "away_score",   limit: 1, null: false
    t.date     "playing_date"
    t.integer  "home_team_id"
    t.integer  "away_team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "player_participations", force: true do |t|
    t.integer  "match_id"
    t.integer  "player_id"
    t.string   "role"
    t.string   "side"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "full_name"
  end

  create_table "teams", force: true do |t|
    t.string   "name",         null: false
    t.string   "nick_names"
    t.string   "logo"
    t.string   "country_code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "country_id"
  end

end
