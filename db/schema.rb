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

ActiveRecord::Schema.define(version: 20200507225042) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pgcrypto"
  enable_extension "uuid-ossp"

  create_table "achievement_proposals", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "info"
    t.integer "reward"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "achievements", id: :serial, force: :cascade do |t|
    t.boolean "achievement0", default: false
    t.boolean "achievement1", default: false
    t.boolean "achievement2", default: false
    t.boolean "achievement3", default: false
    t.boolean "achievement4", default: false
    t.boolean "achievement5", default: false
    t.boolean "achievement6", default: false
    t.boolean "achievement7", default: false
    t.boolean "achievement8", default: false
    t.boolean "achievement9", default: false
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_achievements_on_user_id"
  end

  create_table "ambassadors", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.string "picture"
    t.integer "country"
    t.integer "language"
    t.string "bio_original"
    t.string "bio_english"
    t.string "bio_native"
    t.text "review_original"
    t.text "review_english"
    t.text "review_native"
    t.string "video_interview"
    t.string "video_testimonial"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "partner_name"
    t.string "partner_profile"
    t.json "gallery"
    t.integer "gender"
    t.index ["slug"], name: "index_ambassadors_on_slug", unique: true
  end

  create_table "categories", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "summary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
  end

  create_table "comments", id: :serial, force: :cascade do |t|
    t.text "info"
    t.integer "user_id"
    t.integer "incident_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["incident_id"], name: "index_comments_on_incident_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "configs", id: :serial, force: :cascade do |t|
    t.integer "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "number_of_points"
    t.integer "number_of_promos"
    t.integer "number_of_events"
    t.string "header"
  end

  create_table "destacados", id: :serial, force: :cascade do |t|
    t.string "imgdestacado"
    t.text "info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "titulo"
  end

  create_table "empresas", id: :serial, force: :cascade do |t|
    t.string "logo"
    t.string "name"
    t.text "description"
    t.text "excerpt"
    t.string "address"
    t.string "web"
    t.string "email"
    t.string "tel"
    t.string "video"
    t.json "fotos"
    t.integer "plan", default: 0
    t.float "mlon"
    t.float "mlat"
    t.string "schedule0"
    t.string "schedule1"
    t.string "schedule2"
    t.string "schedule3"
    t.string "schedule4"
    t.string "schedule5"
    t.string "schedule6"
    t.string "schedule7"
    t.string "schedule8"
    t.string "schedule9"
    t.string "schedule10"
    t.string "schedule11"
    t.string "schedule12"
    t.string "schedule13"
    t.string "schedule14"
    t.string "schedule15"
    t.string "schedule16"
    t.string "schedule17"
    t.string "schedule18"
    t.string "schedule19"
    t.string "schedule20"
    t.string "schedule21"
    t.string "schedule22"
    t.string "schedule23"
    t.string "schedule24"
    t.string "schedule25"
    t.string "schedule26"
    t.string "schedule27"
    t.integer "tag_id"
    t.integer "offer_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "category_id"
    t.string "slug"
    t.index ["category_id"], name: "index_empresas_on_category_id"
  end

  create_table "eventos", id: :serial, force: :cascade do |t|
    t.string "titulo"
    t.text "info"
    t.string "imgevento"
    t.datetime "fecha"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.integer "version", default: 0
  end

  create_table "friendly_id_slugs", id: :serial, force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "incidents", id: :serial, force: :cascade do |t|
    t.string "subject"
    t.text "info"
    t.integer "status"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_incidents_on_user_id"
  end

  create_table "maps", id: :serial, force: :cascade do |t|
    t.string "level"
    t.text "title"
    t.text "description"
    t.string "imgsrc"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
  end

  create_table "nodes", force: :cascade do |t|
    t.integer "number"
    t.string "address"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "promos", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "titulo"
    t.string "texto"
    t.string "imgpromo"
    t.datetime "validez"
    t.integer "empresa_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "normal_price"
    t.decimal "special_price"
    t.integer "version", default: 0
    t.index ["empresa_id"], name: "index_promos_on_empresa_id"
  end

  create_table "prospects", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "user_email"
    t.string "dni"
    t.integer "plan"
    t.integer "original_plan"
    t.string "status", default: "created"
    t.string "empresa_name"
    t.string "empresa_email"
    t.integer "empresa_phone"
    t.string "empresa_address"
    t.string "empresa_web"
    t.integer "empresa_category"
    t.string "empresa_summary"
    t.string "user_first_name"
    t.string "user_last_name"
    t.datetime "user_birthday"
    t.string "user_phone"
    t.string "user_address"
    t.string "iban_code"
    t.boolean "conditions_accepted", default: false
    t.string "ip_address"
    t.datetime "date_of_acceptance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "puntos", id: :serial, force: :cascade do |t|
    t.string "title"
    t.string "subtitle"
    t.json "fotospunto"
    t.text "description"
    t.float "mlat"
    t.float "mlon"
    t.string "schedule"
    t.float "price"
    t.text "info"
    t.text "video"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
  end

  create_table "suscriptors", id: :serial, force: :cascade do |t|
    t.string "email"
    t.boolean "email_confirmation", default: false
    t.string "token_confirmation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "empresa_id"
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "empresa_id"
    t.integer "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["empresa_id"], name: "index_taggings_on_empresa_id"
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role"
    t.string "first_name"
    t.string "last_name"
    t.date "birthdate"
    t.string "dni"
    t.string "phone"
    t.string "address"
    t.string "gender"
    t.integer "current_empresa"
    t.boolean "conditions_accepted", default: false
    t.string "date_of_acceptance"
    t.string "ip_address"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "achievements", "users"
  add_foreign_key "comments", "incidents"
  add_foreign_key "comments", "users"
  add_foreign_key "incidents", "users"
  add_foreign_key "promos", "empresas"
  add_foreign_key "taggings", "empresas"
  add_foreign_key "taggings", "tags"
end
