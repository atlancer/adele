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

ActiveRecord::Schema.define(version: 20150314124540) do

  create_table "pages", force: :cascade do |t|
    t.integer  "parent_id",    limit: 4
    t.integer  "lft",          limit: 4,     null: false
    t.integer  "rgt",          limit: 4,     null: false
    t.string   "slug",         limit: 255
    t.string   "path",         limit: 255
    t.string   "title",        limit: 255
    t.string   "keywords",     limit: 255
    t.string   "description",  limit: 255
    t.text     "body",         limit: 65535
    t.datetime "published_at"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "pages", ["lft"], name: "index_pages_on_lft", using: :btree
  add_index "pages", ["parent_id"], name: "index_pages_on_parent_id", using: :btree
  add_index "pages", ["path"], name: "index_pages_on_path", using: :btree
  add_index "pages", ["published_at"], name: "index_pages_on_published_at", using: :btree
  add_index "pages", ["rgt"], name: "index_pages_on_rgt", using: :btree
  add_index "pages", ["slug"], name: "index_pages_on_slug", using: :btree

end
