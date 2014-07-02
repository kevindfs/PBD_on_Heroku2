/*==============================================================*/
/* DBMS name:      PostgreSQL 8                                 */
/* Created on:     29/06/2014 23:27:41                          */
/*==============================================================*/


drop index relationship_22_fk;

drop index relationship_21_fk;

drop index assigned_pk;

drop table assigneds;

drop index base_prices_pk;

drop table base_prices;

drop index relationship_10_fk;

drop index bills_pk;

drop table bills;

drop index relationship_16_fk;

drop index relationship_15_fk;

drop index bill_details_pk;

drop table bill_details;

drop index clients_pk;

drop table clients;

drop index comunne_pk;

drop table comunnes;

drop index concepts_pk;

drop table concepts;

drop index drivers_pk;

drop table drivers;

drop index drivers_license_alerts_pk;

drop table drivers_license_alerts;

drop index relationship_20_fk;

drop table enterprise_clients;

drop index external_enterprises_pk;

drop table external_enterprises;

drop index fixed_rates_pk;

drop table fixed_rates;

drop index kilometers_prices_pk;

drop table kilometers_prices;

drop index log_sqls_pk;

drop table log_sqls;

drop table natural_clients;

drop index relationship_19_fk;

drop index relationship_18_fk;

drop index offer_vehicles_pk;

drop table offer_vehicles;

drop index owners_pk;

drop table owners;

drop index owner_commissions_pk;

drop table owner_commissions;

drop index relationship_17_fk;

drop index relationship_12_fk;

drop index relationship_11_fk;

drop table schedulings;

drop index scheduling_blocks_pk;

drop table scheduling_blocks;

drop index states_pk;

drop table states;

drop index relationship_8_fk;

drop index relationship_7_fk;

drop table state_histories;

drop index technical_review_alerts_pk;

drop table technical_review_alerts;

drop index technical_review_expirations_pk;

drop table technical_review_expirations;

drop index relationship_6_fk;

drop index relationship_5_fk;

drop table transitions;

drop index relationship_13_fk;

drop index relationship_2_fk;

drop index travels_pk;

drop table travels;

drop index relationship_4_fk;

drop index travel_requests_pk;

drop table travel_requests;

drop index relationship_3_fk;

drop index vehicles_pk;

drop table vehicles;

/*==============================================================*/
/* Table: assigneds                                             */
/*==============================================================*/
create table assigneds (
   id                   serial               not null,
   id_veh               int4                 not null,
   run_driv             varchar(40)          not null,
   ini_assigned         date                 null,
   fin_assigned         date                 null,
   constraint pk_assigneds primary key (id)
);

/*==============================================================*/
/* Index: assigned_pk                                           */
/*==============================================================*/
create unique index assigned_pk on assigneds (
id
);

/*==============================================================*/
/* Index: relationship_21_fk                                    */
/*==============================================================*/
create  index relationship_21_fk on assigneds (
run_driv
);

/*==============================================================*/
/* Index: relationship_22_fk                                    */
/*==============================================================*/
create  index relationship_22_fk on assigneds (
id_veh
);

/*==============================================================*/
/* Table: base_prices                                           */
/*==============================================================*/
create table base_prices (
   id_base_pr           serial               not null,
   val_base             int4                 null,
   ini_val_base         date                 null,
   fin_val_base         date                 null,
   estado_val_base      varchar(40)          null,
   constraint pk_base_prices primary key (id_base_pr)
);

/*==============================================================*/
/* Index: base_prices_pk                                        */
/*==============================================================*/
create unique index base_prices_pk on base_prices (
id_base_pr
);

/*==============================================================*/
/* Table: bills                                                 */
/*==============================================================*/
create table bills (
   id_bil               serial               not null,
   rut_ent              varchar(40)          null,
   fecha_fact           date                 null,
   total_fact           int4                 null,
   constraint pk_bills primary key (id_bil)
);

/*==============================================================*/
/* Index: bills_pk                                              */
/*==============================================================*/
create unique index bills_pk on bills (
id_bil
);

/*==============================================================*/
/* Index: relationship_10_fk                                    */
/*==============================================================*/
create  index relationship_10_fk on bills (
rut_ent
);

/*==============================================================*/
/* Table: bill_details                                          */
/*==============================================================*/
create table bill_details (
   id_bill_det          serial               not null,
   id_bil               int4                 not null,
   id_conc              int4                 not null,
   monto_det_fact       int4                 null,
   constraint pk_bill_details primary key (id_bill_det)
);

