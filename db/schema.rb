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

ActiveRecord::Schema.define(version: 20151012194209) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "applications", force: :cascade do |t|
    t.string   "gender",               limit: 255
    t.string   "github",               limit: 255
    t.string   "tshirt_size",          limit: 255
    t.string   "cell_phone",           limit: 255
    t.string   "dietary_restrictions", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "hacker_id"
    t.string   "resume",               limit: 255
    t.boolean  "can_text",                         default: true
    t.string   "major",                limit: 255
    t.string   "degree",               limit: 255
    t.text     "essay1"
    t.text     "essay2"
    t.string   "race",                 limit: 255
    t.string   "ethnicity",            limit: 255
    t.string   "grad_date",            limit: 255
    t.string   "job_interest",         limit: 255
    t.string   "job_date",             limit: 255
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",               default: 0, null: false
    t.integer  "attempts",               default: 0, null: false
    t.text     "handler",                            null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "hacker_rankings", force: :cascade do |t|
    t.integer  "exec_id"
    t.integer  "hacker_id"
    t.integer  "ranking"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "interest_signups", force: :cascade do |t|
    t.string   "email",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "in_mailchimp",             default: false
  end

  create_table "schools", force: :cascade do |t|
    t.string   "name",                     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",                    limit: 255
    t.string   "country",                  limit: 255
    t.string   "category",                 limit: 255
    t.boolean  "is_target"
    t.string   "lat"
    t.string   "lng"
    t.integer  "transportation_method_id"
  end

  create_table "teams", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "secret_key", limit: 255
  end

  create_table "transportation_methods", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "updates", force: :cascade do |t|
    t.string   "title",         limit: 255
    t.string   "body",          limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "short_message", limit: 255
    t.string   "text_sent",     limit: 255
    t.boolean  "should_text",               default: true
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.integer  "school_id"
    t.integer  "team_id"
    t.string   "email",                  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest",        limit: 255
    t.string   "auth_token",             limit: 255
    t.string   "password_reset_token",   limit: 255
    t.datetime "password_reset_sent_at"
    t.string   "type",                   limit: 255
    t.string   "status",                 limit: 255
    t.boolean  "confirmed",                          default: false
    t.string   "transportation_method"
    t.boolean  "declined",                           default: false
    t.datetime "checked_in_time"
  end

end
