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

ActiveRecord::Schema.define(version: 20171124183817) do

  create_table "empresas", force: :cascade do |t|
    t.string   "imgLogo"
    t.string   "imgLogoAlt"
    t.string   "name"
    t.text     "description"
    t.float    "mapLon"
    t.float    "mapLat"
    t.integer  "tag_id"
    t.integer  "offer_id"
    t.string   "schedule"
    t.string   "direction"
    t.string   "web"
    t.string   "email"
    t.string   "tel"
    t.integer  "user_id"
    t.integer  "photo_id"
    t.string   "video"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["offer_id"], name: "index_empresas_on_offer_id"
    t.index ["photo_id"], name: "index_empresas_on_photo_id"
    t.index ["tag_id"], name: "index_empresas_on_tag_id"
    t.index ["user_id"], name: "index_empresas_on_user_id"
  end

  create_table "offers", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "photo_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["photo_id"], name: "index_offers_on_photo_id"
  end

  create_table "photos", force: :cascade do |t|
    t.string   "url"
    t.string   "altText"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "empresa_id"
    t.integer  "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["empresa_id"], name: "index_taggings_on_empresa_id"
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