/*==============================================================*/
/* Index: bill_details_pk                                       */
/*==============================================================*/
create unique index bill_details_pk on bill_details (
id_bill_det
);

/*==============================================================*/
/* Index: relationship_15_fk                                    */
/*==============================================================*/
create  index relationship_15_fk on bill_details (
id_bil
);

/*==============================================================*/
/* Index: relationship_16_fk                                    */
/*==============================================================*/
create  index relationship_16_fk on bill_details (
id_conc
);

/*==============================================================*/
/* Table: clients                                               */
/*==============================================================*/
create table clients (
   run_cli              varchar(40)          not null,
   nom_cli              varchar(40)          null,
   apells_cli           varchar(40)          null,
   tel1_cli             varchar(40)          null,
   tel2_cli             varchar(40)          null,
   email_cli            varchar(40)          null,
   constraint pk_clients primary key (run_cli)
);

/*==============================================================*/
/* Index: clients_pk                                            */
/*==============================================================*/
create unique index clients_pk on clients (
run_cli
);

/*==============================================================*/
/* Table: comunnes                                              */
/*==============================================================*/
create table comunnes (
   id_comun             serial               not null,
   nom_comun            varchar(50)          null,
   num_comun            int4                 null,
   constraint pk_comunnes primary key (id_comun)
);

/*==============================================================*/
/* Index: comunne_pk                                            */
/*==============================================================*/
create unique index comunne_pk on comunnes (
id_comun
);

/*==============================================================*/
/* Table: concepts                                              */
/*==============================================================*/
create table concepts (
   id_conc              serial               not null,
   nom_conc             varchar(60)          null,
   constraint pk_concepts primary key (id_conc)
);

/*==============================================================*/
/* Index: concepts_pk                                           */
/*==============================================================*/
create unique index concepts_pk on concepts (
id_conc
);

/*==============================================================*/
/* Table: drivers                                               */
/*==============================================================*/
create table drivers (
   run_driv             varchar(40)          not null,
   nom_cond             varchar(40)          null,
   apells_cond          varchar(40)          null,
   tel1_cond            varchar(40)          null,
   tel2_cond            varchar(40)          null,
   email_cond           varchar(40)          null,
   venc_licenc_cond     date                 null,
   constraint pk_drivers primary key (run_driv)
);

/*==============================================================*/
/* Index: drivers_pk                                            */
/*==============================================================*/
create unique index drivers_pk on drivers (
run_driv
);

/*==============================================================*/
/* Table: drivers_license_alerts                                */
/*==============================================================*/
create table drivers_license_alerts (
   id_mens_alert_licenc serial               not null,
   plant_alert_licenc   varchar(1024)        null,
   constraint pk_drivers_license_alerts primary key (id_mens_alert_licenc)
);

/*==============================================================*/
/* Index: drivers_license_alerts_pk                             */
/*==============================================================*/
create unique index drivers_license_alerts_pk on drivers_license_alerts (
id_mens_alert_licenc
);

/*==============================================================*/
/* Table: enterprise_clients                                    */
/*==============================================================*/
create table enterprise_clients (
   id_cli_ent           serial               not null,
   run_cli              varchar(40)          not null,
   rut_ent              varchar(40)          null,
   constraint pk_enterprise_clients primary key (id_cli_ent)
);

/*==============================================================*/
/* Index: relationship_20_fk                                    */
/*==============================================================*/
create  index relationship_20_fk on enterprise_clients (
rut_ent
);

/*==============================================================*/
/* Table: external_enterprises                                  */
/*==============================================================*/
create table external_enterprises (
   rut_ent              varchar(40)          not null,
   giro_emp             varchar(40)          null,
   nom_emp              varchar(40)          null,
   dir_emp              varchar(40)          null,
   tel1_emp             varchar(40)          null,
   tel2_emp             varchar(40)          null,
   email_emp            varchar(40)          null,
   est_conv_emp         varchar(40)          null,
   ini_conv_emp         date                 null,
   fin_conv_emp         date                 null,
   descrip_conv_emp     text                 null,
   constraint pk_external_enterprises primary key (rut_ent)
);

/*==============================================================*/
/* Index: external_enterprises_pk                               */
/*==============================================================*/
create unique index external_enterprises_pk on external_enterprises (
rut_ent
);

