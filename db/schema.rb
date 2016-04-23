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

ActiveRecord::Schema.define(version: 20160423042811) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artists", force: :cascade do |t|
    t.string   "name"
    t.string   "spotify_id"
    t.string   "spotify_uri"
    t.integer  "spotify_popularity"
    t.string   "spotify_image_url"
    t.string   "bit_image_url"
    t.string   "website"
    t.string   "facebook_url"
    t.string   "facebook_tour_url"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "shows", force: :cascade do |t|
    t.integer  "bit_id"
    t.datetime "datetime"
    t.string   "formatted_datetime"
    t.string   "formatted_location"
    t.string   "ticket_url"
    t.string   "facebook_rsvp_url"
    t.string   "venue_name"
    t.string   "artist_name"
    t.float    "venue_latitude"
    t.float    "venue_longitude"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "title"
  end

  create_table "user_artists", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "artist_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_artists", ["artist_id"], name: "index_user_artists_on_artist_id", using: :btree
  add_index "user_artists", ["user_id"], name: "index_user_artists_on_user_id", using: :btree

  create_table "user_shows", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "show_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_shows", ["show_id"], name: "index_user_shows_on_show_id", using: :btree
  add_index "user_shows", ["user_id"], name: "index_user_shows_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "uid"
    t.string   "name"
    t.string   "nickname"
    t.string   "spotify"
    t.string   "image"
    t.string   "token"
    t.string   "refresh_token"
    t.datetime "token_expire"
    t.string   "url"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.float    "latitude"
    t.float    "longitude"
    t.string   "location"
  end

  add_foreign_key "user_artists", "artists"
  add_foreign_key "user_artists", "users"
  add_foreign_key "user_shows", "shows"
  add_foreign_key "user_shows", "users"
end
