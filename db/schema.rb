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

ActiveRecord::Schema.define(version: 20150808233043) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "prods", force: true do |t|
    t.text     "content"
    t.integer  "u_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "prods", ["u_id"], name: "index_prods_on_u_id", using: :btree

  create_table "products", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.string   "attach_file_name"
    t.string   "attach_content_type"
    t.integer  "attach_file_size"
    t.datetime "attach_updated_at"
    t.integer  "u_id"
    t.text     "content"
    t.text     "category"
  end

  add_index "products", ["u_id"], name: "index_products_on_u_id", using: :btree

  create_table "us", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",             default: false
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.text     "institution"
    t.text     "city"
  end

  add_index "us", ["email"], name: "index_us_on_email", unique: true, using: :btree

end
