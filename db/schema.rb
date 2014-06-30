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

ActiveRecord::Schema.define(version: 20140625044208) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assigneds", force: true do |t|
    t.integer "id_veh",                  null: false
    t.string  "run_driv",     limit: 40, null: false
    t.date    "ini_assigned"
    t.date    "fin_assigned"
  end

  add_index "assigneds", ["id"], name: "assigned_pk", unique: true, using: :btree
  add_index "assigneds", ["id_veh"], name: "relationship_22_fk", using: :btree
  add_index "assigneds", ["run_driv"], name: "relationship_21_fk", using: :btree

  create_table "base_prices", primary_key: "id_base_pr", force: true do |t|
    t.integer "val_base"
    t.date    "ini_val_base"
    t.date    "fin_val_base"
    t.string  "estado_val_base", limit: 40
  end

  add_index "base_prices", ["id_base_pr"], name: "base_prices_pk", unique: true, using: :btree

  create_table "bill_details", primary_key: "id_bill_det", force: true do |t|
    t.integer "id_bil",         null: false
    t.integer "id_conc",        null: false
    t.integer "monto_det_fact"
  end

  add_index "bill_details", ["id_bil"], name: "relationship_15_fk", using: :btree
  add_index "bill_details", ["id_bill_det"], name: "bill_details_pk", unique: true, using: :btree
  add_index "bill_details", ["id_conc"], name: "relationship_16_fk", using: :btree

  create_table "bills", primary_key: "id_bil", force: true do |t|
    t.string  "rut_ent",    limit: 40
    t.date    "fecha_fact"
    t.integer "total_fact"
  end

  add_index "bills", ["id_bil"], name: "bills_pk", unique: true, using: :btree
  add_index "bills", ["rut_ent"], name: "relationship_10_fk", using: :btree

  create_table "clients", id: false, force: true do |t|
    t.string "run_cli",    limit: 40, null: false
    t.string "nom_cli",    limit: 40
    t.string "apells_cli", limit: 40
    t.string "tel1_cli",   limit: 40
    t.string "tel2_cli",   limit: 40
    t.string "email_cli",  limit: 40
  end

  add_index "clients", ["run_cli"], name: "clients_pk", unique: true, using: :btree

  create_table "comunnes", primary_key: "id_comun", force: true do |t|
    t.string  "nom_comun", limit: 50
    t.integer "num_comun"
  end

  add_index "comunnes", ["id_comun"], name: "comunne_pk", unique: true, using: :btree

  create_table "concepts", primary_key: "id_conc", force: true do |t|
    t.string "nom_conc", limit: 60
  end

  add_index "concepts", ["id_conc"], name: "concepts_pk", unique: true, using: :btree

  create_table "drivers", id: false, force: true do |t|
    t.string "run_driv",         limit: 40, null: false
    t.string "nom_cond",         limit: 40
    t.string "apells_cond",      limit: 40
    t.string "tel1_cond",        limit: 40
    t.string "tel2_cond",        limit: 40
    t.string "email_cond",       limit: 40
    t.string "venc_licenc_cond", limit: 40
  end

  add_index "drivers", ["run_driv"], name: "drivers_pk", unique: true, using: :btree

  create_table "drivers_license_alerts", primary_key: "id_mens_alert_licenc", force: true do |t|
    t.string "plant_alert_licenc", limit: 1024
  end

  add_index "drivers_license_alerts", ["id_mens_alert_licenc"], name: "drivers_license_alerts_pk", unique: true, using: :btree

  create_table "enterprise_clients", id: false, force: true do |t|
    t.string "run_cli", limit: 40, null: false
    t.string "rut_ent", limit: 40
  end

  add_index "enterprise_clients", ["rut_ent"], name: "relationship_20_fk", using: :btree

  create_table "external_enterprises", id: false, force: true do |t|
    t.string "rut_ent",          limit: 40, null: false
    t.string "giro_emp",         limit: 40
    t.string "nom_emp",          limit: 40
    t.string "dir_emp",          limit: 40
    t.string "tel1_emp",         limit: 40
    t.string "tel2_emp",         limit: 40
    t.string "email_emp",        limit: 40
    t.string "est_conv_emp",     limit: 40
    t.date   "ini_conv_emp"
    t.date   "fin_conv_emp"
    t.text   "descrip_conv_emp"
  end

  add_index "external_enterprises", ["rut_ent"], name: "external_enterprises_pk", unique: true, using: :btree

  create_table "fixed_rates", primary_key: "id_fix_rat", force: true do |t|
    t.string  "ori_tar",   limit: 50
    t.string  "dest_tar",  limit: 50
    t.integer "costo_tar"
  end

  add_index "fixed_rates", ["id_fix_rat"], name: "fixed_rates_pk", unique: true, using: :btree

  create_table "kilometers_prices", primary_key: "id_km_pr", force: true do |t|
    t.integer "val_km"
    t.date    "ini_val_km"
    t.date    "fin_val_km"
    t.string  "estado_val_km", limit: 40
  end

  add_index "kilometers_prices", ["id_km_pr"], name: "kilometers_prices_pk", unique: true, using: :btree

  create_table "log_sqls", primary_key: "id_log_sql", force: true do |t|
    t.date   "tms_log_sql"
    t.string "tabla_log_sql",     limit: 50
    t.string "operac_log_sql",    limit: 50
    t.string "usuar_log_sql",     limit: 50
    t.string "dat_antes_log_sql", limit: 50
    t.string "dat_desp_log_sql",  limit: 50
    t.string "ope_det_log_sql",   limit: 100
  end

  add_index "log_sqls", ["id_log_sql"], name: "log_sqls_pk", unique: true, using: :btree

  create_table "natural_clients", id: false, force: true do |t|
    t.string "run_cli", limit: 40, null: false
  end

  create_table "offer_vehicles", primary_key: "id_off_veh", force: true do |t|
    t.integer "id_block"
    t.string  "run_driv",       limit: 40
    t.string  "est_oferta_veh", limit: 40
  end

  add_index "offer_vehicles", ["id_block"], name: "relationship_18_fk", using: :btree
  add_index "offer_vehicles", ["id_off_veh"], name: "offer_vehicles_pk", unique: true, using: :btree
  add_index "offer_vehicles", ["run_driv"], name: "relationship_19_fk", using: :btree

  create_table "owner_commissions", primary_key: "id_own_com", force: true do |t|
    t.float "porcent_comi_prop"
    t.date  "ini_comi_prop"
    t.date  "fin_comi_prop"
  end

  add_index "owner_commissions", ["id_own_com"], name: "owner_commissions_pk", unique: true, using: :btree

  create_table "owners", id: false, force: true do |t|
    t.string "run_own",     limit: 40, null: false
    t.string "nom_prop",    limit: 40
    t.string "apells_prop", limit: 40
    t.string "tel_prop",    limit: 40
    t.string "email_prop",  limit: 40
  end

  add_index "owners", ["run_own"], name: "owners_pk", unique: true, using: :btree

  create_table "scheduling_blocks", primary_key: "id_block", force: true do |t|
    t.datetime "ini_bloq"
    t.datetime "fin_bloq"
  end

  add_index "scheduling_blocks", ["id_block"], name: "scheduling_blocks_pk", unique: true, using: :btree

  create_table "schedulings", id: false, force: true do |t|
    t.integer "id_off_veh"
    t.string  "run_driv",   limit: 40
    t.string  "run_cli",    limit: 40
  end

  add_index "schedulings", ["id_off_veh"], name: "relationship_17_fk", using: :btree
  add_index "schedulings", ["run_cli"], name: "relationship_12_fk", using: :btree
  add_index "schedulings", ["run_driv"], name: "relationship_11_fk", using: :btree

  create_table "state_histories", id: false, force: true do |t|
    t.integer "id_trav", null: false
    t.integer "id_stat", null: false
  end

  add_index "state_histories", ["id_stat"], name: "relationship_8_fk", using: :btree
  add_index "state_histories", ["id_trav"], name: "relationship_7_fk", using: :btree

  create_table "states", primary_key: "id_stat", force: true do |t|
    t.string "nom_est", limit: 40
  end

  add_index "states", ["id_stat"], name: "states_pk", unique: true, using: :btree

  create_table "technical_review_alerts", primary_key: "id_tec_rev", force: true do |t|
    t.string "plant_alert_rev_tec", limit: 1024
  end

  add_index "technical_review_alerts", ["id_tec_rev"], name: "technical_review_alerts_pk", unique: true, using: :btree

  create_table "technical_review_expirations", primary_key: "id_tec_rev_ex", force: true do |t|
    t.string  "mes_venc_rev_tec", limit: 40
    t.integer "num_venc_rev_tec"
  end

  add_index "technical_review_expirations", ["id_tec_rev_ex"], name: "technical_review_expirations_pk", unique: true, using: :btree

  create_table "transitions", id: false, force: true do |t|
    t.integer "id_stat",     null: false
    t.integer "sta_id_stat", null: false
  end

  add_index "transitions", ["id_stat"], name: "relationship_6_fk", using: :btree
  add_index "transitions", ["sta_id_stat"], name: "relationship_5_fk", using: :btree

  create_table "travel_requests", primary_key: "id_trav_req", force: true do |t|
    t.string   "run_cli",        limit: 40
    t.string   "dir_orig_sol",   limit: 60
    t.string   "dir_dest_sol",   limit: 60
    t.string   "com_orig_sol",   limit: 60
    t.string   "com_dest_sol",   limit: 60
    t.integer  "cant_pasaj_sol"
    t.date     "fecha_crea_sol"
    t.datetime "fecha_serv_sol"
    t.string   "est_sol",        limit: 20
  end

  add_index "travel_requests", ["id_trav_req"], name: "travel_requests_pk", unique: true, using: :btree
  add_index "travel_requests", ["run_cli"], name: "relationship_4_fk", using: :btree

  create_table "travels", primary_key: "id_trav", force: true do |t|
    t.string  "run_driv",      limit: 40
    t.integer "id_trav_req",              null: false
    t.date    "hora_ini_via"
    t.time    "tiemp_est_via"
    t.float   "dist_est_via"
    t.integer "val_via"
  end

  add_index "travels", ["id_trav"], name: "travels_pk", unique: true, using: :btree
  add_index "travels", ["id_trav_req"], name: "relationship_2_fk", using: :btree
  add_index "travels", ["run_driv"], name: "relationship_13_fk", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "tipo"
    t.string   "rut"
    t.string   "nombre"
    t.string   "apellidos"
    t.string   "telefono1"
    t.string   "telefono2"
    t.date     "venc_lic_cond"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "vehicles", primary_key: "id_veh", force: true do |t|
    t.string  "run_own",    limit: 40, null: false
    t.string  "pat_veh",    limit: 10
    t.string  "mar_veh",    limit: 20
    t.string  "model_veh",  limit: 20
    t.string  "tipo_veh",   limit: 20
    t.integer "km_sem_veh"
  end

  add_index "vehicles", ["id_veh"], name: "vehicles_pk", unique: true, using: :btree
  add_index "vehicles", ["run_own"], name: "relationship_3_fk", using: :btree

end
