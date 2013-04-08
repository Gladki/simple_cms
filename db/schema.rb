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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130407201339) do

  create_table "admin_users", :force => true do |t|
    t.string   "first_name",      :limit => 25
    t.string   "last_name",       :limit => 50
    t.string   "email",           :limit => 100, :default => "", :null => false
    t.string   "hashed_password", :limit => 40
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
    t.string   "username",        :limit => 25
    t.string   "salt",            :limit => 40
  end

  add_index "admin_users", ["username"], :name => "index_admin_users_on_username"

  create_table "admin_users_pages", :id => false, :force => true do |t|
    t.integer "admin_user_id"
    t.integer "page_id"
  end

  add_index "admin_users_pages", ["admin_user_id", "page_id"], :name => "index_admin_users_pages_on_admin_user_id_and_page_id"

  create_table "cele", :force => true do |t|
    t.string   "ce_minimum"
    t.string   "ce_maximum"
    t.integer  "ce_worker_id"
    t.integer  "ce_aud_us_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "dodatki", :force => true do |t|
    t.string   "do_rodzaj_wozka"
    t.string   "do_opis"
    t.string   "do_kod"
    t.decimal  "do_czas_zakr",       :precision => 10, :scale => 2
    t.decimal  "do_czas_start_stop", :precision => 10, :scale => 2
    t.string   "do_aud_us_id"
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
  end

  create_table "effectivenes", :force => true do |t|
    t.integer  "worker_id"
    t.decimal  "effectivity",     :precision => 10, :scale => 0
    t.decimal  "effectivity_min", :precision => 10, :scale => 0
    t.decimal  "effectivity_max", :precision => 10, :scale => 0
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "groups_users", :force => true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "pages", :force => true do |t|
    t.integer  "subject_id"
    t.string   "name"
    t.string   "permalink"
    t.integer  "position"
    t.boolean  "visible",    :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "pages", ["permalink"], :name => "index_pages_on_permalink"
  add_index "pages", ["subject_id"], :name => "index_pages_on_subject_id"

  create_table "positions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "positions_workers", :force => true do |t|
    t.integer "worker_id"
    t.integer "position_id"
  end

  create_table "predkosci", :force => true do |t|
    t.string   "pr_rodzaj_wozka"
    t.string   "pr_opis"
    t.string   "pr_kod"
    t.decimal  "pr_predkosc_km",    :precision => 10, :scale => 2
    t.decimal  "pr_predkosc_metry", :precision => 10, :scale => 2
    t.decimal  "pr_tmu",            :precision => 10, :scale => 2
    t.string   "pr_aud_us_id"
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
  end

  create_table "searches", :force => true do |t|
    t.string   "keywords"
    t.integer  "id_worker"
    t.integer  "id_worker_merx"
    t.integer  "min_effectivity"
    t.integer  "max_effectivity"
    t.datetime "date_from"
    t.datetime "date_to"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "section_edits", :force => true do |t|
    t.integer  "admin_user_id"
    t.integer  "section_id"
    t.string   "summary"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "section_edits", ["admin_user_id", "section_id"], :name => "index_section_edits_on_admin_user_id_and_section_id"

  create_table "sections", :force => true do |t|
    t.integer  "page_id"
    t.string   "name"
    t.integer  "position"
    t.boolean  "visible",      :default => false
    t.string   "content_type"
    t.text     "content"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "sections", ["page_id"], :name => "index_sections_on_page_id"

  create_table "subjects", :force => true do |t|
    t.string   "name"
    t.integer  "position"
    t.boolean  "visible",    :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "tabela_normatywow", :force => true do |t|
    t.string   "tn_kod_czynnosci"
    t.string   "tn_obszar"
    t.string   "tn_opis_czynnosci"
    t.string   "tn_opis_czynnosci_szczegolowy"
    t.string   "tn_jednostka_odniesienia"
    t.decimal  "tn_czas",                       :precision => 10, :scale => 2
    t.string   "tn_komentarz"
    t.string   "tn_import_file_info"
    t.string   "tn_aud_us_id"
    t.datetime "created_at",                                                   :null => false
    t.datetime "updated_at",                                                   :null => false
  end

  create_table "tabela_transportowa", :force => true do |t|
    t.string   "tt_nr_drogi"
    t.string   "tt_nr_drogi_system"
    t.string   "tt_przebieg_trasy"
    t.string   "tt_opis_trasy"
    t.string   "tt_typ_operacji"
    t.string   "tt_obszar"
    t.string   "tt_ruch_od"
    t.string   "tt_ruch_do"
    t.string   "tt_srodek_transportu"
    t.decimal  "tt_dystans_od",        :precision => 10, :scale => 2
    t.decimal  "tt_dystans_do",        :precision => 10, :scale => 2
    t.integer  "tt_ilosc_zakretow"
    t.integer  "tt_ilosc_start_stop"
    t.string   "tt_rodzaj_pobrania"
    t.string   "tt_komentarz"
    t.string   "tt_predkosc_kod"
    t.string   "tt_import_file_info"
    t.string   "tt_aud_us_id"
    t.datetime "created_at",                                          :null => false
    t.datetime "updated_at",                                          :null => false
  end

  create_table "typy_czynnosci", :force => true do |t|
    t.string   "tc_kod"
    t.string   "tc_opis"
    t.string   "tc_zrodlo_pochodzenia"
    t.integer  "tc_aud_us_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.integer  "group"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "workers", :force => true do |t|
    t.integer  "id_worker"
    t.integer  "id_worker_merx"
    t.string   "last_name"
    t.string   "first_name"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

end