/*==============================================================*/
/* Table: fixed_rates                                           */
/*==============================================================*/
create table fixed_rates (
   id_fix_rat           serial               not null,
   ori_tar              varchar(50)          null,
   dest_tar             varchar(50)          null,
   costo_tar            int4                 null,
   constraint pk_fixed_rates primary key (id_fix_rat)
);

/*==============================================================*/
/* Index: fixed_rates_pk                                        */
/*==============================================================*/
create unique index fixed_rates_pk on fixed_rates (
id_fix_rat
);

/*==============================================================*/
/* Table: kilometers_prices                                     */
/*==============================================================*/
create table kilometers_prices (
   id_km_pr             serial               not null,
   val_km               int4                 null,
   ini_val_km           date                 null,
   fin_val_km           date                 null,
   estado_val_km        varchar(40)          null,
   constraint pk_kilometers_prices primary key (id_km_pr)
);

/*==============================================================*/
/* Index: kilometers_prices_pk                                  */
/*==============================================================*/
create unique index kilometers_prices_pk on kilometers_prices (
id_km_pr
);

/*==============================================================*/
/* Table: log_sqls                                              */
/*==============================================================*/
create table log_sqls (
   id_log_sql           serial               not null,
   tms_log_sql          date                 null,
   tabla_log_sql        varchar(50)          null,
   operac_log_sql       varchar(50)          null,
   usuar_log_sql        varchar(50)          null,
   dat_antes_log_sql    varchar(50)          null,
   dat_desp_log_sql     varchar(50)          null,
   ope_det_log_sql      varchar(100)         null,
   constraint pk_log_sqls primary key (id_log_sql)
);

/*==============================================================*/
/* Index: log_sqls_pk                                           */
/*==============================================================*/
create unique index log_sqls_pk on log_sqls (
id_log_sql
);

/*==============================================================*/
/* Table: natural_clients                                       */
/*==============================================================*/
create table natural_clients (
   run_cli              varchar(40)          not null
);

/*==============================================================*/
/* Table: offer_vehicles                                        */
/*==============================================================*/
create table offer_vehicles (
   id_off_veh           serial               not null,
   id_block             int4                 null,
   run_driv             varchar(40)          null,
   est_oferta_veh       varchar(40)          null,
   constraint pk_offer_vehicles primary key (id_off_veh)
);

/*==============================================================*/
/* Index: offer_vehicles_pk                                     */
/*==============================================================*/
create unique index offer_vehicles_pk on offer_vehicles (
id_off_veh
);

/*==============================================================*/
/* Index: relationship_18_fk                                    */
/*==============================================================*/
create  index relationship_18_fk on offer_vehicles (
id_block
);

/*==============================================================*/
/* Index: relationship_19_fk                                    */
/*==============================================================*/
create  index relationship_19_fk on offer_vehicles (
run_driv
);

/*==============================================================*/
/* Table: owners                                                */
/*==============================================================*/
create table owners (
   run_own              varchar(40)          not null,
   nom_prop             varchar(40)          null,
   apells_prop          varchar(40)          null,
   tel_prop             varchar(40)          null,
   email_prop           varchar(40)          null,
   constraint pk_owners primary key (run_own)
);

/*==============================================================*/
/* Index: owners_pk                                             */
/*==============================================================*/
create unique index owners_pk on owners (
run_own
);

/*==============================================================*/
/* Table: owner_commissions                                     */
/*==============================================================*/
create table owner_commissions (
   id_own_com           serial               not null,
   porcent_comi_prop    float8               null,
   ini_comi_prop        date                 null,
   fin_comi_prop        date                 null,
   constraint pk_owner_commissions primary key (id_own_com)
);

/*==============================================================*/
/* Index: owner_commissions_pk                                  */
/*==============================================================*/
create unique index owner_commissions_pk on owner_commissions (
id_own_com
);

/*==============================================================*/
/* Table: schedulings                                           */
/*==============================================================*/
create table schedulings (
   id_sched             serial               not null,
   id_off_veh           int4                 null,
   run_driv             varchar(40)          null,
   run_cli              varchar(40)          null,
   constraint pk_schedulings primary key (id_sched)
);

/*==============================================================*/
/* Index: relationship_11_fk                                    */
/*==============================================================*/
create  index relationship_11_fk on schedulings (
run_driv
);

/*==============================================================*/
/* Index: relationship_12_fk                                    */
/*==============================================================*/
create  index relationship_12_fk on schedulings (
run_cli
);

/*==============================================================*/
/* Index: relationship_17_fk                                    */
/*==============================================================*/
create  index relationship_17_fk on schedulings (
id_off_veh
);

