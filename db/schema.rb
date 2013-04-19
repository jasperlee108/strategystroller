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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130419074501) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "activities", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "phase"
    t.date     "startDate"
    t.date     "endDate"
    t.integer  "targetManp"
    t.decimal  "targetCost"
    t.text     "notes"
    t.integer  "actualManp"
    t.decimal  "actualCost"
    t.string   "actualProg"
    t.text     "statusNotes"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "project_id"
    t.text     "team"
    t.string   "short_name"
  end

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "applications", :force => true do |t|
    t.string   "company"
    t.integer  "curr_year"
    t.integer  "init_year"
    t.string   "language"
    t.integer  "time_horizon"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "dimensions", :force => true do |t|
    t.string   "name"
    t.float    "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "forms", :force => true do |t|
    t.integer  "lookup"
    t.integer  "user_id"
    t.boolean  "checked"
    t.boolean  "reviewed"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.boolean  "submitted"
    t.date     "last_reminder"
  end

  create_table "goals", :force => true do |t|
    t.string   "name"
    t.string   "need"
    t.string   "justification"
    t.string   "focus"
    t.string   "notes"
    t.float    "status"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "dimension_id"
    t.integer  "user_id"
    t.string   "prereq"
    t.string   "short_name"
  end

  create_table "indicators", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "source"
    t.string   "unit"
    t.string   "freq"
    t.string   "indicator_type"
    t.string   "dir"
    t.float    "actual"
    t.float    "target"
    t.text     "notes"
    t.float    "diff"
    t.float    "status"
    t.text     "status_notes"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "goal_id"
    t.integer  "user_id"
    t.string   "short_name"
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "team"
    t.date     "startDate"
    t.date     "endDate"
    t.float    "duration"
    t.integer  "target_manp"
    t.decimal  "target_cost"
    t.boolean  "inplan"
    t.boolean  "compensation"
    t.text     "notes"
    t.integer  "actual_manp"
    t.decimal  "actual_cost"
    t.float    "status_prog"
    t.integer  "status_ms"
    t.integer  "status_manp"
    t.decimal  "status_cost"
    t.float    "status_global"
    t.text     "status_notes"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "indicator_id"
    t.integer  "head_id"
    t.integer  "steer_id"
    t.string   "short_name"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "username"
    t.boolean  "controlling_unit",       :default => false
    t.string   "business_code"
    t.string   "temp_password"
    t.integer  "application_id"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

end
