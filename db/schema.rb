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

ActiveRecord::Schema.define(:version => 20110816145709) do

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.string   "flag_image"
    t.integer  "priority"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "game_bookers_odds", :force => true do |t|
    t.string   "bookmaker_id"
    t.string   "sport_id"
    t.string   "ligue_id"
    t.string   "team_one_id"
    t.string   "team_two_id"
    t.string   "sportsmen_id"
    t.string   "bet_type_id"
    t.string   "team_one_coef"
    t.string   "team_two_coef"
    t.string   "sportsmen_coef"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ligues", :force => true do |t|
    t.string   "name"
    t.integer  "priority"
    t.integer  "country_id"
    t.integer  "sport_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sports", :force => true do |t|
    t.string   "name"
    t.string   "logo_image"
    t.integer  "priority"
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
