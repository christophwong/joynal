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


ActiveRecord::Schema.define(version: 20140505173031) do


  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "journal_entries", force: true do |t|
    t.integer  "user_id"
    t.text     "content"
    t.integer  "emotion_rating"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "sentiment_score"
    t.string   "sentiment_type"
    t.string   "date"
  end

  add_index "journal_entries", ["created_at"], :name => "index_journal_entries_on_created_at"
  add_index "journal_entries", ["user_id"], :name => "index_journal_entries_on_user_id"

  create_table "keywords", force: true do |t|
    t.integer "journal_entry_id"
    t.string  "name"
    t.float   "relevance"
    t.float   "sentiment_score"
    t.string  "sentiment_type"
  end

  add_index "keywords", ["journal_entry_id"], :name => "index_keywords_on_journal_entry_id"
  add_index "keywords", ["name"], :name => "index_keywords_on_name"
  add_index "keywords", ["sentiment_score"], :name => "index_keywords_on_sentiment_score"

  create_table "location_records", force: true do |t|
    t.integer "journal_entry_id"
    t.spatial "coords",           limit: {:srid=>3785, :type=>"point"}
  end

  add_index "location_records", ["coords"], :name => "index_location_records_on_coords", :spatial => true

  create_table "quotes", force: true do |t|
    t.text   "body"
    t.string "author"
  end

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], :name => "taggings_idx", :unique => true

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], :name => "index_tags_on_name", :unique => true

  create_table "users", force: true do |t|
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
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
