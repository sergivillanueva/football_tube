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

ActiveRecord::Schema.define(version: 20131020173538) do

  create_table "matches", force: true do |t|
    t.integer  "home_score",   limit: 1, null: false
    t.integer  "away_score",   limit: 1, null: false
    t.date     "playing_date"
    t.integer  "home_team_id"
    t.integer  "away_team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.string   "name",         null: false
    t.string   "nick_names"
    t.string   "emblem"
    t.string   "country_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
