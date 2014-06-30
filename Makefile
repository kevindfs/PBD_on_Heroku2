scaffold_amarillo:
	rails g scaffold concepts nom_conc:string --no-migration

	rails g scaffold bill_details id_bill:integer id_conc:integer monto_det_fact:integer --no-migration

	rails g scaffold bills rut_ent:string fecha_fact:date total_fact:integer --no-migration




scaffold_rojo:
	rails g scaffold travel_requests run_cli:string dir_orig_sol:string dir_dest_sol:string com_orig_sol:string com_dest_sol:string cant_pasaj_sol:integer fecha_crea_sol:timestamp fecha_serv_sol:timestamp est_sol:string --no-migration

	rails g scaffold travels run_driv:string id_trav_req:integer hora_ini_via:time tiemp_est_via:integer dist_est_via:float val_via:integer --no-migration

	rails g scaffold state_histories id_trav:integer id_stat:integer --no-migration

	rails g scaffold states nom_est:string --no-migration

	rails g transitions id_stat:integer sta_id_stat:integer --no-migration

scaffold_celeste:
	rails g scaffold external_enterprises rut_ent:string giro_emp:string nom_emp:string dir_emp:string tel1_emp:string tel2_emp:string email_emp:string est_conv_emp:string ini_conv_emp:date fin_conv_emp:date descrip_conv_emp:text --no-migration	

	rails g scaffold natural_clients run_cli:string --no-migration

	rails g scaffold enterprise_clients run_cli:string rut_ent:string --no-migration

	rails g scaffold clients run_cli:string nom_cli:string apells_cli:string tel1_cli:string tel2_cli:string email_cli:string --no-migration

	

scaffold_verde:
	rails g scaffold schedulings id_off_veh:integer run_driv:string run_cli:string --no-migration

	rails g scaffold offer_vehicles id_block:integer run_driv:string  est_oferta_veh:string --no-migration


	rails g scaffold scheduling_blocks ini_bloq:timestamp fin_bloq:timestamp --no-migration

	rails g scaffold drivers run_driv:string nom_cond:string apells_cond:string tel1_cond:string tel2_cond:string email_cond:string venc_licenc_cond:date --no-migration

	rails g scaffold assigneds id_veh:integer run_driv:string ini_assigned:date fin_assigned:date --no-migration

	rails g scaffold vehicles run_own:string pat_veh:string mar_veh:string model_veh:string tipo_veh:string km_sem_veh:integer --no-migration

	rails g scaffold owners run_own:string nom_prop:string apells_prop:string tel_prop:string email_prop:string --no-migration

scaffold_rosado:
	rails g scaffold log_sqls tms_log_sql:date tabla_log_sql:string operac_log_sql:string usuar_log_sql:string dat_antes_log_sql:string dat_desp_log_sql:string ope_det_log_sql:string --no-migration

	rails g scaffold drivers_license_alerts plant_alert_licenc:text --no-migration

	rails g scaffold technical_review_alerts plant_alert_rev_tec:text --no-migration

	rails g scaffold base_prices val_base:integer ini_val_base:date fin_val_base:date estado_val_base:string --no-migration

	rails g scaffold kilometers_prices val_km:integer ini_val_km:date fin_val_km:date estado_val_km:string --no-migration

	rails g scaffold technical_review_expirations mes_venc_rev_tec:string num_venc_rev_tec:integer --no-migration

	rails g scaffold owner_commissions porcent_comi_prop:float ini_comi_prop:date fin_comi_prop:date --no-migration

	rails g scaffold fixed_rates ori_tar:string dest_tar:string costo_tar:integer --no-migration

	rails g scaffold comunnes nom_comun:string num_comun:integer --no-migration



destroy_amarillo:
	rails destroy scaffold concepts 

	rails destroy scaffold bill_details 

	rails destroy scaffold bills 




destroy_rojo:
	rails destroy scaffold travel_requests 

	rails destroy scaffold travels 

	rails destroy scaffold state_histories 

	rails destroy scaffold states 

	rails destroy transitions 

destroy_celeste:
	rails destroy scaffold external_enterprises 

	rails destroy scaffold natural_clients 

	rails destroy scaffold enterprise_clients

	rails destroy scaffold clients
	

destroy_verde:
	rails destroy scaffold schedulings

	rails destroy scaffold offer_vehicles

	rails destroy scaffold scheduling_blocks

	rails destroy scaffold drivers

	rails destroy scaffold assigneds

	rails destroy scaffold vehicles

	rails destroy scaffold owners

destroy_rosado:
	rails destroy scaffold log_sqls 

	rails destroy scaffold drivers_license_alerts 

	rails destroy scaffold technical_review_alerts

	rails destroy scaffold base_prices 

	rails destroy scaffold kilometers_prices 

	rails destroy scaffold technical_review_expirations 

	rails destroy scaffold owner_commissions 

	rails destroy scaffold fixed_rates 

	rails destroy scaffold comunnes



scaffold_all: scaffold_rosado scaffold_verde scaffold_celeste scaffold_rojo scaffold_amarillo	

destroy_all: destroy_rosado destroy_verde destroy_celeste destroy_rojo destroy_amarillo


migrate:
	#rake db:drop
	rake db:create
	rake db:migrate
	rake db:seed

redo: destroy scaffold migrate
	rails s