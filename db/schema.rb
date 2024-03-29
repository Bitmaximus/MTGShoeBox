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

ActiveRecord::Schema.define(version: 20140820061937) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: true do |t|
    t.integer  "mId"
    t.integer  "relatedCardId"
    t.integer  "setNumber"
    t.string   "name"
    t.string   "searchName"
    t.text     "description"
    t.text     "flavor"
    t.string   "colors",            default: [], array: true
    t.string   "manaCost"
    t.integer  "convertedManaCost"
    t.string   "cardSetName"
    t.string   "mtgType"
    t.string   "subType"
    t.integer  "power"
    t.integer  "toughness"
    t.integer  "loyalty"
    t.string   "rarity"
    t.string   "artist"
    t.string   "cardSetId"
    t.boolean  "token"
    t.boolean  "promo"
    t.date     "releasedAt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "cards", ["user_id"], name: "index_cards_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.boolean  "admin",           default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
