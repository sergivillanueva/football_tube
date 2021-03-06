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

ActiveRecord::Schema.define(version: 20170526221255) do

  create_table "average_caches", force: true do |t|
    t.integer  "rater_id"
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.float    "avg",           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.string   "title"
    t.text     "body"
    t.string   "subject"
    t.integer  "user_id",          null: false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "competitions", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "country_id"
    t.string   "kind"
    t.string   "scope"
    t.string   "zone"
    t.string   "slug"
  end

  add_index "competitions", ["slug"], name: "index_competitions_on_slug", unique: true, using: :btree

  create_table "countries", force: true do |t|
    t.string  "name"
    t.string  "code"
    t.integer "priority", limit: 1, default: 0
  end

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "goals", force: true do |t|
    t.integer  "match_id"
    t.integer  "minute"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "player_id"
    t.boolean  "own_goal",             default: false
    t.integer  "video_id"
    t.integer  "video_start_position"
    t.integer  "video_end_position"
    t.string   "source_file"
    t.boolean  "header"
    t.boolean  "free_kick"
    t.boolean  "outside_the_box"
    t.boolean  "super_goal"
    t.integer  "team_id"
    t.integer  "competition_id"
  end

  add_index "goals", ["competition_id"], name: "index_goals_on_competition_id", using: :btree
  add_index "goals", ["team_id"], name: "index_goals_on_team_id", using: :btree
  add_index "goals", ["video_id"], name: "index_goals_on_video_id", using: :btree

  create_table "matches", force: true do |t|
    t.integer  "home_score",             limit: 1,                 null: false
    t.integer  "away_score",             limit: 1,                 null: false
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
    t.string   "slug"
    t.text     "description"
    t.integer  "visualizations_counter",           default: 0
    t.integer  "visits_counter",                   default: 0
    t.boolean  "published",                        default: false
    t.integer  "first_leg_id"
    t.integer  "second_leg_id"
    t.integer  "replay_id"
  end

  add_index "matches", ["first_leg_id"], name: "index_matches_on_first_leg_id", using: :btree
  add_index "matches", ["replay_id"], name: "index_matches_on_replay_id", using: :btree
  add_index "matches", ["second_leg_id"], name: "index_matches_on_second_leg_id", using: :btree
  add_index "matches", ["slug"], name: "index_matches_on_slug", unique: true, using: :btree
  add_index "matches", ["user_id"], name: "index_matches_on_user_id", using: :btree

  create_table "overall_averages", force: true do |t|
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.float    "overall_avg",   null: false
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
    t.integer  "team_number", limit: 1
  end

  create_table "players", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "full_name"
    t.integer  "country_id"
    t.date     "birthday"
    t.string   "slug"
    t.integer  "visits_counter", default: 0
  end

  add_index "players", ["name", "full_name"], name: "name_full_name", type: :fulltext
  add_index "players", ["slug"], name: "index_players_on_slug", unique: true, using: :btree

  create_table "rates", force: true do |t|
    t.integer  "rater_id"
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.float    "stars",         null: false
    t.string   "dimension"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rates", ["rateable_id", "rateable_type"], name: "index_rates_on_rateable_id_and_rateable_type", using: :btree
  add_index "rates", ["rater_id"], name: "index_rates_on_rater_id", using: :btree

  create_table "rating_caches", force: true do |t|
    t.integer  "cacheable_id"
    t.string   "cacheable_type"
    t.float    "avg",            null: false
    t.integer  "qty",            null: false
    t.string   "dimension"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rating_caches", ["cacheable_id", "cacheable_type"], name: "index_rating_caches_on_cacheable_id_and_cacheable_type", using: :btree

  create_table "teams", force: true do |t|
    t.string   "name",                       null: false
    t.string   "nick_names"
    t.string   "logo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "country_id"
    t.string   "slug"
    t.integer  "visits_counter", default: 0
  end

  add_index "teams", ["slug"], name: "index_teams_on_slug", unique: true, using: :btree

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
    t.string   "avatar"
    t.string   "nick_name"
    t.integer  "country_id"
    t.string   "slug"
    t.integer  "favourite_team_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["favourite_team_id"], name: "index_users_on_favourite_team_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true, using: :btree

  create_table "videos", force: true do |t|
    t.string   "source_file"
    t.integer  "match_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
