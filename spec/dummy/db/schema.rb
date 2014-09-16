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

ActiveRecord::Schema.define(version: 20140916123724) do

  create_table "article_categories", force: true do |t|
    t.string   "title"
    t.boolean  "visible"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "articles", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "managers", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "managers", ["email"], name: "index_managers_on_email", unique: true
  add_index "managers", ["reset_password_token"], name: "index_managers_on_reset_password_token", unique: true

  create_table "photos", force: true do |t|
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.integer  "position"
    t.string   "src"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photos", ["imageable_id"], name: "index_photos_on_imageable_id"
  add_index "photos", ["imageable_type"], name: "index_photos_on_imageable_type"
  add_index "photos", ["token"], name: "index_photos_on_token"

end
