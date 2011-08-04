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

ActiveRecord::Schema.define(:version => 20110803221919) do

  create_table "bookmaker_coefficients", :force => true do |t|
    t.integer  "bookmaker_id"
    t.integer  "sport_id"
    t.integer  "ligue_id"
    t.integer  "team_one_id"
    t.integer  "team_two_id"
    t.integer  "sportsmen_id"
    t.integer  "bet_type_id"
    t.string   "team_one_coef"
    t.string   "team_two_coef"
    t.string   "sportsmen_coef"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bookmaker_coefficients", ["bet_type_id"], :name => "index_bookmaker_coefficients_on_bet_type_id"
  add_index "bookmaker_coefficients", ["bookmaker_id"], :name => "index_bookmaker_coefficients_on_bookmaker_id"
  add_index "bookmaker_coefficients", ["ligue_id"], :name => "index_bookmaker_coefficients_on_ligue_id"
  add_index "bookmaker_coefficients", ["sport_id"], :name => "index_bookmaker_coefficients_on_sport_id"
  add_index "bookmaker_coefficients", ["sportsmen_coef"], :name => "index_bookmaker_coefficients_on_sportsmen_coef"
  add_index "bookmaker_coefficients", ["team_one_coef"], :name => "index_bookmaker_coefficients_on_team_one_coef"
  add_index "bookmaker_coefficients", ["team_one_id"], :name => "index_bookmaker_coefficients_on_team_one_id"
  add_index "bookmaker_coefficients", ["team_two_coef"], :name => "index_bookmaker_coefficients_on_team_two_coef"
  add_index "bookmaker_coefficients", ["team_two_id"], :name => "index_bookmaker_coefficients_on_team_two_id"

  create_table "sports", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "admin",                  :default => false
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
