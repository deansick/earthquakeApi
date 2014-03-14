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

ActiveRecord::Schema.define(version: 20140314195801) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "cube"
  enable_extension "earthdistance"

  create_table "earthquakes", force: true do |t|
    t.datetime "reported_date"
    t.string   "usgs_eqid",     null: false
    t.float    "latitude"
    t.float    "longitude"
    t.float    "depth",         null: false
    t.float    "magnitude",     null: false
    t.string   "region"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "earthquakes", ["usgs_eqid"], name: "index_earthquakes_on_usgs_eqid", using: :btree

end
