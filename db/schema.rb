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

ActiveRecord::Schema.define(version: 20151227230525) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bips", force: :cascade do |t|
    t.integer  "student_id"
    t.datetime "start"
    t.datetime "finish"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cards", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "user_id"
    t.datetime "start"
    t.datetime "finish"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "goals", force: :cascade do |t|
    t.integer  "bip_id"
    t.string   "text"
    t.string   "prompt"
    t.string   "meme"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "target"
  end

  create_table "observations", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "user_id"
    t.datetime "start"
    t.datetime "finish"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "records", force: :cascade do |t|
    t.integer  "observation_id"
    t.integer  "goal_id"
    t.integer  "result"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "schools", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "school_id"
    t.integer  "speducator_id"
    t.string   "alias"
    t.integer  "grade"
    t.string   "gender"
    t.string  "race"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "password_digest"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "type"
    t.integer  "school_id"
    t.string   "authenticity_token"
  end

end
