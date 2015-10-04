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

ActiveRecord::Schema.define(version: 20151005125600) do

  create_table "animal_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
  end

  create_table "reports", force: :cascade do |t|
    t.string   "summary"
    t.text     "description"
    t.string   "report_type"
    t.string   "reporter_name"
    t.text     "reporter_contact_info"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "animal_type_id"
    t.boolean  "reunited"
    t.boolean  "reuniter_is_reporter"
    t.string   "reuniter_name"
    t.string   "reuniter_email"
    t.datetime "reunited_at"
    t.text     "reuniter_comment"
    t.boolean  "reunion_confirmed"
    t.string   "reunion_confirmed_by"
    t.datetime "reunion_confirmed_at"
    t.text     "reunion_confirmation_notes"
    t.string   "reporter_email"
    t.integer  "location_id"
  end

  add_index "reports", ["animal_type_id"], name: "index_reports_on_animal_type_id"
  add_index "reports", ["location_id"], name: "index_reports_on_location_id"

end
