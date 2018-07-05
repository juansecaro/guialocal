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

ActiveRecord::Schema.define(version: 20180705105857) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pgcrypto"
  enable_extension "uuid-ossp"

  create_table "achievement_proposals", force: :cascade do |t|
    t.string   "title"
    t.text     "info"
    t.integer  "reward"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "achievements", force: :cascade do |t|
    t.boolean  "achievement0", default: false
    t.boolean  "achievement1", default: false
    t.boolean  "achievement2", default: false
    t.boolean  "achievement3", default: false
    t.boolean  "achievement4", default: false
    t.boolean  "achievement5", default: false
    t.boolean  "achievement6", default: false
    t.boolean  "achievement7", default: false
    t.boolean  "achievement8", default: false
    t.boolean  "achievement9", default: false
    t.integer  "user_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["user_id"], name: "index_achievements_on_user_id", using: :btree
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.string   "summary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text     "info"
    t.integer  "user_id"
    t.integer  "incident_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["incident_id"], name: "index_comments_on_incident_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "configs", force: :cascade do |t|
    t.integer  "city"
    t.json     "map_levels", default: "{}", null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "destacados", force: :cascade do |t|
    t.string   "imgdestacado"
    t.text     "info"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "empresas", force: :cascade do |t|
    t.string   "logo"
    t.string   "name"
    t.text     "description"
    t.text     "excerpt"
    t.string   "address"
    t.string   "web"
    t.string   "email"
    t.string   "tel"
    t.string   "video"
    t.json     "fotos"
    t.integer  "plan",        default: 0
    t.float    "mlon"
    t.float    "mlat"
    t.string   "schedule0"
    t.string   "schedule1"
    t.string   "schedule2"
    t.string   "schedule3"
    t.string   "schedule4"
    t.string   "schedule5"
    t.string   "schedule6"
    t.string   "schedule7"
    t.string   "schedule8"
    t.string   "schedule9"
    t.string   "schedule10"
    t.string   "schedule11"
    t.string   "schedule12"
    t.string   "schedule13"
    t.string   "schedule14"
    t.string   "schedule15"
    t.string   "schedule16"
    t.string   "schedule17"
    t.string   "schedule18"
    t.string   "schedule19"
    t.string   "schedule20"
    t.string   "schedule21"
    t.string   "schedule22"
    t.string   "schedule23"
    t.string   "schedule24"
    t.string   "schedule25"
    t.string   "schedule26"
    t.string   "schedule27"
    t.integer  "tag_id"
    t.integer  "offer_id"
    t.integer  "user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "category_id"
    t.index ["category_id"], name: "index_empresas_on_category_id", using: :btree
  end

  create_table "eventos", force: :cascade do |t|
    t.string   "titulo"
    t.text     "info"
    t.string   "imgevento"
    t.datetime "fecha"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "incidents", force: :cascade do |t|
    t.string   "subject"
    t.text     "info"
    t.integer  "status"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_incidents_on_user_id", using: :btree
  end

  create_table "maps", force: :cascade do |t|
    t.string   "level"
    t.string   "imgsrc"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "promos", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "titulo"
    t.string   "texto"
    t.string   "imgpromo"
    t.datetime "validez"
    t.integer  "empresa_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["empresa_id"], name: "index_promos_on_empresa_id", using: :btree
  end

  create_table "puntos", force: :cascade do |t|
    t.string   "title"
    t.string   "subtitle"
    t.json     "fotospunto"
    t.text     "description"
    t.float    "mlat"
    t.float    "mlon"
    t.string   "schedule"
    t.float    "price"
    t.text     "info"
    t.text     "video"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
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
    t.integer  "creditos",               default: 0,  null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "role"
    t.string   "first_name"
    t.string   "last_name"
    t.date     "birthdate"
    t.string   "dni"
    t.string   "phone"
    t.string   "address"
    t.string   "gender"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "achievements", "users"
  add_foreign_key "comments", "incidents"
  add_foreign_key "comments", "users"
  add_foreign_key "incidents", "users"
  add_foreign_key "promos", "empresas"
  add_foreign_key "taggings", "empresas"
  add_foreign_key "taggings", "tags"
end
