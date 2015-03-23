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

ActiveRecord::Schema.define(version: 20150318143955) do

  create_table "collections", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "game_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "play_id",    limit: 4
    t.text     "comment",    limit: 65535
    t.integer  "reported",   limit: 1,     default: 0
    t.boolean  "edited",     limit: 1,     default: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "expansions", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.integer  "year",       limit: 4
    t.integer  "bgg_id",     limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "friendships", force: :cascade do |t|
    t.integer "friendable_id", limit: 4
    t.integer "friend_id",     limit: 4
    t.integer "blocker_id",    limit: 4
    t.boolean "pending",       limit: 1, default: true
  end

  add_index "friendships", ["friendable_id", "friend_id"], name: "index_friendships_on_friendable_id_and_friend_id", unique: true, using: :btree

  create_table "games", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.integer  "year",       limit: 4
    t.integer  "bgg_id",     limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "play_expansions", force: :cascade do |t|
    t.integer  "play_id",      limit: 4
    t.integer  "expansion_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "players", force: :cascade do |t|
    t.integer  "play_id",         limit: 4,                   null: false
    t.integer  "user_id",         limit: 4
    t.integer  "score",           limit: 4
    t.boolean  "win",             limit: 1,   default: false
    t.string   "non_friend_name", limit: 255
    t.string   "team",            limit: 255
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  create_table "plays", force: :cascade do |t|
    t.integer  "game_id",    limit: 4,     null: false
    t.date     "date",                     null: false
    t.text     "notes",      limit: 65535
    t.string   "location",   limit: 255
    t.datetime "created_at",               null: false
    t.integer  "created_by", limit: 4,     null: false
    t.datetime "updated_at",               null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                   limit: 255
    t.string   "provider",               limit: 255
    t.string   "uid",                    limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