/*==============================================================*/
/* Table: scheduling_blocks                                     */
/*==============================================================*/
create table scheduling_blocks (
   id_block             serial               not null,
   ini_bloq             timestamp            null,
   fin_bloq             timestamp            null,
   constraint pk_scheduling_blocks primary key (id_block)
);

/*==============================================================*/
/* Index: scheduling_blocks_pk                                  */
/*==============================================================*/
create unique index scheduling_blocks_pk on scheduling_blocks (
id_block
);

/*==============================================================*/
/* Table: states                                                */
/*==============================================================*/
create table states (
   id_stat              serial               not null,
   nom_est              varchar(40)          null,
   constraint pk_states primary key (id_stat)
);

/*==============================================================*/
/* Index: states_pk                                             */
/*==============================================================*/
create unique index states_pk on states (
id_stat
);

/*==============================================================*/
/* Table: state_histories                                       */
/*==============================================================*/
create table state_histories (
   id_trav              int4                 not null,
   id_stat              int4                 not null
);

/*==============================================================*/
/* Index: relationship_7_fk                                     */
/*==============================================================*/
create  index relationship_7_fk on state_histories (
id_trav
);

/*==============================================================*/
/* Index: relationship_8_fk                                     */
/*==============================================================*/
create  index relationship_8_fk on state_histories (
id_stat
);

/*==============================================================*/
/* Table: technical_review_alerts                               */
/*==============================================================*/
create table technical_review_alerts (
   id_tec_rev           serial               not null,
   plant_alert_rev_tec  varchar(1024)        null,
   constraint pk_technical_review_alerts primary key (id_tec_rev)
);

/*==============================================================*/
/* Index: technical_review_alerts_pk                            */
/*==============================================================*/
create unique index technical_review_alerts_pk on technical_review_alerts (
id_tec_rev
);

/*==============================================================*/
/* Table: technical_review_expirations                          */
/*==============================================================*/
create table technical_review_expirations (
   id_tec_rev_ex        serial               not null,
   mes_venc_rev_tec     varchar(40)          null,
   num_venc_rev_tec     int4                 null,
   constraint pk_technical_review_expiration primary key (id_tec_rev_ex)
);

/*==============================================================*/
/* Index: technical_review_expirations_pk                       */
/*==============================================================*/
create unique index technical_review_expirations_pk on technical_review_expirations (
id_tec_rev_ex
);

/*==============================================================*/
/* Table: transitions                                           */
/*==============================================================*/
create table transitions (
   id_stat              int4                 not null,
   sta_id_stat          int4                 not null
);

/*==============================================================*/
/* Index: relationship_5_fk                                     */
/*==============================================================*/
create  index relationship_5_fk on transitions (
sta_id_stat
);

/*==============================================================*/
/* Index: relationship_6_fk                                     */
/*==============================================================*/
create  index relationship_6_fk on transitions (
id_stat
);

/*==============================================================*/
/* Table: travels                                               */
/*==============================================================*/
create table travels (
   id_trav              serial               not null,
   run_driv             varchar(40)          null,
   id_trav_req          int4                 not null,
   hora_ini_via         date                 null,
   tiemp_est_via        time                 null,
   dist_est_via         float8               null,
   val_via              int4                 null,
   constraint pk_travels primary key (id_trav)
);

/*==============================================================*/
/* Index: travels_pk                                            */
/*==============================================================*/
create unique index travels_pk on travels (
id_trav
);

/*==============================================================*/
/* Index: relationship_2_fk                                     */
/*==============================================================*/
create  index relationship_2_fk on travels (
id_trav_req
);

/*==============================================================*/
/* Index: relationship_13_fk                                    */
/*==============================================================*/
create  index relationship_13_fk on travels (
run_driv
);

/*==============================================================*/
/* Table: travel_requests                                       */
/*==============================================================*/
create table travel_requests (
   id_trav_req          serial               not null,
   run_cli              varchar(40)          null,
   dir_orig_sol         varchar(60)          null,
   dir_dest_sol         varchar(60)          null,
   com_orig_sol         varchar(60)          null,
   com_dest_sol         varchar(60)          null,
   cant_pasaj_sol       int4                 null,
   fecha_crea_sol       date                 null,
   fecha_serv_sol       timestamp            null,
   est_sol              varchar(20)          null,
   constraint pk_travel_requests primary key (id_trav_req)
);

