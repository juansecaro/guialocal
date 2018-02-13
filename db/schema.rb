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

ActiveRecord::Schema.define(version: 20171128093755) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.string   "summary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "empresas", force: :cascade do |t|
    t.string   "logo"
    t.string   "name"
    t.text     "description"
    t.string   "address"
    t.string   "web"
    t.string   "email"
    t.string   "tel"
    t.string   "video"
    t.json     "fotos"
    t.float    "mlon"
    t.float    "mlat"
    t.time     "schedule0"
    t.time     "schedule1"
    t.time     "schedule2"
    t.time     "schedule3"
    t.time     "schedule4"
    t.time     "schedule5"
    t.time     "schedule6"
    t.time     "schedule7"
    t.time     "schedule8"
    t.time     "schedule9"
    t.time     "schedule10"
    t.time     "schedule11"
    t.time     "schedule12"
    t.time     "schedule13"
    t.time     "schedule14"
    t.time     "schedule15"
    t.time     "schedule16"
    t.time     "schedule17"
    t.time     "schedule18"
    t.time     "schedule19"
    t.time     "schedule20"
    t.time     "schedule21"
    t.time     "schedule22"
    t.time     "schedule23"
    t.time     "schedule24"
    t.time     "schedule25"
    t.time     "schedule26"
    t.time     "schedule27"
    t.integer  "tag_id"
    t.integer  "offer_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "category_id"
    t.index ["category_id"], name: "index_empresas_on_category_id", using: :btree
  end

  create_table "offers", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "empresa_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["empresa_id"], name: "index_offers_on_empresa_id", using: :btree
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "empresa_id"
    t.integer  "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["empresa_id"], name: "index_taggings_on_empresa_id", using: :btree
    t.index ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",                  default: false
    t.integer  "empresa_id"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["empresa_id"], name: "index_users_on_empresa_id", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "offers", "empresas"
  add_foreign_key "taggings", "empresas"
  add_foreign_key "taggings", "tags"
  add_foreign_key "users", "empresas"
end
