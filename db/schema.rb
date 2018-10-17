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

ActiveRecord::Schema.define(version: 20181017003206) do

  create_table "plays", force: :cascade do |t|
    t.integer  "tournament_id"
    t.integer  "team_a_id"
    t.integer  "team_b_id"
    t.string   "round"
    t.integer  "winner"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "team_tournaments", force: :cascade do |t|
    t.integer  "team_id"
    t.integer  "tournament_id"
    t.string   "division"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "division_winner", default: false, null: false
    t.index ["team_id"], name: "index_team_tournaments_on_team_id"
    t.index ["tournament_id"], name: "index_team_tournaments_on_tournament_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tournaments", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
