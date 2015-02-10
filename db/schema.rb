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

ActiveRecord::Schema.define(version: 20150210191813) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "hourly_scores", force: :cascade do |t|
    t.float    "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "player_id"
    t.integer  "yearday"
    t.integer  "hour"
  end

  add_index "hourly_scores", ["player_id"], name: "index_hourly_scores_on_player_id", using: :btree

  create_table "players", force: :cascade do |t|
    t.string   "name"
    t.string   "twitter_handle"
    t.integer  "current_mentions"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.boolean  "switch"
    t.string   "bggif"
  end

  create_table "total_mentions", force: :cascade do |t|
    t.integer  "total_mentions"
    t.integer  "yearday"
    t.integer  "hour"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_foreign_key "hourly_scores", "players"
end