/*==============================================================*/
/* Index: travel_requests_pk                                    */
/*==============================================================*/
create unique index travel_requests_pk on travel_requests (
id_trav_req
);

/*==============================================================*/
/* Index: relationship_4_fk                                     */
/*==============================================================*/
create  index relationship_4_fk on travel_requests (
run_cli
);

/*==============================================================*/
/* Table: vehicles                                              */
/*==============================================================*/
create table vehicles (
   id_veh               serial               not null,
   run_own              varchar(40)          not null,
   pat_veh              varchar(10)          null,
   mar_veh              varchar(20)          null,
   model_veh            varchar(20)          null,
   tipo_veh             varchar(20)          null,
   km_sem_veh           int4                 null,
   constraint pk_vehicles primary key (id_veh)
);

/*==============================================================*/
/* Index: vehicles_pk                                           */
/*==============================================================*/
create unique index vehicles_pk on vehicles (
id_veh
);

/*==============================================================*/
/* Index: relationship_3_fk                                     */
/*==============================================================*/
create  index relationship_3_fk on vehicles (
run_own
);

alter table assigneds
   add constraint fk_assigned_relations_drivers foreign key (run_driv)
      references drivers (run_driv)
      on delete restrict on update restrict;

alter table assigneds
   add constraint fk_assigned_relations_vehicles foreign key (id_veh)
      references vehicles (id_veh)
      on delete restrict on update restrict;

alter table bills
   add constraint fk_bills_relations_external foreign key (rut_ent)
      references external_enterprises (rut_ent)
      on delete restrict on update restrict;

alter table bill_details
   add constraint fk_bill_det_relations_bills foreign key (id_bil)
      references bills (id_bil)
      on delete restrict on update restrict;

alter table bill_details
   add constraint fk_bill_det_relations_concepts foreign key (id_conc)
      references concepts (id_conc)
      on delete restrict on update restrict;

alter table enterprise_clients
   add constraint fk_enterpri_cliente_clients foreign key (run_cli)
      references clients (run_cli)
      on delete restrict on update restrict;

alter table enterprise_clients
   add constraint fk_enterpri_relations_external foreign key (rut_ent)
      references external_enterprises (rut_ent)
      on delete restrict on update restrict;

alter table natural_clients
   add constraint fk_natural__cliente2_clients foreign key (run_cli)
      references clients (run_cli)
      on delete restrict on update restrict;

alter table offer_vehicles
   add constraint fk_offer_ve_relations_scheduli foreign key (id_block)
      references scheduling_blocks (id_block)
      on delete restrict on update restrict;

alter table offer_vehicles
   add constraint fk_offer_ve_relations_drivers foreign key (run_driv)
      references drivers (run_driv)
      on delete restrict on update restrict;

alter table schedulings
   add constraint fk_scheduli_relations_drivers foreign key (run_driv)
      references drivers (run_driv)
      on delete restrict on update restrict;

alter table schedulings
   add constraint fk_scheduli_relations_clients foreign key (run_cli)
      references clients (run_cli)
      on delete restrict on update restrict;

alter table schedulings
   add constraint fk_scheduli_relations_offer_ve foreign key (id_off_veh)
      references offer_vehicles (id_off_veh)
      on delete restrict on update restrict;

alter table state_histories
   add constraint fk_state_hi_relations_travels foreign key (id_trav)
      references travels (id_trav)
      on delete restrict on update restrict;

alter table state_histories
   add constraint fk_state_hi_relations_states foreign key (id_stat)
      references states (id_stat)
      on delete restrict on update restrict;

alter table transitions
   add constraint fk_transiti_relations_states2 foreign key (sta_id_stat)
      references states (id_stat)
      on delete restrict on update restrict;

alter table transitions
   add constraint fk_transiti_relations_states foreign key (id_stat)
      references states (id_stat)
      on delete restrict on update restrict;

alter table travels
   add constraint fk_travels_relations_drivers foreign key (run_driv)
      references drivers (run_driv)
      on delete restrict on update restrict;

alter table travels
   add constraint fk_travels_relations_travel_r foreign key (id_trav_req)
      references travel_requests (id_trav_req)
      on delete restrict on update restrict;

alter table travel_requests
   add constraint fk_travel_r_relations_clients foreign key (run_cli)
      references clients (run_cli)
      on delete restrict on update restrict;

alter table vehicles
   add constraint fk_vehicles_relations_owners foreign key (run_own)
      references owners (run_own)
      on delete restrict on update restrict;

