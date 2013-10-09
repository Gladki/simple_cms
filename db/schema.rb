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

ActiveRecord::Schema.define(:version => 20131009133223) do

  create_table "cele", :force => true do |t|
    t.string   "ce_minimum"
    t.string   "ce_maximum"
    t.integer  "ce_aud_us_id"
    t.integer  "ce_worker_id"
    t.integer  "ce_id_worker_merx"
    t.date     "ce_data"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
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
    t.datetime "ef_data"
    t.integer  "ef_aud_us_id"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "groups_users", :force => true do |t|
    t.integer "user_id"
    t.integer "group_id"
  end

  create_table "jednostka_organizacyjna", :force => true do |t|
    t.string   "name"
    t.string   "w_import_info"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "obszary", :force => true do |t|
    t.string   "ob_nazwa"
    t.string   "ob_magazyn"
    t.string   "ob_opis"
    t.string   "ob_kod"
    t.decimal  "ob_wartosc",   :precision => 10, :scale => 2
    t.string   "ob_aud_us_id"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
  end

  create_table "positions", :force => true do |t|
    t.integer  "worker_id"
    t.string   "name"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.string   "w_import_info", :limit => 45
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

  create_table "premie", :force => true do |t|
    t.string   "pe_tytul"
    t.string   "pe_worker_id"
    t.string   "pe_data_od"
    t.string   "pe_data_do"
    t.decimal  "pe_wartosc",   :precision => 10, :scale => 2
    t.string   "pe_aud_us_id"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
  end

  create_table "realizacja_norm", :force => true do |t|
    t.integer  "rn_id_worker"
    t.integer  "rn_id_worker_hr"
    t.integer  "rn_id_worker_merx"
    t.date     "rn_data"
    t.string   "rn_obszar"
    t.string   "rn_magazyn"
    t.string   "rn_typ_operacji"
    t.string   "rn_komentarz"
    t.decimal  "rn_normatywy_czas_suma_tg", :precision => 10, :scale => 2
    t.decimal  "rn_normatywy_czas_suma_tj", :precision => 10, :scale => 2
    t.string   "rn_import_file_info"
    t.string   "rn_aud_us_id"
    t.datetime "created_at",                                               :null => false
    t.datetime "updated_at",                                               :null => false
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
    t.string   "stanowisko"
  end

  create_table "tabela_czasow_dostepnych", :force => true do |t|
    t.integer  "tcd_id_worker"
    t.integer  "tcd_id_worker_merx"
    t.date     "tcd_data"
    t.decimal  "tcd_sum_godz_przep",   :precision => 10, :scale => 2
    t.decimal  "tcd_sum_godz_chor",    :precision => 10, :scale => 2
    t.string   "tcd_import_file_info"
    t.string   "tcd_aud_us_id"
    t.datetime "created_at",                                          :null => false
    t.datetime "updated_at",                                          :null => false
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
    t.string   "tt_dodatek_kod"
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
    t.integer  "id_worker_hr"
    t.integer  "id_worker_merx"
    t.string   "jednostka_organizacyjna"
    t.string   "last_name"
    t.string   "first_name"
    t.string   "obszar"
    t.string   "profil_merx"
    t.string   "stanowisko"
    t.string   "przelozony"
    t.string   "przelozony_przelozonego"
    t.string   "w_import_info"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

end
