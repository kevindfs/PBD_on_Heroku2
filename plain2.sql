--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.2
-- Dumped by pg_dump version 9.3.2
-- Started on 2014-07-01 22:54:23

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 222 (class 3079 OID 11750)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2299 (class 0 OID 0)
-- Dependencies: 222
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 236 (class 1255 OID 50721)
-- Name: actualizar_tipo_users(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION actualizar_tipo_users() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE BEGIN
	
	IF (NEW.tipo = 'conductor' AND OLD.tipo='cli_nat')   THEN

		INSERT INTO drivers VALUES (NEW.rut, NEW.nombre, NEW.apellidos, NEW.telefono1, NEW.telefono2, NEW.email, NEW.venc_lic_cond);
							
	END IF;

	
	RETURN NULL;
	
END;
$$;


ALTER FUNCTION public.actualizar_tipo_users() OWNER TO postgres;

--
-- TOC entry 235 (class 1255 OID 50719)
-- Name: insertar_clients(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION insertar_clients() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE BEGIN
	
	IF (NEW.tipo = 'cli_nat')   THEN

		INSERT INTO clients VALUES (NEW.rut, NEW.nombre, NEW.apellidos, NEW.telefono1, NEW.telefono2, NEW.email);
		INSERT INTO natural_clients VALUES (NEW.rut);		
					
	END IF;

	IF (NEW.tipo = 'conductor')   THEN
	
		INSERT INTO drivers VALUES (NEW.rut, NEW.nombre, NEW.apellidos, NEW.telefono1, NEW.telefono2, NEW.email, NEW.venc_lic_cond);
		
							
	END IF;
	
	RETURN NULL;
	
END;
$$;


ALTER FUNCTION public.insertar_clients() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 171 (class 1259 OID 50347)
-- Name: assigneds; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE assigneds (
    id integer NOT NULL,
    id_veh integer NOT NULL,
    run_driv character varying(40) NOT NULL,
    ini_assigned date,
    fin_assigned date
);


ALTER TABLE public.assigneds OWNER TO postgres;

--
-- TOC entry 170 (class 1259 OID 50345)
-- Name: assigneds_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE assigneds_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.assigneds_id_seq OWNER TO postgres;

--
-- TOC entry 2300 (class 0 OID 0)
-- Dependencies: 170
-- Name: assigneds_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE assigneds_id_seq OWNED BY assigneds.id;


--
-- TOC entry 173 (class 1259 OID 50358)
-- Name: base_prices; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE base_prices (
    id_base_pr integer NOT NULL,
    val_base integer,
    ini_val_base date,
    fin_val_base date,
    estado_val_base character varying(40)
);


ALTER TABLE public.base_prices OWNER TO postgres;

--
-- TOC entry 172 (class 1259 OID 50356)
-- Name: base_prices_id_base_pr_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE base_prices_id_base_pr_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.base_prices_id_base_pr_seq OWNER TO postgres;

--
-- TOC entry 2301 (class 0 OID 0)
-- Dependencies: 172
-- Name: base_prices_id_base_pr_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE base_prices_id_base_pr_seq OWNED BY base_prices.id_base_pr;


--
-- TOC entry 177 (class 1259 OID 50377)
-- Name: bill_details; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE bill_details (
    id_bill_det integer NOT NULL,
    id_bil integer NOT NULL,
    id_conc integer NOT NULL,
    monto_det_fact integer
);


ALTER TABLE public.bill_details OWNER TO postgres;

--
-- TOC entry 176 (class 1259 OID 50375)
-- Name: bill_details_id_bill_det_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE bill_details_id_bill_det_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bill_details_id_bill_det_seq OWNER TO postgres;

--
-- TOC entry 2302 (class 0 OID 0)
-- Dependencies: 176
-- Name: bill_details_id_bill_det_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE bill_details_id_bill_det_seq OWNED BY bill_details.id_bill_det;


--
-- TOC entry 175 (class 1259 OID 50367)
-- Name: bills; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE bills (
    id_bil integer NOT NULL,
    rut_ent character varying(40),
    fecha_fact date,
    total_fact integer
);


ALTER TABLE public.bills OWNER TO postgres;

--
-- TOC entry 174 (class 1259 OID 50365)
-- Name: bills_id_bil_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE bills_id_bil_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bills_id_bil_seq OWNER TO postgres;

--
-- TOC entry 2303 (class 0 OID 0)
-- Dependencies: 174
-- Name: bills_id_bil_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE bills_id_bil_seq OWNED BY bills.id_bil;


--
-- TOC entry 178 (class 1259 OID 50386)
-- Name: clients; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE clients (
    run_cli character varying(40) NOT NULL,
    nom_cli character varying(40),
    apells_cli character varying(40),
    tel1_cli character varying(40),
    tel2_cli character varying(40),
    email_cli character varying(40)
);


ALTER TABLE public.clients OWNER TO postgres;

--
-- TOC entry 180 (class 1259 OID 50394)
-- Name: comunnes; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE comunnes (
    id_comun integer NOT NULL,
    nom_comun character varying(50),
    num_comun integer
);


ALTER TABLE public.comunnes OWNER TO postgres;

--
-- TOC entry 179 (class 1259 OID 50392)
-- Name: comunnes_id_comun_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE comunnes_id_comun_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comunnes_id_comun_seq OWNER TO postgres;

--
-- TOC entry 2304 (class 0 OID 0)
-- Dependencies: 179
-- Name: comunnes_id_comun_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE comunnes_id_comun_seq OWNED BY comunnes.id_comun;


--
-- TOC entry 182 (class 1259 OID 50403)
-- Name: concepts; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE concepts (
    id_conc integer NOT NULL,
    nom_conc character varying(60)
);


ALTER TABLE public.concepts OWNER TO postgres;

--
-- TOC entry 181 (class 1259 OID 50401)
-- Name: concepts_id_conc_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE concepts_id_conc_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.concepts_id_conc_seq OWNER TO postgres;

--
-- TOC entry 2305 (class 0 OID 0)
-- Dependencies: 181
-- Name: concepts_id_conc_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE concepts_id_conc_seq OWNED BY concepts.id_conc;


--
-- TOC entry 183 (class 1259 OID 50410)
-- Name: drivers; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE drivers (
    run_driv character varying(40) NOT NULL,
    nom_cond character varying(40),
    apells_cond character varying(40),
    tel1_cond character varying(40),
    tel2_cond character varying(40),
    email_cond character varying(40),
    venc_licenc_cond date
);


ALTER TABLE public.drivers OWNER TO postgres;

--
-- TOC entry 185 (class 1259 OID 50418)
-- Name: drivers_license_alerts; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE drivers_license_alerts (
    id_mens_alert_licenc integer NOT NULL,
    plant_alert_licenc character varying(1024)
);


ALTER TABLE public.drivers_license_alerts OWNER TO postgres;

--
-- TOC entry 184 (class 1259 OID 50416)
-- Name: drivers_license_alerts_id_mens_alert_licenc_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE drivers_license_alerts_id_mens_alert_licenc_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.drivers_license_alerts_id_mens_alert_licenc_seq OWNER TO postgres;

--
-- TOC entry 2306 (class 0 OID 0)
-- Dependencies: 184
-- Name: drivers_license_alerts_id_mens_alert_licenc_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE drivers_license_alerts_id_mens_alert_licenc_seq OWNED BY drivers_license_alerts.id_mens_alert_licenc;


--
-- TOC entry 187 (class 1259 OID 50430)
-- Name: enterprise_clients; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE enterprise_clients (
    id_cli_ent integer NOT NULL,
    run_cli character varying(40) NOT NULL,
    rut_ent character varying(40)
);


ALTER TABLE public.enterprise_clients OWNER TO postgres;

--
-- TOC entry 186 (class 1259 OID 50428)
-- Name: enterprise_clients_id_cli_ent_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE enterprise_clients_id_cli_ent_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.enterprise_clients_id_cli_ent_seq OWNER TO postgres;

--
-- TOC entry 2307 (class 0 OID 0)
-- Dependencies: 186
-- Name: enterprise_clients_id_cli_ent_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE enterprise_clients_id_cli_ent_seq OWNED BY enterprise_clients.id_cli_ent;


--
-- TOC entry 188 (class 1259 OID 50437)
-- Name: external_enterprises; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE external_enterprises (
    rut_ent character varying(40) NOT NULL,
    giro_emp character varying(40),
    nom_emp character varying(40),
    dir_emp character varying(40),
    tel1_emp character varying(40),
    tel2_emp character varying(40),
    email_emp character varying(40),
    est_conv_emp character varying(40),
    ini_conv_emp date,
    fin_conv_emp date,
    descrip_conv_emp text
);


ALTER TABLE public.external_enterprises OWNER TO postgres;

--
-- TOC entry 190 (class 1259 OID 50448)
-- Name: fixed_rates; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE fixed_rates (
    id_fix_rat integer NOT NULL,
    ori_tar character varying(50),
    dest_tar character varying(50),
    costo_tar integer
);


ALTER TABLE public.fixed_rates OWNER TO postgres;

--
-- TOC entry 189 (class 1259 OID 50446)
-- Name: fixed_rates_id_fix_rat_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE fixed_rates_id_fix_rat_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fixed_rates_id_fix_rat_seq OWNER TO postgres;

--
-- TOC entry 2308 (class 0 OID 0)
-- Dependencies: 189
-- Name: fixed_rates_id_fix_rat_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE fixed_rates_id_fix_rat_seq OWNED BY fixed_rates.id_fix_rat;


--
-- TOC entry 192 (class 1259 OID 50457)
-- Name: kilometers_prices; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE kilometers_prices (
    id_km_pr integer NOT NULL,
    val_km integer,
    ini_val_km date,
    fin_val_km date,
    estado_val_km character varying(40)
);


ALTER TABLE public.kilometers_prices OWNER TO postgres;

--
-- TOC entry 191 (class 1259 OID 50455)
-- Name: kilometers_prices_id_km_pr_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE kilometers_prices_id_km_pr_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.kilometers_prices_id_km_pr_seq OWNER TO postgres;

--
-- TOC entry 2309 (class 0 OID 0)
-- Dependencies: 191
-- Name: kilometers_prices_id_km_pr_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE kilometers_prices_id_km_pr_seq OWNED BY kilometers_prices.id_km_pr;


--
-- TOC entry 194 (class 1259 OID 50466)
-- Name: log_sqls; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE log_sqls (
    id_log_sql integer NOT NULL,
    tms_log_sql date,
    tabla_log_sql character varying(50),
    operac_log_sql character varying(50),
    usuar_log_sql character varying(50),
    dat_antes_log_sql character varying(50),
    dat_desp_log_sql character varying(50),
    ope_det_log_sql character varying(100)
);


ALTER TABLE public.log_sqls OWNER TO postgres;

--
-- TOC entry 193 (class 1259 OID 50464)
-- Name: log_sqls_id_log_sql_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE log_sqls_id_log_sql_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.log_sqls_id_log_sql_seq OWNER TO postgres;

--
-- TOC entry 2310 (class 0 OID 0)
-- Dependencies: 193
-- Name: log_sqls_id_log_sql_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE log_sqls_id_log_sql_seq OWNED BY log_sqls.id_log_sql;


--
-- TOC entry 195 (class 1259 OID 50473)
-- Name: natural_clients; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE natural_clients (
    run_cli character varying(40) NOT NULL
);


ALTER TABLE public.natural_clients OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 50478)
-- Name: offer_vehicles; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE offer_vehicles (
    id_off_veh integer NOT NULL,
    id_block integer,
    run_driv character varying(40),
    est_oferta_veh character varying(40)
);


ALTER TABLE public.offer_vehicles OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 50476)
-- Name: offer_vehicles_id_off_veh_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE offer_vehicles_id_off_veh_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.offer_vehicles_id_off_veh_seq OWNER TO postgres;

--
-- TOC entry 2311 (class 0 OID 0)
-- Dependencies: 196
-- Name: offer_vehicles_id_off_veh_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE offer_vehicles_id_off_veh_seq OWNED BY offer_vehicles.id_off_veh;


--
-- TOC entry 200 (class 1259 OID 50495)
-- Name: owner_commissions; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE owner_commissions (
    id_own_com integer NOT NULL,
    porcent_comi_prop double precision,
    ini_comi_prop date,
    fin_comi_prop date
);


ALTER TABLE public.owner_commissions OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 50493)
-- Name: owner_commissions_id_own_com_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE owner_commissions_id_own_com_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.owner_commissions_id_own_com_seq OWNER TO postgres;

--
-- TOC entry 2312 (class 0 OID 0)
-- Dependencies: 199
-- Name: owner_commissions_id_own_com_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE owner_commissions_id_own_com_seq OWNED BY owner_commissions.id_own_com;


--
-- TOC entry 198 (class 1259 OID 50487)
-- Name: owners; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE owners (
    run_own character varying(40) NOT NULL,
    nom_prop character varying(40),
    apells_prop character varying(40),
    tel_prop character varying(40),
    email_prop character varying(40)
);


ALTER TABLE public.owners OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 50515)
-- Name: scheduling_blocks; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE scheduling_blocks (
    id_block integer NOT NULL,
    ini_bloq timestamp without time zone,
    fin_bloq timestamp without time zone
);


ALTER TABLE public.scheduling_blocks OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 50513)
-- Name: scheduling_blocks_id_block_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE scheduling_blocks_id_block_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.scheduling_blocks_id_block_seq OWNER TO postgres;

--
-- TOC entry 2313 (class 0 OID 0)
-- Dependencies: 203
-- Name: scheduling_blocks_id_block_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE scheduling_blocks_id_block_seq OWNED BY scheduling_blocks.id_block;


--
-- TOC entry 202 (class 1259 OID 50504)
-- Name: schedulings; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE schedulings (
    id_sched integer NOT NULL,
    id_off_veh integer,
    run_driv character varying(40),
    run_cli character varying(40)
);


ALTER TABLE public.schedulings OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 50502)
-- Name: schedulings_id_sched_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE schedulings_id_sched_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.schedulings_id_sched_seq OWNER TO postgres;

--
-- TOC entry 2314 (class 0 OID 0)
-- Dependencies: 201
-- Name: schedulings_id_sched_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE schedulings_id_sched_seq OWNED BY schedulings.id_sched;


--
-- TOC entry 219 (class 1259 OID 50699)
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: Andres; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO "Andres";

--
-- TOC entry 207 (class 1259 OID 50531)
-- Name: state_histories; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE state_histories (
    id_trav integer NOT NULL,
    id_stat integer NOT NULL
);


ALTER TABLE public.state_histories OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 50524)
-- Name: states; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE states (
    id_stat integer NOT NULL,
    nom_est character varying(40)
);


ALTER TABLE public.states OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 50522)
-- Name: states_id_stat_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE states_id_stat_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.states_id_stat_seq OWNER TO postgres;

--
-- TOC entry 2315 (class 0 OID 0)
-- Dependencies: 205
-- Name: states_id_stat_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE states_id_stat_seq OWNED BY states.id_stat;


--
-- TOC entry 209 (class 1259 OID 50538)
-- Name: technical_review_alerts; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE technical_review_alerts (
    id_tec_rev integer NOT NULL,
    plant_alert_rev_tec character varying(1024)
);


ALTER TABLE public.technical_review_alerts OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 50536)
-- Name: technical_review_alerts_id_tec_rev_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE technical_review_alerts_id_tec_rev_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.technical_review_alerts_id_tec_rev_seq OWNER TO postgres;

--
-- TOC entry 2316 (class 0 OID 0)
-- Dependencies: 208
-- Name: technical_review_alerts_id_tec_rev_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE technical_review_alerts_id_tec_rev_seq OWNED BY technical_review_alerts.id_tec_rev;


--
-- TOC entry 211 (class 1259 OID 50550)
-- Name: technical_review_expirations; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE technical_review_expirations (
    id_tec_rev_ex integer NOT NULL,
    mes_venc_rev_tec character varying(40),
    num_venc_rev_tec integer
);


ALTER TABLE public.technical_review_expirations OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 50548)
-- Name: technical_review_expirations_id_tec_rev_ex_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE technical_review_expirations_id_tec_rev_ex_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.technical_review_expirations_id_tec_rev_ex_seq OWNER TO postgres;

--
-- TOC entry 2317 (class 0 OID 0)
-- Dependencies: 210
-- Name: technical_review_expirations_id_tec_rev_ex_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE technical_review_expirations_id_tec_rev_ex_seq OWNED BY technical_review_expirations.id_tec_rev_ex;


--
-- TOC entry 212 (class 1259 OID 50557)
-- Name: transitions; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE transitions (
    id_stat integer NOT NULL,
    sta_id_stat integer NOT NULL
);


ALTER TABLE public.transitions OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 50575)
-- Name: travel_requests; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE travel_requests (
    id_trav_req integer NOT NULL,
    run_cli character varying(40),
    dir_orig_sol character varying(60),
    dir_dest_sol character varying(60),
    com_orig_sol character varying(60),
    com_dest_sol character varying(60),
    cant_pasaj_sol integer,
    fecha_crea_sol date,
    fecha_serv_sol timestamp without time zone,
    est_sol character varying(20)
);


ALTER TABLE public.travel_requests OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 50573)
-- Name: travel_requests_id_trav_req_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE travel_requests_id_trav_req_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.travel_requests_id_trav_req_seq OWNER TO postgres;

--
-- TOC entry 2318 (class 0 OID 0)
-- Dependencies: 215
-- Name: travel_requests_id_trav_req_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE travel_requests_id_trav_req_seq OWNED BY travel_requests.id_trav_req;


--
-- TOC entry 214 (class 1259 OID 50564)
-- Name: travels; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE travels (
    id_trav integer NOT NULL,
    run_driv character varying(40),
    id_trav_req integer NOT NULL,
    hora_ini_via date,
    tiemp_est_via time without time zone,
    dist_est_via double precision,
    val_via integer
);


ALTER TABLE public.travels OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 50562)
-- Name: travels_id_trav_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE travels_id_trav_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.travels_id_trav_seq OWNER TO postgres;

--
-- TOC entry 2319 (class 0 OID 0)
-- Dependencies: 213
-- Name: travels_id_trav_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE travels_id_trav_seq OWNED BY travels.id_trav;


--
-- TOC entry 221 (class 1259 OID 50705)
-- Name: users; Type: TABLE; Schema: public; Owner: Andres; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    tipo character varying(255) DEFAULT 'cli_nat'::character varying,
    rut character varying(255),
    nombre character varying(255),
    apellidos character varying(255),
    telefono1 character varying(255),
    telefono2 character varying(255),
    venc_lic_cond date,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.users OWNER TO "Andres";

--
-- TOC entry 220 (class 1259 OID 50703)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: Andres
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO "Andres";

--
-- TOC entry 2320 (class 0 OID 0)
-- Dependencies: 220
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Andres
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- TOC entry 218 (class 1259 OID 50585)
-- Name: vehicles; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE vehicles (
    id_veh integer NOT NULL,
    run_own character varying(40) NOT NULL,
    pat_veh character varying(10),
    mar_veh character varying(20),
    model_veh character varying(20),
    tipo_veh character varying(20),
    km_sem_veh integer
);


ALTER TABLE public.vehicles OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 50583)
-- Name: vehicles_id_veh_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE vehicles_id_veh_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vehicles_id_veh_seq OWNER TO postgres;

--
-- TOC entry 2321 (class 0 OID 0)
-- Dependencies: 217
-- Name: vehicles_id_veh_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE vehicles_id_veh_seq OWNED BY vehicles.id_veh;


--
-- TOC entry 1987 (class 2604 OID 50350)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY assigneds ALTER COLUMN id SET DEFAULT nextval('assigneds_id_seq'::regclass);


--
-- TOC entry 1988 (class 2604 OID 50361)
-- Name: id_base_pr; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY base_prices ALTER COLUMN id_base_pr SET DEFAULT nextval('base_prices_id_base_pr_seq'::regclass);


--
-- TOC entry 1990 (class 2604 OID 50380)
-- Name: id_bill_det; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY bill_details ALTER COLUMN id_bill_det SET DEFAULT nextval('bill_details_id_bill_det_seq'::regclass);


--
-- TOC entry 1989 (class 2604 OID 50370)
-- Name: id_bil; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY bills ALTER COLUMN id_bil SET DEFAULT nextval('bills_id_bil_seq'::regclass);


--
-- TOC entry 1991 (class 2604 OID 50397)
-- Name: id_comun; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comunnes ALTER COLUMN id_comun SET DEFAULT nextval('comunnes_id_comun_seq'::regclass);


--
-- TOC entry 1992 (class 2604 OID 50406)
-- Name: id_conc; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY concepts ALTER COLUMN id_conc SET DEFAULT nextval('concepts_id_conc_seq'::regclass);


--
-- TOC entry 1993 (class 2604 OID 50421)
-- Name: id_mens_alert_licenc; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY drivers_license_alerts ALTER COLUMN id_mens_alert_licenc SET DEFAULT nextval('drivers_license_alerts_id_mens_alert_licenc_seq'::regclass);


--
-- TOC entry 1994 (class 2604 OID 50433)
-- Name: id_cli_ent; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY enterprise_clients ALTER COLUMN id_cli_ent SET DEFAULT nextval('enterprise_clients_id_cli_ent_seq'::regclass);


--
-- TOC entry 1995 (class 2604 OID 50451)
-- Name: id_fix_rat; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY fixed_rates ALTER COLUMN id_fix_rat SET DEFAULT nextval('fixed_rates_id_fix_rat_seq'::regclass);


--
-- TOC entry 1996 (class 2604 OID 50460)
-- Name: id_km_pr; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY kilometers_prices ALTER COLUMN id_km_pr SET DEFAULT nextval('kilometers_prices_id_km_pr_seq'::regclass);


--
-- TOC entry 1997 (class 2604 OID 50469)
-- Name: id_log_sql; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY log_sqls ALTER COLUMN id_log_sql SET DEFAULT nextval('log_sqls_id_log_sql_seq'::regclass);


--
-- TOC entry 1998 (class 2604 OID 50481)
-- Name: id_off_veh; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY offer_vehicles ALTER COLUMN id_off_veh SET DEFAULT nextval('offer_vehicles_id_off_veh_seq'::regclass);


--
-- TOC entry 1999 (class 2604 OID 50498)
-- Name: id_own_com; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY owner_commissions ALTER COLUMN id_own_com SET DEFAULT nextval('owner_commissions_id_own_com_seq'::regclass);


--
-- TOC entry 2001 (class 2604 OID 50518)
-- Name: id_block; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY scheduling_blocks ALTER COLUMN id_block SET DEFAULT nextval('scheduling_blocks_id_block_seq'::regclass);


--
-- TOC entry 2000 (class 2604 OID 50507)
-- Name: id_sched; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY schedulings ALTER COLUMN id_sched SET DEFAULT nextval('schedulings_id_sched_seq'::regclass);


--
-- TOC entry 2002 (class 2604 OID 50527)
-- Name: id_stat; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY states ALTER COLUMN id_stat SET DEFAULT nextval('states_id_stat_seq'::regclass);


--
-- TOC entry 2003 (class 2604 OID 50541)
-- Name: id_tec_rev; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY technical_review_alerts ALTER COLUMN id_tec_rev SET DEFAULT nextval('technical_review_alerts_id_tec_rev_seq'::regclass);


--
-- TOC entry 2004 (class 2604 OID 50553)
-- Name: id_tec_rev_ex; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY technical_review_expirations ALTER COLUMN id_tec_rev_ex SET DEFAULT nextval('technical_review_expirations_id_tec_rev_ex_seq'::regclass);


--
-- TOC entry 2006 (class 2604 OID 50578)
-- Name: id_trav_req; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY travel_requests ALTER COLUMN id_trav_req SET DEFAULT nextval('travel_requests_id_trav_req_seq'::regclass);


--
-- TOC entry 2005 (class 2604 OID 50567)
-- Name: id_trav; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY travels ALTER COLUMN id_trav SET DEFAULT nextval('travels_id_trav_seq'::regclass);


--
-- TOC entry 2008 (class 2604 OID 50708)
-- Name: id; Type: DEFAULT; Schema: public; Owner: Andres
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- TOC entry 2007 (class 2604 OID 50588)
-- Name: id_veh; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY vehicles ALTER COLUMN id_veh SET DEFAULT nextval('vehicles_id_veh_seq'::regclass);


--
-- TOC entry 2241 (class 0 OID 50347)
-- Dependencies: 171
-- Data for Name: assigneds; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY assigneds (id, id_veh, run_driv, ini_assigned, fin_assigned) FROM stdin;
\.


--
-- TOC entry 2322 (class 0 OID 0)
-- Dependencies: 170
-- Name: assigneds_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('assigneds_id_seq', 1, false);


--
-- TOC entry 2243 (class 0 OID 50358)
-- Dependencies: 173
-- Data for Name: base_prices; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY base_prices (id_base_pr, val_base, ini_val_base, fin_val_base, estado_val_base) FROM stdin;
1	1400	2014-02-01	2016-02-01	activo
2	1400	2016-02-02	2017-02-01	inactivo
\.


--
-- TOC entry 2323 (class 0 OID 0)
-- Dependencies: 172
-- Name: base_prices_id_base_pr_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('base_prices_id_base_pr_seq', 1, false);


--
-- TOC entry 2247 (class 0 OID 50377)
-- Dependencies: 177
-- Data for Name: bill_details; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY bill_details (id_bill_det, id_bil, id_conc, monto_det_fact) FROM stdin;
\.


--
-- TOC entry 2324 (class 0 OID 0)
-- Dependencies: 176
-- Name: bill_details_id_bill_det_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('bill_details_id_bill_det_seq', 1, false);


--
-- TOC entry 2245 (class 0 OID 50367)
-- Dependencies: 175
-- Data for Name: bills; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY bills (id_bil, rut_ent, fecha_fact, total_fact) FROM stdin;
\.


--
-- TOC entry 2325 (class 0 OID 0)
-- Dependencies: 174
-- Name: bills_id_bil_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('bills_id_bil_seq', 1, false);


--
-- TOC entry 2248 (class 0 OID 50386)
-- Dependencies: 178
-- Data for Name: clients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY clients (run_cli, nom_cli, apells_cli, tel1_cli, tel2_cli, email_cli) FROM stdin;
17579248-1	Andrés	Cifuentes	0224567809	1234673	administrador@activecab.cl
5610320-1	Claudio	Cortés	0227345679	77747523	cliente@activecab.cl
20124182-0	Miguel	Cifuentes	25467655	72223344	conductor@activecab.cl
15714729-3	Nicolás	Fuentes	0227995679	74533322	administrador2@activecab.cl
21186873-2	Camilo	Torres	234765422	72533322	conductor2@activecab.cl
21028729-9	Franco	Fredes	87653344	23450999	operador@activecab.cl
11123301-2	Ricardo	Rojas	23476544	0224563212	operador2@activecab.cl
18561819-6	Romina	Silva	61216985		romisq@live.cl
\.


--
-- TOC entry 2250 (class 0 OID 50394)
-- Dependencies: 180
-- Data for Name: comunnes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY comunnes (id_comun, nom_comun, num_comun) FROM stdin;
\.


--
-- TOC entry 2326 (class 0 OID 0)
-- Dependencies: 179
-- Name: comunnes_id_comun_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('comunnes_id_comun_seq', 1, false);


--
-- TOC entry 2252 (class 0 OID 50403)
-- Dependencies: 182
-- Data for Name: concepts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY concepts (id_conc, nom_conc) FROM stdin;
\.


--
-- TOC entry 2327 (class 0 OID 0)
-- Dependencies: 181
-- Name: concepts_id_conc_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('concepts_id_conc_seq', 1, false);


--
-- TOC entry 2253 (class 0 OID 50410)
-- Dependencies: 183
-- Data for Name: drivers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY drivers (run_driv, nom_cond, apells_cond, tel1_cond, tel2_cond, email_cond, venc_licenc_cond) FROM stdin;
20124182-0	Miguel	Cifuentes	25467655	72223344	conductor@activecab.cl	\N
21186873-2	Camilo	Torres	234765422	72533322	conductor2@activecab.cl	\N
\.


--
-- TOC entry 2255 (class 0 OID 50418)
-- Dependencies: 185
-- Data for Name: drivers_license_alerts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY drivers_license_alerts (id_mens_alert_licenc, plant_alert_licenc) FROM stdin;
\.


--
-- TOC entry 2328 (class 0 OID 0)
-- Dependencies: 184
-- Name: drivers_license_alerts_id_mens_alert_licenc_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('drivers_license_alerts_id_mens_alert_licenc_seq', 1, false);


--
-- TOC entry 2257 (class 0 OID 50430)
-- Dependencies: 187
-- Data for Name: enterprise_clients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY enterprise_clients (id_cli_ent, run_cli, rut_ent) FROM stdin;
\.


--
-- TOC entry 2329 (class 0 OID 0)
-- Dependencies: 186
-- Name: enterprise_clients_id_cli_ent_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('enterprise_clients_id_cli_ent_seq', 1, false);


--
-- TOC entry 2258 (class 0 OID 50437)
-- Dependencies: 188
-- Data for Name: external_enterprises; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY external_enterprises (rut_ent, giro_emp, nom_emp, dir_emp, tel1_emp, tel2_emp, email_emp, est_conv_emp, ini_conv_emp, fin_conv_emp, descrip_conv_emp) FROM stdin;
\.


--
-- TOC entry 2260 (class 0 OID 50448)
-- Dependencies: 190
-- Data for Name: fixed_rates; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY fixed_rates (id_fix_rat, ori_tar, dest_tar, costo_tar) FROM stdin;
\.


--
-- TOC entry 2330 (class 0 OID 0)
-- Dependencies: 189
-- Name: fixed_rates_id_fix_rat_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('fixed_rates_id_fix_rat_seq', 1, false);


--
-- TOC entry 2262 (class 0 OID 50457)
-- Dependencies: 192
-- Data for Name: kilometers_prices; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY kilometers_prices (id_km_pr, val_km, ini_val_km, fin_val_km, estado_val_km) FROM stdin;
1	700	2014-02-01	2015-02-01	activo
2	800	2015-02-02	2016-02-01	inactivo
\.


--
-- TOC entry 2331 (class 0 OID 0)
-- Dependencies: 191
-- Name: kilometers_prices_id_km_pr_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('kilometers_prices_id_km_pr_seq', 1, false);


--
-- TOC entry 2264 (class 0 OID 50466)
-- Dependencies: 194
-- Data for Name: log_sqls; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY log_sqls (id_log_sql, tms_log_sql, tabla_log_sql, operac_log_sql, usuar_log_sql, dat_antes_log_sql, dat_desp_log_sql, ope_det_log_sql) FROM stdin;
\.


--
-- TOC entry 2332 (class 0 OID 0)
-- Dependencies: 193
-- Name: log_sqls_id_log_sql_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('log_sqls_id_log_sql_seq', 1, false);


--
-- TOC entry 2265 (class 0 OID 50473)
-- Dependencies: 195
-- Data for Name: natural_clients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY natural_clients (run_cli) FROM stdin;
17579248-1
5610320-1
20124182-0
15714729-3
21186873-2
21028729-9
11123301-2
18561819-6
\.


--
-- TOC entry 2267 (class 0 OID 50478)
-- Dependencies: 197
-- Data for Name: offer_vehicles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY offer_vehicles (id_off_veh, id_block, run_driv, est_oferta_veh) FROM stdin;
1	1	21186873-2	disponible
\.


--
-- TOC entry 2333 (class 0 OID 0)
-- Dependencies: 196
-- Name: offer_vehicles_id_off_veh_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('offer_vehicles_id_off_veh_seq', 1, true);


--
-- TOC entry 2270 (class 0 OID 50495)
-- Dependencies: 200
-- Data for Name: owner_commissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY owner_commissions (id_own_com, porcent_comi_prop, ini_comi_prop, fin_comi_prop) FROM stdin;
\.


--
-- TOC entry 2334 (class 0 OID 0)
-- Dependencies: 199
-- Name: owner_commissions_id_own_com_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('owner_commissions_id_own_com_seq', 1, false);


--
-- TOC entry 2268 (class 0 OID 50487)
-- Dependencies: 198
-- Data for Name: owners; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY owners (run_own, nom_prop, apells_prop, tel_prop, email_prop) FROM stdin;
11152081-k	Camilo	Paredes	26458778	conductor1@activecab.cl
23031109-9	Juan	Zuñiga	2349081	conductor2@activecab.cl
23555570-0	Pedro	Jara	23121122	conductor3@activecab.cl
\.


--
-- TOC entry 2274 (class 0 OID 50515)
-- Dependencies: 204
-- Data for Name: scheduling_blocks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY scheduling_blocks (id_block, ini_bloq, fin_bloq) FROM stdin;
1	2014-06-01 00:00:00	2014-06-01 00:09:00
2	2014-06-01 00:10:00	2014-06-01 00:19:00
3	2014-06-01 00:20:00	2014-06-01 00:29:00
4	2014-06-01 00:30:00	2014-06-01 00:39:00
5	2014-06-01 00:40:00	2014-06-01 00:49:00
6	2014-06-01 00:50:00	2014-06-01 00:59:00
7	2014-06-01 01:00:00	2014-06-01 01:09:00
8	2014-06-01 01:10:00	2014-06-01 01:19:00
9	2014-06-01 01:20:00	2014-06-01 01:29:00
10	2014-06-01 01:30:00	2014-06-01 01:39:00
11	2014-06-01 01:40:00	2014-06-01 01:49:00
12	2014-06-01 01:50:00	2014-06-01 01:59:00
13	2014-06-01 02:00:00	2014-06-01 02:09:00
14	2014-06-01 02:10:00	2014-06-01 02:19:00
15	2014-06-01 02:20:00	2014-06-01 02:29:00
16	2014-06-01 02:30:00	2014-06-01 02:39:00
17	2014-06-01 02:40:00	2014-06-01 02:49:00
18	2014-06-01 02:50:00	2014-06-01 02:59:00
19	2014-06-01 03:00:00	2014-06-01 03:09:00
20	2014-06-01 03:10:00	2014-06-01 03:19:00
21	2014-06-01 03:20:00	2014-06-01 03:29:00
22	2014-06-01 03:30:00	2014-06-01 03:39:00
23	2014-06-01 03:40:00	2014-06-01 03:49:00
24	2014-06-01 03:50:00	2014-06-01 03:59:00
25	2014-06-01 04:00:00	2014-06-01 04:09:00
26	2014-06-01 04:10:00	2014-06-01 04:19:00
27	2014-06-01 04:20:00	2014-06-01 04:29:00
28	2014-06-01 04:30:00	2014-06-01 04:39:00
29	2014-06-01 04:40:00	2014-06-01 04:49:00
30	2014-06-01 04:50:00	2014-06-01 04:59:00
31	2014-06-01 05:00:00	2014-06-01 05:09:00
32	2014-06-01 05:10:00	2014-06-01 05:19:00
33	2014-06-01 05:20:00	2014-06-01 05:29:00
34	2014-06-01 05:30:00	2014-06-01 05:39:00
35	2014-06-01 05:40:00	2014-06-01 05:49:00
36	2014-06-01 05:50:00	2014-06-01 05:59:00
37	2014-06-01 06:00:00	2014-06-01 06:09:00
38	2014-06-01 06:10:00	2014-06-01 06:19:00
39	2014-06-01 06:20:00	2014-06-01 06:29:00
40	2014-06-01 06:30:00	2014-06-01 06:39:00
41	2014-06-01 06:40:00	2014-06-01 06:49:00
42	2014-06-01 06:50:00	2014-06-01 06:59:00
43	2014-06-01 07:00:00	2014-06-01 07:09:00
44	2014-06-01 07:10:00	2014-06-01 07:19:00
45	2014-06-01 07:20:00	2014-06-01 07:29:00
46	2014-06-01 07:30:00	2014-06-01 07:39:00
47	2014-06-01 07:40:00	2014-06-01 07:49:00
48	2014-06-01 07:50:00	2014-06-01 07:59:00
49	2014-06-01 08:00:00	2014-06-01 08:09:00
50	2014-06-01 08:10:00	2014-06-01 08:19:00
51	2014-06-01 08:20:00	2014-06-01 08:29:00
52	2014-06-01 08:30:00	2014-06-01 08:39:00
53	2014-06-01 08:40:00	2014-06-01 08:49:00
54	2014-06-01 08:50:00	2014-06-01 08:59:00
55	2014-06-01 09:00:00	2014-06-01 09:09:00
56	2014-06-01 09:10:00	2014-06-01 09:19:00
57	2014-06-01 09:20:00	2014-06-01 09:29:00
58	2014-06-01 09:30:00	2014-06-01 09:39:00
59	2014-06-01 09:40:00	2014-06-01 09:49:00
60	2014-06-01 09:50:00	2014-06-01 09:59:00
61	2014-06-01 10:00:00	2014-06-01 10:09:00
62	2014-06-01 10:10:00	2014-06-01 10:19:00
63	2014-06-01 10:20:00	2014-06-01 10:29:00
64	2014-06-01 10:30:00	2014-06-01 10:39:00
65	2014-06-01 10:40:00	2014-06-01 10:49:00
66	2014-06-01 10:50:00	2014-06-01 10:59:00
67	2014-06-01 11:00:00	2014-06-01 11:09:00
68	2014-06-01 11:10:00	2014-06-01 11:19:00
69	2014-06-01 11:20:00	2014-06-01 11:29:00
70	2014-06-01 11:30:00	2014-06-01 11:39:00
71	2014-06-01 11:40:00	2014-06-01 11:49:00
72	2014-06-01 11:50:00	2014-06-01 11:59:00
73	2014-06-01 12:00:00	2014-06-01 12:09:00
74	2014-06-01 12:10:00	2014-06-01 12:19:00
75	2014-06-01 12:20:00	2014-06-01 12:29:00
76	2014-06-01 12:30:00	2014-06-01 12:39:00
77	2014-06-01 12:40:00	2014-06-01 12:49:00
78	2014-06-01 12:50:00	2014-06-01 12:59:00
79	2014-06-01 13:00:00	2014-06-01 13:09:00
80	2014-06-01 13:10:00	2014-06-01 13:19:00
81	2014-06-01 13:20:00	2014-06-01 13:29:00
82	2014-06-01 13:30:00	2014-06-01 13:39:00
83	2014-06-01 13:40:00	2014-06-01 13:49:00
84	2014-06-01 13:50:00	2014-06-01 13:59:00
85	2014-06-01 14:00:00	2014-06-01 14:09:00
86	2014-06-01 14:10:00	2014-06-01 14:19:00
87	2014-06-01 14:20:00	2014-06-01 14:29:00
88	2014-06-01 14:30:00	2014-06-01 14:39:00
89	2014-06-01 14:40:00	2014-06-01 14:49:00
90	2014-06-01 14:50:00	2014-06-01 14:59:00
91	2014-06-01 15:00:00	2014-06-01 15:09:00
92	2014-06-01 15:10:00	2014-06-01 15:19:00
93	2014-06-01 15:20:00	2014-06-01 15:29:00
94	2014-06-01 15:30:00	2014-06-01 15:39:00
95	2014-06-01 15:40:00	2014-06-01 15:49:00
96	2014-06-01 15:50:00	2014-06-01 15:59:00
97	2014-06-01 16:00:00	2014-06-01 16:09:00
98	2014-06-01 16:10:00	2014-06-01 16:19:00
99	2014-06-01 16:20:00	2014-06-01 16:29:00
100	2014-06-01 16:30:00	2014-06-01 16:39:00
101	2014-06-01 16:40:00	2014-06-01 16:49:00
102	2014-06-01 16:50:00	2014-06-01 16:59:00
103	2014-06-01 17:00:00	2014-06-01 17:09:00
104	2014-06-01 17:10:00	2014-06-01 17:19:00
105	2014-06-01 17:20:00	2014-06-01 17:29:00
106	2014-06-01 17:30:00	2014-06-01 17:39:00
107	2014-06-01 17:40:00	2014-06-01 17:49:00
108	2014-06-01 17:50:00	2014-06-01 17:59:00
109	2014-06-01 18:00:00	2014-06-01 18:09:00
110	2014-06-01 18:10:00	2014-06-01 18:19:00
111	2014-06-01 18:20:00	2014-06-01 18:29:00
112	2014-06-01 18:30:00	2014-06-01 18:39:00
113	2014-06-01 18:40:00	2014-06-01 18:49:00
114	2014-06-01 18:50:00	2014-06-01 18:59:00
115	2014-06-01 19:00:00	2014-06-01 19:09:00
116	2014-06-01 19:10:00	2014-06-01 19:19:00
117	2014-06-01 19:20:00	2014-06-01 19:29:00
118	2014-06-01 19:30:00	2014-06-01 19:39:00
119	2014-06-01 19:40:00	2014-06-01 19:49:00
120	2014-06-01 19:50:00	2014-06-01 19:59:00
121	2014-06-01 20:00:00	2014-06-01 20:09:00
122	2014-06-01 20:10:00	2014-06-01 20:19:00
123	2014-06-01 20:20:00	2014-06-01 20:29:00
124	2014-06-01 20:30:00	2014-06-01 20:39:00
125	2014-06-01 20:40:00	2014-06-01 20:49:00
126	2014-06-01 20:50:00	2014-06-01 20:59:00
127	2014-06-01 21:00:00	2014-06-01 21:09:00
128	2014-06-01 21:10:00	2014-06-01 21:19:00
129	2014-06-01 21:20:00	2014-06-01 21:29:00
130	2014-06-01 21:30:00	2014-06-01 21:39:00
131	2014-06-01 21:40:00	2014-06-01 21:49:00
132	2014-06-01 21:50:00	2014-06-01 21:59:00
133	2014-06-01 22:00:00	2014-06-01 22:09:00
134	2014-06-01 22:10:00	2014-06-01 22:19:00
135	2014-06-01 22:20:00	2014-06-01 22:29:00
136	2014-06-01 22:30:00	2014-06-01 22:39:00
137	2014-06-01 22:40:00	2014-06-01 22:49:00
138	2014-06-01 22:50:00	2014-06-01 22:59:00
139	2014-06-01 23:00:00	2014-06-01 23:09:00
140	2014-06-01 23:10:00	2014-06-01 23:19:00
141	2014-06-01 23:20:00	2014-06-01 23:29:00
142	2014-06-01 23:30:00	2014-06-01 23:39:00
143	2014-06-01 23:40:00	2014-06-01 23:49:00
144	2014-06-01 23:50:00	2014-06-01 23:59:00
145	2014-06-02 00:00:00	2014-06-02 00:09:00
146	2014-06-02 00:10:00	2014-06-02 00:19:00
147	2014-06-02 00:20:00	2014-06-02 00:29:00
148	2014-06-02 00:30:00	2014-06-02 00:39:00
149	2014-06-02 00:40:00	2014-06-02 00:49:00
150	2014-06-02 00:50:00	2014-06-02 00:59:00
151	2014-06-02 01:00:00	2014-06-02 01:09:00
152	2014-06-02 01:10:00	2014-06-02 01:19:00
153	2014-06-02 01:20:00	2014-06-02 01:29:00
154	2014-06-02 01:30:00	2014-06-02 01:39:00
155	2014-06-02 01:40:00	2014-06-02 01:49:00
156	2014-06-02 01:50:00	2014-06-02 01:59:00
157	2014-06-02 02:00:00	2014-06-02 02:09:00
158	2014-06-02 02:10:00	2014-06-02 02:19:00
159	2014-06-02 02:20:00	2014-06-02 02:29:00
160	2014-06-02 02:30:00	2014-06-02 02:39:00
161	2014-06-02 02:40:00	2014-06-02 02:49:00
162	2014-06-02 02:50:00	2014-06-02 02:59:00
163	2014-06-02 03:00:00	2014-06-02 03:09:00
164	2014-06-02 03:10:00	2014-06-02 03:19:00
165	2014-06-02 03:20:00	2014-06-02 03:29:00
166	2014-06-02 03:30:00	2014-06-02 03:39:00
167	2014-06-02 03:40:00	2014-06-02 03:49:00
168	2014-06-02 03:50:00	2014-06-02 03:59:00
169	2014-06-02 04:00:00	2014-06-02 04:09:00
170	2014-06-02 04:10:00	2014-06-02 04:19:00
171	2014-06-02 04:20:00	2014-06-02 04:29:00
172	2014-06-02 04:30:00	2014-06-02 04:39:00
173	2014-06-02 04:40:00	2014-06-02 04:49:00
174	2014-06-02 04:50:00	2014-06-02 04:59:00
175	2014-06-02 05:00:00	2014-06-02 05:09:00
176	2014-06-02 05:10:00	2014-06-02 05:19:00
177	2014-06-02 05:20:00	2014-06-02 05:29:00
178	2014-06-02 05:30:00	2014-06-02 05:39:00
179	2014-06-02 05:40:00	2014-06-02 05:49:00
180	2014-06-02 05:50:00	2014-06-02 05:59:00
181	2014-06-02 06:00:00	2014-06-02 06:09:00
182	2014-06-02 06:10:00	2014-06-02 06:19:00
183	2014-06-02 06:20:00	2014-06-02 06:29:00
184	2014-06-02 06:30:00	2014-06-02 06:39:00
185	2014-06-02 06:40:00	2014-06-02 06:49:00
186	2014-06-02 06:50:00	2014-06-02 06:59:00
187	2014-06-02 07:00:00	2014-06-02 07:09:00
188	2014-06-02 07:10:00	2014-06-02 07:19:00
189	2014-06-02 07:20:00	2014-06-02 07:29:00
190	2014-06-02 07:30:00	2014-06-02 07:39:00
191	2014-06-02 07:40:00	2014-06-02 07:49:00
192	2014-06-02 07:50:00	2014-06-02 07:59:00
193	2014-06-02 08:00:00	2014-06-02 08:09:00
194	2014-06-02 08:10:00	2014-06-02 08:19:00
195	2014-06-02 08:20:00	2014-06-02 08:29:00
196	2014-06-02 08:30:00	2014-06-02 08:39:00
197	2014-06-02 08:40:00	2014-06-02 08:49:00
198	2014-06-02 08:50:00	2014-06-02 08:59:00
199	2014-06-02 09:00:00	2014-06-02 09:09:00
200	2014-06-02 09:10:00	2014-06-02 09:19:00
201	2014-06-02 09:20:00	2014-06-02 09:29:00
202	2014-06-02 09:30:00	2014-06-02 09:39:00
203	2014-06-02 09:40:00	2014-06-02 09:49:00
204	2014-06-02 09:50:00	2014-06-02 09:59:00
205	2014-06-02 10:00:00	2014-06-02 10:09:00
206	2014-06-02 10:10:00	2014-06-02 10:19:00
207	2014-06-02 10:20:00	2014-06-02 10:29:00
208	2014-06-02 10:30:00	2014-06-02 10:39:00
209	2014-06-02 10:40:00	2014-06-02 10:49:00
210	2014-06-02 10:50:00	2014-06-02 10:59:00
211	2014-06-02 11:00:00	2014-06-02 11:09:00
212	2014-06-02 11:10:00	2014-06-02 11:19:00
213	2014-06-02 11:20:00	2014-06-02 11:29:00
214	2014-06-02 11:30:00	2014-06-02 11:39:00
215	2014-06-02 11:40:00	2014-06-02 11:49:00
216	2014-06-02 11:50:00	2014-06-02 11:59:00
217	2014-06-02 12:00:00	2014-06-02 12:09:00
218	2014-06-02 12:10:00	2014-06-02 12:19:00
219	2014-06-02 12:20:00	2014-06-02 12:29:00
220	2014-06-02 12:30:00	2014-06-02 12:39:00
221	2014-06-02 12:40:00	2014-06-02 12:49:00
222	2014-06-02 12:50:00	2014-06-02 12:59:00
223	2014-06-02 13:00:00	2014-06-02 13:09:00
224	2014-06-02 13:10:00	2014-06-02 13:19:00
225	2014-06-02 13:20:00	2014-06-02 13:29:00
226	2014-06-02 13:30:00	2014-06-02 13:39:00
227	2014-06-02 13:40:00	2014-06-02 13:49:00
228	2014-06-02 13:50:00	2014-06-02 13:59:00
229	2014-06-02 14:00:00	2014-06-02 14:09:00
230	2014-06-02 14:10:00	2014-06-02 14:19:00
231	2014-06-02 14:20:00	2014-06-02 14:29:00
232	2014-06-02 14:30:00	2014-06-02 14:39:00
233	2014-06-02 14:40:00	2014-06-02 14:49:00
234	2014-06-02 14:50:00	2014-06-02 14:59:00
235	2014-06-02 15:00:00	2014-06-02 15:09:00
236	2014-06-02 15:10:00	2014-06-02 15:19:00
237	2014-06-02 15:20:00	2014-06-02 15:29:00
238	2014-06-02 15:30:00	2014-06-02 15:39:00
239	2014-06-02 15:40:00	2014-06-02 15:49:00
240	2014-06-02 15:50:00	2014-06-02 15:59:00
241	2014-06-02 16:00:00	2014-06-02 16:09:00
242	2014-06-02 16:10:00	2014-06-02 16:19:00
243	2014-06-02 16:20:00	2014-06-02 16:29:00
244	2014-06-02 16:30:00	2014-06-02 16:39:00
245	2014-06-02 16:40:00	2014-06-02 16:49:00
246	2014-06-02 16:50:00	2014-06-02 16:59:00
247	2014-06-02 17:00:00	2014-06-02 17:09:00
248	2014-06-02 17:10:00	2014-06-02 17:19:00
249	2014-06-02 17:20:00	2014-06-02 17:29:00
250	2014-06-02 17:30:00	2014-06-02 17:39:00
251	2014-06-02 17:40:00	2014-06-02 17:49:00
252	2014-06-02 17:50:00	2014-06-02 17:59:00
253	2014-06-02 18:00:00	2014-06-02 18:09:00
254	2014-06-02 18:10:00	2014-06-02 18:19:00
255	2014-06-02 18:20:00	2014-06-02 18:29:00
256	2014-06-02 18:30:00	2014-06-02 18:39:00
257	2014-06-02 18:40:00	2014-06-02 18:49:00
258	2014-06-02 18:50:00	2014-06-02 18:59:00
259	2014-06-02 19:00:00	2014-06-02 19:09:00
260	2014-06-02 19:10:00	2014-06-02 19:19:00
261	2014-06-02 19:20:00	2014-06-02 19:29:00
262	2014-06-02 19:30:00	2014-06-02 19:39:00
263	2014-06-02 19:40:00	2014-06-02 19:49:00
264	2014-06-02 19:50:00	2014-06-02 19:59:00
265	2014-06-02 20:00:00	2014-06-02 20:09:00
266	2014-06-02 20:10:00	2014-06-02 20:19:00
267	2014-06-02 20:20:00	2014-06-02 20:29:00
268	2014-06-02 20:30:00	2014-06-02 20:39:00
269	2014-06-02 20:40:00	2014-06-02 20:49:00
270	2014-06-02 20:50:00	2014-06-02 20:59:00
271	2014-06-02 21:00:00	2014-06-02 21:09:00
272	2014-06-02 21:10:00	2014-06-02 21:19:00
273	2014-06-02 21:20:00	2014-06-02 21:29:00
274	2014-06-02 21:30:00	2014-06-02 21:39:00
275	2014-06-02 21:40:00	2014-06-02 21:49:00
276	2014-06-02 21:50:00	2014-06-02 21:59:00
277	2014-06-02 22:00:00	2014-06-02 22:09:00
278	2014-06-02 22:10:00	2014-06-02 22:19:00
279	2014-06-02 22:20:00	2014-06-02 22:29:00
280	2014-06-02 22:30:00	2014-06-02 22:39:00
281	2014-06-02 22:40:00	2014-06-02 22:49:00
282	2014-06-02 22:50:00	2014-06-02 22:59:00
283	2014-06-02 23:00:00	2014-06-02 23:09:00
284	2014-06-02 23:10:00	2014-06-02 23:19:00
285	2014-06-02 23:20:00	2014-06-02 23:29:00
286	2014-06-02 23:30:00	2014-06-02 23:39:00
287	2014-06-02 23:40:00	2014-06-02 23:49:00
288	2014-06-02 23:50:00	2014-06-02 23:59:00
289	2014-06-03 00:00:00	2014-06-03 00:09:00
290	2014-06-03 00:10:00	2014-06-03 00:19:00
291	2014-06-03 00:20:00	2014-06-03 00:29:00
292	2014-06-03 00:30:00	2014-06-03 00:39:00
293	2014-06-03 00:40:00	2014-06-03 00:49:00
294	2014-06-03 00:50:00	2014-06-03 00:59:00
295	2014-06-03 01:00:00	2014-06-03 01:09:00
296	2014-06-03 01:10:00	2014-06-03 01:19:00
297	2014-06-03 01:20:00	2014-06-03 01:29:00
298	2014-06-03 01:30:00	2014-06-03 01:39:00
299	2014-06-03 01:40:00	2014-06-03 01:49:00
300	2014-06-03 01:50:00	2014-06-03 01:59:00
301	2014-06-03 02:00:00	2014-06-03 02:09:00
302	2014-06-03 02:10:00	2014-06-03 02:19:00
303	2014-06-03 02:20:00	2014-06-03 02:29:00
304	2014-06-03 02:30:00	2014-06-03 02:39:00
305	2014-06-03 02:40:00	2014-06-03 02:49:00
306	2014-06-03 02:50:00	2014-06-03 02:59:00
307	2014-06-03 03:00:00	2014-06-03 03:09:00
308	2014-06-03 03:10:00	2014-06-03 03:19:00
309	2014-06-03 03:20:00	2014-06-03 03:29:00
310	2014-06-03 03:30:00	2014-06-03 03:39:00
311	2014-06-03 03:40:00	2014-06-03 03:49:00
312	2014-06-03 03:50:00	2014-06-03 03:59:00
313	2014-06-03 04:00:00	2014-06-03 04:09:00
314	2014-06-03 04:10:00	2014-06-03 04:19:00
315	2014-06-03 04:20:00	2014-06-03 04:29:00
316	2014-06-03 04:30:00	2014-06-03 04:39:00
317	2014-06-03 04:40:00	2014-06-03 04:49:00
318	2014-06-03 04:50:00	2014-06-03 04:59:00
319	2014-06-03 05:00:00	2014-06-03 05:09:00
320	2014-06-03 05:10:00	2014-06-03 05:19:00
321	2014-06-03 05:20:00	2014-06-03 05:29:00
322	2014-06-03 05:30:00	2014-06-03 05:39:00
323	2014-06-03 05:40:00	2014-06-03 05:49:00
324	2014-06-03 05:50:00	2014-06-03 05:59:00
325	2014-06-03 06:00:00	2014-06-03 06:09:00
326	2014-06-03 06:10:00	2014-06-03 06:19:00
327	2014-06-03 06:20:00	2014-06-03 06:29:00
328	2014-06-03 06:30:00	2014-06-03 06:39:00
329	2014-06-03 06:40:00	2014-06-03 06:49:00
330	2014-06-03 06:50:00	2014-06-03 06:59:00
331	2014-06-03 07:00:00	2014-06-03 07:09:00
332	2014-06-03 07:10:00	2014-06-03 07:19:00
333	2014-06-03 07:20:00	2014-06-03 07:29:00
334	2014-06-03 07:30:00	2014-06-03 07:39:00
335	2014-06-03 07:40:00	2014-06-03 07:49:00
336	2014-06-03 07:50:00	2014-06-03 07:59:00
337	2014-06-03 08:00:00	2014-06-03 08:09:00
338	2014-06-03 08:10:00	2014-06-03 08:19:00
339	2014-06-03 08:20:00	2014-06-03 08:29:00
340	2014-06-03 08:30:00	2014-06-03 08:39:00
341	2014-06-03 08:40:00	2014-06-03 08:49:00
342	2014-06-03 08:50:00	2014-06-03 08:59:00
343	2014-06-03 09:00:00	2014-06-03 09:09:00
344	2014-06-03 09:10:00	2014-06-03 09:19:00
345	2014-06-03 09:20:00	2014-06-03 09:29:00
346	2014-06-03 09:30:00	2014-06-03 09:39:00
347	2014-06-03 09:40:00	2014-06-03 09:49:00
348	2014-06-03 09:50:00	2014-06-03 09:59:00
349	2014-06-03 10:00:00	2014-06-03 10:09:00
350	2014-06-03 10:10:00	2014-06-03 10:19:00
351	2014-06-03 10:20:00	2014-06-03 10:29:00
352	2014-06-03 10:30:00	2014-06-03 10:39:00
353	2014-06-03 10:40:00	2014-06-03 10:49:00
354	2014-06-03 10:50:00	2014-06-03 10:59:00
355	2014-06-03 11:00:00	2014-06-03 11:09:00
356	2014-06-03 11:10:00	2014-06-03 11:19:00
357	2014-06-03 11:20:00	2014-06-03 11:29:00
358	2014-06-03 11:30:00	2014-06-03 11:39:00
359	2014-06-03 11:40:00	2014-06-03 11:49:00
360	2014-06-03 11:50:00	2014-06-03 11:59:00
361	2014-06-03 12:00:00	2014-06-03 12:09:00
362	2014-06-03 12:10:00	2014-06-03 12:19:00
363	2014-06-03 12:20:00	2014-06-03 12:29:00
364	2014-06-03 12:30:00	2014-06-03 12:39:00
365	2014-06-03 12:40:00	2014-06-03 12:49:00
366	2014-06-03 12:50:00	2014-06-03 12:59:00
367	2014-06-03 13:00:00	2014-06-03 13:09:00
368	2014-06-03 13:10:00	2014-06-03 13:19:00
369	2014-06-03 13:20:00	2014-06-03 13:29:00
370	2014-06-03 13:30:00	2014-06-03 13:39:00
371	2014-06-03 13:40:00	2014-06-03 13:49:00
372	2014-06-03 13:50:00	2014-06-03 13:59:00
373	2014-06-03 14:00:00	2014-06-03 14:09:00
374	2014-06-03 14:10:00	2014-06-03 14:19:00
375	2014-06-03 14:20:00	2014-06-03 14:29:00
376	2014-06-03 14:30:00	2014-06-03 14:39:00
377	2014-06-03 14:40:00	2014-06-03 14:49:00
378	2014-06-03 14:50:00	2014-06-03 14:59:00
379	2014-06-03 15:00:00	2014-06-03 15:09:00
380	2014-06-03 15:10:00	2014-06-03 15:19:00
381	2014-06-03 15:20:00	2014-06-03 15:29:00
382	2014-06-03 15:30:00	2014-06-03 15:39:00
383	2014-06-03 15:40:00	2014-06-03 15:49:00
384	2014-06-03 15:50:00	2014-06-03 15:59:00
385	2014-06-03 16:00:00	2014-06-03 16:09:00
386	2014-06-03 16:10:00	2014-06-03 16:19:00
387	2014-06-03 16:20:00	2014-06-03 16:29:00
388	2014-06-03 16:30:00	2014-06-03 16:39:00
389	2014-06-03 16:40:00	2014-06-03 16:49:00
390	2014-06-03 16:50:00	2014-06-03 16:59:00
391	2014-06-03 17:00:00	2014-06-03 17:09:00
392	2014-06-03 17:10:00	2014-06-03 17:19:00
393	2014-06-03 17:20:00	2014-06-03 17:29:00
394	2014-06-03 17:30:00	2014-06-03 17:39:00
395	2014-06-03 17:40:00	2014-06-03 17:49:00
396	2014-06-03 17:50:00	2014-06-03 17:59:00
397	2014-06-03 18:00:00	2014-06-03 18:09:00
398	2014-06-03 18:10:00	2014-06-03 18:19:00
399	2014-06-03 18:20:00	2014-06-03 18:29:00
400	2014-06-03 18:30:00	2014-06-03 18:39:00
401	2014-06-03 18:40:00	2014-06-03 18:49:00
402	2014-06-03 18:50:00	2014-06-03 18:59:00
403	2014-06-03 19:00:00	2014-06-03 19:09:00
404	2014-06-03 19:10:00	2014-06-03 19:19:00
405	2014-06-03 19:20:00	2014-06-03 19:29:00
406	2014-06-03 19:30:00	2014-06-03 19:39:00
407	2014-06-03 19:40:00	2014-06-03 19:49:00
408	2014-06-03 19:50:00	2014-06-03 19:59:00
409	2014-06-03 20:00:00	2014-06-03 20:09:00
410	2014-06-03 20:10:00	2014-06-03 20:19:00
411	2014-06-03 20:20:00	2014-06-03 20:29:00
412	2014-06-03 20:30:00	2014-06-03 20:39:00
413	2014-06-03 20:40:00	2014-06-03 20:49:00
414	2014-06-03 20:50:00	2014-06-03 20:59:00
415	2014-06-03 21:00:00	2014-06-03 21:09:00
416	2014-06-03 21:10:00	2014-06-03 21:19:00
417	2014-06-03 21:20:00	2014-06-03 21:29:00
418	2014-06-03 21:30:00	2014-06-03 21:39:00
419	2014-06-03 21:40:00	2014-06-03 21:49:00
420	2014-06-03 21:50:00	2014-06-03 21:59:00
421	2014-06-03 22:00:00	2014-06-03 22:09:00
422	2014-06-03 22:10:00	2014-06-03 22:19:00
423	2014-06-03 22:20:00	2014-06-03 22:29:00
424	2014-06-03 22:30:00	2014-06-03 22:39:00
425	2014-06-03 22:40:00	2014-06-03 22:49:00
426	2014-06-03 22:50:00	2014-06-03 22:59:00
427	2014-06-03 23:00:00	2014-06-03 23:09:00
428	2014-06-03 23:10:00	2014-06-03 23:19:00
429	2014-06-03 23:20:00	2014-06-03 23:29:00
430	2014-06-03 23:30:00	2014-06-03 23:39:00
431	2014-06-03 23:40:00	2014-06-03 23:49:00
432	2014-06-03 23:50:00	2014-06-03 23:59:00
433	2014-06-04 00:00:00	2014-06-04 00:09:00
434	2014-06-04 00:10:00	2014-06-04 00:19:00
435	2014-06-04 00:20:00	2014-06-04 00:29:00
436	2014-06-04 00:30:00	2014-06-04 00:39:00
437	2014-06-04 00:40:00	2014-06-04 00:49:00
438	2014-06-04 00:50:00	2014-06-04 00:59:00
439	2014-06-04 01:00:00	2014-06-04 01:09:00
440	2014-06-04 01:10:00	2014-06-04 01:19:00
441	2014-06-04 01:20:00	2014-06-04 01:29:00
442	2014-06-04 01:30:00	2014-06-04 01:39:00
443	2014-06-04 01:40:00	2014-06-04 01:49:00
444	2014-06-04 01:50:00	2014-06-04 01:59:00
445	2014-06-04 02:00:00	2014-06-04 02:09:00
446	2014-06-04 02:10:00	2014-06-04 02:19:00
447	2014-06-04 02:20:00	2014-06-04 02:29:00
448	2014-06-04 02:30:00	2014-06-04 02:39:00
449	2014-06-04 02:40:00	2014-06-04 02:49:00
450	2014-06-04 02:50:00	2014-06-04 02:59:00
451	2014-06-04 03:00:00	2014-06-04 03:09:00
452	2014-06-04 03:10:00	2014-06-04 03:19:00
453	2014-06-04 03:20:00	2014-06-04 03:29:00
454	2014-06-04 03:30:00	2014-06-04 03:39:00
455	2014-06-04 03:40:00	2014-06-04 03:49:00
456	2014-06-04 03:50:00	2014-06-04 03:59:00
457	2014-06-04 04:00:00	2014-06-04 04:09:00
458	2014-06-04 04:10:00	2014-06-04 04:19:00
459	2014-06-04 04:20:00	2014-06-04 04:29:00
460	2014-06-04 04:30:00	2014-06-04 04:39:00
461	2014-06-04 04:40:00	2014-06-04 04:49:00
462	2014-06-04 04:50:00	2014-06-04 04:59:00
463	2014-06-04 05:00:00	2014-06-04 05:09:00
464	2014-06-04 05:10:00	2014-06-04 05:19:00
465	2014-06-04 05:20:00	2014-06-04 05:29:00
466	2014-06-04 05:30:00	2014-06-04 05:39:00
467	2014-06-04 05:40:00	2014-06-04 05:49:00
468	2014-06-04 05:50:00	2014-06-04 05:59:00
469	2014-06-04 06:00:00	2014-06-04 06:09:00
470	2014-06-04 06:10:00	2014-06-04 06:19:00
471	2014-06-04 06:20:00	2014-06-04 06:29:00
472	2014-06-04 06:30:00	2014-06-04 06:39:00
473	2014-06-04 06:40:00	2014-06-04 06:49:00
474	2014-06-04 06:50:00	2014-06-04 06:59:00
475	2014-06-04 07:00:00	2014-06-04 07:09:00
476	2014-06-04 07:10:00	2014-06-04 07:19:00
477	2014-06-04 07:20:00	2014-06-04 07:29:00
478	2014-06-04 07:30:00	2014-06-04 07:39:00
479	2014-06-04 07:40:00	2014-06-04 07:49:00
480	2014-06-04 07:50:00	2014-06-04 07:59:00
481	2014-06-04 08:00:00	2014-06-04 08:09:00
482	2014-06-04 08:10:00	2014-06-04 08:19:00
483	2014-06-04 08:20:00	2014-06-04 08:29:00
484	2014-06-04 08:30:00	2014-06-04 08:39:00
485	2014-06-04 08:40:00	2014-06-04 08:49:00
486	2014-06-04 08:50:00	2014-06-04 08:59:00
487	2014-06-04 09:00:00	2014-06-04 09:09:00
488	2014-06-04 09:10:00	2014-06-04 09:19:00
489	2014-06-04 09:20:00	2014-06-04 09:29:00
490	2014-06-04 09:30:00	2014-06-04 09:39:00
491	2014-06-04 09:40:00	2014-06-04 09:49:00
492	2014-06-04 09:50:00	2014-06-04 09:59:00
493	2014-06-04 10:00:00	2014-06-04 10:09:00
494	2014-06-04 10:10:00	2014-06-04 10:19:00
495	2014-06-04 10:20:00	2014-06-04 10:29:00
496	2014-06-04 10:30:00	2014-06-04 10:39:00
497	2014-06-04 10:40:00	2014-06-04 10:49:00
498	2014-06-04 10:50:00	2014-06-04 10:59:00
499	2014-06-04 11:00:00	2014-06-04 11:09:00
500	2014-06-04 11:10:00	2014-06-04 11:19:00
501	2014-06-04 11:20:00	2014-06-04 11:29:00
502	2014-06-04 11:30:00	2014-06-04 11:39:00
503	2014-06-04 11:40:00	2014-06-04 11:49:00
504	2014-06-04 11:50:00	2014-06-04 11:59:00
505	2014-06-04 12:00:00	2014-06-04 12:09:00
506	2014-06-04 12:10:00	2014-06-04 12:19:00
507	2014-06-04 12:20:00	2014-06-04 12:29:00
508	2014-06-04 12:30:00	2014-06-04 12:39:00
509	2014-06-04 12:40:00	2014-06-04 12:49:00
510	2014-06-04 12:50:00	2014-06-04 12:59:00
511	2014-06-04 13:00:00	2014-06-04 13:09:00
512	2014-06-04 13:10:00	2014-06-04 13:19:00
513	2014-06-04 13:20:00	2014-06-04 13:29:00
514	2014-06-04 13:30:00	2014-06-04 13:39:00
515	2014-06-04 13:40:00	2014-06-04 13:49:00
516	2014-06-04 13:50:00	2014-06-04 13:59:00
517	2014-06-04 14:00:00	2014-06-04 14:09:00
518	2014-06-04 14:10:00	2014-06-04 14:19:00
519	2014-06-04 14:20:00	2014-06-04 14:29:00
520	2014-06-04 14:30:00	2014-06-04 14:39:00
521	2014-06-04 14:40:00	2014-06-04 14:49:00
522	2014-06-04 14:50:00	2014-06-04 14:59:00
523	2014-06-04 15:00:00	2014-06-04 15:09:00
524	2014-06-04 15:10:00	2014-06-04 15:19:00
525	2014-06-04 15:20:00	2014-06-04 15:29:00
526	2014-06-04 15:30:00	2014-06-04 15:39:00
527	2014-06-04 15:40:00	2014-06-04 15:49:00
528	2014-06-04 15:50:00	2014-06-04 15:59:00
529	2014-06-04 16:00:00	2014-06-04 16:09:00
530	2014-06-04 16:10:00	2014-06-04 16:19:00
531	2014-06-04 16:20:00	2014-06-04 16:29:00
532	2014-06-04 16:30:00	2014-06-04 16:39:00
533	2014-06-04 16:40:00	2014-06-04 16:49:00
534	2014-06-04 16:50:00	2014-06-04 16:59:00
535	2014-06-04 17:00:00	2014-06-04 17:09:00
536	2014-06-04 17:10:00	2014-06-04 17:19:00
537	2014-06-04 17:20:00	2014-06-04 17:29:00
538	2014-06-04 17:30:00	2014-06-04 17:39:00
539	2014-06-04 17:40:00	2014-06-04 17:49:00
540	2014-06-04 17:50:00	2014-06-04 17:59:00
541	2014-06-04 18:00:00	2014-06-04 18:09:00
542	2014-06-04 18:10:00	2014-06-04 18:19:00
543	2014-06-04 18:20:00	2014-06-04 18:29:00
544	2014-06-04 18:30:00	2014-06-04 18:39:00
545	2014-06-04 18:40:00	2014-06-04 18:49:00
546	2014-06-04 18:50:00	2014-06-04 18:59:00
547	2014-06-04 19:00:00	2014-06-04 19:09:00
548	2014-06-04 19:10:00	2014-06-04 19:19:00
549	2014-06-04 19:20:00	2014-06-04 19:29:00
550	2014-06-04 19:30:00	2014-06-04 19:39:00
551	2014-06-04 19:40:00	2014-06-04 19:49:00
552	2014-06-04 19:50:00	2014-06-04 19:59:00
553	2014-06-04 20:00:00	2014-06-04 20:09:00
554	2014-06-04 20:10:00	2014-06-04 20:19:00
555	2014-06-04 20:20:00	2014-06-04 20:29:00
556	2014-06-04 20:30:00	2014-06-04 20:39:00
557	2014-06-04 20:40:00	2014-06-04 20:49:00
558	2014-06-04 20:50:00	2014-06-04 20:59:00
559	2014-06-04 21:00:00	2014-06-04 21:09:00
560	2014-06-04 21:10:00	2014-06-04 21:19:00
561	2014-06-04 21:20:00	2014-06-04 21:29:00
562	2014-06-04 21:30:00	2014-06-04 21:39:00
563	2014-06-04 21:40:00	2014-06-04 21:49:00
564	2014-06-04 21:50:00	2014-06-04 21:59:00
565	2014-06-04 22:00:00	2014-06-04 22:09:00
566	2014-06-04 22:10:00	2014-06-04 22:19:00
567	2014-06-04 22:20:00	2014-06-04 22:29:00
568	2014-06-04 22:30:00	2014-06-04 22:39:00
569	2014-06-04 22:40:00	2014-06-04 22:49:00
570	2014-06-04 22:50:00	2014-06-04 22:59:00
571	2014-06-04 23:00:00	2014-06-04 23:09:00
572	2014-06-04 23:10:00	2014-06-04 23:19:00
573	2014-06-04 23:20:00	2014-06-04 23:29:00
574	2014-06-04 23:30:00	2014-06-04 23:39:00
575	2014-06-04 23:40:00	2014-06-04 23:49:00
576	2014-06-04 23:50:00	2014-06-04 23:59:00
577	2014-06-05 00:00:00	2014-06-05 00:09:00
578	2014-06-05 00:10:00	2014-06-05 00:19:00
579	2014-06-05 00:20:00	2014-06-05 00:29:00
580	2014-06-05 00:30:00	2014-06-05 00:39:00
581	2014-06-05 00:40:00	2014-06-05 00:49:00
582	2014-06-05 00:50:00	2014-06-05 00:59:00
583	2014-06-05 01:00:00	2014-06-05 01:09:00
584	2014-06-05 01:10:00	2014-06-05 01:19:00
585	2014-06-05 01:20:00	2014-06-05 01:29:00
586	2014-06-05 01:30:00	2014-06-05 01:39:00
587	2014-06-05 01:40:00	2014-06-05 01:49:00
588	2014-06-05 01:50:00	2014-06-05 01:59:00
589	2014-06-05 02:00:00	2014-06-05 02:09:00
590	2014-06-05 02:10:00	2014-06-05 02:19:00
591	2014-06-05 02:20:00	2014-06-05 02:29:00
592	2014-06-05 02:30:00	2014-06-05 02:39:00
593	2014-06-05 02:40:00	2014-06-05 02:49:00
594	2014-06-05 02:50:00	2014-06-05 02:59:00
595	2014-06-05 03:00:00	2014-06-05 03:09:00
596	2014-06-05 03:10:00	2014-06-05 03:19:00
597	2014-06-05 03:20:00	2014-06-05 03:29:00
598	2014-06-05 03:30:00	2014-06-05 03:39:00
599	2014-06-05 03:40:00	2014-06-05 03:49:00
600	2014-06-05 03:50:00	2014-06-05 03:59:00
601	2014-06-05 04:00:00	2014-06-05 04:09:00
602	2014-06-05 04:10:00	2014-06-05 04:19:00
603	2014-06-05 04:20:00	2014-06-05 04:29:00
604	2014-06-05 04:30:00	2014-06-05 04:39:00
605	2014-06-05 04:40:00	2014-06-05 04:49:00
606	2014-06-05 04:50:00	2014-06-05 04:59:00
607	2014-06-05 05:00:00	2014-06-05 05:09:00
608	2014-06-05 05:10:00	2014-06-05 05:19:00
609	2014-06-05 05:20:00	2014-06-05 05:29:00
610	2014-06-05 05:30:00	2014-06-05 05:39:00
611	2014-06-05 05:40:00	2014-06-05 05:49:00
612	2014-06-05 05:50:00	2014-06-05 05:59:00
613	2014-06-05 06:00:00	2014-06-05 06:09:00
614	2014-06-05 06:10:00	2014-06-05 06:19:00
615	2014-06-05 06:20:00	2014-06-05 06:29:00
616	2014-06-05 06:30:00	2014-06-05 06:39:00
617	2014-06-05 06:40:00	2014-06-05 06:49:00
618	2014-06-05 06:50:00	2014-06-05 06:59:00
619	2014-06-05 07:00:00	2014-06-05 07:09:00
620	2014-06-05 07:10:00	2014-06-05 07:19:00
621	2014-06-05 07:20:00	2014-06-05 07:29:00
622	2014-06-05 07:30:00	2014-06-05 07:39:00
623	2014-06-05 07:40:00	2014-06-05 07:49:00
624	2014-06-05 07:50:00	2014-06-05 07:59:00
625	2014-06-05 08:00:00	2014-06-05 08:09:00
626	2014-06-05 08:10:00	2014-06-05 08:19:00
627	2014-06-05 08:20:00	2014-06-05 08:29:00
628	2014-06-05 08:30:00	2014-06-05 08:39:00
629	2014-06-05 08:40:00	2014-06-05 08:49:00
630	2014-06-05 08:50:00	2014-06-05 08:59:00
631	2014-06-05 09:00:00	2014-06-05 09:09:00
632	2014-06-05 09:10:00	2014-06-05 09:19:00
633	2014-06-05 09:20:00	2014-06-05 09:29:00
634	2014-06-05 09:30:00	2014-06-05 09:39:00
635	2014-06-05 09:40:00	2014-06-05 09:49:00
636	2014-06-05 09:50:00	2014-06-05 09:59:00
637	2014-06-05 10:00:00	2014-06-05 10:09:00
638	2014-06-05 10:10:00	2014-06-05 10:19:00
639	2014-06-05 10:20:00	2014-06-05 10:29:00
640	2014-06-05 10:30:00	2014-06-05 10:39:00
641	2014-06-05 10:40:00	2014-06-05 10:49:00
642	2014-06-05 10:50:00	2014-06-05 10:59:00
643	2014-06-05 11:00:00	2014-06-05 11:09:00
644	2014-06-05 11:10:00	2014-06-05 11:19:00
645	2014-06-05 11:20:00	2014-06-05 11:29:00
646	2014-06-05 11:30:00	2014-06-05 11:39:00
647	2014-06-05 11:40:00	2014-06-05 11:49:00
648	2014-06-05 11:50:00	2014-06-05 11:59:00
649	2014-06-05 12:00:00	2014-06-05 12:09:00
650	2014-06-05 12:10:00	2014-06-05 12:19:00
651	2014-06-05 12:20:00	2014-06-05 12:29:00
652	2014-06-05 12:30:00	2014-06-05 12:39:00
653	2014-06-05 12:40:00	2014-06-05 12:49:00
654	2014-06-05 12:50:00	2014-06-05 12:59:00
655	2014-06-05 13:00:00	2014-06-05 13:09:00
656	2014-06-05 13:10:00	2014-06-05 13:19:00
657	2014-06-05 13:20:00	2014-06-05 13:29:00
658	2014-06-05 13:30:00	2014-06-05 13:39:00
659	2014-06-05 13:40:00	2014-06-05 13:49:00
660	2014-06-05 13:50:00	2014-06-05 13:59:00
661	2014-06-05 14:00:00	2014-06-05 14:09:00
662	2014-06-05 14:10:00	2014-06-05 14:19:00
663	2014-06-05 14:20:00	2014-06-05 14:29:00
664	2014-06-05 14:30:00	2014-06-05 14:39:00
665	2014-06-05 14:40:00	2014-06-05 14:49:00
666	2014-06-05 14:50:00	2014-06-05 14:59:00
667	2014-06-05 15:00:00	2014-06-05 15:09:00
668	2014-06-05 15:10:00	2014-06-05 15:19:00
669	2014-06-05 15:20:00	2014-06-05 15:29:00
670	2014-06-05 15:30:00	2014-06-05 15:39:00
671	2014-06-05 15:40:00	2014-06-05 15:49:00
672	2014-06-05 15:50:00	2014-06-05 15:59:00
673	2014-06-05 16:00:00	2014-06-05 16:09:00
674	2014-06-05 16:10:00	2014-06-05 16:19:00
675	2014-06-05 16:20:00	2014-06-05 16:29:00
676	2014-06-05 16:30:00	2014-06-05 16:39:00
677	2014-06-05 16:40:00	2014-06-05 16:49:00
678	2014-06-05 16:50:00	2014-06-05 16:59:00
679	2014-06-05 17:00:00	2014-06-05 17:09:00
680	2014-06-05 17:10:00	2014-06-05 17:19:00
681	2014-06-05 17:20:00	2014-06-05 17:29:00
682	2014-06-05 17:30:00	2014-06-05 17:39:00
683	2014-06-05 17:40:00	2014-06-05 17:49:00
684	2014-06-05 17:50:00	2014-06-05 17:59:00
685	2014-06-05 18:00:00	2014-06-05 18:09:00
686	2014-06-05 18:10:00	2014-06-05 18:19:00
687	2014-06-05 18:20:00	2014-06-05 18:29:00
688	2014-06-05 18:30:00	2014-06-05 18:39:00
689	2014-06-05 18:40:00	2014-06-05 18:49:00
690	2014-06-05 18:50:00	2014-06-05 18:59:00
691	2014-06-05 19:00:00	2014-06-05 19:09:00
692	2014-06-05 19:10:00	2014-06-05 19:19:00
693	2014-06-05 19:20:00	2014-06-05 19:29:00
694	2014-06-05 19:30:00	2014-06-05 19:39:00
695	2014-06-05 19:40:00	2014-06-05 19:49:00
696	2014-06-05 19:50:00	2014-06-05 19:59:00
697	2014-06-05 20:00:00	2014-06-05 20:09:00
698	2014-06-05 20:10:00	2014-06-05 20:19:00
699	2014-06-05 20:20:00	2014-06-05 20:29:00
700	2014-06-05 20:30:00	2014-06-05 20:39:00
701	2014-06-05 20:40:00	2014-06-05 20:49:00
702	2014-06-05 20:50:00	2014-06-05 20:59:00
703	2014-06-05 21:00:00	2014-06-05 21:09:00
704	2014-06-05 21:10:00	2014-06-05 21:19:00
705	2014-06-05 21:20:00	2014-06-05 21:29:00
706	2014-06-05 21:30:00	2014-06-05 21:39:00
707	2014-06-05 21:40:00	2014-06-05 21:49:00
708	2014-06-05 21:50:00	2014-06-05 21:59:00
709	2014-06-05 22:00:00	2014-06-05 22:09:00
710	2014-06-05 22:10:00	2014-06-05 22:19:00
711	2014-06-05 22:20:00	2014-06-05 22:29:00
712	2014-06-05 22:30:00	2014-06-05 22:39:00
713	2014-06-05 22:40:00	2014-06-05 22:49:00
714	2014-06-05 22:50:00	2014-06-05 22:59:00
715	2014-06-05 23:00:00	2014-06-05 23:09:00
716	2014-06-05 23:10:00	2014-06-05 23:19:00
717	2014-06-05 23:20:00	2014-06-05 23:29:00
718	2014-06-05 23:30:00	2014-06-05 23:39:00
719	2014-06-05 23:40:00	2014-06-05 23:49:00
720	2014-06-05 23:50:00	2014-06-05 23:59:00
721	2014-06-06 00:00:00	2014-06-06 00:09:00
722	2014-06-06 00:10:00	2014-06-06 00:19:00
723	2014-06-06 00:20:00	2014-06-06 00:29:00
724	2014-06-06 00:30:00	2014-06-06 00:39:00
725	2014-06-06 00:40:00	2014-06-06 00:49:00
726	2014-06-06 00:50:00	2014-06-06 00:59:00
727	2014-06-06 01:00:00	2014-06-06 01:09:00
728	2014-06-06 01:10:00	2014-06-06 01:19:00
729	2014-06-06 01:20:00	2014-06-06 01:29:00
730	2014-06-06 01:30:00	2014-06-06 01:39:00
731	2014-06-06 01:40:00	2014-06-06 01:49:00
732	2014-06-06 01:50:00	2014-06-06 01:59:00
733	2014-06-06 02:00:00	2014-06-06 02:09:00
734	2014-06-06 02:10:00	2014-06-06 02:19:00
735	2014-06-06 02:20:00	2014-06-06 02:29:00
736	2014-06-06 02:30:00	2014-06-06 02:39:00
737	2014-06-06 02:40:00	2014-06-06 02:49:00
738	2014-06-06 02:50:00	2014-06-06 02:59:00
739	2014-06-06 03:00:00	2014-06-06 03:09:00
740	2014-06-06 03:10:00	2014-06-06 03:19:00
741	2014-06-06 03:20:00	2014-06-06 03:29:00
742	2014-06-06 03:30:00	2014-06-06 03:39:00
743	2014-06-06 03:40:00	2014-06-06 03:49:00
744	2014-06-06 03:50:00	2014-06-06 03:59:00
745	2014-06-06 04:00:00	2014-06-06 04:09:00
746	2014-06-06 04:10:00	2014-06-06 04:19:00
747	2014-06-06 04:20:00	2014-06-06 04:29:00
748	2014-06-06 04:30:00	2014-06-06 04:39:00
749	2014-06-06 04:40:00	2014-06-06 04:49:00
750	2014-06-06 04:50:00	2014-06-06 04:59:00
751	2014-06-06 05:00:00	2014-06-06 05:09:00
752	2014-06-06 05:10:00	2014-06-06 05:19:00
753	2014-06-06 05:20:00	2014-06-06 05:29:00
754	2014-06-06 05:30:00	2014-06-06 05:39:00
755	2014-06-06 05:40:00	2014-06-06 05:49:00
756	2014-06-06 05:50:00	2014-06-06 05:59:00
757	2014-06-06 06:00:00	2014-06-06 06:09:00
758	2014-06-06 06:10:00	2014-06-06 06:19:00
759	2014-06-06 06:20:00	2014-06-06 06:29:00
760	2014-06-06 06:30:00	2014-06-06 06:39:00
761	2014-06-06 06:40:00	2014-06-06 06:49:00
762	2014-06-06 06:50:00	2014-06-06 06:59:00
763	2014-06-06 07:00:00	2014-06-06 07:09:00
764	2014-06-06 07:10:00	2014-06-06 07:19:00
765	2014-06-06 07:20:00	2014-06-06 07:29:00
766	2014-06-06 07:30:00	2014-06-06 07:39:00
767	2014-06-06 07:40:00	2014-06-06 07:49:00
768	2014-06-06 07:50:00	2014-06-06 07:59:00
769	2014-06-06 08:00:00	2014-06-06 08:09:00
770	2014-06-06 08:10:00	2014-06-06 08:19:00
771	2014-06-06 08:20:00	2014-06-06 08:29:00
772	2014-06-06 08:30:00	2014-06-06 08:39:00
773	2014-06-06 08:40:00	2014-06-06 08:49:00
774	2014-06-06 08:50:00	2014-06-06 08:59:00
775	2014-06-06 09:00:00	2014-06-06 09:09:00
776	2014-06-06 09:10:00	2014-06-06 09:19:00
777	2014-06-06 09:20:00	2014-06-06 09:29:00
778	2014-06-06 09:30:00	2014-06-06 09:39:00
779	2014-06-06 09:40:00	2014-06-06 09:49:00
780	2014-06-06 09:50:00	2014-06-06 09:59:00
781	2014-06-06 10:00:00	2014-06-06 10:09:00
782	2014-06-06 10:10:00	2014-06-06 10:19:00
783	2014-06-06 10:20:00	2014-06-06 10:29:00
784	2014-06-06 10:30:00	2014-06-06 10:39:00
785	2014-06-06 10:40:00	2014-06-06 10:49:00
786	2014-06-06 10:50:00	2014-06-06 10:59:00
787	2014-06-06 11:00:00	2014-06-06 11:09:00
788	2014-06-06 11:10:00	2014-06-06 11:19:00
789	2014-06-06 11:20:00	2014-06-06 11:29:00
790	2014-06-06 11:30:00	2014-06-06 11:39:00
791	2014-06-06 11:40:00	2014-06-06 11:49:00
792	2014-06-06 11:50:00	2014-06-06 11:59:00
793	2014-06-06 12:00:00	2014-06-06 12:09:00
794	2014-06-06 12:10:00	2014-06-06 12:19:00
795	2014-06-06 12:20:00	2014-06-06 12:29:00
796	2014-06-06 12:30:00	2014-06-06 12:39:00
797	2014-06-06 12:40:00	2014-06-06 12:49:00
798	2014-06-06 12:50:00	2014-06-06 12:59:00
799	2014-06-06 13:00:00	2014-06-06 13:09:00
800	2014-06-06 13:10:00	2014-06-06 13:19:00
801	2014-06-06 13:20:00	2014-06-06 13:29:00
802	2014-06-06 13:30:00	2014-06-06 13:39:00
803	2014-06-06 13:40:00	2014-06-06 13:49:00
804	2014-06-06 13:50:00	2014-06-06 13:59:00
805	2014-06-06 14:00:00	2014-06-06 14:09:00
806	2014-06-06 14:10:00	2014-06-06 14:19:00
807	2014-06-06 14:20:00	2014-06-06 14:29:00
808	2014-06-06 14:30:00	2014-06-06 14:39:00
809	2014-06-06 14:40:00	2014-06-06 14:49:00
810	2014-06-06 14:50:00	2014-06-06 14:59:00
811	2014-06-06 15:00:00	2014-06-06 15:09:00
812	2014-06-06 15:10:00	2014-06-06 15:19:00
813	2014-06-06 15:20:00	2014-06-06 15:29:00
814	2014-06-06 15:30:00	2014-06-06 15:39:00
815	2014-06-06 15:40:00	2014-06-06 15:49:00
816	2014-06-06 15:50:00	2014-06-06 15:59:00
817	2014-06-06 16:00:00	2014-06-06 16:09:00
818	2014-06-06 16:10:00	2014-06-06 16:19:00
819	2014-06-06 16:20:00	2014-06-06 16:29:00
820	2014-06-06 16:30:00	2014-06-06 16:39:00
821	2014-06-06 16:40:00	2014-06-06 16:49:00
822	2014-06-06 16:50:00	2014-06-06 16:59:00
823	2014-06-06 17:00:00	2014-06-06 17:09:00
824	2014-06-06 17:10:00	2014-06-06 17:19:00
825	2014-06-06 17:20:00	2014-06-06 17:29:00
826	2014-06-06 17:30:00	2014-06-06 17:39:00
827	2014-06-06 17:40:00	2014-06-06 17:49:00
828	2014-06-06 17:50:00	2014-06-06 17:59:00
829	2014-06-06 18:00:00	2014-06-06 18:09:00
830	2014-06-06 18:10:00	2014-06-06 18:19:00
831	2014-06-06 18:20:00	2014-06-06 18:29:00
832	2014-06-06 18:30:00	2014-06-06 18:39:00
833	2014-06-06 18:40:00	2014-06-06 18:49:00
834	2014-06-06 18:50:00	2014-06-06 18:59:00
835	2014-06-06 19:00:00	2014-06-06 19:09:00
836	2014-06-06 19:10:00	2014-06-06 19:19:00
837	2014-06-06 19:20:00	2014-06-06 19:29:00
838	2014-06-06 19:30:00	2014-06-06 19:39:00
839	2014-06-06 19:40:00	2014-06-06 19:49:00
840	2014-06-06 19:50:00	2014-06-06 19:59:00
841	2014-06-06 20:00:00	2014-06-06 20:09:00
842	2014-06-06 20:10:00	2014-06-06 20:19:00
843	2014-06-06 20:20:00	2014-06-06 20:29:00
844	2014-06-06 20:30:00	2014-06-06 20:39:00
845	2014-06-06 20:40:00	2014-06-06 20:49:00
846	2014-06-06 20:50:00	2014-06-06 20:59:00
847	2014-06-06 21:00:00	2014-06-06 21:09:00
848	2014-06-06 21:10:00	2014-06-06 21:19:00
849	2014-06-06 21:20:00	2014-06-06 21:29:00
850	2014-06-06 21:30:00	2014-06-06 21:39:00
851	2014-06-06 21:40:00	2014-06-06 21:49:00
852	2014-06-06 21:50:00	2014-06-06 21:59:00
853	2014-06-06 22:00:00	2014-06-06 22:09:00
854	2014-06-06 22:10:00	2014-06-06 22:19:00
855	2014-06-06 22:20:00	2014-06-06 22:29:00
856	2014-06-06 22:30:00	2014-06-06 22:39:00
857	2014-06-06 22:40:00	2014-06-06 22:49:00
858	2014-06-06 22:50:00	2014-06-06 22:59:00
859	2014-06-06 23:00:00	2014-06-06 23:09:00
860	2014-06-06 23:10:00	2014-06-06 23:19:00
861	2014-06-06 23:20:00	2014-06-06 23:29:00
862	2014-06-06 23:30:00	2014-06-06 23:39:00
863	2014-06-06 23:40:00	2014-06-06 23:49:00
864	2014-06-06 23:50:00	2014-06-06 23:59:00
865	2014-06-07 00:00:00	2014-06-07 00:09:00
866	2014-06-07 00:10:00	2014-06-07 00:19:00
867	2014-06-07 00:20:00	2014-06-07 00:29:00
868	2014-06-07 00:30:00	2014-06-07 00:39:00
869	2014-06-07 00:40:00	2014-06-07 00:49:00
870	2014-06-07 00:50:00	2014-06-07 00:59:00
871	2014-06-07 01:00:00	2014-06-07 01:09:00
872	2014-06-07 01:10:00	2014-06-07 01:19:00
873	2014-06-07 01:20:00	2014-06-07 01:29:00
874	2014-06-07 01:30:00	2014-06-07 01:39:00
875	2014-06-07 01:40:00	2014-06-07 01:49:00
876	2014-06-07 01:50:00	2014-06-07 01:59:00
877	2014-06-07 02:00:00	2014-06-07 02:09:00
878	2014-06-07 02:10:00	2014-06-07 02:19:00
879	2014-06-07 02:20:00	2014-06-07 02:29:00
880	2014-06-07 02:30:00	2014-06-07 02:39:00
881	2014-06-07 02:40:00	2014-06-07 02:49:00
882	2014-06-07 02:50:00	2014-06-07 02:59:00
883	2014-06-07 03:00:00	2014-06-07 03:09:00
884	2014-06-07 03:10:00	2014-06-07 03:19:00
885	2014-06-07 03:20:00	2014-06-07 03:29:00
886	2014-06-07 03:30:00	2014-06-07 03:39:00
887	2014-06-07 03:40:00	2014-06-07 03:49:00
888	2014-06-07 03:50:00	2014-06-07 03:59:00
889	2014-06-07 04:00:00	2014-06-07 04:09:00
890	2014-06-07 04:10:00	2014-06-07 04:19:00
891	2014-06-07 04:20:00	2014-06-07 04:29:00
892	2014-06-07 04:30:00	2014-06-07 04:39:00
893	2014-06-07 04:40:00	2014-06-07 04:49:00
894	2014-06-07 04:50:00	2014-06-07 04:59:00
895	2014-06-07 05:00:00	2014-06-07 05:09:00
896	2014-06-07 05:10:00	2014-06-07 05:19:00
897	2014-06-07 05:20:00	2014-06-07 05:29:00
898	2014-06-07 05:30:00	2014-06-07 05:39:00
899	2014-06-07 05:40:00	2014-06-07 05:49:00
900	2014-06-07 05:50:00	2014-06-07 05:59:00
901	2014-06-07 06:00:00	2014-06-07 06:09:00
902	2014-06-07 06:10:00	2014-06-07 06:19:00
903	2014-06-07 06:20:00	2014-06-07 06:29:00
904	2014-06-07 06:30:00	2014-06-07 06:39:00
905	2014-06-07 06:40:00	2014-06-07 06:49:00
906	2014-06-07 06:50:00	2014-06-07 06:59:00
907	2014-06-07 07:00:00	2014-06-07 07:09:00
908	2014-06-07 07:10:00	2014-06-07 07:19:00
909	2014-06-07 07:20:00	2014-06-07 07:29:00
910	2014-06-07 07:30:00	2014-06-07 07:39:00
911	2014-06-07 07:40:00	2014-06-07 07:49:00
912	2014-06-07 07:50:00	2014-06-07 07:59:00
913	2014-06-07 08:00:00	2014-06-07 08:09:00
914	2014-06-07 08:10:00	2014-06-07 08:19:00
915	2014-06-07 08:20:00	2014-06-07 08:29:00
916	2014-06-07 08:30:00	2014-06-07 08:39:00
917	2014-06-07 08:40:00	2014-06-07 08:49:00
918	2014-06-07 08:50:00	2014-06-07 08:59:00
919	2014-06-07 09:00:00	2014-06-07 09:09:00
920	2014-06-07 09:10:00	2014-06-07 09:19:00
921	2014-06-07 09:20:00	2014-06-07 09:29:00
922	2014-06-07 09:30:00	2014-06-07 09:39:00
923	2014-06-07 09:40:00	2014-06-07 09:49:00
924	2014-06-07 09:50:00	2014-06-07 09:59:00
925	2014-06-07 10:00:00	2014-06-07 10:09:00
926	2014-06-07 10:10:00	2014-06-07 10:19:00
927	2014-06-07 10:20:00	2014-06-07 10:29:00
928	2014-06-07 10:30:00	2014-06-07 10:39:00
929	2014-06-07 10:40:00	2014-06-07 10:49:00
930	2014-06-07 10:50:00	2014-06-07 10:59:00
931	2014-06-07 11:00:00	2014-06-07 11:09:00
932	2014-06-07 11:10:00	2014-06-07 11:19:00
933	2014-06-07 11:20:00	2014-06-07 11:29:00
934	2014-06-07 11:30:00	2014-06-07 11:39:00
935	2014-06-07 11:40:00	2014-06-07 11:49:00
936	2014-06-07 11:50:00	2014-06-07 11:59:00
937	2014-06-07 12:00:00	2014-06-07 12:09:00
938	2014-06-07 12:10:00	2014-06-07 12:19:00
939	2014-06-07 12:20:00	2014-06-07 12:29:00
940	2014-06-07 12:30:00	2014-06-07 12:39:00
941	2014-06-07 12:40:00	2014-06-07 12:49:00
942	2014-06-07 12:50:00	2014-06-07 12:59:00
943	2014-06-07 13:00:00	2014-06-07 13:09:00
944	2014-06-07 13:10:00	2014-06-07 13:19:00
945	2014-06-07 13:20:00	2014-06-07 13:29:00
946	2014-06-07 13:30:00	2014-06-07 13:39:00
947	2014-06-07 13:40:00	2014-06-07 13:49:00
948	2014-06-07 13:50:00	2014-06-07 13:59:00
949	2014-06-07 14:00:00	2014-06-07 14:09:00
950	2014-06-07 14:10:00	2014-06-07 14:19:00
951	2014-06-07 14:20:00	2014-06-07 14:29:00
952	2014-06-07 14:30:00	2014-06-07 14:39:00
953	2014-06-07 14:40:00	2014-06-07 14:49:00
954	2014-06-07 14:50:00	2014-06-07 14:59:00
955	2014-06-07 15:00:00	2014-06-07 15:09:00
956	2014-06-07 15:10:00	2014-06-07 15:19:00
957	2014-06-07 15:20:00	2014-06-07 15:29:00
958	2014-06-07 15:30:00	2014-06-07 15:39:00
959	2014-06-07 15:40:00	2014-06-07 15:49:00
960	2014-06-07 15:50:00	2014-06-07 15:59:00
961	2014-06-07 16:00:00	2014-06-07 16:09:00
962	2014-06-07 16:10:00	2014-06-07 16:19:00
963	2014-06-07 16:20:00	2014-06-07 16:29:00
964	2014-06-07 16:30:00	2014-06-07 16:39:00
965	2014-06-07 16:40:00	2014-06-07 16:49:00
966	2014-06-07 16:50:00	2014-06-07 16:59:00
967	2014-06-07 17:00:00	2014-06-07 17:09:00
968	2014-06-07 17:10:00	2014-06-07 17:19:00
969	2014-06-07 17:20:00	2014-06-07 17:29:00
970	2014-06-07 17:30:00	2014-06-07 17:39:00
971	2014-06-07 17:40:00	2014-06-07 17:49:00
972	2014-06-07 17:50:00	2014-06-07 17:59:00
973	2014-06-07 18:00:00	2014-06-07 18:09:00
974	2014-06-07 18:10:00	2014-06-07 18:19:00
975	2014-06-07 18:20:00	2014-06-07 18:29:00
976	2014-06-07 18:30:00	2014-06-07 18:39:00
977	2014-06-07 18:40:00	2014-06-07 18:49:00
978	2014-06-07 18:50:00	2014-06-07 18:59:00
979	2014-06-07 19:00:00	2014-06-07 19:09:00
980	2014-06-07 19:10:00	2014-06-07 19:19:00
981	2014-06-07 19:20:00	2014-06-07 19:29:00
982	2014-06-07 19:30:00	2014-06-07 19:39:00
983	2014-06-07 19:40:00	2014-06-07 19:49:00
984	2014-06-07 19:50:00	2014-06-07 19:59:00
985	2014-06-07 20:00:00	2014-06-07 20:09:00
986	2014-06-07 20:10:00	2014-06-07 20:19:00
987	2014-06-07 20:20:00	2014-06-07 20:29:00
988	2014-06-07 20:30:00	2014-06-07 20:39:00
989	2014-06-07 20:40:00	2014-06-07 20:49:00
990	2014-06-07 20:50:00	2014-06-07 20:59:00
991	2014-06-07 21:00:00	2014-06-07 21:09:00
992	2014-06-07 21:10:00	2014-06-07 21:19:00
993	2014-06-07 21:20:00	2014-06-07 21:29:00
994	2014-06-07 21:30:00	2014-06-07 21:39:00
995	2014-06-07 21:40:00	2014-06-07 21:49:00
996	2014-06-07 21:50:00	2014-06-07 21:59:00
997	2014-06-07 22:00:00	2014-06-07 22:09:00
998	2014-06-07 22:10:00	2014-06-07 22:19:00
999	2014-06-07 22:20:00	2014-06-07 22:29:00
1000	2014-06-07 22:30:00	2014-06-07 22:39:00
1001	2014-06-07 22:40:00	2014-06-07 22:49:00
1002	2014-06-07 22:50:00	2014-06-07 22:59:00
1003	2014-06-07 23:00:00	2014-06-07 23:09:00
1004	2014-06-07 23:10:00	2014-06-07 23:19:00
1005	2014-06-07 23:20:00	2014-06-07 23:29:00
1006	2014-06-07 23:30:00	2014-06-07 23:39:00
1007	2014-06-07 23:40:00	2014-06-07 23:49:00
1008	2014-06-07 23:50:00	2014-06-07 23:59:00
1009	2014-06-08 00:00:00	2014-06-08 00:09:00
1010	2014-06-08 00:10:00	2014-06-08 00:19:00
1011	2014-06-08 00:20:00	2014-06-08 00:29:00
1012	2014-06-08 00:30:00	2014-06-08 00:39:00
1013	2014-06-08 00:40:00	2014-06-08 00:49:00
1014	2014-06-08 00:50:00	2014-06-08 00:59:00
1015	2014-06-08 01:00:00	2014-06-08 01:09:00
1016	2014-06-08 01:10:00	2014-06-08 01:19:00
1017	2014-06-08 01:20:00	2014-06-08 01:29:00
1018	2014-06-08 01:30:00	2014-06-08 01:39:00
1019	2014-06-08 01:40:00	2014-06-08 01:49:00
1020	2014-06-08 01:50:00	2014-06-08 01:59:00
1021	2014-06-08 02:00:00	2014-06-08 02:09:00
1022	2014-06-08 02:10:00	2014-06-08 02:19:00
1023	2014-06-08 02:20:00	2014-06-08 02:29:00
1024	2014-06-08 02:30:00	2014-06-08 02:39:00
1025	2014-06-08 02:40:00	2014-06-08 02:49:00
1026	2014-06-08 02:50:00	2014-06-08 02:59:00
1027	2014-06-08 03:00:00	2014-06-08 03:09:00
1028	2014-06-08 03:10:00	2014-06-08 03:19:00
1029	2014-06-08 03:20:00	2014-06-08 03:29:00
1030	2014-06-08 03:30:00	2014-06-08 03:39:00
1031	2014-06-08 03:40:00	2014-06-08 03:49:00
1032	2014-06-08 03:50:00	2014-06-08 03:59:00
1033	2014-06-08 04:00:00	2014-06-08 04:09:00
1034	2014-06-08 04:10:00	2014-06-08 04:19:00
1035	2014-06-08 04:20:00	2014-06-08 04:29:00
1036	2014-06-08 04:30:00	2014-06-08 04:39:00
1037	2014-06-08 04:40:00	2014-06-08 04:49:00
1038	2014-06-08 04:50:00	2014-06-08 04:59:00
1039	2014-06-08 05:00:00	2014-06-08 05:09:00
1040	2014-06-08 05:10:00	2014-06-08 05:19:00
1041	2014-06-08 05:20:00	2014-06-08 05:29:00
1042	2014-06-08 05:30:00	2014-06-08 05:39:00
1043	2014-06-08 05:40:00	2014-06-08 05:49:00
1044	2014-06-08 05:50:00	2014-06-08 05:59:00
1045	2014-06-08 06:00:00	2014-06-08 06:09:00
1046	2014-06-08 06:10:00	2014-06-08 06:19:00
1047	2014-06-08 06:20:00	2014-06-08 06:29:00
1048	2014-06-08 06:30:00	2014-06-08 06:39:00
1049	2014-06-08 06:40:00	2014-06-08 06:49:00
1050	2014-06-08 06:50:00	2014-06-08 06:59:00
1051	2014-06-08 07:00:00	2014-06-08 07:09:00
1052	2014-06-08 07:10:00	2014-06-08 07:19:00
1053	2014-06-08 07:20:00	2014-06-08 07:29:00
1054	2014-06-08 07:30:00	2014-06-08 07:39:00
1055	2014-06-08 07:40:00	2014-06-08 07:49:00
1056	2014-06-08 07:50:00	2014-06-08 07:59:00
1057	2014-06-08 08:00:00	2014-06-08 08:09:00
1058	2014-06-08 08:10:00	2014-06-08 08:19:00
1059	2014-06-08 08:20:00	2014-06-08 08:29:00
1060	2014-06-08 08:30:00	2014-06-08 08:39:00
1061	2014-06-08 08:40:00	2014-06-08 08:49:00
1062	2014-06-08 08:50:00	2014-06-08 08:59:00
1063	2014-06-08 09:00:00	2014-06-08 09:09:00
1064	2014-06-08 09:10:00	2014-06-08 09:19:00
1065	2014-06-08 09:20:00	2014-06-08 09:29:00
1066	2014-06-08 09:30:00	2014-06-08 09:39:00
1067	2014-06-08 09:40:00	2014-06-08 09:49:00
1068	2014-06-08 09:50:00	2014-06-08 09:59:00
1069	2014-06-08 10:00:00	2014-06-08 10:09:00
1070	2014-06-08 10:10:00	2014-06-08 10:19:00
1071	2014-06-08 10:20:00	2014-06-08 10:29:00
1072	2014-06-08 10:30:00	2014-06-08 10:39:00
1073	2014-06-08 10:40:00	2014-06-08 10:49:00
1074	2014-06-08 10:50:00	2014-06-08 10:59:00
1075	2014-06-08 11:00:00	2014-06-08 11:09:00
1076	2014-06-08 11:10:00	2014-06-08 11:19:00
1077	2014-06-08 11:20:00	2014-06-08 11:29:00
1078	2014-06-08 11:30:00	2014-06-08 11:39:00
1079	2014-06-08 11:40:00	2014-06-08 11:49:00
1080	2014-06-08 11:50:00	2014-06-08 11:59:00
1081	2014-06-08 12:00:00	2014-06-08 12:09:00
1082	2014-06-08 12:10:00	2014-06-08 12:19:00
1083	2014-06-08 12:20:00	2014-06-08 12:29:00
1084	2014-06-08 12:30:00	2014-06-08 12:39:00
1085	2014-06-08 12:40:00	2014-06-08 12:49:00
1086	2014-06-08 12:50:00	2014-06-08 12:59:00
1087	2014-06-08 13:00:00	2014-06-08 13:09:00
1088	2014-06-08 13:10:00	2014-06-08 13:19:00
1089	2014-06-08 13:20:00	2014-06-08 13:29:00
1090	2014-06-08 13:30:00	2014-06-08 13:39:00
1091	2014-06-08 13:40:00	2014-06-08 13:49:00
1092	2014-06-08 13:50:00	2014-06-08 13:59:00
1093	2014-06-08 14:00:00	2014-06-08 14:09:00
1094	2014-06-08 14:10:00	2014-06-08 14:19:00
1095	2014-06-08 14:20:00	2014-06-08 14:29:00
1096	2014-06-08 14:30:00	2014-06-08 14:39:00
1097	2014-06-08 14:40:00	2014-06-08 14:49:00
1098	2014-06-08 14:50:00	2014-06-08 14:59:00
1099	2014-06-08 15:00:00	2014-06-08 15:09:00
1100	2014-06-08 15:10:00	2014-06-08 15:19:00
1101	2014-06-08 15:20:00	2014-06-08 15:29:00
1102	2014-06-08 15:30:00	2014-06-08 15:39:00
1103	2014-06-08 15:40:00	2014-06-08 15:49:00
1104	2014-06-08 15:50:00	2014-06-08 15:59:00
1105	2014-06-08 16:00:00	2014-06-08 16:09:00
1106	2014-06-08 16:10:00	2014-06-08 16:19:00
1107	2014-06-08 16:20:00	2014-06-08 16:29:00
1108	2014-06-08 16:30:00	2014-06-08 16:39:00
1109	2014-06-08 16:40:00	2014-06-08 16:49:00
1110	2014-06-08 16:50:00	2014-06-08 16:59:00
1111	2014-06-08 17:00:00	2014-06-08 17:09:00
1112	2014-06-08 17:10:00	2014-06-08 17:19:00
1113	2014-06-08 17:20:00	2014-06-08 17:29:00
1114	2014-06-08 17:30:00	2014-06-08 17:39:00
1115	2014-06-08 17:40:00	2014-06-08 17:49:00
1116	2014-06-08 17:50:00	2014-06-08 17:59:00
1117	2014-06-08 18:00:00	2014-06-08 18:09:00
1118	2014-06-08 18:10:00	2014-06-08 18:19:00
1119	2014-06-08 18:20:00	2014-06-08 18:29:00
1120	2014-06-08 18:30:00	2014-06-08 18:39:00
1121	2014-06-08 18:40:00	2014-06-08 18:49:00
1122	2014-06-08 18:50:00	2014-06-08 18:59:00
1123	2014-06-08 19:00:00	2014-06-08 19:09:00
1124	2014-06-08 19:10:00	2014-06-08 19:19:00
1125	2014-06-08 19:20:00	2014-06-08 19:29:00
1126	2014-06-08 19:30:00	2014-06-08 19:39:00
1127	2014-06-08 19:40:00	2014-06-08 19:49:00
1128	2014-06-08 19:50:00	2014-06-08 19:59:00
1129	2014-06-08 20:00:00	2014-06-08 20:09:00
1130	2014-06-08 20:10:00	2014-06-08 20:19:00
1131	2014-06-08 20:20:00	2014-06-08 20:29:00
1132	2014-06-08 20:30:00	2014-06-08 20:39:00
1133	2014-06-08 20:40:00	2014-06-08 20:49:00
1134	2014-06-08 20:50:00	2014-06-08 20:59:00
1135	2014-06-08 21:00:00	2014-06-08 21:09:00
1136	2014-06-08 21:10:00	2014-06-08 21:19:00
1137	2014-06-08 21:20:00	2014-06-08 21:29:00
1138	2014-06-08 21:30:00	2014-06-08 21:39:00
1139	2014-06-08 21:40:00	2014-06-08 21:49:00
1140	2014-06-08 21:50:00	2014-06-08 21:59:00
1141	2014-06-08 22:00:00	2014-06-08 22:09:00
1142	2014-06-08 22:10:00	2014-06-08 22:19:00
1143	2014-06-08 22:20:00	2014-06-08 22:29:00
1144	2014-06-08 22:30:00	2014-06-08 22:39:00
1145	2014-06-08 22:40:00	2014-06-08 22:49:00
1146	2014-06-08 22:50:00	2014-06-08 22:59:00
1147	2014-06-08 23:00:00	2014-06-08 23:09:00
1148	2014-06-08 23:10:00	2014-06-08 23:19:00
1149	2014-06-08 23:20:00	2014-06-08 23:29:00
1150	2014-06-08 23:30:00	2014-06-08 23:39:00
1151	2014-06-08 23:40:00	2014-06-08 23:49:00
1152	2014-06-08 23:50:00	2014-06-08 23:59:00
1153	2014-06-09 00:00:00	2014-06-09 00:09:00
1154	2014-06-09 00:10:00	2014-06-09 00:19:00
1155	2014-06-09 00:20:00	2014-06-09 00:29:00
1156	2014-06-09 00:30:00	2014-06-09 00:39:00
1157	2014-06-09 00:40:00	2014-06-09 00:49:00
1158	2014-06-09 00:50:00	2014-06-09 00:59:00
1159	2014-06-09 01:00:00	2014-06-09 01:09:00
1160	2014-06-09 01:10:00	2014-06-09 01:19:00
1161	2014-06-09 01:20:00	2014-06-09 01:29:00
1162	2014-06-09 01:30:00	2014-06-09 01:39:00
1163	2014-06-09 01:40:00	2014-06-09 01:49:00
1164	2014-06-09 01:50:00	2014-06-09 01:59:00
1165	2014-06-09 02:00:00	2014-06-09 02:09:00
1166	2014-06-09 02:10:00	2014-06-09 02:19:00
1167	2014-06-09 02:20:00	2014-06-09 02:29:00
1168	2014-06-09 02:30:00	2014-06-09 02:39:00
1169	2014-06-09 02:40:00	2014-06-09 02:49:00
1170	2014-06-09 02:50:00	2014-06-09 02:59:00
1171	2014-06-09 03:00:00	2014-06-09 03:09:00
1172	2014-06-09 03:10:00	2014-06-09 03:19:00
1173	2014-06-09 03:20:00	2014-06-09 03:29:00
1174	2014-06-09 03:30:00	2014-06-09 03:39:00
1175	2014-06-09 03:40:00	2014-06-09 03:49:00
1176	2014-06-09 03:50:00	2014-06-09 03:59:00
1177	2014-06-09 04:00:00	2014-06-09 04:09:00
1178	2014-06-09 04:10:00	2014-06-09 04:19:00
1179	2014-06-09 04:20:00	2014-06-09 04:29:00
1180	2014-06-09 04:30:00	2014-06-09 04:39:00
1181	2014-06-09 04:40:00	2014-06-09 04:49:00
1182	2014-06-09 04:50:00	2014-06-09 04:59:00
1183	2014-06-09 05:00:00	2014-06-09 05:09:00
1184	2014-06-09 05:10:00	2014-06-09 05:19:00
1185	2014-06-09 05:20:00	2014-06-09 05:29:00
1186	2014-06-09 05:30:00	2014-06-09 05:39:00
1187	2014-06-09 05:40:00	2014-06-09 05:49:00
1188	2014-06-09 05:50:00	2014-06-09 05:59:00
1189	2014-06-09 06:00:00	2014-06-09 06:09:00
1190	2014-06-09 06:10:00	2014-06-09 06:19:00
1191	2014-06-09 06:20:00	2014-06-09 06:29:00
1192	2014-06-09 06:30:00	2014-06-09 06:39:00
1193	2014-06-09 06:40:00	2014-06-09 06:49:00
1194	2014-06-09 06:50:00	2014-06-09 06:59:00
1195	2014-06-09 07:00:00	2014-06-09 07:09:00
1196	2014-06-09 07:10:00	2014-06-09 07:19:00
1197	2014-06-09 07:20:00	2014-06-09 07:29:00
1198	2014-06-09 07:30:00	2014-06-09 07:39:00
1199	2014-06-09 07:40:00	2014-06-09 07:49:00
1200	2014-06-09 07:50:00	2014-06-09 07:59:00
1201	2014-06-09 08:00:00	2014-06-09 08:09:00
1202	2014-06-09 08:10:00	2014-06-09 08:19:00
1203	2014-06-09 08:20:00	2014-06-09 08:29:00
1204	2014-06-09 08:30:00	2014-06-09 08:39:00
1205	2014-06-09 08:40:00	2014-06-09 08:49:00
1206	2014-06-09 08:50:00	2014-06-09 08:59:00
1207	2014-06-09 09:00:00	2014-06-09 09:09:00
1208	2014-06-09 09:10:00	2014-06-09 09:19:00
1209	2014-06-09 09:20:00	2014-06-09 09:29:00
1210	2014-06-09 09:30:00	2014-06-09 09:39:00
1211	2014-06-09 09:40:00	2014-06-09 09:49:00
1212	2014-06-09 09:50:00	2014-06-09 09:59:00
1213	2014-06-09 10:00:00	2014-06-09 10:09:00
1214	2014-06-09 10:10:00	2014-06-09 10:19:00
1215	2014-06-09 10:20:00	2014-06-09 10:29:00
1216	2014-06-09 10:30:00	2014-06-09 10:39:00
1217	2014-06-09 10:40:00	2014-06-09 10:49:00
1218	2014-06-09 10:50:00	2014-06-09 10:59:00
1219	2014-06-09 11:00:00	2014-06-09 11:09:00
1220	2014-06-09 11:10:00	2014-06-09 11:19:00
1221	2014-06-09 11:20:00	2014-06-09 11:29:00
1222	2014-06-09 11:30:00	2014-06-09 11:39:00
1223	2014-06-09 11:40:00	2014-06-09 11:49:00
1224	2014-06-09 11:50:00	2014-06-09 11:59:00
1225	2014-06-09 12:00:00	2014-06-09 12:09:00
1226	2014-06-09 12:10:00	2014-06-09 12:19:00
1227	2014-06-09 12:20:00	2014-06-09 12:29:00
1228	2014-06-09 12:30:00	2014-06-09 12:39:00
1229	2014-06-09 12:40:00	2014-06-09 12:49:00
1230	2014-06-09 12:50:00	2014-06-09 12:59:00
1231	2014-06-09 13:00:00	2014-06-09 13:09:00
1232	2014-06-09 13:10:00	2014-06-09 13:19:00
1233	2014-06-09 13:20:00	2014-06-09 13:29:00
1234	2014-06-09 13:30:00	2014-06-09 13:39:00
1235	2014-06-09 13:40:00	2014-06-09 13:49:00
1236	2014-06-09 13:50:00	2014-06-09 13:59:00
1237	2014-06-09 14:00:00	2014-06-09 14:09:00
1238	2014-06-09 14:10:00	2014-06-09 14:19:00
1239	2014-06-09 14:20:00	2014-06-09 14:29:00
1240	2014-06-09 14:30:00	2014-06-09 14:39:00
1241	2014-06-09 14:40:00	2014-06-09 14:49:00
1242	2014-06-09 14:50:00	2014-06-09 14:59:00
1243	2014-06-09 15:00:00	2014-06-09 15:09:00
1244	2014-06-09 15:10:00	2014-06-09 15:19:00
1245	2014-06-09 15:20:00	2014-06-09 15:29:00
1246	2014-06-09 15:30:00	2014-06-09 15:39:00
1247	2014-06-09 15:40:00	2014-06-09 15:49:00
1248	2014-06-09 15:50:00	2014-06-09 15:59:00
1249	2014-06-09 16:00:00	2014-06-09 16:09:00
1250	2014-06-09 16:10:00	2014-06-09 16:19:00
1251	2014-06-09 16:20:00	2014-06-09 16:29:00
1252	2014-06-09 16:30:00	2014-06-09 16:39:00
1253	2014-06-09 16:40:00	2014-06-09 16:49:00
1254	2014-06-09 16:50:00	2014-06-09 16:59:00
1255	2014-06-09 17:00:00	2014-06-09 17:09:00
1256	2014-06-09 17:10:00	2014-06-09 17:19:00
1257	2014-06-09 17:20:00	2014-06-09 17:29:00
1258	2014-06-09 17:30:00	2014-06-09 17:39:00
1259	2014-06-09 17:40:00	2014-06-09 17:49:00
1260	2014-06-09 17:50:00	2014-06-09 17:59:00
1261	2014-06-09 18:00:00	2014-06-09 18:09:00
1262	2014-06-09 18:10:00	2014-06-09 18:19:00
1263	2014-06-09 18:20:00	2014-06-09 18:29:00
1264	2014-06-09 18:30:00	2014-06-09 18:39:00
1265	2014-06-09 18:40:00	2014-06-09 18:49:00
1266	2014-06-09 18:50:00	2014-06-09 18:59:00
1267	2014-06-09 19:00:00	2014-06-09 19:09:00
1268	2014-06-09 19:10:00	2014-06-09 19:19:00
1269	2014-06-09 19:20:00	2014-06-09 19:29:00
1270	2014-06-09 19:30:00	2014-06-09 19:39:00
1271	2014-06-09 19:40:00	2014-06-09 19:49:00
1272	2014-06-09 19:50:00	2014-06-09 19:59:00
1273	2014-06-09 20:00:00	2014-06-09 20:09:00
1274	2014-06-09 20:10:00	2014-06-09 20:19:00
1275	2014-06-09 20:20:00	2014-06-09 20:29:00
1276	2014-06-09 20:30:00	2014-06-09 20:39:00
1277	2014-06-09 20:40:00	2014-06-09 20:49:00
1278	2014-06-09 20:50:00	2014-06-09 20:59:00
1279	2014-06-09 21:00:00	2014-06-09 21:09:00
1280	2014-06-09 21:10:00	2014-06-09 21:19:00
1281	2014-06-09 21:20:00	2014-06-09 21:29:00
1282	2014-06-09 21:30:00	2014-06-09 21:39:00
1283	2014-06-09 21:40:00	2014-06-09 21:49:00
1284	2014-06-09 21:50:00	2014-06-09 21:59:00
1285	2014-06-09 22:00:00	2014-06-09 22:09:00
1286	2014-06-09 22:10:00	2014-06-09 22:19:00
1287	2014-06-09 22:20:00	2014-06-09 22:29:00
1288	2014-06-09 22:30:00	2014-06-09 22:39:00
1289	2014-06-09 22:40:00	2014-06-09 22:49:00
1290	2014-06-09 22:50:00	2014-06-09 22:59:00
1291	2014-06-09 23:00:00	2014-06-09 23:09:00
1292	2014-06-09 23:10:00	2014-06-09 23:19:00
1293	2014-06-09 23:20:00	2014-06-09 23:29:00
1294	2014-06-09 23:30:00	2014-06-09 23:39:00
1295	2014-06-09 23:40:00	2014-06-09 23:49:00
1296	2014-06-09 23:50:00	2014-06-09 23:59:00
1297	2014-06-10 00:00:00	2014-06-10 00:09:00
1298	2014-06-10 00:10:00	2014-06-10 00:19:00
1299	2014-06-10 00:20:00	2014-06-10 00:29:00
1300	2014-06-10 00:30:00	2014-06-10 00:39:00
1301	2014-06-10 00:40:00	2014-06-10 00:49:00
1302	2014-06-10 00:50:00	2014-06-10 00:59:00
1303	2014-06-10 01:00:00	2014-06-10 01:09:00
1304	2014-06-10 01:10:00	2014-06-10 01:19:00
1305	2014-06-10 01:20:00	2014-06-10 01:29:00
1306	2014-06-10 01:30:00	2014-06-10 01:39:00
1307	2014-06-10 01:40:00	2014-06-10 01:49:00
1308	2014-06-10 01:50:00	2014-06-10 01:59:00
1309	2014-06-10 02:00:00	2014-06-10 02:09:00
1310	2014-06-10 02:10:00	2014-06-10 02:19:00
1311	2014-06-10 02:20:00	2014-06-10 02:29:00
1312	2014-06-10 02:30:00	2014-06-10 02:39:00
1313	2014-06-10 02:40:00	2014-06-10 02:49:00
1314	2014-06-10 02:50:00	2014-06-10 02:59:00
1315	2014-06-10 03:00:00	2014-06-10 03:09:00
1316	2014-06-10 03:10:00	2014-06-10 03:19:00
1317	2014-06-10 03:20:00	2014-06-10 03:29:00
1318	2014-06-10 03:30:00	2014-06-10 03:39:00
1319	2014-06-10 03:40:00	2014-06-10 03:49:00
1320	2014-06-10 03:50:00	2014-06-10 03:59:00
1321	2014-06-10 04:00:00	2014-06-10 04:09:00
1322	2014-06-10 04:10:00	2014-06-10 04:19:00
1323	2014-06-10 04:20:00	2014-06-10 04:29:00
1324	2014-06-10 04:30:00	2014-06-10 04:39:00
1325	2014-06-10 04:40:00	2014-06-10 04:49:00
1326	2014-06-10 04:50:00	2014-06-10 04:59:00
1327	2014-06-10 05:00:00	2014-06-10 05:09:00
1328	2014-06-10 05:10:00	2014-06-10 05:19:00
1329	2014-06-10 05:20:00	2014-06-10 05:29:00
1330	2014-06-10 05:30:00	2014-06-10 05:39:00
1331	2014-06-10 05:40:00	2014-06-10 05:49:00
1332	2014-06-10 05:50:00	2014-06-10 05:59:00
1333	2014-06-10 06:00:00	2014-06-10 06:09:00
1334	2014-06-10 06:10:00	2014-06-10 06:19:00
1335	2014-06-10 06:20:00	2014-06-10 06:29:00
1336	2014-06-10 06:30:00	2014-06-10 06:39:00
1337	2014-06-10 06:40:00	2014-06-10 06:49:00
1338	2014-06-10 06:50:00	2014-06-10 06:59:00
1339	2014-06-10 07:00:00	2014-06-10 07:09:00
1340	2014-06-10 07:10:00	2014-06-10 07:19:00
1341	2014-06-10 07:20:00	2014-06-10 07:29:00
1342	2014-06-10 07:30:00	2014-06-10 07:39:00
1343	2014-06-10 07:40:00	2014-06-10 07:49:00
1344	2014-06-10 07:50:00	2014-06-10 07:59:00
1345	2014-06-10 08:00:00	2014-06-10 08:09:00
1346	2014-06-10 08:10:00	2014-06-10 08:19:00
1347	2014-06-10 08:20:00	2014-06-10 08:29:00
1348	2014-06-10 08:30:00	2014-06-10 08:39:00
1349	2014-06-10 08:40:00	2014-06-10 08:49:00
1350	2014-06-10 08:50:00	2014-06-10 08:59:00
1351	2014-06-10 09:00:00	2014-06-10 09:09:00
1352	2014-06-10 09:10:00	2014-06-10 09:19:00
1353	2014-06-10 09:20:00	2014-06-10 09:29:00
1354	2014-06-10 09:30:00	2014-06-10 09:39:00
1355	2014-06-10 09:40:00	2014-06-10 09:49:00
1356	2014-06-10 09:50:00	2014-06-10 09:59:00
1357	2014-06-10 10:00:00	2014-06-10 10:09:00
1358	2014-06-10 10:10:00	2014-06-10 10:19:00
1359	2014-06-10 10:20:00	2014-06-10 10:29:00
1360	2014-06-10 10:30:00	2014-06-10 10:39:00
1361	2014-06-10 10:40:00	2014-06-10 10:49:00
1362	2014-06-10 10:50:00	2014-06-10 10:59:00
1363	2014-06-10 11:00:00	2014-06-10 11:09:00
1364	2014-06-10 11:10:00	2014-06-10 11:19:00
1365	2014-06-10 11:20:00	2014-06-10 11:29:00
1366	2014-06-10 11:30:00	2014-06-10 11:39:00
1367	2014-06-10 11:40:00	2014-06-10 11:49:00
1368	2014-06-10 11:50:00	2014-06-10 11:59:00
1369	2014-06-10 12:00:00	2014-06-10 12:09:00
1370	2014-06-10 12:10:00	2014-06-10 12:19:00
1371	2014-06-10 12:20:00	2014-06-10 12:29:00
1372	2014-06-10 12:30:00	2014-06-10 12:39:00
1373	2014-06-10 12:40:00	2014-06-10 12:49:00
1374	2014-06-10 12:50:00	2014-06-10 12:59:00
1375	2014-06-10 13:00:00	2014-06-10 13:09:00
1376	2014-06-10 13:10:00	2014-06-10 13:19:00
1377	2014-06-10 13:20:00	2014-06-10 13:29:00
1378	2014-06-10 13:30:00	2014-06-10 13:39:00
1379	2014-06-10 13:40:00	2014-06-10 13:49:00
1380	2014-06-10 13:50:00	2014-06-10 13:59:00
1381	2014-06-10 14:00:00	2014-06-10 14:09:00
1382	2014-06-10 14:10:00	2014-06-10 14:19:00
1383	2014-06-10 14:20:00	2014-06-10 14:29:00
1384	2014-06-10 14:30:00	2014-06-10 14:39:00
1385	2014-06-10 14:40:00	2014-06-10 14:49:00
1386	2014-06-10 14:50:00	2014-06-10 14:59:00
1387	2014-06-10 15:00:00	2014-06-10 15:09:00
1388	2014-06-10 15:10:00	2014-06-10 15:19:00
1389	2014-06-10 15:20:00	2014-06-10 15:29:00
1390	2014-06-10 15:30:00	2014-06-10 15:39:00
1391	2014-06-10 15:40:00	2014-06-10 15:49:00
1392	2014-06-10 15:50:00	2014-06-10 15:59:00
1393	2014-06-10 16:00:00	2014-06-10 16:09:00
1394	2014-06-10 16:10:00	2014-06-10 16:19:00
1395	2014-06-10 16:20:00	2014-06-10 16:29:00
1396	2014-06-10 16:30:00	2014-06-10 16:39:00
1397	2014-06-10 16:40:00	2014-06-10 16:49:00
1398	2014-06-10 16:50:00	2014-06-10 16:59:00
1399	2014-06-10 17:00:00	2014-06-10 17:09:00
1400	2014-06-10 17:10:00	2014-06-10 17:19:00
1401	2014-06-10 17:20:00	2014-06-10 17:29:00
1402	2014-06-10 17:30:00	2014-06-10 17:39:00
1403	2014-06-10 17:40:00	2014-06-10 17:49:00
1404	2014-06-10 17:50:00	2014-06-10 17:59:00
1405	2014-06-10 18:00:00	2014-06-10 18:09:00
1406	2014-06-10 18:10:00	2014-06-10 18:19:00
1407	2014-06-10 18:20:00	2014-06-10 18:29:00
1408	2014-06-10 18:30:00	2014-06-10 18:39:00
1409	2014-06-10 18:40:00	2014-06-10 18:49:00
1410	2014-06-10 18:50:00	2014-06-10 18:59:00
1411	2014-06-10 19:00:00	2014-06-10 19:09:00
1412	2014-06-10 19:10:00	2014-06-10 19:19:00
1413	2014-06-10 19:20:00	2014-06-10 19:29:00
1414	2014-06-10 19:30:00	2014-06-10 19:39:00
1415	2014-06-10 19:40:00	2014-06-10 19:49:00
1416	2014-06-10 19:50:00	2014-06-10 19:59:00
1417	2014-06-10 20:00:00	2014-06-10 20:09:00
1418	2014-06-10 20:10:00	2014-06-10 20:19:00
1419	2014-06-10 20:20:00	2014-06-10 20:29:00
1420	2014-06-10 20:30:00	2014-06-10 20:39:00
1421	2014-06-10 20:40:00	2014-06-10 20:49:00
1422	2014-06-10 20:50:00	2014-06-10 20:59:00
1423	2014-06-10 21:00:00	2014-06-10 21:09:00
1424	2014-06-10 21:10:00	2014-06-10 21:19:00
1425	2014-06-10 21:20:00	2014-06-10 21:29:00
1426	2014-06-10 21:30:00	2014-06-10 21:39:00
1427	2014-06-10 21:40:00	2014-06-10 21:49:00
1428	2014-06-10 21:50:00	2014-06-10 21:59:00
1429	2014-06-10 22:00:00	2014-06-10 22:09:00
1430	2014-06-10 22:10:00	2014-06-10 22:19:00
1431	2014-06-10 22:20:00	2014-06-10 22:29:00
1432	2014-06-10 22:30:00	2014-06-10 22:39:00
1433	2014-06-10 22:40:00	2014-06-10 22:49:00
1434	2014-06-10 22:50:00	2014-06-10 22:59:00
1435	2014-06-10 23:00:00	2014-06-10 23:09:00
1436	2014-06-10 23:10:00	2014-06-10 23:19:00
1437	2014-06-10 23:20:00	2014-06-10 23:29:00
1438	2014-06-10 23:30:00	2014-06-10 23:39:00
1439	2014-06-10 23:40:00	2014-06-10 23:49:00
1440	2014-06-10 23:50:00	2014-06-10 23:59:00
1441	2014-06-11 00:00:00	2014-06-11 00:09:00
1442	2014-06-11 00:10:00	2014-06-11 00:19:00
1443	2014-06-11 00:20:00	2014-06-11 00:29:00
1444	2014-06-11 00:30:00	2014-06-11 00:39:00
1445	2014-06-11 00:40:00	2014-06-11 00:49:00
1446	2014-06-11 00:50:00	2014-06-11 00:59:00
1447	2014-06-11 01:00:00	2014-06-11 01:09:00
1448	2014-06-11 01:10:00	2014-06-11 01:19:00
1449	2014-06-11 01:20:00	2014-06-11 01:29:00
1450	2014-06-11 01:30:00	2014-06-11 01:39:00
1451	2014-06-11 01:40:00	2014-06-11 01:49:00
1452	2014-06-11 01:50:00	2014-06-11 01:59:00
1453	2014-06-11 02:00:00	2014-06-11 02:09:00
1454	2014-06-11 02:10:00	2014-06-11 02:19:00
1455	2014-06-11 02:20:00	2014-06-11 02:29:00
1456	2014-06-11 02:30:00	2014-06-11 02:39:00
1457	2014-06-11 02:40:00	2014-06-11 02:49:00
1458	2014-06-11 02:50:00	2014-06-11 02:59:00
1459	2014-06-11 03:00:00	2014-06-11 03:09:00
1460	2014-06-11 03:10:00	2014-06-11 03:19:00
1461	2014-06-11 03:20:00	2014-06-11 03:29:00
1462	2014-06-11 03:30:00	2014-06-11 03:39:00
1463	2014-06-11 03:40:00	2014-06-11 03:49:00
1464	2014-06-11 03:50:00	2014-06-11 03:59:00
1465	2014-06-11 04:00:00	2014-06-11 04:09:00
1466	2014-06-11 04:10:00	2014-06-11 04:19:00
1467	2014-06-11 04:20:00	2014-06-11 04:29:00
1468	2014-06-11 04:30:00	2014-06-11 04:39:00
1469	2014-06-11 04:40:00	2014-06-11 04:49:00
1470	2014-06-11 04:50:00	2014-06-11 04:59:00
1471	2014-06-11 05:00:00	2014-06-11 05:09:00
1472	2014-06-11 05:10:00	2014-06-11 05:19:00
1473	2014-06-11 05:20:00	2014-06-11 05:29:00
1474	2014-06-11 05:30:00	2014-06-11 05:39:00
1475	2014-06-11 05:40:00	2014-06-11 05:49:00
1476	2014-06-11 05:50:00	2014-06-11 05:59:00
1477	2014-06-11 06:00:00	2014-06-11 06:09:00
1478	2014-06-11 06:10:00	2014-06-11 06:19:00
1479	2014-06-11 06:20:00	2014-06-11 06:29:00
1480	2014-06-11 06:30:00	2014-06-11 06:39:00
1481	2014-06-11 06:40:00	2014-06-11 06:49:00
1482	2014-06-11 06:50:00	2014-06-11 06:59:00
1483	2014-06-11 07:00:00	2014-06-11 07:09:00
1484	2014-06-11 07:10:00	2014-06-11 07:19:00
1485	2014-06-11 07:20:00	2014-06-11 07:29:00
1486	2014-06-11 07:30:00	2014-06-11 07:39:00
1487	2014-06-11 07:40:00	2014-06-11 07:49:00
1488	2014-06-11 07:50:00	2014-06-11 07:59:00
1489	2014-06-11 08:00:00	2014-06-11 08:09:00
1490	2014-06-11 08:10:00	2014-06-11 08:19:00
1491	2014-06-11 08:20:00	2014-06-11 08:29:00
1492	2014-06-11 08:30:00	2014-06-11 08:39:00
1493	2014-06-11 08:40:00	2014-06-11 08:49:00
1494	2014-06-11 08:50:00	2014-06-11 08:59:00
1495	2014-06-11 09:00:00	2014-06-11 09:09:00
1496	2014-06-11 09:10:00	2014-06-11 09:19:00
1497	2014-06-11 09:20:00	2014-06-11 09:29:00
1498	2014-06-11 09:30:00	2014-06-11 09:39:00
1499	2014-06-11 09:40:00	2014-06-11 09:49:00
1500	2014-06-11 09:50:00	2014-06-11 09:59:00
1501	2014-06-11 10:00:00	2014-06-11 10:09:00
1502	2014-06-11 10:10:00	2014-06-11 10:19:00
1503	2014-06-11 10:20:00	2014-06-11 10:29:00
1504	2014-06-11 10:30:00	2014-06-11 10:39:00
1505	2014-06-11 10:40:00	2014-06-11 10:49:00
1506	2014-06-11 10:50:00	2014-06-11 10:59:00
1507	2014-06-11 11:00:00	2014-06-11 11:09:00
1508	2014-06-11 11:10:00	2014-06-11 11:19:00
1509	2014-06-11 11:20:00	2014-06-11 11:29:00
1510	2014-06-11 11:30:00	2014-06-11 11:39:00
1511	2014-06-11 11:40:00	2014-06-11 11:49:00
1512	2014-06-11 11:50:00	2014-06-11 11:59:00
1513	2014-06-11 12:00:00	2014-06-11 12:09:00
1514	2014-06-11 12:10:00	2014-06-11 12:19:00
1515	2014-06-11 12:20:00	2014-06-11 12:29:00
1516	2014-06-11 12:30:00	2014-06-11 12:39:00
1517	2014-06-11 12:40:00	2014-06-11 12:49:00
1518	2014-06-11 12:50:00	2014-06-11 12:59:00
1519	2014-06-11 13:00:00	2014-06-11 13:09:00
1520	2014-06-11 13:10:00	2014-06-11 13:19:00
1521	2014-06-11 13:20:00	2014-06-11 13:29:00
1522	2014-06-11 13:30:00	2014-06-11 13:39:00
1523	2014-06-11 13:40:00	2014-06-11 13:49:00
1524	2014-06-11 13:50:00	2014-06-11 13:59:00
1525	2014-06-11 14:00:00	2014-06-11 14:09:00
1526	2014-06-11 14:10:00	2014-06-11 14:19:00
1527	2014-06-11 14:20:00	2014-06-11 14:29:00
1528	2014-06-11 14:30:00	2014-06-11 14:39:00
1529	2014-06-11 14:40:00	2014-06-11 14:49:00
1530	2014-06-11 14:50:00	2014-06-11 14:59:00
1531	2014-06-11 15:00:00	2014-06-11 15:09:00
1532	2014-06-11 15:10:00	2014-06-11 15:19:00
1533	2014-06-11 15:20:00	2014-06-11 15:29:00
1534	2014-06-11 15:30:00	2014-06-11 15:39:00
1535	2014-06-11 15:40:00	2014-06-11 15:49:00
1536	2014-06-11 15:50:00	2014-06-11 15:59:00
1537	2014-06-11 16:00:00	2014-06-11 16:09:00
1538	2014-06-11 16:10:00	2014-06-11 16:19:00
1539	2014-06-11 16:20:00	2014-06-11 16:29:00
1540	2014-06-11 16:30:00	2014-06-11 16:39:00
1541	2014-06-11 16:40:00	2014-06-11 16:49:00
1542	2014-06-11 16:50:00	2014-06-11 16:59:00
1543	2014-06-11 17:00:00	2014-06-11 17:09:00
1544	2014-06-11 17:10:00	2014-06-11 17:19:00
1545	2014-06-11 17:20:00	2014-06-11 17:29:00
1546	2014-06-11 17:30:00	2014-06-11 17:39:00
1547	2014-06-11 17:40:00	2014-06-11 17:49:00
1548	2014-06-11 17:50:00	2014-06-11 17:59:00
1549	2014-06-11 18:00:00	2014-06-11 18:09:00
1550	2014-06-11 18:10:00	2014-06-11 18:19:00
1551	2014-06-11 18:20:00	2014-06-11 18:29:00
1552	2014-06-11 18:30:00	2014-06-11 18:39:00
1553	2014-06-11 18:40:00	2014-06-11 18:49:00
1554	2014-06-11 18:50:00	2014-06-11 18:59:00
1555	2014-06-11 19:00:00	2014-06-11 19:09:00
1556	2014-06-11 19:10:00	2014-06-11 19:19:00
1557	2014-06-11 19:20:00	2014-06-11 19:29:00
1558	2014-06-11 19:30:00	2014-06-11 19:39:00
1559	2014-06-11 19:40:00	2014-06-11 19:49:00
1560	2014-06-11 19:50:00	2014-06-11 19:59:00
1561	2014-06-11 20:00:00	2014-06-11 20:09:00
1562	2014-06-11 20:10:00	2014-06-11 20:19:00
1563	2014-06-11 20:20:00	2014-06-11 20:29:00
1564	2014-06-11 20:30:00	2014-06-11 20:39:00
1565	2014-06-11 20:40:00	2014-06-11 20:49:00
1566	2014-06-11 20:50:00	2014-06-11 20:59:00
1567	2014-06-11 21:00:00	2014-06-11 21:09:00
1568	2014-06-11 21:10:00	2014-06-11 21:19:00
1569	2014-06-11 21:20:00	2014-06-11 21:29:00
1570	2014-06-11 21:30:00	2014-06-11 21:39:00
1571	2014-06-11 21:40:00	2014-06-11 21:49:00
1572	2014-06-11 21:50:00	2014-06-11 21:59:00
1573	2014-06-11 22:00:00	2014-06-11 22:09:00
1574	2014-06-11 22:10:00	2014-06-11 22:19:00
1575	2014-06-11 22:20:00	2014-06-11 22:29:00
1576	2014-06-11 22:30:00	2014-06-11 22:39:00
1577	2014-06-11 22:40:00	2014-06-11 22:49:00
1578	2014-06-11 22:50:00	2014-06-11 22:59:00
1579	2014-06-11 23:00:00	2014-06-11 23:09:00
1580	2014-06-11 23:10:00	2014-06-11 23:19:00
1581	2014-06-11 23:20:00	2014-06-11 23:29:00
1582	2014-06-11 23:30:00	2014-06-11 23:39:00
1583	2014-06-11 23:40:00	2014-06-11 23:49:00
1584	2014-06-11 23:50:00	2014-06-11 23:59:00
1585	2014-06-12 00:00:00	2014-06-12 00:09:00
1586	2014-06-12 00:10:00	2014-06-12 00:19:00
1587	2014-06-12 00:20:00	2014-06-12 00:29:00
1588	2014-06-12 00:30:00	2014-06-12 00:39:00
1589	2014-06-12 00:40:00	2014-06-12 00:49:00
1590	2014-06-12 00:50:00	2014-06-12 00:59:00
1591	2014-06-12 01:00:00	2014-06-12 01:09:00
1592	2014-06-12 01:10:00	2014-06-12 01:19:00
1593	2014-06-12 01:20:00	2014-06-12 01:29:00
1594	2014-06-12 01:30:00	2014-06-12 01:39:00
1595	2014-06-12 01:40:00	2014-06-12 01:49:00
1596	2014-06-12 01:50:00	2014-06-12 01:59:00
1597	2014-06-12 02:00:00	2014-06-12 02:09:00
1598	2014-06-12 02:10:00	2014-06-12 02:19:00
1599	2014-06-12 02:20:00	2014-06-12 02:29:00
1600	2014-06-12 02:30:00	2014-06-12 02:39:00
1601	2014-06-12 02:40:00	2014-06-12 02:49:00
1602	2014-06-12 02:50:00	2014-06-12 02:59:00
1603	2014-06-12 03:00:00	2014-06-12 03:09:00
1604	2014-06-12 03:10:00	2014-06-12 03:19:00
1605	2014-06-12 03:20:00	2014-06-12 03:29:00
1606	2014-06-12 03:30:00	2014-06-12 03:39:00
1607	2014-06-12 03:40:00	2014-06-12 03:49:00
1608	2014-06-12 03:50:00	2014-06-12 03:59:00
1609	2014-06-12 04:00:00	2014-06-12 04:09:00
1610	2014-06-12 04:10:00	2014-06-12 04:19:00
1611	2014-06-12 04:20:00	2014-06-12 04:29:00
1612	2014-06-12 04:30:00	2014-06-12 04:39:00
1613	2014-06-12 04:40:00	2014-06-12 04:49:00
1614	2014-06-12 04:50:00	2014-06-12 04:59:00
1615	2014-06-12 05:00:00	2014-06-12 05:09:00
1616	2014-06-12 05:10:00	2014-06-12 05:19:00
1617	2014-06-12 05:20:00	2014-06-12 05:29:00
1618	2014-06-12 05:30:00	2014-06-12 05:39:00
1619	2014-06-12 05:40:00	2014-06-12 05:49:00
1620	2014-06-12 05:50:00	2014-06-12 05:59:00
1621	2014-06-12 06:00:00	2014-06-12 06:09:00
1622	2014-06-12 06:10:00	2014-06-12 06:19:00
1623	2014-06-12 06:20:00	2014-06-12 06:29:00
1624	2014-06-12 06:30:00	2014-06-12 06:39:00
1625	2014-06-12 06:40:00	2014-06-12 06:49:00
1626	2014-06-12 06:50:00	2014-06-12 06:59:00
1627	2014-06-12 07:00:00	2014-06-12 07:09:00
1628	2014-06-12 07:10:00	2014-06-12 07:19:00
1629	2014-06-12 07:20:00	2014-06-12 07:29:00
1630	2014-06-12 07:30:00	2014-06-12 07:39:00
1631	2014-06-12 07:40:00	2014-06-12 07:49:00
1632	2014-06-12 07:50:00	2014-06-12 07:59:00
1633	2014-06-12 08:00:00	2014-06-12 08:09:00
1634	2014-06-12 08:10:00	2014-06-12 08:19:00
1635	2014-06-12 08:20:00	2014-06-12 08:29:00
1636	2014-06-12 08:30:00	2014-06-12 08:39:00
1637	2014-06-12 08:40:00	2014-06-12 08:49:00
1638	2014-06-12 08:50:00	2014-06-12 08:59:00
1639	2014-06-12 09:00:00	2014-06-12 09:09:00
1640	2014-06-12 09:10:00	2014-06-12 09:19:00
1641	2014-06-12 09:20:00	2014-06-12 09:29:00
1642	2014-06-12 09:30:00	2014-06-12 09:39:00
1643	2014-06-12 09:40:00	2014-06-12 09:49:00
1644	2014-06-12 09:50:00	2014-06-12 09:59:00
1645	2014-06-12 10:00:00	2014-06-12 10:09:00
1646	2014-06-12 10:10:00	2014-06-12 10:19:00
1647	2014-06-12 10:20:00	2014-06-12 10:29:00
1648	2014-06-12 10:30:00	2014-06-12 10:39:00
1649	2014-06-12 10:40:00	2014-06-12 10:49:00
1650	2014-06-12 10:50:00	2014-06-12 10:59:00
1651	2014-06-12 11:00:00	2014-06-12 11:09:00
1652	2014-06-12 11:10:00	2014-06-12 11:19:00
1653	2014-06-12 11:20:00	2014-06-12 11:29:00
1654	2014-06-12 11:30:00	2014-06-12 11:39:00
1655	2014-06-12 11:40:00	2014-06-12 11:49:00
1656	2014-06-12 11:50:00	2014-06-12 11:59:00
1657	2014-06-12 12:00:00	2014-06-12 12:09:00
1658	2014-06-12 12:10:00	2014-06-12 12:19:00
1659	2014-06-12 12:20:00	2014-06-12 12:29:00
1660	2014-06-12 12:30:00	2014-06-12 12:39:00
1661	2014-06-12 12:40:00	2014-06-12 12:49:00
1662	2014-06-12 12:50:00	2014-06-12 12:59:00
1663	2014-06-12 13:00:00	2014-06-12 13:09:00
1664	2014-06-12 13:10:00	2014-06-12 13:19:00
1665	2014-06-12 13:20:00	2014-06-12 13:29:00
1666	2014-06-12 13:30:00	2014-06-12 13:39:00
1667	2014-06-12 13:40:00	2014-06-12 13:49:00
1668	2014-06-12 13:50:00	2014-06-12 13:59:00
1669	2014-06-12 14:00:00	2014-06-12 14:09:00
1670	2014-06-12 14:10:00	2014-06-12 14:19:00
1671	2014-06-12 14:20:00	2014-06-12 14:29:00
1672	2014-06-12 14:30:00	2014-06-12 14:39:00
1673	2014-06-12 14:40:00	2014-06-12 14:49:00
1674	2014-06-12 14:50:00	2014-06-12 14:59:00
1675	2014-06-12 15:00:00	2014-06-12 15:09:00
1676	2014-06-12 15:10:00	2014-06-12 15:19:00
1677	2014-06-12 15:20:00	2014-06-12 15:29:00
1678	2014-06-12 15:30:00	2014-06-12 15:39:00
1679	2014-06-12 15:40:00	2014-06-12 15:49:00
1680	2014-06-12 15:50:00	2014-06-12 15:59:00
1681	2014-06-12 16:00:00	2014-06-12 16:09:00
1682	2014-06-12 16:10:00	2014-06-12 16:19:00
1683	2014-06-12 16:20:00	2014-06-12 16:29:00
1684	2014-06-12 16:30:00	2014-06-12 16:39:00
1685	2014-06-12 16:40:00	2014-06-12 16:49:00
1686	2014-06-12 16:50:00	2014-06-12 16:59:00
1687	2014-06-12 17:00:00	2014-06-12 17:09:00
1688	2014-06-12 17:10:00	2014-06-12 17:19:00
1689	2014-06-12 17:20:00	2014-06-12 17:29:00
1690	2014-06-12 17:30:00	2014-06-12 17:39:00
1691	2014-06-12 17:40:00	2014-06-12 17:49:00
1692	2014-06-12 17:50:00	2014-06-12 17:59:00
1693	2014-06-12 18:00:00	2014-06-12 18:09:00
1694	2014-06-12 18:10:00	2014-06-12 18:19:00
1695	2014-06-12 18:20:00	2014-06-12 18:29:00
1696	2014-06-12 18:30:00	2014-06-12 18:39:00
1697	2014-06-12 18:40:00	2014-06-12 18:49:00
1698	2014-06-12 18:50:00	2014-06-12 18:59:00
1699	2014-06-12 19:00:00	2014-06-12 19:09:00
1700	2014-06-12 19:10:00	2014-06-12 19:19:00
1701	2014-06-12 19:20:00	2014-06-12 19:29:00
1702	2014-06-12 19:30:00	2014-06-12 19:39:00
1703	2014-06-12 19:40:00	2014-06-12 19:49:00
1704	2014-06-12 19:50:00	2014-06-12 19:59:00
1705	2014-06-12 20:00:00	2014-06-12 20:09:00
1706	2014-06-12 20:10:00	2014-06-12 20:19:00
1707	2014-06-12 20:20:00	2014-06-12 20:29:00
1708	2014-06-12 20:30:00	2014-06-12 20:39:00
1709	2014-06-12 20:40:00	2014-06-12 20:49:00
1710	2014-06-12 20:50:00	2014-06-12 20:59:00
1711	2014-06-12 21:00:00	2014-06-12 21:09:00
1712	2014-06-12 21:10:00	2014-06-12 21:19:00
1713	2014-06-12 21:20:00	2014-06-12 21:29:00
1714	2014-06-12 21:30:00	2014-06-12 21:39:00
1715	2014-06-12 21:40:00	2014-06-12 21:49:00
1716	2014-06-12 21:50:00	2014-06-12 21:59:00
1717	2014-06-12 22:00:00	2014-06-12 22:09:00
1718	2014-06-12 22:10:00	2014-06-12 22:19:00
1719	2014-06-12 22:20:00	2014-06-12 22:29:00
1720	2014-06-12 22:30:00	2014-06-12 22:39:00
1721	2014-06-12 22:40:00	2014-06-12 22:49:00
1722	2014-06-12 22:50:00	2014-06-12 22:59:00
1723	2014-06-12 23:00:00	2014-06-12 23:09:00
1724	2014-06-12 23:10:00	2014-06-12 23:19:00
1725	2014-06-12 23:20:00	2014-06-12 23:29:00
1726	2014-06-12 23:30:00	2014-06-12 23:39:00
1727	2014-06-12 23:40:00	2014-06-12 23:49:00
1728	2014-06-12 23:50:00	2014-06-12 23:59:00
1729	2014-06-13 00:00:00	2014-06-13 00:09:00
1730	2014-06-13 00:10:00	2014-06-13 00:19:00
1731	2014-06-13 00:20:00	2014-06-13 00:29:00
1732	2014-06-13 00:30:00	2014-06-13 00:39:00
1733	2014-06-13 00:40:00	2014-06-13 00:49:00
1734	2014-06-13 00:50:00	2014-06-13 00:59:00
1735	2014-06-13 01:00:00	2014-06-13 01:09:00
1736	2014-06-13 01:10:00	2014-06-13 01:19:00
1737	2014-06-13 01:20:00	2014-06-13 01:29:00
1738	2014-06-13 01:30:00	2014-06-13 01:39:00
1739	2014-06-13 01:40:00	2014-06-13 01:49:00
1740	2014-06-13 01:50:00	2014-06-13 01:59:00
1741	2014-06-13 02:00:00	2014-06-13 02:09:00
1742	2014-06-13 02:10:00	2014-06-13 02:19:00
1743	2014-06-13 02:20:00	2014-06-13 02:29:00
1744	2014-06-13 02:30:00	2014-06-13 02:39:00
1745	2014-06-13 02:40:00	2014-06-13 02:49:00
1746	2014-06-13 02:50:00	2014-06-13 02:59:00
1747	2014-06-13 03:00:00	2014-06-13 03:09:00
1748	2014-06-13 03:10:00	2014-06-13 03:19:00
1749	2014-06-13 03:20:00	2014-06-13 03:29:00
1750	2014-06-13 03:30:00	2014-06-13 03:39:00
1751	2014-06-13 03:40:00	2014-06-13 03:49:00
1752	2014-06-13 03:50:00	2014-06-13 03:59:00
1753	2014-06-13 04:00:00	2014-06-13 04:09:00
1754	2014-06-13 04:10:00	2014-06-13 04:19:00
1755	2014-06-13 04:20:00	2014-06-13 04:29:00
1756	2014-06-13 04:30:00	2014-06-13 04:39:00
1757	2014-06-13 04:40:00	2014-06-13 04:49:00
1758	2014-06-13 04:50:00	2014-06-13 04:59:00
1759	2014-06-13 05:00:00	2014-06-13 05:09:00
1760	2014-06-13 05:10:00	2014-06-13 05:19:00
1761	2014-06-13 05:20:00	2014-06-13 05:29:00
1762	2014-06-13 05:30:00	2014-06-13 05:39:00
1763	2014-06-13 05:40:00	2014-06-13 05:49:00
1764	2014-06-13 05:50:00	2014-06-13 05:59:00
1765	2014-06-13 06:00:00	2014-06-13 06:09:00
1766	2014-06-13 06:10:00	2014-06-13 06:19:00
1767	2014-06-13 06:20:00	2014-06-13 06:29:00
1768	2014-06-13 06:30:00	2014-06-13 06:39:00
1769	2014-06-13 06:40:00	2014-06-13 06:49:00
1770	2014-06-13 06:50:00	2014-06-13 06:59:00
1771	2014-06-13 07:00:00	2014-06-13 07:09:00
1772	2014-06-13 07:10:00	2014-06-13 07:19:00
1773	2014-06-13 07:20:00	2014-06-13 07:29:00
1774	2014-06-13 07:30:00	2014-06-13 07:39:00
1775	2014-06-13 07:40:00	2014-06-13 07:49:00
1776	2014-06-13 07:50:00	2014-06-13 07:59:00
1777	2014-06-13 08:00:00	2014-06-13 08:09:00
1778	2014-06-13 08:10:00	2014-06-13 08:19:00
1779	2014-06-13 08:20:00	2014-06-13 08:29:00
1780	2014-06-13 08:30:00	2014-06-13 08:39:00
1781	2014-06-13 08:40:00	2014-06-13 08:49:00
1782	2014-06-13 08:50:00	2014-06-13 08:59:00
1783	2014-06-13 09:00:00	2014-06-13 09:09:00
1784	2014-06-13 09:10:00	2014-06-13 09:19:00
1785	2014-06-13 09:20:00	2014-06-13 09:29:00
1786	2014-06-13 09:30:00	2014-06-13 09:39:00
1787	2014-06-13 09:40:00	2014-06-13 09:49:00
1788	2014-06-13 09:50:00	2014-06-13 09:59:00
1789	2014-06-13 10:00:00	2014-06-13 10:09:00
1790	2014-06-13 10:10:00	2014-06-13 10:19:00
1791	2014-06-13 10:20:00	2014-06-13 10:29:00
1792	2014-06-13 10:30:00	2014-06-13 10:39:00
1793	2014-06-13 10:40:00	2014-06-13 10:49:00
1794	2014-06-13 10:50:00	2014-06-13 10:59:00
1795	2014-06-13 11:00:00	2014-06-13 11:09:00
1796	2014-06-13 11:10:00	2014-06-13 11:19:00
1797	2014-06-13 11:20:00	2014-06-13 11:29:00
1798	2014-06-13 11:30:00	2014-06-13 11:39:00
1799	2014-06-13 11:40:00	2014-06-13 11:49:00
1800	2014-06-13 11:50:00	2014-06-13 11:59:00
1801	2014-06-13 12:00:00	2014-06-13 12:09:00
1802	2014-06-13 12:10:00	2014-06-13 12:19:00
1803	2014-06-13 12:20:00	2014-06-13 12:29:00
1804	2014-06-13 12:30:00	2014-06-13 12:39:00
1805	2014-06-13 12:40:00	2014-06-13 12:49:00
1806	2014-06-13 12:50:00	2014-06-13 12:59:00
1807	2014-06-13 13:00:00	2014-06-13 13:09:00
1808	2014-06-13 13:10:00	2014-06-13 13:19:00
1809	2014-06-13 13:20:00	2014-06-13 13:29:00
1810	2014-06-13 13:30:00	2014-06-13 13:39:00
1811	2014-06-13 13:40:00	2014-06-13 13:49:00
1812	2014-06-13 13:50:00	2014-06-13 13:59:00
1813	2014-06-13 14:00:00	2014-06-13 14:09:00
1814	2014-06-13 14:10:00	2014-06-13 14:19:00
1815	2014-06-13 14:20:00	2014-06-13 14:29:00
1816	2014-06-13 14:30:00	2014-06-13 14:39:00
1817	2014-06-13 14:40:00	2014-06-13 14:49:00
1818	2014-06-13 14:50:00	2014-06-13 14:59:00
1819	2014-06-13 15:00:00	2014-06-13 15:09:00
1820	2014-06-13 15:10:00	2014-06-13 15:19:00
1821	2014-06-13 15:20:00	2014-06-13 15:29:00
1822	2014-06-13 15:30:00	2014-06-13 15:39:00
1823	2014-06-13 15:40:00	2014-06-13 15:49:00
1824	2014-06-13 15:50:00	2014-06-13 15:59:00
1825	2014-06-13 16:00:00	2014-06-13 16:09:00
1826	2014-06-13 16:10:00	2014-06-13 16:19:00
1827	2014-06-13 16:20:00	2014-06-13 16:29:00
1828	2014-06-13 16:30:00	2014-06-13 16:39:00
1829	2014-06-13 16:40:00	2014-06-13 16:49:00
1830	2014-06-13 16:50:00	2014-06-13 16:59:00
1831	2014-06-13 17:00:00	2014-06-13 17:09:00
1832	2014-06-13 17:10:00	2014-06-13 17:19:00
1833	2014-06-13 17:20:00	2014-06-13 17:29:00
1834	2014-06-13 17:30:00	2014-06-13 17:39:00
1835	2014-06-13 17:40:00	2014-06-13 17:49:00
1836	2014-06-13 17:50:00	2014-06-13 17:59:00
1837	2014-06-13 18:00:00	2014-06-13 18:09:00
1838	2014-06-13 18:10:00	2014-06-13 18:19:00
1839	2014-06-13 18:20:00	2014-06-13 18:29:00
1840	2014-06-13 18:30:00	2014-06-13 18:39:00
1841	2014-06-13 18:40:00	2014-06-13 18:49:00
1842	2014-06-13 18:50:00	2014-06-13 18:59:00
1843	2014-06-13 19:00:00	2014-06-13 19:09:00
1844	2014-06-13 19:10:00	2014-06-13 19:19:00
1845	2014-06-13 19:20:00	2014-06-13 19:29:00
1846	2014-06-13 19:30:00	2014-06-13 19:39:00
1847	2014-06-13 19:40:00	2014-06-13 19:49:00
1848	2014-06-13 19:50:00	2014-06-13 19:59:00
1849	2014-06-13 20:00:00	2014-06-13 20:09:00
1850	2014-06-13 20:10:00	2014-06-13 20:19:00
1851	2014-06-13 20:20:00	2014-06-13 20:29:00
1852	2014-06-13 20:30:00	2014-06-13 20:39:00
1853	2014-06-13 20:40:00	2014-06-13 20:49:00
1854	2014-06-13 20:50:00	2014-06-13 20:59:00
1855	2014-06-13 21:00:00	2014-06-13 21:09:00
1856	2014-06-13 21:10:00	2014-06-13 21:19:00
1857	2014-06-13 21:20:00	2014-06-13 21:29:00
1858	2014-06-13 21:30:00	2014-06-13 21:39:00
1859	2014-06-13 21:40:00	2014-06-13 21:49:00
1860	2014-06-13 21:50:00	2014-06-13 21:59:00
1861	2014-06-13 22:00:00	2014-06-13 22:09:00
1862	2014-06-13 22:10:00	2014-06-13 22:19:00
1863	2014-06-13 22:20:00	2014-06-13 22:29:00
1864	2014-06-13 22:30:00	2014-06-13 22:39:00
1865	2014-06-13 22:40:00	2014-06-13 22:49:00
1866	2014-06-13 22:50:00	2014-06-13 22:59:00
1867	2014-06-13 23:00:00	2014-06-13 23:09:00
1868	2014-06-13 23:10:00	2014-06-13 23:19:00
1869	2014-06-13 23:20:00	2014-06-13 23:29:00
1870	2014-06-13 23:30:00	2014-06-13 23:39:00
1871	2014-06-13 23:40:00	2014-06-13 23:49:00
1872	2014-06-13 23:50:00	2014-06-13 23:59:00
1873	2014-06-14 00:00:00	2014-06-14 00:09:00
1874	2014-06-14 00:10:00	2014-06-14 00:19:00
1875	2014-06-14 00:20:00	2014-06-14 00:29:00
1876	2014-06-14 00:30:00	2014-06-14 00:39:00
1877	2014-06-14 00:40:00	2014-06-14 00:49:00
1878	2014-06-14 00:50:00	2014-06-14 00:59:00
1879	2014-06-14 01:00:00	2014-06-14 01:09:00
1880	2014-06-14 01:10:00	2014-06-14 01:19:00
1881	2014-06-14 01:20:00	2014-06-14 01:29:00
1882	2014-06-14 01:30:00	2014-06-14 01:39:00
1883	2014-06-14 01:40:00	2014-06-14 01:49:00
1884	2014-06-14 01:50:00	2014-06-14 01:59:00
1885	2014-06-14 02:00:00	2014-06-14 02:09:00
1886	2014-06-14 02:10:00	2014-06-14 02:19:00
1887	2014-06-14 02:20:00	2014-06-14 02:29:00
1888	2014-06-14 02:30:00	2014-06-14 02:39:00
1889	2014-06-14 02:40:00	2014-06-14 02:49:00
1890	2014-06-14 02:50:00	2014-06-14 02:59:00
1891	2014-06-14 03:00:00	2014-06-14 03:09:00
1892	2014-06-14 03:10:00	2014-06-14 03:19:00
1893	2014-06-14 03:20:00	2014-06-14 03:29:00
1894	2014-06-14 03:30:00	2014-06-14 03:39:00
1895	2014-06-14 03:40:00	2014-06-14 03:49:00
1896	2014-06-14 03:50:00	2014-06-14 03:59:00
1897	2014-06-14 04:00:00	2014-06-14 04:09:00
1898	2014-06-14 04:10:00	2014-06-14 04:19:00
1899	2014-06-14 04:20:00	2014-06-14 04:29:00
1900	2014-06-14 04:30:00	2014-06-14 04:39:00
1901	2014-06-14 04:40:00	2014-06-14 04:49:00
1902	2014-06-14 04:50:00	2014-06-14 04:59:00
1903	2014-06-14 05:00:00	2014-06-14 05:09:00
1904	2014-06-14 05:10:00	2014-06-14 05:19:00
1905	2014-06-14 05:20:00	2014-06-14 05:29:00
1906	2014-06-14 05:30:00	2014-06-14 05:39:00
1907	2014-06-14 05:40:00	2014-06-14 05:49:00
1908	2014-06-14 05:50:00	2014-06-14 05:59:00
1909	2014-06-14 06:00:00	2014-06-14 06:09:00
1910	2014-06-14 06:10:00	2014-06-14 06:19:00
1911	2014-06-14 06:20:00	2014-06-14 06:29:00
1912	2014-06-14 06:30:00	2014-06-14 06:39:00
1913	2014-06-14 06:40:00	2014-06-14 06:49:00
1914	2014-06-14 06:50:00	2014-06-14 06:59:00
1915	2014-06-14 07:00:00	2014-06-14 07:09:00
1916	2014-06-14 07:10:00	2014-06-14 07:19:00
1917	2014-06-14 07:20:00	2014-06-14 07:29:00
1918	2014-06-14 07:30:00	2014-06-14 07:39:00
1919	2014-06-14 07:40:00	2014-06-14 07:49:00
1920	2014-06-14 07:50:00	2014-06-14 07:59:00
1921	2014-06-14 08:00:00	2014-06-14 08:09:00
1922	2014-06-14 08:10:00	2014-06-14 08:19:00
1923	2014-06-14 08:20:00	2014-06-14 08:29:00
1924	2014-06-14 08:30:00	2014-06-14 08:39:00
1925	2014-06-14 08:40:00	2014-06-14 08:49:00
1926	2014-06-14 08:50:00	2014-06-14 08:59:00
1927	2014-06-14 09:00:00	2014-06-14 09:09:00
1928	2014-06-14 09:10:00	2014-06-14 09:19:00
1929	2014-06-14 09:20:00	2014-06-14 09:29:00
1930	2014-06-14 09:30:00	2014-06-14 09:39:00
1931	2014-06-14 09:40:00	2014-06-14 09:49:00
1932	2014-06-14 09:50:00	2014-06-14 09:59:00
1933	2014-06-14 10:00:00	2014-06-14 10:09:00
1934	2014-06-14 10:10:00	2014-06-14 10:19:00
1935	2014-06-14 10:20:00	2014-06-14 10:29:00
1936	2014-06-14 10:30:00	2014-06-14 10:39:00
1937	2014-06-14 10:40:00	2014-06-14 10:49:00
1938	2014-06-14 10:50:00	2014-06-14 10:59:00
1939	2014-06-14 11:00:00	2014-06-14 11:09:00
1940	2014-06-14 11:10:00	2014-06-14 11:19:00
1941	2014-06-14 11:20:00	2014-06-14 11:29:00
1942	2014-06-14 11:30:00	2014-06-14 11:39:00
1943	2014-06-14 11:40:00	2014-06-14 11:49:00
1944	2014-06-14 11:50:00	2014-06-14 11:59:00
1945	2014-06-14 12:00:00	2014-06-14 12:09:00
1946	2014-06-14 12:10:00	2014-06-14 12:19:00
1947	2014-06-14 12:20:00	2014-06-14 12:29:00
1948	2014-06-14 12:30:00	2014-06-14 12:39:00
1949	2014-06-14 12:40:00	2014-06-14 12:49:00
1950	2014-06-14 12:50:00	2014-06-14 12:59:00
1951	2014-06-14 13:00:00	2014-06-14 13:09:00
1952	2014-06-14 13:10:00	2014-06-14 13:19:00
1953	2014-06-14 13:20:00	2014-06-14 13:29:00
1954	2014-06-14 13:30:00	2014-06-14 13:39:00
1955	2014-06-14 13:40:00	2014-06-14 13:49:00
1956	2014-06-14 13:50:00	2014-06-14 13:59:00
1957	2014-06-14 14:00:00	2014-06-14 14:09:00
1958	2014-06-14 14:10:00	2014-06-14 14:19:00
1959	2014-06-14 14:20:00	2014-06-14 14:29:00
1960	2014-06-14 14:30:00	2014-06-14 14:39:00
1961	2014-06-14 14:40:00	2014-06-14 14:49:00
1962	2014-06-14 14:50:00	2014-06-14 14:59:00
1963	2014-06-14 15:00:00	2014-06-14 15:09:00
1964	2014-06-14 15:10:00	2014-06-14 15:19:00
1965	2014-06-14 15:20:00	2014-06-14 15:29:00
1966	2014-06-14 15:30:00	2014-06-14 15:39:00
1967	2014-06-14 15:40:00	2014-06-14 15:49:00
1968	2014-06-14 15:50:00	2014-06-14 15:59:00
1969	2014-06-14 16:00:00	2014-06-14 16:09:00
1970	2014-06-14 16:10:00	2014-06-14 16:19:00
1971	2014-06-14 16:20:00	2014-06-14 16:29:00
1972	2014-06-14 16:30:00	2014-06-14 16:39:00
1973	2014-06-14 16:40:00	2014-06-14 16:49:00
1974	2014-06-14 16:50:00	2014-06-14 16:59:00
1975	2014-06-14 17:00:00	2014-06-14 17:09:00
1976	2014-06-14 17:10:00	2014-06-14 17:19:00
1977	2014-06-14 17:20:00	2014-06-14 17:29:00
1978	2014-06-14 17:30:00	2014-06-14 17:39:00
1979	2014-06-14 17:40:00	2014-06-14 17:49:00
1980	2014-06-14 17:50:00	2014-06-14 17:59:00
1981	2014-06-14 18:00:00	2014-06-14 18:09:00
1982	2014-06-14 18:10:00	2014-06-14 18:19:00
1983	2014-06-14 18:20:00	2014-06-14 18:29:00
1984	2014-06-14 18:30:00	2014-06-14 18:39:00
1985	2014-06-14 18:40:00	2014-06-14 18:49:00
1986	2014-06-14 18:50:00	2014-06-14 18:59:00
1987	2014-06-14 19:00:00	2014-06-14 19:09:00
1988	2014-06-14 19:10:00	2014-06-14 19:19:00
1989	2014-06-14 19:20:00	2014-06-14 19:29:00
1990	2014-06-14 19:30:00	2014-06-14 19:39:00
1991	2014-06-14 19:40:00	2014-06-14 19:49:00
1992	2014-06-14 19:50:00	2014-06-14 19:59:00
1993	2014-06-14 20:00:00	2014-06-14 20:09:00
1994	2014-06-14 20:10:00	2014-06-14 20:19:00
1995	2014-06-14 20:20:00	2014-06-14 20:29:00
1996	2014-06-14 20:30:00	2014-06-14 20:39:00
1997	2014-06-14 20:40:00	2014-06-14 20:49:00
1998	2014-06-14 20:50:00	2014-06-14 20:59:00
1999	2014-06-14 21:00:00	2014-06-14 21:09:00
2000	2014-06-14 21:10:00	2014-06-14 21:19:00
2001	2014-06-14 21:20:00	2014-06-14 21:29:00
2002	2014-06-14 21:30:00	2014-06-14 21:39:00
2003	2014-06-14 21:40:00	2014-06-14 21:49:00
2004	2014-06-14 21:50:00	2014-06-14 21:59:00
2005	2014-06-14 22:00:00	2014-06-14 22:09:00
2006	2014-06-14 22:10:00	2014-06-14 22:19:00
2007	2014-06-14 22:20:00	2014-06-14 22:29:00
2008	2014-06-14 22:30:00	2014-06-14 22:39:00
2009	2014-06-14 22:40:00	2014-06-14 22:49:00
2010	2014-06-14 22:50:00	2014-06-14 22:59:00
2011	2014-06-14 23:00:00	2014-06-14 23:09:00
2012	2014-06-14 23:10:00	2014-06-14 23:19:00
2013	2014-06-14 23:20:00	2014-06-14 23:29:00
2014	2014-06-14 23:30:00	2014-06-14 23:39:00
2015	2014-06-14 23:40:00	2014-06-14 23:49:00
2016	2014-06-14 23:50:00	2014-06-14 23:59:00
2017	2014-06-15 00:00:00	2014-06-15 00:09:00
2018	2014-06-15 00:10:00	2014-06-15 00:19:00
2019	2014-06-15 00:20:00	2014-06-15 00:29:00
2020	2014-06-15 00:30:00	2014-06-15 00:39:00
2021	2014-06-15 00:40:00	2014-06-15 00:49:00
2022	2014-06-15 00:50:00	2014-06-15 00:59:00
2023	2014-06-15 01:00:00	2014-06-15 01:09:00
2024	2014-06-15 01:10:00	2014-06-15 01:19:00
2025	2014-06-15 01:20:00	2014-06-15 01:29:00
2026	2014-06-15 01:30:00	2014-06-15 01:39:00
2027	2014-06-15 01:40:00	2014-06-15 01:49:00
2028	2014-06-15 01:50:00	2014-06-15 01:59:00
2029	2014-06-15 02:00:00	2014-06-15 02:09:00
2030	2014-06-15 02:10:00	2014-06-15 02:19:00
2031	2014-06-15 02:20:00	2014-06-15 02:29:00
2032	2014-06-15 02:30:00	2014-06-15 02:39:00
2033	2014-06-15 02:40:00	2014-06-15 02:49:00
2034	2014-06-15 02:50:00	2014-06-15 02:59:00
2035	2014-06-15 03:00:00	2014-06-15 03:09:00
2036	2014-06-15 03:10:00	2014-06-15 03:19:00
2037	2014-06-15 03:20:00	2014-06-15 03:29:00
2038	2014-06-15 03:30:00	2014-06-15 03:39:00
2039	2014-06-15 03:40:00	2014-06-15 03:49:00
2040	2014-06-15 03:50:00	2014-06-15 03:59:00
2041	2014-06-15 04:00:00	2014-06-15 04:09:00
2042	2014-06-15 04:10:00	2014-06-15 04:19:00
2043	2014-06-15 04:20:00	2014-06-15 04:29:00
2044	2014-06-15 04:30:00	2014-06-15 04:39:00
2045	2014-06-15 04:40:00	2014-06-15 04:49:00
2046	2014-06-15 04:50:00	2014-06-15 04:59:00
2047	2014-06-15 05:00:00	2014-06-15 05:09:00
2048	2014-06-15 05:10:00	2014-06-15 05:19:00
2049	2014-06-15 05:20:00	2014-06-15 05:29:00
2050	2014-06-15 05:30:00	2014-06-15 05:39:00
2051	2014-06-15 05:40:00	2014-06-15 05:49:00
2052	2014-06-15 05:50:00	2014-06-15 05:59:00
2053	2014-06-15 06:00:00	2014-06-15 06:09:00
2054	2014-06-15 06:10:00	2014-06-15 06:19:00
2055	2014-06-15 06:20:00	2014-06-15 06:29:00
2056	2014-06-15 06:30:00	2014-06-15 06:39:00
2057	2014-06-15 06:40:00	2014-06-15 06:49:00
2058	2014-06-15 06:50:00	2014-06-15 06:59:00
2059	2014-06-15 07:00:00	2014-06-15 07:09:00
2060	2014-06-15 07:10:00	2014-06-15 07:19:00
2061	2014-06-15 07:20:00	2014-06-15 07:29:00
2062	2014-06-15 07:30:00	2014-06-15 07:39:00
2063	2014-06-15 07:40:00	2014-06-15 07:49:00
2064	2014-06-15 07:50:00	2014-06-15 07:59:00
2065	2014-06-15 08:00:00	2014-06-15 08:09:00
2066	2014-06-15 08:10:00	2014-06-15 08:19:00
2067	2014-06-15 08:20:00	2014-06-15 08:29:00
2068	2014-06-15 08:30:00	2014-06-15 08:39:00
2069	2014-06-15 08:40:00	2014-06-15 08:49:00
2070	2014-06-15 08:50:00	2014-06-15 08:59:00
2071	2014-06-15 09:00:00	2014-06-15 09:09:00
2072	2014-06-15 09:10:00	2014-06-15 09:19:00
2073	2014-06-15 09:20:00	2014-06-15 09:29:00
2074	2014-06-15 09:30:00	2014-06-15 09:39:00
2075	2014-06-15 09:40:00	2014-06-15 09:49:00
2076	2014-06-15 09:50:00	2014-06-15 09:59:00
2077	2014-06-15 10:00:00	2014-06-15 10:09:00
2078	2014-06-15 10:10:00	2014-06-15 10:19:00
2079	2014-06-15 10:20:00	2014-06-15 10:29:00
2080	2014-06-15 10:30:00	2014-06-15 10:39:00
2081	2014-06-15 10:40:00	2014-06-15 10:49:00
2082	2014-06-15 10:50:00	2014-06-15 10:59:00
2083	2014-06-15 11:00:00	2014-06-15 11:09:00
2084	2014-06-15 11:10:00	2014-06-15 11:19:00
2085	2014-06-15 11:20:00	2014-06-15 11:29:00
2086	2014-06-15 11:30:00	2014-06-15 11:39:00
2087	2014-06-15 11:40:00	2014-06-15 11:49:00
2088	2014-06-15 11:50:00	2014-06-15 11:59:00
2089	2014-06-15 12:00:00	2014-06-15 12:09:00
2090	2014-06-15 12:10:00	2014-06-15 12:19:00
2091	2014-06-15 12:20:00	2014-06-15 12:29:00
2092	2014-06-15 12:30:00	2014-06-15 12:39:00
2093	2014-06-15 12:40:00	2014-06-15 12:49:00
2094	2014-06-15 12:50:00	2014-06-15 12:59:00
2095	2014-06-15 13:00:00	2014-06-15 13:09:00
2096	2014-06-15 13:10:00	2014-06-15 13:19:00
2097	2014-06-15 13:20:00	2014-06-15 13:29:00
2098	2014-06-15 13:30:00	2014-06-15 13:39:00
2099	2014-06-15 13:40:00	2014-06-15 13:49:00
2100	2014-06-15 13:50:00	2014-06-15 13:59:00
2101	2014-06-15 14:00:00	2014-06-15 14:09:00
2102	2014-06-15 14:10:00	2014-06-15 14:19:00
2103	2014-06-15 14:20:00	2014-06-15 14:29:00
2104	2014-06-15 14:30:00	2014-06-15 14:39:00
2105	2014-06-15 14:40:00	2014-06-15 14:49:00
2106	2014-06-15 14:50:00	2014-06-15 14:59:00
2107	2014-06-15 15:00:00	2014-06-15 15:09:00
2108	2014-06-15 15:10:00	2014-06-15 15:19:00
2109	2014-06-15 15:20:00	2014-06-15 15:29:00
2110	2014-06-15 15:30:00	2014-06-15 15:39:00
2111	2014-06-15 15:40:00	2014-06-15 15:49:00
2112	2014-06-15 15:50:00	2014-06-15 15:59:00
2113	2014-06-15 16:00:00	2014-06-15 16:09:00
2114	2014-06-15 16:10:00	2014-06-15 16:19:00
2115	2014-06-15 16:20:00	2014-06-15 16:29:00
2116	2014-06-15 16:30:00	2014-06-15 16:39:00
2117	2014-06-15 16:40:00	2014-06-15 16:49:00
2118	2014-06-15 16:50:00	2014-06-15 16:59:00
2119	2014-06-15 17:00:00	2014-06-15 17:09:00
2120	2014-06-15 17:10:00	2014-06-15 17:19:00
2121	2014-06-15 17:20:00	2014-06-15 17:29:00
2122	2014-06-15 17:30:00	2014-06-15 17:39:00
2123	2014-06-15 17:40:00	2014-06-15 17:49:00
2124	2014-06-15 17:50:00	2014-06-15 17:59:00
2125	2014-06-15 18:00:00	2014-06-15 18:09:00
2126	2014-06-15 18:10:00	2014-06-15 18:19:00
2127	2014-06-15 18:20:00	2014-06-15 18:29:00
2128	2014-06-15 18:30:00	2014-06-15 18:39:00
2129	2014-06-15 18:40:00	2014-06-15 18:49:00
2130	2014-06-15 18:50:00	2014-06-15 18:59:00
2131	2014-06-15 19:00:00	2014-06-15 19:09:00
2132	2014-06-15 19:10:00	2014-06-15 19:19:00
2133	2014-06-15 19:20:00	2014-06-15 19:29:00
2134	2014-06-15 19:30:00	2014-06-15 19:39:00
2135	2014-06-15 19:40:00	2014-06-15 19:49:00
2136	2014-06-15 19:50:00	2014-06-15 19:59:00
2137	2014-06-15 20:00:00	2014-06-15 20:09:00
2138	2014-06-15 20:10:00	2014-06-15 20:19:00
2139	2014-06-15 20:20:00	2014-06-15 20:29:00
2140	2014-06-15 20:30:00	2014-06-15 20:39:00
2141	2014-06-15 20:40:00	2014-06-15 20:49:00
2142	2014-06-15 20:50:00	2014-06-15 20:59:00
2143	2014-06-15 21:00:00	2014-06-15 21:09:00
2144	2014-06-15 21:10:00	2014-06-15 21:19:00
2145	2014-06-15 21:20:00	2014-06-15 21:29:00
2146	2014-06-15 21:30:00	2014-06-15 21:39:00
2147	2014-06-15 21:40:00	2014-06-15 21:49:00
2148	2014-06-15 21:50:00	2014-06-15 21:59:00
2149	2014-06-15 22:00:00	2014-06-15 22:09:00
2150	2014-06-15 22:10:00	2014-06-15 22:19:00
2151	2014-06-15 22:20:00	2014-06-15 22:29:00
2152	2014-06-15 22:30:00	2014-06-15 22:39:00
2153	2014-06-15 22:40:00	2014-06-15 22:49:00
2154	2014-06-15 22:50:00	2014-06-15 22:59:00
2155	2014-06-15 23:00:00	2014-06-15 23:09:00
2156	2014-06-15 23:10:00	2014-06-15 23:19:00
2157	2014-06-15 23:20:00	2014-06-15 23:29:00
2158	2014-06-15 23:30:00	2014-06-15 23:39:00
2159	2014-06-15 23:40:00	2014-06-15 23:49:00
2160	2014-06-15 23:50:00	2014-06-15 23:59:00
2161	2014-06-16 00:00:00	2014-06-16 00:09:00
2162	2014-06-16 00:10:00	2014-06-16 00:19:00
2163	2014-06-16 00:20:00	2014-06-16 00:29:00
2164	2014-06-16 00:30:00	2014-06-16 00:39:00
2165	2014-06-16 00:40:00	2014-06-16 00:49:00
2166	2014-06-16 00:50:00	2014-06-16 00:59:00
2167	2014-06-16 01:00:00	2014-06-16 01:09:00
2168	2014-06-16 01:10:00	2014-06-16 01:19:00
2169	2014-06-16 01:20:00	2014-06-16 01:29:00
2170	2014-06-16 01:30:00	2014-06-16 01:39:00
2171	2014-06-16 01:40:00	2014-06-16 01:49:00
2172	2014-06-16 01:50:00	2014-06-16 01:59:00
2173	2014-06-16 02:00:00	2014-06-16 02:09:00
2174	2014-06-16 02:10:00	2014-06-16 02:19:00
2175	2014-06-16 02:20:00	2014-06-16 02:29:00
2176	2014-06-16 02:30:00	2014-06-16 02:39:00
2177	2014-06-16 02:40:00	2014-06-16 02:49:00
2178	2014-06-16 02:50:00	2014-06-16 02:59:00
2179	2014-06-16 03:00:00	2014-06-16 03:09:00
2180	2014-06-16 03:10:00	2014-06-16 03:19:00
2181	2014-06-16 03:20:00	2014-06-16 03:29:00
2182	2014-06-16 03:30:00	2014-06-16 03:39:00
2183	2014-06-16 03:40:00	2014-06-16 03:49:00
2184	2014-06-16 03:50:00	2014-06-16 03:59:00
2185	2014-06-16 04:00:00	2014-06-16 04:09:00
2186	2014-06-16 04:10:00	2014-06-16 04:19:00
2187	2014-06-16 04:20:00	2014-06-16 04:29:00
2188	2014-06-16 04:30:00	2014-06-16 04:39:00
2189	2014-06-16 04:40:00	2014-06-16 04:49:00
2190	2014-06-16 04:50:00	2014-06-16 04:59:00
2191	2014-06-16 05:00:00	2014-06-16 05:09:00
2192	2014-06-16 05:10:00	2014-06-16 05:19:00
2193	2014-06-16 05:20:00	2014-06-16 05:29:00
2194	2014-06-16 05:30:00	2014-06-16 05:39:00
2195	2014-06-16 05:40:00	2014-06-16 05:49:00
2196	2014-06-16 05:50:00	2014-06-16 05:59:00
2197	2014-06-16 06:00:00	2014-06-16 06:09:00
2198	2014-06-16 06:10:00	2014-06-16 06:19:00
2199	2014-06-16 06:20:00	2014-06-16 06:29:00
2200	2014-06-16 06:30:00	2014-06-16 06:39:00
2201	2014-06-16 06:40:00	2014-06-16 06:49:00
2202	2014-06-16 06:50:00	2014-06-16 06:59:00
2203	2014-06-16 07:00:00	2014-06-16 07:09:00
2204	2014-06-16 07:10:00	2014-06-16 07:19:00
2205	2014-06-16 07:20:00	2014-06-16 07:29:00
2206	2014-06-16 07:30:00	2014-06-16 07:39:00
2207	2014-06-16 07:40:00	2014-06-16 07:49:00
2208	2014-06-16 07:50:00	2014-06-16 07:59:00
2209	2014-06-16 08:00:00	2014-06-16 08:09:00
2210	2014-06-16 08:10:00	2014-06-16 08:19:00
2211	2014-06-16 08:20:00	2014-06-16 08:29:00
2212	2014-06-16 08:30:00	2014-06-16 08:39:00
2213	2014-06-16 08:40:00	2014-06-16 08:49:00
2214	2014-06-16 08:50:00	2014-06-16 08:59:00
2215	2014-06-16 09:00:00	2014-06-16 09:09:00
2216	2014-06-16 09:10:00	2014-06-16 09:19:00
2217	2014-06-16 09:20:00	2014-06-16 09:29:00
2218	2014-06-16 09:30:00	2014-06-16 09:39:00
2219	2014-06-16 09:40:00	2014-06-16 09:49:00
2220	2014-06-16 09:50:00	2014-06-16 09:59:00
2221	2014-06-16 10:00:00	2014-06-16 10:09:00
2222	2014-06-16 10:10:00	2014-06-16 10:19:00
2223	2014-06-16 10:20:00	2014-06-16 10:29:00
2224	2014-06-16 10:30:00	2014-06-16 10:39:00
2225	2014-06-16 10:40:00	2014-06-16 10:49:00
2226	2014-06-16 10:50:00	2014-06-16 10:59:00
2227	2014-06-16 11:00:00	2014-06-16 11:09:00
2228	2014-06-16 11:10:00	2014-06-16 11:19:00
2229	2014-06-16 11:20:00	2014-06-16 11:29:00
2230	2014-06-16 11:30:00	2014-06-16 11:39:00
2231	2014-06-16 11:40:00	2014-06-16 11:49:00
2232	2014-06-16 11:50:00	2014-06-16 11:59:00
2233	2014-06-16 12:00:00	2014-06-16 12:09:00
2234	2014-06-16 12:10:00	2014-06-16 12:19:00
2235	2014-06-16 12:20:00	2014-06-16 12:29:00
2236	2014-06-16 12:30:00	2014-06-16 12:39:00
2237	2014-06-16 12:40:00	2014-06-16 12:49:00
2238	2014-06-16 12:50:00	2014-06-16 12:59:00
2239	2014-06-16 13:00:00	2014-06-16 13:09:00
2240	2014-06-16 13:10:00	2014-06-16 13:19:00
2241	2014-06-16 13:20:00	2014-06-16 13:29:00
2242	2014-06-16 13:30:00	2014-06-16 13:39:00
2243	2014-06-16 13:40:00	2014-06-16 13:49:00
2244	2014-06-16 13:50:00	2014-06-16 13:59:00
2245	2014-06-16 14:00:00	2014-06-16 14:09:00
2246	2014-06-16 14:10:00	2014-06-16 14:19:00
2247	2014-06-16 14:20:00	2014-06-16 14:29:00
2248	2014-06-16 14:30:00	2014-06-16 14:39:00
2249	2014-06-16 14:40:00	2014-06-16 14:49:00
2250	2014-06-16 14:50:00	2014-06-16 14:59:00
2251	2014-06-16 15:00:00	2014-06-16 15:09:00
2252	2014-06-16 15:10:00	2014-06-16 15:19:00
2253	2014-06-16 15:20:00	2014-06-16 15:29:00
2254	2014-06-16 15:30:00	2014-06-16 15:39:00
2255	2014-06-16 15:40:00	2014-06-16 15:49:00
2256	2014-06-16 15:50:00	2014-06-16 15:59:00
2257	2014-06-16 16:00:00	2014-06-16 16:09:00
2258	2014-06-16 16:10:00	2014-06-16 16:19:00
2259	2014-06-16 16:20:00	2014-06-16 16:29:00
2260	2014-06-16 16:30:00	2014-06-16 16:39:00
2261	2014-06-16 16:40:00	2014-06-16 16:49:00
2262	2014-06-16 16:50:00	2014-06-16 16:59:00
2263	2014-06-16 17:00:00	2014-06-16 17:09:00
2264	2014-06-16 17:10:00	2014-06-16 17:19:00
2265	2014-06-16 17:20:00	2014-06-16 17:29:00
2266	2014-06-16 17:30:00	2014-06-16 17:39:00
2267	2014-06-16 17:40:00	2014-06-16 17:49:00
2268	2014-06-16 17:50:00	2014-06-16 17:59:00
2269	2014-06-16 18:00:00	2014-06-16 18:09:00
2270	2014-06-16 18:10:00	2014-06-16 18:19:00
2271	2014-06-16 18:20:00	2014-06-16 18:29:00
2272	2014-06-16 18:30:00	2014-06-16 18:39:00
2273	2014-06-16 18:40:00	2014-06-16 18:49:00
2274	2014-06-16 18:50:00	2014-06-16 18:59:00
2275	2014-06-16 19:00:00	2014-06-16 19:09:00
2276	2014-06-16 19:10:00	2014-06-16 19:19:00
2277	2014-06-16 19:20:00	2014-06-16 19:29:00
2278	2014-06-16 19:30:00	2014-06-16 19:39:00
2279	2014-06-16 19:40:00	2014-06-16 19:49:00
2280	2014-06-16 19:50:00	2014-06-16 19:59:00
2281	2014-06-16 20:00:00	2014-06-16 20:09:00
2282	2014-06-16 20:10:00	2014-06-16 20:19:00
2283	2014-06-16 20:20:00	2014-06-16 20:29:00
2284	2014-06-16 20:30:00	2014-06-16 20:39:00
2285	2014-06-16 20:40:00	2014-06-16 20:49:00
2286	2014-06-16 20:50:00	2014-06-16 20:59:00
2287	2014-06-16 21:00:00	2014-06-16 21:09:00
2288	2014-06-16 21:10:00	2014-06-16 21:19:00
2289	2014-06-16 21:20:00	2014-06-16 21:29:00
2290	2014-06-16 21:30:00	2014-06-16 21:39:00
2291	2014-06-16 21:40:00	2014-06-16 21:49:00
2292	2014-06-16 21:50:00	2014-06-16 21:59:00
2293	2014-06-16 22:00:00	2014-06-16 22:09:00
2294	2014-06-16 22:10:00	2014-06-16 22:19:00
2295	2014-06-16 22:20:00	2014-06-16 22:29:00
2296	2014-06-16 22:30:00	2014-06-16 22:39:00
2297	2014-06-16 22:40:00	2014-06-16 22:49:00
2298	2014-06-16 22:50:00	2014-06-16 22:59:00
2299	2014-06-16 23:00:00	2014-06-16 23:09:00
2300	2014-06-16 23:10:00	2014-06-16 23:19:00
2301	2014-06-16 23:20:00	2014-06-16 23:29:00
2302	2014-06-16 23:30:00	2014-06-16 23:39:00
2303	2014-06-16 23:40:00	2014-06-16 23:49:00
2304	2014-06-16 23:50:00	2014-06-16 23:59:00
2305	2014-06-17 00:00:00	2014-06-17 00:09:00
2306	2014-06-17 00:10:00	2014-06-17 00:19:00
2307	2014-06-17 00:20:00	2014-06-17 00:29:00
2308	2014-06-17 00:30:00	2014-06-17 00:39:00
2309	2014-06-17 00:40:00	2014-06-17 00:49:00
2310	2014-06-17 00:50:00	2014-06-17 00:59:00
2311	2014-06-17 01:00:00	2014-06-17 01:09:00
2312	2014-06-17 01:10:00	2014-06-17 01:19:00
2313	2014-06-17 01:20:00	2014-06-17 01:29:00
2314	2014-06-17 01:30:00	2014-06-17 01:39:00
2315	2014-06-17 01:40:00	2014-06-17 01:49:00
2316	2014-06-17 01:50:00	2014-06-17 01:59:00
2317	2014-06-17 02:00:00	2014-06-17 02:09:00
2318	2014-06-17 02:10:00	2014-06-17 02:19:00
2319	2014-06-17 02:20:00	2014-06-17 02:29:00
2320	2014-06-17 02:30:00	2014-06-17 02:39:00
2321	2014-06-17 02:40:00	2014-06-17 02:49:00
2322	2014-06-17 02:50:00	2014-06-17 02:59:00
2323	2014-06-17 03:00:00	2014-06-17 03:09:00
2324	2014-06-17 03:10:00	2014-06-17 03:19:00
2325	2014-06-17 03:20:00	2014-06-17 03:29:00
2326	2014-06-17 03:30:00	2014-06-17 03:39:00
2327	2014-06-17 03:40:00	2014-06-17 03:49:00
2328	2014-06-17 03:50:00	2014-06-17 03:59:00
2329	2014-06-17 04:00:00	2014-06-17 04:09:00
2330	2014-06-17 04:10:00	2014-06-17 04:19:00
2331	2014-06-17 04:20:00	2014-06-17 04:29:00
2332	2014-06-17 04:30:00	2014-06-17 04:39:00
2333	2014-06-17 04:40:00	2014-06-17 04:49:00
2334	2014-06-17 04:50:00	2014-06-17 04:59:00
2335	2014-06-17 05:00:00	2014-06-17 05:09:00
2336	2014-06-17 05:10:00	2014-06-17 05:19:00
2337	2014-06-17 05:20:00	2014-06-17 05:29:00
2338	2014-06-17 05:30:00	2014-06-17 05:39:00
2339	2014-06-17 05:40:00	2014-06-17 05:49:00
2340	2014-06-17 05:50:00	2014-06-17 05:59:00
2341	2014-06-17 06:00:00	2014-06-17 06:09:00
2342	2014-06-17 06:10:00	2014-06-17 06:19:00
2343	2014-06-17 06:20:00	2014-06-17 06:29:00
2344	2014-06-17 06:30:00	2014-06-17 06:39:00
2345	2014-06-17 06:40:00	2014-06-17 06:49:00
2346	2014-06-17 06:50:00	2014-06-17 06:59:00
2347	2014-06-17 07:00:00	2014-06-17 07:09:00
2348	2014-06-17 07:10:00	2014-06-17 07:19:00
2349	2014-06-17 07:20:00	2014-06-17 07:29:00
2350	2014-06-17 07:30:00	2014-06-17 07:39:00
2351	2014-06-17 07:40:00	2014-06-17 07:49:00
2352	2014-06-17 07:50:00	2014-06-17 07:59:00
2353	2014-06-17 08:00:00	2014-06-17 08:09:00
2354	2014-06-17 08:10:00	2014-06-17 08:19:00
2355	2014-06-17 08:20:00	2014-06-17 08:29:00
2356	2014-06-17 08:30:00	2014-06-17 08:39:00
2357	2014-06-17 08:40:00	2014-06-17 08:49:00
2358	2014-06-17 08:50:00	2014-06-17 08:59:00
2359	2014-06-17 09:00:00	2014-06-17 09:09:00
2360	2014-06-17 09:10:00	2014-06-17 09:19:00
2361	2014-06-17 09:20:00	2014-06-17 09:29:00
2362	2014-06-17 09:30:00	2014-06-17 09:39:00
2363	2014-06-17 09:40:00	2014-06-17 09:49:00
2364	2014-06-17 09:50:00	2014-06-17 09:59:00
2365	2014-06-17 10:00:00	2014-06-17 10:09:00
2366	2014-06-17 10:10:00	2014-06-17 10:19:00
2367	2014-06-17 10:20:00	2014-06-17 10:29:00
2368	2014-06-17 10:30:00	2014-06-17 10:39:00
2369	2014-06-17 10:40:00	2014-06-17 10:49:00
2370	2014-06-17 10:50:00	2014-06-17 10:59:00
2371	2014-06-17 11:00:00	2014-06-17 11:09:00
2372	2014-06-17 11:10:00	2014-06-17 11:19:00
2373	2014-06-17 11:20:00	2014-06-17 11:29:00
2374	2014-06-17 11:30:00	2014-06-17 11:39:00
2375	2014-06-17 11:40:00	2014-06-17 11:49:00
2376	2014-06-17 11:50:00	2014-06-17 11:59:00
2377	2014-06-17 12:00:00	2014-06-17 12:09:00
2378	2014-06-17 12:10:00	2014-06-17 12:19:00
2379	2014-06-17 12:20:00	2014-06-17 12:29:00
2380	2014-06-17 12:30:00	2014-06-17 12:39:00
2381	2014-06-17 12:40:00	2014-06-17 12:49:00
2382	2014-06-17 12:50:00	2014-06-17 12:59:00
2383	2014-06-17 13:00:00	2014-06-17 13:09:00
2384	2014-06-17 13:10:00	2014-06-17 13:19:00
2385	2014-06-17 13:20:00	2014-06-17 13:29:00
2386	2014-06-17 13:30:00	2014-06-17 13:39:00
2387	2014-06-17 13:40:00	2014-06-17 13:49:00
2388	2014-06-17 13:50:00	2014-06-17 13:59:00
2389	2014-06-17 14:00:00	2014-06-17 14:09:00
2390	2014-06-17 14:10:00	2014-06-17 14:19:00
2391	2014-06-17 14:20:00	2014-06-17 14:29:00
2392	2014-06-17 14:30:00	2014-06-17 14:39:00
2393	2014-06-17 14:40:00	2014-06-17 14:49:00
2394	2014-06-17 14:50:00	2014-06-17 14:59:00
2395	2014-06-17 15:00:00	2014-06-17 15:09:00
2396	2014-06-17 15:10:00	2014-06-17 15:19:00
2397	2014-06-17 15:20:00	2014-06-17 15:29:00
2398	2014-06-17 15:30:00	2014-06-17 15:39:00
2399	2014-06-17 15:40:00	2014-06-17 15:49:00
2400	2014-06-17 15:50:00	2014-06-17 15:59:00
2401	2014-06-17 16:00:00	2014-06-17 16:09:00
2402	2014-06-17 16:10:00	2014-06-17 16:19:00
2403	2014-06-17 16:20:00	2014-06-17 16:29:00
2404	2014-06-17 16:30:00	2014-06-17 16:39:00
2405	2014-06-17 16:40:00	2014-06-17 16:49:00
2406	2014-06-17 16:50:00	2014-06-17 16:59:00
2407	2014-06-17 17:00:00	2014-06-17 17:09:00
2408	2014-06-17 17:10:00	2014-06-17 17:19:00
2409	2014-06-17 17:20:00	2014-06-17 17:29:00
2410	2014-06-17 17:30:00	2014-06-17 17:39:00
2411	2014-06-17 17:40:00	2014-06-17 17:49:00
2412	2014-06-17 17:50:00	2014-06-17 17:59:00
2413	2014-06-17 18:00:00	2014-06-17 18:09:00
2414	2014-06-17 18:10:00	2014-06-17 18:19:00
2415	2014-06-17 18:20:00	2014-06-17 18:29:00
2416	2014-06-17 18:30:00	2014-06-17 18:39:00
2417	2014-06-17 18:40:00	2014-06-17 18:49:00
2418	2014-06-17 18:50:00	2014-06-17 18:59:00
2419	2014-06-17 19:00:00	2014-06-17 19:09:00
2420	2014-06-17 19:10:00	2014-06-17 19:19:00
2421	2014-06-17 19:20:00	2014-06-17 19:29:00
2422	2014-06-17 19:30:00	2014-06-17 19:39:00
2423	2014-06-17 19:40:00	2014-06-17 19:49:00
2424	2014-06-17 19:50:00	2014-06-17 19:59:00
2425	2014-06-17 20:00:00	2014-06-17 20:09:00
2426	2014-06-17 20:10:00	2014-06-17 20:19:00
2427	2014-06-17 20:20:00	2014-06-17 20:29:00
2428	2014-06-17 20:30:00	2014-06-17 20:39:00
2429	2014-06-17 20:40:00	2014-06-17 20:49:00
2430	2014-06-17 20:50:00	2014-06-17 20:59:00
2431	2014-06-17 21:00:00	2014-06-17 21:09:00
2432	2014-06-17 21:10:00	2014-06-17 21:19:00
2433	2014-06-17 21:20:00	2014-06-17 21:29:00
2434	2014-06-17 21:30:00	2014-06-17 21:39:00
2435	2014-06-17 21:40:00	2014-06-17 21:49:00
2436	2014-06-17 21:50:00	2014-06-17 21:59:00
2437	2014-06-17 22:00:00	2014-06-17 22:09:00
2438	2014-06-17 22:10:00	2014-06-17 22:19:00
2439	2014-06-17 22:20:00	2014-06-17 22:29:00
2440	2014-06-17 22:30:00	2014-06-17 22:39:00
2441	2014-06-17 22:40:00	2014-06-17 22:49:00
2442	2014-06-17 22:50:00	2014-06-17 22:59:00
2443	2014-06-17 23:00:00	2014-06-17 23:09:00
2444	2014-06-17 23:10:00	2014-06-17 23:19:00
2445	2014-06-17 23:20:00	2014-06-17 23:29:00
2446	2014-06-17 23:30:00	2014-06-17 23:39:00
2447	2014-06-17 23:40:00	2014-06-17 23:49:00
2448	2014-06-17 23:50:00	2014-06-17 23:59:00
2449	2014-06-18 00:00:00	2014-06-18 00:09:00
2450	2014-06-18 00:10:00	2014-06-18 00:19:00
2451	2014-06-18 00:20:00	2014-06-18 00:29:00
2452	2014-06-18 00:30:00	2014-06-18 00:39:00
2453	2014-06-18 00:40:00	2014-06-18 00:49:00
2454	2014-06-18 00:50:00	2014-06-18 00:59:00
2455	2014-06-18 01:00:00	2014-06-18 01:09:00
2456	2014-06-18 01:10:00	2014-06-18 01:19:00
2457	2014-06-18 01:20:00	2014-06-18 01:29:00
2458	2014-06-18 01:30:00	2014-06-18 01:39:00
2459	2014-06-18 01:40:00	2014-06-18 01:49:00
2460	2014-06-18 01:50:00	2014-06-18 01:59:00
2461	2014-06-18 02:00:00	2014-06-18 02:09:00
2462	2014-06-18 02:10:00	2014-06-18 02:19:00
2463	2014-06-18 02:20:00	2014-06-18 02:29:00
2464	2014-06-18 02:30:00	2014-06-18 02:39:00
2465	2014-06-18 02:40:00	2014-06-18 02:49:00
2466	2014-06-18 02:50:00	2014-06-18 02:59:00
2467	2014-06-18 03:00:00	2014-06-18 03:09:00
2468	2014-06-18 03:10:00	2014-06-18 03:19:00
2469	2014-06-18 03:20:00	2014-06-18 03:29:00
2470	2014-06-18 03:30:00	2014-06-18 03:39:00
2471	2014-06-18 03:40:00	2014-06-18 03:49:00
2472	2014-06-18 03:50:00	2014-06-18 03:59:00
2473	2014-06-18 04:00:00	2014-06-18 04:09:00
2474	2014-06-18 04:10:00	2014-06-18 04:19:00
2475	2014-06-18 04:20:00	2014-06-18 04:29:00
2476	2014-06-18 04:30:00	2014-06-18 04:39:00
2477	2014-06-18 04:40:00	2014-06-18 04:49:00
2478	2014-06-18 04:50:00	2014-06-18 04:59:00
2479	2014-06-18 05:00:00	2014-06-18 05:09:00
2480	2014-06-18 05:10:00	2014-06-18 05:19:00
2481	2014-06-18 05:20:00	2014-06-18 05:29:00
2482	2014-06-18 05:30:00	2014-06-18 05:39:00
2483	2014-06-18 05:40:00	2014-06-18 05:49:00
2484	2014-06-18 05:50:00	2014-06-18 05:59:00
2485	2014-06-18 06:00:00	2014-06-18 06:09:00
2486	2014-06-18 06:10:00	2014-06-18 06:19:00
2487	2014-06-18 06:20:00	2014-06-18 06:29:00
2488	2014-06-18 06:30:00	2014-06-18 06:39:00
2489	2014-06-18 06:40:00	2014-06-18 06:49:00
2490	2014-06-18 06:50:00	2014-06-18 06:59:00
2491	2014-06-18 07:00:00	2014-06-18 07:09:00
2492	2014-06-18 07:10:00	2014-06-18 07:19:00
2493	2014-06-18 07:20:00	2014-06-18 07:29:00
2494	2014-06-18 07:30:00	2014-06-18 07:39:00
2495	2014-06-18 07:40:00	2014-06-18 07:49:00
2496	2014-06-18 07:50:00	2014-06-18 07:59:00
2497	2014-06-18 08:00:00	2014-06-18 08:09:00
2498	2014-06-18 08:10:00	2014-06-18 08:19:00
2499	2014-06-18 08:20:00	2014-06-18 08:29:00
2500	2014-06-18 08:30:00	2014-06-18 08:39:00
2501	2014-06-18 08:40:00	2014-06-18 08:49:00
2502	2014-06-18 08:50:00	2014-06-18 08:59:00
2503	2014-06-18 09:00:00	2014-06-18 09:09:00
2504	2014-06-18 09:10:00	2014-06-18 09:19:00
2505	2014-06-18 09:20:00	2014-06-18 09:29:00
2506	2014-06-18 09:30:00	2014-06-18 09:39:00
2507	2014-06-18 09:40:00	2014-06-18 09:49:00
2508	2014-06-18 09:50:00	2014-06-18 09:59:00
2509	2014-06-18 10:00:00	2014-06-18 10:09:00
2510	2014-06-18 10:10:00	2014-06-18 10:19:00
2511	2014-06-18 10:20:00	2014-06-18 10:29:00
2512	2014-06-18 10:30:00	2014-06-18 10:39:00
2513	2014-06-18 10:40:00	2014-06-18 10:49:00
2514	2014-06-18 10:50:00	2014-06-18 10:59:00
2515	2014-06-18 11:00:00	2014-06-18 11:09:00
2516	2014-06-18 11:10:00	2014-06-18 11:19:00
2517	2014-06-18 11:20:00	2014-06-18 11:29:00
2518	2014-06-18 11:30:00	2014-06-18 11:39:00
2519	2014-06-18 11:40:00	2014-06-18 11:49:00
2520	2014-06-18 11:50:00	2014-06-18 11:59:00
2521	2014-06-18 12:00:00	2014-06-18 12:09:00
2522	2014-06-18 12:10:00	2014-06-18 12:19:00
2523	2014-06-18 12:20:00	2014-06-18 12:29:00
2524	2014-06-18 12:30:00	2014-06-18 12:39:00
2525	2014-06-18 12:40:00	2014-06-18 12:49:00
2526	2014-06-18 12:50:00	2014-06-18 12:59:00
2527	2014-06-18 13:00:00	2014-06-18 13:09:00
2528	2014-06-18 13:10:00	2014-06-18 13:19:00
2529	2014-06-18 13:20:00	2014-06-18 13:29:00
2530	2014-06-18 13:30:00	2014-06-18 13:39:00
2531	2014-06-18 13:40:00	2014-06-18 13:49:00
2532	2014-06-18 13:50:00	2014-06-18 13:59:00
2533	2014-06-18 14:00:00	2014-06-18 14:09:00
2534	2014-06-18 14:10:00	2014-06-18 14:19:00
2535	2014-06-18 14:20:00	2014-06-18 14:29:00
2536	2014-06-18 14:30:00	2014-06-18 14:39:00
2537	2014-06-18 14:40:00	2014-06-18 14:49:00
2538	2014-06-18 14:50:00	2014-06-18 14:59:00
2539	2014-06-18 15:00:00	2014-06-18 15:09:00
2540	2014-06-18 15:10:00	2014-06-18 15:19:00
2541	2014-06-18 15:20:00	2014-06-18 15:29:00
2542	2014-06-18 15:30:00	2014-06-18 15:39:00
2543	2014-06-18 15:40:00	2014-06-18 15:49:00
2544	2014-06-18 15:50:00	2014-06-18 15:59:00
2545	2014-06-18 16:00:00	2014-06-18 16:09:00
2546	2014-06-18 16:10:00	2014-06-18 16:19:00
2547	2014-06-18 16:20:00	2014-06-18 16:29:00
2548	2014-06-18 16:30:00	2014-06-18 16:39:00
2549	2014-06-18 16:40:00	2014-06-18 16:49:00
2550	2014-06-18 16:50:00	2014-06-18 16:59:00
2551	2014-06-18 17:00:00	2014-06-18 17:09:00
2552	2014-06-18 17:10:00	2014-06-18 17:19:00
2553	2014-06-18 17:20:00	2014-06-18 17:29:00
2554	2014-06-18 17:30:00	2014-06-18 17:39:00
2555	2014-06-18 17:40:00	2014-06-18 17:49:00
2556	2014-06-18 17:50:00	2014-06-18 17:59:00
2557	2014-06-18 18:00:00	2014-06-18 18:09:00
2558	2014-06-18 18:10:00	2014-06-18 18:19:00
2559	2014-06-18 18:20:00	2014-06-18 18:29:00
2560	2014-06-18 18:30:00	2014-06-18 18:39:00
2561	2014-06-18 18:40:00	2014-06-18 18:49:00
2562	2014-06-18 18:50:00	2014-06-18 18:59:00
2563	2014-06-18 19:00:00	2014-06-18 19:09:00
2564	2014-06-18 19:10:00	2014-06-18 19:19:00
2565	2014-06-18 19:20:00	2014-06-18 19:29:00
2566	2014-06-18 19:30:00	2014-06-18 19:39:00
2567	2014-06-18 19:40:00	2014-06-18 19:49:00
2568	2014-06-18 19:50:00	2014-06-18 19:59:00
2569	2014-06-18 20:00:00	2014-06-18 20:09:00
2570	2014-06-18 20:10:00	2014-06-18 20:19:00
2571	2014-06-18 20:20:00	2014-06-18 20:29:00
2572	2014-06-18 20:30:00	2014-06-18 20:39:00
2573	2014-06-18 20:40:00	2014-06-18 20:49:00
2574	2014-06-18 20:50:00	2014-06-18 20:59:00
2575	2014-06-18 21:00:00	2014-06-18 21:09:00
2576	2014-06-18 21:10:00	2014-06-18 21:19:00
2577	2014-06-18 21:20:00	2014-06-18 21:29:00
2578	2014-06-18 21:30:00	2014-06-18 21:39:00
2579	2014-06-18 21:40:00	2014-06-18 21:49:00
2580	2014-06-18 21:50:00	2014-06-18 21:59:00
2581	2014-06-18 22:00:00	2014-06-18 22:09:00
2582	2014-06-18 22:10:00	2014-06-18 22:19:00
2583	2014-06-18 22:20:00	2014-06-18 22:29:00
2584	2014-06-18 22:30:00	2014-06-18 22:39:00
2585	2014-06-18 22:40:00	2014-06-18 22:49:00
2586	2014-06-18 22:50:00	2014-06-18 22:59:00
2587	2014-06-18 23:00:00	2014-06-18 23:09:00
2588	2014-06-18 23:10:00	2014-06-18 23:19:00
2589	2014-06-18 23:20:00	2014-06-18 23:29:00
2590	2014-06-18 23:30:00	2014-06-18 23:39:00
2591	2014-06-18 23:40:00	2014-06-18 23:49:00
2592	2014-06-18 23:50:00	2014-06-18 23:59:00
2593	2014-06-19 00:00:00	2014-06-19 00:09:00
2594	2014-06-19 00:10:00	2014-06-19 00:19:00
2595	2014-06-19 00:20:00	2014-06-19 00:29:00
2596	2014-06-19 00:30:00	2014-06-19 00:39:00
2597	2014-06-19 00:40:00	2014-06-19 00:49:00
2598	2014-06-19 00:50:00	2014-06-19 00:59:00
2599	2014-06-19 01:00:00	2014-06-19 01:09:00
2600	2014-06-19 01:10:00	2014-06-19 01:19:00
2601	2014-06-19 01:20:00	2014-06-19 01:29:00
2602	2014-06-19 01:30:00	2014-06-19 01:39:00
2603	2014-06-19 01:40:00	2014-06-19 01:49:00
2604	2014-06-19 01:50:00	2014-06-19 01:59:00
2605	2014-06-19 02:00:00	2014-06-19 02:09:00
2606	2014-06-19 02:10:00	2014-06-19 02:19:00
2607	2014-06-19 02:20:00	2014-06-19 02:29:00
2608	2014-06-19 02:30:00	2014-06-19 02:39:00
2609	2014-06-19 02:40:00	2014-06-19 02:49:00
2610	2014-06-19 02:50:00	2014-06-19 02:59:00
2611	2014-06-19 03:00:00	2014-06-19 03:09:00
2612	2014-06-19 03:10:00	2014-06-19 03:19:00
2613	2014-06-19 03:20:00	2014-06-19 03:29:00
2614	2014-06-19 03:30:00	2014-06-19 03:39:00
2615	2014-06-19 03:40:00	2014-06-19 03:49:00
2616	2014-06-19 03:50:00	2014-06-19 03:59:00
2617	2014-06-19 04:00:00	2014-06-19 04:09:00
2618	2014-06-19 04:10:00	2014-06-19 04:19:00
2619	2014-06-19 04:20:00	2014-06-19 04:29:00
2620	2014-06-19 04:30:00	2014-06-19 04:39:00
2621	2014-06-19 04:40:00	2014-06-19 04:49:00
2622	2014-06-19 04:50:00	2014-06-19 04:59:00
2623	2014-06-19 05:00:00	2014-06-19 05:09:00
2624	2014-06-19 05:10:00	2014-06-19 05:19:00
2625	2014-06-19 05:20:00	2014-06-19 05:29:00
2626	2014-06-19 05:30:00	2014-06-19 05:39:00
2627	2014-06-19 05:40:00	2014-06-19 05:49:00
2628	2014-06-19 05:50:00	2014-06-19 05:59:00
2629	2014-06-19 06:00:00	2014-06-19 06:09:00
2630	2014-06-19 06:10:00	2014-06-19 06:19:00
2631	2014-06-19 06:20:00	2014-06-19 06:29:00
2632	2014-06-19 06:30:00	2014-06-19 06:39:00
2633	2014-06-19 06:40:00	2014-06-19 06:49:00
2634	2014-06-19 06:50:00	2014-06-19 06:59:00
2635	2014-06-19 07:00:00	2014-06-19 07:09:00
2636	2014-06-19 07:10:00	2014-06-19 07:19:00
2637	2014-06-19 07:20:00	2014-06-19 07:29:00
2638	2014-06-19 07:30:00	2014-06-19 07:39:00
2639	2014-06-19 07:40:00	2014-06-19 07:49:00
2640	2014-06-19 07:50:00	2014-06-19 07:59:00
2641	2014-06-19 08:00:00	2014-06-19 08:09:00
2642	2014-06-19 08:10:00	2014-06-19 08:19:00
2643	2014-06-19 08:20:00	2014-06-19 08:29:00
2644	2014-06-19 08:30:00	2014-06-19 08:39:00
2645	2014-06-19 08:40:00	2014-06-19 08:49:00
2646	2014-06-19 08:50:00	2014-06-19 08:59:00
2647	2014-06-19 09:00:00	2014-06-19 09:09:00
2648	2014-06-19 09:10:00	2014-06-19 09:19:00
2649	2014-06-19 09:20:00	2014-06-19 09:29:00
2650	2014-06-19 09:30:00	2014-06-19 09:39:00
2651	2014-06-19 09:40:00	2014-06-19 09:49:00
2652	2014-06-19 09:50:00	2014-06-19 09:59:00
2653	2014-06-19 10:00:00	2014-06-19 10:09:00
2654	2014-06-19 10:10:00	2014-06-19 10:19:00
2655	2014-06-19 10:20:00	2014-06-19 10:29:00
2656	2014-06-19 10:30:00	2014-06-19 10:39:00
2657	2014-06-19 10:40:00	2014-06-19 10:49:00
2658	2014-06-19 10:50:00	2014-06-19 10:59:00
2659	2014-06-19 11:00:00	2014-06-19 11:09:00
2660	2014-06-19 11:10:00	2014-06-19 11:19:00
2661	2014-06-19 11:20:00	2014-06-19 11:29:00
2662	2014-06-19 11:30:00	2014-06-19 11:39:00
2663	2014-06-19 11:40:00	2014-06-19 11:49:00
2664	2014-06-19 11:50:00	2014-06-19 11:59:00
2665	2014-06-19 12:00:00	2014-06-19 12:09:00
2666	2014-06-19 12:10:00	2014-06-19 12:19:00
2667	2014-06-19 12:20:00	2014-06-19 12:29:00
2668	2014-06-19 12:30:00	2014-06-19 12:39:00
2669	2014-06-19 12:40:00	2014-06-19 12:49:00
2670	2014-06-19 12:50:00	2014-06-19 12:59:00
2671	2014-06-19 13:00:00	2014-06-19 13:09:00
2672	2014-06-19 13:10:00	2014-06-19 13:19:00
2673	2014-06-19 13:20:00	2014-06-19 13:29:00
2674	2014-06-19 13:30:00	2014-06-19 13:39:00
2675	2014-06-19 13:40:00	2014-06-19 13:49:00
2676	2014-06-19 13:50:00	2014-06-19 13:59:00
2677	2014-06-19 14:00:00	2014-06-19 14:09:00
2678	2014-06-19 14:10:00	2014-06-19 14:19:00
2679	2014-06-19 14:20:00	2014-06-19 14:29:00
2680	2014-06-19 14:30:00	2014-06-19 14:39:00
2681	2014-06-19 14:40:00	2014-06-19 14:49:00
2682	2014-06-19 14:50:00	2014-06-19 14:59:00
2683	2014-06-19 15:00:00	2014-06-19 15:09:00
2684	2014-06-19 15:10:00	2014-06-19 15:19:00
2685	2014-06-19 15:20:00	2014-06-19 15:29:00
2686	2014-06-19 15:30:00	2014-06-19 15:39:00
2687	2014-06-19 15:40:00	2014-06-19 15:49:00
2688	2014-06-19 15:50:00	2014-06-19 15:59:00
2689	2014-06-19 16:00:00	2014-06-19 16:09:00
2690	2014-06-19 16:10:00	2014-06-19 16:19:00
2691	2014-06-19 16:20:00	2014-06-19 16:29:00
2692	2014-06-19 16:30:00	2014-06-19 16:39:00
2693	2014-06-19 16:40:00	2014-06-19 16:49:00
2694	2014-06-19 16:50:00	2014-06-19 16:59:00
2695	2014-06-19 17:00:00	2014-06-19 17:09:00
2696	2014-06-19 17:10:00	2014-06-19 17:19:00
2697	2014-06-19 17:20:00	2014-06-19 17:29:00
2698	2014-06-19 17:30:00	2014-06-19 17:39:00
2699	2014-06-19 17:40:00	2014-06-19 17:49:00
2700	2014-06-19 17:50:00	2014-06-19 17:59:00
2701	2014-06-19 18:00:00	2014-06-19 18:09:00
2702	2014-06-19 18:10:00	2014-06-19 18:19:00
2703	2014-06-19 18:20:00	2014-06-19 18:29:00
2704	2014-06-19 18:30:00	2014-06-19 18:39:00
2705	2014-06-19 18:40:00	2014-06-19 18:49:00
2706	2014-06-19 18:50:00	2014-06-19 18:59:00
2707	2014-06-19 19:00:00	2014-06-19 19:09:00
2708	2014-06-19 19:10:00	2014-06-19 19:19:00
2709	2014-06-19 19:20:00	2014-06-19 19:29:00
2710	2014-06-19 19:30:00	2014-06-19 19:39:00
2711	2014-06-19 19:40:00	2014-06-19 19:49:00
2712	2014-06-19 19:50:00	2014-06-19 19:59:00
2713	2014-06-19 20:00:00	2014-06-19 20:09:00
2714	2014-06-19 20:10:00	2014-06-19 20:19:00
2715	2014-06-19 20:20:00	2014-06-19 20:29:00
2716	2014-06-19 20:30:00	2014-06-19 20:39:00
2717	2014-06-19 20:40:00	2014-06-19 20:49:00
2718	2014-06-19 20:50:00	2014-06-19 20:59:00
2719	2014-06-19 21:00:00	2014-06-19 21:09:00
2720	2014-06-19 21:10:00	2014-06-19 21:19:00
2721	2014-06-19 21:20:00	2014-06-19 21:29:00
2722	2014-06-19 21:30:00	2014-06-19 21:39:00
2723	2014-06-19 21:40:00	2014-06-19 21:49:00
2724	2014-06-19 21:50:00	2014-06-19 21:59:00
2725	2014-06-19 22:00:00	2014-06-19 22:09:00
2726	2014-06-19 22:10:00	2014-06-19 22:19:00
2727	2014-06-19 22:20:00	2014-06-19 22:29:00
2728	2014-06-19 22:30:00	2014-06-19 22:39:00
2729	2014-06-19 22:40:00	2014-06-19 22:49:00
2730	2014-06-19 22:50:00	2014-06-19 22:59:00
2731	2014-06-19 23:00:00	2014-06-19 23:09:00
2732	2014-06-19 23:10:00	2014-06-19 23:19:00
2733	2014-06-19 23:20:00	2014-06-19 23:29:00
2734	2014-06-19 23:30:00	2014-06-19 23:39:00
2735	2014-06-19 23:40:00	2014-06-19 23:49:00
2736	2014-06-19 23:50:00	2014-06-19 23:59:00
2737	2014-06-20 00:00:00	2014-06-20 00:09:00
2738	2014-06-20 00:10:00	2014-06-20 00:19:00
2739	2014-06-20 00:20:00	2014-06-20 00:29:00
2740	2014-06-20 00:30:00	2014-06-20 00:39:00
2741	2014-06-20 00:40:00	2014-06-20 00:49:00
2742	2014-06-20 00:50:00	2014-06-20 00:59:00
2743	2014-06-20 01:00:00	2014-06-20 01:09:00
2744	2014-06-20 01:10:00	2014-06-20 01:19:00
2745	2014-06-20 01:20:00	2014-06-20 01:29:00
2746	2014-06-20 01:30:00	2014-06-20 01:39:00
2747	2014-06-20 01:40:00	2014-06-20 01:49:00
2748	2014-06-20 01:50:00	2014-06-20 01:59:00
2749	2014-06-20 02:00:00	2014-06-20 02:09:00
2750	2014-06-20 02:10:00	2014-06-20 02:19:00
2751	2014-06-20 02:20:00	2014-06-20 02:29:00
2752	2014-06-20 02:30:00	2014-06-20 02:39:00
2753	2014-06-20 02:40:00	2014-06-20 02:49:00
2754	2014-06-20 02:50:00	2014-06-20 02:59:00
2755	2014-06-20 03:00:00	2014-06-20 03:09:00
2756	2014-06-20 03:10:00	2014-06-20 03:19:00
2757	2014-06-20 03:20:00	2014-06-20 03:29:00
2758	2014-06-20 03:30:00	2014-06-20 03:39:00
2759	2014-06-20 03:40:00	2014-06-20 03:49:00
2760	2014-06-20 03:50:00	2014-06-20 03:59:00
2761	2014-06-20 04:00:00	2014-06-20 04:09:00
2762	2014-06-20 04:10:00	2014-06-20 04:19:00
2763	2014-06-20 04:20:00	2014-06-20 04:29:00
2764	2014-06-20 04:30:00	2014-06-20 04:39:00
2765	2014-06-20 04:40:00	2014-06-20 04:49:00
2766	2014-06-20 04:50:00	2014-06-20 04:59:00
2767	2014-06-20 05:00:00	2014-06-20 05:09:00
2768	2014-06-20 05:10:00	2014-06-20 05:19:00
2769	2014-06-20 05:20:00	2014-06-20 05:29:00
2770	2014-06-20 05:30:00	2014-06-20 05:39:00
2771	2014-06-20 05:40:00	2014-06-20 05:49:00
2772	2014-06-20 05:50:00	2014-06-20 05:59:00
2773	2014-06-20 06:00:00	2014-06-20 06:09:00
2774	2014-06-20 06:10:00	2014-06-20 06:19:00
2775	2014-06-20 06:20:00	2014-06-20 06:29:00
2776	2014-06-20 06:30:00	2014-06-20 06:39:00
2777	2014-06-20 06:40:00	2014-06-20 06:49:00
2778	2014-06-20 06:50:00	2014-06-20 06:59:00
2779	2014-06-20 07:00:00	2014-06-20 07:09:00
2780	2014-06-20 07:10:00	2014-06-20 07:19:00
2781	2014-06-20 07:20:00	2014-06-20 07:29:00
2782	2014-06-20 07:30:00	2014-06-20 07:39:00
2783	2014-06-20 07:40:00	2014-06-20 07:49:00
2784	2014-06-20 07:50:00	2014-06-20 07:59:00
2785	2014-06-20 08:00:00	2014-06-20 08:09:00
2786	2014-06-20 08:10:00	2014-06-20 08:19:00
2787	2014-06-20 08:20:00	2014-06-20 08:29:00
2788	2014-06-20 08:30:00	2014-06-20 08:39:00
2789	2014-06-20 08:40:00	2014-06-20 08:49:00
2790	2014-06-20 08:50:00	2014-06-20 08:59:00
2791	2014-06-20 09:00:00	2014-06-20 09:09:00
2792	2014-06-20 09:10:00	2014-06-20 09:19:00
2793	2014-06-20 09:20:00	2014-06-20 09:29:00
2794	2014-06-20 09:30:00	2014-06-20 09:39:00
2795	2014-06-20 09:40:00	2014-06-20 09:49:00
2796	2014-06-20 09:50:00	2014-06-20 09:59:00
2797	2014-06-20 10:00:00	2014-06-20 10:09:00
2798	2014-06-20 10:10:00	2014-06-20 10:19:00
2799	2014-06-20 10:20:00	2014-06-20 10:29:00
2800	2014-06-20 10:30:00	2014-06-20 10:39:00
2801	2014-06-20 10:40:00	2014-06-20 10:49:00
2802	2014-06-20 10:50:00	2014-06-20 10:59:00
2803	2014-06-20 11:00:00	2014-06-20 11:09:00
2804	2014-06-20 11:10:00	2014-06-20 11:19:00
2805	2014-06-20 11:20:00	2014-06-20 11:29:00
2806	2014-06-20 11:30:00	2014-06-20 11:39:00
2807	2014-06-20 11:40:00	2014-06-20 11:49:00
2808	2014-06-20 11:50:00	2014-06-20 11:59:00
2809	2014-06-20 12:00:00	2014-06-20 12:09:00
2810	2014-06-20 12:10:00	2014-06-20 12:19:00
2811	2014-06-20 12:20:00	2014-06-20 12:29:00
2812	2014-06-20 12:30:00	2014-06-20 12:39:00
2813	2014-06-20 12:40:00	2014-06-20 12:49:00
2814	2014-06-20 12:50:00	2014-06-20 12:59:00
2815	2014-06-20 13:00:00	2014-06-20 13:09:00
2816	2014-06-20 13:10:00	2014-06-20 13:19:00
2817	2014-06-20 13:20:00	2014-06-20 13:29:00
2818	2014-06-20 13:30:00	2014-06-20 13:39:00
2819	2014-06-20 13:40:00	2014-06-20 13:49:00
2820	2014-06-20 13:50:00	2014-06-20 13:59:00
2821	2014-06-20 14:00:00	2014-06-20 14:09:00
2822	2014-06-20 14:10:00	2014-06-20 14:19:00
2823	2014-06-20 14:20:00	2014-06-20 14:29:00
2824	2014-06-20 14:30:00	2014-06-20 14:39:00
2825	2014-06-20 14:40:00	2014-06-20 14:49:00
2826	2014-06-20 14:50:00	2014-06-20 14:59:00
2827	2014-06-20 15:00:00	2014-06-20 15:09:00
2828	2014-06-20 15:10:00	2014-06-20 15:19:00
2829	2014-06-20 15:20:00	2014-06-20 15:29:00
2830	2014-06-20 15:30:00	2014-06-20 15:39:00
2831	2014-06-20 15:40:00	2014-06-20 15:49:00
2832	2014-06-20 15:50:00	2014-06-20 15:59:00
2833	2014-06-20 16:00:00	2014-06-20 16:09:00
2834	2014-06-20 16:10:00	2014-06-20 16:19:00
2835	2014-06-20 16:20:00	2014-06-20 16:29:00
2836	2014-06-20 16:30:00	2014-06-20 16:39:00
2837	2014-06-20 16:40:00	2014-06-20 16:49:00
2838	2014-06-20 16:50:00	2014-06-20 16:59:00
2839	2014-06-20 17:00:00	2014-06-20 17:09:00
2840	2014-06-20 17:10:00	2014-06-20 17:19:00
2841	2014-06-20 17:20:00	2014-06-20 17:29:00
2842	2014-06-20 17:30:00	2014-06-20 17:39:00
2843	2014-06-20 17:40:00	2014-06-20 17:49:00
2844	2014-06-20 17:50:00	2014-06-20 17:59:00
2845	2014-06-20 18:00:00	2014-06-20 18:09:00
2846	2014-06-20 18:10:00	2014-06-20 18:19:00
2847	2014-06-20 18:20:00	2014-06-20 18:29:00
2848	2014-06-20 18:30:00	2014-06-20 18:39:00
2849	2014-06-20 18:40:00	2014-06-20 18:49:00
2850	2014-06-20 18:50:00	2014-06-20 18:59:00
2851	2014-06-20 19:00:00	2014-06-20 19:09:00
2852	2014-06-20 19:10:00	2014-06-20 19:19:00
2853	2014-06-20 19:20:00	2014-06-20 19:29:00
2854	2014-06-20 19:30:00	2014-06-20 19:39:00
2855	2014-06-20 19:40:00	2014-06-20 19:49:00
2856	2014-06-20 19:50:00	2014-06-20 19:59:00
2857	2014-06-20 20:00:00	2014-06-20 20:09:00
2858	2014-06-20 20:10:00	2014-06-20 20:19:00
2859	2014-06-20 20:20:00	2014-06-20 20:29:00
2860	2014-06-20 20:30:00	2014-06-20 20:39:00
2861	2014-06-20 20:40:00	2014-06-20 20:49:00
2862	2014-06-20 20:50:00	2014-06-20 20:59:00
2863	2014-06-20 21:00:00	2014-06-20 21:09:00
2864	2014-06-20 21:10:00	2014-06-20 21:19:00
2865	2014-06-20 21:20:00	2014-06-20 21:29:00
2866	2014-06-20 21:30:00	2014-06-20 21:39:00
2867	2014-06-20 21:40:00	2014-06-20 21:49:00
2868	2014-06-20 21:50:00	2014-06-20 21:59:00
2869	2014-06-20 22:00:00	2014-06-20 22:09:00
2870	2014-06-20 22:10:00	2014-06-20 22:19:00
2871	2014-06-20 22:20:00	2014-06-20 22:29:00
2872	2014-06-20 22:30:00	2014-06-20 22:39:00
2873	2014-06-20 22:40:00	2014-06-20 22:49:00
2874	2014-06-20 22:50:00	2014-06-20 22:59:00
2875	2014-06-20 23:00:00	2014-06-20 23:09:00
2876	2014-06-20 23:10:00	2014-06-20 23:19:00
2877	2014-06-20 23:20:00	2014-06-20 23:29:00
2878	2014-06-20 23:30:00	2014-06-20 23:39:00
2879	2014-06-20 23:40:00	2014-06-20 23:49:00
2880	2014-06-20 23:50:00	2014-06-20 23:59:00
2881	2014-06-21 00:00:00	2014-06-21 00:09:00
2882	2014-06-21 00:10:00	2014-06-21 00:19:00
2883	2014-06-21 00:20:00	2014-06-21 00:29:00
2884	2014-06-21 00:30:00	2014-06-21 00:39:00
2885	2014-06-21 00:40:00	2014-06-21 00:49:00
2886	2014-06-21 00:50:00	2014-06-21 00:59:00
2887	2014-06-21 01:00:00	2014-06-21 01:09:00
2888	2014-06-21 01:10:00	2014-06-21 01:19:00
2889	2014-06-21 01:20:00	2014-06-21 01:29:00
2890	2014-06-21 01:30:00	2014-06-21 01:39:00
2891	2014-06-21 01:40:00	2014-06-21 01:49:00
2892	2014-06-21 01:50:00	2014-06-21 01:59:00
2893	2014-06-21 02:00:00	2014-06-21 02:09:00
2894	2014-06-21 02:10:00	2014-06-21 02:19:00
2895	2014-06-21 02:20:00	2014-06-21 02:29:00
2896	2014-06-21 02:30:00	2014-06-21 02:39:00
2897	2014-06-21 02:40:00	2014-06-21 02:49:00
2898	2014-06-21 02:50:00	2014-06-21 02:59:00
2899	2014-06-21 03:00:00	2014-06-21 03:09:00
2900	2014-06-21 03:10:00	2014-06-21 03:19:00
2901	2014-06-21 03:20:00	2014-06-21 03:29:00
2902	2014-06-21 03:30:00	2014-06-21 03:39:00
2903	2014-06-21 03:40:00	2014-06-21 03:49:00
2904	2014-06-21 03:50:00	2014-06-21 03:59:00
2905	2014-06-21 04:00:00	2014-06-21 04:09:00
2906	2014-06-21 04:10:00	2014-06-21 04:19:00
2907	2014-06-21 04:20:00	2014-06-21 04:29:00
2908	2014-06-21 04:30:00	2014-06-21 04:39:00
2909	2014-06-21 04:40:00	2014-06-21 04:49:00
2910	2014-06-21 04:50:00	2014-06-21 04:59:00
2911	2014-06-21 05:00:00	2014-06-21 05:09:00
2912	2014-06-21 05:10:00	2014-06-21 05:19:00
2913	2014-06-21 05:20:00	2014-06-21 05:29:00
2914	2014-06-21 05:30:00	2014-06-21 05:39:00
2915	2014-06-21 05:40:00	2014-06-21 05:49:00
2916	2014-06-21 05:50:00	2014-06-21 05:59:00
2917	2014-06-21 06:00:00	2014-06-21 06:09:00
2918	2014-06-21 06:10:00	2014-06-21 06:19:00
2919	2014-06-21 06:20:00	2014-06-21 06:29:00
2920	2014-06-21 06:30:00	2014-06-21 06:39:00
2921	2014-06-21 06:40:00	2014-06-21 06:49:00
2922	2014-06-21 06:50:00	2014-06-21 06:59:00
2923	2014-06-21 07:00:00	2014-06-21 07:09:00
2924	2014-06-21 07:10:00	2014-06-21 07:19:00
2925	2014-06-21 07:20:00	2014-06-21 07:29:00
2926	2014-06-21 07:30:00	2014-06-21 07:39:00
2927	2014-06-21 07:40:00	2014-06-21 07:49:00
2928	2014-06-21 07:50:00	2014-06-21 07:59:00
2929	2014-06-21 08:00:00	2014-06-21 08:09:00
2930	2014-06-21 08:10:00	2014-06-21 08:19:00
2931	2014-06-21 08:20:00	2014-06-21 08:29:00
2932	2014-06-21 08:30:00	2014-06-21 08:39:00
2933	2014-06-21 08:40:00	2014-06-21 08:49:00
2934	2014-06-21 08:50:00	2014-06-21 08:59:00
2935	2014-06-21 09:00:00	2014-06-21 09:09:00
2936	2014-06-21 09:10:00	2014-06-21 09:19:00
2937	2014-06-21 09:20:00	2014-06-21 09:29:00
2938	2014-06-21 09:30:00	2014-06-21 09:39:00
2939	2014-06-21 09:40:00	2014-06-21 09:49:00
2940	2014-06-21 09:50:00	2014-06-21 09:59:00
2941	2014-06-21 10:00:00	2014-06-21 10:09:00
2942	2014-06-21 10:10:00	2014-06-21 10:19:00
2943	2014-06-21 10:20:00	2014-06-21 10:29:00
2944	2014-06-21 10:30:00	2014-06-21 10:39:00
2945	2014-06-21 10:40:00	2014-06-21 10:49:00
2946	2014-06-21 10:50:00	2014-06-21 10:59:00
2947	2014-06-21 11:00:00	2014-06-21 11:09:00
2948	2014-06-21 11:10:00	2014-06-21 11:19:00
2949	2014-06-21 11:20:00	2014-06-21 11:29:00
2950	2014-06-21 11:30:00	2014-06-21 11:39:00
2951	2014-06-21 11:40:00	2014-06-21 11:49:00
2952	2014-06-21 11:50:00	2014-06-21 11:59:00
2953	2014-06-21 12:00:00	2014-06-21 12:09:00
2954	2014-06-21 12:10:00	2014-06-21 12:19:00
2955	2014-06-21 12:20:00	2014-06-21 12:29:00
2956	2014-06-21 12:30:00	2014-06-21 12:39:00
2957	2014-06-21 12:40:00	2014-06-21 12:49:00
2958	2014-06-21 12:50:00	2014-06-21 12:59:00
2959	2014-06-21 13:00:00	2014-06-21 13:09:00
2960	2014-06-21 13:10:00	2014-06-21 13:19:00
2961	2014-06-21 13:20:00	2014-06-21 13:29:00
2962	2014-06-21 13:30:00	2014-06-21 13:39:00
2963	2014-06-21 13:40:00	2014-06-21 13:49:00
2964	2014-06-21 13:50:00	2014-06-21 13:59:00
2965	2014-06-21 14:00:00	2014-06-21 14:09:00
2966	2014-06-21 14:10:00	2014-06-21 14:19:00
2967	2014-06-21 14:20:00	2014-06-21 14:29:00
2968	2014-06-21 14:30:00	2014-06-21 14:39:00
2969	2014-06-21 14:40:00	2014-06-21 14:49:00
2970	2014-06-21 14:50:00	2014-06-21 14:59:00
2971	2014-06-21 15:00:00	2014-06-21 15:09:00
2972	2014-06-21 15:10:00	2014-06-21 15:19:00
2973	2014-06-21 15:20:00	2014-06-21 15:29:00
2974	2014-06-21 15:30:00	2014-06-21 15:39:00
2975	2014-06-21 15:40:00	2014-06-21 15:49:00
2976	2014-06-21 15:50:00	2014-06-21 15:59:00
2977	2014-06-21 16:00:00	2014-06-21 16:09:00
2978	2014-06-21 16:10:00	2014-06-21 16:19:00
2979	2014-06-21 16:20:00	2014-06-21 16:29:00
2980	2014-06-21 16:30:00	2014-06-21 16:39:00
2981	2014-06-21 16:40:00	2014-06-21 16:49:00
2982	2014-06-21 16:50:00	2014-06-21 16:59:00
2983	2014-06-21 17:00:00	2014-06-21 17:09:00
2984	2014-06-21 17:10:00	2014-06-21 17:19:00
2985	2014-06-21 17:20:00	2014-06-21 17:29:00
2986	2014-06-21 17:30:00	2014-06-21 17:39:00
2987	2014-06-21 17:40:00	2014-06-21 17:49:00
2988	2014-06-21 17:50:00	2014-06-21 17:59:00
2989	2014-06-21 18:00:00	2014-06-21 18:09:00
2990	2014-06-21 18:10:00	2014-06-21 18:19:00
2991	2014-06-21 18:20:00	2014-06-21 18:29:00
2992	2014-06-21 18:30:00	2014-06-21 18:39:00
2993	2014-06-21 18:40:00	2014-06-21 18:49:00
2994	2014-06-21 18:50:00	2014-06-21 18:59:00
2995	2014-06-21 19:00:00	2014-06-21 19:09:00
2996	2014-06-21 19:10:00	2014-06-21 19:19:00
2997	2014-06-21 19:20:00	2014-06-21 19:29:00
2998	2014-06-21 19:30:00	2014-06-21 19:39:00
2999	2014-06-21 19:40:00	2014-06-21 19:49:00
3000	2014-06-21 19:50:00	2014-06-21 19:59:00
3001	2014-06-21 20:00:00	2014-06-21 20:09:00
3002	2014-06-21 20:10:00	2014-06-21 20:19:00
3003	2014-06-21 20:20:00	2014-06-21 20:29:00
3004	2014-06-21 20:30:00	2014-06-21 20:39:00
3005	2014-06-21 20:40:00	2014-06-21 20:49:00
3006	2014-06-21 20:50:00	2014-06-21 20:59:00
3007	2014-06-21 21:00:00	2014-06-21 21:09:00
3008	2014-06-21 21:10:00	2014-06-21 21:19:00
3009	2014-06-21 21:20:00	2014-06-21 21:29:00
3010	2014-06-21 21:30:00	2014-06-21 21:39:00
3011	2014-06-21 21:40:00	2014-06-21 21:49:00
3012	2014-06-21 21:50:00	2014-06-21 21:59:00
3013	2014-06-21 22:00:00	2014-06-21 22:09:00
3014	2014-06-21 22:10:00	2014-06-21 22:19:00
3015	2014-06-21 22:20:00	2014-06-21 22:29:00
3016	2014-06-21 22:30:00	2014-06-21 22:39:00
3017	2014-06-21 22:40:00	2014-06-21 22:49:00
3018	2014-06-21 22:50:00	2014-06-21 22:59:00
3019	2014-06-21 23:00:00	2014-06-21 23:09:00
3020	2014-06-21 23:10:00	2014-06-21 23:19:00
3021	2014-06-21 23:20:00	2014-06-21 23:29:00
3022	2014-06-21 23:30:00	2014-06-21 23:39:00
3023	2014-06-21 23:40:00	2014-06-21 23:49:00
3024	2014-06-21 23:50:00	2014-06-21 23:59:00
3025	2014-06-22 00:00:00	2014-06-22 00:09:00
3026	2014-06-22 00:10:00	2014-06-22 00:19:00
3027	2014-06-22 00:20:00	2014-06-22 00:29:00
3028	2014-06-22 00:30:00	2014-06-22 00:39:00
3029	2014-06-22 00:40:00	2014-06-22 00:49:00
3030	2014-06-22 00:50:00	2014-06-22 00:59:00
3031	2014-06-22 01:00:00	2014-06-22 01:09:00
3032	2014-06-22 01:10:00	2014-06-22 01:19:00
3033	2014-06-22 01:20:00	2014-06-22 01:29:00
3034	2014-06-22 01:30:00	2014-06-22 01:39:00
3035	2014-06-22 01:40:00	2014-06-22 01:49:00
3036	2014-06-22 01:50:00	2014-06-22 01:59:00
3037	2014-06-22 02:00:00	2014-06-22 02:09:00
3038	2014-06-22 02:10:00	2014-06-22 02:19:00
3039	2014-06-22 02:20:00	2014-06-22 02:29:00
3040	2014-06-22 02:30:00	2014-06-22 02:39:00
3041	2014-06-22 02:40:00	2014-06-22 02:49:00
3042	2014-06-22 02:50:00	2014-06-22 02:59:00
3043	2014-06-22 03:00:00	2014-06-22 03:09:00
3044	2014-06-22 03:10:00	2014-06-22 03:19:00
3045	2014-06-22 03:20:00	2014-06-22 03:29:00
3046	2014-06-22 03:30:00	2014-06-22 03:39:00
3047	2014-06-22 03:40:00	2014-06-22 03:49:00
3048	2014-06-22 03:50:00	2014-06-22 03:59:00
3049	2014-06-22 04:00:00	2014-06-22 04:09:00
3050	2014-06-22 04:10:00	2014-06-22 04:19:00
3051	2014-06-22 04:20:00	2014-06-22 04:29:00
3052	2014-06-22 04:30:00	2014-06-22 04:39:00
3053	2014-06-22 04:40:00	2014-06-22 04:49:00
3054	2014-06-22 04:50:00	2014-06-22 04:59:00
3055	2014-06-22 05:00:00	2014-06-22 05:09:00
3056	2014-06-22 05:10:00	2014-06-22 05:19:00
3057	2014-06-22 05:20:00	2014-06-22 05:29:00
3058	2014-06-22 05:30:00	2014-06-22 05:39:00
3059	2014-06-22 05:40:00	2014-06-22 05:49:00
3060	2014-06-22 05:50:00	2014-06-22 05:59:00
3061	2014-06-22 06:00:00	2014-06-22 06:09:00
3062	2014-06-22 06:10:00	2014-06-22 06:19:00
3063	2014-06-22 06:20:00	2014-06-22 06:29:00
3064	2014-06-22 06:30:00	2014-06-22 06:39:00
3065	2014-06-22 06:40:00	2014-06-22 06:49:00
3066	2014-06-22 06:50:00	2014-06-22 06:59:00
3067	2014-06-22 07:00:00	2014-06-22 07:09:00
3068	2014-06-22 07:10:00	2014-06-22 07:19:00
3069	2014-06-22 07:20:00	2014-06-22 07:29:00
3070	2014-06-22 07:30:00	2014-06-22 07:39:00
3071	2014-06-22 07:40:00	2014-06-22 07:49:00
3072	2014-06-22 07:50:00	2014-06-22 07:59:00
3073	2014-06-22 08:00:00	2014-06-22 08:09:00
3074	2014-06-22 08:10:00	2014-06-22 08:19:00
3075	2014-06-22 08:20:00	2014-06-22 08:29:00
3076	2014-06-22 08:30:00	2014-06-22 08:39:00
3077	2014-06-22 08:40:00	2014-06-22 08:49:00
3078	2014-06-22 08:50:00	2014-06-22 08:59:00
3079	2014-06-22 09:00:00	2014-06-22 09:09:00
3080	2014-06-22 09:10:00	2014-06-22 09:19:00
3081	2014-06-22 09:20:00	2014-06-22 09:29:00
3082	2014-06-22 09:30:00	2014-06-22 09:39:00
3083	2014-06-22 09:40:00	2014-06-22 09:49:00
3084	2014-06-22 09:50:00	2014-06-22 09:59:00
3085	2014-06-22 10:00:00	2014-06-22 10:09:00
3086	2014-06-22 10:10:00	2014-06-22 10:19:00
3087	2014-06-22 10:20:00	2014-06-22 10:29:00
3088	2014-06-22 10:30:00	2014-06-22 10:39:00
3089	2014-06-22 10:40:00	2014-06-22 10:49:00
3090	2014-06-22 10:50:00	2014-06-22 10:59:00
3091	2014-06-22 11:00:00	2014-06-22 11:09:00
3092	2014-06-22 11:10:00	2014-06-22 11:19:00
3093	2014-06-22 11:20:00	2014-06-22 11:29:00
3094	2014-06-22 11:30:00	2014-06-22 11:39:00
3095	2014-06-22 11:40:00	2014-06-22 11:49:00
3096	2014-06-22 11:50:00	2014-06-22 11:59:00
3097	2014-06-22 12:00:00	2014-06-22 12:09:00
3098	2014-06-22 12:10:00	2014-06-22 12:19:00
3099	2014-06-22 12:20:00	2014-06-22 12:29:00
3100	2014-06-22 12:30:00	2014-06-22 12:39:00
3101	2014-06-22 12:40:00	2014-06-22 12:49:00
3102	2014-06-22 12:50:00	2014-06-22 12:59:00
3103	2014-06-22 13:00:00	2014-06-22 13:09:00
3104	2014-06-22 13:10:00	2014-06-22 13:19:00
3105	2014-06-22 13:20:00	2014-06-22 13:29:00
3106	2014-06-22 13:30:00	2014-06-22 13:39:00
3107	2014-06-22 13:40:00	2014-06-22 13:49:00
3108	2014-06-22 13:50:00	2014-06-22 13:59:00
3109	2014-06-22 14:00:00	2014-06-22 14:09:00
3110	2014-06-22 14:10:00	2014-06-22 14:19:00
3111	2014-06-22 14:20:00	2014-06-22 14:29:00
3112	2014-06-22 14:30:00	2014-06-22 14:39:00
3113	2014-06-22 14:40:00	2014-06-22 14:49:00
3114	2014-06-22 14:50:00	2014-06-22 14:59:00
3115	2014-06-22 15:00:00	2014-06-22 15:09:00
3116	2014-06-22 15:10:00	2014-06-22 15:19:00
3117	2014-06-22 15:20:00	2014-06-22 15:29:00
3118	2014-06-22 15:30:00	2014-06-22 15:39:00
3119	2014-06-22 15:40:00	2014-06-22 15:49:00
3120	2014-06-22 15:50:00	2014-06-22 15:59:00
3121	2014-06-22 16:00:00	2014-06-22 16:09:00
3122	2014-06-22 16:10:00	2014-06-22 16:19:00
3123	2014-06-22 16:20:00	2014-06-22 16:29:00
3124	2014-06-22 16:30:00	2014-06-22 16:39:00
3125	2014-06-22 16:40:00	2014-06-22 16:49:00
3126	2014-06-22 16:50:00	2014-06-22 16:59:00
3127	2014-06-22 17:00:00	2014-06-22 17:09:00
3128	2014-06-22 17:10:00	2014-06-22 17:19:00
3129	2014-06-22 17:20:00	2014-06-22 17:29:00
3130	2014-06-22 17:30:00	2014-06-22 17:39:00
3131	2014-06-22 17:40:00	2014-06-22 17:49:00
3132	2014-06-22 17:50:00	2014-06-22 17:59:00
3133	2014-06-22 18:00:00	2014-06-22 18:09:00
3134	2014-06-22 18:10:00	2014-06-22 18:19:00
3135	2014-06-22 18:20:00	2014-06-22 18:29:00
3136	2014-06-22 18:30:00	2014-06-22 18:39:00
3137	2014-06-22 18:40:00	2014-06-22 18:49:00
3138	2014-06-22 18:50:00	2014-06-22 18:59:00
3139	2014-06-22 19:00:00	2014-06-22 19:09:00
3140	2014-06-22 19:10:00	2014-06-22 19:19:00
3141	2014-06-22 19:20:00	2014-06-22 19:29:00
3142	2014-06-22 19:30:00	2014-06-22 19:39:00
3143	2014-06-22 19:40:00	2014-06-22 19:49:00
3144	2014-06-22 19:50:00	2014-06-22 19:59:00
3145	2014-06-22 20:00:00	2014-06-22 20:09:00
3146	2014-06-22 20:10:00	2014-06-22 20:19:00
3147	2014-06-22 20:20:00	2014-06-22 20:29:00
3148	2014-06-22 20:30:00	2014-06-22 20:39:00
3149	2014-06-22 20:40:00	2014-06-22 20:49:00
3150	2014-06-22 20:50:00	2014-06-22 20:59:00
3151	2014-06-22 21:00:00	2014-06-22 21:09:00
3152	2014-06-22 21:10:00	2014-06-22 21:19:00
3153	2014-06-22 21:20:00	2014-06-22 21:29:00
3154	2014-06-22 21:30:00	2014-06-22 21:39:00
3155	2014-06-22 21:40:00	2014-06-22 21:49:00
3156	2014-06-22 21:50:00	2014-06-22 21:59:00
3157	2014-06-22 22:00:00	2014-06-22 22:09:00
3158	2014-06-22 22:10:00	2014-06-22 22:19:00
3159	2014-06-22 22:20:00	2014-06-22 22:29:00
3160	2014-06-22 22:30:00	2014-06-22 22:39:00
3161	2014-06-22 22:40:00	2014-06-22 22:49:00
3162	2014-06-22 22:50:00	2014-06-22 22:59:00
3163	2014-06-22 23:00:00	2014-06-22 23:09:00
3164	2014-06-22 23:10:00	2014-06-22 23:19:00
3165	2014-06-22 23:20:00	2014-06-22 23:29:00
3166	2014-06-22 23:30:00	2014-06-22 23:39:00
3167	2014-06-22 23:40:00	2014-06-22 23:49:00
3168	2014-06-22 23:50:00	2014-06-22 23:59:00
3169	2014-06-23 00:00:00	2014-06-23 00:09:00
3170	2014-06-23 00:10:00	2014-06-23 00:19:00
3171	2014-06-23 00:20:00	2014-06-23 00:29:00
3172	2014-06-23 00:30:00	2014-06-23 00:39:00
3173	2014-06-23 00:40:00	2014-06-23 00:49:00
3174	2014-06-23 00:50:00	2014-06-23 00:59:00
3175	2014-06-23 01:00:00	2014-06-23 01:09:00
3176	2014-06-23 01:10:00	2014-06-23 01:19:00
3177	2014-06-23 01:20:00	2014-06-23 01:29:00
3178	2014-06-23 01:30:00	2014-06-23 01:39:00
3179	2014-06-23 01:40:00	2014-06-23 01:49:00
3180	2014-06-23 01:50:00	2014-06-23 01:59:00
3181	2014-06-23 02:00:00	2014-06-23 02:09:00
3182	2014-06-23 02:10:00	2014-06-23 02:19:00
3183	2014-06-23 02:20:00	2014-06-23 02:29:00
3184	2014-06-23 02:30:00	2014-06-23 02:39:00
3185	2014-06-23 02:40:00	2014-06-23 02:49:00
3186	2014-06-23 02:50:00	2014-06-23 02:59:00
3187	2014-06-23 03:00:00	2014-06-23 03:09:00
3188	2014-06-23 03:10:00	2014-06-23 03:19:00
3189	2014-06-23 03:20:00	2014-06-23 03:29:00
3190	2014-06-23 03:30:00	2014-06-23 03:39:00
3191	2014-06-23 03:40:00	2014-06-23 03:49:00
3192	2014-06-23 03:50:00	2014-06-23 03:59:00
3193	2014-06-23 04:00:00	2014-06-23 04:09:00
3194	2014-06-23 04:10:00	2014-06-23 04:19:00
3195	2014-06-23 04:20:00	2014-06-23 04:29:00
3196	2014-06-23 04:30:00	2014-06-23 04:39:00
3197	2014-06-23 04:40:00	2014-06-23 04:49:00
3198	2014-06-23 04:50:00	2014-06-23 04:59:00
3199	2014-06-23 05:00:00	2014-06-23 05:09:00
3200	2014-06-23 05:10:00	2014-06-23 05:19:00
3201	2014-06-23 05:20:00	2014-06-23 05:29:00
3202	2014-06-23 05:30:00	2014-06-23 05:39:00
3203	2014-06-23 05:40:00	2014-06-23 05:49:00
3204	2014-06-23 05:50:00	2014-06-23 05:59:00
3205	2014-06-23 06:00:00	2014-06-23 06:09:00
3206	2014-06-23 06:10:00	2014-06-23 06:19:00
3207	2014-06-23 06:20:00	2014-06-23 06:29:00
3208	2014-06-23 06:30:00	2014-06-23 06:39:00
3209	2014-06-23 06:40:00	2014-06-23 06:49:00
3210	2014-06-23 06:50:00	2014-06-23 06:59:00
3211	2014-06-23 07:00:00	2014-06-23 07:09:00
3212	2014-06-23 07:10:00	2014-06-23 07:19:00
3213	2014-06-23 07:20:00	2014-06-23 07:29:00
3214	2014-06-23 07:30:00	2014-06-23 07:39:00
3215	2014-06-23 07:40:00	2014-06-23 07:49:00
3216	2014-06-23 07:50:00	2014-06-23 07:59:00
3217	2014-06-23 08:00:00	2014-06-23 08:09:00
3218	2014-06-23 08:10:00	2014-06-23 08:19:00
3219	2014-06-23 08:20:00	2014-06-23 08:29:00
3220	2014-06-23 08:30:00	2014-06-23 08:39:00
3221	2014-06-23 08:40:00	2014-06-23 08:49:00
3222	2014-06-23 08:50:00	2014-06-23 08:59:00
3223	2014-06-23 09:00:00	2014-06-23 09:09:00
3224	2014-06-23 09:10:00	2014-06-23 09:19:00
3225	2014-06-23 09:20:00	2014-06-23 09:29:00
3226	2014-06-23 09:30:00	2014-06-23 09:39:00
3227	2014-06-23 09:40:00	2014-06-23 09:49:00
3228	2014-06-23 09:50:00	2014-06-23 09:59:00
3229	2014-06-23 10:00:00	2014-06-23 10:09:00
3230	2014-06-23 10:10:00	2014-06-23 10:19:00
3231	2014-06-23 10:20:00	2014-06-23 10:29:00
3232	2014-06-23 10:30:00	2014-06-23 10:39:00
3233	2014-06-23 10:40:00	2014-06-23 10:49:00
3234	2014-06-23 10:50:00	2014-06-23 10:59:00
3235	2014-06-23 11:00:00	2014-06-23 11:09:00
3236	2014-06-23 11:10:00	2014-06-23 11:19:00
3237	2014-06-23 11:20:00	2014-06-23 11:29:00
3238	2014-06-23 11:30:00	2014-06-23 11:39:00
3239	2014-06-23 11:40:00	2014-06-23 11:49:00
3240	2014-06-23 11:50:00	2014-06-23 11:59:00
3241	2014-06-23 12:00:00	2014-06-23 12:09:00
3242	2014-06-23 12:10:00	2014-06-23 12:19:00
3243	2014-06-23 12:20:00	2014-06-23 12:29:00
3244	2014-06-23 12:30:00	2014-06-23 12:39:00
3245	2014-06-23 12:40:00	2014-06-23 12:49:00
3246	2014-06-23 12:50:00	2014-06-23 12:59:00
3247	2014-06-23 13:00:00	2014-06-23 13:09:00
3248	2014-06-23 13:10:00	2014-06-23 13:19:00
3249	2014-06-23 13:20:00	2014-06-23 13:29:00
3250	2014-06-23 13:30:00	2014-06-23 13:39:00
3251	2014-06-23 13:40:00	2014-06-23 13:49:00
3252	2014-06-23 13:50:00	2014-06-23 13:59:00
3253	2014-06-23 14:00:00	2014-06-23 14:09:00
3254	2014-06-23 14:10:00	2014-06-23 14:19:00
3255	2014-06-23 14:20:00	2014-06-23 14:29:00
3256	2014-06-23 14:30:00	2014-06-23 14:39:00
3257	2014-06-23 14:40:00	2014-06-23 14:49:00
3258	2014-06-23 14:50:00	2014-06-23 14:59:00
3259	2014-06-23 15:00:00	2014-06-23 15:09:00
3260	2014-06-23 15:10:00	2014-06-23 15:19:00
3261	2014-06-23 15:20:00	2014-06-23 15:29:00
3262	2014-06-23 15:30:00	2014-06-23 15:39:00
3263	2014-06-23 15:40:00	2014-06-23 15:49:00
3264	2014-06-23 15:50:00	2014-06-23 15:59:00
3265	2014-06-23 16:00:00	2014-06-23 16:09:00
3266	2014-06-23 16:10:00	2014-06-23 16:19:00
3267	2014-06-23 16:20:00	2014-06-23 16:29:00
3268	2014-06-23 16:30:00	2014-06-23 16:39:00
3269	2014-06-23 16:40:00	2014-06-23 16:49:00
3270	2014-06-23 16:50:00	2014-06-23 16:59:00
3271	2014-06-23 17:00:00	2014-06-23 17:09:00
3272	2014-06-23 17:10:00	2014-06-23 17:19:00
3273	2014-06-23 17:20:00	2014-06-23 17:29:00
3274	2014-06-23 17:30:00	2014-06-23 17:39:00
3275	2014-06-23 17:40:00	2014-06-23 17:49:00
3276	2014-06-23 17:50:00	2014-06-23 17:59:00
3277	2014-06-23 18:00:00	2014-06-23 18:09:00
3278	2014-06-23 18:10:00	2014-06-23 18:19:00
3279	2014-06-23 18:20:00	2014-06-23 18:29:00
3280	2014-06-23 18:30:00	2014-06-23 18:39:00
3281	2014-06-23 18:40:00	2014-06-23 18:49:00
3282	2014-06-23 18:50:00	2014-06-23 18:59:00
3283	2014-06-23 19:00:00	2014-06-23 19:09:00
3284	2014-06-23 19:10:00	2014-06-23 19:19:00
3285	2014-06-23 19:20:00	2014-06-23 19:29:00
3286	2014-06-23 19:30:00	2014-06-23 19:39:00
3287	2014-06-23 19:40:00	2014-06-23 19:49:00
3288	2014-06-23 19:50:00	2014-06-23 19:59:00
3289	2014-06-23 20:00:00	2014-06-23 20:09:00
3290	2014-06-23 20:10:00	2014-06-23 20:19:00
3291	2014-06-23 20:20:00	2014-06-23 20:29:00
3292	2014-06-23 20:30:00	2014-06-23 20:39:00
3293	2014-06-23 20:40:00	2014-06-23 20:49:00
3294	2014-06-23 20:50:00	2014-06-23 20:59:00
3295	2014-06-23 21:00:00	2014-06-23 21:09:00
3296	2014-06-23 21:10:00	2014-06-23 21:19:00
3297	2014-06-23 21:20:00	2014-06-23 21:29:00
3298	2014-06-23 21:30:00	2014-06-23 21:39:00
3299	2014-06-23 21:40:00	2014-06-23 21:49:00
3300	2014-06-23 21:50:00	2014-06-23 21:59:00
3301	2014-06-23 22:00:00	2014-06-23 22:09:00
3302	2014-06-23 22:10:00	2014-06-23 22:19:00
3303	2014-06-23 22:20:00	2014-06-23 22:29:00
3304	2014-06-23 22:30:00	2014-06-23 22:39:00
3305	2014-06-23 22:40:00	2014-06-23 22:49:00
3306	2014-06-23 22:50:00	2014-06-23 22:59:00
3307	2014-06-23 23:00:00	2014-06-23 23:09:00
3308	2014-06-23 23:10:00	2014-06-23 23:19:00
3309	2014-06-23 23:20:00	2014-06-23 23:29:00
3310	2014-06-23 23:30:00	2014-06-23 23:39:00
3311	2014-06-23 23:40:00	2014-06-23 23:49:00
3312	2014-06-23 23:50:00	2014-06-23 23:59:00
3313	2014-06-24 00:00:00	2014-06-24 00:09:00
3314	2014-06-24 00:10:00	2014-06-24 00:19:00
3315	2014-06-24 00:20:00	2014-06-24 00:29:00
3316	2014-06-24 00:30:00	2014-06-24 00:39:00
3317	2014-06-24 00:40:00	2014-06-24 00:49:00
3318	2014-06-24 00:50:00	2014-06-24 00:59:00
3319	2014-06-24 01:00:00	2014-06-24 01:09:00
3320	2014-06-24 01:10:00	2014-06-24 01:19:00
3321	2014-06-24 01:20:00	2014-06-24 01:29:00
3322	2014-06-24 01:30:00	2014-06-24 01:39:00
3323	2014-06-24 01:40:00	2014-06-24 01:49:00
3324	2014-06-24 01:50:00	2014-06-24 01:59:00
3325	2014-06-24 02:00:00	2014-06-24 02:09:00
3326	2014-06-24 02:10:00	2014-06-24 02:19:00
3327	2014-06-24 02:20:00	2014-06-24 02:29:00
3328	2014-06-24 02:30:00	2014-06-24 02:39:00
3329	2014-06-24 02:40:00	2014-06-24 02:49:00
3330	2014-06-24 02:50:00	2014-06-24 02:59:00
3331	2014-06-24 03:00:00	2014-06-24 03:09:00
3332	2014-06-24 03:10:00	2014-06-24 03:19:00
3333	2014-06-24 03:20:00	2014-06-24 03:29:00
3334	2014-06-24 03:30:00	2014-06-24 03:39:00
3335	2014-06-24 03:40:00	2014-06-24 03:49:00
3336	2014-06-24 03:50:00	2014-06-24 03:59:00
3337	2014-06-24 04:00:00	2014-06-24 04:09:00
3338	2014-06-24 04:10:00	2014-06-24 04:19:00
3339	2014-06-24 04:20:00	2014-06-24 04:29:00
3340	2014-06-24 04:30:00	2014-06-24 04:39:00
3341	2014-06-24 04:40:00	2014-06-24 04:49:00
3342	2014-06-24 04:50:00	2014-06-24 04:59:00
3343	2014-06-24 05:00:00	2014-06-24 05:09:00
3344	2014-06-24 05:10:00	2014-06-24 05:19:00
3345	2014-06-24 05:20:00	2014-06-24 05:29:00
3346	2014-06-24 05:30:00	2014-06-24 05:39:00
3347	2014-06-24 05:40:00	2014-06-24 05:49:00
3348	2014-06-24 05:50:00	2014-06-24 05:59:00
3349	2014-06-24 06:00:00	2014-06-24 06:09:00
3350	2014-06-24 06:10:00	2014-06-24 06:19:00
3351	2014-06-24 06:20:00	2014-06-24 06:29:00
3352	2014-06-24 06:30:00	2014-06-24 06:39:00
3353	2014-06-24 06:40:00	2014-06-24 06:49:00
3354	2014-06-24 06:50:00	2014-06-24 06:59:00
3355	2014-06-24 07:00:00	2014-06-24 07:09:00
3356	2014-06-24 07:10:00	2014-06-24 07:19:00
3357	2014-06-24 07:20:00	2014-06-24 07:29:00
3358	2014-06-24 07:30:00	2014-06-24 07:39:00
3359	2014-06-24 07:40:00	2014-06-24 07:49:00
3360	2014-06-24 07:50:00	2014-06-24 07:59:00
3361	2014-06-24 08:00:00	2014-06-24 08:09:00
3362	2014-06-24 08:10:00	2014-06-24 08:19:00
3363	2014-06-24 08:20:00	2014-06-24 08:29:00
3364	2014-06-24 08:30:00	2014-06-24 08:39:00
3365	2014-06-24 08:40:00	2014-06-24 08:49:00
3366	2014-06-24 08:50:00	2014-06-24 08:59:00
3367	2014-06-24 09:00:00	2014-06-24 09:09:00
3368	2014-06-24 09:10:00	2014-06-24 09:19:00
3369	2014-06-24 09:20:00	2014-06-24 09:29:00
3370	2014-06-24 09:30:00	2014-06-24 09:39:00
3371	2014-06-24 09:40:00	2014-06-24 09:49:00
3372	2014-06-24 09:50:00	2014-06-24 09:59:00
3373	2014-06-24 10:00:00	2014-06-24 10:09:00
3374	2014-06-24 10:10:00	2014-06-24 10:19:00
3375	2014-06-24 10:20:00	2014-06-24 10:29:00
3376	2014-06-24 10:30:00	2014-06-24 10:39:00
3377	2014-06-24 10:40:00	2014-06-24 10:49:00
3378	2014-06-24 10:50:00	2014-06-24 10:59:00
3379	2014-06-24 11:00:00	2014-06-24 11:09:00
3380	2014-06-24 11:10:00	2014-06-24 11:19:00
3381	2014-06-24 11:20:00	2014-06-24 11:29:00
3382	2014-06-24 11:30:00	2014-06-24 11:39:00
3383	2014-06-24 11:40:00	2014-06-24 11:49:00
3384	2014-06-24 11:50:00	2014-06-24 11:59:00
3385	2014-06-24 12:00:00	2014-06-24 12:09:00
3386	2014-06-24 12:10:00	2014-06-24 12:19:00
3387	2014-06-24 12:20:00	2014-06-24 12:29:00
3388	2014-06-24 12:30:00	2014-06-24 12:39:00
3389	2014-06-24 12:40:00	2014-06-24 12:49:00
3390	2014-06-24 12:50:00	2014-06-24 12:59:00
3391	2014-06-24 13:00:00	2014-06-24 13:09:00
3392	2014-06-24 13:10:00	2014-06-24 13:19:00
3393	2014-06-24 13:20:00	2014-06-24 13:29:00
3394	2014-06-24 13:30:00	2014-06-24 13:39:00
3395	2014-06-24 13:40:00	2014-06-24 13:49:00
3396	2014-06-24 13:50:00	2014-06-24 13:59:00
3397	2014-06-24 14:00:00	2014-06-24 14:09:00
3398	2014-06-24 14:10:00	2014-06-24 14:19:00
3399	2014-06-24 14:20:00	2014-06-24 14:29:00
3400	2014-06-24 14:30:00	2014-06-24 14:39:00
3401	2014-06-24 14:40:00	2014-06-24 14:49:00
3402	2014-06-24 14:50:00	2014-06-24 14:59:00
3403	2014-06-24 15:00:00	2014-06-24 15:09:00
3404	2014-06-24 15:10:00	2014-06-24 15:19:00
3405	2014-06-24 15:20:00	2014-06-24 15:29:00
3406	2014-06-24 15:30:00	2014-06-24 15:39:00
3407	2014-06-24 15:40:00	2014-06-24 15:49:00
3408	2014-06-24 15:50:00	2014-06-24 15:59:00
3409	2014-06-24 16:00:00	2014-06-24 16:09:00
3410	2014-06-24 16:10:00	2014-06-24 16:19:00
3411	2014-06-24 16:20:00	2014-06-24 16:29:00
3412	2014-06-24 16:30:00	2014-06-24 16:39:00
3413	2014-06-24 16:40:00	2014-06-24 16:49:00
3414	2014-06-24 16:50:00	2014-06-24 16:59:00
3415	2014-06-24 17:00:00	2014-06-24 17:09:00
3416	2014-06-24 17:10:00	2014-06-24 17:19:00
3417	2014-06-24 17:20:00	2014-06-24 17:29:00
3418	2014-06-24 17:30:00	2014-06-24 17:39:00
3419	2014-06-24 17:40:00	2014-06-24 17:49:00
3420	2014-06-24 17:50:00	2014-06-24 17:59:00
3421	2014-06-24 18:00:00	2014-06-24 18:09:00
3422	2014-06-24 18:10:00	2014-06-24 18:19:00
3423	2014-06-24 18:20:00	2014-06-24 18:29:00
3424	2014-06-24 18:30:00	2014-06-24 18:39:00
3425	2014-06-24 18:40:00	2014-06-24 18:49:00
3426	2014-06-24 18:50:00	2014-06-24 18:59:00
3427	2014-06-24 19:00:00	2014-06-24 19:09:00
3428	2014-06-24 19:10:00	2014-06-24 19:19:00
3429	2014-06-24 19:20:00	2014-06-24 19:29:00
3430	2014-06-24 19:30:00	2014-06-24 19:39:00
3431	2014-06-24 19:40:00	2014-06-24 19:49:00
3432	2014-06-24 19:50:00	2014-06-24 19:59:00
3433	2014-06-24 20:00:00	2014-06-24 20:09:00
3434	2014-06-24 20:10:00	2014-06-24 20:19:00
3435	2014-06-24 20:20:00	2014-06-24 20:29:00
3436	2014-06-24 20:30:00	2014-06-24 20:39:00
3437	2014-06-24 20:40:00	2014-06-24 20:49:00
3438	2014-06-24 20:50:00	2014-06-24 20:59:00
3439	2014-06-24 21:00:00	2014-06-24 21:09:00
3440	2014-06-24 21:10:00	2014-06-24 21:19:00
3441	2014-06-24 21:20:00	2014-06-24 21:29:00
3442	2014-06-24 21:30:00	2014-06-24 21:39:00
3443	2014-06-24 21:40:00	2014-06-24 21:49:00
3444	2014-06-24 21:50:00	2014-06-24 21:59:00
3445	2014-06-24 22:00:00	2014-06-24 22:09:00
3446	2014-06-24 22:10:00	2014-06-24 22:19:00
3447	2014-06-24 22:20:00	2014-06-24 22:29:00
3448	2014-06-24 22:30:00	2014-06-24 22:39:00
3449	2014-06-24 22:40:00	2014-06-24 22:49:00
3450	2014-06-24 22:50:00	2014-06-24 22:59:00
3451	2014-06-24 23:00:00	2014-06-24 23:09:00
3452	2014-06-24 23:10:00	2014-06-24 23:19:00
3453	2014-06-24 23:20:00	2014-06-24 23:29:00
3454	2014-06-24 23:30:00	2014-06-24 23:39:00
3455	2014-06-24 23:40:00	2014-06-24 23:49:00
3456	2014-06-24 23:50:00	2014-06-24 23:59:00
3457	2014-06-25 00:00:00	2014-06-25 00:09:00
3458	2014-06-25 00:10:00	2014-06-25 00:19:00
3459	2014-06-25 00:20:00	2014-06-25 00:29:00
3460	2014-06-25 00:30:00	2014-06-25 00:39:00
3461	2014-06-25 00:40:00	2014-06-25 00:49:00
3462	2014-06-25 00:50:00	2014-06-25 00:59:00
3463	2014-06-25 01:00:00	2014-06-25 01:09:00
3464	2014-06-25 01:10:00	2014-06-25 01:19:00
3465	2014-06-25 01:20:00	2014-06-25 01:29:00
3466	2014-06-25 01:30:00	2014-06-25 01:39:00
3467	2014-06-25 01:40:00	2014-06-25 01:49:00
3468	2014-06-25 01:50:00	2014-06-25 01:59:00
3469	2014-06-25 02:00:00	2014-06-25 02:09:00
3470	2014-06-25 02:10:00	2014-06-25 02:19:00
3471	2014-06-25 02:20:00	2014-06-25 02:29:00
3472	2014-06-25 02:30:00	2014-06-25 02:39:00
3473	2014-06-25 02:40:00	2014-06-25 02:49:00
3474	2014-06-25 02:50:00	2014-06-25 02:59:00
3475	2014-06-25 03:00:00	2014-06-25 03:09:00
3476	2014-06-25 03:10:00	2014-06-25 03:19:00
3477	2014-06-25 03:20:00	2014-06-25 03:29:00
3478	2014-06-25 03:30:00	2014-06-25 03:39:00
3479	2014-06-25 03:40:00	2014-06-25 03:49:00
3480	2014-06-25 03:50:00	2014-06-25 03:59:00
3481	2014-06-25 04:00:00	2014-06-25 04:09:00
3482	2014-06-25 04:10:00	2014-06-25 04:19:00
3483	2014-06-25 04:20:00	2014-06-25 04:29:00
3484	2014-06-25 04:30:00	2014-06-25 04:39:00
3485	2014-06-25 04:40:00	2014-06-25 04:49:00
3486	2014-06-25 04:50:00	2014-06-25 04:59:00
3487	2014-06-25 05:00:00	2014-06-25 05:09:00
3488	2014-06-25 05:10:00	2014-06-25 05:19:00
3489	2014-06-25 05:20:00	2014-06-25 05:29:00
3490	2014-06-25 05:30:00	2014-06-25 05:39:00
3491	2014-06-25 05:40:00	2014-06-25 05:49:00
3492	2014-06-25 05:50:00	2014-06-25 05:59:00
3493	2014-06-25 06:00:00	2014-06-25 06:09:00
3494	2014-06-25 06:10:00	2014-06-25 06:19:00
3495	2014-06-25 06:20:00	2014-06-25 06:29:00
3496	2014-06-25 06:30:00	2014-06-25 06:39:00
3497	2014-06-25 06:40:00	2014-06-25 06:49:00
3498	2014-06-25 06:50:00	2014-06-25 06:59:00
3499	2014-06-25 07:00:00	2014-06-25 07:09:00
3500	2014-06-25 07:10:00	2014-06-25 07:19:00
3501	2014-06-25 07:20:00	2014-06-25 07:29:00
3502	2014-06-25 07:30:00	2014-06-25 07:39:00
3503	2014-06-25 07:40:00	2014-06-25 07:49:00
3504	2014-06-25 07:50:00	2014-06-25 07:59:00
3505	2014-06-25 08:00:00	2014-06-25 08:09:00
3506	2014-06-25 08:10:00	2014-06-25 08:19:00
3507	2014-06-25 08:20:00	2014-06-25 08:29:00
3508	2014-06-25 08:30:00	2014-06-25 08:39:00
3509	2014-06-25 08:40:00	2014-06-25 08:49:00
3510	2014-06-25 08:50:00	2014-06-25 08:59:00
3511	2014-06-25 09:00:00	2014-06-25 09:09:00
3512	2014-06-25 09:10:00	2014-06-25 09:19:00
3513	2014-06-25 09:20:00	2014-06-25 09:29:00
3514	2014-06-25 09:30:00	2014-06-25 09:39:00
3515	2014-06-25 09:40:00	2014-06-25 09:49:00
3516	2014-06-25 09:50:00	2014-06-25 09:59:00
3517	2014-06-25 10:00:00	2014-06-25 10:09:00
3518	2014-06-25 10:10:00	2014-06-25 10:19:00
3519	2014-06-25 10:20:00	2014-06-25 10:29:00
3520	2014-06-25 10:30:00	2014-06-25 10:39:00
3521	2014-06-25 10:40:00	2014-06-25 10:49:00
3522	2014-06-25 10:50:00	2014-06-25 10:59:00
3523	2014-06-25 11:00:00	2014-06-25 11:09:00
3524	2014-06-25 11:10:00	2014-06-25 11:19:00
3525	2014-06-25 11:20:00	2014-06-25 11:29:00
3526	2014-06-25 11:30:00	2014-06-25 11:39:00
3527	2014-06-25 11:40:00	2014-06-25 11:49:00
3528	2014-06-25 11:50:00	2014-06-25 11:59:00
3529	2014-06-25 12:00:00	2014-06-25 12:09:00
3530	2014-06-25 12:10:00	2014-06-25 12:19:00
3531	2014-06-25 12:20:00	2014-06-25 12:29:00
3532	2014-06-25 12:30:00	2014-06-25 12:39:00
3533	2014-06-25 12:40:00	2014-06-25 12:49:00
3534	2014-06-25 12:50:00	2014-06-25 12:59:00
3535	2014-06-25 13:00:00	2014-06-25 13:09:00
3536	2014-06-25 13:10:00	2014-06-25 13:19:00
3537	2014-06-25 13:20:00	2014-06-25 13:29:00
3538	2014-06-25 13:30:00	2014-06-25 13:39:00
3539	2014-06-25 13:40:00	2014-06-25 13:49:00
3540	2014-06-25 13:50:00	2014-06-25 13:59:00
3541	2014-06-25 14:00:00	2014-06-25 14:09:00
3542	2014-06-25 14:10:00	2014-06-25 14:19:00
3543	2014-06-25 14:20:00	2014-06-25 14:29:00
3544	2014-06-25 14:30:00	2014-06-25 14:39:00
3545	2014-06-25 14:40:00	2014-06-25 14:49:00
3546	2014-06-25 14:50:00	2014-06-25 14:59:00
3547	2014-06-25 15:00:00	2014-06-25 15:09:00
3548	2014-06-25 15:10:00	2014-06-25 15:19:00
3549	2014-06-25 15:20:00	2014-06-25 15:29:00
3550	2014-06-25 15:30:00	2014-06-25 15:39:00
3551	2014-06-25 15:40:00	2014-06-25 15:49:00
3552	2014-06-25 15:50:00	2014-06-25 15:59:00
3553	2014-06-25 16:00:00	2014-06-25 16:09:00
3554	2014-06-25 16:10:00	2014-06-25 16:19:00
3555	2014-06-25 16:20:00	2014-06-25 16:29:00
3556	2014-06-25 16:30:00	2014-06-25 16:39:00
3557	2014-06-25 16:40:00	2014-06-25 16:49:00
3558	2014-06-25 16:50:00	2014-06-25 16:59:00
3559	2014-06-25 17:00:00	2014-06-25 17:09:00
3560	2014-06-25 17:10:00	2014-06-25 17:19:00
3561	2014-06-25 17:20:00	2014-06-25 17:29:00
3562	2014-06-25 17:30:00	2014-06-25 17:39:00
3563	2014-06-25 17:40:00	2014-06-25 17:49:00
3564	2014-06-25 17:50:00	2014-06-25 17:59:00
3565	2014-06-25 18:00:00	2014-06-25 18:09:00
3566	2014-06-25 18:10:00	2014-06-25 18:19:00
3567	2014-06-25 18:20:00	2014-06-25 18:29:00
3568	2014-06-25 18:30:00	2014-06-25 18:39:00
3569	2014-06-25 18:40:00	2014-06-25 18:49:00
3570	2014-06-25 18:50:00	2014-06-25 18:59:00
3571	2014-06-25 19:00:00	2014-06-25 19:09:00
3572	2014-06-25 19:10:00	2014-06-25 19:19:00
3573	2014-06-25 19:20:00	2014-06-25 19:29:00
3574	2014-06-25 19:30:00	2014-06-25 19:39:00
3575	2014-06-25 19:40:00	2014-06-25 19:49:00
3576	2014-06-25 19:50:00	2014-06-25 19:59:00
3577	2014-06-25 20:00:00	2014-06-25 20:09:00
3578	2014-06-25 20:10:00	2014-06-25 20:19:00
3579	2014-06-25 20:20:00	2014-06-25 20:29:00
3580	2014-06-25 20:30:00	2014-06-25 20:39:00
3581	2014-06-25 20:40:00	2014-06-25 20:49:00
3582	2014-06-25 20:50:00	2014-06-25 20:59:00
3583	2014-06-25 21:00:00	2014-06-25 21:09:00
3584	2014-06-25 21:10:00	2014-06-25 21:19:00
3585	2014-06-25 21:20:00	2014-06-25 21:29:00
3586	2014-06-25 21:30:00	2014-06-25 21:39:00
3587	2014-06-25 21:40:00	2014-06-25 21:49:00
3588	2014-06-25 21:50:00	2014-06-25 21:59:00
3589	2014-06-25 22:00:00	2014-06-25 22:09:00
3590	2014-06-25 22:10:00	2014-06-25 22:19:00
3591	2014-06-25 22:20:00	2014-06-25 22:29:00
3592	2014-06-25 22:30:00	2014-06-25 22:39:00
3593	2014-06-25 22:40:00	2014-06-25 22:49:00
3594	2014-06-25 22:50:00	2014-06-25 22:59:00
3595	2014-06-25 23:00:00	2014-06-25 23:09:00
3596	2014-06-25 23:10:00	2014-06-25 23:19:00
3597	2014-06-25 23:20:00	2014-06-25 23:29:00
3598	2014-06-25 23:30:00	2014-06-25 23:39:00
3599	2014-06-25 23:40:00	2014-06-25 23:49:00
3600	2014-06-25 23:50:00	2014-06-25 23:59:00
3601	2014-06-26 00:00:00	2014-06-26 00:09:00
3602	2014-06-26 00:10:00	2014-06-26 00:19:00
3603	2014-06-26 00:20:00	2014-06-26 00:29:00
3604	2014-06-26 00:30:00	2014-06-26 00:39:00
3605	2014-06-26 00:40:00	2014-06-26 00:49:00
3606	2014-06-26 00:50:00	2014-06-26 00:59:00
3607	2014-06-26 01:00:00	2014-06-26 01:09:00
3608	2014-06-26 01:10:00	2014-06-26 01:19:00
3609	2014-06-26 01:20:00	2014-06-26 01:29:00
3610	2014-06-26 01:30:00	2014-06-26 01:39:00
3611	2014-06-26 01:40:00	2014-06-26 01:49:00
3612	2014-06-26 01:50:00	2014-06-26 01:59:00
3613	2014-06-26 02:00:00	2014-06-26 02:09:00
3614	2014-06-26 02:10:00	2014-06-26 02:19:00
3615	2014-06-26 02:20:00	2014-06-26 02:29:00
3616	2014-06-26 02:30:00	2014-06-26 02:39:00
3617	2014-06-26 02:40:00	2014-06-26 02:49:00
3618	2014-06-26 02:50:00	2014-06-26 02:59:00
3619	2014-06-26 03:00:00	2014-06-26 03:09:00
3620	2014-06-26 03:10:00	2014-06-26 03:19:00
3621	2014-06-26 03:20:00	2014-06-26 03:29:00
3622	2014-06-26 03:30:00	2014-06-26 03:39:00
3623	2014-06-26 03:40:00	2014-06-26 03:49:00
3624	2014-06-26 03:50:00	2014-06-26 03:59:00
3625	2014-06-26 04:00:00	2014-06-26 04:09:00
3626	2014-06-26 04:10:00	2014-06-26 04:19:00
3627	2014-06-26 04:20:00	2014-06-26 04:29:00
3628	2014-06-26 04:30:00	2014-06-26 04:39:00
3629	2014-06-26 04:40:00	2014-06-26 04:49:00
3630	2014-06-26 04:50:00	2014-06-26 04:59:00
3631	2014-06-26 05:00:00	2014-06-26 05:09:00
3632	2014-06-26 05:10:00	2014-06-26 05:19:00
3633	2014-06-26 05:20:00	2014-06-26 05:29:00
3634	2014-06-26 05:30:00	2014-06-26 05:39:00
3635	2014-06-26 05:40:00	2014-06-26 05:49:00
3636	2014-06-26 05:50:00	2014-06-26 05:59:00
3637	2014-06-26 06:00:00	2014-06-26 06:09:00
3638	2014-06-26 06:10:00	2014-06-26 06:19:00
3639	2014-06-26 06:20:00	2014-06-26 06:29:00
3640	2014-06-26 06:30:00	2014-06-26 06:39:00
3641	2014-06-26 06:40:00	2014-06-26 06:49:00
3642	2014-06-26 06:50:00	2014-06-26 06:59:00
3643	2014-06-26 07:00:00	2014-06-26 07:09:00
3644	2014-06-26 07:10:00	2014-06-26 07:19:00
3645	2014-06-26 07:20:00	2014-06-26 07:29:00
3646	2014-06-26 07:30:00	2014-06-26 07:39:00
3647	2014-06-26 07:40:00	2014-06-26 07:49:00
3648	2014-06-26 07:50:00	2014-06-26 07:59:00
3649	2014-06-26 08:00:00	2014-06-26 08:09:00
3650	2014-06-26 08:10:00	2014-06-26 08:19:00
3651	2014-06-26 08:20:00	2014-06-26 08:29:00
3652	2014-06-26 08:30:00	2014-06-26 08:39:00
3653	2014-06-26 08:40:00	2014-06-26 08:49:00
3654	2014-06-26 08:50:00	2014-06-26 08:59:00
3655	2014-06-26 09:00:00	2014-06-26 09:09:00
3656	2014-06-26 09:10:00	2014-06-26 09:19:00
3657	2014-06-26 09:20:00	2014-06-26 09:29:00
3658	2014-06-26 09:30:00	2014-06-26 09:39:00
3659	2014-06-26 09:40:00	2014-06-26 09:49:00
3660	2014-06-26 09:50:00	2014-06-26 09:59:00
3661	2014-06-26 10:00:00	2014-06-26 10:09:00
3662	2014-06-26 10:10:00	2014-06-26 10:19:00
3663	2014-06-26 10:20:00	2014-06-26 10:29:00
3664	2014-06-26 10:30:00	2014-06-26 10:39:00
3665	2014-06-26 10:40:00	2014-06-26 10:49:00
3666	2014-06-26 10:50:00	2014-06-26 10:59:00
3667	2014-06-26 11:00:00	2014-06-26 11:09:00
3668	2014-06-26 11:10:00	2014-06-26 11:19:00
3669	2014-06-26 11:20:00	2014-06-26 11:29:00
3670	2014-06-26 11:30:00	2014-06-26 11:39:00
3671	2014-06-26 11:40:00	2014-06-26 11:49:00
3672	2014-06-26 11:50:00	2014-06-26 11:59:00
3673	2014-06-26 12:00:00	2014-06-26 12:09:00
3674	2014-06-26 12:10:00	2014-06-26 12:19:00
3675	2014-06-26 12:20:00	2014-06-26 12:29:00
3676	2014-06-26 12:30:00	2014-06-26 12:39:00
3677	2014-06-26 12:40:00	2014-06-26 12:49:00
3678	2014-06-26 12:50:00	2014-06-26 12:59:00
3679	2014-06-26 13:00:00	2014-06-26 13:09:00
3680	2014-06-26 13:10:00	2014-06-26 13:19:00
3681	2014-06-26 13:20:00	2014-06-26 13:29:00
3682	2014-06-26 13:30:00	2014-06-26 13:39:00
3683	2014-06-26 13:40:00	2014-06-26 13:49:00
3684	2014-06-26 13:50:00	2014-06-26 13:59:00
3685	2014-06-26 14:00:00	2014-06-26 14:09:00
3686	2014-06-26 14:10:00	2014-06-26 14:19:00
3687	2014-06-26 14:20:00	2014-06-26 14:29:00
3688	2014-06-26 14:30:00	2014-06-26 14:39:00
3689	2014-06-26 14:40:00	2014-06-26 14:49:00
3690	2014-06-26 14:50:00	2014-06-26 14:59:00
3691	2014-06-26 15:00:00	2014-06-26 15:09:00
3692	2014-06-26 15:10:00	2014-06-26 15:19:00
3693	2014-06-26 15:20:00	2014-06-26 15:29:00
3694	2014-06-26 15:30:00	2014-06-26 15:39:00
3695	2014-06-26 15:40:00	2014-06-26 15:49:00
3696	2014-06-26 15:50:00	2014-06-26 15:59:00
3697	2014-06-26 16:00:00	2014-06-26 16:09:00
3698	2014-06-26 16:10:00	2014-06-26 16:19:00
3699	2014-06-26 16:20:00	2014-06-26 16:29:00
3700	2014-06-26 16:30:00	2014-06-26 16:39:00
3701	2014-06-26 16:40:00	2014-06-26 16:49:00
3702	2014-06-26 16:50:00	2014-06-26 16:59:00
3703	2014-06-26 17:00:00	2014-06-26 17:09:00
3704	2014-06-26 17:10:00	2014-06-26 17:19:00
3705	2014-06-26 17:20:00	2014-06-26 17:29:00
3706	2014-06-26 17:30:00	2014-06-26 17:39:00
3707	2014-06-26 17:40:00	2014-06-26 17:49:00
3708	2014-06-26 17:50:00	2014-06-26 17:59:00
3709	2014-06-26 18:00:00	2014-06-26 18:09:00
3710	2014-06-26 18:10:00	2014-06-26 18:19:00
3711	2014-06-26 18:20:00	2014-06-26 18:29:00
3712	2014-06-26 18:30:00	2014-06-26 18:39:00
3713	2014-06-26 18:40:00	2014-06-26 18:49:00
3714	2014-06-26 18:50:00	2014-06-26 18:59:00
3715	2014-06-26 19:00:00	2014-06-26 19:09:00
3716	2014-06-26 19:10:00	2014-06-26 19:19:00
3717	2014-06-26 19:20:00	2014-06-26 19:29:00
3718	2014-06-26 19:30:00	2014-06-26 19:39:00
3719	2014-06-26 19:40:00	2014-06-26 19:49:00
3720	2014-06-26 19:50:00	2014-06-26 19:59:00
3721	2014-06-26 20:00:00	2014-06-26 20:09:00
3722	2014-06-26 20:10:00	2014-06-26 20:19:00
3723	2014-06-26 20:20:00	2014-06-26 20:29:00
3724	2014-06-26 20:30:00	2014-06-26 20:39:00
3725	2014-06-26 20:40:00	2014-06-26 20:49:00
3726	2014-06-26 20:50:00	2014-06-26 20:59:00
3727	2014-06-26 21:00:00	2014-06-26 21:09:00
3728	2014-06-26 21:10:00	2014-06-26 21:19:00
3729	2014-06-26 21:20:00	2014-06-26 21:29:00
3730	2014-06-26 21:30:00	2014-06-26 21:39:00
3731	2014-06-26 21:40:00	2014-06-26 21:49:00
3732	2014-06-26 21:50:00	2014-06-26 21:59:00
3733	2014-06-26 22:00:00	2014-06-26 22:09:00
3734	2014-06-26 22:10:00	2014-06-26 22:19:00
3735	2014-06-26 22:20:00	2014-06-26 22:29:00
3736	2014-06-26 22:30:00	2014-06-26 22:39:00
3737	2014-06-26 22:40:00	2014-06-26 22:49:00
3738	2014-06-26 22:50:00	2014-06-26 22:59:00
3739	2014-06-26 23:00:00	2014-06-26 23:09:00
3740	2014-06-26 23:10:00	2014-06-26 23:19:00
3741	2014-06-26 23:20:00	2014-06-26 23:29:00
3742	2014-06-26 23:30:00	2014-06-26 23:39:00
3743	2014-06-26 23:40:00	2014-06-26 23:49:00
3744	2014-06-26 23:50:00	2014-06-26 23:59:00
3745	2014-06-27 00:00:00	2014-06-27 00:09:00
3746	2014-06-27 00:10:00	2014-06-27 00:19:00
3747	2014-06-27 00:20:00	2014-06-27 00:29:00
3748	2014-06-27 00:30:00	2014-06-27 00:39:00
3749	2014-06-27 00:40:00	2014-06-27 00:49:00
3750	2014-06-27 00:50:00	2014-06-27 00:59:00
3751	2014-06-27 01:00:00	2014-06-27 01:09:00
3752	2014-06-27 01:10:00	2014-06-27 01:19:00
3753	2014-06-27 01:20:00	2014-06-27 01:29:00
3754	2014-06-27 01:30:00	2014-06-27 01:39:00
3755	2014-06-27 01:40:00	2014-06-27 01:49:00
3756	2014-06-27 01:50:00	2014-06-27 01:59:00
3757	2014-06-27 02:00:00	2014-06-27 02:09:00
3758	2014-06-27 02:10:00	2014-06-27 02:19:00
3759	2014-06-27 02:20:00	2014-06-27 02:29:00
3760	2014-06-27 02:30:00	2014-06-27 02:39:00
3761	2014-06-27 02:40:00	2014-06-27 02:49:00
3762	2014-06-27 02:50:00	2014-06-27 02:59:00
3763	2014-06-27 03:00:00	2014-06-27 03:09:00
3764	2014-06-27 03:10:00	2014-06-27 03:19:00
3765	2014-06-27 03:20:00	2014-06-27 03:29:00
3766	2014-06-27 03:30:00	2014-06-27 03:39:00
3767	2014-06-27 03:40:00	2014-06-27 03:49:00
3768	2014-06-27 03:50:00	2014-06-27 03:59:00
3769	2014-06-27 04:00:00	2014-06-27 04:09:00
3770	2014-06-27 04:10:00	2014-06-27 04:19:00
3771	2014-06-27 04:20:00	2014-06-27 04:29:00
3772	2014-06-27 04:30:00	2014-06-27 04:39:00
3773	2014-06-27 04:40:00	2014-06-27 04:49:00
3774	2014-06-27 04:50:00	2014-06-27 04:59:00
3775	2014-06-27 05:00:00	2014-06-27 05:09:00
3776	2014-06-27 05:10:00	2014-06-27 05:19:00
3777	2014-06-27 05:20:00	2014-06-27 05:29:00
3778	2014-06-27 05:30:00	2014-06-27 05:39:00
3779	2014-06-27 05:40:00	2014-06-27 05:49:00
3780	2014-06-27 05:50:00	2014-06-27 05:59:00
3781	2014-06-27 06:00:00	2014-06-27 06:09:00
3782	2014-06-27 06:10:00	2014-06-27 06:19:00
3783	2014-06-27 06:20:00	2014-06-27 06:29:00
3784	2014-06-27 06:30:00	2014-06-27 06:39:00
3785	2014-06-27 06:40:00	2014-06-27 06:49:00
3786	2014-06-27 06:50:00	2014-06-27 06:59:00
3787	2014-06-27 07:00:00	2014-06-27 07:09:00
3788	2014-06-27 07:10:00	2014-06-27 07:19:00
3789	2014-06-27 07:20:00	2014-06-27 07:29:00
3790	2014-06-27 07:30:00	2014-06-27 07:39:00
3791	2014-06-27 07:40:00	2014-06-27 07:49:00
3792	2014-06-27 07:50:00	2014-06-27 07:59:00
3793	2014-06-27 08:00:00	2014-06-27 08:09:00
3794	2014-06-27 08:10:00	2014-06-27 08:19:00
3795	2014-06-27 08:20:00	2014-06-27 08:29:00
3796	2014-06-27 08:30:00	2014-06-27 08:39:00
3797	2014-06-27 08:40:00	2014-06-27 08:49:00
3798	2014-06-27 08:50:00	2014-06-27 08:59:00
3799	2014-06-27 09:00:00	2014-06-27 09:09:00
3800	2014-06-27 09:10:00	2014-06-27 09:19:00
3801	2014-06-27 09:20:00	2014-06-27 09:29:00
3802	2014-06-27 09:30:00	2014-06-27 09:39:00
3803	2014-06-27 09:40:00	2014-06-27 09:49:00
3804	2014-06-27 09:50:00	2014-06-27 09:59:00
3805	2014-06-27 10:00:00	2014-06-27 10:09:00
3806	2014-06-27 10:10:00	2014-06-27 10:19:00
3807	2014-06-27 10:20:00	2014-06-27 10:29:00
3808	2014-06-27 10:30:00	2014-06-27 10:39:00
3809	2014-06-27 10:40:00	2014-06-27 10:49:00
3810	2014-06-27 10:50:00	2014-06-27 10:59:00
3811	2014-06-27 11:00:00	2014-06-27 11:09:00
3812	2014-06-27 11:10:00	2014-06-27 11:19:00
3813	2014-06-27 11:20:00	2014-06-27 11:29:00
3814	2014-06-27 11:30:00	2014-06-27 11:39:00
3815	2014-06-27 11:40:00	2014-06-27 11:49:00
3816	2014-06-27 11:50:00	2014-06-27 11:59:00
3817	2014-06-27 12:00:00	2014-06-27 12:09:00
3818	2014-06-27 12:10:00	2014-06-27 12:19:00
3819	2014-06-27 12:20:00	2014-06-27 12:29:00
3820	2014-06-27 12:30:00	2014-06-27 12:39:00
3821	2014-06-27 12:40:00	2014-06-27 12:49:00
3822	2014-06-27 12:50:00	2014-06-27 12:59:00
3823	2014-06-27 13:00:00	2014-06-27 13:09:00
3824	2014-06-27 13:10:00	2014-06-27 13:19:00
3825	2014-06-27 13:20:00	2014-06-27 13:29:00
3826	2014-06-27 13:30:00	2014-06-27 13:39:00
3827	2014-06-27 13:40:00	2014-06-27 13:49:00
3828	2014-06-27 13:50:00	2014-06-27 13:59:00
3829	2014-06-27 14:00:00	2014-06-27 14:09:00
3830	2014-06-27 14:10:00	2014-06-27 14:19:00
3831	2014-06-27 14:20:00	2014-06-27 14:29:00
3832	2014-06-27 14:30:00	2014-06-27 14:39:00
3833	2014-06-27 14:40:00	2014-06-27 14:49:00
3834	2014-06-27 14:50:00	2014-06-27 14:59:00
3835	2014-06-27 15:00:00	2014-06-27 15:09:00
3836	2014-06-27 15:10:00	2014-06-27 15:19:00
3837	2014-06-27 15:20:00	2014-06-27 15:29:00
3838	2014-06-27 15:30:00	2014-06-27 15:39:00
3839	2014-06-27 15:40:00	2014-06-27 15:49:00
3840	2014-06-27 15:50:00	2014-06-27 15:59:00
3841	2014-06-27 16:00:00	2014-06-27 16:09:00
3842	2014-06-27 16:10:00	2014-06-27 16:19:00
3843	2014-06-27 16:20:00	2014-06-27 16:29:00
3844	2014-06-27 16:30:00	2014-06-27 16:39:00
3845	2014-06-27 16:40:00	2014-06-27 16:49:00
3846	2014-06-27 16:50:00	2014-06-27 16:59:00
3847	2014-06-27 17:00:00	2014-06-27 17:09:00
3848	2014-06-27 17:10:00	2014-06-27 17:19:00
3849	2014-06-27 17:20:00	2014-06-27 17:29:00
3850	2014-06-27 17:30:00	2014-06-27 17:39:00
3851	2014-06-27 17:40:00	2014-06-27 17:49:00
3852	2014-06-27 17:50:00	2014-06-27 17:59:00
3853	2014-06-27 18:00:00	2014-06-27 18:09:00
3854	2014-06-27 18:10:00	2014-06-27 18:19:00
3855	2014-06-27 18:20:00	2014-06-27 18:29:00
3856	2014-06-27 18:30:00	2014-06-27 18:39:00
3857	2014-06-27 18:40:00	2014-06-27 18:49:00
3858	2014-06-27 18:50:00	2014-06-27 18:59:00
3859	2014-06-27 19:00:00	2014-06-27 19:09:00
3860	2014-06-27 19:10:00	2014-06-27 19:19:00
3861	2014-06-27 19:20:00	2014-06-27 19:29:00
3862	2014-06-27 19:30:00	2014-06-27 19:39:00
3863	2014-06-27 19:40:00	2014-06-27 19:49:00
3864	2014-06-27 19:50:00	2014-06-27 19:59:00
3865	2014-06-27 20:00:00	2014-06-27 20:09:00
3866	2014-06-27 20:10:00	2014-06-27 20:19:00
3867	2014-06-27 20:20:00	2014-06-27 20:29:00
3868	2014-06-27 20:30:00	2014-06-27 20:39:00
3869	2014-06-27 20:40:00	2014-06-27 20:49:00
3870	2014-06-27 20:50:00	2014-06-27 20:59:00
3871	2014-06-27 21:00:00	2014-06-27 21:09:00
3872	2014-06-27 21:10:00	2014-06-27 21:19:00
3873	2014-06-27 21:20:00	2014-06-27 21:29:00
3874	2014-06-27 21:30:00	2014-06-27 21:39:00
3875	2014-06-27 21:40:00	2014-06-27 21:49:00
3876	2014-06-27 21:50:00	2014-06-27 21:59:00
3877	2014-06-27 22:00:00	2014-06-27 22:09:00
3878	2014-06-27 22:10:00	2014-06-27 22:19:00
3879	2014-06-27 22:20:00	2014-06-27 22:29:00
3880	2014-06-27 22:30:00	2014-06-27 22:39:00
3881	2014-06-27 22:40:00	2014-06-27 22:49:00
3882	2014-06-27 22:50:00	2014-06-27 22:59:00
3883	2014-06-27 23:00:00	2014-06-27 23:09:00
3884	2014-06-27 23:10:00	2014-06-27 23:19:00
3885	2014-06-27 23:20:00	2014-06-27 23:29:00
3886	2014-06-27 23:30:00	2014-06-27 23:39:00
3887	2014-06-27 23:40:00	2014-06-27 23:49:00
3888	2014-06-27 23:50:00	2014-06-27 23:59:00
3889	2014-06-28 00:00:00	2014-06-28 00:09:00
3890	2014-06-28 00:10:00	2014-06-28 00:19:00
3891	2014-06-28 00:20:00	2014-06-28 00:29:00
3892	2014-06-28 00:30:00	2014-06-28 00:39:00
3893	2014-06-28 00:40:00	2014-06-28 00:49:00
3894	2014-06-28 00:50:00	2014-06-28 00:59:00
3895	2014-06-28 01:00:00	2014-06-28 01:09:00
3896	2014-06-28 01:10:00	2014-06-28 01:19:00
3897	2014-06-28 01:20:00	2014-06-28 01:29:00
3898	2014-06-28 01:30:00	2014-06-28 01:39:00
3899	2014-06-28 01:40:00	2014-06-28 01:49:00
3900	2014-06-28 01:50:00	2014-06-28 01:59:00
3901	2014-06-28 02:00:00	2014-06-28 02:09:00
3902	2014-06-28 02:10:00	2014-06-28 02:19:00
3903	2014-06-28 02:20:00	2014-06-28 02:29:00
3904	2014-06-28 02:30:00	2014-06-28 02:39:00
3905	2014-06-28 02:40:00	2014-06-28 02:49:00
3906	2014-06-28 02:50:00	2014-06-28 02:59:00
3907	2014-06-28 03:00:00	2014-06-28 03:09:00
3908	2014-06-28 03:10:00	2014-06-28 03:19:00
3909	2014-06-28 03:20:00	2014-06-28 03:29:00
3910	2014-06-28 03:30:00	2014-06-28 03:39:00
3911	2014-06-28 03:40:00	2014-06-28 03:49:00
3912	2014-06-28 03:50:00	2014-06-28 03:59:00
3913	2014-06-28 04:00:00	2014-06-28 04:09:00
3914	2014-06-28 04:10:00	2014-06-28 04:19:00
3915	2014-06-28 04:20:00	2014-06-28 04:29:00
3916	2014-06-28 04:30:00	2014-06-28 04:39:00
3917	2014-06-28 04:40:00	2014-06-28 04:49:00
3918	2014-06-28 04:50:00	2014-06-28 04:59:00
3919	2014-06-28 05:00:00	2014-06-28 05:09:00
3920	2014-06-28 05:10:00	2014-06-28 05:19:00
3921	2014-06-28 05:20:00	2014-06-28 05:29:00
3922	2014-06-28 05:30:00	2014-06-28 05:39:00
3923	2014-06-28 05:40:00	2014-06-28 05:49:00
3924	2014-06-28 05:50:00	2014-06-28 05:59:00
3925	2014-06-28 06:00:00	2014-06-28 06:09:00
3926	2014-06-28 06:10:00	2014-06-28 06:19:00
3927	2014-06-28 06:20:00	2014-06-28 06:29:00
3928	2014-06-28 06:30:00	2014-06-28 06:39:00
3929	2014-06-28 06:40:00	2014-06-28 06:49:00
3930	2014-06-28 06:50:00	2014-06-28 06:59:00
3931	2014-06-28 07:00:00	2014-06-28 07:09:00
3932	2014-06-28 07:10:00	2014-06-28 07:19:00
3933	2014-06-28 07:20:00	2014-06-28 07:29:00
3934	2014-06-28 07:30:00	2014-06-28 07:39:00
3935	2014-06-28 07:40:00	2014-06-28 07:49:00
3936	2014-06-28 07:50:00	2014-06-28 07:59:00
3937	2014-06-28 08:00:00	2014-06-28 08:09:00
3938	2014-06-28 08:10:00	2014-06-28 08:19:00
3939	2014-06-28 08:20:00	2014-06-28 08:29:00
3940	2014-06-28 08:30:00	2014-06-28 08:39:00
3941	2014-06-28 08:40:00	2014-06-28 08:49:00
3942	2014-06-28 08:50:00	2014-06-28 08:59:00
3943	2014-06-28 09:00:00	2014-06-28 09:09:00
3944	2014-06-28 09:10:00	2014-06-28 09:19:00
3945	2014-06-28 09:20:00	2014-06-28 09:29:00
3946	2014-06-28 09:30:00	2014-06-28 09:39:00
3947	2014-06-28 09:40:00	2014-06-28 09:49:00
3948	2014-06-28 09:50:00	2014-06-28 09:59:00
3949	2014-06-28 10:00:00	2014-06-28 10:09:00
3950	2014-06-28 10:10:00	2014-06-28 10:19:00
3951	2014-06-28 10:20:00	2014-06-28 10:29:00
3952	2014-06-28 10:30:00	2014-06-28 10:39:00
3953	2014-06-28 10:40:00	2014-06-28 10:49:00
3954	2014-06-28 10:50:00	2014-06-28 10:59:00
3955	2014-06-28 11:00:00	2014-06-28 11:09:00
3956	2014-06-28 11:10:00	2014-06-28 11:19:00
3957	2014-06-28 11:20:00	2014-06-28 11:29:00
3958	2014-06-28 11:30:00	2014-06-28 11:39:00
3959	2014-06-28 11:40:00	2014-06-28 11:49:00
3960	2014-06-28 11:50:00	2014-06-28 11:59:00
3961	2014-06-28 12:00:00	2014-06-28 12:09:00
3962	2014-06-28 12:10:00	2014-06-28 12:19:00
3963	2014-06-28 12:20:00	2014-06-28 12:29:00
3964	2014-06-28 12:30:00	2014-06-28 12:39:00
3965	2014-06-28 12:40:00	2014-06-28 12:49:00
3966	2014-06-28 12:50:00	2014-06-28 12:59:00
3967	2014-06-28 13:00:00	2014-06-28 13:09:00
3968	2014-06-28 13:10:00	2014-06-28 13:19:00
3969	2014-06-28 13:20:00	2014-06-28 13:29:00
3970	2014-06-28 13:30:00	2014-06-28 13:39:00
3971	2014-06-28 13:40:00	2014-06-28 13:49:00
3972	2014-06-28 13:50:00	2014-06-28 13:59:00
3973	2014-06-28 14:00:00	2014-06-28 14:09:00
3974	2014-06-28 14:10:00	2014-06-28 14:19:00
3975	2014-06-28 14:20:00	2014-06-28 14:29:00
3976	2014-06-28 14:30:00	2014-06-28 14:39:00
3977	2014-06-28 14:40:00	2014-06-28 14:49:00
3978	2014-06-28 14:50:00	2014-06-28 14:59:00
3979	2014-06-28 15:00:00	2014-06-28 15:09:00
3980	2014-06-28 15:10:00	2014-06-28 15:19:00
3981	2014-06-28 15:20:00	2014-06-28 15:29:00
3982	2014-06-28 15:30:00	2014-06-28 15:39:00
3983	2014-06-28 15:40:00	2014-06-28 15:49:00
3984	2014-06-28 15:50:00	2014-06-28 15:59:00
3985	2014-06-28 16:00:00	2014-06-28 16:09:00
3986	2014-06-28 16:10:00	2014-06-28 16:19:00
3987	2014-06-28 16:20:00	2014-06-28 16:29:00
3988	2014-06-28 16:30:00	2014-06-28 16:39:00
3989	2014-06-28 16:40:00	2014-06-28 16:49:00
3990	2014-06-28 16:50:00	2014-06-28 16:59:00
3991	2014-06-28 17:00:00	2014-06-28 17:09:00
3992	2014-06-28 17:10:00	2014-06-28 17:19:00
3993	2014-06-28 17:20:00	2014-06-28 17:29:00
3994	2014-06-28 17:30:00	2014-06-28 17:39:00
3995	2014-06-28 17:40:00	2014-06-28 17:49:00
3996	2014-06-28 17:50:00	2014-06-28 17:59:00
3997	2014-06-28 18:00:00	2014-06-28 18:09:00
3998	2014-06-28 18:10:00	2014-06-28 18:19:00
3999	2014-06-28 18:20:00	2014-06-28 18:29:00
4000	2014-06-28 18:30:00	2014-06-28 18:39:00
4001	2014-06-28 18:40:00	2014-06-28 18:49:00
4002	2014-06-28 18:50:00	2014-06-28 18:59:00
4003	2014-06-28 19:00:00	2014-06-28 19:09:00
4004	2014-06-28 19:10:00	2014-06-28 19:19:00
4005	2014-06-28 19:20:00	2014-06-28 19:29:00
4006	2014-06-28 19:30:00	2014-06-28 19:39:00
4007	2014-06-28 19:40:00	2014-06-28 19:49:00
4008	2014-06-28 19:50:00	2014-06-28 19:59:00
4009	2014-06-28 20:00:00	2014-06-28 20:09:00
4010	2014-06-28 20:10:00	2014-06-28 20:19:00
4011	2014-06-28 20:20:00	2014-06-28 20:29:00
4012	2014-06-28 20:30:00	2014-06-28 20:39:00
4013	2014-06-28 20:40:00	2014-06-28 20:49:00
4014	2014-06-28 20:50:00	2014-06-28 20:59:00
4015	2014-06-28 21:00:00	2014-06-28 21:09:00
4016	2014-06-28 21:10:00	2014-06-28 21:19:00
4017	2014-06-28 21:20:00	2014-06-28 21:29:00
4018	2014-06-28 21:30:00	2014-06-28 21:39:00
4019	2014-06-28 21:40:00	2014-06-28 21:49:00
4020	2014-06-28 21:50:00	2014-06-28 21:59:00
4021	2014-06-28 22:00:00	2014-06-28 22:09:00
4022	2014-06-28 22:10:00	2014-06-28 22:19:00
4023	2014-06-28 22:20:00	2014-06-28 22:29:00
4024	2014-06-28 22:30:00	2014-06-28 22:39:00
4025	2014-06-28 22:40:00	2014-06-28 22:49:00
4026	2014-06-28 22:50:00	2014-06-28 22:59:00
4027	2014-06-28 23:00:00	2014-06-28 23:09:00
4028	2014-06-28 23:10:00	2014-06-28 23:19:00
4029	2014-06-28 23:20:00	2014-06-28 23:29:00
4030	2014-06-28 23:30:00	2014-06-28 23:39:00
4031	2014-06-28 23:40:00	2014-06-28 23:49:00
4032	2014-06-28 23:50:00	2014-06-28 23:59:00
4033	2014-06-29 00:00:00	2014-06-29 00:09:00
4034	2014-06-29 00:10:00	2014-06-29 00:19:00
4035	2014-06-29 00:20:00	2014-06-29 00:29:00
4036	2014-06-29 00:30:00	2014-06-29 00:39:00
4037	2014-06-29 00:40:00	2014-06-29 00:49:00
4038	2014-06-29 00:50:00	2014-06-29 00:59:00
4039	2014-06-29 01:00:00	2014-06-29 01:09:00
4040	2014-06-29 01:10:00	2014-06-29 01:19:00
4041	2014-06-29 01:20:00	2014-06-29 01:29:00
4042	2014-06-29 01:30:00	2014-06-29 01:39:00
4043	2014-06-29 01:40:00	2014-06-29 01:49:00
4044	2014-06-29 01:50:00	2014-06-29 01:59:00
4045	2014-06-29 02:00:00	2014-06-29 02:09:00
4046	2014-06-29 02:10:00	2014-06-29 02:19:00
4047	2014-06-29 02:20:00	2014-06-29 02:29:00
4048	2014-06-29 02:30:00	2014-06-29 02:39:00
4049	2014-06-29 02:40:00	2014-06-29 02:49:00
4050	2014-06-29 02:50:00	2014-06-29 02:59:00
4051	2014-06-29 03:00:00	2014-06-29 03:09:00
4052	2014-06-29 03:10:00	2014-06-29 03:19:00
4053	2014-06-29 03:20:00	2014-06-29 03:29:00
4054	2014-06-29 03:30:00	2014-06-29 03:39:00
4055	2014-06-29 03:40:00	2014-06-29 03:49:00
4056	2014-06-29 03:50:00	2014-06-29 03:59:00
4057	2014-06-29 04:00:00	2014-06-29 04:09:00
4058	2014-06-29 04:10:00	2014-06-29 04:19:00
4059	2014-06-29 04:20:00	2014-06-29 04:29:00
4060	2014-06-29 04:30:00	2014-06-29 04:39:00
4061	2014-06-29 04:40:00	2014-06-29 04:49:00
4062	2014-06-29 04:50:00	2014-06-29 04:59:00
4063	2014-06-29 05:00:00	2014-06-29 05:09:00
4064	2014-06-29 05:10:00	2014-06-29 05:19:00
4065	2014-06-29 05:20:00	2014-06-29 05:29:00
4066	2014-06-29 05:30:00	2014-06-29 05:39:00
4067	2014-06-29 05:40:00	2014-06-29 05:49:00
4068	2014-06-29 05:50:00	2014-06-29 05:59:00
4069	2014-06-29 06:00:00	2014-06-29 06:09:00
4070	2014-06-29 06:10:00	2014-06-29 06:19:00
4071	2014-06-29 06:20:00	2014-06-29 06:29:00
4072	2014-06-29 06:30:00	2014-06-29 06:39:00
4073	2014-06-29 06:40:00	2014-06-29 06:49:00
4074	2014-06-29 06:50:00	2014-06-29 06:59:00
4075	2014-06-29 07:00:00	2014-06-29 07:09:00
4076	2014-06-29 07:10:00	2014-06-29 07:19:00
4077	2014-06-29 07:20:00	2014-06-29 07:29:00
4078	2014-06-29 07:30:00	2014-06-29 07:39:00
4079	2014-06-29 07:40:00	2014-06-29 07:49:00
4080	2014-06-29 07:50:00	2014-06-29 07:59:00
4081	2014-06-29 08:00:00	2014-06-29 08:09:00
4082	2014-06-29 08:10:00	2014-06-29 08:19:00
4083	2014-06-29 08:20:00	2014-06-29 08:29:00
4084	2014-06-29 08:30:00	2014-06-29 08:39:00
4085	2014-06-29 08:40:00	2014-06-29 08:49:00
4086	2014-06-29 08:50:00	2014-06-29 08:59:00
4087	2014-06-29 09:00:00	2014-06-29 09:09:00
4088	2014-06-29 09:10:00	2014-06-29 09:19:00
4089	2014-06-29 09:20:00	2014-06-29 09:29:00
4090	2014-06-29 09:30:00	2014-06-29 09:39:00
4091	2014-06-29 09:40:00	2014-06-29 09:49:00
4092	2014-06-29 09:50:00	2014-06-29 09:59:00
4093	2014-06-29 10:00:00	2014-06-29 10:09:00
4094	2014-06-29 10:10:00	2014-06-29 10:19:00
4095	2014-06-29 10:20:00	2014-06-29 10:29:00
4096	2014-06-29 10:30:00	2014-06-29 10:39:00
4097	2014-06-29 10:40:00	2014-06-29 10:49:00
4098	2014-06-29 10:50:00	2014-06-29 10:59:00
4099	2014-06-29 11:00:00	2014-06-29 11:09:00
4100	2014-06-29 11:10:00	2014-06-29 11:19:00
4101	2014-06-29 11:20:00	2014-06-29 11:29:00
4102	2014-06-29 11:30:00	2014-06-29 11:39:00
4103	2014-06-29 11:40:00	2014-06-29 11:49:00
4104	2014-06-29 11:50:00	2014-06-29 11:59:00
4105	2014-06-29 12:00:00	2014-06-29 12:09:00
4106	2014-06-29 12:10:00	2014-06-29 12:19:00
4107	2014-06-29 12:20:00	2014-06-29 12:29:00
4108	2014-06-29 12:30:00	2014-06-29 12:39:00
4109	2014-06-29 12:40:00	2014-06-29 12:49:00
4110	2014-06-29 12:50:00	2014-06-29 12:59:00
4111	2014-06-29 13:00:00	2014-06-29 13:09:00
4112	2014-06-29 13:10:00	2014-06-29 13:19:00
4113	2014-06-29 13:20:00	2014-06-29 13:29:00
4114	2014-06-29 13:30:00	2014-06-29 13:39:00
4115	2014-06-29 13:40:00	2014-06-29 13:49:00
4116	2014-06-29 13:50:00	2014-06-29 13:59:00
4117	2014-06-29 14:00:00	2014-06-29 14:09:00
4118	2014-06-29 14:10:00	2014-06-29 14:19:00
4119	2014-06-29 14:20:00	2014-06-29 14:29:00
4120	2014-06-29 14:30:00	2014-06-29 14:39:00
4121	2014-06-29 14:40:00	2014-06-29 14:49:00
4122	2014-06-29 14:50:00	2014-06-29 14:59:00
4123	2014-06-29 15:00:00	2014-06-29 15:09:00
4124	2014-06-29 15:10:00	2014-06-29 15:19:00
4125	2014-06-29 15:20:00	2014-06-29 15:29:00
4126	2014-06-29 15:30:00	2014-06-29 15:39:00
4127	2014-06-29 15:40:00	2014-06-29 15:49:00
4128	2014-06-29 15:50:00	2014-06-29 15:59:00
4129	2014-06-29 16:00:00	2014-06-29 16:09:00
4130	2014-06-29 16:10:00	2014-06-29 16:19:00
4131	2014-06-29 16:20:00	2014-06-29 16:29:00
4132	2014-06-29 16:30:00	2014-06-29 16:39:00
4133	2014-06-29 16:40:00	2014-06-29 16:49:00
4134	2014-06-29 16:50:00	2014-06-29 16:59:00
4135	2014-06-29 17:00:00	2014-06-29 17:09:00
4136	2014-06-29 17:10:00	2014-06-29 17:19:00
4137	2014-06-29 17:20:00	2014-06-29 17:29:00
4138	2014-06-29 17:30:00	2014-06-29 17:39:00
4139	2014-06-29 17:40:00	2014-06-29 17:49:00
4140	2014-06-29 17:50:00	2014-06-29 17:59:00
4141	2014-06-29 18:00:00	2014-06-29 18:09:00
4142	2014-06-29 18:10:00	2014-06-29 18:19:00
4143	2014-06-29 18:20:00	2014-06-29 18:29:00
4144	2014-06-29 18:30:00	2014-06-29 18:39:00
4145	2014-06-29 18:40:00	2014-06-29 18:49:00
4146	2014-06-29 18:50:00	2014-06-29 18:59:00
4147	2014-06-29 19:00:00	2014-06-29 19:09:00
4148	2014-06-29 19:10:00	2014-06-29 19:19:00
4149	2014-06-29 19:20:00	2014-06-29 19:29:00
4150	2014-06-29 19:30:00	2014-06-29 19:39:00
4151	2014-06-29 19:40:00	2014-06-29 19:49:00
4152	2014-06-29 19:50:00	2014-06-29 19:59:00
4153	2014-06-29 20:00:00	2014-06-29 20:09:00
4154	2014-06-29 20:10:00	2014-06-29 20:19:00
4155	2014-06-29 20:20:00	2014-06-29 20:29:00
4156	2014-06-29 20:30:00	2014-06-29 20:39:00
4157	2014-06-29 20:40:00	2014-06-29 20:49:00
4158	2014-06-29 20:50:00	2014-06-29 20:59:00
4159	2014-06-29 21:00:00	2014-06-29 21:09:00
4160	2014-06-29 21:10:00	2014-06-29 21:19:00
4161	2014-06-29 21:20:00	2014-06-29 21:29:00
4162	2014-06-29 21:30:00	2014-06-29 21:39:00
4163	2014-06-29 21:40:00	2014-06-29 21:49:00
4164	2014-06-29 21:50:00	2014-06-29 21:59:00
4165	2014-06-29 22:00:00	2014-06-29 22:09:00
4166	2014-06-29 22:10:00	2014-06-29 22:19:00
4167	2014-06-29 22:20:00	2014-06-29 22:29:00
4168	2014-06-29 22:30:00	2014-06-29 22:39:00
4169	2014-06-29 22:40:00	2014-06-29 22:49:00
4170	2014-06-29 22:50:00	2014-06-29 22:59:00
4171	2014-06-29 23:00:00	2014-06-29 23:09:00
4172	2014-06-29 23:10:00	2014-06-29 23:19:00
4173	2014-06-29 23:20:00	2014-06-29 23:29:00
4174	2014-06-29 23:30:00	2014-06-29 23:39:00
4175	2014-06-29 23:40:00	2014-06-29 23:49:00
4176	2014-06-29 23:50:00	2014-06-29 23:59:00
4177	2014-06-30 00:00:00	2014-06-30 00:09:00
4178	2014-06-30 00:10:00	2014-06-30 00:19:00
4179	2014-06-30 00:20:00	2014-06-30 00:29:00
4180	2014-06-30 00:30:00	2014-06-30 00:39:00
4181	2014-06-30 00:40:00	2014-06-30 00:49:00
4182	2014-06-30 00:50:00	2014-06-30 00:59:00
4183	2014-06-30 01:00:00	2014-06-30 01:09:00
4184	2014-06-30 01:10:00	2014-06-30 01:19:00
4185	2014-06-30 01:20:00	2014-06-30 01:29:00
4186	2014-06-30 01:30:00	2014-06-30 01:39:00
4187	2014-06-30 01:40:00	2014-06-30 01:49:00
4188	2014-06-30 01:50:00	2014-06-30 01:59:00
4189	2014-06-30 02:00:00	2014-06-30 02:09:00
4190	2014-06-30 02:10:00	2014-06-30 02:19:00
4191	2014-06-30 02:20:00	2014-06-30 02:29:00
4192	2014-06-30 02:30:00	2014-06-30 02:39:00
4193	2014-06-30 02:40:00	2014-06-30 02:49:00
4194	2014-06-30 02:50:00	2014-06-30 02:59:00
4195	2014-06-30 03:00:00	2014-06-30 03:09:00
4196	2014-06-30 03:10:00	2014-06-30 03:19:00
4197	2014-06-30 03:20:00	2014-06-30 03:29:00
4198	2014-06-30 03:30:00	2014-06-30 03:39:00
4199	2014-06-30 03:40:00	2014-06-30 03:49:00
4200	2014-06-30 03:50:00	2014-06-30 03:59:00
4201	2014-06-30 04:00:00	2014-06-30 04:09:00
4202	2014-06-30 04:10:00	2014-06-30 04:19:00
4203	2014-06-30 04:20:00	2014-06-30 04:29:00
4204	2014-06-30 04:30:00	2014-06-30 04:39:00
4205	2014-06-30 04:40:00	2014-06-30 04:49:00
4206	2014-06-30 04:50:00	2014-06-30 04:59:00
4207	2014-06-30 05:00:00	2014-06-30 05:09:00
4208	2014-06-30 05:10:00	2014-06-30 05:19:00
4209	2014-06-30 05:20:00	2014-06-30 05:29:00
4210	2014-06-30 05:30:00	2014-06-30 05:39:00
4211	2014-06-30 05:40:00	2014-06-30 05:49:00
4212	2014-06-30 05:50:00	2014-06-30 05:59:00
4213	2014-06-30 06:00:00	2014-06-30 06:09:00
4214	2014-06-30 06:10:00	2014-06-30 06:19:00
4215	2014-06-30 06:20:00	2014-06-30 06:29:00
4216	2014-06-30 06:30:00	2014-06-30 06:39:00
4217	2014-06-30 06:40:00	2014-06-30 06:49:00
4218	2014-06-30 06:50:00	2014-06-30 06:59:00
4219	2014-06-30 07:00:00	2014-06-30 07:09:00
4220	2014-06-30 07:10:00	2014-06-30 07:19:00
4221	2014-06-30 07:20:00	2014-06-30 07:29:00
4222	2014-06-30 07:30:00	2014-06-30 07:39:00
4223	2014-06-30 07:40:00	2014-06-30 07:49:00
4224	2014-06-30 07:50:00	2014-06-30 07:59:00
4225	2014-06-30 08:00:00	2014-06-30 08:09:00
4226	2014-06-30 08:10:00	2014-06-30 08:19:00
4227	2014-06-30 08:20:00	2014-06-30 08:29:00
4228	2014-06-30 08:30:00	2014-06-30 08:39:00
4229	2014-06-30 08:40:00	2014-06-30 08:49:00
4230	2014-06-30 08:50:00	2014-06-30 08:59:00
4231	2014-06-30 09:00:00	2014-06-30 09:09:00
4232	2014-06-30 09:10:00	2014-06-30 09:19:00
4233	2014-06-30 09:20:00	2014-06-30 09:29:00
4234	2014-06-30 09:30:00	2014-06-30 09:39:00
4235	2014-06-30 09:40:00	2014-06-30 09:49:00
4236	2014-06-30 09:50:00	2014-06-30 09:59:00
4237	2014-06-30 10:00:00	2014-06-30 10:09:00
4238	2014-06-30 10:10:00	2014-06-30 10:19:00
4239	2014-06-30 10:20:00	2014-06-30 10:29:00
4240	2014-06-30 10:30:00	2014-06-30 10:39:00
4241	2014-06-30 10:40:00	2014-06-30 10:49:00
4242	2014-06-30 10:50:00	2014-06-30 10:59:00
4243	2014-06-30 11:00:00	2014-06-30 11:09:00
4244	2014-06-30 11:10:00	2014-06-30 11:19:00
4245	2014-06-30 11:20:00	2014-06-30 11:29:00
4246	2014-06-30 11:30:00	2014-06-30 11:39:00
4247	2014-06-30 11:40:00	2014-06-30 11:49:00
4248	2014-06-30 11:50:00	2014-06-30 11:59:00
4249	2014-06-30 12:00:00	2014-06-30 12:09:00
4250	2014-06-30 12:10:00	2014-06-30 12:19:00
4251	2014-06-30 12:20:00	2014-06-30 12:29:00
4252	2014-06-30 12:30:00	2014-06-30 12:39:00
4253	2014-06-30 12:40:00	2014-06-30 12:49:00
4254	2014-06-30 12:50:00	2014-06-30 12:59:00
4255	2014-06-30 13:00:00	2014-06-30 13:09:00
4256	2014-06-30 13:10:00	2014-06-30 13:19:00
4257	2014-06-30 13:20:00	2014-06-30 13:29:00
4258	2014-06-30 13:30:00	2014-06-30 13:39:00
4259	2014-06-30 13:40:00	2014-06-30 13:49:00
4260	2014-06-30 13:50:00	2014-06-30 13:59:00
4261	2014-06-30 14:00:00	2014-06-30 14:09:00
4262	2014-06-30 14:10:00	2014-06-30 14:19:00
4263	2014-06-30 14:20:00	2014-06-30 14:29:00
4264	2014-06-30 14:30:00	2014-06-30 14:39:00
4265	2014-06-30 14:40:00	2014-06-30 14:49:00
4266	2014-06-30 14:50:00	2014-06-30 14:59:00
4267	2014-06-30 15:00:00	2014-06-30 15:09:00
4268	2014-06-30 15:10:00	2014-06-30 15:19:00
4269	2014-06-30 15:20:00	2014-06-30 15:29:00
4270	2014-06-30 15:30:00	2014-06-30 15:39:00
4271	2014-06-30 15:40:00	2014-06-30 15:49:00
4272	2014-06-30 15:50:00	2014-06-30 15:59:00
4273	2014-06-30 16:00:00	2014-06-30 16:09:00
4274	2014-06-30 16:10:00	2014-06-30 16:19:00
4275	2014-06-30 16:20:00	2014-06-30 16:29:00
4276	2014-06-30 16:30:00	2014-06-30 16:39:00
4277	2014-06-30 16:40:00	2014-06-30 16:49:00
4278	2014-06-30 16:50:00	2014-06-30 16:59:00
4279	2014-06-30 17:00:00	2014-06-30 17:09:00
4280	2014-06-30 17:10:00	2014-06-30 17:19:00
4281	2014-06-30 17:20:00	2014-06-30 17:29:00
4282	2014-06-30 17:30:00	2014-06-30 17:39:00
4283	2014-06-30 17:40:00	2014-06-30 17:49:00
4284	2014-06-30 17:50:00	2014-06-30 17:59:00
4285	2014-06-30 18:00:00	2014-06-30 18:09:00
4286	2014-06-30 18:10:00	2014-06-30 18:19:00
4287	2014-06-30 18:20:00	2014-06-30 18:29:00
4288	2014-06-30 18:30:00	2014-06-30 18:39:00
4289	2014-06-30 18:40:00	2014-06-30 18:49:00
4290	2014-06-30 18:50:00	2014-06-30 18:59:00
4291	2014-06-30 19:00:00	2014-06-30 19:09:00
4292	2014-06-30 19:10:00	2014-06-30 19:19:00
4293	2014-06-30 19:20:00	2014-06-30 19:29:00
4294	2014-06-30 19:30:00	2014-06-30 19:39:00
4295	2014-06-30 19:40:00	2014-06-30 19:49:00
4296	2014-06-30 19:50:00	2014-06-30 19:59:00
4297	2014-06-30 20:00:00	2014-06-30 20:09:00
4298	2014-06-30 20:10:00	2014-06-30 20:19:00
4299	2014-06-30 20:20:00	2014-06-30 20:29:00
4300	2014-06-30 20:30:00	2014-06-30 20:39:00
4301	2014-06-30 20:40:00	2014-06-30 20:49:00
4302	2014-06-30 20:50:00	2014-06-30 20:59:00
4303	2014-06-30 21:00:00	2014-06-30 21:09:00
4304	2014-06-30 21:10:00	2014-06-30 21:19:00
4305	2014-06-30 21:20:00	2014-06-30 21:29:00
4306	2014-06-30 21:30:00	2014-06-30 21:39:00
4307	2014-06-30 21:40:00	2014-06-30 21:49:00
4308	2014-06-30 21:50:00	2014-06-30 21:59:00
4309	2014-06-30 22:00:00	2014-06-30 22:09:00
4310	2014-06-30 22:10:00	2014-06-30 22:19:00
4311	2014-06-30 22:20:00	2014-06-30 22:29:00
4312	2014-06-30 22:30:00	2014-06-30 22:39:00
4313	2014-06-30 22:40:00	2014-06-30 22:49:00
4314	2014-06-30 22:50:00	2014-06-30 22:59:00
4315	2014-06-30 23:00:00	2014-06-30 23:09:00
4316	2014-06-30 23:10:00	2014-06-30 23:19:00
4317	2014-06-30 23:20:00	2014-06-30 23:29:00
4318	2014-06-30 23:30:00	2014-06-30 23:39:00
4319	2014-06-30 23:40:00	2014-06-30 23:49:00
4320	2014-06-30 23:50:00	2014-06-30 23:59:00
4321	2014-07-01 00:00:00	2014-07-01 00:09:00
4322	2014-07-01 00:10:00	2014-07-01 00:19:00
4323	2014-07-01 00:20:00	2014-07-01 00:29:00
4324	2014-07-01 00:30:00	2014-07-01 00:39:00
4325	2014-07-01 00:40:00	2014-07-01 00:49:00
4326	2014-07-01 00:50:00	2014-07-01 00:59:00
4327	2014-07-01 01:00:00	2014-07-01 01:09:00
4328	2014-07-01 01:10:00	2014-07-01 01:19:00
4329	2014-07-01 01:20:00	2014-07-01 01:29:00
4330	2014-07-01 01:30:00	2014-07-01 01:39:00
4331	2014-07-01 01:40:00	2014-07-01 01:49:00
4332	2014-07-01 01:50:00	2014-07-01 01:59:00
4333	2014-07-01 02:00:00	2014-07-01 02:09:00
4334	2014-07-01 02:10:00	2014-07-01 02:19:00
4335	2014-07-01 02:20:00	2014-07-01 02:29:00
4336	2014-07-01 02:30:00	2014-07-01 02:39:00
4337	2014-07-01 02:40:00	2014-07-01 02:49:00
4338	2014-07-01 02:50:00	2014-07-01 02:59:00
4339	2014-07-01 03:00:00	2014-07-01 03:09:00
4340	2014-07-01 03:10:00	2014-07-01 03:19:00
4341	2014-07-01 03:20:00	2014-07-01 03:29:00
4342	2014-07-01 03:30:00	2014-07-01 03:39:00
4343	2014-07-01 03:40:00	2014-07-01 03:49:00
4344	2014-07-01 03:50:00	2014-07-01 03:59:00
4345	2014-07-01 04:00:00	2014-07-01 04:09:00
4346	2014-07-01 04:10:00	2014-07-01 04:19:00
4347	2014-07-01 04:20:00	2014-07-01 04:29:00
4348	2014-07-01 04:30:00	2014-07-01 04:39:00
4349	2014-07-01 04:40:00	2014-07-01 04:49:00
4350	2014-07-01 04:50:00	2014-07-01 04:59:00
4351	2014-07-01 05:00:00	2014-07-01 05:09:00
4352	2014-07-01 05:10:00	2014-07-01 05:19:00
4353	2014-07-01 05:20:00	2014-07-01 05:29:00
4354	2014-07-01 05:30:00	2014-07-01 05:39:00
4355	2014-07-01 05:40:00	2014-07-01 05:49:00
4356	2014-07-01 05:50:00	2014-07-01 05:59:00
4357	2014-07-01 06:00:00	2014-07-01 06:09:00
4358	2014-07-01 06:10:00	2014-07-01 06:19:00
4359	2014-07-01 06:20:00	2014-07-01 06:29:00
4360	2014-07-01 06:30:00	2014-07-01 06:39:00
4361	2014-07-01 06:40:00	2014-07-01 06:49:00
4362	2014-07-01 06:50:00	2014-07-01 06:59:00
4363	2014-07-01 07:00:00	2014-07-01 07:09:00
4364	2014-07-01 07:10:00	2014-07-01 07:19:00
4365	2014-07-01 07:20:00	2014-07-01 07:29:00
4366	2014-07-01 07:30:00	2014-07-01 07:39:00
4367	2014-07-01 07:40:00	2014-07-01 07:49:00
4368	2014-07-01 07:50:00	2014-07-01 07:59:00
4369	2014-07-01 08:00:00	2014-07-01 08:09:00
4370	2014-07-01 08:10:00	2014-07-01 08:19:00
4371	2014-07-01 08:20:00	2014-07-01 08:29:00
4372	2014-07-01 08:30:00	2014-07-01 08:39:00
4373	2014-07-01 08:40:00	2014-07-01 08:49:00
4374	2014-07-01 08:50:00	2014-07-01 08:59:00
4375	2014-07-01 09:00:00	2014-07-01 09:09:00
4376	2014-07-01 09:10:00	2014-07-01 09:19:00
4377	2014-07-01 09:20:00	2014-07-01 09:29:00
4378	2014-07-01 09:30:00	2014-07-01 09:39:00
4379	2014-07-01 09:40:00	2014-07-01 09:49:00
4380	2014-07-01 09:50:00	2014-07-01 09:59:00
4381	2014-07-01 10:00:00	2014-07-01 10:09:00
4382	2014-07-01 10:10:00	2014-07-01 10:19:00
4383	2014-07-01 10:20:00	2014-07-01 10:29:00
4384	2014-07-01 10:30:00	2014-07-01 10:39:00
4385	2014-07-01 10:40:00	2014-07-01 10:49:00
4386	2014-07-01 10:50:00	2014-07-01 10:59:00
4387	2014-07-01 11:00:00	2014-07-01 11:09:00
4388	2014-07-01 11:10:00	2014-07-01 11:19:00
4389	2014-07-01 11:20:00	2014-07-01 11:29:00
4390	2014-07-01 11:30:00	2014-07-01 11:39:00
4391	2014-07-01 11:40:00	2014-07-01 11:49:00
4392	2014-07-01 11:50:00	2014-07-01 11:59:00
4393	2014-07-01 12:00:00	2014-07-01 12:09:00
4394	2014-07-01 12:10:00	2014-07-01 12:19:00
4395	2014-07-01 12:20:00	2014-07-01 12:29:00
4396	2014-07-01 12:30:00	2014-07-01 12:39:00
4397	2014-07-01 12:40:00	2014-07-01 12:49:00
4398	2014-07-01 12:50:00	2014-07-01 12:59:00
4399	2014-07-01 13:00:00	2014-07-01 13:09:00
4400	2014-07-01 13:10:00	2014-07-01 13:19:00
4401	2014-07-01 13:20:00	2014-07-01 13:29:00
4402	2014-07-01 13:30:00	2014-07-01 13:39:00
4403	2014-07-01 13:40:00	2014-07-01 13:49:00
4404	2014-07-01 13:50:00	2014-07-01 13:59:00
4405	2014-07-01 14:00:00	2014-07-01 14:09:00
4406	2014-07-01 14:10:00	2014-07-01 14:19:00
4407	2014-07-01 14:20:00	2014-07-01 14:29:00
4408	2014-07-01 14:30:00	2014-07-01 14:39:00
4409	2014-07-01 14:40:00	2014-07-01 14:49:00
4410	2014-07-01 14:50:00	2014-07-01 14:59:00
4411	2014-07-01 15:00:00	2014-07-01 15:09:00
4412	2014-07-01 15:10:00	2014-07-01 15:19:00
4413	2014-07-01 15:20:00	2014-07-01 15:29:00
4414	2014-07-01 15:30:00	2014-07-01 15:39:00
4415	2014-07-01 15:40:00	2014-07-01 15:49:00
4416	2014-07-01 15:50:00	2014-07-01 15:59:00
4417	2014-07-01 16:00:00	2014-07-01 16:09:00
4418	2014-07-01 16:10:00	2014-07-01 16:19:00
4419	2014-07-01 16:20:00	2014-07-01 16:29:00
4420	2014-07-01 16:30:00	2014-07-01 16:39:00
4421	2014-07-01 16:40:00	2014-07-01 16:49:00
4422	2014-07-01 16:50:00	2014-07-01 16:59:00
4423	2014-07-01 17:00:00	2014-07-01 17:09:00
4424	2014-07-01 17:10:00	2014-07-01 17:19:00
4425	2014-07-01 17:20:00	2014-07-01 17:29:00
4426	2014-07-01 17:30:00	2014-07-01 17:39:00
4427	2014-07-01 17:40:00	2014-07-01 17:49:00
4428	2014-07-01 17:50:00	2014-07-01 17:59:00
4429	2014-07-01 18:00:00	2014-07-01 18:09:00
4430	2014-07-01 18:10:00	2014-07-01 18:19:00
4431	2014-07-01 18:20:00	2014-07-01 18:29:00
4432	2014-07-01 18:30:00	2014-07-01 18:39:00
4433	2014-07-01 18:40:00	2014-07-01 18:49:00
4434	2014-07-01 18:50:00	2014-07-01 18:59:00
4435	2014-07-01 19:00:00	2014-07-01 19:09:00
4436	2014-07-01 19:10:00	2014-07-01 19:19:00
4437	2014-07-01 19:20:00	2014-07-01 19:29:00
4438	2014-07-01 19:30:00	2014-07-01 19:39:00
4439	2014-07-01 19:40:00	2014-07-01 19:49:00
4440	2014-07-01 19:50:00	2014-07-01 19:59:00
4441	2014-07-01 20:00:00	2014-07-01 20:09:00
4442	2014-07-01 20:10:00	2014-07-01 20:19:00
4443	2014-07-01 20:20:00	2014-07-01 20:29:00
4444	2014-07-01 20:30:00	2014-07-01 20:39:00
4445	2014-07-01 20:40:00	2014-07-01 20:49:00
4446	2014-07-01 20:50:00	2014-07-01 20:59:00
4447	2014-07-01 21:00:00	2014-07-01 21:09:00
4448	2014-07-01 21:10:00	2014-07-01 21:19:00
4449	2014-07-01 21:20:00	2014-07-01 21:29:00
4450	2014-07-01 21:30:00	2014-07-01 21:39:00
4451	2014-07-01 21:40:00	2014-07-01 21:49:00
4452	2014-07-01 21:50:00	2014-07-01 21:59:00
4453	2014-07-01 22:00:00	2014-07-01 22:09:00
4454	2014-07-01 22:10:00	2014-07-01 22:19:00
4455	2014-07-01 22:20:00	2014-07-01 22:29:00
4456	2014-07-01 22:30:00	2014-07-01 22:39:00
4457	2014-07-01 22:40:00	2014-07-01 22:49:00
4458	2014-07-01 22:50:00	2014-07-01 22:59:00
4459	2014-07-01 23:00:00	2014-07-01 23:09:00
4460	2014-07-01 23:10:00	2014-07-01 23:19:00
4461	2014-07-01 23:20:00	2014-07-01 23:29:00
4462	2014-07-01 23:30:00	2014-07-01 23:39:00
4463	2014-07-01 23:40:00	2014-07-01 23:49:00
4464	2014-07-01 23:50:00	2014-07-01 23:59:00
4465	2014-07-02 00:00:00	2014-07-02 00:09:00
4466	2014-07-02 00:10:00	2014-07-02 00:19:00
4467	2014-07-02 00:20:00	2014-07-02 00:29:00
4468	2014-07-02 00:30:00	2014-07-02 00:39:00
4469	2014-07-02 00:40:00	2014-07-02 00:49:00
4470	2014-07-02 00:50:00	2014-07-02 00:59:00
4471	2014-07-02 01:00:00	2014-07-02 01:09:00
4472	2014-07-02 01:10:00	2014-07-02 01:19:00
4473	2014-07-02 01:20:00	2014-07-02 01:29:00
4474	2014-07-02 01:30:00	2014-07-02 01:39:00
4475	2014-07-02 01:40:00	2014-07-02 01:49:00
4476	2014-07-02 01:50:00	2014-07-02 01:59:00
4477	2014-07-02 02:00:00	2014-07-02 02:09:00
4478	2014-07-02 02:10:00	2014-07-02 02:19:00
4479	2014-07-02 02:20:00	2014-07-02 02:29:00
4480	2014-07-02 02:30:00	2014-07-02 02:39:00
4481	2014-07-02 02:40:00	2014-07-02 02:49:00
4482	2014-07-02 02:50:00	2014-07-02 02:59:00
4483	2014-07-02 03:00:00	2014-07-02 03:09:00
4484	2014-07-02 03:10:00	2014-07-02 03:19:00
4485	2014-07-02 03:20:00	2014-07-02 03:29:00
4486	2014-07-02 03:30:00	2014-07-02 03:39:00
4487	2014-07-02 03:40:00	2014-07-02 03:49:00
4488	2014-07-02 03:50:00	2014-07-02 03:59:00
4489	2014-07-02 04:00:00	2014-07-02 04:09:00
4490	2014-07-02 04:10:00	2014-07-02 04:19:00
4491	2014-07-02 04:20:00	2014-07-02 04:29:00
4492	2014-07-02 04:30:00	2014-07-02 04:39:00
4493	2014-07-02 04:40:00	2014-07-02 04:49:00
4494	2014-07-02 04:50:00	2014-07-02 04:59:00
4495	2014-07-02 05:00:00	2014-07-02 05:09:00
4496	2014-07-02 05:10:00	2014-07-02 05:19:00
4497	2014-07-02 05:20:00	2014-07-02 05:29:00
4498	2014-07-02 05:30:00	2014-07-02 05:39:00
4499	2014-07-02 05:40:00	2014-07-02 05:49:00
4500	2014-07-02 05:50:00	2014-07-02 05:59:00
4501	2014-07-02 06:00:00	2014-07-02 06:09:00
4502	2014-07-02 06:10:00	2014-07-02 06:19:00
4503	2014-07-02 06:20:00	2014-07-02 06:29:00
4504	2014-07-02 06:30:00	2014-07-02 06:39:00
4505	2014-07-02 06:40:00	2014-07-02 06:49:00
4506	2014-07-02 06:50:00	2014-07-02 06:59:00
4507	2014-07-02 07:00:00	2014-07-02 07:09:00
4508	2014-07-02 07:10:00	2014-07-02 07:19:00
4509	2014-07-02 07:20:00	2014-07-02 07:29:00
4510	2014-07-02 07:30:00	2014-07-02 07:39:00
4511	2014-07-02 07:40:00	2014-07-02 07:49:00
4512	2014-07-02 07:50:00	2014-07-02 07:59:00
4513	2014-07-02 08:00:00	2014-07-02 08:09:00
4514	2014-07-02 08:10:00	2014-07-02 08:19:00
4515	2014-07-02 08:20:00	2014-07-02 08:29:00
4516	2014-07-02 08:30:00	2014-07-02 08:39:00
4517	2014-07-02 08:40:00	2014-07-02 08:49:00
4518	2014-07-02 08:50:00	2014-07-02 08:59:00
4519	2014-07-02 09:00:00	2014-07-02 09:09:00
4520	2014-07-02 09:10:00	2014-07-02 09:19:00
4521	2014-07-02 09:20:00	2014-07-02 09:29:00
4522	2014-07-02 09:30:00	2014-07-02 09:39:00
4523	2014-07-02 09:40:00	2014-07-02 09:49:00
4524	2014-07-02 09:50:00	2014-07-02 09:59:00
4525	2014-07-02 10:00:00	2014-07-02 10:09:00
4526	2014-07-02 10:10:00	2014-07-02 10:19:00
4527	2014-07-02 10:20:00	2014-07-02 10:29:00
4528	2014-07-02 10:30:00	2014-07-02 10:39:00
4529	2014-07-02 10:40:00	2014-07-02 10:49:00
4530	2014-07-02 10:50:00	2014-07-02 10:59:00
4531	2014-07-02 11:00:00	2014-07-02 11:09:00
4532	2014-07-02 11:10:00	2014-07-02 11:19:00
4533	2014-07-02 11:20:00	2014-07-02 11:29:00
4534	2014-07-02 11:30:00	2014-07-02 11:39:00
4535	2014-07-02 11:40:00	2014-07-02 11:49:00
4536	2014-07-02 11:50:00	2014-07-02 11:59:00
4537	2014-07-02 12:00:00	2014-07-02 12:09:00
4538	2014-07-02 12:10:00	2014-07-02 12:19:00
4539	2014-07-02 12:20:00	2014-07-02 12:29:00
4540	2014-07-02 12:30:00	2014-07-02 12:39:00
4541	2014-07-02 12:40:00	2014-07-02 12:49:00
4542	2014-07-02 12:50:00	2014-07-02 12:59:00
4543	2014-07-02 13:00:00	2014-07-02 13:09:00
4544	2014-07-02 13:10:00	2014-07-02 13:19:00
4545	2014-07-02 13:20:00	2014-07-02 13:29:00
4546	2014-07-02 13:30:00	2014-07-02 13:39:00
4547	2014-07-02 13:40:00	2014-07-02 13:49:00
4548	2014-07-02 13:50:00	2014-07-02 13:59:00
4549	2014-07-02 14:00:00	2014-07-02 14:09:00
4550	2014-07-02 14:10:00	2014-07-02 14:19:00
4551	2014-07-02 14:20:00	2014-07-02 14:29:00
4552	2014-07-02 14:30:00	2014-07-02 14:39:00
4553	2014-07-02 14:40:00	2014-07-02 14:49:00
4554	2014-07-02 14:50:00	2014-07-02 14:59:00
4555	2014-07-02 15:00:00	2014-07-02 15:09:00
4556	2014-07-02 15:10:00	2014-07-02 15:19:00
4557	2014-07-02 15:20:00	2014-07-02 15:29:00
4558	2014-07-02 15:30:00	2014-07-02 15:39:00
4559	2014-07-02 15:40:00	2014-07-02 15:49:00
4560	2014-07-02 15:50:00	2014-07-02 15:59:00
4561	2014-07-02 16:00:00	2014-07-02 16:09:00
4562	2014-07-02 16:10:00	2014-07-02 16:19:00
4563	2014-07-02 16:20:00	2014-07-02 16:29:00
4564	2014-07-02 16:30:00	2014-07-02 16:39:00
4565	2014-07-02 16:40:00	2014-07-02 16:49:00
4566	2014-07-02 16:50:00	2014-07-02 16:59:00
4567	2014-07-02 17:00:00	2014-07-02 17:09:00
4568	2014-07-02 17:10:00	2014-07-02 17:19:00
4569	2014-07-02 17:20:00	2014-07-02 17:29:00
4570	2014-07-02 17:30:00	2014-07-02 17:39:00
4571	2014-07-02 17:40:00	2014-07-02 17:49:00
4572	2014-07-02 17:50:00	2014-07-02 17:59:00
4573	2014-07-02 18:00:00	2014-07-02 18:09:00
4574	2014-07-02 18:10:00	2014-07-02 18:19:00
4575	2014-07-02 18:20:00	2014-07-02 18:29:00
4576	2014-07-02 18:30:00	2014-07-02 18:39:00
4577	2014-07-02 18:40:00	2014-07-02 18:49:00
4578	2014-07-02 18:50:00	2014-07-02 18:59:00
4579	2014-07-02 19:00:00	2014-07-02 19:09:00
4580	2014-07-02 19:10:00	2014-07-02 19:19:00
4581	2014-07-02 19:20:00	2014-07-02 19:29:00
4582	2014-07-02 19:30:00	2014-07-02 19:39:00
4583	2014-07-02 19:40:00	2014-07-02 19:49:00
4584	2014-07-02 19:50:00	2014-07-02 19:59:00
4585	2014-07-02 20:00:00	2014-07-02 20:09:00
4586	2014-07-02 20:10:00	2014-07-02 20:19:00
4587	2014-07-02 20:20:00	2014-07-02 20:29:00
4588	2014-07-02 20:30:00	2014-07-02 20:39:00
4589	2014-07-02 20:40:00	2014-07-02 20:49:00
4590	2014-07-02 20:50:00	2014-07-02 20:59:00
4591	2014-07-02 21:00:00	2014-07-02 21:09:00
4592	2014-07-02 21:10:00	2014-07-02 21:19:00
4593	2014-07-02 21:20:00	2014-07-02 21:29:00
4594	2014-07-02 21:30:00	2014-07-02 21:39:00
4595	2014-07-02 21:40:00	2014-07-02 21:49:00
4596	2014-07-02 21:50:00	2014-07-02 21:59:00
4597	2014-07-02 22:00:00	2014-07-02 22:09:00
4598	2014-07-02 22:10:00	2014-07-02 22:19:00
4599	2014-07-02 22:20:00	2014-07-02 22:29:00
4600	2014-07-02 22:30:00	2014-07-02 22:39:00
4601	2014-07-02 22:40:00	2014-07-02 22:49:00
4602	2014-07-02 22:50:00	2014-07-02 22:59:00
4603	2014-07-02 23:00:00	2014-07-02 23:09:00
4604	2014-07-02 23:10:00	2014-07-02 23:19:00
4605	2014-07-02 23:20:00	2014-07-02 23:29:00
4606	2014-07-02 23:30:00	2014-07-02 23:39:00
4607	2014-07-02 23:40:00	2014-07-02 23:49:00
4608	2014-07-02 23:50:00	2014-07-02 23:59:00
4609	2014-07-03 00:00:00	2014-07-03 00:09:00
4610	2014-07-03 00:10:00	2014-07-03 00:19:00
4611	2014-07-03 00:20:00	2014-07-03 00:29:00
4612	2014-07-03 00:30:00	2014-07-03 00:39:00
4613	2014-07-03 00:40:00	2014-07-03 00:49:00
4614	2014-07-03 00:50:00	2014-07-03 00:59:00
4615	2014-07-03 01:00:00	2014-07-03 01:09:00
4616	2014-07-03 01:10:00	2014-07-03 01:19:00
4617	2014-07-03 01:20:00	2014-07-03 01:29:00
4618	2014-07-03 01:30:00	2014-07-03 01:39:00
4619	2014-07-03 01:40:00	2014-07-03 01:49:00
4620	2014-07-03 01:50:00	2014-07-03 01:59:00
4621	2014-07-03 02:00:00	2014-07-03 02:09:00
4622	2014-07-03 02:10:00	2014-07-03 02:19:00
4623	2014-07-03 02:20:00	2014-07-03 02:29:00
4624	2014-07-03 02:30:00	2014-07-03 02:39:00
4625	2014-07-03 02:40:00	2014-07-03 02:49:00
4626	2014-07-03 02:50:00	2014-07-03 02:59:00
4627	2014-07-03 03:00:00	2014-07-03 03:09:00
4628	2014-07-03 03:10:00	2014-07-03 03:19:00
4629	2014-07-03 03:20:00	2014-07-03 03:29:00
4630	2014-07-03 03:30:00	2014-07-03 03:39:00
4631	2014-07-03 03:40:00	2014-07-03 03:49:00
4632	2014-07-03 03:50:00	2014-07-03 03:59:00
4633	2014-07-03 04:00:00	2014-07-03 04:09:00
4634	2014-07-03 04:10:00	2014-07-03 04:19:00
4635	2014-07-03 04:20:00	2014-07-03 04:29:00
4636	2014-07-03 04:30:00	2014-07-03 04:39:00
4637	2014-07-03 04:40:00	2014-07-03 04:49:00
4638	2014-07-03 04:50:00	2014-07-03 04:59:00
4639	2014-07-03 05:00:00	2014-07-03 05:09:00
4640	2014-07-03 05:10:00	2014-07-03 05:19:00
4641	2014-07-03 05:20:00	2014-07-03 05:29:00
4642	2014-07-03 05:30:00	2014-07-03 05:39:00
4643	2014-07-03 05:40:00	2014-07-03 05:49:00
4644	2014-07-03 05:50:00	2014-07-03 05:59:00
4645	2014-07-03 06:00:00	2014-07-03 06:09:00
4646	2014-07-03 06:10:00	2014-07-03 06:19:00
4647	2014-07-03 06:20:00	2014-07-03 06:29:00
4648	2014-07-03 06:30:00	2014-07-03 06:39:00
4649	2014-07-03 06:40:00	2014-07-03 06:49:00
4650	2014-07-03 06:50:00	2014-07-03 06:59:00
4651	2014-07-03 07:00:00	2014-07-03 07:09:00
4652	2014-07-03 07:10:00	2014-07-03 07:19:00
4653	2014-07-03 07:20:00	2014-07-03 07:29:00
4654	2014-07-03 07:30:00	2014-07-03 07:39:00
4655	2014-07-03 07:40:00	2014-07-03 07:49:00
4656	2014-07-03 07:50:00	2014-07-03 07:59:00
4657	2014-07-03 08:00:00	2014-07-03 08:09:00
4658	2014-07-03 08:10:00	2014-07-03 08:19:00
4659	2014-07-03 08:20:00	2014-07-03 08:29:00
4660	2014-07-03 08:30:00	2014-07-03 08:39:00
4661	2014-07-03 08:40:00	2014-07-03 08:49:00
4662	2014-07-03 08:50:00	2014-07-03 08:59:00
4663	2014-07-03 09:00:00	2014-07-03 09:09:00
4664	2014-07-03 09:10:00	2014-07-03 09:19:00
4665	2014-07-03 09:20:00	2014-07-03 09:29:00
4666	2014-07-03 09:30:00	2014-07-03 09:39:00
4667	2014-07-03 09:40:00	2014-07-03 09:49:00
4668	2014-07-03 09:50:00	2014-07-03 09:59:00
4669	2014-07-03 10:00:00	2014-07-03 10:09:00
4670	2014-07-03 10:10:00	2014-07-03 10:19:00
4671	2014-07-03 10:20:00	2014-07-03 10:29:00
4672	2014-07-03 10:30:00	2014-07-03 10:39:00
4673	2014-07-03 10:40:00	2014-07-03 10:49:00
4674	2014-07-03 10:50:00	2014-07-03 10:59:00
4675	2014-07-03 11:00:00	2014-07-03 11:09:00
4676	2014-07-03 11:10:00	2014-07-03 11:19:00
4677	2014-07-03 11:20:00	2014-07-03 11:29:00
4678	2014-07-03 11:30:00	2014-07-03 11:39:00
4679	2014-07-03 11:40:00	2014-07-03 11:49:00
4680	2014-07-03 11:50:00	2014-07-03 11:59:00
4681	2014-07-03 12:00:00	2014-07-03 12:09:00
4682	2014-07-03 12:10:00	2014-07-03 12:19:00
4683	2014-07-03 12:20:00	2014-07-03 12:29:00
4684	2014-07-03 12:30:00	2014-07-03 12:39:00
4685	2014-07-03 12:40:00	2014-07-03 12:49:00
4686	2014-07-03 12:50:00	2014-07-03 12:59:00
4687	2014-07-03 13:00:00	2014-07-03 13:09:00
4688	2014-07-03 13:10:00	2014-07-03 13:19:00
4689	2014-07-03 13:20:00	2014-07-03 13:29:00
4690	2014-07-03 13:30:00	2014-07-03 13:39:00
4691	2014-07-03 13:40:00	2014-07-03 13:49:00
4692	2014-07-03 13:50:00	2014-07-03 13:59:00
4693	2014-07-03 14:00:00	2014-07-03 14:09:00
4694	2014-07-03 14:10:00	2014-07-03 14:19:00
4695	2014-07-03 14:20:00	2014-07-03 14:29:00
4696	2014-07-03 14:30:00	2014-07-03 14:39:00
4697	2014-07-03 14:40:00	2014-07-03 14:49:00
4698	2014-07-03 14:50:00	2014-07-03 14:59:00
4699	2014-07-03 15:00:00	2014-07-03 15:09:00
4700	2014-07-03 15:10:00	2014-07-03 15:19:00
4701	2014-07-03 15:20:00	2014-07-03 15:29:00
4702	2014-07-03 15:30:00	2014-07-03 15:39:00
4703	2014-07-03 15:40:00	2014-07-03 15:49:00
4704	2014-07-03 15:50:00	2014-07-03 15:59:00
4705	2014-07-03 16:00:00	2014-07-03 16:09:00
4706	2014-07-03 16:10:00	2014-07-03 16:19:00
4707	2014-07-03 16:20:00	2014-07-03 16:29:00
4708	2014-07-03 16:30:00	2014-07-03 16:39:00
4709	2014-07-03 16:40:00	2014-07-03 16:49:00
4710	2014-07-03 16:50:00	2014-07-03 16:59:00
4711	2014-07-03 17:00:00	2014-07-03 17:09:00
4712	2014-07-03 17:10:00	2014-07-03 17:19:00
4713	2014-07-03 17:20:00	2014-07-03 17:29:00
4714	2014-07-03 17:30:00	2014-07-03 17:39:00
4715	2014-07-03 17:40:00	2014-07-03 17:49:00
4716	2014-07-03 17:50:00	2014-07-03 17:59:00
4717	2014-07-03 18:00:00	2014-07-03 18:09:00
4718	2014-07-03 18:10:00	2014-07-03 18:19:00
4719	2014-07-03 18:20:00	2014-07-03 18:29:00
4720	2014-07-03 18:30:00	2014-07-03 18:39:00
4721	2014-07-03 18:40:00	2014-07-03 18:49:00
4722	2014-07-03 18:50:00	2014-07-03 18:59:00
4723	2014-07-03 19:00:00	2014-07-03 19:09:00
4724	2014-07-03 19:10:00	2014-07-03 19:19:00
4725	2014-07-03 19:20:00	2014-07-03 19:29:00
4726	2014-07-03 19:30:00	2014-07-03 19:39:00
4727	2014-07-03 19:40:00	2014-07-03 19:49:00
4728	2014-07-03 19:50:00	2014-07-03 19:59:00
4729	2014-07-03 20:00:00	2014-07-03 20:09:00
4730	2014-07-03 20:10:00	2014-07-03 20:19:00
4731	2014-07-03 20:20:00	2014-07-03 20:29:00
4732	2014-07-03 20:30:00	2014-07-03 20:39:00
4733	2014-07-03 20:40:00	2014-07-03 20:49:00
4734	2014-07-03 20:50:00	2014-07-03 20:59:00
4735	2014-07-03 21:00:00	2014-07-03 21:09:00
4736	2014-07-03 21:10:00	2014-07-03 21:19:00
4737	2014-07-03 21:20:00	2014-07-03 21:29:00
4738	2014-07-03 21:30:00	2014-07-03 21:39:00
4739	2014-07-03 21:40:00	2014-07-03 21:49:00
4740	2014-07-03 21:50:00	2014-07-03 21:59:00
4741	2014-07-03 22:00:00	2014-07-03 22:09:00
4742	2014-07-03 22:10:00	2014-07-03 22:19:00
4743	2014-07-03 22:20:00	2014-07-03 22:29:00
4744	2014-07-03 22:30:00	2014-07-03 22:39:00
4745	2014-07-03 22:40:00	2014-07-03 22:49:00
4746	2014-07-03 22:50:00	2014-07-03 22:59:00
4747	2014-07-03 23:00:00	2014-07-03 23:09:00
4748	2014-07-03 23:10:00	2014-07-03 23:19:00
4749	2014-07-03 23:20:00	2014-07-03 23:29:00
4750	2014-07-03 23:30:00	2014-07-03 23:39:00
4751	2014-07-03 23:40:00	2014-07-03 23:49:00
4752	2014-07-03 23:50:00	2014-07-03 23:59:00
4753	2014-07-04 00:00:00	2014-07-04 00:09:00
4754	2014-07-04 00:10:00	2014-07-04 00:19:00
4755	2014-07-04 00:20:00	2014-07-04 00:29:00
4756	2014-07-04 00:30:00	2014-07-04 00:39:00
4757	2014-07-04 00:40:00	2014-07-04 00:49:00
4758	2014-07-04 00:50:00	2014-07-04 00:59:00
4759	2014-07-04 01:00:00	2014-07-04 01:09:00
4760	2014-07-04 01:10:00	2014-07-04 01:19:00
4761	2014-07-04 01:20:00	2014-07-04 01:29:00
4762	2014-07-04 01:30:00	2014-07-04 01:39:00
4763	2014-07-04 01:40:00	2014-07-04 01:49:00
4764	2014-07-04 01:50:00	2014-07-04 01:59:00
4765	2014-07-04 02:00:00	2014-07-04 02:09:00
4766	2014-07-04 02:10:00	2014-07-04 02:19:00
4767	2014-07-04 02:20:00	2014-07-04 02:29:00
4768	2014-07-04 02:30:00	2014-07-04 02:39:00
4769	2014-07-04 02:40:00	2014-07-04 02:49:00
4770	2014-07-04 02:50:00	2014-07-04 02:59:00
4771	2014-07-04 03:00:00	2014-07-04 03:09:00
4772	2014-07-04 03:10:00	2014-07-04 03:19:00
4773	2014-07-04 03:20:00	2014-07-04 03:29:00
4774	2014-07-04 03:30:00	2014-07-04 03:39:00
4775	2014-07-04 03:40:00	2014-07-04 03:49:00
4776	2014-07-04 03:50:00	2014-07-04 03:59:00
4777	2014-07-04 04:00:00	2014-07-04 04:09:00
4778	2014-07-04 04:10:00	2014-07-04 04:19:00
4779	2014-07-04 04:20:00	2014-07-04 04:29:00
4780	2014-07-04 04:30:00	2014-07-04 04:39:00
4781	2014-07-04 04:40:00	2014-07-04 04:49:00
4782	2014-07-04 04:50:00	2014-07-04 04:59:00
4783	2014-07-04 05:00:00	2014-07-04 05:09:00
4784	2014-07-04 05:10:00	2014-07-04 05:19:00
4785	2014-07-04 05:20:00	2014-07-04 05:29:00
4786	2014-07-04 05:30:00	2014-07-04 05:39:00
4787	2014-07-04 05:40:00	2014-07-04 05:49:00
4788	2014-07-04 05:50:00	2014-07-04 05:59:00
4789	2014-07-04 06:00:00	2014-07-04 06:09:00
4790	2014-07-04 06:10:00	2014-07-04 06:19:00
4791	2014-07-04 06:20:00	2014-07-04 06:29:00
4792	2014-07-04 06:30:00	2014-07-04 06:39:00
4793	2014-07-04 06:40:00	2014-07-04 06:49:00
4794	2014-07-04 06:50:00	2014-07-04 06:59:00
4795	2014-07-04 07:00:00	2014-07-04 07:09:00
4796	2014-07-04 07:10:00	2014-07-04 07:19:00
4797	2014-07-04 07:20:00	2014-07-04 07:29:00
4798	2014-07-04 07:30:00	2014-07-04 07:39:00
4799	2014-07-04 07:40:00	2014-07-04 07:49:00
4800	2014-07-04 07:50:00	2014-07-04 07:59:00
4801	2014-07-04 08:00:00	2014-07-04 08:09:00
4802	2014-07-04 08:10:00	2014-07-04 08:19:00
4803	2014-07-04 08:20:00	2014-07-04 08:29:00
4804	2014-07-04 08:30:00	2014-07-04 08:39:00
4805	2014-07-04 08:40:00	2014-07-04 08:49:00
4806	2014-07-04 08:50:00	2014-07-04 08:59:00
4807	2014-07-04 09:00:00	2014-07-04 09:09:00
4808	2014-07-04 09:10:00	2014-07-04 09:19:00
4809	2014-07-04 09:20:00	2014-07-04 09:29:00
4810	2014-07-04 09:30:00	2014-07-04 09:39:00
4811	2014-07-04 09:40:00	2014-07-04 09:49:00
4812	2014-07-04 09:50:00	2014-07-04 09:59:00
4813	2014-07-04 10:00:00	2014-07-04 10:09:00
4814	2014-07-04 10:10:00	2014-07-04 10:19:00
4815	2014-07-04 10:20:00	2014-07-04 10:29:00
4816	2014-07-04 10:30:00	2014-07-04 10:39:00
4817	2014-07-04 10:40:00	2014-07-04 10:49:00
4818	2014-07-04 10:50:00	2014-07-04 10:59:00
4819	2014-07-04 11:00:00	2014-07-04 11:09:00
4820	2014-07-04 11:10:00	2014-07-04 11:19:00
4821	2014-07-04 11:20:00	2014-07-04 11:29:00
4822	2014-07-04 11:30:00	2014-07-04 11:39:00
4823	2014-07-04 11:40:00	2014-07-04 11:49:00
4824	2014-07-04 11:50:00	2014-07-04 11:59:00
4825	2014-07-04 12:00:00	2014-07-04 12:09:00
4826	2014-07-04 12:10:00	2014-07-04 12:19:00
4827	2014-07-04 12:20:00	2014-07-04 12:29:00
4828	2014-07-04 12:30:00	2014-07-04 12:39:00
4829	2014-07-04 12:40:00	2014-07-04 12:49:00
4830	2014-07-04 12:50:00	2014-07-04 12:59:00
4831	2014-07-04 13:00:00	2014-07-04 13:09:00
4832	2014-07-04 13:10:00	2014-07-04 13:19:00
4833	2014-07-04 13:20:00	2014-07-04 13:29:00
4834	2014-07-04 13:30:00	2014-07-04 13:39:00
4835	2014-07-04 13:40:00	2014-07-04 13:49:00
4836	2014-07-04 13:50:00	2014-07-04 13:59:00
4837	2014-07-04 14:00:00	2014-07-04 14:09:00
4838	2014-07-04 14:10:00	2014-07-04 14:19:00
4839	2014-07-04 14:20:00	2014-07-04 14:29:00
4840	2014-07-04 14:30:00	2014-07-04 14:39:00
4841	2014-07-04 14:40:00	2014-07-04 14:49:00
4842	2014-07-04 14:50:00	2014-07-04 14:59:00
4843	2014-07-04 15:00:00	2014-07-04 15:09:00
4844	2014-07-04 15:10:00	2014-07-04 15:19:00
4845	2014-07-04 15:20:00	2014-07-04 15:29:00
4846	2014-07-04 15:30:00	2014-07-04 15:39:00
4847	2014-07-04 15:40:00	2014-07-04 15:49:00
4848	2014-07-04 15:50:00	2014-07-04 15:59:00
4849	2014-07-04 16:00:00	2014-07-04 16:09:00
4850	2014-07-04 16:10:00	2014-07-04 16:19:00
4851	2014-07-04 16:20:00	2014-07-04 16:29:00
4852	2014-07-04 16:30:00	2014-07-04 16:39:00
4853	2014-07-04 16:40:00	2014-07-04 16:49:00
4854	2014-07-04 16:50:00	2014-07-04 16:59:00
4855	2014-07-04 17:00:00	2014-07-04 17:09:00
4856	2014-07-04 17:10:00	2014-07-04 17:19:00
4857	2014-07-04 17:20:00	2014-07-04 17:29:00
4858	2014-07-04 17:30:00	2014-07-04 17:39:00
4859	2014-07-04 17:40:00	2014-07-04 17:49:00
4860	2014-07-04 17:50:00	2014-07-04 17:59:00
4861	2014-07-04 18:00:00	2014-07-04 18:09:00
4862	2014-07-04 18:10:00	2014-07-04 18:19:00
4863	2014-07-04 18:20:00	2014-07-04 18:29:00
4864	2014-07-04 18:30:00	2014-07-04 18:39:00
4865	2014-07-04 18:40:00	2014-07-04 18:49:00
4866	2014-07-04 18:50:00	2014-07-04 18:59:00
4867	2014-07-04 19:00:00	2014-07-04 19:09:00
4868	2014-07-04 19:10:00	2014-07-04 19:19:00
4869	2014-07-04 19:20:00	2014-07-04 19:29:00
4870	2014-07-04 19:30:00	2014-07-04 19:39:00
4871	2014-07-04 19:40:00	2014-07-04 19:49:00
4872	2014-07-04 19:50:00	2014-07-04 19:59:00
4873	2014-07-04 20:00:00	2014-07-04 20:09:00
4874	2014-07-04 20:10:00	2014-07-04 20:19:00
4875	2014-07-04 20:20:00	2014-07-04 20:29:00
4876	2014-07-04 20:30:00	2014-07-04 20:39:00
4877	2014-07-04 20:40:00	2014-07-04 20:49:00
4878	2014-07-04 20:50:00	2014-07-04 20:59:00
4879	2014-07-04 21:00:00	2014-07-04 21:09:00
4880	2014-07-04 21:10:00	2014-07-04 21:19:00
4881	2014-07-04 21:20:00	2014-07-04 21:29:00
4882	2014-07-04 21:30:00	2014-07-04 21:39:00
4883	2014-07-04 21:40:00	2014-07-04 21:49:00
4884	2014-07-04 21:50:00	2014-07-04 21:59:00
4885	2014-07-04 22:00:00	2014-07-04 22:09:00
4886	2014-07-04 22:10:00	2014-07-04 22:19:00
4887	2014-07-04 22:20:00	2014-07-04 22:29:00
4888	2014-07-04 22:30:00	2014-07-04 22:39:00
4889	2014-07-04 22:40:00	2014-07-04 22:49:00
4890	2014-07-04 22:50:00	2014-07-04 22:59:00
4891	2014-07-04 23:00:00	2014-07-04 23:09:00
4892	2014-07-04 23:10:00	2014-07-04 23:19:00
4893	2014-07-04 23:20:00	2014-07-04 23:29:00
4894	2014-07-04 23:30:00	2014-07-04 23:39:00
4895	2014-07-04 23:40:00	2014-07-04 23:49:00
4896	2014-07-04 23:50:00	2014-07-04 23:59:00
4897	2014-07-05 00:00:00	2014-07-05 00:09:00
4898	2014-07-05 00:10:00	2014-07-05 00:19:00
4899	2014-07-05 00:20:00	2014-07-05 00:29:00
4900	2014-07-05 00:30:00	2014-07-05 00:39:00
4901	2014-07-05 00:40:00	2014-07-05 00:49:00
4902	2014-07-05 00:50:00	2014-07-05 00:59:00
4903	2014-07-05 01:00:00	2014-07-05 01:09:00
4904	2014-07-05 01:10:00	2014-07-05 01:19:00
4905	2014-07-05 01:20:00	2014-07-05 01:29:00
4906	2014-07-05 01:30:00	2014-07-05 01:39:00
4907	2014-07-05 01:40:00	2014-07-05 01:49:00
4908	2014-07-05 01:50:00	2014-07-05 01:59:00
4909	2014-07-05 02:00:00	2014-07-05 02:09:00
4910	2014-07-05 02:10:00	2014-07-05 02:19:00
4911	2014-07-05 02:20:00	2014-07-05 02:29:00
4912	2014-07-05 02:30:00	2014-07-05 02:39:00
4913	2014-07-05 02:40:00	2014-07-05 02:49:00
4914	2014-07-05 02:50:00	2014-07-05 02:59:00
4915	2014-07-05 03:00:00	2014-07-05 03:09:00
4916	2014-07-05 03:10:00	2014-07-05 03:19:00
4917	2014-07-05 03:20:00	2014-07-05 03:29:00
4918	2014-07-05 03:30:00	2014-07-05 03:39:00
4919	2014-07-05 03:40:00	2014-07-05 03:49:00
4920	2014-07-05 03:50:00	2014-07-05 03:59:00
4921	2014-07-05 04:00:00	2014-07-05 04:09:00
4922	2014-07-05 04:10:00	2014-07-05 04:19:00
4923	2014-07-05 04:20:00	2014-07-05 04:29:00
4924	2014-07-05 04:30:00	2014-07-05 04:39:00
4925	2014-07-05 04:40:00	2014-07-05 04:49:00
4926	2014-07-05 04:50:00	2014-07-05 04:59:00
4927	2014-07-05 05:00:00	2014-07-05 05:09:00
4928	2014-07-05 05:10:00	2014-07-05 05:19:00
4929	2014-07-05 05:20:00	2014-07-05 05:29:00
4930	2014-07-05 05:30:00	2014-07-05 05:39:00
4931	2014-07-05 05:40:00	2014-07-05 05:49:00
4932	2014-07-05 05:50:00	2014-07-05 05:59:00
4933	2014-07-05 06:00:00	2014-07-05 06:09:00
4934	2014-07-05 06:10:00	2014-07-05 06:19:00
4935	2014-07-05 06:20:00	2014-07-05 06:29:00
4936	2014-07-05 06:30:00	2014-07-05 06:39:00
4937	2014-07-05 06:40:00	2014-07-05 06:49:00
4938	2014-07-05 06:50:00	2014-07-05 06:59:00
4939	2014-07-05 07:00:00	2014-07-05 07:09:00
4940	2014-07-05 07:10:00	2014-07-05 07:19:00
4941	2014-07-05 07:20:00	2014-07-05 07:29:00
4942	2014-07-05 07:30:00	2014-07-05 07:39:00
4943	2014-07-05 07:40:00	2014-07-05 07:49:00
4944	2014-07-05 07:50:00	2014-07-05 07:59:00
4945	2014-07-05 08:00:00	2014-07-05 08:09:00
4946	2014-07-05 08:10:00	2014-07-05 08:19:00
4947	2014-07-05 08:20:00	2014-07-05 08:29:00
4948	2014-07-05 08:30:00	2014-07-05 08:39:00
4949	2014-07-05 08:40:00	2014-07-05 08:49:00
4950	2014-07-05 08:50:00	2014-07-05 08:59:00
4951	2014-07-05 09:00:00	2014-07-05 09:09:00
4952	2014-07-05 09:10:00	2014-07-05 09:19:00
4953	2014-07-05 09:20:00	2014-07-05 09:29:00
4954	2014-07-05 09:30:00	2014-07-05 09:39:00
4955	2014-07-05 09:40:00	2014-07-05 09:49:00
4956	2014-07-05 09:50:00	2014-07-05 09:59:00
4957	2014-07-05 10:00:00	2014-07-05 10:09:00
4958	2014-07-05 10:10:00	2014-07-05 10:19:00
4959	2014-07-05 10:20:00	2014-07-05 10:29:00
4960	2014-07-05 10:30:00	2014-07-05 10:39:00
4961	2014-07-05 10:40:00	2014-07-05 10:49:00
4962	2014-07-05 10:50:00	2014-07-05 10:59:00
4963	2014-07-05 11:00:00	2014-07-05 11:09:00
4964	2014-07-05 11:10:00	2014-07-05 11:19:00
4965	2014-07-05 11:20:00	2014-07-05 11:29:00
4966	2014-07-05 11:30:00	2014-07-05 11:39:00
4967	2014-07-05 11:40:00	2014-07-05 11:49:00
4968	2014-07-05 11:50:00	2014-07-05 11:59:00
4969	2014-07-05 12:00:00	2014-07-05 12:09:00
4970	2014-07-05 12:10:00	2014-07-05 12:19:00
4971	2014-07-05 12:20:00	2014-07-05 12:29:00
4972	2014-07-05 12:30:00	2014-07-05 12:39:00
4973	2014-07-05 12:40:00	2014-07-05 12:49:00
4974	2014-07-05 12:50:00	2014-07-05 12:59:00
4975	2014-07-05 13:00:00	2014-07-05 13:09:00
4976	2014-07-05 13:10:00	2014-07-05 13:19:00
4977	2014-07-05 13:20:00	2014-07-05 13:29:00
4978	2014-07-05 13:30:00	2014-07-05 13:39:00
4979	2014-07-05 13:40:00	2014-07-05 13:49:00
4980	2014-07-05 13:50:00	2014-07-05 13:59:00
4981	2014-07-05 14:00:00	2014-07-05 14:09:00
4982	2014-07-05 14:10:00	2014-07-05 14:19:00
4983	2014-07-05 14:20:00	2014-07-05 14:29:00
4984	2014-07-05 14:30:00	2014-07-05 14:39:00
4985	2014-07-05 14:40:00	2014-07-05 14:49:00
4986	2014-07-05 14:50:00	2014-07-05 14:59:00
4987	2014-07-05 15:00:00	2014-07-05 15:09:00
4988	2014-07-05 15:10:00	2014-07-05 15:19:00
4989	2014-07-05 15:20:00	2014-07-05 15:29:00
4990	2014-07-05 15:30:00	2014-07-05 15:39:00
4991	2014-07-05 15:40:00	2014-07-05 15:49:00
4992	2014-07-05 15:50:00	2014-07-05 15:59:00
4993	2014-07-05 16:00:00	2014-07-05 16:09:00
4994	2014-07-05 16:10:00	2014-07-05 16:19:00
4995	2014-07-05 16:20:00	2014-07-05 16:29:00
4996	2014-07-05 16:30:00	2014-07-05 16:39:00
4997	2014-07-05 16:40:00	2014-07-05 16:49:00
4998	2014-07-05 16:50:00	2014-07-05 16:59:00
4999	2014-07-05 17:00:00	2014-07-05 17:09:00
5000	2014-07-05 17:10:00	2014-07-05 17:19:00
5001	2014-07-05 17:20:00	2014-07-05 17:29:00
5002	2014-07-05 17:30:00	2014-07-05 17:39:00
5003	2014-07-05 17:40:00	2014-07-05 17:49:00
5004	2014-07-05 17:50:00	2014-07-05 17:59:00
5005	2014-07-05 18:00:00	2014-07-05 18:09:00
5006	2014-07-05 18:10:00	2014-07-05 18:19:00
5007	2014-07-05 18:20:00	2014-07-05 18:29:00
5008	2014-07-05 18:30:00	2014-07-05 18:39:00
5009	2014-07-05 18:40:00	2014-07-05 18:49:00
5010	2014-07-05 18:50:00	2014-07-05 18:59:00
5011	2014-07-05 19:00:00	2014-07-05 19:09:00
5012	2014-07-05 19:10:00	2014-07-05 19:19:00
5013	2014-07-05 19:20:00	2014-07-05 19:29:00
5014	2014-07-05 19:30:00	2014-07-05 19:39:00
5015	2014-07-05 19:40:00	2014-07-05 19:49:00
5016	2014-07-05 19:50:00	2014-07-05 19:59:00
5017	2014-07-05 20:00:00	2014-07-05 20:09:00
5018	2014-07-05 20:10:00	2014-07-05 20:19:00
5019	2014-07-05 20:20:00	2014-07-05 20:29:00
5020	2014-07-05 20:30:00	2014-07-05 20:39:00
5021	2014-07-05 20:40:00	2014-07-05 20:49:00
5022	2014-07-05 20:50:00	2014-07-05 20:59:00
5023	2014-07-05 21:00:00	2014-07-05 21:09:00
5024	2014-07-05 21:10:00	2014-07-05 21:19:00
5025	2014-07-05 21:20:00	2014-07-05 21:29:00
5026	2014-07-05 21:30:00	2014-07-05 21:39:00
5027	2014-07-05 21:40:00	2014-07-05 21:49:00
5028	2014-07-05 21:50:00	2014-07-05 21:59:00
5029	2014-07-05 22:00:00	2014-07-05 22:09:00
5030	2014-07-05 22:10:00	2014-07-05 22:19:00
5031	2014-07-05 22:20:00	2014-07-05 22:29:00
5032	2014-07-05 22:30:00	2014-07-05 22:39:00
5033	2014-07-05 22:40:00	2014-07-05 22:49:00
5034	2014-07-05 22:50:00	2014-07-05 22:59:00
5035	2014-07-05 23:00:00	2014-07-05 23:09:00
5036	2014-07-05 23:10:00	2014-07-05 23:19:00
5037	2014-07-05 23:20:00	2014-07-05 23:29:00
5038	2014-07-05 23:30:00	2014-07-05 23:39:00
5039	2014-07-05 23:40:00	2014-07-05 23:49:00
5040	2014-07-05 23:50:00	2014-07-05 23:59:00
5041	2014-07-06 00:00:00	2014-07-06 00:09:00
5042	2014-07-06 00:10:00	2014-07-06 00:19:00
5043	2014-07-06 00:20:00	2014-07-06 00:29:00
5044	2014-07-06 00:30:00	2014-07-06 00:39:00
5045	2014-07-06 00:40:00	2014-07-06 00:49:00
5046	2014-07-06 00:50:00	2014-07-06 00:59:00
5047	2014-07-06 01:00:00	2014-07-06 01:09:00
5048	2014-07-06 01:10:00	2014-07-06 01:19:00
5049	2014-07-06 01:20:00	2014-07-06 01:29:00
5050	2014-07-06 01:30:00	2014-07-06 01:39:00
5051	2014-07-06 01:40:00	2014-07-06 01:49:00
5052	2014-07-06 01:50:00	2014-07-06 01:59:00
5053	2014-07-06 02:00:00	2014-07-06 02:09:00
5054	2014-07-06 02:10:00	2014-07-06 02:19:00
5055	2014-07-06 02:20:00	2014-07-06 02:29:00
5056	2014-07-06 02:30:00	2014-07-06 02:39:00
5057	2014-07-06 02:40:00	2014-07-06 02:49:00
5058	2014-07-06 02:50:00	2014-07-06 02:59:00
5059	2014-07-06 03:00:00	2014-07-06 03:09:00
5060	2014-07-06 03:10:00	2014-07-06 03:19:00
5061	2014-07-06 03:20:00	2014-07-06 03:29:00
5062	2014-07-06 03:30:00	2014-07-06 03:39:00
5063	2014-07-06 03:40:00	2014-07-06 03:49:00
5064	2014-07-06 03:50:00	2014-07-06 03:59:00
5065	2014-07-06 04:00:00	2014-07-06 04:09:00
5066	2014-07-06 04:10:00	2014-07-06 04:19:00
5067	2014-07-06 04:20:00	2014-07-06 04:29:00
5068	2014-07-06 04:30:00	2014-07-06 04:39:00
5069	2014-07-06 04:40:00	2014-07-06 04:49:00
5070	2014-07-06 04:50:00	2014-07-06 04:59:00
5071	2014-07-06 05:00:00	2014-07-06 05:09:00
5072	2014-07-06 05:10:00	2014-07-06 05:19:00
5073	2014-07-06 05:20:00	2014-07-06 05:29:00
5074	2014-07-06 05:30:00	2014-07-06 05:39:00
5075	2014-07-06 05:40:00	2014-07-06 05:49:00
5076	2014-07-06 05:50:00	2014-07-06 05:59:00
5077	2014-07-06 06:00:00	2014-07-06 06:09:00
5078	2014-07-06 06:10:00	2014-07-06 06:19:00
5079	2014-07-06 06:20:00	2014-07-06 06:29:00
5080	2014-07-06 06:30:00	2014-07-06 06:39:00
5081	2014-07-06 06:40:00	2014-07-06 06:49:00
5082	2014-07-06 06:50:00	2014-07-06 06:59:00
5083	2014-07-06 07:00:00	2014-07-06 07:09:00
5084	2014-07-06 07:10:00	2014-07-06 07:19:00
5085	2014-07-06 07:20:00	2014-07-06 07:29:00
5086	2014-07-06 07:30:00	2014-07-06 07:39:00
5087	2014-07-06 07:40:00	2014-07-06 07:49:00
5088	2014-07-06 07:50:00	2014-07-06 07:59:00
5089	2014-07-06 08:00:00	2014-07-06 08:09:00
5090	2014-07-06 08:10:00	2014-07-06 08:19:00
5091	2014-07-06 08:20:00	2014-07-06 08:29:00
5092	2014-07-06 08:30:00	2014-07-06 08:39:00
5093	2014-07-06 08:40:00	2014-07-06 08:49:00
5094	2014-07-06 08:50:00	2014-07-06 08:59:00
5095	2014-07-06 09:00:00	2014-07-06 09:09:00
5096	2014-07-06 09:10:00	2014-07-06 09:19:00
5097	2014-07-06 09:20:00	2014-07-06 09:29:00
5098	2014-07-06 09:30:00	2014-07-06 09:39:00
5099	2014-07-06 09:40:00	2014-07-06 09:49:00
5100	2014-07-06 09:50:00	2014-07-06 09:59:00
5101	2014-07-06 10:00:00	2014-07-06 10:09:00
5102	2014-07-06 10:10:00	2014-07-06 10:19:00
5103	2014-07-06 10:20:00	2014-07-06 10:29:00
5104	2014-07-06 10:30:00	2014-07-06 10:39:00
5105	2014-07-06 10:40:00	2014-07-06 10:49:00
5106	2014-07-06 10:50:00	2014-07-06 10:59:00
5107	2014-07-06 11:00:00	2014-07-06 11:09:00
5108	2014-07-06 11:10:00	2014-07-06 11:19:00
5109	2014-07-06 11:20:00	2014-07-06 11:29:00
5110	2014-07-06 11:30:00	2014-07-06 11:39:00
5111	2014-07-06 11:40:00	2014-07-06 11:49:00
5112	2014-07-06 11:50:00	2014-07-06 11:59:00
5113	2014-07-06 12:00:00	2014-07-06 12:09:00
5114	2014-07-06 12:10:00	2014-07-06 12:19:00
5115	2014-07-06 12:20:00	2014-07-06 12:29:00
5116	2014-07-06 12:30:00	2014-07-06 12:39:00
5117	2014-07-06 12:40:00	2014-07-06 12:49:00
5118	2014-07-06 12:50:00	2014-07-06 12:59:00
5119	2014-07-06 13:00:00	2014-07-06 13:09:00
5120	2014-07-06 13:10:00	2014-07-06 13:19:00
5121	2014-07-06 13:20:00	2014-07-06 13:29:00
5122	2014-07-06 13:30:00	2014-07-06 13:39:00
5123	2014-07-06 13:40:00	2014-07-06 13:49:00
5124	2014-07-06 13:50:00	2014-07-06 13:59:00
5125	2014-07-06 14:00:00	2014-07-06 14:09:00
5126	2014-07-06 14:10:00	2014-07-06 14:19:00
5127	2014-07-06 14:20:00	2014-07-06 14:29:00
5128	2014-07-06 14:30:00	2014-07-06 14:39:00
5129	2014-07-06 14:40:00	2014-07-06 14:49:00
5130	2014-07-06 14:50:00	2014-07-06 14:59:00
5131	2014-07-06 15:00:00	2014-07-06 15:09:00
5132	2014-07-06 15:10:00	2014-07-06 15:19:00
5133	2014-07-06 15:20:00	2014-07-06 15:29:00
5134	2014-07-06 15:30:00	2014-07-06 15:39:00
5135	2014-07-06 15:40:00	2014-07-06 15:49:00
5136	2014-07-06 15:50:00	2014-07-06 15:59:00
5137	2014-07-06 16:00:00	2014-07-06 16:09:00
5138	2014-07-06 16:10:00	2014-07-06 16:19:00
5139	2014-07-06 16:20:00	2014-07-06 16:29:00
5140	2014-07-06 16:30:00	2014-07-06 16:39:00
5141	2014-07-06 16:40:00	2014-07-06 16:49:00
5142	2014-07-06 16:50:00	2014-07-06 16:59:00
5143	2014-07-06 17:00:00	2014-07-06 17:09:00
5144	2014-07-06 17:10:00	2014-07-06 17:19:00
5145	2014-07-06 17:20:00	2014-07-06 17:29:00
5146	2014-07-06 17:30:00	2014-07-06 17:39:00
5147	2014-07-06 17:40:00	2014-07-06 17:49:00
5148	2014-07-06 17:50:00	2014-07-06 17:59:00
5149	2014-07-06 18:00:00	2014-07-06 18:09:00
5150	2014-07-06 18:10:00	2014-07-06 18:19:00
5151	2014-07-06 18:20:00	2014-07-06 18:29:00
5152	2014-07-06 18:30:00	2014-07-06 18:39:00
5153	2014-07-06 18:40:00	2014-07-06 18:49:00
5154	2014-07-06 18:50:00	2014-07-06 18:59:00
5155	2014-07-06 19:00:00	2014-07-06 19:09:00
5156	2014-07-06 19:10:00	2014-07-06 19:19:00
5157	2014-07-06 19:20:00	2014-07-06 19:29:00
5158	2014-07-06 19:30:00	2014-07-06 19:39:00
5159	2014-07-06 19:40:00	2014-07-06 19:49:00
5160	2014-07-06 19:50:00	2014-07-06 19:59:00
5161	2014-07-06 20:00:00	2014-07-06 20:09:00
5162	2014-07-06 20:10:00	2014-07-06 20:19:00
5163	2014-07-06 20:20:00	2014-07-06 20:29:00
5164	2014-07-06 20:30:00	2014-07-06 20:39:00
5165	2014-07-06 20:40:00	2014-07-06 20:49:00
5166	2014-07-06 20:50:00	2014-07-06 20:59:00
5167	2014-07-06 21:00:00	2014-07-06 21:09:00
5168	2014-07-06 21:10:00	2014-07-06 21:19:00
5169	2014-07-06 21:20:00	2014-07-06 21:29:00
5170	2014-07-06 21:30:00	2014-07-06 21:39:00
5171	2014-07-06 21:40:00	2014-07-06 21:49:00
5172	2014-07-06 21:50:00	2014-07-06 21:59:00
5173	2014-07-06 22:00:00	2014-07-06 22:09:00
5174	2014-07-06 22:10:00	2014-07-06 22:19:00
5175	2014-07-06 22:20:00	2014-07-06 22:29:00
5176	2014-07-06 22:30:00	2014-07-06 22:39:00
5177	2014-07-06 22:40:00	2014-07-06 22:49:00
5178	2014-07-06 22:50:00	2014-07-06 22:59:00
5179	2014-07-06 23:00:00	2014-07-06 23:09:00
5180	2014-07-06 23:10:00	2014-07-06 23:19:00
5181	2014-07-06 23:20:00	2014-07-06 23:29:00
5182	2014-07-06 23:30:00	2014-07-06 23:39:00
5183	2014-07-06 23:40:00	2014-07-06 23:49:00
5184	2014-07-06 23:50:00	2014-07-06 23:59:00
5185	2014-07-07 00:00:00	2014-07-07 00:09:00
5186	2014-07-07 00:10:00	2014-07-07 00:19:00
5187	2014-07-07 00:20:00	2014-07-07 00:29:00
5188	2014-07-07 00:30:00	2014-07-07 00:39:00
5189	2014-07-07 00:40:00	2014-07-07 00:49:00
5190	2014-07-07 00:50:00	2014-07-07 00:59:00
5191	2014-07-07 01:00:00	2014-07-07 01:09:00
5192	2014-07-07 01:10:00	2014-07-07 01:19:00
5193	2014-07-07 01:20:00	2014-07-07 01:29:00
5194	2014-07-07 01:30:00	2014-07-07 01:39:00
5195	2014-07-07 01:40:00	2014-07-07 01:49:00
5196	2014-07-07 01:50:00	2014-07-07 01:59:00
5197	2014-07-07 02:00:00	2014-07-07 02:09:00
5198	2014-07-07 02:10:00	2014-07-07 02:19:00
5199	2014-07-07 02:20:00	2014-07-07 02:29:00
5200	2014-07-07 02:30:00	2014-07-07 02:39:00
5201	2014-07-07 02:40:00	2014-07-07 02:49:00
5202	2014-07-07 02:50:00	2014-07-07 02:59:00
5203	2014-07-07 03:00:00	2014-07-07 03:09:00
5204	2014-07-07 03:10:00	2014-07-07 03:19:00
5205	2014-07-07 03:20:00	2014-07-07 03:29:00
5206	2014-07-07 03:30:00	2014-07-07 03:39:00
5207	2014-07-07 03:40:00	2014-07-07 03:49:00
5208	2014-07-07 03:50:00	2014-07-07 03:59:00
5209	2014-07-07 04:00:00	2014-07-07 04:09:00
5210	2014-07-07 04:10:00	2014-07-07 04:19:00
5211	2014-07-07 04:20:00	2014-07-07 04:29:00
5212	2014-07-07 04:30:00	2014-07-07 04:39:00
5213	2014-07-07 04:40:00	2014-07-07 04:49:00
5214	2014-07-07 04:50:00	2014-07-07 04:59:00
5215	2014-07-07 05:00:00	2014-07-07 05:09:00
5216	2014-07-07 05:10:00	2014-07-07 05:19:00
5217	2014-07-07 05:20:00	2014-07-07 05:29:00
5218	2014-07-07 05:30:00	2014-07-07 05:39:00
5219	2014-07-07 05:40:00	2014-07-07 05:49:00
5220	2014-07-07 05:50:00	2014-07-07 05:59:00
5221	2014-07-07 06:00:00	2014-07-07 06:09:00
5222	2014-07-07 06:10:00	2014-07-07 06:19:00
5223	2014-07-07 06:20:00	2014-07-07 06:29:00
5224	2014-07-07 06:30:00	2014-07-07 06:39:00
5225	2014-07-07 06:40:00	2014-07-07 06:49:00
5226	2014-07-07 06:50:00	2014-07-07 06:59:00
5227	2014-07-07 07:00:00	2014-07-07 07:09:00
5228	2014-07-07 07:10:00	2014-07-07 07:19:00
5229	2014-07-07 07:20:00	2014-07-07 07:29:00
5230	2014-07-07 07:30:00	2014-07-07 07:39:00
5231	2014-07-07 07:40:00	2014-07-07 07:49:00
5232	2014-07-07 07:50:00	2014-07-07 07:59:00
5233	2014-07-07 08:00:00	2014-07-07 08:09:00
5234	2014-07-07 08:10:00	2014-07-07 08:19:00
5235	2014-07-07 08:20:00	2014-07-07 08:29:00
5236	2014-07-07 08:30:00	2014-07-07 08:39:00
5237	2014-07-07 08:40:00	2014-07-07 08:49:00
5238	2014-07-07 08:50:00	2014-07-07 08:59:00
5239	2014-07-07 09:00:00	2014-07-07 09:09:00
5240	2014-07-07 09:10:00	2014-07-07 09:19:00
5241	2014-07-07 09:20:00	2014-07-07 09:29:00
5242	2014-07-07 09:30:00	2014-07-07 09:39:00
5243	2014-07-07 09:40:00	2014-07-07 09:49:00
5244	2014-07-07 09:50:00	2014-07-07 09:59:00
5245	2014-07-07 10:00:00	2014-07-07 10:09:00
5246	2014-07-07 10:10:00	2014-07-07 10:19:00
5247	2014-07-07 10:20:00	2014-07-07 10:29:00
5248	2014-07-07 10:30:00	2014-07-07 10:39:00
5249	2014-07-07 10:40:00	2014-07-07 10:49:00
5250	2014-07-07 10:50:00	2014-07-07 10:59:00
5251	2014-07-07 11:00:00	2014-07-07 11:09:00
5252	2014-07-07 11:10:00	2014-07-07 11:19:00
5253	2014-07-07 11:20:00	2014-07-07 11:29:00
5254	2014-07-07 11:30:00	2014-07-07 11:39:00
5255	2014-07-07 11:40:00	2014-07-07 11:49:00
5256	2014-07-07 11:50:00	2014-07-07 11:59:00
5257	2014-07-07 12:00:00	2014-07-07 12:09:00
5258	2014-07-07 12:10:00	2014-07-07 12:19:00
5259	2014-07-07 12:20:00	2014-07-07 12:29:00
5260	2014-07-07 12:30:00	2014-07-07 12:39:00
5261	2014-07-07 12:40:00	2014-07-07 12:49:00
5262	2014-07-07 12:50:00	2014-07-07 12:59:00
5263	2014-07-07 13:00:00	2014-07-07 13:09:00
5264	2014-07-07 13:10:00	2014-07-07 13:19:00
5265	2014-07-07 13:20:00	2014-07-07 13:29:00
5266	2014-07-07 13:30:00	2014-07-07 13:39:00
5267	2014-07-07 13:40:00	2014-07-07 13:49:00
5268	2014-07-07 13:50:00	2014-07-07 13:59:00
5269	2014-07-07 14:00:00	2014-07-07 14:09:00
5270	2014-07-07 14:10:00	2014-07-07 14:19:00
5271	2014-07-07 14:20:00	2014-07-07 14:29:00
5272	2014-07-07 14:30:00	2014-07-07 14:39:00
5273	2014-07-07 14:40:00	2014-07-07 14:49:00
5274	2014-07-07 14:50:00	2014-07-07 14:59:00
5275	2014-07-07 15:00:00	2014-07-07 15:09:00
5276	2014-07-07 15:10:00	2014-07-07 15:19:00
5277	2014-07-07 15:20:00	2014-07-07 15:29:00
5278	2014-07-07 15:30:00	2014-07-07 15:39:00
5279	2014-07-07 15:40:00	2014-07-07 15:49:00
5280	2014-07-07 15:50:00	2014-07-07 15:59:00
5281	2014-07-07 16:00:00	2014-07-07 16:09:00
5282	2014-07-07 16:10:00	2014-07-07 16:19:00
5283	2014-07-07 16:20:00	2014-07-07 16:29:00
5284	2014-07-07 16:30:00	2014-07-07 16:39:00
5285	2014-07-07 16:40:00	2014-07-07 16:49:00
5286	2014-07-07 16:50:00	2014-07-07 16:59:00
5287	2014-07-07 17:00:00	2014-07-07 17:09:00
5288	2014-07-07 17:10:00	2014-07-07 17:19:00
5289	2014-07-07 17:20:00	2014-07-07 17:29:00
5290	2014-07-07 17:30:00	2014-07-07 17:39:00
5291	2014-07-07 17:40:00	2014-07-07 17:49:00
5292	2014-07-07 17:50:00	2014-07-07 17:59:00
5293	2014-07-07 18:00:00	2014-07-07 18:09:00
5294	2014-07-07 18:10:00	2014-07-07 18:19:00
5295	2014-07-07 18:20:00	2014-07-07 18:29:00
5296	2014-07-07 18:30:00	2014-07-07 18:39:00
5297	2014-07-07 18:40:00	2014-07-07 18:49:00
5298	2014-07-07 18:50:00	2014-07-07 18:59:00
5299	2014-07-07 19:00:00	2014-07-07 19:09:00
5300	2014-07-07 19:10:00	2014-07-07 19:19:00
5301	2014-07-07 19:20:00	2014-07-07 19:29:00
5302	2014-07-07 19:30:00	2014-07-07 19:39:00
5303	2014-07-07 19:40:00	2014-07-07 19:49:00
5304	2014-07-07 19:50:00	2014-07-07 19:59:00
5305	2014-07-07 20:00:00	2014-07-07 20:09:00
5306	2014-07-07 20:10:00	2014-07-07 20:19:00
5307	2014-07-07 20:20:00	2014-07-07 20:29:00
5308	2014-07-07 20:30:00	2014-07-07 20:39:00
5309	2014-07-07 20:40:00	2014-07-07 20:49:00
5310	2014-07-07 20:50:00	2014-07-07 20:59:00
5311	2014-07-07 21:00:00	2014-07-07 21:09:00
5312	2014-07-07 21:10:00	2014-07-07 21:19:00
5313	2014-07-07 21:20:00	2014-07-07 21:29:00
5314	2014-07-07 21:30:00	2014-07-07 21:39:00
5315	2014-07-07 21:40:00	2014-07-07 21:49:00
5316	2014-07-07 21:50:00	2014-07-07 21:59:00
5317	2014-07-07 22:00:00	2014-07-07 22:09:00
5318	2014-07-07 22:10:00	2014-07-07 22:19:00
5319	2014-07-07 22:20:00	2014-07-07 22:29:00
5320	2014-07-07 22:30:00	2014-07-07 22:39:00
5321	2014-07-07 22:40:00	2014-07-07 22:49:00
5322	2014-07-07 22:50:00	2014-07-07 22:59:00
5323	2014-07-07 23:00:00	2014-07-07 23:09:00
5324	2014-07-07 23:10:00	2014-07-07 23:19:00
5325	2014-07-07 23:20:00	2014-07-07 23:29:00
5326	2014-07-07 23:30:00	2014-07-07 23:39:00
5327	2014-07-07 23:40:00	2014-07-07 23:49:00
5328	2014-07-07 23:50:00	2014-07-07 23:59:00
5329	2014-07-08 00:00:00	2014-07-08 00:09:00
5330	2014-07-08 00:10:00	2014-07-08 00:19:00
5331	2014-07-08 00:20:00	2014-07-08 00:29:00
5332	2014-07-08 00:30:00	2014-07-08 00:39:00
5333	2014-07-08 00:40:00	2014-07-08 00:49:00
5334	2014-07-08 00:50:00	2014-07-08 00:59:00
5335	2014-07-08 01:00:00	2014-07-08 01:09:00
5336	2014-07-08 01:10:00	2014-07-08 01:19:00
5337	2014-07-08 01:20:00	2014-07-08 01:29:00
5338	2014-07-08 01:30:00	2014-07-08 01:39:00
5339	2014-07-08 01:40:00	2014-07-08 01:49:00
5340	2014-07-08 01:50:00	2014-07-08 01:59:00
5341	2014-07-08 02:00:00	2014-07-08 02:09:00
5342	2014-07-08 02:10:00	2014-07-08 02:19:00
5343	2014-07-08 02:20:00	2014-07-08 02:29:00
5344	2014-07-08 02:30:00	2014-07-08 02:39:00
5345	2014-07-08 02:40:00	2014-07-08 02:49:00
5346	2014-07-08 02:50:00	2014-07-08 02:59:00
5347	2014-07-08 03:00:00	2014-07-08 03:09:00
5348	2014-07-08 03:10:00	2014-07-08 03:19:00
5349	2014-07-08 03:20:00	2014-07-08 03:29:00
5350	2014-07-08 03:30:00	2014-07-08 03:39:00
5351	2014-07-08 03:40:00	2014-07-08 03:49:00
5352	2014-07-08 03:50:00	2014-07-08 03:59:00
5353	2014-07-08 04:00:00	2014-07-08 04:09:00
5354	2014-07-08 04:10:00	2014-07-08 04:19:00
5355	2014-07-08 04:20:00	2014-07-08 04:29:00
5356	2014-07-08 04:30:00	2014-07-08 04:39:00
5357	2014-07-08 04:40:00	2014-07-08 04:49:00
5358	2014-07-08 04:50:00	2014-07-08 04:59:00
5359	2014-07-08 05:00:00	2014-07-08 05:09:00
5360	2014-07-08 05:10:00	2014-07-08 05:19:00
5361	2014-07-08 05:20:00	2014-07-08 05:29:00
5362	2014-07-08 05:30:00	2014-07-08 05:39:00
5363	2014-07-08 05:40:00	2014-07-08 05:49:00
5364	2014-07-08 05:50:00	2014-07-08 05:59:00
5365	2014-07-08 06:00:00	2014-07-08 06:09:00
5366	2014-07-08 06:10:00	2014-07-08 06:19:00
5367	2014-07-08 06:20:00	2014-07-08 06:29:00
5368	2014-07-08 06:30:00	2014-07-08 06:39:00
5369	2014-07-08 06:40:00	2014-07-08 06:49:00
5370	2014-07-08 06:50:00	2014-07-08 06:59:00
5371	2014-07-08 07:00:00	2014-07-08 07:09:00
5372	2014-07-08 07:10:00	2014-07-08 07:19:00
5373	2014-07-08 07:20:00	2014-07-08 07:29:00
5374	2014-07-08 07:30:00	2014-07-08 07:39:00
5375	2014-07-08 07:40:00	2014-07-08 07:49:00
5376	2014-07-08 07:50:00	2014-07-08 07:59:00
5377	2014-07-08 08:00:00	2014-07-08 08:09:00
5378	2014-07-08 08:10:00	2014-07-08 08:19:00
5379	2014-07-08 08:20:00	2014-07-08 08:29:00
5380	2014-07-08 08:30:00	2014-07-08 08:39:00
5381	2014-07-08 08:40:00	2014-07-08 08:49:00
5382	2014-07-08 08:50:00	2014-07-08 08:59:00
5383	2014-07-08 09:00:00	2014-07-08 09:09:00
5384	2014-07-08 09:10:00	2014-07-08 09:19:00
5385	2014-07-08 09:20:00	2014-07-08 09:29:00
5386	2014-07-08 09:30:00	2014-07-08 09:39:00
5387	2014-07-08 09:40:00	2014-07-08 09:49:00
5388	2014-07-08 09:50:00	2014-07-08 09:59:00
5389	2014-07-08 10:00:00	2014-07-08 10:09:00
5390	2014-07-08 10:10:00	2014-07-08 10:19:00
5391	2014-07-08 10:20:00	2014-07-08 10:29:00
5392	2014-07-08 10:30:00	2014-07-08 10:39:00
5393	2014-07-08 10:40:00	2014-07-08 10:49:00
5394	2014-07-08 10:50:00	2014-07-08 10:59:00
5395	2014-07-08 11:00:00	2014-07-08 11:09:00
5396	2014-07-08 11:10:00	2014-07-08 11:19:00
5397	2014-07-08 11:20:00	2014-07-08 11:29:00
5398	2014-07-08 11:30:00	2014-07-08 11:39:00
5399	2014-07-08 11:40:00	2014-07-08 11:49:00
5400	2014-07-08 11:50:00	2014-07-08 11:59:00
5401	2014-07-08 12:00:00	2014-07-08 12:09:00
5402	2014-07-08 12:10:00	2014-07-08 12:19:00
5403	2014-07-08 12:20:00	2014-07-08 12:29:00
5404	2014-07-08 12:30:00	2014-07-08 12:39:00
5405	2014-07-08 12:40:00	2014-07-08 12:49:00
5406	2014-07-08 12:50:00	2014-07-08 12:59:00
5407	2014-07-08 13:00:00	2014-07-08 13:09:00
5408	2014-07-08 13:10:00	2014-07-08 13:19:00
5409	2014-07-08 13:20:00	2014-07-08 13:29:00
5410	2014-07-08 13:30:00	2014-07-08 13:39:00
5411	2014-07-08 13:40:00	2014-07-08 13:49:00
5412	2014-07-08 13:50:00	2014-07-08 13:59:00
5413	2014-07-08 14:00:00	2014-07-08 14:09:00
5414	2014-07-08 14:10:00	2014-07-08 14:19:00
5415	2014-07-08 14:20:00	2014-07-08 14:29:00
5416	2014-07-08 14:30:00	2014-07-08 14:39:00
5417	2014-07-08 14:40:00	2014-07-08 14:49:00
5418	2014-07-08 14:50:00	2014-07-08 14:59:00
5419	2014-07-08 15:00:00	2014-07-08 15:09:00
5420	2014-07-08 15:10:00	2014-07-08 15:19:00
5421	2014-07-08 15:20:00	2014-07-08 15:29:00
5422	2014-07-08 15:30:00	2014-07-08 15:39:00
5423	2014-07-08 15:40:00	2014-07-08 15:49:00
5424	2014-07-08 15:50:00	2014-07-08 15:59:00
5425	2014-07-08 16:00:00	2014-07-08 16:09:00
5426	2014-07-08 16:10:00	2014-07-08 16:19:00
5427	2014-07-08 16:20:00	2014-07-08 16:29:00
5428	2014-07-08 16:30:00	2014-07-08 16:39:00
5429	2014-07-08 16:40:00	2014-07-08 16:49:00
5430	2014-07-08 16:50:00	2014-07-08 16:59:00
5431	2014-07-08 17:00:00	2014-07-08 17:09:00
5432	2014-07-08 17:10:00	2014-07-08 17:19:00
5433	2014-07-08 17:20:00	2014-07-08 17:29:00
5434	2014-07-08 17:30:00	2014-07-08 17:39:00
5435	2014-07-08 17:40:00	2014-07-08 17:49:00
5436	2014-07-08 17:50:00	2014-07-08 17:59:00
5437	2014-07-08 18:00:00	2014-07-08 18:09:00
5438	2014-07-08 18:10:00	2014-07-08 18:19:00
5439	2014-07-08 18:20:00	2014-07-08 18:29:00
5440	2014-07-08 18:30:00	2014-07-08 18:39:00
5441	2014-07-08 18:40:00	2014-07-08 18:49:00
5442	2014-07-08 18:50:00	2014-07-08 18:59:00
5443	2014-07-08 19:00:00	2014-07-08 19:09:00
5444	2014-07-08 19:10:00	2014-07-08 19:19:00
5445	2014-07-08 19:20:00	2014-07-08 19:29:00
5446	2014-07-08 19:30:00	2014-07-08 19:39:00
5447	2014-07-08 19:40:00	2014-07-08 19:49:00
5448	2014-07-08 19:50:00	2014-07-08 19:59:00
5449	2014-07-08 20:00:00	2014-07-08 20:09:00
5450	2014-07-08 20:10:00	2014-07-08 20:19:00
5451	2014-07-08 20:20:00	2014-07-08 20:29:00
5452	2014-07-08 20:30:00	2014-07-08 20:39:00
5453	2014-07-08 20:40:00	2014-07-08 20:49:00
5454	2014-07-08 20:50:00	2014-07-08 20:59:00
5455	2014-07-08 21:00:00	2014-07-08 21:09:00
5456	2014-07-08 21:10:00	2014-07-08 21:19:00
5457	2014-07-08 21:20:00	2014-07-08 21:29:00
5458	2014-07-08 21:30:00	2014-07-08 21:39:00
5459	2014-07-08 21:40:00	2014-07-08 21:49:00
5460	2014-07-08 21:50:00	2014-07-08 21:59:00
5461	2014-07-08 22:00:00	2014-07-08 22:09:00
5462	2014-07-08 22:10:00	2014-07-08 22:19:00
5463	2014-07-08 22:20:00	2014-07-08 22:29:00
5464	2014-07-08 22:30:00	2014-07-08 22:39:00
5465	2014-07-08 22:40:00	2014-07-08 22:49:00
5466	2014-07-08 22:50:00	2014-07-08 22:59:00
5467	2014-07-08 23:00:00	2014-07-08 23:09:00
5468	2014-07-08 23:10:00	2014-07-08 23:19:00
5469	2014-07-08 23:20:00	2014-07-08 23:29:00
5470	2014-07-08 23:30:00	2014-07-08 23:39:00
5471	2014-07-08 23:40:00	2014-07-08 23:49:00
5472	2014-07-08 23:50:00	2014-07-08 23:59:00
5473	2014-07-09 00:00:00	2014-07-09 00:09:00
5474	2014-07-09 00:10:00	2014-07-09 00:19:00
5475	2014-07-09 00:20:00	2014-07-09 00:29:00
5476	2014-07-09 00:30:00	2014-07-09 00:39:00
5477	2014-07-09 00:40:00	2014-07-09 00:49:00
5478	2014-07-09 00:50:00	2014-07-09 00:59:00
5479	2014-07-09 01:00:00	2014-07-09 01:09:00
5480	2014-07-09 01:10:00	2014-07-09 01:19:00
5481	2014-07-09 01:20:00	2014-07-09 01:29:00
5482	2014-07-09 01:30:00	2014-07-09 01:39:00
5483	2014-07-09 01:40:00	2014-07-09 01:49:00
5484	2014-07-09 01:50:00	2014-07-09 01:59:00
5485	2014-07-09 02:00:00	2014-07-09 02:09:00
5486	2014-07-09 02:10:00	2014-07-09 02:19:00
5487	2014-07-09 02:20:00	2014-07-09 02:29:00
5488	2014-07-09 02:30:00	2014-07-09 02:39:00
5489	2014-07-09 02:40:00	2014-07-09 02:49:00
5490	2014-07-09 02:50:00	2014-07-09 02:59:00
5491	2014-07-09 03:00:00	2014-07-09 03:09:00
5492	2014-07-09 03:10:00	2014-07-09 03:19:00
5493	2014-07-09 03:20:00	2014-07-09 03:29:00
5494	2014-07-09 03:30:00	2014-07-09 03:39:00
5495	2014-07-09 03:40:00	2014-07-09 03:49:00
5496	2014-07-09 03:50:00	2014-07-09 03:59:00
5497	2014-07-09 04:00:00	2014-07-09 04:09:00
5498	2014-07-09 04:10:00	2014-07-09 04:19:00
5499	2014-07-09 04:20:00	2014-07-09 04:29:00
5500	2014-07-09 04:30:00	2014-07-09 04:39:00
5501	2014-07-09 04:40:00	2014-07-09 04:49:00
5502	2014-07-09 04:50:00	2014-07-09 04:59:00
5503	2014-07-09 05:00:00	2014-07-09 05:09:00
5504	2014-07-09 05:10:00	2014-07-09 05:19:00
5505	2014-07-09 05:20:00	2014-07-09 05:29:00
5506	2014-07-09 05:30:00	2014-07-09 05:39:00
5507	2014-07-09 05:40:00	2014-07-09 05:49:00
5508	2014-07-09 05:50:00	2014-07-09 05:59:00
5509	2014-07-09 06:00:00	2014-07-09 06:09:00
5510	2014-07-09 06:10:00	2014-07-09 06:19:00
5511	2014-07-09 06:20:00	2014-07-09 06:29:00
5512	2014-07-09 06:30:00	2014-07-09 06:39:00
5513	2014-07-09 06:40:00	2014-07-09 06:49:00
5514	2014-07-09 06:50:00	2014-07-09 06:59:00
5515	2014-07-09 07:00:00	2014-07-09 07:09:00
5516	2014-07-09 07:10:00	2014-07-09 07:19:00
5517	2014-07-09 07:20:00	2014-07-09 07:29:00
5518	2014-07-09 07:30:00	2014-07-09 07:39:00
5519	2014-07-09 07:40:00	2014-07-09 07:49:00
5520	2014-07-09 07:50:00	2014-07-09 07:59:00
5521	2014-07-09 08:00:00	2014-07-09 08:09:00
5522	2014-07-09 08:10:00	2014-07-09 08:19:00
5523	2014-07-09 08:20:00	2014-07-09 08:29:00
5524	2014-07-09 08:30:00	2014-07-09 08:39:00
5525	2014-07-09 08:40:00	2014-07-09 08:49:00
5526	2014-07-09 08:50:00	2014-07-09 08:59:00
5527	2014-07-09 09:00:00	2014-07-09 09:09:00
5528	2014-07-09 09:10:00	2014-07-09 09:19:00
5529	2014-07-09 09:20:00	2014-07-09 09:29:00
5530	2014-07-09 09:30:00	2014-07-09 09:39:00
5531	2014-07-09 09:40:00	2014-07-09 09:49:00
5532	2014-07-09 09:50:00	2014-07-09 09:59:00
5533	2014-07-09 10:00:00	2014-07-09 10:09:00
5534	2014-07-09 10:10:00	2014-07-09 10:19:00
5535	2014-07-09 10:20:00	2014-07-09 10:29:00
5536	2014-07-09 10:30:00	2014-07-09 10:39:00
5537	2014-07-09 10:40:00	2014-07-09 10:49:00
5538	2014-07-09 10:50:00	2014-07-09 10:59:00
5539	2014-07-09 11:00:00	2014-07-09 11:09:00
5540	2014-07-09 11:10:00	2014-07-09 11:19:00
5541	2014-07-09 11:20:00	2014-07-09 11:29:00
5542	2014-07-09 11:30:00	2014-07-09 11:39:00
5543	2014-07-09 11:40:00	2014-07-09 11:49:00
5544	2014-07-09 11:50:00	2014-07-09 11:59:00
5545	2014-07-09 12:00:00	2014-07-09 12:09:00
5546	2014-07-09 12:10:00	2014-07-09 12:19:00
5547	2014-07-09 12:20:00	2014-07-09 12:29:00
5548	2014-07-09 12:30:00	2014-07-09 12:39:00
5549	2014-07-09 12:40:00	2014-07-09 12:49:00
5550	2014-07-09 12:50:00	2014-07-09 12:59:00
5551	2014-07-09 13:00:00	2014-07-09 13:09:00
5552	2014-07-09 13:10:00	2014-07-09 13:19:00
5553	2014-07-09 13:20:00	2014-07-09 13:29:00
5554	2014-07-09 13:30:00	2014-07-09 13:39:00
5555	2014-07-09 13:40:00	2014-07-09 13:49:00
5556	2014-07-09 13:50:00	2014-07-09 13:59:00
5557	2014-07-09 14:00:00	2014-07-09 14:09:00
5558	2014-07-09 14:10:00	2014-07-09 14:19:00
5559	2014-07-09 14:20:00	2014-07-09 14:29:00
5560	2014-07-09 14:30:00	2014-07-09 14:39:00
5561	2014-07-09 14:40:00	2014-07-09 14:49:00
5562	2014-07-09 14:50:00	2014-07-09 14:59:00
5563	2014-07-09 15:00:00	2014-07-09 15:09:00
5564	2014-07-09 15:10:00	2014-07-09 15:19:00
5565	2014-07-09 15:20:00	2014-07-09 15:29:00
5566	2014-07-09 15:30:00	2014-07-09 15:39:00
5567	2014-07-09 15:40:00	2014-07-09 15:49:00
5568	2014-07-09 15:50:00	2014-07-09 15:59:00
5569	2014-07-09 16:00:00	2014-07-09 16:09:00
5570	2014-07-09 16:10:00	2014-07-09 16:19:00
5571	2014-07-09 16:20:00	2014-07-09 16:29:00
5572	2014-07-09 16:30:00	2014-07-09 16:39:00
5573	2014-07-09 16:40:00	2014-07-09 16:49:00
5574	2014-07-09 16:50:00	2014-07-09 16:59:00
5575	2014-07-09 17:00:00	2014-07-09 17:09:00
5576	2014-07-09 17:10:00	2014-07-09 17:19:00
5577	2014-07-09 17:20:00	2014-07-09 17:29:00
5578	2014-07-09 17:30:00	2014-07-09 17:39:00
5579	2014-07-09 17:40:00	2014-07-09 17:49:00
5580	2014-07-09 17:50:00	2014-07-09 17:59:00
5581	2014-07-09 18:00:00	2014-07-09 18:09:00
5582	2014-07-09 18:10:00	2014-07-09 18:19:00
5583	2014-07-09 18:20:00	2014-07-09 18:29:00
5584	2014-07-09 18:30:00	2014-07-09 18:39:00
5585	2014-07-09 18:40:00	2014-07-09 18:49:00
5586	2014-07-09 18:50:00	2014-07-09 18:59:00
5587	2014-07-09 19:00:00	2014-07-09 19:09:00
5588	2014-07-09 19:10:00	2014-07-09 19:19:00
5589	2014-07-09 19:20:00	2014-07-09 19:29:00
5590	2014-07-09 19:30:00	2014-07-09 19:39:00
5591	2014-07-09 19:40:00	2014-07-09 19:49:00
5592	2014-07-09 19:50:00	2014-07-09 19:59:00
5593	2014-07-09 20:00:00	2014-07-09 20:09:00
5594	2014-07-09 20:10:00	2014-07-09 20:19:00
5595	2014-07-09 20:20:00	2014-07-09 20:29:00
5596	2014-07-09 20:30:00	2014-07-09 20:39:00
5597	2014-07-09 20:40:00	2014-07-09 20:49:00
5598	2014-07-09 20:50:00	2014-07-09 20:59:00
5599	2014-07-09 21:00:00	2014-07-09 21:09:00
5600	2014-07-09 21:10:00	2014-07-09 21:19:00
5601	2014-07-09 21:20:00	2014-07-09 21:29:00
5602	2014-07-09 21:30:00	2014-07-09 21:39:00
5603	2014-07-09 21:40:00	2014-07-09 21:49:00
5604	2014-07-09 21:50:00	2014-07-09 21:59:00
5605	2014-07-09 22:00:00	2014-07-09 22:09:00
5606	2014-07-09 22:10:00	2014-07-09 22:19:00
5607	2014-07-09 22:20:00	2014-07-09 22:29:00
5608	2014-07-09 22:30:00	2014-07-09 22:39:00
5609	2014-07-09 22:40:00	2014-07-09 22:49:00
5610	2014-07-09 22:50:00	2014-07-09 22:59:00
5611	2014-07-09 23:00:00	2014-07-09 23:09:00
5612	2014-07-09 23:10:00	2014-07-09 23:19:00
5613	2014-07-09 23:20:00	2014-07-09 23:29:00
5614	2014-07-09 23:30:00	2014-07-09 23:39:00
5615	2014-07-09 23:40:00	2014-07-09 23:49:00
5616	2014-07-09 23:50:00	2014-07-09 23:59:00
5617	2014-07-10 00:00:00	2014-07-10 00:09:00
5618	2014-07-10 00:10:00	2014-07-10 00:19:00
5619	2014-07-10 00:20:00	2014-07-10 00:29:00
5620	2014-07-10 00:30:00	2014-07-10 00:39:00
5621	2014-07-10 00:40:00	2014-07-10 00:49:00
5622	2014-07-10 00:50:00	2014-07-10 00:59:00
5623	2014-07-10 01:00:00	2014-07-10 01:09:00
5624	2014-07-10 01:10:00	2014-07-10 01:19:00
5625	2014-07-10 01:20:00	2014-07-10 01:29:00
5626	2014-07-10 01:30:00	2014-07-10 01:39:00
5627	2014-07-10 01:40:00	2014-07-10 01:49:00
5628	2014-07-10 01:50:00	2014-07-10 01:59:00
5629	2014-07-10 02:00:00	2014-07-10 02:09:00
5630	2014-07-10 02:10:00	2014-07-10 02:19:00
5631	2014-07-10 02:20:00	2014-07-10 02:29:00
5632	2014-07-10 02:30:00	2014-07-10 02:39:00
5633	2014-07-10 02:40:00	2014-07-10 02:49:00
5634	2014-07-10 02:50:00	2014-07-10 02:59:00
5635	2014-07-10 03:00:00	2014-07-10 03:09:00
5636	2014-07-10 03:10:00	2014-07-10 03:19:00
5637	2014-07-10 03:20:00	2014-07-10 03:29:00
5638	2014-07-10 03:30:00	2014-07-10 03:39:00
5639	2014-07-10 03:40:00	2014-07-10 03:49:00
5640	2014-07-10 03:50:00	2014-07-10 03:59:00
5641	2014-07-10 04:00:00	2014-07-10 04:09:00
5642	2014-07-10 04:10:00	2014-07-10 04:19:00
5643	2014-07-10 04:20:00	2014-07-10 04:29:00
5644	2014-07-10 04:30:00	2014-07-10 04:39:00
5645	2014-07-10 04:40:00	2014-07-10 04:49:00
5646	2014-07-10 04:50:00	2014-07-10 04:59:00
5647	2014-07-10 05:00:00	2014-07-10 05:09:00
5648	2014-07-10 05:10:00	2014-07-10 05:19:00
5649	2014-07-10 05:20:00	2014-07-10 05:29:00
5650	2014-07-10 05:30:00	2014-07-10 05:39:00
5651	2014-07-10 05:40:00	2014-07-10 05:49:00
5652	2014-07-10 05:50:00	2014-07-10 05:59:00
5653	2014-07-10 06:00:00	2014-07-10 06:09:00
5654	2014-07-10 06:10:00	2014-07-10 06:19:00
5655	2014-07-10 06:20:00	2014-07-10 06:29:00
5656	2014-07-10 06:30:00	2014-07-10 06:39:00
5657	2014-07-10 06:40:00	2014-07-10 06:49:00
5658	2014-07-10 06:50:00	2014-07-10 06:59:00
5659	2014-07-10 07:00:00	2014-07-10 07:09:00
5660	2014-07-10 07:10:00	2014-07-10 07:19:00
5661	2014-07-10 07:20:00	2014-07-10 07:29:00
5662	2014-07-10 07:30:00	2014-07-10 07:39:00
5663	2014-07-10 07:40:00	2014-07-10 07:49:00
5664	2014-07-10 07:50:00	2014-07-10 07:59:00
5665	2014-07-10 08:00:00	2014-07-10 08:09:00
5666	2014-07-10 08:10:00	2014-07-10 08:19:00
5667	2014-07-10 08:20:00	2014-07-10 08:29:00
5668	2014-07-10 08:30:00	2014-07-10 08:39:00
5669	2014-07-10 08:40:00	2014-07-10 08:49:00
5670	2014-07-10 08:50:00	2014-07-10 08:59:00
5671	2014-07-10 09:00:00	2014-07-10 09:09:00
5672	2014-07-10 09:10:00	2014-07-10 09:19:00
5673	2014-07-10 09:20:00	2014-07-10 09:29:00
5674	2014-07-10 09:30:00	2014-07-10 09:39:00
5675	2014-07-10 09:40:00	2014-07-10 09:49:00
5676	2014-07-10 09:50:00	2014-07-10 09:59:00
5677	2014-07-10 10:00:00	2014-07-10 10:09:00
5678	2014-07-10 10:10:00	2014-07-10 10:19:00
5679	2014-07-10 10:20:00	2014-07-10 10:29:00
5680	2014-07-10 10:30:00	2014-07-10 10:39:00
5681	2014-07-10 10:40:00	2014-07-10 10:49:00
5682	2014-07-10 10:50:00	2014-07-10 10:59:00
5683	2014-07-10 11:00:00	2014-07-10 11:09:00
5684	2014-07-10 11:10:00	2014-07-10 11:19:00
5685	2014-07-10 11:20:00	2014-07-10 11:29:00
5686	2014-07-10 11:30:00	2014-07-10 11:39:00
5687	2014-07-10 11:40:00	2014-07-10 11:49:00
5688	2014-07-10 11:50:00	2014-07-10 11:59:00
5689	2014-07-10 12:00:00	2014-07-10 12:09:00
5690	2014-07-10 12:10:00	2014-07-10 12:19:00
5691	2014-07-10 12:20:00	2014-07-10 12:29:00
5692	2014-07-10 12:30:00	2014-07-10 12:39:00
5693	2014-07-10 12:40:00	2014-07-10 12:49:00
5694	2014-07-10 12:50:00	2014-07-10 12:59:00
5695	2014-07-10 13:00:00	2014-07-10 13:09:00
5696	2014-07-10 13:10:00	2014-07-10 13:19:00
5697	2014-07-10 13:20:00	2014-07-10 13:29:00
5698	2014-07-10 13:30:00	2014-07-10 13:39:00
5699	2014-07-10 13:40:00	2014-07-10 13:49:00
5700	2014-07-10 13:50:00	2014-07-10 13:59:00
5701	2014-07-10 14:00:00	2014-07-10 14:09:00
5702	2014-07-10 14:10:00	2014-07-10 14:19:00
5703	2014-07-10 14:20:00	2014-07-10 14:29:00
5704	2014-07-10 14:30:00	2014-07-10 14:39:00
5705	2014-07-10 14:40:00	2014-07-10 14:49:00
5706	2014-07-10 14:50:00	2014-07-10 14:59:00
5707	2014-07-10 15:00:00	2014-07-10 15:09:00
5708	2014-07-10 15:10:00	2014-07-10 15:19:00
5709	2014-07-10 15:20:00	2014-07-10 15:29:00
5710	2014-07-10 15:30:00	2014-07-10 15:39:00
5711	2014-07-10 15:40:00	2014-07-10 15:49:00
5712	2014-07-10 15:50:00	2014-07-10 15:59:00
5713	2014-07-10 16:00:00	2014-07-10 16:09:00
5714	2014-07-10 16:10:00	2014-07-10 16:19:00
5715	2014-07-10 16:20:00	2014-07-10 16:29:00
5716	2014-07-10 16:30:00	2014-07-10 16:39:00
5717	2014-07-10 16:40:00	2014-07-10 16:49:00
5718	2014-07-10 16:50:00	2014-07-10 16:59:00
5719	2014-07-10 17:00:00	2014-07-10 17:09:00
5720	2014-07-10 17:10:00	2014-07-10 17:19:00
5721	2014-07-10 17:20:00	2014-07-10 17:29:00
5722	2014-07-10 17:30:00	2014-07-10 17:39:00
5723	2014-07-10 17:40:00	2014-07-10 17:49:00
5724	2014-07-10 17:50:00	2014-07-10 17:59:00
5725	2014-07-10 18:00:00	2014-07-10 18:09:00
5726	2014-07-10 18:10:00	2014-07-10 18:19:00
5727	2014-07-10 18:20:00	2014-07-10 18:29:00
5728	2014-07-10 18:30:00	2014-07-10 18:39:00
5729	2014-07-10 18:40:00	2014-07-10 18:49:00
5730	2014-07-10 18:50:00	2014-07-10 18:59:00
5731	2014-07-10 19:00:00	2014-07-10 19:09:00
5732	2014-07-10 19:10:00	2014-07-10 19:19:00
5733	2014-07-10 19:20:00	2014-07-10 19:29:00
5734	2014-07-10 19:30:00	2014-07-10 19:39:00
5735	2014-07-10 19:40:00	2014-07-10 19:49:00
5736	2014-07-10 19:50:00	2014-07-10 19:59:00
5737	2014-07-10 20:00:00	2014-07-10 20:09:00
5738	2014-07-10 20:10:00	2014-07-10 20:19:00
5739	2014-07-10 20:20:00	2014-07-10 20:29:00
5740	2014-07-10 20:30:00	2014-07-10 20:39:00
5741	2014-07-10 20:40:00	2014-07-10 20:49:00
5742	2014-07-10 20:50:00	2014-07-10 20:59:00
5743	2014-07-10 21:00:00	2014-07-10 21:09:00
5744	2014-07-10 21:10:00	2014-07-10 21:19:00
5745	2014-07-10 21:20:00	2014-07-10 21:29:00
5746	2014-07-10 21:30:00	2014-07-10 21:39:00
5747	2014-07-10 21:40:00	2014-07-10 21:49:00
5748	2014-07-10 21:50:00	2014-07-10 21:59:00
5749	2014-07-10 22:00:00	2014-07-10 22:09:00
5750	2014-07-10 22:10:00	2014-07-10 22:19:00
5751	2014-07-10 22:20:00	2014-07-10 22:29:00
5752	2014-07-10 22:30:00	2014-07-10 22:39:00
5753	2014-07-10 22:40:00	2014-07-10 22:49:00
5754	2014-07-10 22:50:00	2014-07-10 22:59:00
5755	2014-07-10 23:00:00	2014-07-10 23:09:00
5756	2014-07-10 23:10:00	2014-07-10 23:19:00
5757	2014-07-10 23:20:00	2014-07-10 23:29:00
5758	2014-07-10 23:30:00	2014-07-10 23:39:00
5759	2014-07-10 23:40:00	2014-07-10 23:49:00
5760	2014-07-10 23:50:00	2014-07-10 23:59:00
5761	2014-07-11 00:00:00	2014-07-11 00:09:00
5762	2014-07-11 00:10:00	2014-07-11 00:19:00
5763	2014-07-11 00:20:00	2014-07-11 00:29:00
5764	2014-07-11 00:30:00	2014-07-11 00:39:00
5765	2014-07-11 00:40:00	2014-07-11 00:49:00
5766	2014-07-11 00:50:00	2014-07-11 00:59:00
5767	2014-07-11 01:00:00	2014-07-11 01:09:00
5768	2014-07-11 01:10:00	2014-07-11 01:19:00
5769	2014-07-11 01:20:00	2014-07-11 01:29:00
5770	2014-07-11 01:30:00	2014-07-11 01:39:00
5771	2014-07-11 01:40:00	2014-07-11 01:49:00
5772	2014-07-11 01:50:00	2014-07-11 01:59:00
5773	2014-07-11 02:00:00	2014-07-11 02:09:00
5774	2014-07-11 02:10:00	2014-07-11 02:19:00
5775	2014-07-11 02:20:00	2014-07-11 02:29:00
5776	2014-07-11 02:30:00	2014-07-11 02:39:00
5777	2014-07-11 02:40:00	2014-07-11 02:49:00
5778	2014-07-11 02:50:00	2014-07-11 02:59:00
5779	2014-07-11 03:00:00	2014-07-11 03:09:00
5780	2014-07-11 03:10:00	2014-07-11 03:19:00
5781	2014-07-11 03:20:00	2014-07-11 03:29:00
5782	2014-07-11 03:30:00	2014-07-11 03:39:00
5783	2014-07-11 03:40:00	2014-07-11 03:49:00
5784	2014-07-11 03:50:00	2014-07-11 03:59:00
5785	2014-07-11 04:00:00	2014-07-11 04:09:00
5786	2014-07-11 04:10:00	2014-07-11 04:19:00
5787	2014-07-11 04:20:00	2014-07-11 04:29:00
5788	2014-07-11 04:30:00	2014-07-11 04:39:00
5789	2014-07-11 04:40:00	2014-07-11 04:49:00
5790	2014-07-11 04:50:00	2014-07-11 04:59:00
5791	2014-07-11 05:00:00	2014-07-11 05:09:00
5792	2014-07-11 05:10:00	2014-07-11 05:19:00
5793	2014-07-11 05:20:00	2014-07-11 05:29:00
5794	2014-07-11 05:30:00	2014-07-11 05:39:00
5795	2014-07-11 05:40:00	2014-07-11 05:49:00
5796	2014-07-11 05:50:00	2014-07-11 05:59:00
5797	2014-07-11 06:00:00	2014-07-11 06:09:00
5798	2014-07-11 06:10:00	2014-07-11 06:19:00
5799	2014-07-11 06:20:00	2014-07-11 06:29:00
5800	2014-07-11 06:30:00	2014-07-11 06:39:00
5801	2014-07-11 06:40:00	2014-07-11 06:49:00
5802	2014-07-11 06:50:00	2014-07-11 06:59:00
5803	2014-07-11 07:00:00	2014-07-11 07:09:00
5804	2014-07-11 07:10:00	2014-07-11 07:19:00
5805	2014-07-11 07:20:00	2014-07-11 07:29:00
5806	2014-07-11 07:30:00	2014-07-11 07:39:00
5807	2014-07-11 07:40:00	2014-07-11 07:49:00
5808	2014-07-11 07:50:00	2014-07-11 07:59:00
5809	2014-07-11 08:00:00	2014-07-11 08:09:00
5810	2014-07-11 08:10:00	2014-07-11 08:19:00
5811	2014-07-11 08:20:00	2014-07-11 08:29:00
5812	2014-07-11 08:30:00	2014-07-11 08:39:00
5813	2014-07-11 08:40:00	2014-07-11 08:49:00
5814	2014-07-11 08:50:00	2014-07-11 08:59:00
5815	2014-07-11 09:00:00	2014-07-11 09:09:00
5816	2014-07-11 09:10:00	2014-07-11 09:19:00
5817	2014-07-11 09:20:00	2014-07-11 09:29:00
5818	2014-07-11 09:30:00	2014-07-11 09:39:00
5819	2014-07-11 09:40:00	2014-07-11 09:49:00
5820	2014-07-11 09:50:00	2014-07-11 09:59:00
5821	2014-07-11 10:00:00	2014-07-11 10:09:00
5822	2014-07-11 10:10:00	2014-07-11 10:19:00
5823	2014-07-11 10:20:00	2014-07-11 10:29:00
5824	2014-07-11 10:30:00	2014-07-11 10:39:00
5825	2014-07-11 10:40:00	2014-07-11 10:49:00
5826	2014-07-11 10:50:00	2014-07-11 10:59:00
5827	2014-07-11 11:00:00	2014-07-11 11:09:00
5828	2014-07-11 11:10:00	2014-07-11 11:19:00
5829	2014-07-11 11:20:00	2014-07-11 11:29:00
5830	2014-07-11 11:30:00	2014-07-11 11:39:00
5831	2014-07-11 11:40:00	2014-07-11 11:49:00
5832	2014-07-11 11:50:00	2014-07-11 11:59:00
5833	2014-07-11 12:00:00	2014-07-11 12:09:00
5834	2014-07-11 12:10:00	2014-07-11 12:19:00
5835	2014-07-11 12:20:00	2014-07-11 12:29:00
5836	2014-07-11 12:30:00	2014-07-11 12:39:00
5837	2014-07-11 12:40:00	2014-07-11 12:49:00
5838	2014-07-11 12:50:00	2014-07-11 12:59:00
5839	2014-07-11 13:00:00	2014-07-11 13:09:00
5840	2014-07-11 13:10:00	2014-07-11 13:19:00
5841	2014-07-11 13:20:00	2014-07-11 13:29:00
5842	2014-07-11 13:30:00	2014-07-11 13:39:00
5843	2014-07-11 13:40:00	2014-07-11 13:49:00
5844	2014-07-11 13:50:00	2014-07-11 13:59:00
5845	2014-07-11 14:00:00	2014-07-11 14:09:00
5846	2014-07-11 14:10:00	2014-07-11 14:19:00
5847	2014-07-11 14:20:00	2014-07-11 14:29:00
5848	2014-07-11 14:30:00	2014-07-11 14:39:00
5849	2014-07-11 14:40:00	2014-07-11 14:49:00
5850	2014-07-11 14:50:00	2014-07-11 14:59:00
5851	2014-07-11 15:00:00	2014-07-11 15:09:00
5852	2014-07-11 15:10:00	2014-07-11 15:19:00
5853	2014-07-11 15:20:00	2014-07-11 15:29:00
5854	2014-07-11 15:30:00	2014-07-11 15:39:00
5855	2014-07-11 15:40:00	2014-07-11 15:49:00
5856	2014-07-11 15:50:00	2014-07-11 15:59:00
5857	2014-07-11 16:00:00	2014-07-11 16:09:00
5858	2014-07-11 16:10:00	2014-07-11 16:19:00
5859	2014-07-11 16:20:00	2014-07-11 16:29:00
5860	2014-07-11 16:30:00	2014-07-11 16:39:00
5861	2014-07-11 16:40:00	2014-07-11 16:49:00
5862	2014-07-11 16:50:00	2014-07-11 16:59:00
5863	2014-07-11 17:00:00	2014-07-11 17:09:00
5864	2014-07-11 17:10:00	2014-07-11 17:19:00
5865	2014-07-11 17:20:00	2014-07-11 17:29:00
5866	2014-07-11 17:30:00	2014-07-11 17:39:00
5867	2014-07-11 17:40:00	2014-07-11 17:49:00
5868	2014-07-11 17:50:00	2014-07-11 17:59:00
5869	2014-07-11 18:00:00	2014-07-11 18:09:00
5870	2014-07-11 18:10:00	2014-07-11 18:19:00
5871	2014-07-11 18:20:00	2014-07-11 18:29:00
5872	2014-07-11 18:30:00	2014-07-11 18:39:00
5873	2014-07-11 18:40:00	2014-07-11 18:49:00
5874	2014-07-11 18:50:00	2014-07-11 18:59:00
5875	2014-07-11 19:00:00	2014-07-11 19:09:00
5876	2014-07-11 19:10:00	2014-07-11 19:19:00
5877	2014-07-11 19:20:00	2014-07-11 19:29:00
5878	2014-07-11 19:30:00	2014-07-11 19:39:00
5879	2014-07-11 19:40:00	2014-07-11 19:49:00
5880	2014-07-11 19:50:00	2014-07-11 19:59:00
5881	2014-07-11 20:00:00	2014-07-11 20:09:00
5882	2014-07-11 20:10:00	2014-07-11 20:19:00
5883	2014-07-11 20:20:00	2014-07-11 20:29:00
5884	2014-07-11 20:30:00	2014-07-11 20:39:00
5885	2014-07-11 20:40:00	2014-07-11 20:49:00
5886	2014-07-11 20:50:00	2014-07-11 20:59:00
5887	2014-07-11 21:00:00	2014-07-11 21:09:00
5888	2014-07-11 21:10:00	2014-07-11 21:19:00
5889	2014-07-11 21:20:00	2014-07-11 21:29:00
5890	2014-07-11 21:30:00	2014-07-11 21:39:00
5891	2014-07-11 21:40:00	2014-07-11 21:49:00
5892	2014-07-11 21:50:00	2014-07-11 21:59:00
5893	2014-07-11 22:00:00	2014-07-11 22:09:00
5894	2014-07-11 22:10:00	2014-07-11 22:19:00
5895	2014-07-11 22:20:00	2014-07-11 22:29:00
5896	2014-07-11 22:30:00	2014-07-11 22:39:00
5897	2014-07-11 22:40:00	2014-07-11 22:49:00
5898	2014-07-11 22:50:00	2014-07-11 22:59:00
5899	2014-07-11 23:00:00	2014-07-11 23:09:00
5900	2014-07-11 23:10:00	2014-07-11 23:19:00
5901	2014-07-11 23:20:00	2014-07-11 23:29:00
5902	2014-07-11 23:30:00	2014-07-11 23:39:00
5903	2014-07-11 23:40:00	2014-07-11 23:49:00
5904	2014-07-11 23:50:00	2014-07-11 23:59:00
5905	2014-07-12 00:00:00	2014-07-12 00:09:00
5906	2014-07-12 00:10:00	2014-07-12 00:19:00
5907	2014-07-12 00:20:00	2014-07-12 00:29:00
5908	2014-07-12 00:30:00	2014-07-12 00:39:00
5909	2014-07-12 00:40:00	2014-07-12 00:49:00
5910	2014-07-12 00:50:00	2014-07-12 00:59:00
5911	2014-07-12 01:00:00	2014-07-12 01:09:00
5912	2014-07-12 01:10:00	2014-07-12 01:19:00
5913	2014-07-12 01:20:00	2014-07-12 01:29:00
5914	2014-07-12 01:30:00	2014-07-12 01:39:00
5915	2014-07-12 01:40:00	2014-07-12 01:49:00
5916	2014-07-12 01:50:00	2014-07-12 01:59:00
5917	2014-07-12 02:00:00	2014-07-12 02:09:00
5918	2014-07-12 02:10:00	2014-07-12 02:19:00
5919	2014-07-12 02:20:00	2014-07-12 02:29:00
5920	2014-07-12 02:30:00	2014-07-12 02:39:00
5921	2014-07-12 02:40:00	2014-07-12 02:49:00
5922	2014-07-12 02:50:00	2014-07-12 02:59:00
5923	2014-07-12 03:00:00	2014-07-12 03:09:00
5924	2014-07-12 03:10:00	2014-07-12 03:19:00
5925	2014-07-12 03:20:00	2014-07-12 03:29:00
5926	2014-07-12 03:30:00	2014-07-12 03:39:00
5927	2014-07-12 03:40:00	2014-07-12 03:49:00
5928	2014-07-12 03:50:00	2014-07-12 03:59:00
5929	2014-07-12 04:00:00	2014-07-12 04:09:00
5930	2014-07-12 04:10:00	2014-07-12 04:19:00
5931	2014-07-12 04:20:00	2014-07-12 04:29:00
5932	2014-07-12 04:30:00	2014-07-12 04:39:00
5933	2014-07-12 04:40:00	2014-07-12 04:49:00
5934	2014-07-12 04:50:00	2014-07-12 04:59:00
5935	2014-07-12 05:00:00	2014-07-12 05:09:00
5936	2014-07-12 05:10:00	2014-07-12 05:19:00
5937	2014-07-12 05:20:00	2014-07-12 05:29:00
5938	2014-07-12 05:30:00	2014-07-12 05:39:00
5939	2014-07-12 05:40:00	2014-07-12 05:49:00
5940	2014-07-12 05:50:00	2014-07-12 05:59:00
5941	2014-07-12 06:00:00	2014-07-12 06:09:00
5942	2014-07-12 06:10:00	2014-07-12 06:19:00
5943	2014-07-12 06:20:00	2014-07-12 06:29:00
5944	2014-07-12 06:30:00	2014-07-12 06:39:00
5945	2014-07-12 06:40:00	2014-07-12 06:49:00
5946	2014-07-12 06:50:00	2014-07-12 06:59:00
5947	2014-07-12 07:00:00	2014-07-12 07:09:00
5948	2014-07-12 07:10:00	2014-07-12 07:19:00
5949	2014-07-12 07:20:00	2014-07-12 07:29:00
5950	2014-07-12 07:30:00	2014-07-12 07:39:00
5951	2014-07-12 07:40:00	2014-07-12 07:49:00
5952	2014-07-12 07:50:00	2014-07-12 07:59:00
5953	2014-07-12 08:00:00	2014-07-12 08:09:00
5954	2014-07-12 08:10:00	2014-07-12 08:19:00
5955	2014-07-12 08:20:00	2014-07-12 08:29:00
5956	2014-07-12 08:30:00	2014-07-12 08:39:00
5957	2014-07-12 08:40:00	2014-07-12 08:49:00
5958	2014-07-12 08:50:00	2014-07-12 08:59:00
5959	2014-07-12 09:00:00	2014-07-12 09:09:00
5960	2014-07-12 09:10:00	2014-07-12 09:19:00
5961	2014-07-12 09:20:00	2014-07-12 09:29:00
5962	2014-07-12 09:30:00	2014-07-12 09:39:00
5963	2014-07-12 09:40:00	2014-07-12 09:49:00
5964	2014-07-12 09:50:00	2014-07-12 09:59:00
5965	2014-07-12 10:00:00	2014-07-12 10:09:00
5966	2014-07-12 10:10:00	2014-07-12 10:19:00
5967	2014-07-12 10:20:00	2014-07-12 10:29:00
5968	2014-07-12 10:30:00	2014-07-12 10:39:00
5969	2014-07-12 10:40:00	2014-07-12 10:49:00
5970	2014-07-12 10:50:00	2014-07-12 10:59:00
5971	2014-07-12 11:00:00	2014-07-12 11:09:00
5972	2014-07-12 11:10:00	2014-07-12 11:19:00
5973	2014-07-12 11:20:00	2014-07-12 11:29:00
5974	2014-07-12 11:30:00	2014-07-12 11:39:00
5975	2014-07-12 11:40:00	2014-07-12 11:49:00
5976	2014-07-12 11:50:00	2014-07-12 11:59:00
5977	2014-07-12 12:00:00	2014-07-12 12:09:00
5978	2014-07-12 12:10:00	2014-07-12 12:19:00
5979	2014-07-12 12:20:00	2014-07-12 12:29:00
5980	2014-07-12 12:30:00	2014-07-12 12:39:00
5981	2014-07-12 12:40:00	2014-07-12 12:49:00
5982	2014-07-12 12:50:00	2014-07-12 12:59:00
5983	2014-07-12 13:00:00	2014-07-12 13:09:00
5984	2014-07-12 13:10:00	2014-07-12 13:19:00
5985	2014-07-12 13:20:00	2014-07-12 13:29:00
5986	2014-07-12 13:30:00	2014-07-12 13:39:00
5987	2014-07-12 13:40:00	2014-07-12 13:49:00
5988	2014-07-12 13:50:00	2014-07-12 13:59:00
5989	2014-07-12 14:00:00	2014-07-12 14:09:00
5990	2014-07-12 14:10:00	2014-07-12 14:19:00
5991	2014-07-12 14:20:00	2014-07-12 14:29:00
5992	2014-07-12 14:30:00	2014-07-12 14:39:00
5993	2014-07-12 14:40:00	2014-07-12 14:49:00
5994	2014-07-12 14:50:00	2014-07-12 14:59:00
5995	2014-07-12 15:00:00	2014-07-12 15:09:00
5996	2014-07-12 15:10:00	2014-07-12 15:19:00
5997	2014-07-12 15:20:00	2014-07-12 15:29:00
5998	2014-07-12 15:30:00	2014-07-12 15:39:00
5999	2014-07-12 15:40:00	2014-07-12 15:49:00
6000	2014-07-12 15:50:00	2014-07-12 15:59:00
6001	2014-07-12 16:00:00	2014-07-12 16:09:00
6002	2014-07-12 16:10:00	2014-07-12 16:19:00
6003	2014-07-12 16:20:00	2014-07-12 16:29:00
6004	2014-07-12 16:30:00	2014-07-12 16:39:00
6005	2014-07-12 16:40:00	2014-07-12 16:49:00
6006	2014-07-12 16:50:00	2014-07-12 16:59:00
6007	2014-07-12 17:00:00	2014-07-12 17:09:00
6008	2014-07-12 17:10:00	2014-07-12 17:19:00
6009	2014-07-12 17:20:00	2014-07-12 17:29:00
6010	2014-07-12 17:30:00	2014-07-12 17:39:00
6011	2014-07-12 17:40:00	2014-07-12 17:49:00
6012	2014-07-12 17:50:00	2014-07-12 17:59:00
6013	2014-07-12 18:00:00	2014-07-12 18:09:00
6014	2014-07-12 18:10:00	2014-07-12 18:19:00
6015	2014-07-12 18:20:00	2014-07-12 18:29:00
6016	2014-07-12 18:30:00	2014-07-12 18:39:00
6017	2014-07-12 18:40:00	2014-07-12 18:49:00
6018	2014-07-12 18:50:00	2014-07-12 18:59:00
6019	2014-07-12 19:00:00	2014-07-12 19:09:00
6020	2014-07-12 19:10:00	2014-07-12 19:19:00
6021	2014-07-12 19:20:00	2014-07-12 19:29:00
6022	2014-07-12 19:30:00	2014-07-12 19:39:00
6023	2014-07-12 19:40:00	2014-07-12 19:49:00
6024	2014-07-12 19:50:00	2014-07-12 19:59:00
6025	2014-07-12 20:00:00	2014-07-12 20:09:00
6026	2014-07-12 20:10:00	2014-07-12 20:19:00
6027	2014-07-12 20:20:00	2014-07-12 20:29:00
6028	2014-07-12 20:30:00	2014-07-12 20:39:00
6029	2014-07-12 20:40:00	2014-07-12 20:49:00
6030	2014-07-12 20:50:00	2014-07-12 20:59:00
6031	2014-07-12 21:00:00	2014-07-12 21:09:00
6032	2014-07-12 21:10:00	2014-07-12 21:19:00
6033	2014-07-12 21:20:00	2014-07-12 21:29:00
6034	2014-07-12 21:30:00	2014-07-12 21:39:00
6035	2014-07-12 21:40:00	2014-07-12 21:49:00
6036	2014-07-12 21:50:00	2014-07-12 21:59:00
6037	2014-07-12 22:00:00	2014-07-12 22:09:00
6038	2014-07-12 22:10:00	2014-07-12 22:19:00
6039	2014-07-12 22:20:00	2014-07-12 22:29:00
6040	2014-07-12 22:30:00	2014-07-12 22:39:00
6041	2014-07-12 22:40:00	2014-07-12 22:49:00
6042	2014-07-12 22:50:00	2014-07-12 22:59:00
6043	2014-07-12 23:00:00	2014-07-12 23:09:00
6044	2014-07-12 23:10:00	2014-07-12 23:19:00
6045	2014-07-12 23:20:00	2014-07-12 23:29:00
6046	2014-07-12 23:30:00	2014-07-12 23:39:00
6047	2014-07-12 23:40:00	2014-07-12 23:49:00
6048	2014-07-12 23:50:00	2014-07-12 23:59:00
6049	2014-07-13 00:00:00	2014-07-13 00:09:00
6050	2014-07-13 00:10:00	2014-07-13 00:19:00
6051	2014-07-13 00:20:00	2014-07-13 00:29:00
6052	2014-07-13 00:30:00	2014-07-13 00:39:00
6053	2014-07-13 00:40:00	2014-07-13 00:49:00
6054	2014-07-13 00:50:00	2014-07-13 00:59:00
6055	2014-07-13 01:00:00	2014-07-13 01:09:00
6056	2014-07-13 01:10:00	2014-07-13 01:19:00
6057	2014-07-13 01:20:00	2014-07-13 01:29:00
6058	2014-07-13 01:30:00	2014-07-13 01:39:00
6059	2014-07-13 01:40:00	2014-07-13 01:49:00
6060	2014-07-13 01:50:00	2014-07-13 01:59:00
6061	2014-07-13 02:00:00	2014-07-13 02:09:00
6062	2014-07-13 02:10:00	2014-07-13 02:19:00
6063	2014-07-13 02:20:00	2014-07-13 02:29:00
6064	2014-07-13 02:30:00	2014-07-13 02:39:00
6065	2014-07-13 02:40:00	2014-07-13 02:49:00
6066	2014-07-13 02:50:00	2014-07-13 02:59:00
6067	2014-07-13 03:00:00	2014-07-13 03:09:00
6068	2014-07-13 03:10:00	2014-07-13 03:19:00
6069	2014-07-13 03:20:00	2014-07-13 03:29:00
6070	2014-07-13 03:30:00	2014-07-13 03:39:00
6071	2014-07-13 03:40:00	2014-07-13 03:49:00
6072	2014-07-13 03:50:00	2014-07-13 03:59:00
6073	2014-07-13 04:00:00	2014-07-13 04:09:00
6074	2014-07-13 04:10:00	2014-07-13 04:19:00
6075	2014-07-13 04:20:00	2014-07-13 04:29:00
6076	2014-07-13 04:30:00	2014-07-13 04:39:00
6077	2014-07-13 04:40:00	2014-07-13 04:49:00
6078	2014-07-13 04:50:00	2014-07-13 04:59:00
6079	2014-07-13 05:00:00	2014-07-13 05:09:00
6080	2014-07-13 05:10:00	2014-07-13 05:19:00
6081	2014-07-13 05:20:00	2014-07-13 05:29:00
6082	2014-07-13 05:30:00	2014-07-13 05:39:00
6083	2014-07-13 05:40:00	2014-07-13 05:49:00
6084	2014-07-13 05:50:00	2014-07-13 05:59:00
6085	2014-07-13 06:00:00	2014-07-13 06:09:00
6086	2014-07-13 06:10:00	2014-07-13 06:19:00
6087	2014-07-13 06:20:00	2014-07-13 06:29:00
6088	2014-07-13 06:30:00	2014-07-13 06:39:00
6089	2014-07-13 06:40:00	2014-07-13 06:49:00
6090	2014-07-13 06:50:00	2014-07-13 06:59:00
6091	2014-07-13 07:00:00	2014-07-13 07:09:00
6092	2014-07-13 07:10:00	2014-07-13 07:19:00
6093	2014-07-13 07:20:00	2014-07-13 07:29:00
6094	2014-07-13 07:30:00	2014-07-13 07:39:00
6095	2014-07-13 07:40:00	2014-07-13 07:49:00
6096	2014-07-13 07:50:00	2014-07-13 07:59:00
6097	2014-07-13 08:00:00	2014-07-13 08:09:00
6098	2014-07-13 08:10:00	2014-07-13 08:19:00
6099	2014-07-13 08:20:00	2014-07-13 08:29:00
6100	2014-07-13 08:30:00	2014-07-13 08:39:00
6101	2014-07-13 08:40:00	2014-07-13 08:49:00
6102	2014-07-13 08:50:00	2014-07-13 08:59:00
6103	2014-07-13 09:00:00	2014-07-13 09:09:00
6104	2014-07-13 09:10:00	2014-07-13 09:19:00
6105	2014-07-13 09:20:00	2014-07-13 09:29:00
6106	2014-07-13 09:30:00	2014-07-13 09:39:00
6107	2014-07-13 09:40:00	2014-07-13 09:49:00
6108	2014-07-13 09:50:00	2014-07-13 09:59:00
6109	2014-07-13 10:00:00	2014-07-13 10:09:00
6110	2014-07-13 10:10:00	2014-07-13 10:19:00
6111	2014-07-13 10:20:00	2014-07-13 10:29:00
6112	2014-07-13 10:30:00	2014-07-13 10:39:00
6113	2014-07-13 10:40:00	2014-07-13 10:49:00
6114	2014-07-13 10:50:00	2014-07-13 10:59:00
6115	2014-07-13 11:00:00	2014-07-13 11:09:00
6116	2014-07-13 11:10:00	2014-07-13 11:19:00
6117	2014-07-13 11:20:00	2014-07-13 11:29:00
6118	2014-07-13 11:30:00	2014-07-13 11:39:00
6119	2014-07-13 11:40:00	2014-07-13 11:49:00
6120	2014-07-13 11:50:00	2014-07-13 11:59:00
6121	2014-07-13 12:00:00	2014-07-13 12:09:00
6122	2014-07-13 12:10:00	2014-07-13 12:19:00
6123	2014-07-13 12:20:00	2014-07-13 12:29:00
6124	2014-07-13 12:30:00	2014-07-13 12:39:00
6125	2014-07-13 12:40:00	2014-07-13 12:49:00
6126	2014-07-13 12:50:00	2014-07-13 12:59:00
6127	2014-07-13 13:00:00	2014-07-13 13:09:00
6128	2014-07-13 13:10:00	2014-07-13 13:19:00
6129	2014-07-13 13:20:00	2014-07-13 13:29:00
6130	2014-07-13 13:30:00	2014-07-13 13:39:00
6131	2014-07-13 13:40:00	2014-07-13 13:49:00
6132	2014-07-13 13:50:00	2014-07-13 13:59:00
6133	2014-07-13 14:00:00	2014-07-13 14:09:00
6134	2014-07-13 14:10:00	2014-07-13 14:19:00
6135	2014-07-13 14:20:00	2014-07-13 14:29:00
6136	2014-07-13 14:30:00	2014-07-13 14:39:00
6137	2014-07-13 14:40:00	2014-07-13 14:49:00
6138	2014-07-13 14:50:00	2014-07-13 14:59:00
6139	2014-07-13 15:00:00	2014-07-13 15:09:00
6140	2014-07-13 15:10:00	2014-07-13 15:19:00
6141	2014-07-13 15:20:00	2014-07-13 15:29:00
6142	2014-07-13 15:30:00	2014-07-13 15:39:00
6143	2014-07-13 15:40:00	2014-07-13 15:49:00
6144	2014-07-13 15:50:00	2014-07-13 15:59:00
6145	2014-07-13 16:00:00	2014-07-13 16:09:00
6146	2014-07-13 16:10:00	2014-07-13 16:19:00
6147	2014-07-13 16:20:00	2014-07-13 16:29:00
6148	2014-07-13 16:30:00	2014-07-13 16:39:00
6149	2014-07-13 16:40:00	2014-07-13 16:49:00
6150	2014-07-13 16:50:00	2014-07-13 16:59:00
6151	2014-07-13 17:00:00	2014-07-13 17:09:00
6152	2014-07-13 17:10:00	2014-07-13 17:19:00
6153	2014-07-13 17:20:00	2014-07-13 17:29:00
6154	2014-07-13 17:30:00	2014-07-13 17:39:00
6155	2014-07-13 17:40:00	2014-07-13 17:49:00
6156	2014-07-13 17:50:00	2014-07-13 17:59:00
6157	2014-07-13 18:00:00	2014-07-13 18:09:00
6158	2014-07-13 18:10:00	2014-07-13 18:19:00
6159	2014-07-13 18:20:00	2014-07-13 18:29:00
6160	2014-07-13 18:30:00	2014-07-13 18:39:00
6161	2014-07-13 18:40:00	2014-07-13 18:49:00
6162	2014-07-13 18:50:00	2014-07-13 18:59:00
6163	2014-07-13 19:00:00	2014-07-13 19:09:00
6164	2014-07-13 19:10:00	2014-07-13 19:19:00
6165	2014-07-13 19:20:00	2014-07-13 19:29:00
6166	2014-07-13 19:30:00	2014-07-13 19:39:00
6167	2014-07-13 19:40:00	2014-07-13 19:49:00
6168	2014-07-13 19:50:00	2014-07-13 19:59:00
6169	2014-07-13 20:00:00	2014-07-13 20:09:00
6170	2014-07-13 20:10:00	2014-07-13 20:19:00
6171	2014-07-13 20:20:00	2014-07-13 20:29:00
6172	2014-07-13 20:30:00	2014-07-13 20:39:00
6173	2014-07-13 20:40:00	2014-07-13 20:49:00
6174	2014-07-13 20:50:00	2014-07-13 20:59:00
6175	2014-07-13 21:00:00	2014-07-13 21:09:00
6176	2014-07-13 21:10:00	2014-07-13 21:19:00
6177	2014-07-13 21:20:00	2014-07-13 21:29:00
6178	2014-07-13 21:30:00	2014-07-13 21:39:00
6179	2014-07-13 21:40:00	2014-07-13 21:49:00
6180	2014-07-13 21:50:00	2014-07-13 21:59:00
6181	2014-07-13 22:00:00	2014-07-13 22:09:00
6182	2014-07-13 22:10:00	2014-07-13 22:19:00
6183	2014-07-13 22:20:00	2014-07-13 22:29:00
6184	2014-07-13 22:30:00	2014-07-13 22:39:00
6185	2014-07-13 22:40:00	2014-07-13 22:49:00
6186	2014-07-13 22:50:00	2014-07-13 22:59:00
6187	2014-07-13 23:00:00	2014-07-13 23:09:00
6188	2014-07-13 23:10:00	2014-07-13 23:19:00
6189	2014-07-13 23:20:00	2014-07-13 23:29:00
6190	2014-07-13 23:30:00	2014-07-13 23:39:00
6191	2014-07-13 23:40:00	2014-07-13 23:49:00
6192	2014-07-13 23:50:00	2014-07-13 23:59:00
6193	2014-07-14 00:00:00	2014-07-14 00:09:00
6194	2014-07-14 00:10:00	2014-07-14 00:19:00
6195	2014-07-14 00:20:00	2014-07-14 00:29:00
6196	2014-07-14 00:30:00	2014-07-14 00:39:00
6197	2014-07-14 00:40:00	2014-07-14 00:49:00
6198	2014-07-14 00:50:00	2014-07-14 00:59:00
6199	2014-07-14 01:00:00	2014-07-14 01:09:00
6200	2014-07-14 01:10:00	2014-07-14 01:19:00
6201	2014-07-14 01:20:00	2014-07-14 01:29:00
6202	2014-07-14 01:30:00	2014-07-14 01:39:00
6203	2014-07-14 01:40:00	2014-07-14 01:49:00
6204	2014-07-14 01:50:00	2014-07-14 01:59:00
6205	2014-07-14 02:00:00	2014-07-14 02:09:00
6206	2014-07-14 02:10:00	2014-07-14 02:19:00
6207	2014-07-14 02:20:00	2014-07-14 02:29:00
6208	2014-07-14 02:30:00	2014-07-14 02:39:00
6209	2014-07-14 02:40:00	2014-07-14 02:49:00
6210	2014-07-14 02:50:00	2014-07-14 02:59:00
6211	2014-07-14 03:00:00	2014-07-14 03:09:00
6212	2014-07-14 03:10:00	2014-07-14 03:19:00
6213	2014-07-14 03:20:00	2014-07-14 03:29:00
6214	2014-07-14 03:30:00	2014-07-14 03:39:00
6215	2014-07-14 03:40:00	2014-07-14 03:49:00
6216	2014-07-14 03:50:00	2014-07-14 03:59:00
6217	2014-07-14 04:00:00	2014-07-14 04:09:00
6218	2014-07-14 04:10:00	2014-07-14 04:19:00
6219	2014-07-14 04:20:00	2014-07-14 04:29:00
6220	2014-07-14 04:30:00	2014-07-14 04:39:00
6221	2014-07-14 04:40:00	2014-07-14 04:49:00
6222	2014-07-14 04:50:00	2014-07-14 04:59:00
6223	2014-07-14 05:00:00	2014-07-14 05:09:00
6224	2014-07-14 05:10:00	2014-07-14 05:19:00
6225	2014-07-14 05:20:00	2014-07-14 05:29:00
6226	2014-07-14 05:30:00	2014-07-14 05:39:00
6227	2014-07-14 05:40:00	2014-07-14 05:49:00
6228	2014-07-14 05:50:00	2014-07-14 05:59:00
6229	2014-07-14 06:00:00	2014-07-14 06:09:00
6230	2014-07-14 06:10:00	2014-07-14 06:19:00
6231	2014-07-14 06:20:00	2014-07-14 06:29:00
6232	2014-07-14 06:30:00	2014-07-14 06:39:00
6233	2014-07-14 06:40:00	2014-07-14 06:49:00
6234	2014-07-14 06:50:00	2014-07-14 06:59:00
6235	2014-07-14 07:00:00	2014-07-14 07:09:00
6236	2014-07-14 07:10:00	2014-07-14 07:19:00
6237	2014-07-14 07:20:00	2014-07-14 07:29:00
6238	2014-07-14 07:30:00	2014-07-14 07:39:00
6239	2014-07-14 07:40:00	2014-07-14 07:49:00
6240	2014-07-14 07:50:00	2014-07-14 07:59:00
6241	2014-07-14 08:00:00	2014-07-14 08:09:00
6242	2014-07-14 08:10:00	2014-07-14 08:19:00
6243	2014-07-14 08:20:00	2014-07-14 08:29:00
6244	2014-07-14 08:30:00	2014-07-14 08:39:00
6245	2014-07-14 08:40:00	2014-07-14 08:49:00
6246	2014-07-14 08:50:00	2014-07-14 08:59:00
6247	2014-07-14 09:00:00	2014-07-14 09:09:00
6248	2014-07-14 09:10:00	2014-07-14 09:19:00
6249	2014-07-14 09:20:00	2014-07-14 09:29:00
6250	2014-07-14 09:30:00	2014-07-14 09:39:00
6251	2014-07-14 09:40:00	2014-07-14 09:49:00
6252	2014-07-14 09:50:00	2014-07-14 09:59:00
6253	2014-07-14 10:00:00	2014-07-14 10:09:00
6254	2014-07-14 10:10:00	2014-07-14 10:19:00
6255	2014-07-14 10:20:00	2014-07-14 10:29:00
6256	2014-07-14 10:30:00	2014-07-14 10:39:00
6257	2014-07-14 10:40:00	2014-07-14 10:49:00
6258	2014-07-14 10:50:00	2014-07-14 10:59:00
6259	2014-07-14 11:00:00	2014-07-14 11:09:00
6260	2014-07-14 11:10:00	2014-07-14 11:19:00
6261	2014-07-14 11:20:00	2014-07-14 11:29:00
6262	2014-07-14 11:30:00	2014-07-14 11:39:00
6263	2014-07-14 11:40:00	2014-07-14 11:49:00
6264	2014-07-14 11:50:00	2014-07-14 11:59:00
6265	2014-07-14 12:00:00	2014-07-14 12:09:00
6266	2014-07-14 12:10:00	2014-07-14 12:19:00
6267	2014-07-14 12:20:00	2014-07-14 12:29:00
6268	2014-07-14 12:30:00	2014-07-14 12:39:00
6269	2014-07-14 12:40:00	2014-07-14 12:49:00
6270	2014-07-14 12:50:00	2014-07-14 12:59:00
6271	2014-07-14 13:00:00	2014-07-14 13:09:00
6272	2014-07-14 13:10:00	2014-07-14 13:19:00
6273	2014-07-14 13:20:00	2014-07-14 13:29:00
6274	2014-07-14 13:30:00	2014-07-14 13:39:00
6275	2014-07-14 13:40:00	2014-07-14 13:49:00
6276	2014-07-14 13:50:00	2014-07-14 13:59:00
6277	2014-07-14 14:00:00	2014-07-14 14:09:00
6278	2014-07-14 14:10:00	2014-07-14 14:19:00
6279	2014-07-14 14:20:00	2014-07-14 14:29:00
6280	2014-07-14 14:30:00	2014-07-14 14:39:00
6281	2014-07-14 14:40:00	2014-07-14 14:49:00
6282	2014-07-14 14:50:00	2014-07-14 14:59:00
6283	2014-07-14 15:00:00	2014-07-14 15:09:00
6284	2014-07-14 15:10:00	2014-07-14 15:19:00
6285	2014-07-14 15:20:00	2014-07-14 15:29:00
6286	2014-07-14 15:30:00	2014-07-14 15:39:00
6287	2014-07-14 15:40:00	2014-07-14 15:49:00
6288	2014-07-14 15:50:00	2014-07-14 15:59:00
6289	2014-07-14 16:00:00	2014-07-14 16:09:00
6290	2014-07-14 16:10:00	2014-07-14 16:19:00
6291	2014-07-14 16:20:00	2014-07-14 16:29:00
6292	2014-07-14 16:30:00	2014-07-14 16:39:00
6293	2014-07-14 16:40:00	2014-07-14 16:49:00
6294	2014-07-14 16:50:00	2014-07-14 16:59:00
6295	2014-07-14 17:00:00	2014-07-14 17:09:00
6296	2014-07-14 17:10:00	2014-07-14 17:19:00
6297	2014-07-14 17:20:00	2014-07-14 17:29:00
6298	2014-07-14 17:30:00	2014-07-14 17:39:00
6299	2014-07-14 17:40:00	2014-07-14 17:49:00
6300	2014-07-14 17:50:00	2014-07-14 17:59:00
6301	2014-07-14 18:00:00	2014-07-14 18:09:00
6302	2014-07-14 18:10:00	2014-07-14 18:19:00
6303	2014-07-14 18:20:00	2014-07-14 18:29:00
6304	2014-07-14 18:30:00	2014-07-14 18:39:00
6305	2014-07-14 18:40:00	2014-07-14 18:49:00
6306	2014-07-14 18:50:00	2014-07-14 18:59:00
6307	2014-07-14 19:00:00	2014-07-14 19:09:00
6308	2014-07-14 19:10:00	2014-07-14 19:19:00
6309	2014-07-14 19:20:00	2014-07-14 19:29:00
6310	2014-07-14 19:30:00	2014-07-14 19:39:00
6311	2014-07-14 19:40:00	2014-07-14 19:49:00
6312	2014-07-14 19:50:00	2014-07-14 19:59:00
6313	2014-07-14 20:00:00	2014-07-14 20:09:00
6314	2014-07-14 20:10:00	2014-07-14 20:19:00
6315	2014-07-14 20:20:00	2014-07-14 20:29:00
6316	2014-07-14 20:30:00	2014-07-14 20:39:00
6317	2014-07-14 20:40:00	2014-07-14 20:49:00
6318	2014-07-14 20:50:00	2014-07-14 20:59:00
6319	2014-07-14 21:00:00	2014-07-14 21:09:00
6320	2014-07-14 21:10:00	2014-07-14 21:19:00
6321	2014-07-14 21:20:00	2014-07-14 21:29:00
6322	2014-07-14 21:30:00	2014-07-14 21:39:00
6323	2014-07-14 21:40:00	2014-07-14 21:49:00
6324	2014-07-14 21:50:00	2014-07-14 21:59:00
6325	2014-07-14 22:00:00	2014-07-14 22:09:00
6326	2014-07-14 22:10:00	2014-07-14 22:19:00
6327	2014-07-14 22:20:00	2014-07-14 22:29:00
6328	2014-07-14 22:30:00	2014-07-14 22:39:00
6329	2014-07-14 22:40:00	2014-07-14 22:49:00
6330	2014-07-14 22:50:00	2014-07-14 22:59:00
6331	2014-07-14 23:00:00	2014-07-14 23:09:00
6332	2014-07-14 23:10:00	2014-07-14 23:19:00
6333	2014-07-14 23:20:00	2014-07-14 23:29:00
6334	2014-07-14 23:30:00	2014-07-14 23:39:00
6335	2014-07-14 23:40:00	2014-07-14 23:49:00
6336	2014-07-14 23:50:00	2014-07-14 23:59:00
6337	2014-07-15 00:00:00	2014-07-15 00:09:00
6338	2014-07-15 00:10:00	2014-07-15 00:19:00
6339	2014-07-15 00:20:00	2014-07-15 00:29:00
6340	2014-07-15 00:30:00	2014-07-15 00:39:00
6341	2014-07-15 00:40:00	2014-07-15 00:49:00
6342	2014-07-15 00:50:00	2014-07-15 00:59:00
6343	2014-07-15 01:00:00	2014-07-15 01:09:00
6344	2014-07-15 01:10:00	2014-07-15 01:19:00
6345	2014-07-15 01:20:00	2014-07-15 01:29:00
6346	2014-07-15 01:30:00	2014-07-15 01:39:00
6347	2014-07-15 01:40:00	2014-07-15 01:49:00
6348	2014-07-15 01:50:00	2014-07-15 01:59:00
6349	2014-07-15 02:00:00	2014-07-15 02:09:00
6350	2014-07-15 02:10:00	2014-07-15 02:19:00
6351	2014-07-15 02:20:00	2014-07-15 02:29:00
6352	2014-07-15 02:30:00	2014-07-15 02:39:00
6353	2014-07-15 02:40:00	2014-07-15 02:49:00
6354	2014-07-15 02:50:00	2014-07-15 02:59:00
6355	2014-07-15 03:00:00	2014-07-15 03:09:00
6356	2014-07-15 03:10:00	2014-07-15 03:19:00
6357	2014-07-15 03:20:00	2014-07-15 03:29:00
6358	2014-07-15 03:30:00	2014-07-15 03:39:00
6359	2014-07-15 03:40:00	2014-07-15 03:49:00
6360	2014-07-15 03:50:00	2014-07-15 03:59:00
6361	2014-07-15 04:00:00	2014-07-15 04:09:00
6362	2014-07-15 04:10:00	2014-07-15 04:19:00
6363	2014-07-15 04:20:00	2014-07-15 04:29:00
6364	2014-07-15 04:30:00	2014-07-15 04:39:00
6365	2014-07-15 04:40:00	2014-07-15 04:49:00
6366	2014-07-15 04:50:00	2014-07-15 04:59:00
6367	2014-07-15 05:00:00	2014-07-15 05:09:00
6368	2014-07-15 05:10:00	2014-07-15 05:19:00
6369	2014-07-15 05:20:00	2014-07-15 05:29:00
6370	2014-07-15 05:30:00	2014-07-15 05:39:00
6371	2014-07-15 05:40:00	2014-07-15 05:49:00
6372	2014-07-15 05:50:00	2014-07-15 05:59:00
6373	2014-07-15 06:00:00	2014-07-15 06:09:00
6374	2014-07-15 06:10:00	2014-07-15 06:19:00
6375	2014-07-15 06:20:00	2014-07-15 06:29:00
6376	2014-07-15 06:30:00	2014-07-15 06:39:00
6377	2014-07-15 06:40:00	2014-07-15 06:49:00
6378	2014-07-15 06:50:00	2014-07-15 06:59:00
6379	2014-07-15 07:00:00	2014-07-15 07:09:00
6380	2014-07-15 07:10:00	2014-07-15 07:19:00
6381	2014-07-15 07:20:00	2014-07-15 07:29:00
6382	2014-07-15 07:30:00	2014-07-15 07:39:00
6383	2014-07-15 07:40:00	2014-07-15 07:49:00
6384	2014-07-15 07:50:00	2014-07-15 07:59:00
6385	2014-07-15 08:00:00	2014-07-15 08:09:00
6386	2014-07-15 08:10:00	2014-07-15 08:19:00
6387	2014-07-15 08:20:00	2014-07-15 08:29:00
6388	2014-07-15 08:30:00	2014-07-15 08:39:00
6389	2014-07-15 08:40:00	2014-07-15 08:49:00
6390	2014-07-15 08:50:00	2014-07-15 08:59:00
6391	2014-07-15 09:00:00	2014-07-15 09:09:00
6392	2014-07-15 09:10:00	2014-07-15 09:19:00
6393	2014-07-15 09:20:00	2014-07-15 09:29:00
6394	2014-07-15 09:30:00	2014-07-15 09:39:00
6395	2014-07-15 09:40:00	2014-07-15 09:49:00
6396	2014-07-15 09:50:00	2014-07-15 09:59:00
6397	2014-07-15 10:00:00	2014-07-15 10:09:00
6398	2014-07-15 10:10:00	2014-07-15 10:19:00
6399	2014-07-15 10:20:00	2014-07-15 10:29:00
6400	2014-07-15 10:30:00	2014-07-15 10:39:00
6401	2014-07-15 10:40:00	2014-07-15 10:49:00
6402	2014-07-15 10:50:00	2014-07-15 10:59:00
6403	2014-07-15 11:00:00	2014-07-15 11:09:00
6404	2014-07-15 11:10:00	2014-07-15 11:19:00
6405	2014-07-15 11:20:00	2014-07-15 11:29:00
6406	2014-07-15 11:30:00	2014-07-15 11:39:00
6407	2014-07-15 11:40:00	2014-07-15 11:49:00
6408	2014-07-15 11:50:00	2014-07-15 11:59:00
6409	2014-07-15 12:00:00	2014-07-15 12:09:00
6410	2014-07-15 12:10:00	2014-07-15 12:19:00
6411	2014-07-15 12:20:00	2014-07-15 12:29:00
6412	2014-07-15 12:30:00	2014-07-15 12:39:00
6413	2014-07-15 12:40:00	2014-07-15 12:49:00
6414	2014-07-15 12:50:00	2014-07-15 12:59:00
6415	2014-07-15 13:00:00	2014-07-15 13:09:00
6416	2014-07-15 13:10:00	2014-07-15 13:19:00
6417	2014-07-15 13:20:00	2014-07-15 13:29:00
6418	2014-07-15 13:30:00	2014-07-15 13:39:00
6419	2014-07-15 13:40:00	2014-07-15 13:49:00
6420	2014-07-15 13:50:00	2014-07-15 13:59:00
6421	2014-07-15 14:00:00	2014-07-15 14:09:00
6422	2014-07-15 14:10:00	2014-07-15 14:19:00
6423	2014-07-15 14:20:00	2014-07-15 14:29:00
6424	2014-07-15 14:30:00	2014-07-15 14:39:00
6425	2014-07-15 14:40:00	2014-07-15 14:49:00
6426	2014-07-15 14:50:00	2014-07-15 14:59:00
6427	2014-07-15 15:00:00	2014-07-15 15:09:00
6428	2014-07-15 15:10:00	2014-07-15 15:19:00
6429	2014-07-15 15:20:00	2014-07-15 15:29:00
6430	2014-07-15 15:30:00	2014-07-15 15:39:00
6431	2014-07-15 15:40:00	2014-07-15 15:49:00
6432	2014-07-15 15:50:00	2014-07-15 15:59:00
6433	2014-07-15 16:00:00	2014-07-15 16:09:00
6434	2014-07-15 16:10:00	2014-07-15 16:19:00
6435	2014-07-15 16:20:00	2014-07-15 16:29:00
6436	2014-07-15 16:30:00	2014-07-15 16:39:00
6437	2014-07-15 16:40:00	2014-07-15 16:49:00
6438	2014-07-15 16:50:00	2014-07-15 16:59:00
6439	2014-07-15 17:00:00	2014-07-15 17:09:00
6440	2014-07-15 17:10:00	2014-07-15 17:19:00
6441	2014-07-15 17:20:00	2014-07-15 17:29:00
6442	2014-07-15 17:30:00	2014-07-15 17:39:00
6443	2014-07-15 17:40:00	2014-07-15 17:49:00
6444	2014-07-15 17:50:00	2014-07-15 17:59:00
6445	2014-07-15 18:00:00	2014-07-15 18:09:00
6446	2014-07-15 18:10:00	2014-07-15 18:19:00
6447	2014-07-15 18:20:00	2014-07-15 18:29:00
6448	2014-07-15 18:30:00	2014-07-15 18:39:00
6449	2014-07-15 18:40:00	2014-07-15 18:49:00
6450	2014-07-15 18:50:00	2014-07-15 18:59:00
6451	2014-07-15 19:00:00	2014-07-15 19:09:00
6452	2014-07-15 19:10:00	2014-07-15 19:19:00
6453	2014-07-15 19:20:00	2014-07-15 19:29:00
6454	2014-07-15 19:30:00	2014-07-15 19:39:00
6455	2014-07-15 19:40:00	2014-07-15 19:49:00
6456	2014-07-15 19:50:00	2014-07-15 19:59:00
6457	2014-07-15 20:00:00	2014-07-15 20:09:00
6458	2014-07-15 20:10:00	2014-07-15 20:19:00
6459	2014-07-15 20:20:00	2014-07-15 20:29:00
6460	2014-07-15 20:30:00	2014-07-15 20:39:00
6461	2014-07-15 20:40:00	2014-07-15 20:49:00
6462	2014-07-15 20:50:00	2014-07-15 20:59:00
6463	2014-07-15 21:00:00	2014-07-15 21:09:00
6464	2014-07-15 21:10:00	2014-07-15 21:19:00
6465	2014-07-15 21:20:00	2014-07-15 21:29:00
6466	2014-07-15 21:30:00	2014-07-15 21:39:00
6467	2014-07-15 21:40:00	2014-07-15 21:49:00
6468	2014-07-15 21:50:00	2014-07-15 21:59:00
6469	2014-07-15 22:00:00	2014-07-15 22:09:00
6470	2014-07-15 22:10:00	2014-07-15 22:19:00
6471	2014-07-15 22:20:00	2014-07-15 22:29:00
6472	2014-07-15 22:30:00	2014-07-15 22:39:00
6473	2014-07-15 22:40:00	2014-07-15 22:49:00
6474	2014-07-15 22:50:00	2014-07-15 22:59:00
6475	2014-07-15 23:00:00	2014-07-15 23:09:00
6476	2014-07-15 23:10:00	2014-07-15 23:19:00
6477	2014-07-15 23:20:00	2014-07-15 23:29:00
6478	2014-07-15 23:30:00	2014-07-15 23:39:00
6479	2014-07-15 23:40:00	2014-07-15 23:49:00
6480	2014-07-15 23:50:00	2014-07-15 23:59:00
6481	2014-07-16 00:00:00	2014-07-16 00:09:00
6482	2014-07-16 00:10:00	2014-07-16 00:19:00
6483	2014-07-16 00:20:00	2014-07-16 00:29:00
6484	2014-07-16 00:30:00	2014-07-16 00:39:00
6485	2014-07-16 00:40:00	2014-07-16 00:49:00
6486	2014-07-16 00:50:00	2014-07-16 00:59:00
6487	2014-07-16 01:00:00	2014-07-16 01:09:00
6488	2014-07-16 01:10:00	2014-07-16 01:19:00
6489	2014-07-16 01:20:00	2014-07-16 01:29:00
6490	2014-07-16 01:30:00	2014-07-16 01:39:00
6491	2014-07-16 01:40:00	2014-07-16 01:49:00
6492	2014-07-16 01:50:00	2014-07-16 01:59:00
6493	2014-07-16 02:00:00	2014-07-16 02:09:00
6494	2014-07-16 02:10:00	2014-07-16 02:19:00
6495	2014-07-16 02:20:00	2014-07-16 02:29:00
6496	2014-07-16 02:30:00	2014-07-16 02:39:00
6497	2014-07-16 02:40:00	2014-07-16 02:49:00
6498	2014-07-16 02:50:00	2014-07-16 02:59:00
6499	2014-07-16 03:00:00	2014-07-16 03:09:00
6500	2014-07-16 03:10:00	2014-07-16 03:19:00
6501	2014-07-16 03:20:00	2014-07-16 03:29:00
6502	2014-07-16 03:30:00	2014-07-16 03:39:00
6503	2014-07-16 03:40:00	2014-07-16 03:49:00
6504	2014-07-16 03:50:00	2014-07-16 03:59:00
6505	2014-07-16 04:00:00	2014-07-16 04:09:00
6506	2014-07-16 04:10:00	2014-07-16 04:19:00
6507	2014-07-16 04:20:00	2014-07-16 04:29:00
6508	2014-07-16 04:30:00	2014-07-16 04:39:00
6509	2014-07-16 04:40:00	2014-07-16 04:49:00
6510	2014-07-16 04:50:00	2014-07-16 04:59:00
6511	2014-07-16 05:00:00	2014-07-16 05:09:00
6512	2014-07-16 05:10:00	2014-07-16 05:19:00
6513	2014-07-16 05:20:00	2014-07-16 05:29:00
6514	2014-07-16 05:30:00	2014-07-16 05:39:00
6515	2014-07-16 05:40:00	2014-07-16 05:49:00
6516	2014-07-16 05:50:00	2014-07-16 05:59:00
6517	2014-07-16 06:00:00	2014-07-16 06:09:00
6518	2014-07-16 06:10:00	2014-07-16 06:19:00
6519	2014-07-16 06:20:00	2014-07-16 06:29:00
6520	2014-07-16 06:30:00	2014-07-16 06:39:00
6521	2014-07-16 06:40:00	2014-07-16 06:49:00
6522	2014-07-16 06:50:00	2014-07-16 06:59:00
6523	2014-07-16 07:00:00	2014-07-16 07:09:00
6524	2014-07-16 07:10:00	2014-07-16 07:19:00
6525	2014-07-16 07:20:00	2014-07-16 07:29:00
6526	2014-07-16 07:30:00	2014-07-16 07:39:00
6527	2014-07-16 07:40:00	2014-07-16 07:49:00
6528	2014-07-16 07:50:00	2014-07-16 07:59:00
6529	2014-07-16 08:00:00	2014-07-16 08:09:00
6530	2014-07-16 08:10:00	2014-07-16 08:19:00
6531	2014-07-16 08:20:00	2014-07-16 08:29:00
6532	2014-07-16 08:30:00	2014-07-16 08:39:00
6533	2014-07-16 08:40:00	2014-07-16 08:49:00
6534	2014-07-16 08:50:00	2014-07-16 08:59:00
6535	2014-07-16 09:00:00	2014-07-16 09:09:00
6536	2014-07-16 09:10:00	2014-07-16 09:19:00
6537	2014-07-16 09:20:00	2014-07-16 09:29:00
6538	2014-07-16 09:30:00	2014-07-16 09:39:00
6539	2014-07-16 09:40:00	2014-07-16 09:49:00
6540	2014-07-16 09:50:00	2014-07-16 09:59:00
6541	2014-07-16 10:00:00	2014-07-16 10:09:00
6542	2014-07-16 10:10:00	2014-07-16 10:19:00
6543	2014-07-16 10:20:00	2014-07-16 10:29:00
6544	2014-07-16 10:30:00	2014-07-16 10:39:00
6545	2014-07-16 10:40:00	2014-07-16 10:49:00
6546	2014-07-16 10:50:00	2014-07-16 10:59:00
6547	2014-07-16 11:00:00	2014-07-16 11:09:00
6548	2014-07-16 11:10:00	2014-07-16 11:19:00
6549	2014-07-16 11:20:00	2014-07-16 11:29:00
6550	2014-07-16 11:30:00	2014-07-16 11:39:00
6551	2014-07-16 11:40:00	2014-07-16 11:49:00
6552	2014-07-16 11:50:00	2014-07-16 11:59:00
6553	2014-07-16 12:00:00	2014-07-16 12:09:00
6554	2014-07-16 12:10:00	2014-07-16 12:19:00
6555	2014-07-16 12:20:00	2014-07-16 12:29:00
6556	2014-07-16 12:30:00	2014-07-16 12:39:00
6557	2014-07-16 12:40:00	2014-07-16 12:49:00
6558	2014-07-16 12:50:00	2014-07-16 12:59:00
6559	2014-07-16 13:00:00	2014-07-16 13:09:00
6560	2014-07-16 13:10:00	2014-07-16 13:19:00
6561	2014-07-16 13:20:00	2014-07-16 13:29:00
6562	2014-07-16 13:30:00	2014-07-16 13:39:00
6563	2014-07-16 13:40:00	2014-07-16 13:49:00
6564	2014-07-16 13:50:00	2014-07-16 13:59:00
6565	2014-07-16 14:00:00	2014-07-16 14:09:00
6566	2014-07-16 14:10:00	2014-07-16 14:19:00
6567	2014-07-16 14:20:00	2014-07-16 14:29:00
6568	2014-07-16 14:30:00	2014-07-16 14:39:00
6569	2014-07-16 14:40:00	2014-07-16 14:49:00
6570	2014-07-16 14:50:00	2014-07-16 14:59:00
6571	2014-07-16 15:00:00	2014-07-16 15:09:00
6572	2014-07-16 15:10:00	2014-07-16 15:19:00
6573	2014-07-16 15:20:00	2014-07-16 15:29:00
6574	2014-07-16 15:30:00	2014-07-16 15:39:00
6575	2014-07-16 15:40:00	2014-07-16 15:49:00
6576	2014-07-16 15:50:00	2014-07-16 15:59:00
6577	2014-07-16 16:00:00	2014-07-16 16:09:00
6578	2014-07-16 16:10:00	2014-07-16 16:19:00
6579	2014-07-16 16:20:00	2014-07-16 16:29:00
6580	2014-07-16 16:30:00	2014-07-16 16:39:00
6581	2014-07-16 16:40:00	2014-07-16 16:49:00
6582	2014-07-16 16:50:00	2014-07-16 16:59:00
6583	2014-07-16 17:00:00	2014-07-16 17:09:00
6584	2014-07-16 17:10:00	2014-07-16 17:19:00
6585	2014-07-16 17:20:00	2014-07-16 17:29:00
6586	2014-07-16 17:30:00	2014-07-16 17:39:00
6587	2014-07-16 17:40:00	2014-07-16 17:49:00
6588	2014-07-16 17:50:00	2014-07-16 17:59:00
6589	2014-07-16 18:00:00	2014-07-16 18:09:00
6590	2014-07-16 18:10:00	2014-07-16 18:19:00
6591	2014-07-16 18:20:00	2014-07-16 18:29:00
6592	2014-07-16 18:30:00	2014-07-16 18:39:00
6593	2014-07-16 18:40:00	2014-07-16 18:49:00
6594	2014-07-16 18:50:00	2014-07-16 18:59:00
6595	2014-07-16 19:00:00	2014-07-16 19:09:00
6596	2014-07-16 19:10:00	2014-07-16 19:19:00
6597	2014-07-16 19:20:00	2014-07-16 19:29:00
6598	2014-07-16 19:30:00	2014-07-16 19:39:00
6599	2014-07-16 19:40:00	2014-07-16 19:49:00
6600	2014-07-16 19:50:00	2014-07-16 19:59:00
6601	2014-07-16 20:00:00	2014-07-16 20:09:00
6602	2014-07-16 20:10:00	2014-07-16 20:19:00
6603	2014-07-16 20:20:00	2014-07-16 20:29:00
6604	2014-07-16 20:30:00	2014-07-16 20:39:00
6605	2014-07-16 20:40:00	2014-07-16 20:49:00
6606	2014-07-16 20:50:00	2014-07-16 20:59:00
6607	2014-07-16 21:00:00	2014-07-16 21:09:00
6608	2014-07-16 21:10:00	2014-07-16 21:19:00
6609	2014-07-16 21:20:00	2014-07-16 21:29:00
6610	2014-07-16 21:30:00	2014-07-16 21:39:00
6611	2014-07-16 21:40:00	2014-07-16 21:49:00
6612	2014-07-16 21:50:00	2014-07-16 21:59:00
6613	2014-07-16 22:00:00	2014-07-16 22:09:00
6614	2014-07-16 22:10:00	2014-07-16 22:19:00
6615	2014-07-16 22:20:00	2014-07-16 22:29:00
6616	2014-07-16 22:30:00	2014-07-16 22:39:00
6617	2014-07-16 22:40:00	2014-07-16 22:49:00
6618	2014-07-16 22:50:00	2014-07-16 22:59:00
6619	2014-07-16 23:00:00	2014-07-16 23:09:00
6620	2014-07-16 23:10:00	2014-07-16 23:19:00
6621	2014-07-16 23:20:00	2014-07-16 23:29:00
6622	2014-07-16 23:30:00	2014-07-16 23:39:00
6623	2014-07-16 23:40:00	2014-07-16 23:49:00
6624	2014-07-16 23:50:00	2014-07-16 23:59:00
6625	2014-07-17 00:00:00	2014-07-17 00:09:00
6626	2014-07-17 00:10:00	2014-07-17 00:19:00
6627	2014-07-17 00:20:00	2014-07-17 00:29:00
6628	2014-07-17 00:30:00	2014-07-17 00:39:00
6629	2014-07-17 00:40:00	2014-07-17 00:49:00
6630	2014-07-17 00:50:00	2014-07-17 00:59:00
6631	2014-07-17 01:00:00	2014-07-17 01:09:00
6632	2014-07-17 01:10:00	2014-07-17 01:19:00
6633	2014-07-17 01:20:00	2014-07-17 01:29:00
6634	2014-07-17 01:30:00	2014-07-17 01:39:00
6635	2014-07-17 01:40:00	2014-07-17 01:49:00
6636	2014-07-17 01:50:00	2014-07-17 01:59:00
6637	2014-07-17 02:00:00	2014-07-17 02:09:00
6638	2014-07-17 02:10:00	2014-07-17 02:19:00
6639	2014-07-17 02:20:00	2014-07-17 02:29:00
6640	2014-07-17 02:30:00	2014-07-17 02:39:00
6641	2014-07-17 02:40:00	2014-07-17 02:49:00
6642	2014-07-17 02:50:00	2014-07-17 02:59:00
6643	2014-07-17 03:00:00	2014-07-17 03:09:00
6644	2014-07-17 03:10:00	2014-07-17 03:19:00
6645	2014-07-17 03:20:00	2014-07-17 03:29:00
6646	2014-07-17 03:30:00	2014-07-17 03:39:00
6647	2014-07-17 03:40:00	2014-07-17 03:49:00
6648	2014-07-17 03:50:00	2014-07-17 03:59:00
6649	2014-07-17 04:00:00	2014-07-17 04:09:00
6650	2014-07-17 04:10:00	2014-07-17 04:19:00
6651	2014-07-17 04:20:00	2014-07-17 04:29:00
6652	2014-07-17 04:30:00	2014-07-17 04:39:00
6653	2014-07-17 04:40:00	2014-07-17 04:49:00
6654	2014-07-17 04:50:00	2014-07-17 04:59:00
6655	2014-07-17 05:00:00	2014-07-17 05:09:00
6656	2014-07-17 05:10:00	2014-07-17 05:19:00
6657	2014-07-17 05:20:00	2014-07-17 05:29:00
6658	2014-07-17 05:30:00	2014-07-17 05:39:00
6659	2014-07-17 05:40:00	2014-07-17 05:49:00
6660	2014-07-17 05:50:00	2014-07-17 05:59:00
6661	2014-07-17 06:00:00	2014-07-17 06:09:00
6662	2014-07-17 06:10:00	2014-07-17 06:19:00
6663	2014-07-17 06:20:00	2014-07-17 06:29:00
6664	2014-07-17 06:30:00	2014-07-17 06:39:00
6665	2014-07-17 06:40:00	2014-07-17 06:49:00
6666	2014-07-17 06:50:00	2014-07-17 06:59:00
6667	2014-07-17 07:00:00	2014-07-17 07:09:00
6668	2014-07-17 07:10:00	2014-07-17 07:19:00
6669	2014-07-17 07:20:00	2014-07-17 07:29:00
6670	2014-07-17 07:30:00	2014-07-17 07:39:00
6671	2014-07-17 07:40:00	2014-07-17 07:49:00
6672	2014-07-17 07:50:00	2014-07-17 07:59:00
6673	2014-07-17 08:00:00	2014-07-17 08:09:00
6674	2014-07-17 08:10:00	2014-07-17 08:19:00
6675	2014-07-17 08:20:00	2014-07-17 08:29:00
6676	2014-07-17 08:30:00	2014-07-17 08:39:00
6677	2014-07-17 08:40:00	2014-07-17 08:49:00
6678	2014-07-17 08:50:00	2014-07-17 08:59:00
6679	2014-07-17 09:00:00	2014-07-17 09:09:00
6680	2014-07-17 09:10:00	2014-07-17 09:19:00
6681	2014-07-17 09:20:00	2014-07-17 09:29:00
6682	2014-07-17 09:30:00	2014-07-17 09:39:00
6683	2014-07-17 09:40:00	2014-07-17 09:49:00
6684	2014-07-17 09:50:00	2014-07-17 09:59:00
6685	2014-07-17 10:00:00	2014-07-17 10:09:00
6686	2014-07-17 10:10:00	2014-07-17 10:19:00
6687	2014-07-17 10:20:00	2014-07-17 10:29:00
6688	2014-07-17 10:30:00	2014-07-17 10:39:00
6689	2014-07-17 10:40:00	2014-07-17 10:49:00
6690	2014-07-17 10:50:00	2014-07-17 10:59:00
6691	2014-07-17 11:00:00	2014-07-17 11:09:00
6692	2014-07-17 11:10:00	2014-07-17 11:19:00
6693	2014-07-17 11:20:00	2014-07-17 11:29:00
6694	2014-07-17 11:30:00	2014-07-17 11:39:00
6695	2014-07-17 11:40:00	2014-07-17 11:49:00
6696	2014-07-17 11:50:00	2014-07-17 11:59:00
6697	2014-07-17 12:00:00	2014-07-17 12:09:00
6698	2014-07-17 12:10:00	2014-07-17 12:19:00
6699	2014-07-17 12:20:00	2014-07-17 12:29:00
6700	2014-07-17 12:30:00	2014-07-17 12:39:00
6701	2014-07-17 12:40:00	2014-07-17 12:49:00
6702	2014-07-17 12:50:00	2014-07-17 12:59:00
6703	2014-07-17 13:00:00	2014-07-17 13:09:00
6704	2014-07-17 13:10:00	2014-07-17 13:19:00
6705	2014-07-17 13:20:00	2014-07-17 13:29:00
6706	2014-07-17 13:30:00	2014-07-17 13:39:00
6707	2014-07-17 13:40:00	2014-07-17 13:49:00
6708	2014-07-17 13:50:00	2014-07-17 13:59:00
6709	2014-07-17 14:00:00	2014-07-17 14:09:00
6710	2014-07-17 14:10:00	2014-07-17 14:19:00
6711	2014-07-17 14:20:00	2014-07-17 14:29:00
6712	2014-07-17 14:30:00	2014-07-17 14:39:00
6713	2014-07-17 14:40:00	2014-07-17 14:49:00
6714	2014-07-17 14:50:00	2014-07-17 14:59:00
6715	2014-07-17 15:00:00	2014-07-17 15:09:00
6716	2014-07-17 15:10:00	2014-07-17 15:19:00
6717	2014-07-17 15:20:00	2014-07-17 15:29:00
6718	2014-07-17 15:30:00	2014-07-17 15:39:00
6719	2014-07-17 15:40:00	2014-07-17 15:49:00
6720	2014-07-17 15:50:00	2014-07-17 15:59:00
6721	2014-07-17 16:00:00	2014-07-17 16:09:00
6722	2014-07-17 16:10:00	2014-07-17 16:19:00
6723	2014-07-17 16:20:00	2014-07-17 16:29:00
6724	2014-07-17 16:30:00	2014-07-17 16:39:00
6725	2014-07-17 16:40:00	2014-07-17 16:49:00
6726	2014-07-17 16:50:00	2014-07-17 16:59:00
6727	2014-07-17 17:00:00	2014-07-17 17:09:00
6728	2014-07-17 17:10:00	2014-07-17 17:19:00
6729	2014-07-17 17:20:00	2014-07-17 17:29:00
6730	2014-07-17 17:30:00	2014-07-17 17:39:00
6731	2014-07-17 17:40:00	2014-07-17 17:49:00
6732	2014-07-17 17:50:00	2014-07-17 17:59:00
6733	2014-07-17 18:00:00	2014-07-17 18:09:00
6734	2014-07-17 18:10:00	2014-07-17 18:19:00
6735	2014-07-17 18:20:00	2014-07-17 18:29:00
6736	2014-07-17 18:30:00	2014-07-17 18:39:00
6737	2014-07-17 18:40:00	2014-07-17 18:49:00
6738	2014-07-17 18:50:00	2014-07-17 18:59:00
6739	2014-07-17 19:00:00	2014-07-17 19:09:00
6740	2014-07-17 19:10:00	2014-07-17 19:19:00
6741	2014-07-17 19:20:00	2014-07-17 19:29:00
6742	2014-07-17 19:30:00	2014-07-17 19:39:00
6743	2014-07-17 19:40:00	2014-07-17 19:49:00
6744	2014-07-17 19:50:00	2014-07-17 19:59:00
6745	2014-07-17 20:00:00	2014-07-17 20:09:00
6746	2014-07-17 20:10:00	2014-07-17 20:19:00
6747	2014-07-17 20:20:00	2014-07-17 20:29:00
6748	2014-07-17 20:30:00	2014-07-17 20:39:00
6749	2014-07-17 20:40:00	2014-07-17 20:49:00
6750	2014-07-17 20:50:00	2014-07-17 20:59:00
6751	2014-07-17 21:00:00	2014-07-17 21:09:00
6752	2014-07-17 21:10:00	2014-07-17 21:19:00
6753	2014-07-17 21:20:00	2014-07-17 21:29:00
6754	2014-07-17 21:30:00	2014-07-17 21:39:00
6755	2014-07-17 21:40:00	2014-07-17 21:49:00
6756	2014-07-17 21:50:00	2014-07-17 21:59:00
6757	2014-07-17 22:00:00	2014-07-17 22:09:00
6758	2014-07-17 22:10:00	2014-07-17 22:19:00
6759	2014-07-17 22:20:00	2014-07-17 22:29:00
6760	2014-07-17 22:30:00	2014-07-17 22:39:00
6761	2014-07-17 22:40:00	2014-07-17 22:49:00
6762	2014-07-17 22:50:00	2014-07-17 22:59:00
6763	2014-07-17 23:00:00	2014-07-17 23:09:00
6764	2014-07-17 23:10:00	2014-07-17 23:19:00
6765	2014-07-17 23:20:00	2014-07-17 23:29:00
6766	2014-07-17 23:30:00	2014-07-17 23:39:00
6767	2014-07-17 23:40:00	2014-07-17 23:49:00
6768	2014-07-17 23:50:00	2014-07-17 23:59:00
6769	2014-07-18 00:00:00	2014-07-18 00:09:00
6770	2014-07-18 00:10:00	2014-07-18 00:19:00
6771	2014-07-18 00:20:00	2014-07-18 00:29:00
6772	2014-07-18 00:30:00	2014-07-18 00:39:00
6773	2014-07-18 00:40:00	2014-07-18 00:49:00
6774	2014-07-18 00:50:00	2014-07-18 00:59:00
6775	2014-07-18 01:00:00	2014-07-18 01:09:00
6776	2014-07-18 01:10:00	2014-07-18 01:19:00
6777	2014-07-18 01:20:00	2014-07-18 01:29:00
6778	2014-07-18 01:30:00	2014-07-18 01:39:00
6779	2014-07-18 01:40:00	2014-07-18 01:49:00
6780	2014-07-18 01:50:00	2014-07-18 01:59:00
6781	2014-07-18 02:00:00	2014-07-18 02:09:00
6782	2014-07-18 02:10:00	2014-07-18 02:19:00
6783	2014-07-18 02:20:00	2014-07-18 02:29:00
6784	2014-07-18 02:30:00	2014-07-18 02:39:00
6785	2014-07-18 02:40:00	2014-07-18 02:49:00
6786	2014-07-18 02:50:00	2014-07-18 02:59:00
6787	2014-07-18 03:00:00	2014-07-18 03:09:00
6788	2014-07-18 03:10:00	2014-07-18 03:19:00
6789	2014-07-18 03:20:00	2014-07-18 03:29:00
6790	2014-07-18 03:30:00	2014-07-18 03:39:00
6791	2014-07-18 03:40:00	2014-07-18 03:49:00
6792	2014-07-18 03:50:00	2014-07-18 03:59:00
6793	2014-07-18 04:00:00	2014-07-18 04:09:00
6794	2014-07-18 04:10:00	2014-07-18 04:19:00
6795	2014-07-18 04:20:00	2014-07-18 04:29:00
6796	2014-07-18 04:30:00	2014-07-18 04:39:00
6797	2014-07-18 04:40:00	2014-07-18 04:49:00
6798	2014-07-18 04:50:00	2014-07-18 04:59:00
6799	2014-07-18 05:00:00	2014-07-18 05:09:00
6800	2014-07-18 05:10:00	2014-07-18 05:19:00
6801	2014-07-18 05:20:00	2014-07-18 05:29:00
6802	2014-07-18 05:30:00	2014-07-18 05:39:00
6803	2014-07-18 05:40:00	2014-07-18 05:49:00
6804	2014-07-18 05:50:00	2014-07-18 05:59:00
6805	2014-07-18 06:00:00	2014-07-18 06:09:00
6806	2014-07-18 06:10:00	2014-07-18 06:19:00
6807	2014-07-18 06:20:00	2014-07-18 06:29:00
6808	2014-07-18 06:30:00	2014-07-18 06:39:00
6809	2014-07-18 06:40:00	2014-07-18 06:49:00
6810	2014-07-18 06:50:00	2014-07-18 06:59:00
6811	2014-07-18 07:00:00	2014-07-18 07:09:00
6812	2014-07-18 07:10:00	2014-07-18 07:19:00
6813	2014-07-18 07:20:00	2014-07-18 07:29:00
6814	2014-07-18 07:30:00	2014-07-18 07:39:00
6815	2014-07-18 07:40:00	2014-07-18 07:49:00
6816	2014-07-18 07:50:00	2014-07-18 07:59:00
6817	2014-07-18 08:00:00	2014-07-18 08:09:00
6818	2014-07-18 08:10:00	2014-07-18 08:19:00
6819	2014-07-18 08:20:00	2014-07-18 08:29:00
6820	2014-07-18 08:30:00	2014-07-18 08:39:00
6821	2014-07-18 08:40:00	2014-07-18 08:49:00
6822	2014-07-18 08:50:00	2014-07-18 08:59:00
6823	2014-07-18 09:00:00	2014-07-18 09:09:00
6824	2014-07-18 09:10:00	2014-07-18 09:19:00
6825	2014-07-18 09:20:00	2014-07-18 09:29:00
6826	2014-07-18 09:30:00	2014-07-18 09:39:00
6827	2014-07-18 09:40:00	2014-07-18 09:49:00
6828	2014-07-18 09:50:00	2014-07-18 09:59:00
6829	2014-07-18 10:00:00	2014-07-18 10:09:00
6830	2014-07-18 10:10:00	2014-07-18 10:19:00
6831	2014-07-18 10:20:00	2014-07-18 10:29:00
6832	2014-07-18 10:30:00	2014-07-18 10:39:00
6833	2014-07-18 10:40:00	2014-07-18 10:49:00
6834	2014-07-18 10:50:00	2014-07-18 10:59:00
6835	2014-07-18 11:00:00	2014-07-18 11:09:00
6836	2014-07-18 11:10:00	2014-07-18 11:19:00
6837	2014-07-18 11:20:00	2014-07-18 11:29:00
6838	2014-07-18 11:30:00	2014-07-18 11:39:00
6839	2014-07-18 11:40:00	2014-07-18 11:49:00
6840	2014-07-18 11:50:00	2014-07-18 11:59:00
6841	2014-07-18 12:00:00	2014-07-18 12:09:00
6842	2014-07-18 12:10:00	2014-07-18 12:19:00
6843	2014-07-18 12:20:00	2014-07-18 12:29:00
6844	2014-07-18 12:30:00	2014-07-18 12:39:00
6845	2014-07-18 12:40:00	2014-07-18 12:49:00
6846	2014-07-18 12:50:00	2014-07-18 12:59:00
6847	2014-07-18 13:00:00	2014-07-18 13:09:00
6848	2014-07-18 13:10:00	2014-07-18 13:19:00
6849	2014-07-18 13:20:00	2014-07-18 13:29:00
6850	2014-07-18 13:30:00	2014-07-18 13:39:00
6851	2014-07-18 13:40:00	2014-07-18 13:49:00
6852	2014-07-18 13:50:00	2014-07-18 13:59:00
6853	2014-07-18 14:00:00	2014-07-18 14:09:00
6854	2014-07-18 14:10:00	2014-07-18 14:19:00
6855	2014-07-18 14:20:00	2014-07-18 14:29:00
6856	2014-07-18 14:30:00	2014-07-18 14:39:00
6857	2014-07-18 14:40:00	2014-07-18 14:49:00
6858	2014-07-18 14:50:00	2014-07-18 14:59:00
6859	2014-07-18 15:00:00	2014-07-18 15:09:00
6860	2014-07-18 15:10:00	2014-07-18 15:19:00
6861	2014-07-18 15:20:00	2014-07-18 15:29:00
6862	2014-07-18 15:30:00	2014-07-18 15:39:00
6863	2014-07-18 15:40:00	2014-07-18 15:49:00
6864	2014-07-18 15:50:00	2014-07-18 15:59:00
6865	2014-07-18 16:00:00	2014-07-18 16:09:00
6866	2014-07-18 16:10:00	2014-07-18 16:19:00
6867	2014-07-18 16:20:00	2014-07-18 16:29:00
6868	2014-07-18 16:30:00	2014-07-18 16:39:00
6869	2014-07-18 16:40:00	2014-07-18 16:49:00
6870	2014-07-18 16:50:00	2014-07-18 16:59:00
6871	2014-07-18 17:00:00	2014-07-18 17:09:00
6872	2014-07-18 17:10:00	2014-07-18 17:19:00
6873	2014-07-18 17:20:00	2014-07-18 17:29:00
6874	2014-07-18 17:30:00	2014-07-18 17:39:00
6875	2014-07-18 17:40:00	2014-07-18 17:49:00
6876	2014-07-18 17:50:00	2014-07-18 17:59:00
6877	2014-07-18 18:00:00	2014-07-18 18:09:00
6878	2014-07-18 18:10:00	2014-07-18 18:19:00
6879	2014-07-18 18:20:00	2014-07-18 18:29:00
6880	2014-07-18 18:30:00	2014-07-18 18:39:00
6881	2014-07-18 18:40:00	2014-07-18 18:49:00
6882	2014-07-18 18:50:00	2014-07-18 18:59:00
6883	2014-07-18 19:00:00	2014-07-18 19:09:00
6884	2014-07-18 19:10:00	2014-07-18 19:19:00
6885	2014-07-18 19:20:00	2014-07-18 19:29:00
6886	2014-07-18 19:30:00	2014-07-18 19:39:00
6887	2014-07-18 19:40:00	2014-07-18 19:49:00
6888	2014-07-18 19:50:00	2014-07-18 19:59:00
6889	2014-07-18 20:00:00	2014-07-18 20:09:00
6890	2014-07-18 20:10:00	2014-07-18 20:19:00
6891	2014-07-18 20:20:00	2014-07-18 20:29:00
6892	2014-07-18 20:30:00	2014-07-18 20:39:00
6893	2014-07-18 20:40:00	2014-07-18 20:49:00
6894	2014-07-18 20:50:00	2014-07-18 20:59:00
6895	2014-07-18 21:00:00	2014-07-18 21:09:00
6896	2014-07-18 21:10:00	2014-07-18 21:19:00
6897	2014-07-18 21:20:00	2014-07-18 21:29:00
6898	2014-07-18 21:30:00	2014-07-18 21:39:00
6899	2014-07-18 21:40:00	2014-07-18 21:49:00
6900	2014-07-18 21:50:00	2014-07-18 21:59:00
6901	2014-07-18 22:00:00	2014-07-18 22:09:00
6902	2014-07-18 22:10:00	2014-07-18 22:19:00
6903	2014-07-18 22:20:00	2014-07-18 22:29:00
6904	2014-07-18 22:30:00	2014-07-18 22:39:00
6905	2014-07-18 22:40:00	2014-07-18 22:49:00
6906	2014-07-18 22:50:00	2014-07-18 22:59:00
6907	2014-07-18 23:00:00	2014-07-18 23:09:00
6908	2014-07-18 23:10:00	2014-07-18 23:19:00
6909	2014-07-18 23:20:00	2014-07-18 23:29:00
6910	2014-07-18 23:30:00	2014-07-18 23:39:00
6911	2014-07-18 23:40:00	2014-07-18 23:49:00
6912	2014-07-18 23:50:00	2014-07-18 23:59:00
6913	2014-07-19 00:00:00	2014-07-19 00:09:00
6914	2014-07-19 00:10:00	2014-07-19 00:19:00
6915	2014-07-19 00:20:00	2014-07-19 00:29:00
6916	2014-07-19 00:30:00	2014-07-19 00:39:00
6917	2014-07-19 00:40:00	2014-07-19 00:49:00
6918	2014-07-19 00:50:00	2014-07-19 00:59:00
6919	2014-07-19 01:00:00	2014-07-19 01:09:00
6920	2014-07-19 01:10:00	2014-07-19 01:19:00
6921	2014-07-19 01:20:00	2014-07-19 01:29:00
6922	2014-07-19 01:30:00	2014-07-19 01:39:00
6923	2014-07-19 01:40:00	2014-07-19 01:49:00
6924	2014-07-19 01:50:00	2014-07-19 01:59:00
6925	2014-07-19 02:00:00	2014-07-19 02:09:00
6926	2014-07-19 02:10:00	2014-07-19 02:19:00
6927	2014-07-19 02:20:00	2014-07-19 02:29:00
6928	2014-07-19 02:30:00	2014-07-19 02:39:00
6929	2014-07-19 02:40:00	2014-07-19 02:49:00
6930	2014-07-19 02:50:00	2014-07-19 02:59:00
6931	2014-07-19 03:00:00	2014-07-19 03:09:00
6932	2014-07-19 03:10:00	2014-07-19 03:19:00
6933	2014-07-19 03:20:00	2014-07-19 03:29:00
6934	2014-07-19 03:30:00	2014-07-19 03:39:00
6935	2014-07-19 03:40:00	2014-07-19 03:49:00
6936	2014-07-19 03:50:00	2014-07-19 03:59:00
6937	2014-07-19 04:00:00	2014-07-19 04:09:00
6938	2014-07-19 04:10:00	2014-07-19 04:19:00
6939	2014-07-19 04:20:00	2014-07-19 04:29:00
6940	2014-07-19 04:30:00	2014-07-19 04:39:00
6941	2014-07-19 04:40:00	2014-07-19 04:49:00
6942	2014-07-19 04:50:00	2014-07-19 04:59:00
6943	2014-07-19 05:00:00	2014-07-19 05:09:00
6944	2014-07-19 05:10:00	2014-07-19 05:19:00
6945	2014-07-19 05:20:00	2014-07-19 05:29:00
6946	2014-07-19 05:30:00	2014-07-19 05:39:00
6947	2014-07-19 05:40:00	2014-07-19 05:49:00
6948	2014-07-19 05:50:00	2014-07-19 05:59:00
6949	2014-07-19 06:00:00	2014-07-19 06:09:00
6950	2014-07-19 06:10:00	2014-07-19 06:19:00
6951	2014-07-19 06:20:00	2014-07-19 06:29:00
6952	2014-07-19 06:30:00	2014-07-19 06:39:00
6953	2014-07-19 06:40:00	2014-07-19 06:49:00
6954	2014-07-19 06:50:00	2014-07-19 06:59:00
6955	2014-07-19 07:00:00	2014-07-19 07:09:00
6956	2014-07-19 07:10:00	2014-07-19 07:19:00
6957	2014-07-19 07:20:00	2014-07-19 07:29:00
6958	2014-07-19 07:30:00	2014-07-19 07:39:00
6959	2014-07-19 07:40:00	2014-07-19 07:49:00
6960	2014-07-19 07:50:00	2014-07-19 07:59:00
6961	2014-07-19 08:00:00	2014-07-19 08:09:00
6962	2014-07-19 08:10:00	2014-07-19 08:19:00
6963	2014-07-19 08:20:00	2014-07-19 08:29:00
6964	2014-07-19 08:30:00	2014-07-19 08:39:00
6965	2014-07-19 08:40:00	2014-07-19 08:49:00
6966	2014-07-19 08:50:00	2014-07-19 08:59:00
6967	2014-07-19 09:00:00	2014-07-19 09:09:00
6968	2014-07-19 09:10:00	2014-07-19 09:19:00
6969	2014-07-19 09:20:00	2014-07-19 09:29:00
6970	2014-07-19 09:30:00	2014-07-19 09:39:00
6971	2014-07-19 09:40:00	2014-07-19 09:49:00
6972	2014-07-19 09:50:00	2014-07-19 09:59:00
6973	2014-07-19 10:00:00	2014-07-19 10:09:00
6974	2014-07-19 10:10:00	2014-07-19 10:19:00
6975	2014-07-19 10:20:00	2014-07-19 10:29:00
6976	2014-07-19 10:30:00	2014-07-19 10:39:00
6977	2014-07-19 10:40:00	2014-07-19 10:49:00
6978	2014-07-19 10:50:00	2014-07-19 10:59:00
6979	2014-07-19 11:00:00	2014-07-19 11:09:00
6980	2014-07-19 11:10:00	2014-07-19 11:19:00
6981	2014-07-19 11:20:00	2014-07-19 11:29:00
6982	2014-07-19 11:30:00	2014-07-19 11:39:00
6983	2014-07-19 11:40:00	2014-07-19 11:49:00
6984	2014-07-19 11:50:00	2014-07-19 11:59:00
6985	2014-07-19 12:00:00	2014-07-19 12:09:00
6986	2014-07-19 12:10:00	2014-07-19 12:19:00
6987	2014-07-19 12:20:00	2014-07-19 12:29:00
6988	2014-07-19 12:30:00	2014-07-19 12:39:00
6989	2014-07-19 12:40:00	2014-07-19 12:49:00
6990	2014-07-19 12:50:00	2014-07-19 12:59:00
6991	2014-07-19 13:00:00	2014-07-19 13:09:00
6992	2014-07-19 13:10:00	2014-07-19 13:19:00
6993	2014-07-19 13:20:00	2014-07-19 13:29:00
6994	2014-07-19 13:30:00	2014-07-19 13:39:00
6995	2014-07-19 13:40:00	2014-07-19 13:49:00
6996	2014-07-19 13:50:00	2014-07-19 13:59:00
6997	2014-07-19 14:00:00	2014-07-19 14:09:00
6998	2014-07-19 14:10:00	2014-07-19 14:19:00
6999	2014-07-19 14:20:00	2014-07-19 14:29:00
7000	2014-07-19 14:30:00	2014-07-19 14:39:00
7001	2014-07-19 14:40:00	2014-07-19 14:49:00
7002	2014-07-19 14:50:00	2014-07-19 14:59:00
7003	2014-07-19 15:00:00	2014-07-19 15:09:00
7004	2014-07-19 15:10:00	2014-07-19 15:19:00
7005	2014-07-19 15:20:00	2014-07-19 15:29:00
7006	2014-07-19 15:30:00	2014-07-19 15:39:00
7007	2014-07-19 15:40:00	2014-07-19 15:49:00
7008	2014-07-19 15:50:00	2014-07-19 15:59:00
7009	2014-07-19 16:00:00	2014-07-19 16:09:00
7010	2014-07-19 16:10:00	2014-07-19 16:19:00
7011	2014-07-19 16:20:00	2014-07-19 16:29:00
7012	2014-07-19 16:30:00	2014-07-19 16:39:00
7013	2014-07-19 16:40:00	2014-07-19 16:49:00
7014	2014-07-19 16:50:00	2014-07-19 16:59:00
7015	2014-07-19 17:00:00	2014-07-19 17:09:00
7016	2014-07-19 17:10:00	2014-07-19 17:19:00
7017	2014-07-19 17:20:00	2014-07-19 17:29:00
7018	2014-07-19 17:30:00	2014-07-19 17:39:00
7019	2014-07-19 17:40:00	2014-07-19 17:49:00
7020	2014-07-19 17:50:00	2014-07-19 17:59:00
7021	2014-07-19 18:00:00	2014-07-19 18:09:00
7022	2014-07-19 18:10:00	2014-07-19 18:19:00
7023	2014-07-19 18:20:00	2014-07-19 18:29:00
7024	2014-07-19 18:30:00	2014-07-19 18:39:00
7025	2014-07-19 18:40:00	2014-07-19 18:49:00
7026	2014-07-19 18:50:00	2014-07-19 18:59:00
7027	2014-07-19 19:00:00	2014-07-19 19:09:00
7028	2014-07-19 19:10:00	2014-07-19 19:19:00
7029	2014-07-19 19:20:00	2014-07-19 19:29:00
7030	2014-07-19 19:30:00	2014-07-19 19:39:00
7031	2014-07-19 19:40:00	2014-07-19 19:49:00
7032	2014-07-19 19:50:00	2014-07-19 19:59:00
7033	2014-07-19 20:00:00	2014-07-19 20:09:00
7034	2014-07-19 20:10:00	2014-07-19 20:19:00
7035	2014-07-19 20:20:00	2014-07-19 20:29:00
7036	2014-07-19 20:30:00	2014-07-19 20:39:00
7037	2014-07-19 20:40:00	2014-07-19 20:49:00
7038	2014-07-19 20:50:00	2014-07-19 20:59:00
7039	2014-07-19 21:00:00	2014-07-19 21:09:00
7040	2014-07-19 21:10:00	2014-07-19 21:19:00
7041	2014-07-19 21:20:00	2014-07-19 21:29:00
7042	2014-07-19 21:30:00	2014-07-19 21:39:00
7043	2014-07-19 21:40:00	2014-07-19 21:49:00
7044	2014-07-19 21:50:00	2014-07-19 21:59:00
7045	2014-07-19 22:00:00	2014-07-19 22:09:00
7046	2014-07-19 22:10:00	2014-07-19 22:19:00
7047	2014-07-19 22:20:00	2014-07-19 22:29:00
7048	2014-07-19 22:30:00	2014-07-19 22:39:00
7049	2014-07-19 22:40:00	2014-07-19 22:49:00
7050	2014-07-19 22:50:00	2014-07-19 22:59:00
7051	2014-07-19 23:00:00	2014-07-19 23:09:00
7052	2014-07-19 23:10:00	2014-07-19 23:19:00
7053	2014-07-19 23:20:00	2014-07-19 23:29:00
7054	2014-07-19 23:30:00	2014-07-19 23:39:00
7055	2014-07-19 23:40:00	2014-07-19 23:49:00
7056	2014-07-19 23:50:00	2014-07-19 23:59:00
7057	2014-07-20 00:00:00	2014-07-20 00:09:00
7058	2014-07-20 00:10:00	2014-07-20 00:19:00
7059	2014-07-20 00:20:00	2014-07-20 00:29:00
7060	2014-07-20 00:30:00	2014-07-20 00:39:00
7061	2014-07-20 00:40:00	2014-07-20 00:49:00
7062	2014-07-20 00:50:00	2014-07-20 00:59:00
7063	2014-07-20 01:00:00	2014-07-20 01:09:00
7064	2014-07-20 01:10:00	2014-07-20 01:19:00
7065	2014-07-20 01:20:00	2014-07-20 01:29:00
7066	2014-07-20 01:30:00	2014-07-20 01:39:00
7067	2014-07-20 01:40:00	2014-07-20 01:49:00
7068	2014-07-20 01:50:00	2014-07-20 01:59:00
7069	2014-07-20 02:00:00	2014-07-20 02:09:00
7070	2014-07-20 02:10:00	2014-07-20 02:19:00
7071	2014-07-20 02:20:00	2014-07-20 02:29:00
7072	2014-07-20 02:30:00	2014-07-20 02:39:00
7073	2014-07-20 02:40:00	2014-07-20 02:49:00
7074	2014-07-20 02:50:00	2014-07-20 02:59:00
7075	2014-07-20 03:00:00	2014-07-20 03:09:00
7076	2014-07-20 03:10:00	2014-07-20 03:19:00
7077	2014-07-20 03:20:00	2014-07-20 03:29:00
7078	2014-07-20 03:30:00	2014-07-20 03:39:00
7079	2014-07-20 03:40:00	2014-07-20 03:49:00
7080	2014-07-20 03:50:00	2014-07-20 03:59:00
7081	2014-07-20 04:00:00	2014-07-20 04:09:00
7082	2014-07-20 04:10:00	2014-07-20 04:19:00
7083	2014-07-20 04:20:00	2014-07-20 04:29:00
7084	2014-07-20 04:30:00	2014-07-20 04:39:00
7085	2014-07-20 04:40:00	2014-07-20 04:49:00
7086	2014-07-20 04:50:00	2014-07-20 04:59:00
7087	2014-07-20 05:00:00	2014-07-20 05:09:00
7088	2014-07-20 05:10:00	2014-07-20 05:19:00
7089	2014-07-20 05:20:00	2014-07-20 05:29:00
7090	2014-07-20 05:30:00	2014-07-20 05:39:00
7091	2014-07-20 05:40:00	2014-07-20 05:49:00
7092	2014-07-20 05:50:00	2014-07-20 05:59:00
7093	2014-07-20 06:00:00	2014-07-20 06:09:00
7094	2014-07-20 06:10:00	2014-07-20 06:19:00
7095	2014-07-20 06:20:00	2014-07-20 06:29:00
7096	2014-07-20 06:30:00	2014-07-20 06:39:00
7097	2014-07-20 06:40:00	2014-07-20 06:49:00
7098	2014-07-20 06:50:00	2014-07-20 06:59:00
7099	2014-07-20 07:00:00	2014-07-20 07:09:00
7100	2014-07-20 07:10:00	2014-07-20 07:19:00
7101	2014-07-20 07:20:00	2014-07-20 07:29:00
7102	2014-07-20 07:30:00	2014-07-20 07:39:00
7103	2014-07-20 07:40:00	2014-07-20 07:49:00
7104	2014-07-20 07:50:00	2014-07-20 07:59:00
7105	2014-07-20 08:00:00	2014-07-20 08:09:00
7106	2014-07-20 08:10:00	2014-07-20 08:19:00
7107	2014-07-20 08:20:00	2014-07-20 08:29:00
7108	2014-07-20 08:30:00	2014-07-20 08:39:00
7109	2014-07-20 08:40:00	2014-07-20 08:49:00
7110	2014-07-20 08:50:00	2014-07-20 08:59:00
7111	2014-07-20 09:00:00	2014-07-20 09:09:00
7112	2014-07-20 09:10:00	2014-07-20 09:19:00
7113	2014-07-20 09:20:00	2014-07-20 09:29:00
7114	2014-07-20 09:30:00	2014-07-20 09:39:00
7115	2014-07-20 09:40:00	2014-07-20 09:49:00
7116	2014-07-20 09:50:00	2014-07-20 09:59:00
7117	2014-07-20 10:00:00	2014-07-20 10:09:00
7118	2014-07-20 10:10:00	2014-07-20 10:19:00
7119	2014-07-20 10:20:00	2014-07-20 10:29:00
7120	2014-07-20 10:30:00	2014-07-20 10:39:00
7121	2014-07-20 10:40:00	2014-07-20 10:49:00
7122	2014-07-20 10:50:00	2014-07-20 10:59:00
7123	2014-07-20 11:00:00	2014-07-20 11:09:00
7124	2014-07-20 11:10:00	2014-07-20 11:19:00
7125	2014-07-20 11:20:00	2014-07-20 11:29:00
7126	2014-07-20 11:30:00	2014-07-20 11:39:00
7127	2014-07-20 11:40:00	2014-07-20 11:49:00
7128	2014-07-20 11:50:00	2014-07-20 11:59:00
7129	2014-07-20 12:00:00	2014-07-20 12:09:00
7130	2014-07-20 12:10:00	2014-07-20 12:19:00
7131	2014-07-20 12:20:00	2014-07-20 12:29:00
7132	2014-07-20 12:30:00	2014-07-20 12:39:00
7133	2014-07-20 12:40:00	2014-07-20 12:49:00
7134	2014-07-20 12:50:00	2014-07-20 12:59:00
7135	2014-07-20 13:00:00	2014-07-20 13:09:00
7136	2014-07-20 13:10:00	2014-07-20 13:19:00
7137	2014-07-20 13:20:00	2014-07-20 13:29:00
7138	2014-07-20 13:30:00	2014-07-20 13:39:00
7139	2014-07-20 13:40:00	2014-07-20 13:49:00
7140	2014-07-20 13:50:00	2014-07-20 13:59:00
7141	2014-07-20 14:00:00	2014-07-20 14:09:00
7142	2014-07-20 14:10:00	2014-07-20 14:19:00
7143	2014-07-20 14:20:00	2014-07-20 14:29:00
7144	2014-07-20 14:30:00	2014-07-20 14:39:00
7145	2014-07-20 14:40:00	2014-07-20 14:49:00
7146	2014-07-20 14:50:00	2014-07-20 14:59:00
7147	2014-07-20 15:00:00	2014-07-20 15:09:00
7148	2014-07-20 15:10:00	2014-07-20 15:19:00
7149	2014-07-20 15:20:00	2014-07-20 15:29:00
7150	2014-07-20 15:30:00	2014-07-20 15:39:00
7151	2014-07-20 15:40:00	2014-07-20 15:49:00
7152	2014-07-20 15:50:00	2014-07-20 15:59:00
7153	2014-07-20 16:00:00	2014-07-20 16:09:00
7154	2014-07-20 16:10:00	2014-07-20 16:19:00
7155	2014-07-20 16:20:00	2014-07-20 16:29:00
7156	2014-07-20 16:30:00	2014-07-20 16:39:00
7157	2014-07-20 16:40:00	2014-07-20 16:49:00
7158	2014-07-20 16:50:00	2014-07-20 16:59:00
7159	2014-07-20 17:00:00	2014-07-20 17:09:00
7160	2014-07-20 17:10:00	2014-07-20 17:19:00
7161	2014-07-20 17:20:00	2014-07-20 17:29:00
7162	2014-07-20 17:30:00	2014-07-20 17:39:00
7163	2014-07-20 17:40:00	2014-07-20 17:49:00
7164	2014-07-20 17:50:00	2014-07-20 17:59:00
7165	2014-07-20 18:00:00	2014-07-20 18:09:00
7166	2014-07-20 18:10:00	2014-07-20 18:19:00
7167	2014-07-20 18:20:00	2014-07-20 18:29:00
7168	2014-07-20 18:30:00	2014-07-20 18:39:00
7169	2014-07-20 18:40:00	2014-07-20 18:49:00
7170	2014-07-20 18:50:00	2014-07-20 18:59:00
7171	2014-07-20 19:00:00	2014-07-20 19:09:00
7172	2014-07-20 19:10:00	2014-07-20 19:19:00
7173	2014-07-20 19:20:00	2014-07-20 19:29:00
7174	2014-07-20 19:30:00	2014-07-20 19:39:00
7175	2014-07-20 19:40:00	2014-07-20 19:49:00
7176	2014-07-20 19:50:00	2014-07-20 19:59:00
7177	2014-07-20 20:00:00	2014-07-20 20:09:00
7178	2014-07-20 20:10:00	2014-07-20 20:19:00
7179	2014-07-20 20:20:00	2014-07-20 20:29:00
7180	2014-07-20 20:30:00	2014-07-20 20:39:00
7181	2014-07-20 20:40:00	2014-07-20 20:49:00
7182	2014-07-20 20:50:00	2014-07-20 20:59:00
7183	2014-07-20 21:00:00	2014-07-20 21:09:00
7184	2014-07-20 21:10:00	2014-07-20 21:19:00
7185	2014-07-20 21:20:00	2014-07-20 21:29:00
7186	2014-07-20 21:30:00	2014-07-20 21:39:00
7187	2014-07-20 21:40:00	2014-07-20 21:49:00
7188	2014-07-20 21:50:00	2014-07-20 21:59:00
7189	2014-07-20 22:00:00	2014-07-20 22:09:00
7190	2014-07-20 22:10:00	2014-07-20 22:19:00
7191	2014-07-20 22:20:00	2014-07-20 22:29:00
7192	2014-07-20 22:30:00	2014-07-20 22:39:00
7193	2014-07-20 22:40:00	2014-07-20 22:49:00
7194	2014-07-20 22:50:00	2014-07-20 22:59:00
7195	2014-07-20 23:00:00	2014-07-20 23:09:00
7196	2014-07-20 23:10:00	2014-07-20 23:19:00
7197	2014-07-20 23:20:00	2014-07-20 23:29:00
7198	2014-07-20 23:30:00	2014-07-20 23:39:00
7199	2014-07-20 23:40:00	2014-07-20 23:49:00
7200	2014-07-20 23:50:00	2014-07-20 23:59:00
7201	2014-07-21 00:00:00	2014-07-21 00:09:00
7202	2014-07-21 00:10:00	2014-07-21 00:19:00
7203	2014-07-21 00:20:00	2014-07-21 00:29:00
7204	2014-07-21 00:30:00	2014-07-21 00:39:00
7205	2014-07-21 00:40:00	2014-07-21 00:49:00
7206	2014-07-21 00:50:00	2014-07-21 00:59:00
7207	2014-07-21 01:00:00	2014-07-21 01:09:00
7208	2014-07-21 01:10:00	2014-07-21 01:19:00
7209	2014-07-21 01:20:00	2014-07-21 01:29:00
7210	2014-07-21 01:30:00	2014-07-21 01:39:00
7211	2014-07-21 01:40:00	2014-07-21 01:49:00
7212	2014-07-21 01:50:00	2014-07-21 01:59:00
7213	2014-07-21 02:00:00	2014-07-21 02:09:00
7214	2014-07-21 02:10:00	2014-07-21 02:19:00
7215	2014-07-21 02:20:00	2014-07-21 02:29:00
7216	2014-07-21 02:30:00	2014-07-21 02:39:00
7217	2014-07-21 02:40:00	2014-07-21 02:49:00
7218	2014-07-21 02:50:00	2014-07-21 02:59:00
7219	2014-07-21 03:00:00	2014-07-21 03:09:00
7220	2014-07-21 03:10:00	2014-07-21 03:19:00
7221	2014-07-21 03:20:00	2014-07-21 03:29:00
7222	2014-07-21 03:30:00	2014-07-21 03:39:00
7223	2014-07-21 03:40:00	2014-07-21 03:49:00
7224	2014-07-21 03:50:00	2014-07-21 03:59:00
7225	2014-07-21 04:00:00	2014-07-21 04:09:00
7226	2014-07-21 04:10:00	2014-07-21 04:19:00
7227	2014-07-21 04:20:00	2014-07-21 04:29:00
7228	2014-07-21 04:30:00	2014-07-21 04:39:00
7229	2014-07-21 04:40:00	2014-07-21 04:49:00
7230	2014-07-21 04:50:00	2014-07-21 04:59:00
7231	2014-07-21 05:00:00	2014-07-21 05:09:00
7232	2014-07-21 05:10:00	2014-07-21 05:19:00
7233	2014-07-21 05:20:00	2014-07-21 05:29:00
7234	2014-07-21 05:30:00	2014-07-21 05:39:00
7235	2014-07-21 05:40:00	2014-07-21 05:49:00
7236	2014-07-21 05:50:00	2014-07-21 05:59:00
7237	2014-07-21 06:00:00	2014-07-21 06:09:00
7238	2014-07-21 06:10:00	2014-07-21 06:19:00
7239	2014-07-21 06:20:00	2014-07-21 06:29:00
7240	2014-07-21 06:30:00	2014-07-21 06:39:00
7241	2014-07-21 06:40:00	2014-07-21 06:49:00
7242	2014-07-21 06:50:00	2014-07-21 06:59:00
7243	2014-07-21 07:00:00	2014-07-21 07:09:00
7244	2014-07-21 07:10:00	2014-07-21 07:19:00
7245	2014-07-21 07:20:00	2014-07-21 07:29:00
7246	2014-07-21 07:30:00	2014-07-21 07:39:00
7247	2014-07-21 07:40:00	2014-07-21 07:49:00
7248	2014-07-21 07:50:00	2014-07-21 07:59:00
7249	2014-07-21 08:00:00	2014-07-21 08:09:00
7250	2014-07-21 08:10:00	2014-07-21 08:19:00
7251	2014-07-21 08:20:00	2014-07-21 08:29:00
7252	2014-07-21 08:30:00	2014-07-21 08:39:00
7253	2014-07-21 08:40:00	2014-07-21 08:49:00
7254	2014-07-21 08:50:00	2014-07-21 08:59:00
7255	2014-07-21 09:00:00	2014-07-21 09:09:00
7256	2014-07-21 09:10:00	2014-07-21 09:19:00
7257	2014-07-21 09:20:00	2014-07-21 09:29:00
7258	2014-07-21 09:30:00	2014-07-21 09:39:00
7259	2014-07-21 09:40:00	2014-07-21 09:49:00
7260	2014-07-21 09:50:00	2014-07-21 09:59:00
7261	2014-07-21 10:00:00	2014-07-21 10:09:00
7262	2014-07-21 10:10:00	2014-07-21 10:19:00
7263	2014-07-21 10:20:00	2014-07-21 10:29:00
7264	2014-07-21 10:30:00	2014-07-21 10:39:00
7265	2014-07-21 10:40:00	2014-07-21 10:49:00
7266	2014-07-21 10:50:00	2014-07-21 10:59:00
7267	2014-07-21 11:00:00	2014-07-21 11:09:00
7268	2014-07-21 11:10:00	2014-07-21 11:19:00
7269	2014-07-21 11:20:00	2014-07-21 11:29:00
7270	2014-07-21 11:30:00	2014-07-21 11:39:00
7271	2014-07-21 11:40:00	2014-07-21 11:49:00
7272	2014-07-21 11:50:00	2014-07-21 11:59:00
7273	2014-07-21 12:00:00	2014-07-21 12:09:00
7274	2014-07-21 12:10:00	2014-07-21 12:19:00
7275	2014-07-21 12:20:00	2014-07-21 12:29:00
7276	2014-07-21 12:30:00	2014-07-21 12:39:00
7277	2014-07-21 12:40:00	2014-07-21 12:49:00
7278	2014-07-21 12:50:00	2014-07-21 12:59:00
7279	2014-07-21 13:00:00	2014-07-21 13:09:00
7280	2014-07-21 13:10:00	2014-07-21 13:19:00
7281	2014-07-21 13:20:00	2014-07-21 13:29:00
7282	2014-07-21 13:30:00	2014-07-21 13:39:00
7283	2014-07-21 13:40:00	2014-07-21 13:49:00
7284	2014-07-21 13:50:00	2014-07-21 13:59:00
7285	2014-07-21 14:00:00	2014-07-21 14:09:00
7286	2014-07-21 14:10:00	2014-07-21 14:19:00
7287	2014-07-21 14:20:00	2014-07-21 14:29:00
7288	2014-07-21 14:30:00	2014-07-21 14:39:00
7289	2014-07-21 14:40:00	2014-07-21 14:49:00
7290	2014-07-21 14:50:00	2014-07-21 14:59:00
7291	2014-07-21 15:00:00	2014-07-21 15:09:00
7292	2014-07-21 15:10:00	2014-07-21 15:19:00
7293	2014-07-21 15:20:00	2014-07-21 15:29:00
7294	2014-07-21 15:30:00	2014-07-21 15:39:00
7295	2014-07-21 15:40:00	2014-07-21 15:49:00
7296	2014-07-21 15:50:00	2014-07-21 15:59:00
7297	2014-07-21 16:00:00	2014-07-21 16:09:00
7298	2014-07-21 16:10:00	2014-07-21 16:19:00
7299	2014-07-21 16:20:00	2014-07-21 16:29:00
7300	2014-07-21 16:30:00	2014-07-21 16:39:00
7301	2014-07-21 16:40:00	2014-07-21 16:49:00
7302	2014-07-21 16:50:00	2014-07-21 16:59:00
7303	2014-07-21 17:00:00	2014-07-21 17:09:00
7304	2014-07-21 17:10:00	2014-07-21 17:19:00
7305	2014-07-21 17:20:00	2014-07-21 17:29:00
7306	2014-07-21 17:30:00	2014-07-21 17:39:00
7307	2014-07-21 17:40:00	2014-07-21 17:49:00
7308	2014-07-21 17:50:00	2014-07-21 17:59:00
7309	2014-07-21 18:00:00	2014-07-21 18:09:00
7310	2014-07-21 18:10:00	2014-07-21 18:19:00
7311	2014-07-21 18:20:00	2014-07-21 18:29:00
7312	2014-07-21 18:30:00	2014-07-21 18:39:00
7313	2014-07-21 18:40:00	2014-07-21 18:49:00
7314	2014-07-21 18:50:00	2014-07-21 18:59:00
7315	2014-07-21 19:00:00	2014-07-21 19:09:00
7316	2014-07-21 19:10:00	2014-07-21 19:19:00
7317	2014-07-21 19:20:00	2014-07-21 19:29:00
7318	2014-07-21 19:30:00	2014-07-21 19:39:00
7319	2014-07-21 19:40:00	2014-07-21 19:49:00
7320	2014-07-21 19:50:00	2014-07-21 19:59:00
7321	2014-07-21 20:00:00	2014-07-21 20:09:00
7322	2014-07-21 20:10:00	2014-07-21 20:19:00
7323	2014-07-21 20:20:00	2014-07-21 20:29:00
7324	2014-07-21 20:30:00	2014-07-21 20:39:00
7325	2014-07-21 20:40:00	2014-07-21 20:49:00
7326	2014-07-21 20:50:00	2014-07-21 20:59:00
7327	2014-07-21 21:00:00	2014-07-21 21:09:00
7328	2014-07-21 21:10:00	2014-07-21 21:19:00
7329	2014-07-21 21:20:00	2014-07-21 21:29:00
7330	2014-07-21 21:30:00	2014-07-21 21:39:00
7331	2014-07-21 21:40:00	2014-07-21 21:49:00
7332	2014-07-21 21:50:00	2014-07-21 21:59:00
7333	2014-07-21 22:00:00	2014-07-21 22:09:00
7334	2014-07-21 22:10:00	2014-07-21 22:19:00
7335	2014-07-21 22:20:00	2014-07-21 22:29:00
7336	2014-07-21 22:30:00	2014-07-21 22:39:00
7337	2014-07-21 22:40:00	2014-07-21 22:49:00
7338	2014-07-21 22:50:00	2014-07-21 22:59:00
7339	2014-07-21 23:00:00	2014-07-21 23:09:00
7340	2014-07-21 23:10:00	2014-07-21 23:19:00
7341	2014-07-21 23:20:00	2014-07-21 23:29:00
7342	2014-07-21 23:30:00	2014-07-21 23:39:00
7343	2014-07-21 23:40:00	2014-07-21 23:49:00
7344	2014-07-21 23:50:00	2014-07-21 23:59:00
7345	2014-07-22 00:00:00	2014-07-22 00:09:00
7346	2014-07-22 00:10:00	2014-07-22 00:19:00
7347	2014-07-22 00:20:00	2014-07-22 00:29:00
7348	2014-07-22 00:30:00	2014-07-22 00:39:00
7349	2014-07-22 00:40:00	2014-07-22 00:49:00
7350	2014-07-22 00:50:00	2014-07-22 00:59:00
7351	2014-07-22 01:00:00	2014-07-22 01:09:00
7352	2014-07-22 01:10:00	2014-07-22 01:19:00
7353	2014-07-22 01:20:00	2014-07-22 01:29:00
7354	2014-07-22 01:30:00	2014-07-22 01:39:00
7355	2014-07-22 01:40:00	2014-07-22 01:49:00
7356	2014-07-22 01:50:00	2014-07-22 01:59:00
7357	2014-07-22 02:00:00	2014-07-22 02:09:00
7358	2014-07-22 02:10:00	2014-07-22 02:19:00
7359	2014-07-22 02:20:00	2014-07-22 02:29:00
7360	2014-07-22 02:30:00	2014-07-22 02:39:00
7361	2014-07-22 02:40:00	2014-07-22 02:49:00
7362	2014-07-22 02:50:00	2014-07-22 02:59:00
7363	2014-07-22 03:00:00	2014-07-22 03:09:00
7364	2014-07-22 03:10:00	2014-07-22 03:19:00
7365	2014-07-22 03:20:00	2014-07-22 03:29:00
7366	2014-07-22 03:30:00	2014-07-22 03:39:00
7367	2014-07-22 03:40:00	2014-07-22 03:49:00
7368	2014-07-22 03:50:00	2014-07-22 03:59:00
7369	2014-07-22 04:00:00	2014-07-22 04:09:00
7370	2014-07-22 04:10:00	2014-07-22 04:19:00
7371	2014-07-22 04:20:00	2014-07-22 04:29:00
7372	2014-07-22 04:30:00	2014-07-22 04:39:00
7373	2014-07-22 04:40:00	2014-07-22 04:49:00
7374	2014-07-22 04:50:00	2014-07-22 04:59:00
7375	2014-07-22 05:00:00	2014-07-22 05:09:00
7376	2014-07-22 05:10:00	2014-07-22 05:19:00
7377	2014-07-22 05:20:00	2014-07-22 05:29:00
7378	2014-07-22 05:30:00	2014-07-22 05:39:00
7379	2014-07-22 05:40:00	2014-07-22 05:49:00
7380	2014-07-22 05:50:00	2014-07-22 05:59:00
7381	2014-07-22 06:00:00	2014-07-22 06:09:00
7382	2014-07-22 06:10:00	2014-07-22 06:19:00
7383	2014-07-22 06:20:00	2014-07-22 06:29:00
7384	2014-07-22 06:30:00	2014-07-22 06:39:00
7385	2014-07-22 06:40:00	2014-07-22 06:49:00
7386	2014-07-22 06:50:00	2014-07-22 06:59:00
7387	2014-07-22 07:00:00	2014-07-22 07:09:00
7388	2014-07-22 07:10:00	2014-07-22 07:19:00
7389	2014-07-22 07:20:00	2014-07-22 07:29:00
7390	2014-07-22 07:30:00	2014-07-22 07:39:00
7391	2014-07-22 07:40:00	2014-07-22 07:49:00
7392	2014-07-22 07:50:00	2014-07-22 07:59:00
7393	2014-07-22 08:00:00	2014-07-22 08:09:00
7394	2014-07-22 08:10:00	2014-07-22 08:19:00
7395	2014-07-22 08:20:00	2014-07-22 08:29:00
7396	2014-07-22 08:30:00	2014-07-22 08:39:00
7397	2014-07-22 08:40:00	2014-07-22 08:49:00
7398	2014-07-22 08:50:00	2014-07-22 08:59:00
7399	2014-07-22 09:00:00	2014-07-22 09:09:00
7400	2014-07-22 09:10:00	2014-07-22 09:19:00
7401	2014-07-22 09:20:00	2014-07-22 09:29:00
7402	2014-07-22 09:30:00	2014-07-22 09:39:00
7403	2014-07-22 09:40:00	2014-07-22 09:49:00
7404	2014-07-22 09:50:00	2014-07-22 09:59:00
7405	2014-07-22 10:00:00	2014-07-22 10:09:00
7406	2014-07-22 10:10:00	2014-07-22 10:19:00
7407	2014-07-22 10:20:00	2014-07-22 10:29:00
7408	2014-07-22 10:30:00	2014-07-22 10:39:00
7409	2014-07-22 10:40:00	2014-07-22 10:49:00
7410	2014-07-22 10:50:00	2014-07-22 10:59:00
7411	2014-07-22 11:00:00	2014-07-22 11:09:00
7412	2014-07-22 11:10:00	2014-07-22 11:19:00
7413	2014-07-22 11:20:00	2014-07-22 11:29:00
7414	2014-07-22 11:30:00	2014-07-22 11:39:00
7415	2014-07-22 11:40:00	2014-07-22 11:49:00
7416	2014-07-22 11:50:00	2014-07-22 11:59:00
7417	2014-07-22 12:00:00	2014-07-22 12:09:00
7418	2014-07-22 12:10:00	2014-07-22 12:19:00
7419	2014-07-22 12:20:00	2014-07-22 12:29:00
7420	2014-07-22 12:30:00	2014-07-22 12:39:00
7421	2014-07-22 12:40:00	2014-07-22 12:49:00
7422	2014-07-22 12:50:00	2014-07-22 12:59:00
7423	2014-07-22 13:00:00	2014-07-22 13:09:00
7424	2014-07-22 13:10:00	2014-07-22 13:19:00
7425	2014-07-22 13:20:00	2014-07-22 13:29:00
7426	2014-07-22 13:30:00	2014-07-22 13:39:00
7427	2014-07-22 13:40:00	2014-07-22 13:49:00
7428	2014-07-22 13:50:00	2014-07-22 13:59:00
7429	2014-07-22 14:00:00	2014-07-22 14:09:00
7430	2014-07-22 14:10:00	2014-07-22 14:19:00
7431	2014-07-22 14:20:00	2014-07-22 14:29:00
7432	2014-07-22 14:30:00	2014-07-22 14:39:00
7433	2014-07-22 14:40:00	2014-07-22 14:49:00
7434	2014-07-22 14:50:00	2014-07-22 14:59:00
7435	2014-07-22 15:00:00	2014-07-22 15:09:00
7436	2014-07-22 15:10:00	2014-07-22 15:19:00
7437	2014-07-22 15:20:00	2014-07-22 15:29:00
7438	2014-07-22 15:30:00	2014-07-22 15:39:00
7439	2014-07-22 15:40:00	2014-07-22 15:49:00
7440	2014-07-22 15:50:00	2014-07-22 15:59:00
7441	2014-07-22 16:00:00	2014-07-22 16:09:00
7442	2014-07-22 16:10:00	2014-07-22 16:19:00
7443	2014-07-22 16:20:00	2014-07-22 16:29:00
7444	2014-07-22 16:30:00	2014-07-22 16:39:00
7445	2014-07-22 16:40:00	2014-07-22 16:49:00
7446	2014-07-22 16:50:00	2014-07-22 16:59:00
7447	2014-07-22 17:00:00	2014-07-22 17:09:00
7448	2014-07-22 17:10:00	2014-07-22 17:19:00
7449	2014-07-22 17:20:00	2014-07-22 17:29:00
7450	2014-07-22 17:30:00	2014-07-22 17:39:00
7451	2014-07-22 17:40:00	2014-07-22 17:49:00
7452	2014-07-22 17:50:00	2014-07-22 17:59:00
7453	2014-07-22 18:00:00	2014-07-22 18:09:00
7454	2014-07-22 18:10:00	2014-07-22 18:19:00
7455	2014-07-22 18:20:00	2014-07-22 18:29:00
7456	2014-07-22 18:30:00	2014-07-22 18:39:00
7457	2014-07-22 18:40:00	2014-07-22 18:49:00
7458	2014-07-22 18:50:00	2014-07-22 18:59:00
7459	2014-07-22 19:00:00	2014-07-22 19:09:00
7460	2014-07-22 19:10:00	2014-07-22 19:19:00
7461	2014-07-22 19:20:00	2014-07-22 19:29:00
7462	2014-07-22 19:30:00	2014-07-22 19:39:00
7463	2014-07-22 19:40:00	2014-07-22 19:49:00
7464	2014-07-22 19:50:00	2014-07-22 19:59:00
7465	2014-07-22 20:00:00	2014-07-22 20:09:00
7466	2014-07-22 20:10:00	2014-07-22 20:19:00
7467	2014-07-22 20:20:00	2014-07-22 20:29:00
7468	2014-07-22 20:30:00	2014-07-22 20:39:00
7469	2014-07-22 20:40:00	2014-07-22 20:49:00
7470	2014-07-22 20:50:00	2014-07-22 20:59:00
7471	2014-07-22 21:00:00	2014-07-22 21:09:00
7472	2014-07-22 21:10:00	2014-07-22 21:19:00
7473	2014-07-22 21:20:00	2014-07-22 21:29:00
7474	2014-07-22 21:30:00	2014-07-22 21:39:00
7475	2014-07-22 21:40:00	2014-07-22 21:49:00
7476	2014-07-22 21:50:00	2014-07-22 21:59:00
7477	2014-07-22 22:00:00	2014-07-22 22:09:00
7478	2014-07-22 22:10:00	2014-07-22 22:19:00
7479	2014-07-22 22:20:00	2014-07-22 22:29:00
7480	2014-07-22 22:30:00	2014-07-22 22:39:00
7481	2014-07-22 22:40:00	2014-07-22 22:49:00
7482	2014-07-22 22:50:00	2014-07-22 22:59:00
7483	2014-07-22 23:00:00	2014-07-22 23:09:00
7484	2014-07-22 23:10:00	2014-07-22 23:19:00
7485	2014-07-22 23:20:00	2014-07-22 23:29:00
7486	2014-07-22 23:30:00	2014-07-22 23:39:00
7487	2014-07-22 23:40:00	2014-07-22 23:49:00
7488	2014-07-22 23:50:00	2014-07-22 23:59:00
7489	2014-07-23 00:00:00	2014-07-23 00:09:00
7490	2014-07-23 00:10:00	2014-07-23 00:19:00
7491	2014-07-23 00:20:00	2014-07-23 00:29:00
7492	2014-07-23 00:30:00	2014-07-23 00:39:00
7493	2014-07-23 00:40:00	2014-07-23 00:49:00
7494	2014-07-23 00:50:00	2014-07-23 00:59:00
7495	2014-07-23 01:00:00	2014-07-23 01:09:00
7496	2014-07-23 01:10:00	2014-07-23 01:19:00
7497	2014-07-23 01:20:00	2014-07-23 01:29:00
7498	2014-07-23 01:30:00	2014-07-23 01:39:00
7499	2014-07-23 01:40:00	2014-07-23 01:49:00
7500	2014-07-23 01:50:00	2014-07-23 01:59:00
7501	2014-07-23 02:00:00	2014-07-23 02:09:00
7502	2014-07-23 02:10:00	2014-07-23 02:19:00
7503	2014-07-23 02:20:00	2014-07-23 02:29:00
7504	2014-07-23 02:30:00	2014-07-23 02:39:00
7505	2014-07-23 02:40:00	2014-07-23 02:49:00
7506	2014-07-23 02:50:00	2014-07-23 02:59:00
7507	2014-07-23 03:00:00	2014-07-23 03:09:00
7508	2014-07-23 03:10:00	2014-07-23 03:19:00
7509	2014-07-23 03:20:00	2014-07-23 03:29:00
7510	2014-07-23 03:30:00	2014-07-23 03:39:00
7511	2014-07-23 03:40:00	2014-07-23 03:49:00
7512	2014-07-23 03:50:00	2014-07-23 03:59:00
7513	2014-07-23 04:00:00	2014-07-23 04:09:00
7514	2014-07-23 04:10:00	2014-07-23 04:19:00
7515	2014-07-23 04:20:00	2014-07-23 04:29:00
7516	2014-07-23 04:30:00	2014-07-23 04:39:00
7517	2014-07-23 04:40:00	2014-07-23 04:49:00
7518	2014-07-23 04:50:00	2014-07-23 04:59:00
7519	2014-07-23 05:00:00	2014-07-23 05:09:00
7520	2014-07-23 05:10:00	2014-07-23 05:19:00
7521	2014-07-23 05:20:00	2014-07-23 05:29:00
7522	2014-07-23 05:30:00	2014-07-23 05:39:00
7523	2014-07-23 05:40:00	2014-07-23 05:49:00
7524	2014-07-23 05:50:00	2014-07-23 05:59:00
7525	2014-07-23 06:00:00	2014-07-23 06:09:00
7526	2014-07-23 06:10:00	2014-07-23 06:19:00
7527	2014-07-23 06:20:00	2014-07-23 06:29:00
7528	2014-07-23 06:30:00	2014-07-23 06:39:00
7529	2014-07-23 06:40:00	2014-07-23 06:49:00
7530	2014-07-23 06:50:00	2014-07-23 06:59:00
7531	2014-07-23 07:00:00	2014-07-23 07:09:00
7532	2014-07-23 07:10:00	2014-07-23 07:19:00
7533	2014-07-23 07:20:00	2014-07-23 07:29:00
7534	2014-07-23 07:30:00	2014-07-23 07:39:00
7535	2014-07-23 07:40:00	2014-07-23 07:49:00
7536	2014-07-23 07:50:00	2014-07-23 07:59:00
7537	2014-07-23 08:00:00	2014-07-23 08:09:00
7538	2014-07-23 08:10:00	2014-07-23 08:19:00
7539	2014-07-23 08:20:00	2014-07-23 08:29:00
7540	2014-07-23 08:30:00	2014-07-23 08:39:00
7541	2014-07-23 08:40:00	2014-07-23 08:49:00
7542	2014-07-23 08:50:00	2014-07-23 08:59:00
7543	2014-07-23 09:00:00	2014-07-23 09:09:00
7544	2014-07-23 09:10:00	2014-07-23 09:19:00
7545	2014-07-23 09:20:00	2014-07-23 09:29:00
7546	2014-07-23 09:30:00	2014-07-23 09:39:00
7547	2014-07-23 09:40:00	2014-07-23 09:49:00
7548	2014-07-23 09:50:00	2014-07-23 09:59:00
7549	2014-07-23 10:00:00	2014-07-23 10:09:00
7550	2014-07-23 10:10:00	2014-07-23 10:19:00
7551	2014-07-23 10:20:00	2014-07-23 10:29:00
7552	2014-07-23 10:30:00	2014-07-23 10:39:00
7553	2014-07-23 10:40:00	2014-07-23 10:49:00
7554	2014-07-23 10:50:00	2014-07-23 10:59:00
7555	2014-07-23 11:00:00	2014-07-23 11:09:00
7556	2014-07-23 11:10:00	2014-07-23 11:19:00
7557	2014-07-23 11:20:00	2014-07-23 11:29:00
7558	2014-07-23 11:30:00	2014-07-23 11:39:00
7559	2014-07-23 11:40:00	2014-07-23 11:49:00
7560	2014-07-23 11:50:00	2014-07-23 11:59:00
7561	2014-07-23 12:00:00	2014-07-23 12:09:00
7562	2014-07-23 12:10:00	2014-07-23 12:19:00
7563	2014-07-23 12:20:00	2014-07-23 12:29:00
7564	2014-07-23 12:30:00	2014-07-23 12:39:00
7565	2014-07-23 12:40:00	2014-07-23 12:49:00
7566	2014-07-23 12:50:00	2014-07-23 12:59:00
7567	2014-07-23 13:00:00	2014-07-23 13:09:00
7568	2014-07-23 13:10:00	2014-07-23 13:19:00
7569	2014-07-23 13:20:00	2014-07-23 13:29:00
7570	2014-07-23 13:30:00	2014-07-23 13:39:00
7571	2014-07-23 13:40:00	2014-07-23 13:49:00
7572	2014-07-23 13:50:00	2014-07-23 13:59:00
7573	2014-07-23 14:00:00	2014-07-23 14:09:00
7574	2014-07-23 14:10:00	2014-07-23 14:19:00
7575	2014-07-23 14:20:00	2014-07-23 14:29:00
7576	2014-07-23 14:30:00	2014-07-23 14:39:00
7577	2014-07-23 14:40:00	2014-07-23 14:49:00
7578	2014-07-23 14:50:00	2014-07-23 14:59:00
7579	2014-07-23 15:00:00	2014-07-23 15:09:00
7580	2014-07-23 15:10:00	2014-07-23 15:19:00
7581	2014-07-23 15:20:00	2014-07-23 15:29:00
7582	2014-07-23 15:30:00	2014-07-23 15:39:00
7583	2014-07-23 15:40:00	2014-07-23 15:49:00
7584	2014-07-23 15:50:00	2014-07-23 15:59:00
7585	2014-07-23 16:00:00	2014-07-23 16:09:00
7586	2014-07-23 16:10:00	2014-07-23 16:19:00
7587	2014-07-23 16:20:00	2014-07-23 16:29:00
7588	2014-07-23 16:30:00	2014-07-23 16:39:00
7589	2014-07-23 16:40:00	2014-07-23 16:49:00
7590	2014-07-23 16:50:00	2014-07-23 16:59:00
7591	2014-07-23 17:00:00	2014-07-23 17:09:00
7592	2014-07-23 17:10:00	2014-07-23 17:19:00
7593	2014-07-23 17:20:00	2014-07-23 17:29:00
7594	2014-07-23 17:30:00	2014-07-23 17:39:00
7595	2014-07-23 17:40:00	2014-07-23 17:49:00
7596	2014-07-23 17:50:00	2014-07-23 17:59:00
7597	2014-07-23 18:00:00	2014-07-23 18:09:00
7598	2014-07-23 18:10:00	2014-07-23 18:19:00
7599	2014-07-23 18:20:00	2014-07-23 18:29:00
7600	2014-07-23 18:30:00	2014-07-23 18:39:00
7601	2014-07-23 18:40:00	2014-07-23 18:49:00
7602	2014-07-23 18:50:00	2014-07-23 18:59:00
7603	2014-07-23 19:00:00	2014-07-23 19:09:00
7604	2014-07-23 19:10:00	2014-07-23 19:19:00
7605	2014-07-23 19:20:00	2014-07-23 19:29:00
7606	2014-07-23 19:30:00	2014-07-23 19:39:00
7607	2014-07-23 19:40:00	2014-07-23 19:49:00
7608	2014-07-23 19:50:00	2014-07-23 19:59:00
7609	2014-07-23 20:00:00	2014-07-23 20:09:00
7610	2014-07-23 20:10:00	2014-07-23 20:19:00
7611	2014-07-23 20:20:00	2014-07-23 20:29:00
7612	2014-07-23 20:30:00	2014-07-23 20:39:00
7613	2014-07-23 20:40:00	2014-07-23 20:49:00
7614	2014-07-23 20:50:00	2014-07-23 20:59:00
7615	2014-07-23 21:00:00	2014-07-23 21:09:00
7616	2014-07-23 21:10:00	2014-07-23 21:19:00
7617	2014-07-23 21:20:00	2014-07-23 21:29:00
7618	2014-07-23 21:30:00	2014-07-23 21:39:00
7619	2014-07-23 21:40:00	2014-07-23 21:49:00
7620	2014-07-23 21:50:00	2014-07-23 21:59:00
7621	2014-07-23 22:00:00	2014-07-23 22:09:00
7622	2014-07-23 22:10:00	2014-07-23 22:19:00
7623	2014-07-23 22:20:00	2014-07-23 22:29:00
7624	2014-07-23 22:30:00	2014-07-23 22:39:00
7625	2014-07-23 22:40:00	2014-07-23 22:49:00
7626	2014-07-23 22:50:00	2014-07-23 22:59:00
7627	2014-07-23 23:00:00	2014-07-23 23:09:00
7628	2014-07-23 23:10:00	2014-07-23 23:19:00
7629	2014-07-23 23:20:00	2014-07-23 23:29:00
7630	2014-07-23 23:30:00	2014-07-23 23:39:00
7631	2014-07-23 23:40:00	2014-07-23 23:49:00
7632	2014-07-23 23:50:00	2014-07-23 23:59:00
7633	2014-07-24 00:00:00	2014-07-24 00:09:00
7634	2014-07-24 00:10:00	2014-07-24 00:19:00
7635	2014-07-24 00:20:00	2014-07-24 00:29:00
7636	2014-07-24 00:30:00	2014-07-24 00:39:00
7637	2014-07-24 00:40:00	2014-07-24 00:49:00
7638	2014-07-24 00:50:00	2014-07-24 00:59:00
7639	2014-07-24 01:00:00	2014-07-24 01:09:00
7640	2014-07-24 01:10:00	2014-07-24 01:19:00
7641	2014-07-24 01:20:00	2014-07-24 01:29:00
7642	2014-07-24 01:30:00	2014-07-24 01:39:00
7643	2014-07-24 01:40:00	2014-07-24 01:49:00
7644	2014-07-24 01:50:00	2014-07-24 01:59:00
7645	2014-07-24 02:00:00	2014-07-24 02:09:00
7646	2014-07-24 02:10:00	2014-07-24 02:19:00
7647	2014-07-24 02:20:00	2014-07-24 02:29:00
7648	2014-07-24 02:30:00	2014-07-24 02:39:00
7649	2014-07-24 02:40:00	2014-07-24 02:49:00
7650	2014-07-24 02:50:00	2014-07-24 02:59:00
7651	2014-07-24 03:00:00	2014-07-24 03:09:00
7652	2014-07-24 03:10:00	2014-07-24 03:19:00
7653	2014-07-24 03:20:00	2014-07-24 03:29:00
7654	2014-07-24 03:30:00	2014-07-24 03:39:00
7655	2014-07-24 03:40:00	2014-07-24 03:49:00
7656	2014-07-24 03:50:00	2014-07-24 03:59:00
7657	2014-07-24 04:00:00	2014-07-24 04:09:00
7658	2014-07-24 04:10:00	2014-07-24 04:19:00
7659	2014-07-24 04:20:00	2014-07-24 04:29:00
7660	2014-07-24 04:30:00	2014-07-24 04:39:00
7661	2014-07-24 04:40:00	2014-07-24 04:49:00
7662	2014-07-24 04:50:00	2014-07-24 04:59:00
7663	2014-07-24 05:00:00	2014-07-24 05:09:00
7664	2014-07-24 05:10:00	2014-07-24 05:19:00
7665	2014-07-24 05:20:00	2014-07-24 05:29:00
7666	2014-07-24 05:30:00	2014-07-24 05:39:00
7667	2014-07-24 05:40:00	2014-07-24 05:49:00
7668	2014-07-24 05:50:00	2014-07-24 05:59:00
7669	2014-07-24 06:00:00	2014-07-24 06:09:00
7670	2014-07-24 06:10:00	2014-07-24 06:19:00
7671	2014-07-24 06:20:00	2014-07-24 06:29:00
7672	2014-07-24 06:30:00	2014-07-24 06:39:00
7673	2014-07-24 06:40:00	2014-07-24 06:49:00
7674	2014-07-24 06:50:00	2014-07-24 06:59:00
7675	2014-07-24 07:00:00	2014-07-24 07:09:00
7676	2014-07-24 07:10:00	2014-07-24 07:19:00
7677	2014-07-24 07:20:00	2014-07-24 07:29:00
7678	2014-07-24 07:30:00	2014-07-24 07:39:00
7679	2014-07-24 07:40:00	2014-07-24 07:49:00
7680	2014-07-24 07:50:00	2014-07-24 07:59:00
7681	2014-07-24 08:00:00	2014-07-24 08:09:00
7682	2014-07-24 08:10:00	2014-07-24 08:19:00
7683	2014-07-24 08:20:00	2014-07-24 08:29:00
7684	2014-07-24 08:30:00	2014-07-24 08:39:00
7685	2014-07-24 08:40:00	2014-07-24 08:49:00
7686	2014-07-24 08:50:00	2014-07-24 08:59:00
7687	2014-07-24 09:00:00	2014-07-24 09:09:00
7688	2014-07-24 09:10:00	2014-07-24 09:19:00
7689	2014-07-24 09:20:00	2014-07-24 09:29:00
7690	2014-07-24 09:30:00	2014-07-24 09:39:00
7691	2014-07-24 09:40:00	2014-07-24 09:49:00
7692	2014-07-24 09:50:00	2014-07-24 09:59:00
7693	2014-07-24 10:00:00	2014-07-24 10:09:00
7694	2014-07-24 10:10:00	2014-07-24 10:19:00
7695	2014-07-24 10:20:00	2014-07-24 10:29:00
7696	2014-07-24 10:30:00	2014-07-24 10:39:00
7697	2014-07-24 10:40:00	2014-07-24 10:49:00
7698	2014-07-24 10:50:00	2014-07-24 10:59:00
7699	2014-07-24 11:00:00	2014-07-24 11:09:00
7700	2014-07-24 11:10:00	2014-07-24 11:19:00
7701	2014-07-24 11:20:00	2014-07-24 11:29:00
7702	2014-07-24 11:30:00	2014-07-24 11:39:00
7703	2014-07-24 11:40:00	2014-07-24 11:49:00
7704	2014-07-24 11:50:00	2014-07-24 11:59:00
7705	2014-07-24 12:00:00	2014-07-24 12:09:00
7706	2014-07-24 12:10:00	2014-07-24 12:19:00
7707	2014-07-24 12:20:00	2014-07-24 12:29:00
7708	2014-07-24 12:30:00	2014-07-24 12:39:00
7709	2014-07-24 12:40:00	2014-07-24 12:49:00
7710	2014-07-24 12:50:00	2014-07-24 12:59:00
7711	2014-07-24 13:00:00	2014-07-24 13:09:00
7712	2014-07-24 13:10:00	2014-07-24 13:19:00
7713	2014-07-24 13:20:00	2014-07-24 13:29:00
7714	2014-07-24 13:30:00	2014-07-24 13:39:00
7715	2014-07-24 13:40:00	2014-07-24 13:49:00
7716	2014-07-24 13:50:00	2014-07-24 13:59:00
7717	2014-07-24 14:00:00	2014-07-24 14:09:00
7718	2014-07-24 14:10:00	2014-07-24 14:19:00
7719	2014-07-24 14:20:00	2014-07-24 14:29:00
7720	2014-07-24 14:30:00	2014-07-24 14:39:00
7721	2014-07-24 14:40:00	2014-07-24 14:49:00
7722	2014-07-24 14:50:00	2014-07-24 14:59:00
7723	2014-07-24 15:00:00	2014-07-24 15:09:00
7724	2014-07-24 15:10:00	2014-07-24 15:19:00
7725	2014-07-24 15:20:00	2014-07-24 15:29:00
7726	2014-07-24 15:30:00	2014-07-24 15:39:00
7727	2014-07-24 15:40:00	2014-07-24 15:49:00
7728	2014-07-24 15:50:00	2014-07-24 15:59:00
7729	2014-07-24 16:00:00	2014-07-24 16:09:00
7730	2014-07-24 16:10:00	2014-07-24 16:19:00
7731	2014-07-24 16:20:00	2014-07-24 16:29:00
7732	2014-07-24 16:30:00	2014-07-24 16:39:00
7733	2014-07-24 16:40:00	2014-07-24 16:49:00
7734	2014-07-24 16:50:00	2014-07-24 16:59:00
7735	2014-07-24 17:00:00	2014-07-24 17:09:00
7736	2014-07-24 17:10:00	2014-07-24 17:19:00
7737	2014-07-24 17:20:00	2014-07-24 17:29:00
7738	2014-07-24 17:30:00	2014-07-24 17:39:00
7739	2014-07-24 17:40:00	2014-07-24 17:49:00
7740	2014-07-24 17:50:00	2014-07-24 17:59:00
7741	2014-07-24 18:00:00	2014-07-24 18:09:00
7742	2014-07-24 18:10:00	2014-07-24 18:19:00
7743	2014-07-24 18:20:00	2014-07-24 18:29:00
7744	2014-07-24 18:30:00	2014-07-24 18:39:00
7745	2014-07-24 18:40:00	2014-07-24 18:49:00
7746	2014-07-24 18:50:00	2014-07-24 18:59:00
7747	2014-07-24 19:00:00	2014-07-24 19:09:00
7748	2014-07-24 19:10:00	2014-07-24 19:19:00
7749	2014-07-24 19:20:00	2014-07-24 19:29:00
7750	2014-07-24 19:30:00	2014-07-24 19:39:00
7751	2014-07-24 19:40:00	2014-07-24 19:49:00
7752	2014-07-24 19:50:00	2014-07-24 19:59:00
7753	2014-07-24 20:00:00	2014-07-24 20:09:00
7754	2014-07-24 20:10:00	2014-07-24 20:19:00
7755	2014-07-24 20:20:00	2014-07-24 20:29:00
7756	2014-07-24 20:30:00	2014-07-24 20:39:00
7757	2014-07-24 20:40:00	2014-07-24 20:49:00
7758	2014-07-24 20:50:00	2014-07-24 20:59:00
7759	2014-07-24 21:00:00	2014-07-24 21:09:00
7760	2014-07-24 21:10:00	2014-07-24 21:19:00
7761	2014-07-24 21:20:00	2014-07-24 21:29:00
7762	2014-07-24 21:30:00	2014-07-24 21:39:00
7763	2014-07-24 21:40:00	2014-07-24 21:49:00
7764	2014-07-24 21:50:00	2014-07-24 21:59:00
7765	2014-07-24 22:00:00	2014-07-24 22:09:00
7766	2014-07-24 22:10:00	2014-07-24 22:19:00
7767	2014-07-24 22:20:00	2014-07-24 22:29:00
7768	2014-07-24 22:30:00	2014-07-24 22:39:00
7769	2014-07-24 22:40:00	2014-07-24 22:49:00
7770	2014-07-24 22:50:00	2014-07-24 22:59:00
7771	2014-07-24 23:00:00	2014-07-24 23:09:00
7772	2014-07-24 23:10:00	2014-07-24 23:19:00
7773	2014-07-24 23:20:00	2014-07-24 23:29:00
7774	2014-07-24 23:30:00	2014-07-24 23:39:00
7775	2014-07-24 23:40:00	2014-07-24 23:49:00
7776	2014-07-24 23:50:00	2014-07-24 23:59:00
7777	2014-07-25 00:00:00	2014-07-25 00:09:00
7778	2014-07-25 00:10:00	2014-07-25 00:19:00
7779	2014-07-25 00:20:00	2014-07-25 00:29:00
7780	2014-07-25 00:30:00	2014-07-25 00:39:00
7781	2014-07-25 00:40:00	2014-07-25 00:49:00
7782	2014-07-25 00:50:00	2014-07-25 00:59:00
7783	2014-07-25 01:00:00	2014-07-25 01:09:00
7784	2014-07-25 01:10:00	2014-07-25 01:19:00
7785	2014-07-25 01:20:00	2014-07-25 01:29:00
7786	2014-07-25 01:30:00	2014-07-25 01:39:00
7787	2014-07-25 01:40:00	2014-07-25 01:49:00
7788	2014-07-25 01:50:00	2014-07-25 01:59:00
7789	2014-07-25 02:00:00	2014-07-25 02:09:00
7790	2014-07-25 02:10:00	2014-07-25 02:19:00
7791	2014-07-25 02:20:00	2014-07-25 02:29:00
7792	2014-07-25 02:30:00	2014-07-25 02:39:00
7793	2014-07-25 02:40:00	2014-07-25 02:49:00
7794	2014-07-25 02:50:00	2014-07-25 02:59:00
7795	2014-07-25 03:00:00	2014-07-25 03:09:00
7796	2014-07-25 03:10:00	2014-07-25 03:19:00
7797	2014-07-25 03:20:00	2014-07-25 03:29:00
7798	2014-07-25 03:30:00	2014-07-25 03:39:00
7799	2014-07-25 03:40:00	2014-07-25 03:49:00
7800	2014-07-25 03:50:00	2014-07-25 03:59:00
7801	2014-07-25 04:00:00	2014-07-25 04:09:00
7802	2014-07-25 04:10:00	2014-07-25 04:19:00
7803	2014-07-25 04:20:00	2014-07-25 04:29:00
7804	2014-07-25 04:30:00	2014-07-25 04:39:00
7805	2014-07-25 04:40:00	2014-07-25 04:49:00
7806	2014-07-25 04:50:00	2014-07-25 04:59:00
7807	2014-07-25 05:00:00	2014-07-25 05:09:00
7808	2014-07-25 05:10:00	2014-07-25 05:19:00
7809	2014-07-25 05:20:00	2014-07-25 05:29:00
7810	2014-07-25 05:30:00	2014-07-25 05:39:00
7811	2014-07-25 05:40:00	2014-07-25 05:49:00
7812	2014-07-25 05:50:00	2014-07-25 05:59:00
7813	2014-07-25 06:00:00	2014-07-25 06:09:00
7814	2014-07-25 06:10:00	2014-07-25 06:19:00
7815	2014-07-25 06:20:00	2014-07-25 06:29:00
7816	2014-07-25 06:30:00	2014-07-25 06:39:00
7817	2014-07-25 06:40:00	2014-07-25 06:49:00
7818	2014-07-25 06:50:00	2014-07-25 06:59:00
7819	2014-07-25 07:00:00	2014-07-25 07:09:00
7820	2014-07-25 07:10:00	2014-07-25 07:19:00
7821	2014-07-25 07:20:00	2014-07-25 07:29:00
7822	2014-07-25 07:30:00	2014-07-25 07:39:00
7823	2014-07-25 07:40:00	2014-07-25 07:49:00
7824	2014-07-25 07:50:00	2014-07-25 07:59:00
7825	2014-07-25 08:00:00	2014-07-25 08:09:00
7826	2014-07-25 08:10:00	2014-07-25 08:19:00
7827	2014-07-25 08:20:00	2014-07-25 08:29:00
7828	2014-07-25 08:30:00	2014-07-25 08:39:00
7829	2014-07-25 08:40:00	2014-07-25 08:49:00
7830	2014-07-25 08:50:00	2014-07-25 08:59:00
7831	2014-07-25 09:00:00	2014-07-25 09:09:00
7832	2014-07-25 09:10:00	2014-07-25 09:19:00
7833	2014-07-25 09:20:00	2014-07-25 09:29:00
7834	2014-07-25 09:30:00	2014-07-25 09:39:00
7835	2014-07-25 09:40:00	2014-07-25 09:49:00
7836	2014-07-25 09:50:00	2014-07-25 09:59:00
7837	2014-07-25 10:00:00	2014-07-25 10:09:00
7838	2014-07-25 10:10:00	2014-07-25 10:19:00
7839	2014-07-25 10:20:00	2014-07-25 10:29:00
7840	2014-07-25 10:30:00	2014-07-25 10:39:00
7841	2014-07-25 10:40:00	2014-07-25 10:49:00
7842	2014-07-25 10:50:00	2014-07-25 10:59:00
7843	2014-07-25 11:00:00	2014-07-25 11:09:00
7844	2014-07-25 11:10:00	2014-07-25 11:19:00
7845	2014-07-25 11:20:00	2014-07-25 11:29:00
7846	2014-07-25 11:30:00	2014-07-25 11:39:00
7847	2014-07-25 11:40:00	2014-07-25 11:49:00
7848	2014-07-25 11:50:00	2014-07-25 11:59:00
7849	2014-07-25 12:00:00	2014-07-25 12:09:00
7850	2014-07-25 12:10:00	2014-07-25 12:19:00
7851	2014-07-25 12:20:00	2014-07-25 12:29:00
7852	2014-07-25 12:30:00	2014-07-25 12:39:00
7853	2014-07-25 12:40:00	2014-07-25 12:49:00
7854	2014-07-25 12:50:00	2014-07-25 12:59:00
7855	2014-07-25 13:00:00	2014-07-25 13:09:00
7856	2014-07-25 13:10:00	2014-07-25 13:19:00
7857	2014-07-25 13:20:00	2014-07-25 13:29:00
7858	2014-07-25 13:30:00	2014-07-25 13:39:00
7859	2014-07-25 13:40:00	2014-07-25 13:49:00
7860	2014-07-25 13:50:00	2014-07-25 13:59:00
7861	2014-07-25 14:00:00	2014-07-25 14:09:00
7862	2014-07-25 14:10:00	2014-07-25 14:19:00
7863	2014-07-25 14:20:00	2014-07-25 14:29:00
7864	2014-07-25 14:30:00	2014-07-25 14:39:00
7865	2014-07-25 14:40:00	2014-07-25 14:49:00
7866	2014-07-25 14:50:00	2014-07-25 14:59:00
7867	2014-07-25 15:00:00	2014-07-25 15:09:00
7868	2014-07-25 15:10:00	2014-07-25 15:19:00
7869	2014-07-25 15:20:00	2014-07-25 15:29:00
7870	2014-07-25 15:30:00	2014-07-25 15:39:00
7871	2014-07-25 15:40:00	2014-07-25 15:49:00
7872	2014-07-25 15:50:00	2014-07-25 15:59:00
7873	2014-07-25 16:00:00	2014-07-25 16:09:00
7874	2014-07-25 16:10:00	2014-07-25 16:19:00
7875	2014-07-25 16:20:00	2014-07-25 16:29:00
7876	2014-07-25 16:30:00	2014-07-25 16:39:00
7877	2014-07-25 16:40:00	2014-07-25 16:49:00
7878	2014-07-25 16:50:00	2014-07-25 16:59:00
7879	2014-07-25 17:00:00	2014-07-25 17:09:00
7880	2014-07-25 17:10:00	2014-07-25 17:19:00
7881	2014-07-25 17:20:00	2014-07-25 17:29:00
7882	2014-07-25 17:30:00	2014-07-25 17:39:00
7883	2014-07-25 17:40:00	2014-07-25 17:49:00
7884	2014-07-25 17:50:00	2014-07-25 17:59:00
7885	2014-07-25 18:00:00	2014-07-25 18:09:00
7886	2014-07-25 18:10:00	2014-07-25 18:19:00
7887	2014-07-25 18:20:00	2014-07-25 18:29:00
7888	2014-07-25 18:30:00	2014-07-25 18:39:00
7889	2014-07-25 18:40:00	2014-07-25 18:49:00
7890	2014-07-25 18:50:00	2014-07-25 18:59:00
7891	2014-07-25 19:00:00	2014-07-25 19:09:00
7892	2014-07-25 19:10:00	2014-07-25 19:19:00
7893	2014-07-25 19:20:00	2014-07-25 19:29:00
7894	2014-07-25 19:30:00	2014-07-25 19:39:00
7895	2014-07-25 19:40:00	2014-07-25 19:49:00
7896	2014-07-25 19:50:00	2014-07-25 19:59:00
7897	2014-07-25 20:00:00	2014-07-25 20:09:00
7898	2014-07-25 20:10:00	2014-07-25 20:19:00
7899	2014-07-25 20:20:00	2014-07-25 20:29:00
7900	2014-07-25 20:30:00	2014-07-25 20:39:00
7901	2014-07-25 20:40:00	2014-07-25 20:49:00
7902	2014-07-25 20:50:00	2014-07-25 20:59:00
7903	2014-07-25 21:00:00	2014-07-25 21:09:00
7904	2014-07-25 21:10:00	2014-07-25 21:19:00
7905	2014-07-25 21:20:00	2014-07-25 21:29:00
7906	2014-07-25 21:30:00	2014-07-25 21:39:00
7907	2014-07-25 21:40:00	2014-07-25 21:49:00
7908	2014-07-25 21:50:00	2014-07-25 21:59:00
7909	2014-07-25 22:00:00	2014-07-25 22:09:00
7910	2014-07-25 22:10:00	2014-07-25 22:19:00
7911	2014-07-25 22:20:00	2014-07-25 22:29:00
7912	2014-07-25 22:30:00	2014-07-25 22:39:00
7913	2014-07-25 22:40:00	2014-07-25 22:49:00
7914	2014-07-25 22:50:00	2014-07-25 22:59:00
7915	2014-07-25 23:00:00	2014-07-25 23:09:00
7916	2014-07-25 23:10:00	2014-07-25 23:19:00
7917	2014-07-25 23:20:00	2014-07-25 23:29:00
7918	2014-07-25 23:30:00	2014-07-25 23:39:00
7919	2014-07-25 23:40:00	2014-07-25 23:49:00
7920	2014-07-25 23:50:00	2014-07-25 23:59:00
7921	2014-07-26 00:00:00	2014-07-26 00:09:00
7922	2014-07-26 00:10:00	2014-07-26 00:19:00
7923	2014-07-26 00:20:00	2014-07-26 00:29:00
7924	2014-07-26 00:30:00	2014-07-26 00:39:00
7925	2014-07-26 00:40:00	2014-07-26 00:49:00
7926	2014-07-26 00:50:00	2014-07-26 00:59:00
7927	2014-07-26 01:00:00	2014-07-26 01:09:00
7928	2014-07-26 01:10:00	2014-07-26 01:19:00
7929	2014-07-26 01:20:00	2014-07-26 01:29:00
7930	2014-07-26 01:30:00	2014-07-26 01:39:00
7931	2014-07-26 01:40:00	2014-07-26 01:49:00
7932	2014-07-26 01:50:00	2014-07-26 01:59:00
7933	2014-07-26 02:00:00	2014-07-26 02:09:00
7934	2014-07-26 02:10:00	2014-07-26 02:19:00
7935	2014-07-26 02:20:00	2014-07-26 02:29:00
7936	2014-07-26 02:30:00	2014-07-26 02:39:00
7937	2014-07-26 02:40:00	2014-07-26 02:49:00
7938	2014-07-26 02:50:00	2014-07-26 02:59:00
7939	2014-07-26 03:00:00	2014-07-26 03:09:00
7940	2014-07-26 03:10:00	2014-07-26 03:19:00
7941	2014-07-26 03:20:00	2014-07-26 03:29:00
7942	2014-07-26 03:30:00	2014-07-26 03:39:00
7943	2014-07-26 03:40:00	2014-07-26 03:49:00
7944	2014-07-26 03:50:00	2014-07-26 03:59:00
7945	2014-07-26 04:00:00	2014-07-26 04:09:00
7946	2014-07-26 04:10:00	2014-07-26 04:19:00
7947	2014-07-26 04:20:00	2014-07-26 04:29:00
7948	2014-07-26 04:30:00	2014-07-26 04:39:00
7949	2014-07-26 04:40:00	2014-07-26 04:49:00
7950	2014-07-26 04:50:00	2014-07-26 04:59:00
7951	2014-07-26 05:00:00	2014-07-26 05:09:00
7952	2014-07-26 05:10:00	2014-07-26 05:19:00
7953	2014-07-26 05:20:00	2014-07-26 05:29:00
7954	2014-07-26 05:30:00	2014-07-26 05:39:00
7955	2014-07-26 05:40:00	2014-07-26 05:49:00
7956	2014-07-26 05:50:00	2014-07-26 05:59:00
7957	2014-07-26 06:00:00	2014-07-26 06:09:00
7958	2014-07-26 06:10:00	2014-07-26 06:19:00
7959	2014-07-26 06:20:00	2014-07-26 06:29:00
7960	2014-07-26 06:30:00	2014-07-26 06:39:00
7961	2014-07-26 06:40:00	2014-07-26 06:49:00
7962	2014-07-26 06:50:00	2014-07-26 06:59:00
7963	2014-07-26 07:00:00	2014-07-26 07:09:00
7964	2014-07-26 07:10:00	2014-07-26 07:19:00
7965	2014-07-26 07:20:00	2014-07-26 07:29:00
7966	2014-07-26 07:30:00	2014-07-26 07:39:00
7967	2014-07-26 07:40:00	2014-07-26 07:49:00
7968	2014-07-26 07:50:00	2014-07-26 07:59:00
7969	2014-07-26 08:00:00	2014-07-26 08:09:00
7970	2014-07-26 08:10:00	2014-07-26 08:19:00
7971	2014-07-26 08:20:00	2014-07-26 08:29:00
7972	2014-07-26 08:30:00	2014-07-26 08:39:00
7973	2014-07-26 08:40:00	2014-07-26 08:49:00
7974	2014-07-26 08:50:00	2014-07-26 08:59:00
7975	2014-07-26 09:00:00	2014-07-26 09:09:00
7976	2014-07-26 09:10:00	2014-07-26 09:19:00
7977	2014-07-26 09:20:00	2014-07-26 09:29:00
7978	2014-07-26 09:30:00	2014-07-26 09:39:00
7979	2014-07-26 09:40:00	2014-07-26 09:49:00
7980	2014-07-26 09:50:00	2014-07-26 09:59:00
7981	2014-07-26 10:00:00	2014-07-26 10:09:00
7982	2014-07-26 10:10:00	2014-07-26 10:19:00
7983	2014-07-26 10:20:00	2014-07-26 10:29:00
7984	2014-07-26 10:30:00	2014-07-26 10:39:00
7985	2014-07-26 10:40:00	2014-07-26 10:49:00
7986	2014-07-26 10:50:00	2014-07-26 10:59:00
7987	2014-07-26 11:00:00	2014-07-26 11:09:00
7988	2014-07-26 11:10:00	2014-07-26 11:19:00
7989	2014-07-26 11:20:00	2014-07-26 11:29:00
7990	2014-07-26 11:30:00	2014-07-26 11:39:00
7991	2014-07-26 11:40:00	2014-07-26 11:49:00
7992	2014-07-26 11:50:00	2014-07-26 11:59:00
7993	2014-07-26 12:00:00	2014-07-26 12:09:00
7994	2014-07-26 12:10:00	2014-07-26 12:19:00
7995	2014-07-26 12:20:00	2014-07-26 12:29:00
7996	2014-07-26 12:30:00	2014-07-26 12:39:00
7997	2014-07-26 12:40:00	2014-07-26 12:49:00
7998	2014-07-26 12:50:00	2014-07-26 12:59:00
7999	2014-07-26 13:00:00	2014-07-26 13:09:00
8000	2014-07-26 13:10:00	2014-07-26 13:19:00
8001	2014-07-26 13:20:00	2014-07-26 13:29:00
8002	2014-07-26 13:30:00	2014-07-26 13:39:00
8003	2014-07-26 13:40:00	2014-07-26 13:49:00
8004	2014-07-26 13:50:00	2014-07-26 13:59:00
8005	2014-07-26 14:00:00	2014-07-26 14:09:00
8006	2014-07-26 14:10:00	2014-07-26 14:19:00
8007	2014-07-26 14:20:00	2014-07-26 14:29:00
8008	2014-07-26 14:30:00	2014-07-26 14:39:00
8009	2014-07-26 14:40:00	2014-07-26 14:49:00
8010	2014-07-26 14:50:00	2014-07-26 14:59:00
8011	2014-07-26 15:00:00	2014-07-26 15:09:00
8012	2014-07-26 15:10:00	2014-07-26 15:19:00
8013	2014-07-26 15:20:00	2014-07-26 15:29:00
8014	2014-07-26 15:30:00	2014-07-26 15:39:00
8015	2014-07-26 15:40:00	2014-07-26 15:49:00
8016	2014-07-26 15:50:00	2014-07-26 15:59:00
8017	2014-07-26 16:00:00	2014-07-26 16:09:00
8018	2014-07-26 16:10:00	2014-07-26 16:19:00
8019	2014-07-26 16:20:00	2014-07-26 16:29:00
8020	2014-07-26 16:30:00	2014-07-26 16:39:00
8021	2014-07-26 16:40:00	2014-07-26 16:49:00
8022	2014-07-26 16:50:00	2014-07-26 16:59:00
8023	2014-07-26 17:00:00	2014-07-26 17:09:00
8024	2014-07-26 17:10:00	2014-07-26 17:19:00
8025	2014-07-26 17:20:00	2014-07-26 17:29:00
8026	2014-07-26 17:30:00	2014-07-26 17:39:00
8027	2014-07-26 17:40:00	2014-07-26 17:49:00
8028	2014-07-26 17:50:00	2014-07-26 17:59:00
8029	2014-07-26 18:00:00	2014-07-26 18:09:00
8030	2014-07-26 18:10:00	2014-07-26 18:19:00
8031	2014-07-26 18:20:00	2014-07-26 18:29:00
8032	2014-07-26 18:30:00	2014-07-26 18:39:00
8033	2014-07-26 18:40:00	2014-07-26 18:49:00
8034	2014-07-26 18:50:00	2014-07-26 18:59:00
8035	2014-07-26 19:00:00	2014-07-26 19:09:00
8036	2014-07-26 19:10:00	2014-07-26 19:19:00
8037	2014-07-26 19:20:00	2014-07-26 19:29:00
8038	2014-07-26 19:30:00	2014-07-26 19:39:00
8039	2014-07-26 19:40:00	2014-07-26 19:49:00
8040	2014-07-26 19:50:00	2014-07-26 19:59:00
8041	2014-07-26 20:00:00	2014-07-26 20:09:00
8042	2014-07-26 20:10:00	2014-07-26 20:19:00
8043	2014-07-26 20:20:00	2014-07-26 20:29:00
8044	2014-07-26 20:30:00	2014-07-26 20:39:00
8045	2014-07-26 20:40:00	2014-07-26 20:49:00
8046	2014-07-26 20:50:00	2014-07-26 20:59:00
8047	2014-07-26 21:00:00	2014-07-26 21:09:00
8048	2014-07-26 21:10:00	2014-07-26 21:19:00
8049	2014-07-26 21:20:00	2014-07-26 21:29:00
8050	2014-07-26 21:30:00	2014-07-26 21:39:00
8051	2014-07-26 21:40:00	2014-07-26 21:49:00
8052	2014-07-26 21:50:00	2014-07-26 21:59:00
8053	2014-07-26 22:00:00	2014-07-26 22:09:00
8054	2014-07-26 22:10:00	2014-07-26 22:19:00
8055	2014-07-26 22:20:00	2014-07-26 22:29:00
8056	2014-07-26 22:30:00	2014-07-26 22:39:00
8057	2014-07-26 22:40:00	2014-07-26 22:49:00
8058	2014-07-26 22:50:00	2014-07-26 22:59:00
8059	2014-07-26 23:00:00	2014-07-26 23:09:00
8060	2014-07-26 23:10:00	2014-07-26 23:19:00
8061	2014-07-26 23:20:00	2014-07-26 23:29:00
8062	2014-07-26 23:30:00	2014-07-26 23:39:00
8063	2014-07-26 23:40:00	2014-07-26 23:49:00
8064	2014-07-26 23:50:00	2014-07-26 23:59:00
8065	2014-07-27 00:00:00	2014-07-27 00:09:00
8066	2014-07-27 00:10:00	2014-07-27 00:19:00
8067	2014-07-27 00:20:00	2014-07-27 00:29:00
8068	2014-07-27 00:30:00	2014-07-27 00:39:00
8069	2014-07-27 00:40:00	2014-07-27 00:49:00
8070	2014-07-27 00:50:00	2014-07-27 00:59:00
8071	2014-07-27 01:00:00	2014-07-27 01:09:00
8072	2014-07-27 01:10:00	2014-07-27 01:19:00
8073	2014-07-27 01:20:00	2014-07-27 01:29:00
8074	2014-07-27 01:30:00	2014-07-27 01:39:00
8075	2014-07-27 01:40:00	2014-07-27 01:49:00
8076	2014-07-27 01:50:00	2014-07-27 01:59:00
8077	2014-07-27 02:00:00	2014-07-27 02:09:00
8078	2014-07-27 02:10:00	2014-07-27 02:19:00
8079	2014-07-27 02:20:00	2014-07-27 02:29:00
8080	2014-07-27 02:30:00	2014-07-27 02:39:00
8081	2014-07-27 02:40:00	2014-07-27 02:49:00
8082	2014-07-27 02:50:00	2014-07-27 02:59:00
8083	2014-07-27 03:00:00	2014-07-27 03:09:00
8084	2014-07-27 03:10:00	2014-07-27 03:19:00
8085	2014-07-27 03:20:00	2014-07-27 03:29:00
8086	2014-07-27 03:30:00	2014-07-27 03:39:00
8087	2014-07-27 03:40:00	2014-07-27 03:49:00
8088	2014-07-27 03:50:00	2014-07-27 03:59:00
8089	2014-07-27 04:00:00	2014-07-27 04:09:00
8090	2014-07-27 04:10:00	2014-07-27 04:19:00
8091	2014-07-27 04:20:00	2014-07-27 04:29:00
8092	2014-07-27 04:30:00	2014-07-27 04:39:00
8093	2014-07-27 04:40:00	2014-07-27 04:49:00
8094	2014-07-27 04:50:00	2014-07-27 04:59:00
8095	2014-07-27 05:00:00	2014-07-27 05:09:00
8096	2014-07-27 05:10:00	2014-07-27 05:19:00
8097	2014-07-27 05:20:00	2014-07-27 05:29:00
8098	2014-07-27 05:30:00	2014-07-27 05:39:00
8099	2014-07-27 05:40:00	2014-07-27 05:49:00
8100	2014-07-27 05:50:00	2014-07-27 05:59:00
8101	2014-07-27 06:00:00	2014-07-27 06:09:00
8102	2014-07-27 06:10:00	2014-07-27 06:19:00
8103	2014-07-27 06:20:00	2014-07-27 06:29:00
8104	2014-07-27 06:30:00	2014-07-27 06:39:00
8105	2014-07-27 06:40:00	2014-07-27 06:49:00
8106	2014-07-27 06:50:00	2014-07-27 06:59:00
8107	2014-07-27 07:00:00	2014-07-27 07:09:00
8108	2014-07-27 07:10:00	2014-07-27 07:19:00
8109	2014-07-27 07:20:00	2014-07-27 07:29:00
8110	2014-07-27 07:30:00	2014-07-27 07:39:00
8111	2014-07-27 07:40:00	2014-07-27 07:49:00
8112	2014-07-27 07:50:00	2014-07-27 07:59:00
8113	2014-07-27 08:00:00	2014-07-27 08:09:00
8114	2014-07-27 08:10:00	2014-07-27 08:19:00
8115	2014-07-27 08:20:00	2014-07-27 08:29:00
8116	2014-07-27 08:30:00	2014-07-27 08:39:00
8117	2014-07-27 08:40:00	2014-07-27 08:49:00
8118	2014-07-27 08:50:00	2014-07-27 08:59:00
8119	2014-07-27 09:00:00	2014-07-27 09:09:00
8120	2014-07-27 09:10:00	2014-07-27 09:19:00
8121	2014-07-27 09:20:00	2014-07-27 09:29:00
8122	2014-07-27 09:30:00	2014-07-27 09:39:00
8123	2014-07-27 09:40:00	2014-07-27 09:49:00
8124	2014-07-27 09:50:00	2014-07-27 09:59:00
8125	2014-07-27 10:00:00	2014-07-27 10:09:00
8126	2014-07-27 10:10:00	2014-07-27 10:19:00
8127	2014-07-27 10:20:00	2014-07-27 10:29:00
8128	2014-07-27 10:30:00	2014-07-27 10:39:00
8129	2014-07-27 10:40:00	2014-07-27 10:49:00
8130	2014-07-27 10:50:00	2014-07-27 10:59:00
8131	2014-07-27 11:00:00	2014-07-27 11:09:00
8132	2014-07-27 11:10:00	2014-07-27 11:19:00
8133	2014-07-27 11:20:00	2014-07-27 11:29:00
8134	2014-07-27 11:30:00	2014-07-27 11:39:00
8135	2014-07-27 11:40:00	2014-07-27 11:49:00
8136	2014-07-27 11:50:00	2014-07-27 11:59:00
8137	2014-07-27 12:00:00	2014-07-27 12:09:00
8138	2014-07-27 12:10:00	2014-07-27 12:19:00
8139	2014-07-27 12:20:00	2014-07-27 12:29:00
8140	2014-07-27 12:30:00	2014-07-27 12:39:00
8141	2014-07-27 12:40:00	2014-07-27 12:49:00
8142	2014-07-27 12:50:00	2014-07-27 12:59:00
8143	2014-07-27 13:00:00	2014-07-27 13:09:00
8144	2014-07-27 13:10:00	2014-07-27 13:19:00
8145	2014-07-27 13:20:00	2014-07-27 13:29:00
8146	2014-07-27 13:30:00	2014-07-27 13:39:00
8147	2014-07-27 13:40:00	2014-07-27 13:49:00
8148	2014-07-27 13:50:00	2014-07-27 13:59:00
8149	2014-07-27 14:00:00	2014-07-27 14:09:00
8150	2014-07-27 14:10:00	2014-07-27 14:19:00
8151	2014-07-27 14:20:00	2014-07-27 14:29:00
8152	2014-07-27 14:30:00	2014-07-27 14:39:00
8153	2014-07-27 14:40:00	2014-07-27 14:49:00
8154	2014-07-27 14:50:00	2014-07-27 14:59:00
8155	2014-07-27 15:00:00	2014-07-27 15:09:00
8156	2014-07-27 15:10:00	2014-07-27 15:19:00
8157	2014-07-27 15:20:00	2014-07-27 15:29:00
8158	2014-07-27 15:30:00	2014-07-27 15:39:00
8159	2014-07-27 15:40:00	2014-07-27 15:49:00
8160	2014-07-27 15:50:00	2014-07-27 15:59:00
8161	2014-07-27 16:00:00	2014-07-27 16:09:00
8162	2014-07-27 16:10:00	2014-07-27 16:19:00
8163	2014-07-27 16:20:00	2014-07-27 16:29:00
8164	2014-07-27 16:30:00	2014-07-27 16:39:00
8165	2014-07-27 16:40:00	2014-07-27 16:49:00
8166	2014-07-27 16:50:00	2014-07-27 16:59:00
8167	2014-07-27 17:00:00	2014-07-27 17:09:00
8168	2014-07-27 17:10:00	2014-07-27 17:19:00
8169	2014-07-27 17:20:00	2014-07-27 17:29:00
8170	2014-07-27 17:30:00	2014-07-27 17:39:00
8171	2014-07-27 17:40:00	2014-07-27 17:49:00
8172	2014-07-27 17:50:00	2014-07-27 17:59:00
8173	2014-07-27 18:00:00	2014-07-27 18:09:00
8174	2014-07-27 18:10:00	2014-07-27 18:19:00
8175	2014-07-27 18:20:00	2014-07-27 18:29:00
8176	2014-07-27 18:30:00	2014-07-27 18:39:00
8177	2014-07-27 18:40:00	2014-07-27 18:49:00
8178	2014-07-27 18:50:00	2014-07-27 18:59:00
8179	2014-07-27 19:00:00	2014-07-27 19:09:00
8180	2014-07-27 19:10:00	2014-07-27 19:19:00
8181	2014-07-27 19:20:00	2014-07-27 19:29:00
8182	2014-07-27 19:30:00	2014-07-27 19:39:00
8183	2014-07-27 19:40:00	2014-07-27 19:49:00
8184	2014-07-27 19:50:00	2014-07-27 19:59:00
8185	2014-07-27 20:00:00	2014-07-27 20:09:00
8186	2014-07-27 20:10:00	2014-07-27 20:19:00
8187	2014-07-27 20:20:00	2014-07-27 20:29:00
8188	2014-07-27 20:30:00	2014-07-27 20:39:00
8189	2014-07-27 20:40:00	2014-07-27 20:49:00
8190	2014-07-27 20:50:00	2014-07-27 20:59:00
8191	2014-07-27 21:00:00	2014-07-27 21:09:00
8192	2014-07-27 21:10:00	2014-07-27 21:19:00
8193	2014-07-27 21:20:00	2014-07-27 21:29:00
8194	2014-07-27 21:30:00	2014-07-27 21:39:00
8195	2014-07-27 21:40:00	2014-07-27 21:49:00
8196	2014-07-27 21:50:00	2014-07-27 21:59:00
8197	2014-07-27 22:00:00	2014-07-27 22:09:00
8198	2014-07-27 22:10:00	2014-07-27 22:19:00
8199	2014-07-27 22:20:00	2014-07-27 22:29:00
8200	2014-07-27 22:30:00	2014-07-27 22:39:00
8201	2014-07-27 22:40:00	2014-07-27 22:49:00
8202	2014-07-27 22:50:00	2014-07-27 22:59:00
8203	2014-07-27 23:00:00	2014-07-27 23:09:00
8204	2014-07-27 23:10:00	2014-07-27 23:19:00
8205	2014-07-27 23:20:00	2014-07-27 23:29:00
8206	2014-07-27 23:30:00	2014-07-27 23:39:00
8207	2014-07-27 23:40:00	2014-07-27 23:49:00
8208	2014-07-27 23:50:00	2014-07-27 23:59:00
8209	2014-07-28 00:00:00	2014-07-28 00:09:00
8210	2014-07-28 00:10:00	2014-07-28 00:19:00
8211	2014-07-28 00:20:00	2014-07-28 00:29:00
8212	2014-07-28 00:30:00	2014-07-28 00:39:00
8213	2014-07-28 00:40:00	2014-07-28 00:49:00
8214	2014-07-28 00:50:00	2014-07-28 00:59:00
8215	2014-07-28 01:00:00	2014-07-28 01:09:00
8216	2014-07-28 01:10:00	2014-07-28 01:19:00
8217	2014-07-28 01:20:00	2014-07-28 01:29:00
8218	2014-07-28 01:30:00	2014-07-28 01:39:00
8219	2014-07-28 01:40:00	2014-07-28 01:49:00
8220	2014-07-28 01:50:00	2014-07-28 01:59:00
8221	2014-07-28 02:00:00	2014-07-28 02:09:00
8222	2014-07-28 02:10:00	2014-07-28 02:19:00
8223	2014-07-28 02:20:00	2014-07-28 02:29:00
8224	2014-07-28 02:30:00	2014-07-28 02:39:00
8225	2014-07-28 02:40:00	2014-07-28 02:49:00
8226	2014-07-28 02:50:00	2014-07-28 02:59:00
8227	2014-07-28 03:00:00	2014-07-28 03:09:00
8228	2014-07-28 03:10:00	2014-07-28 03:19:00
8229	2014-07-28 03:20:00	2014-07-28 03:29:00
8230	2014-07-28 03:30:00	2014-07-28 03:39:00
8231	2014-07-28 03:40:00	2014-07-28 03:49:00
8232	2014-07-28 03:50:00	2014-07-28 03:59:00
8233	2014-07-28 04:00:00	2014-07-28 04:09:00
8234	2014-07-28 04:10:00	2014-07-28 04:19:00
8235	2014-07-28 04:20:00	2014-07-28 04:29:00
8236	2014-07-28 04:30:00	2014-07-28 04:39:00
8237	2014-07-28 04:40:00	2014-07-28 04:49:00
8238	2014-07-28 04:50:00	2014-07-28 04:59:00
8239	2014-07-28 05:00:00	2014-07-28 05:09:00
8240	2014-07-28 05:10:00	2014-07-28 05:19:00
8241	2014-07-28 05:20:00	2014-07-28 05:29:00
8242	2014-07-28 05:30:00	2014-07-28 05:39:00
8243	2014-07-28 05:40:00	2014-07-28 05:49:00
8244	2014-07-28 05:50:00	2014-07-28 05:59:00
8245	2014-07-28 06:00:00	2014-07-28 06:09:00
8246	2014-07-28 06:10:00	2014-07-28 06:19:00
8247	2014-07-28 06:20:00	2014-07-28 06:29:00
8248	2014-07-28 06:30:00	2014-07-28 06:39:00
8249	2014-07-28 06:40:00	2014-07-28 06:49:00
8250	2014-07-28 06:50:00	2014-07-28 06:59:00
8251	2014-07-28 07:00:00	2014-07-28 07:09:00
8252	2014-07-28 07:10:00	2014-07-28 07:19:00
8253	2014-07-28 07:20:00	2014-07-28 07:29:00
8254	2014-07-28 07:30:00	2014-07-28 07:39:00
8255	2014-07-28 07:40:00	2014-07-28 07:49:00
8256	2014-07-28 07:50:00	2014-07-28 07:59:00
8257	2014-07-28 08:00:00	2014-07-28 08:09:00
8258	2014-07-28 08:10:00	2014-07-28 08:19:00
8259	2014-07-28 08:20:00	2014-07-28 08:29:00
8260	2014-07-28 08:30:00	2014-07-28 08:39:00
8261	2014-07-28 08:40:00	2014-07-28 08:49:00
8262	2014-07-28 08:50:00	2014-07-28 08:59:00
8263	2014-07-28 09:00:00	2014-07-28 09:09:00
8264	2014-07-28 09:10:00	2014-07-28 09:19:00
8265	2014-07-28 09:20:00	2014-07-28 09:29:00
8266	2014-07-28 09:30:00	2014-07-28 09:39:00
8267	2014-07-28 09:40:00	2014-07-28 09:49:00
8268	2014-07-28 09:50:00	2014-07-28 09:59:00
8269	2014-07-28 10:00:00	2014-07-28 10:09:00
8270	2014-07-28 10:10:00	2014-07-28 10:19:00
8271	2014-07-28 10:20:00	2014-07-28 10:29:00
8272	2014-07-28 10:30:00	2014-07-28 10:39:00
8273	2014-07-28 10:40:00	2014-07-28 10:49:00
8274	2014-07-28 10:50:00	2014-07-28 10:59:00
8275	2014-07-28 11:00:00	2014-07-28 11:09:00
8276	2014-07-28 11:10:00	2014-07-28 11:19:00
8277	2014-07-28 11:20:00	2014-07-28 11:29:00
8278	2014-07-28 11:30:00	2014-07-28 11:39:00
8279	2014-07-28 11:40:00	2014-07-28 11:49:00
8280	2014-07-28 11:50:00	2014-07-28 11:59:00
8281	2014-07-28 12:00:00	2014-07-28 12:09:00
8282	2014-07-28 12:10:00	2014-07-28 12:19:00
8283	2014-07-28 12:20:00	2014-07-28 12:29:00
8284	2014-07-28 12:30:00	2014-07-28 12:39:00
8285	2014-07-28 12:40:00	2014-07-28 12:49:00
8286	2014-07-28 12:50:00	2014-07-28 12:59:00
8287	2014-07-28 13:00:00	2014-07-28 13:09:00
8288	2014-07-28 13:10:00	2014-07-28 13:19:00
8289	2014-07-28 13:20:00	2014-07-28 13:29:00
8290	2014-07-28 13:30:00	2014-07-28 13:39:00
8291	2014-07-28 13:40:00	2014-07-28 13:49:00
8292	2014-07-28 13:50:00	2014-07-28 13:59:00
8293	2014-07-28 14:00:00	2014-07-28 14:09:00
8294	2014-07-28 14:10:00	2014-07-28 14:19:00
8295	2014-07-28 14:20:00	2014-07-28 14:29:00
8296	2014-07-28 14:30:00	2014-07-28 14:39:00
8297	2014-07-28 14:40:00	2014-07-28 14:49:00
8298	2014-07-28 14:50:00	2014-07-28 14:59:00
8299	2014-07-28 15:00:00	2014-07-28 15:09:00
8300	2014-07-28 15:10:00	2014-07-28 15:19:00
8301	2014-07-28 15:20:00	2014-07-28 15:29:00
8302	2014-07-28 15:30:00	2014-07-28 15:39:00
8303	2014-07-28 15:40:00	2014-07-28 15:49:00
8304	2014-07-28 15:50:00	2014-07-28 15:59:00
8305	2014-07-28 16:00:00	2014-07-28 16:09:00
8306	2014-07-28 16:10:00	2014-07-28 16:19:00
8307	2014-07-28 16:20:00	2014-07-28 16:29:00
8308	2014-07-28 16:30:00	2014-07-28 16:39:00
8309	2014-07-28 16:40:00	2014-07-28 16:49:00
8310	2014-07-28 16:50:00	2014-07-28 16:59:00
8311	2014-07-28 17:00:00	2014-07-28 17:09:00
8312	2014-07-28 17:10:00	2014-07-28 17:19:00
8313	2014-07-28 17:20:00	2014-07-28 17:29:00
8314	2014-07-28 17:30:00	2014-07-28 17:39:00
8315	2014-07-28 17:40:00	2014-07-28 17:49:00
8316	2014-07-28 17:50:00	2014-07-28 17:59:00
8317	2014-07-28 18:00:00	2014-07-28 18:09:00
8318	2014-07-28 18:10:00	2014-07-28 18:19:00
8319	2014-07-28 18:20:00	2014-07-28 18:29:00
8320	2014-07-28 18:30:00	2014-07-28 18:39:00
8321	2014-07-28 18:40:00	2014-07-28 18:49:00
8322	2014-07-28 18:50:00	2014-07-28 18:59:00
8323	2014-07-28 19:00:00	2014-07-28 19:09:00
8324	2014-07-28 19:10:00	2014-07-28 19:19:00
8325	2014-07-28 19:20:00	2014-07-28 19:29:00
8326	2014-07-28 19:30:00	2014-07-28 19:39:00
8327	2014-07-28 19:40:00	2014-07-28 19:49:00
8328	2014-07-28 19:50:00	2014-07-28 19:59:00
8329	2014-07-28 20:00:00	2014-07-28 20:09:00
8330	2014-07-28 20:10:00	2014-07-28 20:19:00
8331	2014-07-28 20:20:00	2014-07-28 20:29:00
8332	2014-07-28 20:30:00	2014-07-28 20:39:00
8333	2014-07-28 20:40:00	2014-07-28 20:49:00
8334	2014-07-28 20:50:00	2014-07-28 20:59:00
8335	2014-07-28 21:00:00	2014-07-28 21:09:00
8336	2014-07-28 21:10:00	2014-07-28 21:19:00
8337	2014-07-28 21:20:00	2014-07-28 21:29:00
8338	2014-07-28 21:30:00	2014-07-28 21:39:00
8339	2014-07-28 21:40:00	2014-07-28 21:49:00
8340	2014-07-28 21:50:00	2014-07-28 21:59:00
8341	2014-07-28 22:00:00	2014-07-28 22:09:00
8342	2014-07-28 22:10:00	2014-07-28 22:19:00
8343	2014-07-28 22:20:00	2014-07-28 22:29:00
8344	2014-07-28 22:30:00	2014-07-28 22:39:00
8345	2014-07-28 22:40:00	2014-07-28 22:49:00
8346	2014-07-28 22:50:00	2014-07-28 22:59:00
8347	2014-07-28 23:00:00	2014-07-28 23:09:00
8348	2014-07-28 23:10:00	2014-07-28 23:19:00
8349	2014-07-28 23:20:00	2014-07-28 23:29:00
8350	2014-07-28 23:30:00	2014-07-28 23:39:00
8351	2014-07-28 23:40:00	2014-07-28 23:49:00
8352	2014-07-28 23:50:00	2014-07-28 23:59:00
8353	2014-07-29 00:00:00	2014-07-29 00:09:00
8354	2014-07-29 00:10:00	2014-07-29 00:19:00
8355	2014-07-29 00:20:00	2014-07-29 00:29:00
8356	2014-07-29 00:30:00	2014-07-29 00:39:00
8357	2014-07-29 00:40:00	2014-07-29 00:49:00
8358	2014-07-29 00:50:00	2014-07-29 00:59:00
8359	2014-07-29 01:00:00	2014-07-29 01:09:00
8360	2014-07-29 01:10:00	2014-07-29 01:19:00
8361	2014-07-29 01:20:00	2014-07-29 01:29:00
8362	2014-07-29 01:30:00	2014-07-29 01:39:00
8363	2014-07-29 01:40:00	2014-07-29 01:49:00
8364	2014-07-29 01:50:00	2014-07-29 01:59:00
8365	2014-07-29 02:00:00	2014-07-29 02:09:00
8366	2014-07-29 02:10:00	2014-07-29 02:19:00
8367	2014-07-29 02:20:00	2014-07-29 02:29:00
8368	2014-07-29 02:30:00	2014-07-29 02:39:00
8369	2014-07-29 02:40:00	2014-07-29 02:49:00
8370	2014-07-29 02:50:00	2014-07-29 02:59:00
8371	2014-07-29 03:00:00	2014-07-29 03:09:00
8372	2014-07-29 03:10:00	2014-07-29 03:19:00
8373	2014-07-29 03:20:00	2014-07-29 03:29:00
8374	2014-07-29 03:30:00	2014-07-29 03:39:00
8375	2014-07-29 03:40:00	2014-07-29 03:49:00
8376	2014-07-29 03:50:00	2014-07-29 03:59:00
8377	2014-07-29 04:00:00	2014-07-29 04:09:00
8378	2014-07-29 04:10:00	2014-07-29 04:19:00
8379	2014-07-29 04:20:00	2014-07-29 04:29:00
8380	2014-07-29 04:30:00	2014-07-29 04:39:00
8381	2014-07-29 04:40:00	2014-07-29 04:49:00
8382	2014-07-29 04:50:00	2014-07-29 04:59:00
8383	2014-07-29 05:00:00	2014-07-29 05:09:00
8384	2014-07-29 05:10:00	2014-07-29 05:19:00
8385	2014-07-29 05:20:00	2014-07-29 05:29:00
8386	2014-07-29 05:30:00	2014-07-29 05:39:00
8387	2014-07-29 05:40:00	2014-07-29 05:49:00
8388	2014-07-29 05:50:00	2014-07-29 05:59:00
8389	2014-07-29 06:00:00	2014-07-29 06:09:00
8390	2014-07-29 06:10:00	2014-07-29 06:19:00
8391	2014-07-29 06:20:00	2014-07-29 06:29:00
8392	2014-07-29 06:30:00	2014-07-29 06:39:00
8393	2014-07-29 06:40:00	2014-07-29 06:49:00
8394	2014-07-29 06:50:00	2014-07-29 06:59:00
8395	2014-07-29 07:00:00	2014-07-29 07:09:00
8396	2014-07-29 07:10:00	2014-07-29 07:19:00
8397	2014-07-29 07:20:00	2014-07-29 07:29:00
8398	2014-07-29 07:30:00	2014-07-29 07:39:00
8399	2014-07-29 07:40:00	2014-07-29 07:49:00
8400	2014-07-29 07:50:00	2014-07-29 07:59:00
8401	2014-07-29 08:00:00	2014-07-29 08:09:00
8402	2014-07-29 08:10:00	2014-07-29 08:19:00
8403	2014-07-29 08:20:00	2014-07-29 08:29:00
8404	2014-07-29 08:30:00	2014-07-29 08:39:00
8405	2014-07-29 08:40:00	2014-07-29 08:49:00
8406	2014-07-29 08:50:00	2014-07-29 08:59:00
8407	2014-07-29 09:00:00	2014-07-29 09:09:00
8408	2014-07-29 09:10:00	2014-07-29 09:19:00
8409	2014-07-29 09:20:00	2014-07-29 09:29:00
8410	2014-07-29 09:30:00	2014-07-29 09:39:00
8411	2014-07-29 09:40:00	2014-07-29 09:49:00
8412	2014-07-29 09:50:00	2014-07-29 09:59:00
8413	2014-07-29 10:00:00	2014-07-29 10:09:00
8414	2014-07-29 10:10:00	2014-07-29 10:19:00
8415	2014-07-29 10:20:00	2014-07-29 10:29:00
8416	2014-07-29 10:30:00	2014-07-29 10:39:00
8417	2014-07-29 10:40:00	2014-07-29 10:49:00
8418	2014-07-29 10:50:00	2014-07-29 10:59:00
8419	2014-07-29 11:00:00	2014-07-29 11:09:00
8420	2014-07-29 11:10:00	2014-07-29 11:19:00
8421	2014-07-29 11:20:00	2014-07-29 11:29:00
8422	2014-07-29 11:30:00	2014-07-29 11:39:00
8423	2014-07-29 11:40:00	2014-07-29 11:49:00
8424	2014-07-29 11:50:00	2014-07-29 11:59:00
8425	2014-07-29 12:00:00	2014-07-29 12:09:00
8426	2014-07-29 12:10:00	2014-07-29 12:19:00
8427	2014-07-29 12:20:00	2014-07-29 12:29:00
8428	2014-07-29 12:30:00	2014-07-29 12:39:00
8429	2014-07-29 12:40:00	2014-07-29 12:49:00
8430	2014-07-29 12:50:00	2014-07-29 12:59:00
8431	2014-07-29 13:00:00	2014-07-29 13:09:00
8432	2014-07-29 13:10:00	2014-07-29 13:19:00
8433	2014-07-29 13:20:00	2014-07-29 13:29:00
8434	2014-07-29 13:30:00	2014-07-29 13:39:00
8435	2014-07-29 13:40:00	2014-07-29 13:49:00
8436	2014-07-29 13:50:00	2014-07-29 13:59:00
8437	2014-07-29 14:00:00	2014-07-29 14:09:00
8438	2014-07-29 14:10:00	2014-07-29 14:19:00
8439	2014-07-29 14:20:00	2014-07-29 14:29:00
8440	2014-07-29 14:30:00	2014-07-29 14:39:00
8441	2014-07-29 14:40:00	2014-07-29 14:49:00
8442	2014-07-29 14:50:00	2014-07-29 14:59:00
8443	2014-07-29 15:00:00	2014-07-29 15:09:00
8444	2014-07-29 15:10:00	2014-07-29 15:19:00
8445	2014-07-29 15:20:00	2014-07-29 15:29:00
8446	2014-07-29 15:30:00	2014-07-29 15:39:00
8447	2014-07-29 15:40:00	2014-07-29 15:49:00
8448	2014-07-29 15:50:00	2014-07-29 15:59:00
8449	2014-07-29 16:00:00	2014-07-29 16:09:00
8450	2014-07-29 16:10:00	2014-07-29 16:19:00
8451	2014-07-29 16:20:00	2014-07-29 16:29:00
8452	2014-07-29 16:30:00	2014-07-29 16:39:00
8453	2014-07-29 16:40:00	2014-07-29 16:49:00
8454	2014-07-29 16:50:00	2014-07-29 16:59:00
8455	2014-07-29 17:00:00	2014-07-29 17:09:00
8456	2014-07-29 17:10:00	2014-07-29 17:19:00
8457	2014-07-29 17:20:00	2014-07-29 17:29:00
8458	2014-07-29 17:30:00	2014-07-29 17:39:00
8459	2014-07-29 17:40:00	2014-07-29 17:49:00
8460	2014-07-29 17:50:00	2014-07-29 17:59:00
8461	2014-07-29 18:00:00	2014-07-29 18:09:00
8462	2014-07-29 18:10:00	2014-07-29 18:19:00
8463	2014-07-29 18:20:00	2014-07-29 18:29:00
8464	2014-07-29 18:30:00	2014-07-29 18:39:00
8465	2014-07-29 18:40:00	2014-07-29 18:49:00
8466	2014-07-29 18:50:00	2014-07-29 18:59:00
8467	2014-07-29 19:00:00	2014-07-29 19:09:00
8468	2014-07-29 19:10:00	2014-07-29 19:19:00
8469	2014-07-29 19:20:00	2014-07-29 19:29:00
8470	2014-07-29 19:30:00	2014-07-29 19:39:00
8471	2014-07-29 19:40:00	2014-07-29 19:49:00
8472	2014-07-29 19:50:00	2014-07-29 19:59:00
8473	2014-07-29 20:00:00	2014-07-29 20:09:00
8474	2014-07-29 20:10:00	2014-07-29 20:19:00
8475	2014-07-29 20:20:00	2014-07-29 20:29:00
8476	2014-07-29 20:30:00	2014-07-29 20:39:00
8477	2014-07-29 20:40:00	2014-07-29 20:49:00
8478	2014-07-29 20:50:00	2014-07-29 20:59:00
8479	2014-07-29 21:00:00	2014-07-29 21:09:00
8480	2014-07-29 21:10:00	2014-07-29 21:19:00
8481	2014-07-29 21:20:00	2014-07-29 21:29:00
8482	2014-07-29 21:30:00	2014-07-29 21:39:00
8483	2014-07-29 21:40:00	2014-07-29 21:49:00
8484	2014-07-29 21:50:00	2014-07-29 21:59:00
8485	2014-07-29 22:00:00	2014-07-29 22:09:00
8486	2014-07-29 22:10:00	2014-07-29 22:19:00
8487	2014-07-29 22:20:00	2014-07-29 22:29:00
8488	2014-07-29 22:30:00	2014-07-29 22:39:00
8489	2014-07-29 22:40:00	2014-07-29 22:49:00
8490	2014-07-29 22:50:00	2014-07-29 22:59:00
8491	2014-07-29 23:00:00	2014-07-29 23:09:00
8492	2014-07-29 23:10:00	2014-07-29 23:19:00
8493	2014-07-29 23:20:00	2014-07-29 23:29:00
8494	2014-07-29 23:30:00	2014-07-29 23:39:00
8495	2014-07-29 23:40:00	2014-07-29 23:49:00
8496	2014-07-29 23:50:00	2014-07-29 23:59:00
8497	2014-07-30 00:00:00	2014-07-30 00:09:00
8498	2014-07-30 00:10:00	2014-07-30 00:19:00
8499	2014-07-30 00:20:00	2014-07-30 00:29:00
8500	2014-07-30 00:30:00	2014-07-30 00:39:00
8501	2014-07-30 00:40:00	2014-07-30 00:49:00
8502	2014-07-30 00:50:00	2014-07-30 00:59:00
8503	2014-07-30 01:00:00	2014-07-30 01:09:00
8504	2014-07-30 01:10:00	2014-07-30 01:19:00
8505	2014-07-30 01:20:00	2014-07-30 01:29:00
8506	2014-07-30 01:30:00	2014-07-30 01:39:00
8507	2014-07-30 01:40:00	2014-07-30 01:49:00
8508	2014-07-30 01:50:00	2014-07-30 01:59:00
8509	2014-07-30 02:00:00	2014-07-30 02:09:00
8510	2014-07-30 02:10:00	2014-07-30 02:19:00
8511	2014-07-30 02:20:00	2014-07-30 02:29:00
8512	2014-07-30 02:30:00	2014-07-30 02:39:00
8513	2014-07-30 02:40:00	2014-07-30 02:49:00
8514	2014-07-30 02:50:00	2014-07-30 02:59:00
8515	2014-07-30 03:00:00	2014-07-30 03:09:00
8516	2014-07-30 03:10:00	2014-07-30 03:19:00
8517	2014-07-30 03:20:00	2014-07-30 03:29:00
8518	2014-07-30 03:30:00	2014-07-30 03:39:00
8519	2014-07-30 03:40:00	2014-07-30 03:49:00
8520	2014-07-30 03:50:00	2014-07-30 03:59:00
8521	2014-07-30 04:00:00	2014-07-30 04:09:00
8522	2014-07-30 04:10:00	2014-07-30 04:19:00
8523	2014-07-30 04:20:00	2014-07-30 04:29:00
8524	2014-07-30 04:30:00	2014-07-30 04:39:00
8525	2014-07-30 04:40:00	2014-07-30 04:49:00
8526	2014-07-30 04:50:00	2014-07-30 04:59:00
8527	2014-07-30 05:00:00	2014-07-30 05:09:00
8528	2014-07-30 05:10:00	2014-07-30 05:19:00
8529	2014-07-30 05:20:00	2014-07-30 05:29:00
8530	2014-07-30 05:30:00	2014-07-30 05:39:00
8531	2014-07-30 05:40:00	2014-07-30 05:49:00
8532	2014-07-30 05:50:00	2014-07-30 05:59:00
8533	2014-07-30 06:00:00	2014-07-30 06:09:00
8534	2014-07-30 06:10:00	2014-07-30 06:19:00
8535	2014-07-30 06:20:00	2014-07-30 06:29:00
8536	2014-07-30 06:30:00	2014-07-30 06:39:00
8537	2014-07-30 06:40:00	2014-07-30 06:49:00
8538	2014-07-30 06:50:00	2014-07-30 06:59:00
8539	2014-07-30 07:00:00	2014-07-30 07:09:00
8540	2014-07-30 07:10:00	2014-07-30 07:19:00
8541	2014-07-30 07:20:00	2014-07-30 07:29:00
8542	2014-07-30 07:30:00	2014-07-30 07:39:00
8543	2014-07-30 07:40:00	2014-07-30 07:49:00
8544	2014-07-30 07:50:00	2014-07-30 07:59:00
8545	2014-07-30 08:00:00	2014-07-30 08:09:00
8546	2014-07-30 08:10:00	2014-07-30 08:19:00
8547	2014-07-30 08:20:00	2014-07-30 08:29:00
8548	2014-07-30 08:30:00	2014-07-30 08:39:00
8549	2014-07-30 08:40:00	2014-07-30 08:49:00
8550	2014-07-30 08:50:00	2014-07-30 08:59:00
8551	2014-07-30 09:00:00	2014-07-30 09:09:00
8552	2014-07-30 09:10:00	2014-07-30 09:19:00
8553	2014-07-30 09:20:00	2014-07-30 09:29:00
8554	2014-07-30 09:30:00	2014-07-30 09:39:00
8555	2014-07-30 09:40:00	2014-07-30 09:49:00
8556	2014-07-30 09:50:00	2014-07-30 09:59:00
8557	2014-07-30 10:00:00	2014-07-30 10:09:00
8558	2014-07-30 10:10:00	2014-07-30 10:19:00
8559	2014-07-30 10:20:00	2014-07-30 10:29:00
8560	2014-07-30 10:30:00	2014-07-30 10:39:00
8561	2014-07-30 10:40:00	2014-07-30 10:49:00
8562	2014-07-30 10:50:00	2014-07-30 10:59:00
8563	2014-07-30 11:00:00	2014-07-30 11:09:00
8564	2014-07-30 11:10:00	2014-07-30 11:19:00
8565	2014-07-30 11:20:00	2014-07-30 11:29:00
8566	2014-07-30 11:30:00	2014-07-30 11:39:00
8567	2014-07-30 11:40:00	2014-07-30 11:49:00
8568	2014-07-30 11:50:00	2014-07-30 11:59:00
8569	2014-07-30 12:00:00	2014-07-30 12:09:00
8570	2014-07-30 12:10:00	2014-07-30 12:19:00
8571	2014-07-30 12:20:00	2014-07-30 12:29:00
8572	2014-07-30 12:30:00	2014-07-30 12:39:00
8573	2014-07-30 12:40:00	2014-07-30 12:49:00
8574	2014-07-30 12:50:00	2014-07-30 12:59:00
8575	2014-07-30 13:00:00	2014-07-30 13:09:00
8576	2014-07-30 13:10:00	2014-07-30 13:19:00
8577	2014-07-30 13:20:00	2014-07-30 13:29:00
8578	2014-07-30 13:30:00	2014-07-30 13:39:00
8579	2014-07-30 13:40:00	2014-07-30 13:49:00
8580	2014-07-30 13:50:00	2014-07-30 13:59:00
8581	2014-07-30 14:00:00	2014-07-30 14:09:00
8582	2014-07-30 14:10:00	2014-07-30 14:19:00
8583	2014-07-30 14:20:00	2014-07-30 14:29:00
8584	2014-07-30 14:30:00	2014-07-30 14:39:00
8585	2014-07-30 14:40:00	2014-07-30 14:49:00
8586	2014-07-30 14:50:00	2014-07-30 14:59:00
8587	2014-07-30 15:00:00	2014-07-30 15:09:00
8588	2014-07-30 15:10:00	2014-07-30 15:19:00
8589	2014-07-30 15:20:00	2014-07-30 15:29:00
8590	2014-07-30 15:30:00	2014-07-30 15:39:00
8591	2014-07-30 15:40:00	2014-07-30 15:49:00
8592	2014-07-30 15:50:00	2014-07-30 15:59:00
8593	2014-07-30 16:00:00	2014-07-30 16:09:00
8594	2014-07-30 16:10:00	2014-07-30 16:19:00
8595	2014-07-30 16:20:00	2014-07-30 16:29:00
8596	2014-07-30 16:30:00	2014-07-30 16:39:00
8597	2014-07-30 16:40:00	2014-07-30 16:49:00
8598	2014-07-30 16:50:00	2014-07-30 16:59:00
8599	2014-07-30 17:00:00	2014-07-30 17:09:00
8600	2014-07-30 17:10:00	2014-07-30 17:19:00
8601	2014-07-30 17:20:00	2014-07-30 17:29:00
8602	2014-07-30 17:30:00	2014-07-30 17:39:00
8603	2014-07-30 17:40:00	2014-07-30 17:49:00
8604	2014-07-30 17:50:00	2014-07-30 17:59:00
8605	2014-07-30 18:00:00	2014-07-30 18:09:00
8606	2014-07-30 18:10:00	2014-07-30 18:19:00
8607	2014-07-30 18:20:00	2014-07-30 18:29:00
8608	2014-07-30 18:30:00	2014-07-30 18:39:00
8609	2014-07-30 18:40:00	2014-07-30 18:49:00
8610	2014-07-30 18:50:00	2014-07-30 18:59:00
8611	2014-07-30 19:00:00	2014-07-30 19:09:00
8612	2014-07-30 19:10:00	2014-07-30 19:19:00
8613	2014-07-30 19:20:00	2014-07-30 19:29:00
8614	2014-07-30 19:30:00	2014-07-30 19:39:00
8615	2014-07-30 19:40:00	2014-07-30 19:49:00
8616	2014-07-30 19:50:00	2014-07-30 19:59:00
8617	2014-07-30 20:00:00	2014-07-30 20:09:00
8618	2014-07-30 20:10:00	2014-07-30 20:19:00
8619	2014-07-30 20:20:00	2014-07-30 20:29:00
8620	2014-07-30 20:30:00	2014-07-30 20:39:00
8621	2014-07-30 20:40:00	2014-07-30 20:49:00
8622	2014-07-30 20:50:00	2014-07-30 20:59:00
8623	2014-07-30 21:00:00	2014-07-30 21:09:00
8624	2014-07-30 21:10:00	2014-07-30 21:19:00
8625	2014-07-30 21:20:00	2014-07-30 21:29:00
8626	2014-07-30 21:30:00	2014-07-30 21:39:00
8627	2014-07-30 21:40:00	2014-07-30 21:49:00
8628	2014-07-30 21:50:00	2014-07-30 21:59:00
8629	2014-07-30 22:00:00	2014-07-30 22:09:00
8630	2014-07-30 22:10:00	2014-07-30 22:19:00
8631	2014-07-30 22:20:00	2014-07-30 22:29:00
8632	2014-07-30 22:30:00	2014-07-30 22:39:00
8633	2014-07-30 22:40:00	2014-07-30 22:49:00
8634	2014-07-30 22:50:00	2014-07-30 22:59:00
8635	2014-07-30 23:00:00	2014-07-30 23:09:00
8636	2014-07-30 23:10:00	2014-07-30 23:19:00
8637	2014-07-30 23:20:00	2014-07-30 23:29:00
8638	2014-07-30 23:30:00	2014-07-30 23:39:00
8639	2014-07-30 23:40:00	2014-07-30 23:49:00
8640	2014-07-30 23:50:00	2014-07-30 23:59:00
8641	2014-07-31 00:00:00	2014-07-31 00:09:00
8642	2014-07-31 00:10:00	2014-07-31 00:19:00
8643	2014-07-31 00:20:00	2014-07-31 00:29:00
8644	2014-07-31 00:30:00	2014-07-31 00:39:00
8645	2014-07-31 00:40:00	2014-07-31 00:49:00
8646	2014-07-31 00:50:00	2014-07-31 00:59:00
8647	2014-07-31 01:00:00	2014-07-31 01:09:00
8648	2014-07-31 01:10:00	2014-07-31 01:19:00
8649	2014-07-31 01:20:00	2014-07-31 01:29:00
8650	2014-07-31 01:30:00	2014-07-31 01:39:00
8651	2014-07-31 01:40:00	2014-07-31 01:49:00
8652	2014-07-31 01:50:00	2014-07-31 01:59:00
8653	2014-07-31 02:00:00	2014-07-31 02:09:00
8654	2014-07-31 02:10:00	2014-07-31 02:19:00
8655	2014-07-31 02:20:00	2014-07-31 02:29:00
8656	2014-07-31 02:30:00	2014-07-31 02:39:00
8657	2014-07-31 02:40:00	2014-07-31 02:49:00
8658	2014-07-31 02:50:00	2014-07-31 02:59:00
8659	2014-07-31 03:00:00	2014-07-31 03:09:00
8660	2014-07-31 03:10:00	2014-07-31 03:19:00
8661	2014-07-31 03:20:00	2014-07-31 03:29:00
8662	2014-07-31 03:30:00	2014-07-31 03:39:00
8663	2014-07-31 03:40:00	2014-07-31 03:49:00
8664	2014-07-31 03:50:00	2014-07-31 03:59:00
8665	2014-07-31 04:00:00	2014-07-31 04:09:00
8666	2014-07-31 04:10:00	2014-07-31 04:19:00
8667	2014-07-31 04:20:00	2014-07-31 04:29:00
8668	2014-07-31 04:30:00	2014-07-31 04:39:00
8669	2014-07-31 04:40:00	2014-07-31 04:49:00
8670	2014-07-31 04:50:00	2014-07-31 04:59:00
8671	2014-07-31 05:00:00	2014-07-31 05:09:00
8672	2014-07-31 05:10:00	2014-07-31 05:19:00
8673	2014-07-31 05:20:00	2014-07-31 05:29:00
8674	2014-07-31 05:30:00	2014-07-31 05:39:00
8675	2014-07-31 05:40:00	2014-07-31 05:49:00
8676	2014-07-31 05:50:00	2014-07-31 05:59:00
8677	2014-07-31 06:00:00	2014-07-31 06:09:00
8678	2014-07-31 06:10:00	2014-07-31 06:19:00
8679	2014-07-31 06:20:00	2014-07-31 06:29:00
8680	2014-07-31 06:30:00	2014-07-31 06:39:00
8681	2014-07-31 06:40:00	2014-07-31 06:49:00
8682	2014-07-31 06:50:00	2014-07-31 06:59:00
8683	2014-07-31 07:00:00	2014-07-31 07:09:00
8684	2014-07-31 07:10:00	2014-07-31 07:19:00
8685	2014-07-31 07:20:00	2014-07-31 07:29:00
8686	2014-07-31 07:30:00	2014-07-31 07:39:00
8687	2014-07-31 07:40:00	2014-07-31 07:49:00
8688	2014-07-31 07:50:00	2014-07-31 07:59:00
8689	2014-07-31 08:00:00	2014-07-31 08:09:00
8690	2014-07-31 08:10:00	2014-07-31 08:19:00
8691	2014-07-31 08:20:00	2014-07-31 08:29:00
8692	2014-07-31 08:30:00	2014-07-31 08:39:00
8693	2014-07-31 08:40:00	2014-07-31 08:49:00
8694	2014-07-31 08:50:00	2014-07-31 08:59:00
8695	2014-07-31 09:00:00	2014-07-31 09:09:00
8696	2014-07-31 09:10:00	2014-07-31 09:19:00
8697	2014-07-31 09:20:00	2014-07-31 09:29:00
8698	2014-07-31 09:30:00	2014-07-31 09:39:00
8699	2014-07-31 09:40:00	2014-07-31 09:49:00
8700	2014-07-31 09:50:00	2014-07-31 09:59:00
8701	2014-07-31 10:00:00	2014-07-31 10:09:00
8702	2014-07-31 10:10:00	2014-07-31 10:19:00
8703	2014-07-31 10:20:00	2014-07-31 10:29:00
8704	2014-07-31 10:30:00	2014-07-31 10:39:00
8705	2014-07-31 10:40:00	2014-07-31 10:49:00
8706	2014-07-31 10:50:00	2014-07-31 10:59:00
8707	2014-07-31 11:00:00	2014-07-31 11:09:00
8708	2014-07-31 11:10:00	2014-07-31 11:19:00
8709	2014-07-31 11:20:00	2014-07-31 11:29:00
8710	2014-07-31 11:30:00	2014-07-31 11:39:00
8711	2014-07-31 11:40:00	2014-07-31 11:49:00
8712	2014-07-31 11:50:00	2014-07-31 11:59:00
8713	2014-07-31 12:00:00	2014-07-31 12:09:00
8714	2014-07-31 12:10:00	2014-07-31 12:19:00
8715	2014-07-31 12:20:00	2014-07-31 12:29:00
8716	2014-07-31 12:30:00	2014-07-31 12:39:00
8717	2014-07-31 12:40:00	2014-07-31 12:49:00
8718	2014-07-31 12:50:00	2014-07-31 12:59:00
8719	2014-07-31 13:00:00	2014-07-31 13:09:00
8720	2014-07-31 13:10:00	2014-07-31 13:19:00
8721	2014-07-31 13:20:00	2014-07-31 13:29:00
8722	2014-07-31 13:30:00	2014-07-31 13:39:00
8723	2014-07-31 13:40:00	2014-07-31 13:49:00
8724	2014-07-31 13:50:00	2014-07-31 13:59:00
8725	2014-07-31 14:00:00	2014-07-31 14:09:00
8726	2014-07-31 14:10:00	2014-07-31 14:19:00
8727	2014-07-31 14:20:00	2014-07-31 14:29:00
8728	2014-07-31 14:30:00	2014-07-31 14:39:00
8729	2014-07-31 14:40:00	2014-07-31 14:49:00
8730	2014-07-31 14:50:00	2014-07-31 14:59:00
8731	2014-07-31 15:00:00	2014-07-31 15:09:00
8732	2014-07-31 15:10:00	2014-07-31 15:19:00
8733	2014-07-31 15:20:00	2014-07-31 15:29:00
8734	2014-07-31 15:30:00	2014-07-31 15:39:00
8735	2014-07-31 15:40:00	2014-07-31 15:49:00
8736	2014-07-31 15:50:00	2014-07-31 15:59:00
8737	2014-07-31 16:00:00	2014-07-31 16:09:00
8738	2014-07-31 16:10:00	2014-07-31 16:19:00
8739	2014-07-31 16:20:00	2014-07-31 16:29:00
8740	2014-07-31 16:30:00	2014-07-31 16:39:00
8741	2014-07-31 16:40:00	2014-07-31 16:49:00
8742	2014-07-31 16:50:00	2014-07-31 16:59:00
8743	2014-07-31 17:00:00	2014-07-31 17:09:00
8744	2014-07-31 17:10:00	2014-07-31 17:19:00
8745	2014-07-31 17:20:00	2014-07-31 17:29:00
8746	2014-07-31 17:30:00	2014-07-31 17:39:00
8747	2014-07-31 17:40:00	2014-07-31 17:49:00
8748	2014-07-31 17:50:00	2014-07-31 17:59:00
8749	2014-07-31 18:00:00	2014-07-31 18:09:00
8750	2014-07-31 18:10:00	2014-07-31 18:19:00
8751	2014-07-31 18:20:00	2014-07-31 18:29:00
8752	2014-07-31 18:30:00	2014-07-31 18:39:00
8753	2014-07-31 18:40:00	2014-07-31 18:49:00
8754	2014-07-31 18:50:00	2014-07-31 18:59:00
8755	2014-07-31 19:00:00	2014-07-31 19:09:00
8756	2014-07-31 19:10:00	2014-07-31 19:19:00
8757	2014-07-31 19:20:00	2014-07-31 19:29:00
8758	2014-07-31 19:30:00	2014-07-31 19:39:00
8759	2014-07-31 19:40:00	2014-07-31 19:49:00
8760	2014-07-31 19:50:00	2014-07-31 19:59:00
8761	2014-07-31 20:00:00	2014-07-31 20:09:00
8762	2014-07-31 20:10:00	2014-07-31 20:19:00
8763	2014-07-31 20:20:00	2014-07-31 20:29:00
8764	2014-07-31 20:30:00	2014-07-31 20:39:00
8765	2014-07-31 20:40:00	2014-07-31 20:49:00
8766	2014-07-31 20:50:00	2014-07-31 20:59:00
8767	2014-07-31 21:00:00	2014-07-31 21:09:00
8768	2014-07-31 21:10:00	2014-07-31 21:19:00
8769	2014-07-31 21:20:00	2014-07-31 21:29:00
8770	2014-07-31 21:30:00	2014-07-31 21:39:00
8771	2014-07-31 21:40:00	2014-07-31 21:49:00
8772	2014-07-31 21:50:00	2014-07-31 21:59:00
8773	2014-07-31 22:00:00	2014-07-31 22:09:00
8774	2014-07-31 22:10:00	2014-07-31 22:19:00
8775	2014-07-31 22:20:00	2014-07-31 22:29:00
8776	2014-07-31 22:30:00	2014-07-31 22:39:00
8777	2014-07-31 22:40:00	2014-07-31 22:49:00
8778	2014-07-31 22:50:00	2014-07-31 22:59:00
8779	2014-07-31 23:00:00	2014-07-31 23:09:00
8780	2014-07-31 23:10:00	2014-07-31 23:19:00
8781	2014-07-31 23:20:00	2014-07-31 23:29:00
8782	2014-07-31 23:30:00	2014-07-31 23:39:00
8783	2014-07-31 23:40:00	2014-07-31 23:49:00
8784	2014-07-31 23:50:00	2014-07-31 23:59:00
8785	2014-08-01 00:00:00	2014-08-01 00:09:00
8786	2014-08-01 00:10:00	2014-08-01 00:19:00
8787	2014-08-01 00:20:00	2014-08-01 00:29:00
8788	2014-08-01 00:30:00	2014-08-01 00:39:00
8789	2014-08-01 00:40:00	2014-08-01 00:49:00
8790	2014-08-01 00:50:00	2014-08-01 00:59:00
8791	2014-08-01 01:00:00	2014-08-01 01:09:00
8792	2014-08-01 01:10:00	2014-08-01 01:19:00
8793	2014-08-01 01:20:00	2014-08-01 01:29:00
8794	2014-08-01 01:30:00	2014-08-01 01:39:00
8795	2014-08-01 01:40:00	2014-08-01 01:49:00
8796	2014-08-01 01:50:00	2014-08-01 01:59:00
8797	2014-08-01 02:00:00	2014-08-01 02:09:00
8798	2014-08-01 02:10:00	2014-08-01 02:19:00
8799	2014-08-01 02:20:00	2014-08-01 02:29:00
8800	2014-08-01 02:30:00	2014-08-01 02:39:00
8801	2014-08-01 02:40:00	2014-08-01 02:49:00
8802	2014-08-01 02:50:00	2014-08-01 02:59:00
8803	2014-08-01 03:00:00	2014-08-01 03:09:00
8804	2014-08-01 03:10:00	2014-08-01 03:19:00
8805	2014-08-01 03:20:00	2014-08-01 03:29:00
8806	2014-08-01 03:30:00	2014-08-01 03:39:00
8807	2014-08-01 03:40:00	2014-08-01 03:49:00
8808	2014-08-01 03:50:00	2014-08-01 03:59:00
8809	2014-08-01 04:00:00	2014-08-01 04:09:00
8810	2014-08-01 04:10:00	2014-08-01 04:19:00
8811	2014-08-01 04:20:00	2014-08-01 04:29:00
8812	2014-08-01 04:30:00	2014-08-01 04:39:00
8813	2014-08-01 04:40:00	2014-08-01 04:49:00
8814	2014-08-01 04:50:00	2014-08-01 04:59:00
8815	2014-08-01 05:00:00	2014-08-01 05:09:00
8816	2014-08-01 05:10:00	2014-08-01 05:19:00
8817	2014-08-01 05:20:00	2014-08-01 05:29:00
8818	2014-08-01 05:30:00	2014-08-01 05:39:00
8819	2014-08-01 05:40:00	2014-08-01 05:49:00
8820	2014-08-01 05:50:00	2014-08-01 05:59:00
8821	2014-08-01 06:00:00	2014-08-01 06:09:00
8822	2014-08-01 06:10:00	2014-08-01 06:19:00
8823	2014-08-01 06:20:00	2014-08-01 06:29:00
8824	2014-08-01 06:30:00	2014-08-01 06:39:00
8825	2014-08-01 06:40:00	2014-08-01 06:49:00
8826	2014-08-01 06:50:00	2014-08-01 06:59:00
8827	2014-08-01 07:00:00	2014-08-01 07:09:00
8828	2014-08-01 07:10:00	2014-08-01 07:19:00
8829	2014-08-01 07:20:00	2014-08-01 07:29:00
8830	2014-08-01 07:30:00	2014-08-01 07:39:00
8831	2014-08-01 07:40:00	2014-08-01 07:49:00
8832	2014-08-01 07:50:00	2014-08-01 07:59:00
8833	2014-08-01 08:00:00	2014-08-01 08:09:00
8834	2014-08-01 08:10:00	2014-08-01 08:19:00
8835	2014-08-01 08:20:00	2014-08-01 08:29:00
8836	2014-08-01 08:30:00	2014-08-01 08:39:00
8837	2014-08-01 08:40:00	2014-08-01 08:49:00
8838	2014-08-01 08:50:00	2014-08-01 08:59:00
8839	2014-08-01 09:00:00	2014-08-01 09:09:00
8840	2014-08-01 09:10:00	2014-08-01 09:19:00
8841	2014-08-01 09:20:00	2014-08-01 09:29:00
8842	2014-08-01 09:30:00	2014-08-01 09:39:00
8843	2014-08-01 09:40:00	2014-08-01 09:49:00
8844	2014-08-01 09:50:00	2014-08-01 09:59:00
8845	2014-08-01 10:00:00	2014-08-01 10:09:00
8846	2014-08-01 10:10:00	2014-08-01 10:19:00
8847	2014-08-01 10:20:00	2014-08-01 10:29:00
8848	2014-08-01 10:30:00	2014-08-01 10:39:00
8849	2014-08-01 10:40:00	2014-08-01 10:49:00
8850	2014-08-01 10:50:00	2014-08-01 10:59:00
8851	2014-08-01 11:00:00	2014-08-01 11:09:00
8852	2014-08-01 11:10:00	2014-08-01 11:19:00
8853	2014-08-01 11:20:00	2014-08-01 11:29:00
8854	2014-08-01 11:30:00	2014-08-01 11:39:00
8855	2014-08-01 11:40:00	2014-08-01 11:49:00
8856	2014-08-01 11:50:00	2014-08-01 11:59:00
8857	2014-08-01 12:00:00	2014-08-01 12:09:00
8858	2014-08-01 12:10:00	2014-08-01 12:19:00
8859	2014-08-01 12:20:00	2014-08-01 12:29:00
8860	2014-08-01 12:30:00	2014-08-01 12:39:00
8861	2014-08-01 12:40:00	2014-08-01 12:49:00
8862	2014-08-01 12:50:00	2014-08-01 12:59:00
8863	2014-08-01 13:00:00	2014-08-01 13:09:00
8864	2014-08-01 13:10:00	2014-08-01 13:19:00
8865	2014-08-01 13:20:00	2014-08-01 13:29:00
8866	2014-08-01 13:30:00	2014-08-01 13:39:00
8867	2014-08-01 13:40:00	2014-08-01 13:49:00
8868	2014-08-01 13:50:00	2014-08-01 13:59:00
8869	2014-08-01 14:00:00	2014-08-01 14:09:00
8870	2014-08-01 14:10:00	2014-08-01 14:19:00
8871	2014-08-01 14:20:00	2014-08-01 14:29:00
8872	2014-08-01 14:30:00	2014-08-01 14:39:00
8873	2014-08-01 14:40:00	2014-08-01 14:49:00
8874	2014-08-01 14:50:00	2014-08-01 14:59:00
8875	2014-08-01 15:00:00	2014-08-01 15:09:00
8876	2014-08-01 15:10:00	2014-08-01 15:19:00
8877	2014-08-01 15:20:00	2014-08-01 15:29:00
8878	2014-08-01 15:30:00	2014-08-01 15:39:00
8879	2014-08-01 15:40:00	2014-08-01 15:49:00
8880	2014-08-01 15:50:00	2014-08-01 15:59:00
8881	2014-08-01 16:00:00	2014-08-01 16:09:00
8882	2014-08-01 16:10:00	2014-08-01 16:19:00
8883	2014-08-01 16:20:00	2014-08-01 16:29:00
8884	2014-08-01 16:30:00	2014-08-01 16:39:00
8885	2014-08-01 16:40:00	2014-08-01 16:49:00
8886	2014-08-01 16:50:00	2014-08-01 16:59:00
8887	2014-08-01 17:00:00	2014-08-01 17:09:00
8888	2014-08-01 17:10:00	2014-08-01 17:19:00
8889	2014-08-01 17:20:00	2014-08-01 17:29:00
8890	2014-08-01 17:30:00	2014-08-01 17:39:00
8891	2014-08-01 17:40:00	2014-08-01 17:49:00
8892	2014-08-01 17:50:00	2014-08-01 17:59:00
8893	2014-08-01 18:00:00	2014-08-01 18:09:00
8894	2014-08-01 18:10:00	2014-08-01 18:19:00
8895	2014-08-01 18:20:00	2014-08-01 18:29:00
8896	2014-08-01 18:30:00	2014-08-01 18:39:00
8897	2014-08-01 18:40:00	2014-08-01 18:49:00
8898	2014-08-01 18:50:00	2014-08-01 18:59:00
8899	2014-08-01 19:00:00	2014-08-01 19:09:00
8900	2014-08-01 19:10:00	2014-08-01 19:19:00
8901	2014-08-01 19:20:00	2014-08-01 19:29:00
8902	2014-08-01 19:30:00	2014-08-01 19:39:00
8903	2014-08-01 19:40:00	2014-08-01 19:49:00
8904	2014-08-01 19:50:00	2014-08-01 19:59:00
8905	2014-08-01 20:00:00	2014-08-01 20:09:00
8906	2014-08-01 20:10:00	2014-08-01 20:19:00
8907	2014-08-01 20:20:00	2014-08-01 20:29:00
8908	2014-08-01 20:30:00	2014-08-01 20:39:00
8909	2014-08-01 20:40:00	2014-08-01 20:49:00
8910	2014-08-01 20:50:00	2014-08-01 20:59:00
8911	2014-08-01 21:00:00	2014-08-01 21:09:00
8912	2014-08-01 21:10:00	2014-08-01 21:19:00
8913	2014-08-01 21:20:00	2014-08-01 21:29:00
8914	2014-08-01 21:30:00	2014-08-01 21:39:00
8915	2014-08-01 21:40:00	2014-08-01 21:49:00
8916	2014-08-01 21:50:00	2014-08-01 21:59:00
8917	2014-08-01 22:00:00	2014-08-01 22:09:00
8918	2014-08-01 22:10:00	2014-08-01 22:19:00
8919	2014-08-01 22:20:00	2014-08-01 22:29:00
8920	2014-08-01 22:30:00	2014-08-01 22:39:00
8921	2014-08-01 22:40:00	2014-08-01 22:49:00
8922	2014-08-01 22:50:00	2014-08-01 22:59:00
8923	2014-08-01 23:00:00	2014-08-01 23:09:00
8924	2014-08-01 23:10:00	2014-08-01 23:19:00
8925	2014-08-01 23:20:00	2014-08-01 23:29:00
8926	2014-08-01 23:30:00	2014-08-01 23:39:00
8927	2014-08-01 23:40:00	2014-08-01 23:49:00
8928	2014-08-01 23:50:00	2014-08-01 23:59:00
8929	2014-08-02 00:00:00	2014-08-02 00:09:00
8930	2014-08-02 00:10:00	2014-08-02 00:19:00
8931	2014-08-02 00:20:00	2014-08-02 00:29:00
8932	2014-08-02 00:30:00	2014-08-02 00:39:00
8933	2014-08-02 00:40:00	2014-08-02 00:49:00
8934	2014-08-02 00:50:00	2014-08-02 00:59:00
8935	2014-08-02 01:00:00	2014-08-02 01:09:00
8936	2014-08-02 01:10:00	2014-08-02 01:19:00
8937	2014-08-02 01:20:00	2014-08-02 01:29:00
8938	2014-08-02 01:30:00	2014-08-02 01:39:00
8939	2014-08-02 01:40:00	2014-08-02 01:49:00
8940	2014-08-02 01:50:00	2014-08-02 01:59:00
8941	2014-08-02 02:00:00	2014-08-02 02:09:00
8942	2014-08-02 02:10:00	2014-08-02 02:19:00
8943	2014-08-02 02:20:00	2014-08-02 02:29:00
8944	2014-08-02 02:30:00	2014-08-02 02:39:00
8945	2014-08-02 02:40:00	2014-08-02 02:49:00
8946	2014-08-02 02:50:00	2014-08-02 02:59:00
8947	2014-08-02 03:00:00	2014-08-02 03:09:00
8948	2014-08-02 03:10:00	2014-08-02 03:19:00
8949	2014-08-02 03:20:00	2014-08-02 03:29:00
8950	2014-08-02 03:30:00	2014-08-02 03:39:00
8951	2014-08-02 03:40:00	2014-08-02 03:49:00
8952	2014-08-02 03:50:00	2014-08-02 03:59:00
8953	2014-08-02 04:00:00	2014-08-02 04:09:00
8954	2014-08-02 04:10:00	2014-08-02 04:19:00
8955	2014-08-02 04:20:00	2014-08-02 04:29:00
8956	2014-08-02 04:30:00	2014-08-02 04:39:00
8957	2014-08-02 04:40:00	2014-08-02 04:49:00
8958	2014-08-02 04:50:00	2014-08-02 04:59:00
8959	2014-08-02 05:00:00	2014-08-02 05:09:00
8960	2014-08-02 05:10:00	2014-08-02 05:19:00
8961	2014-08-02 05:20:00	2014-08-02 05:29:00
8962	2014-08-02 05:30:00	2014-08-02 05:39:00
8963	2014-08-02 05:40:00	2014-08-02 05:49:00
8964	2014-08-02 05:50:00	2014-08-02 05:59:00
8965	2014-08-02 06:00:00	2014-08-02 06:09:00
8966	2014-08-02 06:10:00	2014-08-02 06:19:00
8967	2014-08-02 06:20:00	2014-08-02 06:29:00
8968	2014-08-02 06:30:00	2014-08-02 06:39:00
8969	2014-08-02 06:40:00	2014-08-02 06:49:00
8970	2014-08-02 06:50:00	2014-08-02 06:59:00
8971	2014-08-02 07:00:00	2014-08-02 07:09:00
8972	2014-08-02 07:10:00	2014-08-02 07:19:00
8973	2014-08-02 07:20:00	2014-08-02 07:29:00
8974	2014-08-02 07:30:00	2014-08-02 07:39:00
8975	2014-08-02 07:40:00	2014-08-02 07:49:00
8976	2014-08-02 07:50:00	2014-08-02 07:59:00
8977	2014-08-02 08:00:00	2014-08-02 08:09:00
8978	2014-08-02 08:10:00	2014-08-02 08:19:00
8979	2014-08-02 08:20:00	2014-08-02 08:29:00
8980	2014-08-02 08:30:00	2014-08-02 08:39:00
8981	2014-08-02 08:40:00	2014-08-02 08:49:00
8982	2014-08-02 08:50:00	2014-08-02 08:59:00
8983	2014-08-02 09:00:00	2014-08-02 09:09:00
8984	2014-08-02 09:10:00	2014-08-02 09:19:00
8985	2014-08-02 09:20:00	2014-08-02 09:29:00
8986	2014-08-02 09:30:00	2014-08-02 09:39:00
8987	2014-08-02 09:40:00	2014-08-02 09:49:00
8988	2014-08-02 09:50:00	2014-08-02 09:59:00
8989	2014-08-02 10:00:00	2014-08-02 10:09:00
8990	2014-08-02 10:10:00	2014-08-02 10:19:00
8991	2014-08-02 10:20:00	2014-08-02 10:29:00
8992	2014-08-02 10:30:00	2014-08-02 10:39:00
8993	2014-08-02 10:40:00	2014-08-02 10:49:00
8994	2014-08-02 10:50:00	2014-08-02 10:59:00
8995	2014-08-02 11:00:00	2014-08-02 11:09:00
8996	2014-08-02 11:10:00	2014-08-02 11:19:00
8997	2014-08-02 11:20:00	2014-08-02 11:29:00
8998	2014-08-02 11:30:00	2014-08-02 11:39:00
8999	2014-08-02 11:40:00	2014-08-02 11:49:00
9000	2014-08-02 11:50:00	2014-08-02 11:59:00
9001	2014-08-02 12:00:00	2014-08-02 12:09:00
9002	2014-08-02 12:10:00	2014-08-02 12:19:00
9003	2014-08-02 12:20:00	2014-08-02 12:29:00
9004	2014-08-02 12:30:00	2014-08-02 12:39:00
9005	2014-08-02 12:40:00	2014-08-02 12:49:00
9006	2014-08-02 12:50:00	2014-08-02 12:59:00
9007	2014-08-02 13:00:00	2014-08-02 13:09:00
9008	2014-08-02 13:10:00	2014-08-02 13:19:00
9009	2014-08-02 13:20:00	2014-08-02 13:29:00
9010	2014-08-02 13:30:00	2014-08-02 13:39:00
9011	2014-08-02 13:40:00	2014-08-02 13:49:00
9012	2014-08-02 13:50:00	2014-08-02 13:59:00
9013	2014-08-02 14:00:00	2014-08-02 14:09:00
9014	2014-08-02 14:10:00	2014-08-02 14:19:00
9015	2014-08-02 14:20:00	2014-08-02 14:29:00
9016	2014-08-02 14:30:00	2014-08-02 14:39:00
9017	2014-08-02 14:40:00	2014-08-02 14:49:00
9018	2014-08-02 14:50:00	2014-08-02 14:59:00
9019	2014-08-02 15:00:00	2014-08-02 15:09:00
9020	2014-08-02 15:10:00	2014-08-02 15:19:00
9021	2014-08-02 15:20:00	2014-08-02 15:29:00
9022	2014-08-02 15:30:00	2014-08-02 15:39:00
9023	2014-08-02 15:40:00	2014-08-02 15:49:00
9024	2014-08-02 15:50:00	2014-08-02 15:59:00
9025	2014-08-02 16:00:00	2014-08-02 16:09:00
9026	2014-08-02 16:10:00	2014-08-02 16:19:00
9027	2014-08-02 16:20:00	2014-08-02 16:29:00
9028	2014-08-02 16:30:00	2014-08-02 16:39:00
9029	2014-08-02 16:40:00	2014-08-02 16:49:00
9030	2014-08-02 16:50:00	2014-08-02 16:59:00
9031	2014-08-02 17:00:00	2014-08-02 17:09:00
9032	2014-08-02 17:10:00	2014-08-02 17:19:00
9033	2014-08-02 17:20:00	2014-08-02 17:29:00
9034	2014-08-02 17:30:00	2014-08-02 17:39:00
9035	2014-08-02 17:40:00	2014-08-02 17:49:00
9036	2014-08-02 17:50:00	2014-08-02 17:59:00
9037	2014-08-02 18:00:00	2014-08-02 18:09:00
9038	2014-08-02 18:10:00	2014-08-02 18:19:00
9039	2014-08-02 18:20:00	2014-08-02 18:29:00
9040	2014-08-02 18:30:00	2014-08-02 18:39:00
9041	2014-08-02 18:40:00	2014-08-02 18:49:00
9042	2014-08-02 18:50:00	2014-08-02 18:59:00
9043	2014-08-02 19:00:00	2014-08-02 19:09:00
9044	2014-08-02 19:10:00	2014-08-02 19:19:00
9045	2014-08-02 19:20:00	2014-08-02 19:29:00
9046	2014-08-02 19:30:00	2014-08-02 19:39:00
9047	2014-08-02 19:40:00	2014-08-02 19:49:00
9048	2014-08-02 19:50:00	2014-08-02 19:59:00
9049	2014-08-02 20:00:00	2014-08-02 20:09:00
9050	2014-08-02 20:10:00	2014-08-02 20:19:00
9051	2014-08-02 20:20:00	2014-08-02 20:29:00
9052	2014-08-02 20:30:00	2014-08-02 20:39:00
9053	2014-08-02 20:40:00	2014-08-02 20:49:00
9054	2014-08-02 20:50:00	2014-08-02 20:59:00
9055	2014-08-02 21:00:00	2014-08-02 21:09:00
9056	2014-08-02 21:10:00	2014-08-02 21:19:00
9057	2014-08-02 21:20:00	2014-08-02 21:29:00
9058	2014-08-02 21:30:00	2014-08-02 21:39:00
9059	2014-08-02 21:40:00	2014-08-02 21:49:00
9060	2014-08-02 21:50:00	2014-08-02 21:59:00
9061	2014-08-02 22:00:00	2014-08-02 22:09:00
9062	2014-08-02 22:10:00	2014-08-02 22:19:00
9063	2014-08-02 22:20:00	2014-08-02 22:29:00
9064	2014-08-02 22:30:00	2014-08-02 22:39:00
9065	2014-08-02 22:40:00	2014-08-02 22:49:00
9066	2014-08-02 22:50:00	2014-08-02 22:59:00
9067	2014-08-02 23:00:00	2014-08-02 23:09:00
9068	2014-08-02 23:10:00	2014-08-02 23:19:00
9069	2014-08-02 23:20:00	2014-08-02 23:29:00
9070	2014-08-02 23:30:00	2014-08-02 23:39:00
9071	2014-08-02 23:40:00	2014-08-02 23:49:00
9072	2014-08-02 23:50:00	2014-08-02 23:59:00
9073	2014-08-03 00:00:00	2014-08-03 00:09:00
9074	2014-08-03 00:10:00	2014-08-03 00:19:00
9075	2014-08-03 00:20:00	2014-08-03 00:29:00
9076	2014-08-03 00:30:00	2014-08-03 00:39:00
9077	2014-08-03 00:40:00	2014-08-03 00:49:00
9078	2014-08-03 00:50:00	2014-08-03 00:59:00
9079	2014-08-03 01:00:00	2014-08-03 01:09:00
9080	2014-08-03 01:10:00	2014-08-03 01:19:00
9081	2014-08-03 01:20:00	2014-08-03 01:29:00
9082	2014-08-03 01:30:00	2014-08-03 01:39:00
9083	2014-08-03 01:40:00	2014-08-03 01:49:00
9084	2014-08-03 01:50:00	2014-08-03 01:59:00
9085	2014-08-03 02:00:00	2014-08-03 02:09:00
9086	2014-08-03 02:10:00	2014-08-03 02:19:00
9087	2014-08-03 02:20:00	2014-08-03 02:29:00
9088	2014-08-03 02:30:00	2014-08-03 02:39:00
9089	2014-08-03 02:40:00	2014-08-03 02:49:00
9090	2014-08-03 02:50:00	2014-08-03 02:59:00
9091	2014-08-03 03:00:00	2014-08-03 03:09:00
9092	2014-08-03 03:10:00	2014-08-03 03:19:00
9093	2014-08-03 03:20:00	2014-08-03 03:29:00
9094	2014-08-03 03:30:00	2014-08-03 03:39:00
9095	2014-08-03 03:40:00	2014-08-03 03:49:00
9096	2014-08-03 03:50:00	2014-08-03 03:59:00
9097	2014-08-03 04:00:00	2014-08-03 04:09:00
9098	2014-08-03 04:10:00	2014-08-03 04:19:00
9099	2014-08-03 04:20:00	2014-08-03 04:29:00
9100	2014-08-03 04:30:00	2014-08-03 04:39:00
9101	2014-08-03 04:40:00	2014-08-03 04:49:00
9102	2014-08-03 04:50:00	2014-08-03 04:59:00
9103	2014-08-03 05:00:00	2014-08-03 05:09:00
9104	2014-08-03 05:10:00	2014-08-03 05:19:00
9105	2014-08-03 05:20:00	2014-08-03 05:29:00
9106	2014-08-03 05:30:00	2014-08-03 05:39:00
9107	2014-08-03 05:40:00	2014-08-03 05:49:00
9108	2014-08-03 05:50:00	2014-08-03 05:59:00
9109	2014-08-03 06:00:00	2014-08-03 06:09:00
9110	2014-08-03 06:10:00	2014-08-03 06:19:00
9111	2014-08-03 06:20:00	2014-08-03 06:29:00
9112	2014-08-03 06:30:00	2014-08-03 06:39:00
9113	2014-08-03 06:40:00	2014-08-03 06:49:00
9114	2014-08-03 06:50:00	2014-08-03 06:59:00
9115	2014-08-03 07:00:00	2014-08-03 07:09:00
9116	2014-08-03 07:10:00	2014-08-03 07:19:00
9117	2014-08-03 07:20:00	2014-08-03 07:29:00
9118	2014-08-03 07:30:00	2014-08-03 07:39:00
9119	2014-08-03 07:40:00	2014-08-03 07:49:00
9120	2014-08-03 07:50:00	2014-08-03 07:59:00
9121	2014-08-03 08:00:00	2014-08-03 08:09:00
9122	2014-08-03 08:10:00	2014-08-03 08:19:00
9123	2014-08-03 08:20:00	2014-08-03 08:29:00
9124	2014-08-03 08:30:00	2014-08-03 08:39:00
9125	2014-08-03 08:40:00	2014-08-03 08:49:00
9126	2014-08-03 08:50:00	2014-08-03 08:59:00
9127	2014-08-03 09:00:00	2014-08-03 09:09:00
9128	2014-08-03 09:10:00	2014-08-03 09:19:00
9129	2014-08-03 09:20:00	2014-08-03 09:29:00
9130	2014-08-03 09:30:00	2014-08-03 09:39:00
9131	2014-08-03 09:40:00	2014-08-03 09:49:00
9132	2014-08-03 09:50:00	2014-08-03 09:59:00
9133	2014-08-03 10:00:00	2014-08-03 10:09:00
9134	2014-08-03 10:10:00	2014-08-03 10:19:00
9135	2014-08-03 10:20:00	2014-08-03 10:29:00
9136	2014-08-03 10:30:00	2014-08-03 10:39:00
9137	2014-08-03 10:40:00	2014-08-03 10:49:00
9138	2014-08-03 10:50:00	2014-08-03 10:59:00
9139	2014-08-03 11:00:00	2014-08-03 11:09:00
9140	2014-08-03 11:10:00	2014-08-03 11:19:00
9141	2014-08-03 11:20:00	2014-08-03 11:29:00
9142	2014-08-03 11:30:00	2014-08-03 11:39:00
9143	2014-08-03 11:40:00	2014-08-03 11:49:00
9144	2014-08-03 11:50:00	2014-08-03 11:59:00
9145	2014-08-03 12:00:00	2014-08-03 12:09:00
9146	2014-08-03 12:10:00	2014-08-03 12:19:00
9147	2014-08-03 12:20:00	2014-08-03 12:29:00
9148	2014-08-03 12:30:00	2014-08-03 12:39:00
9149	2014-08-03 12:40:00	2014-08-03 12:49:00
9150	2014-08-03 12:50:00	2014-08-03 12:59:00
9151	2014-08-03 13:00:00	2014-08-03 13:09:00
9152	2014-08-03 13:10:00	2014-08-03 13:19:00
9153	2014-08-03 13:20:00	2014-08-03 13:29:00
9154	2014-08-03 13:30:00	2014-08-03 13:39:00
9155	2014-08-03 13:40:00	2014-08-03 13:49:00
9156	2014-08-03 13:50:00	2014-08-03 13:59:00
9157	2014-08-03 14:00:00	2014-08-03 14:09:00
9158	2014-08-03 14:10:00	2014-08-03 14:19:00
9159	2014-08-03 14:20:00	2014-08-03 14:29:00
9160	2014-08-03 14:30:00	2014-08-03 14:39:00
9161	2014-08-03 14:40:00	2014-08-03 14:49:00
9162	2014-08-03 14:50:00	2014-08-03 14:59:00
9163	2014-08-03 15:00:00	2014-08-03 15:09:00
9164	2014-08-03 15:10:00	2014-08-03 15:19:00
9165	2014-08-03 15:20:00	2014-08-03 15:29:00
9166	2014-08-03 15:30:00	2014-08-03 15:39:00
9167	2014-08-03 15:40:00	2014-08-03 15:49:00
9168	2014-08-03 15:50:00	2014-08-03 15:59:00
9169	2014-08-03 16:00:00	2014-08-03 16:09:00
9170	2014-08-03 16:10:00	2014-08-03 16:19:00
9171	2014-08-03 16:20:00	2014-08-03 16:29:00
9172	2014-08-03 16:30:00	2014-08-03 16:39:00
9173	2014-08-03 16:40:00	2014-08-03 16:49:00
9174	2014-08-03 16:50:00	2014-08-03 16:59:00
9175	2014-08-03 17:00:00	2014-08-03 17:09:00
9176	2014-08-03 17:10:00	2014-08-03 17:19:00
9177	2014-08-03 17:20:00	2014-08-03 17:29:00
9178	2014-08-03 17:30:00	2014-08-03 17:39:00
9179	2014-08-03 17:40:00	2014-08-03 17:49:00
9180	2014-08-03 17:50:00	2014-08-03 17:59:00
9181	2014-08-03 18:00:00	2014-08-03 18:09:00
9182	2014-08-03 18:10:00	2014-08-03 18:19:00
9183	2014-08-03 18:20:00	2014-08-03 18:29:00
9184	2014-08-03 18:30:00	2014-08-03 18:39:00
9185	2014-08-03 18:40:00	2014-08-03 18:49:00
9186	2014-08-03 18:50:00	2014-08-03 18:59:00
9187	2014-08-03 19:00:00	2014-08-03 19:09:00
9188	2014-08-03 19:10:00	2014-08-03 19:19:00
9189	2014-08-03 19:20:00	2014-08-03 19:29:00
9190	2014-08-03 19:30:00	2014-08-03 19:39:00
9191	2014-08-03 19:40:00	2014-08-03 19:49:00
9192	2014-08-03 19:50:00	2014-08-03 19:59:00
9193	2014-08-03 20:00:00	2014-08-03 20:09:00
9194	2014-08-03 20:10:00	2014-08-03 20:19:00
9195	2014-08-03 20:20:00	2014-08-03 20:29:00
9196	2014-08-03 20:30:00	2014-08-03 20:39:00
9197	2014-08-03 20:40:00	2014-08-03 20:49:00
9198	2014-08-03 20:50:00	2014-08-03 20:59:00
9199	2014-08-03 21:00:00	2014-08-03 21:09:00
9200	2014-08-03 21:10:00	2014-08-03 21:19:00
9201	2014-08-03 21:20:00	2014-08-03 21:29:00
9202	2014-08-03 21:30:00	2014-08-03 21:39:00
9203	2014-08-03 21:40:00	2014-08-03 21:49:00
9204	2014-08-03 21:50:00	2014-08-03 21:59:00
9205	2014-08-03 22:00:00	2014-08-03 22:09:00
9206	2014-08-03 22:10:00	2014-08-03 22:19:00
9207	2014-08-03 22:20:00	2014-08-03 22:29:00
9208	2014-08-03 22:30:00	2014-08-03 22:39:00
9209	2014-08-03 22:40:00	2014-08-03 22:49:00
9210	2014-08-03 22:50:00	2014-08-03 22:59:00
9211	2014-08-03 23:00:00	2014-08-03 23:09:00
9212	2014-08-03 23:10:00	2014-08-03 23:19:00
9213	2014-08-03 23:20:00	2014-08-03 23:29:00
9214	2014-08-03 23:30:00	2014-08-03 23:39:00
9215	2014-08-03 23:40:00	2014-08-03 23:49:00
9216	2014-08-03 23:50:00	2014-08-03 23:59:00
9217	2014-08-04 00:00:00	2014-08-04 00:09:00
9218	2014-08-04 00:10:00	2014-08-04 00:19:00
9219	2014-08-04 00:20:00	2014-08-04 00:29:00
9220	2014-08-04 00:30:00	2014-08-04 00:39:00
9221	2014-08-04 00:40:00	2014-08-04 00:49:00
9222	2014-08-04 00:50:00	2014-08-04 00:59:00
9223	2014-08-04 01:00:00	2014-08-04 01:09:00
9224	2014-08-04 01:10:00	2014-08-04 01:19:00
9225	2014-08-04 01:20:00	2014-08-04 01:29:00
9226	2014-08-04 01:30:00	2014-08-04 01:39:00
9227	2014-08-04 01:40:00	2014-08-04 01:49:00
9228	2014-08-04 01:50:00	2014-08-04 01:59:00
9229	2014-08-04 02:00:00	2014-08-04 02:09:00
9230	2014-08-04 02:10:00	2014-08-04 02:19:00
9231	2014-08-04 02:20:00	2014-08-04 02:29:00
9232	2014-08-04 02:30:00	2014-08-04 02:39:00
9233	2014-08-04 02:40:00	2014-08-04 02:49:00
9234	2014-08-04 02:50:00	2014-08-04 02:59:00
9235	2014-08-04 03:00:00	2014-08-04 03:09:00
9236	2014-08-04 03:10:00	2014-08-04 03:19:00
9237	2014-08-04 03:20:00	2014-08-04 03:29:00
9238	2014-08-04 03:30:00	2014-08-04 03:39:00
9239	2014-08-04 03:40:00	2014-08-04 03:49:00
9240	2014-08-04 03:50:00	2014-08-04 03:59:00
9241	2014-08-04 04:00:00	2014-08-04 04:09:00
9242	2014-08-04 04:10:00	2014-08-04 04:19:00
9243	2014-08-04 04:20:00	2014-08-04 04:29:00
9244	2014-08-04 04:30:00	2014-08-04 04:39:00
9245	2014-08-04 04:40:00	2014-08-04 04:49:00
9246	2014-08-04 04:50:00	2014-08-04 04:59:00
9247	2014-08-04 05:00:00	2014-08-04 05:09:00
9248	2014-08-04 05:10:00	2014-08-04 05:19:00
9249	2014-08-04 05:20:00	2014-08-04 05:29:00
9250	2014-08-04 05:30:00	2014-08-04 05:39:00
9251	2014-08-04 05:40:00	2014-08-04 05:49:00
9252	2014-08-04 05:50:00	2014-08-04 05:59:00
9253	2014-08-04 06:00:00	2014-08-04 06:09:00
9254	2014-08-04 06:10:00	2014-08-04 06:19:00
9255	2014-08-04 06:20:00	2014-08-04 06:29:00
9256	2014-08-04 06:30:00	2014-08-04 06:39:00
9257	2014-08-04 06:40:00	2014-08-04 06:49:00
9258	2014-08-04 06:50:00	2014-08-04 06:59:00
9259	2014-08-04 07:00:00	2014-08-04 07:09:00
9260	2014-08-04 07:10:00	2014-08-04 07:19:00
9261	2014-08-04 07:20:00	2014-08-04 07:29:00
9262	2014-08-04 07:30:00	2014-08-04 07:39:00
9263	2014-08-04 07:40:00	2014-08-04 07:49:00
9264	2014-08-04 07:50:00	2014-08-04 07:59:00
9265	2014-08-04 08:00:00	2014-08-04 08:09:00
9266	2014-08-04 08:10:00	2014-08-04 08:19:00
9267	2014-08-04 08:20:00	2014-08-04 08:29:00
9268	2014-08-04 08:30:00	2014-08-04 08:39:00
9269	2014-08-04 08:40:00	2014-08-04 08:49:00
9270	2014-08-04 08:50:00	2014-08-04 08:59:00
9271	2014-08-04 09:00:00	2014-08-04 09:09:00
9272	2014-08-04 09:10:00	2014-08-04 09:19:00
9273	2014-08-04 09:20:00	2014-08-04 09:29:00
9274	2014-08-04 09:30:00	2014-08-04 09:39:00
9275	2014-08-04 09:40:00	2014-08-04 09:49:00
9276	2014-08-04 09:50:00	2014-08-04 09:59:00
9277	2014-08-04 10:00:00	2014-08-04 10:09:00
9278	2014-08-04 10:10:00	2014-08-04 10:19:00
9279	2014-08-04 10:20:00	2014-08-04 10:29:00
9280	2014-08-04 10:30:00	2014-08-04 10:39:00
9281	2014-08-04 10:40:00	2014-08-04 10:49:00
9282	2014-08-04 10:50:00	2014-08-04 10:59:00
9283	2014-08-04 11:00:00	2014-08-04 11:09:00
9284	2014-08-04 11:10:00	2014-08-04 11:19:00
9285	2014-08-04 11:20:00	2014-08-04 11:29:00
9286	2014-08-04 11:30:00	2014-08-04 11:39:00
9287	2014-08-04 11:40:00	2014-08-04 11:49:00
9288	2014-08-04 11:50:00	2014-08-04 11:59:00
9289	2014-08-04 12:00:00	2014-08-04 12:09:00
9290	2014-08-04 12:10:00	2014-08-04 12:19:00
9291	2014-08-04 12:20:00	2014-08-04 12:29:00
9292	2014-08-04 12:30:00	2014-08-04 12:39:00
9293	2014-08-04 12:40:00	2014-08-04 12:49:00
9294	2014-08-04 12:50:00	2014-08-04 12:59:00
9295	2014-08-04 13:00:00	2014-08-04 13:09:00
9296	2014-08-04 13:10:00	2014-08-04 13:19:00
9297	2014-08-04 13:20:00	2014-08-04 13:29:00
9298	2014-08-04 13:30:00	2014-08-04 13:39:00
9299	2014-08-04 13:40:00	2014-08-04 13:49:00
9300	2014-08-04 13:50:00	2014-08-04 13:59:00
9301	2014-08-04 14:00:00	2014-08-04 14:09:00
9302	2014-08-04 14:10:00	2014-08-04 14:19:00
9303	2014-08-04 14:20:00	2014-08-04 14:29:00
9304	2014-08-04 14:30:00	2014-08-04 14:39:00
9305	2014-08-04 14:40:00	2014-08-04 14:49:00
9306	2014-08-04 14:50:00	2014-08-04 14:59:00
9307	2014-08-04 15:00:00	2014-08-04 15:09:00
9308	2014-08-04 15:10:00	2014-08-04 15:19:00
9309	2014-08-04 15:20:00	2014-08-04 15:29:00
9310	2014-08-04 15:30:00	2014-08-04 15:39:00
9311	2014-08-04 15:40:00	2014-08-04 15:49:00
9312	2014-08-04 15:50:00	2014-08-04 15:59:00
9313	2014-08-04 16:00:00	2014-08-04 16:09:00
9314	2014-08-04 16:10:00	2014-08-04 16:19:00
9315	2014-08-04 16:20:00	2014-08-04 16:29:00
9316	2014-08-04 16:30:00	2014-08-04 16:39:00
9317	2014-08-04 16:40:00	2014-08-04 16:49:00
9318	2014-08-04 16:50:00	2014-08-04 16:59:00
9319	2014-08-04 17:00:00	2014-08-04 17:09:00
9320	2014-08-04 17:10:00	2014-08-04 17:19:00
9321	2014-08-04 17:20:00	2014-08-04 17:29:00
9322	2014-08-04 17:30:00	2014-08-04 17:39:00
9323	2014-08-04 17:40:00	2014-08-04 17:49:00
9324	2014-08-04 17:50:00	2014-08-04 17:59:00
9325	2014-08-04 18:00:00	2014-08-04 18:09:00
9326	2014-08-04 18:10:00	2014-08-04 18:19:00
9327	2014-08-04 18:20:00	2014-08-04 18:29:00
9328	2014-08-04 18:30:00	2014-08-04 18:39:00
9329	2014-08-04 18:40:00	2014-08-04 18:49:00
9330	2014-08-04 18:50:00	2014-08-04 18:59:00
9331	2014-08-04 19:00:00	2014-08-04 19:09:00
9332	2014-08-04 19:10:00	2014-08-04 19:19:00
9333	2014-08-04 19:20:00	2014-08-04 19:29:00
9334	2014-08-04 19:30:00	2014-08-04 19:39:00
9335	2014-08-04 19:40:00	2014-08-04 19:49:00
9336	2014-08-04 19:50:00	2014-08-04 19:59:00
9337	2014-08-04 20:00:00	2014-08-04 20:09:00
9338	2014-08-04 20:10:00	2014-08-04 20:19:00
9339	2014-08-04 20:20:00	2014-08-04 20:29:00
9340	2014-08-04 20:30:00	2014-08-04 20:39:00
9341	2014-08-04 20:40:00	2014-08-04 20:49:00
9342	2014-08-04 20:50:00	2014-08-04 20:59:00
9343	2014-08-04 21:00:00	2014-08-04 21:09:00
9344	2014-08-04 21:10:00	2014-08-04 21:19:00
9345	2014-08-04 21:20:00	2014-08-04 21:29:00
9346	2014-08-04 21:30:00	2014-08-04 21:39:00
9347	2014-08-04 21:40:00	2014-08-04 21:49:00
9348	2014-08-04 21:50:00	2014-08-04 21:59:00
9349	2014-08-04 22:00:00	2014-08-04 22:09:00
9350	2014-08-04 22:10:00	2014-08-04 22:19:00
9351	2014-08-04 22:20:00	2014-08-04 22:29:00
9352	2014-08-04 22:30:00	2014-08-04 22:39:00
9353	2014-08-04 22:40:00	2014-08-04 22:49:00
9354	2014-08-04 22:50:00	2014-08-04 22:59:00
9355	2014-08-04 23:00:00	2014-08-04 23:09:00
9356	2014-08-04 23:10:00	2014-08-04 23:19:00
9357	2014-08-04 23:20:00	2014-08-04 23:29:00
9358	2014-08-04 23:30:00	2014-08-04 23:39:00
9359	2014-08-04 23:40:00	2014-08-04 23:49:00
9360	2014-08-04 23:50:00	2014-08-04 23:59:00
9361	2014-08-05 00:00:00	2014-08-05 00:09:00
9362	2014-08-05 00:10:00	2014-08-05 00:19:00
9363	2014-08-05 00:20:00	2014-08-05 00:29:00
9364	2014-08-05 00:30:00	2014-08-05 00:39:00
9365	2014-08-05 00:40:00	2014-08-05 00:49:00
9366	2014-08-05 00:50:00	2014-08-05 00:59:00
9367	2014-08-05 01:00:00	2014-08-05 01:09:00
9368	2014-08-05 01:10:00	2014-08-05 01:19:00
9369	2014-08-05 01:20:00	2014-08-05 01:29:00
9370	2014-08-05 01:30:00	2014-08-05 01:39:00
9371	2014-08-05 01:40:00	2014-08-05 01:49:00
9372	2014-08-05 01:50:00	2014-08-05 01:59:00
9373	2014-08-05 02:00:00	2014-08-05 02:09:00
9374	2014-08-05 02:10:00	2014-08-05 02:19:00
9375	2014-08-05 02:20:00	2014-08-05 02:29:00
9376	2014-08-05 02:30:00	2014-08-05 02:39:00
9377	2014-08-05 02:40:00	2014-08-05 02:49:00
9378	2014-08-05 02:50:00	2014-08-05 02:59:00
9379	2014-08-05 03:00:00	2014-08-05 03:09:00
9380	2014-08-05 03:10:00	2014-08-05 03:19:00
9381	2014-08-05 03:20:00	2014-08-05 03:29:00
9382	2014-08-05 03:30:00	2014-08-05 03:39:00
9383	2014-08-05 03:40:00	2014-08-05 03:49:00
9384	2014-08-05 03:50:00	2014-08-05 03:59:00
9385	2014-08-05 04:00:00	2014-08-05 04:09:00
9386	2014-08-05 04:10:00	2014-08-05 04:19:00
9387	2014-08-05 04:20:00	2014-08-05 04:29:00
9388	2014-08-05 04:30:00	2014-08-05 04:39:00
9389	2014-08-05 04:40:00	2014-08-05 04:49:00
9390	2014-08-05 04:50:00	2014-08-05 04:59:00
9391	2014-08-05 05:00:00	2014-08-05 05:09:00
9392	2014-08-05 05:10:00	2014-08-05 05:19:00
9393	2014-08-05 05:20:00	2014-08-05 05:29:00
9394	2014-08-05 05:30:00	2014-08-05 05:39:00
9395	2014-08-05 05:40:00	2014-08-05 05:49:00
9396	2014-08-05 05:50:00	2014-08-05 05:59:00
9397	2014-08-05 06:00:00	2014-08-05 06:09:00
9398	2014-08-05 06:10:00	2014-08-05 06:19:00
9399	2014-08-05 06:20:00	2014-08-05 06:29:00
9400	2014-08-05 06:30:00	2014-08-05 06:39:00
9401	2014-08-05 06:40:00	2014-08-05 06:49:00
9402	2014-08-05 06:50:00	2014-08-05 06:59:00
9403	2014-08-05 07:00:00	2014-08-05 07:09:00
9404	2014-08-05 07:10:00	2014-08-05 07:19:00
9405	2014-08-05 07:20:00	2014-08-05 07:29:00
9406	2014-08-05 07:30:00	2014-08-05 07:39:00
9407	2014-08-05 07:40:00	2014-08-05 07:49:00
9408	2014-08-05 07:50:00	2014-08-05 07:59:00
9409	2014-08-05 08:00:00	2014-08-05 08:09:00
9410	2014-08-05 08:10:00	2014-08-05 08:19:00
9411	2014-08-05 08:20:00	2014-08-05 08:29:00
9412	2014-08-05 08:30:00	2014-08-05 08:39:00
9413	2014-08-05 08:40:00	2014-08-05 08:49:00
9414	2014-08-05 08:50:00	2014-08-05 08:59:00
9415	2014-08-05 09:00:00	2014-08-05 09:09:00
9416	2014-08-05 09:10:00	2014-08-05 09:19:00
9417	2014-08-05 09:20:00	2014-08-05 09:29:00
9418	2014-08-05 09:30:00	2014-08-05 09:39:00
9419	2014-08-05 09:40:00	2014-08-05 09:49:00
9420	2014-08-05 09:50:00	2014-08-05 09:59:00
9421	2014-08-05 10:00:00	2014-08-05 10:09:00
9422	2014-08-05 10:10:00	2014-08-05 10:19:00
9423	2014-08-05 10:20:00	2014-08-05 10:29:00
9424	2014-08-05 10:30:00	2014-08-05 10:39:00
9425	2014-08-05 10:40:00	2014-08-05 10:49:00
9426	2014-08-05 10:50:00	2014-08-05 10:59:00
9427	2014-08-05 11:00:00	2014-08-05 11:09:00
9428	2014-08-05 11:10:00	2014-08-05 11:19:00
9429	2014-08-05 11:20:00	2014-08-05 11:29:00
9430	2014-08-05 11:30:00	2014-08-05 11:39:00
9431	2014-08-05 11:40:00	2014-08-05 11:49:00
9432	2014-08-05 11:50:00	2014-08-05 11:59:00
9433	2014-08-05 12:00:00	2014-08-05 12:09:00
9434	2014-08-05 12:10:00	2014-08-05 12:19:00
9435	2014-08-05 12:20:00	2014-08-05 12:29:00
9436	2014-08-05 12:30:00	2014-08-05 12:39:00
9437	2014-08-05 12:40:00	2014-08-05 12:49:00
9438	2014-08-05 12:50:00	2014-08-05 12:59:00
9439	2014-08-05 13:00:00	2014-08-05 13:09:00
9440	2014-08-05 13:10:00	2014-08-05 13:19:00
9441	2014-08-05 13:20:00	2014-08-05 13:29:00
9442	2014-08-05 13:30:00	2014-08-05 13:39:00
9443	2014-08-05 13:40:00	2014-08-05 13:49:00
9444	2014-08-05 13:50:00	2014-08-05 13:59:00
9445	2014-08-05 14:00:00	2014-08-05 14:09:00
9446	2014-08-05 14:10:00	2014-08-05 14:19:00
9447	2014-08-05 14:20:00	2014-08-05 14:29:00
9448	2014-08-05 14:30:00	2014-08-05 14:39:00
9449	2014-08-05 14:40:00	2014-08-05 14:49:00
9450	2014-08-05 14:50:00	2014-08-05 14:59:00
9451	2014-08-05 15:00:00	2014-08-05 15:09:00
9452	2014-08-05 15:10:00	2014-08-05 15:19:00
9453	2014-08-05 15:20:00	2014-08-05 15:29:00
9454	2014-08-05 15:30:00	2014-08-05 15:39:00
9455	2014-08-05 15:40:00	2014-08-05 15:49:00
9456	2014-08-05 15:50:00	2014-08-05 15:59:00
9457	2014-08-05 16:00:00	2014-08-05 16:09:00
9458	2014-08-05 16:10:00	2014-08-05 16:19:00
9459	2014-08-05 16:20:00	2014-08-05 16:29:00
9460	2014-08-05 16:30:00	2014-08-05 16:39:00
9461	2014-08-05 16:40:00	2014-08-05 16:49:00
9462	2014-08-05 16:50:00	2014-08-05 16:59:00
9463	2014-08-05 17:00:00	2014-08-05 17:09:00
9464	2014-08-05 17:10:00	2014-08-05 17:19:00
9465	2014-08-05 17:20:00	2014-08-05 17:29:00
9466	2014-08-05 17:30:00	2014-08-05 17:39:00
9467	2014-08-05 17:40:00	2014-08-05 17:49:00
9468	2014-08-05 17:50:00	2014-08-05 17:59:00
9469	2014-08-05 18:00:00	2014-08-05 18:09:00
9470	2014-08-05 18:10:00	2014-08-05 18:19:00
9471	2014-08-05 18:20:00	2014-08-05 18:29:00
9472	2014-08-05 18:30:00	2014-08-05 18:39:00
9473	2014-08-05 18:40:00	2014-08-05 18:49:00
9474	2014-08-05 18:50:00	2014-08-05 18:59:00
9475	2014-08-05 19:00:00	2014-08-05 19:09:00
9476	2014-08-05 19:10:00	2014-08-05 19:19:00
9477	2014-08-05 19:20:00	2014-08-05 19:29:00
9478	2014-08-05 19:30:00	2014-08-05 19:39:00
9479	2014-08-05 19:40:00	2014-08-05 19:49:00
9480	2014-08-05 19:50:00	2014-08-05 19:59:00
9481	2014-08-05 20:00:00	2014-08-05 20:09:00
9482	2014-08-05 20:10:00	2014-08-05 20:19:00
9483	2014-08-05 20:20:00	2014-08-05 20:29:00
9484	2014-08-05 20:30:00	2014-08-05 20:39:00
9485	2014-08-05 20:40:00	2014-08-05 20:49:00
9486	2014-08-05 20:50:00	2014-08-05 20:59:00
9487	2014-08-05 21:00:00	2014-08-05 21:09:00
9488	2014-08-05 21:10:00	2014-08-05 21:19:00
9489	2014-08-05 21:20:00	2014-08-05 21:29:00
9490	2014-08-05 21:30:00	2014-08-05 21:39:00
9491	2014-08-05 21:40:00	2014-08-05 21:49:00
9492	2014-08-05 21:50:00	2014-08-05 21:59:00
9493	2014-08-05 22:00:00	2014-08-05 22:09:00
9494	2014-08-05 22:10:00	2014-08-05 22:19:00
9495	2014-08-05 22:20:00	2014-08-05 22:29:00
9496	2014-08-05 22:30:00	2014-08-05 22:39:00
9497	2014-08-05 22:40:00	2014-08-05 22:49:00
9498	2014-08-05 22:50:00	2014-08-05 22:59:00
9499	2014-08-05 23:00:00	2014-08-05 23:09:00
9500	2014-08-05 23:10:00	2014-08-05 23:19:00
9501	2014-08-05 23:20:00	2014-08-05 23:29:00
9502	2014-08-05 23:30:00	2014-08-05 23:39:00
9503	2014-08-05 23:40:00	2014-08-05 23:49:00
9504	2014-08-05 23:50:00	2014-08-05 23:59:00
9505	2014-08-06 00:00:00	2014-08-06 00:09:00
9506	2014-08-06 00:10:00	2014-08-06 00:19:00
9507	2014-08-06 00:20:00	2014-08-06 00:29:00
9508	2014-08-06 00:30:00	2014-08-06 00:39:00
9509	2014-08-06 00:40:00	2014-08-06 00:49:00
9510	2014-08-06 00:50:00	2014-08-06 00:59:00
9511	2014-08-06 01:00:00	2014-08-06 01:09:00
9512	2014-08-06 01:10:00	2014-08-06 01:19:00
9513	2014-08-06 01:20:00	2014-08-06 01:29:00
9514	2014-08-06 01:30:00	2014-08-06 01:39:00
9515	2014-08-06 01:40:00	2014-08-06 01:49:00
9516	2014-08-06 01:50:00	2014-08-06 01:59:00
9517	2014-08-06 02:00:00	2014-08-06 02:09:00
9518	2014-08-06 02:10:00	2014-08-06 02:19:00
9519	2014-08-06 02:20:00	2014-08-06 02:29:00
9520	2014-08-06 02:30:00	2014-08-06 02:39:00
9521	2014-08-06 02:40:00	2014-08-06 02:49:00
9522	2014-08-06 02:50:00	2014-08-06 02:59:00
9523	2014-08-06 03:00:00	2014-08-06 03:09:00
9524	2014-08-06 03:10:00	2014-08-06 03:19:00
9525	2014-08-06 03:20:00	2014-08-06 03:29:00
9526	2014-08-06 03:30:00	2014-08-06 03:39:00
9527	2014-08-06 03:40:00	2014-08-06 03:49:00
9528	2014-08-06 03:50:00	2014-08-06 03:59:00
9529	2014-08-06 04:00:00	2014-08-06 04:09:00
9530	2014-08-06 04:10:00	2014-08-06 04:19:00
9531	2014-08-06 04:20:00	2014-08-06 04:29:00
9532	2014-08-06 04:30:00	2014-08-06 04:39:00
9533	2014-08-06 04:40:00	2014-08-06 04:49:00
9534	2014-08-06 04:50:00	2014-08-06 04:59:00
9535	2014-08-06 05:00:00	2014-08-06 05:09:00
9536	2014-08-06 05:10:00	2014-08-06 05:19:00
9537	2014-08-06 05:20:00	2014-08-06 05:29:00
9538	2014-08-06 05:30:00	2014-08-06 05:39:00
9539	2014-08-06 05:40:00	2014-08-06 05:49:00
9540	2014-08-06 05:50:00	2014-08-06 05:59:00
9541	2014-08-06 06:00:00	2014-08-06 06:09:00
9542	2014-08-06 06:10:00	2014-08-06 06:19:00
9543	2014-08-06 06:20:00	2014-08-06 06:29:00
9544	2014-08-06 06:30:00	2014-08-06 06:39:00
9545	2014-08-06 06:40:00	2014-08-06 06:49:00
9546	2014-08-06 06:50:00	2014-08-06 06:59:00
9547	2014-08-06 07:00:00	2014-08-06 07:09:00
9548	2014-08-06 07:10:00	2014-08-06 07:19:00
9549	2014-08-06 07:20:00	2014-08-06 07:29:00
9550	2014-08-06 07:30:00	2014-08-06 07:39:00
9551	2014-08-06 07:40:00	2014-08-06 07:49:00
9552	2014-08-06 07:50:00	2014-08-06 07:59:00
9553	2014-08-06 08:00:00	2014-08-06 08:09:00
9554	2014-08-06 08:10:00	2014-08-06 08:19:00
9555	2014-08-06 08:20:00	2014-08-06 08:29:00
9556	2014-08-06 08:30:00	2014-08-06 08:39:00
9557	2014-08-06 08:40:00	2014-08-06 08:49:00
9558	2014-08-06 08:50:00	2014-08-06 08:59:00
9559	2014-08-06 09:00:00	2014-08-06 09:09:00
9560	2014-08-06 09:10:00	2014-08-06 09:19:00
9561	2014-08-06 09:20:00	2014-08-06 09:29:00
9562	2014-08-06 09:30:00	2014-08-06 09:39:00
9563	2014-08-06 09:40:00	2014-08-06 09:49:00
9564	2014-08-06 09:50:00	2014-08-06 09:59:00
9565	2014-08-06 10:00:00	2014-08-06 10:09:00
9566	2014-08-06 10:10:00	2014-08-06 10:19:00
9567	2014-08-06 10:20:00	2014-08-06 10:29:00
9568	2014-08-06 10:30:00	2014-08-06 10:39:00
9569	2014-08-06 10:40:00	2014-08-06 10:49:00
9570	2014-08-06 10:50:00	2014-08-06 10:59:00
9571	2014-08-06 11:00:00	2014-08-06 11:09:00
9572	2014-08-06 11:10:00	2014-08-06 11:19:00
9573	2014-08-06 11:20:00	2014-08-06 11:29:00
9574	2014-08-06 11:30:00	2014-08-06 11:39:00
9575	2014-08-06 11:40:00	2014-08-06 11:49:00
9576	2014-08-06 11:50:00	2014-08-06 11:59:00
9577	2014-08-06 12:00:00	2014-08-06 12:09:00
9578	2014-08-06 12:10:00	2014-08-06 12:19:00
9579	2014-08-06 12:20:00	2014-08-06 12:29:00
9580	2014-08-06 12:30:00	2014-08-06 12:39:00
9581	2014-08-06 12:40:00	2014-08-06 12:49:00
9582	2014-08-06 12:50:00	2014-08-06 12:59:00
9583	2014-08-06 13:00:00	2014-08-06 13:09:00
9584	2014-08-06 13:10:00	2014-08-06 13:19:00
9585	2014-08-06 13:20:00	2014-08-06 13:29:00
9586	2014-08-06 13:30:00	2014-08-06 13:39:00
9587	2014-08-06 13:40:00	2014-08-06 13:49:00
9588	2014-08-06 13:50:00	2014-08-06 13:59:00
9589	2014-08-06 14:00:00	2014-08-06 14:09:00
9590	2014-08-06 14:10:00	2014-08-06 14:19:00
9591	2014-08-06 14:20:00	2014-08-06 14:29:00
9592	2014-08-06 14:30:00	2014-08-06 14:39:00
9593	2014-08-06 14:40:00	2014-08-06 14:49:00
9594	2014-08-06 14:50:00	2014-08-06 14:59:00
9595	2014-08-06 15:00:00	2014-08-06 15:09:00
9596	2014-08-06 15:10:00	2014-08-06 15:19:00
9597	2014-08-06 15:20:00	2014-08-06 15:29:00
9598	2014-08-06 15:30:00	2014-08-06 15:39:00
9599	2014-08-06 15:40:00	2014-08-06 15:49:00
9600	2014-08-06 15:50:00	2014-08-06 15:59:00
9601	2014-08-06 16:00:00	2014-08-06 16:09:00
9602	2014-08-06 16:10:00	2014-08-06 16:19:00
9603	2014-08-06 16:20:00	2014-08-06 16:29:00
9604	2014-08-06 16:30:00	2014-08-06 16:39:00
9605	2014-08-06 16:40:00	2014-08-06 16:49:00
9606	2014-08-06 16:50:00	2014-08-06 16:59:00
9607	2014-08-06 17:00:00	2014-08-06 17:09:00
9608	2014-08-06 17:10:00	2014-08-06 17:19:00
9609	2014-08-06 17:20:00	2014-08-06 17:29:00
9610	2014-08-06 17:30:00	2014-08-06 17:39:00
9611	2014-08-06 17:40:00	2014-08-06 17:49:00
9612	2014-08-06 17:50:00	2014-08-06 17:59:00
9613	2014-08-06 18:00:00	2014-08-06 18:09:00
9614	2014-08-06 18:10:00	2014-08-06 18:19:00
9615	2014-08-06 18:20:00	2014-08-06 18:29:00
9616	2014-08-06 18:30:00	2014-08-06 18:39:00
9617	2014-08-06 18:40:00	2014-08-06 18:49:00
9618	2014-08-06 18:50:00	2014-08-06 18:59:00
9619	2014-08-06 19:00:00	2014-08-06 19:09:00
9620	2014-08-06 19:10:00	2014-08-06 19:19:00
9621	2014-08-06 19:20:00	2014-08-06 19:29:00
9622	2014-08-06 19:30:00	2014-08-06 19:39:00
9623	2014-08-06 19:40:00	2014-08-06 19:49:00
9624	2014-08-06 19:50:00	2014-08-06 19:59:00
9625	2014-08-06 20:00:00	2014-08-06 20:09:00
9626	2014-08-06 20:10:00	2014-08-06 20:19:00
9627	2014-08-06 20:20:00	2014-08-06 20:29:00
9628	2014-08-06 20:30:00	2014-08-06 20:39:00
9629	2014-08-06 20:40:00	2014-08-06 20:49:00
9630	2014-08-06 20:50:00	2014-08-06 20:59:00
9631	2014-08-06 21:00:00	2014-08-06 21:09:00
9632	2014-08-06 21:10:00	2014-08-06 21:19:00
9633	2014-08-06 21:20:00	2014-08-06 21:29:00
9634	2014-08-06 21:30:00	2014-08-06 21:39:00
9635	2014-08-06 21:40:00	2014-08-06 21:49:00
9636	2014-08-06 21:50:00	2014-08-06 21:59:00
9637	2014-08-06 22:00:00	2014-08-06 22:09:00
9638	2014-08-06 22:10:00	2014-08-06 22:19:00
9639	2014-08-06 22:20:00	2014-08-06 22:29:00
9640	2014-08-06 22:30:00	2014-08-06 22:39:00
9641	2014-08-06 22:40:00	2014-08-06 22:49:00
9642	2014-08-06 22:50:00	2014-08-06 22:59:00
9643	2014-08-06 23:00:00	2014-08-06 23:09:00
9644	2014-08-06 23:10:00	2014-08-06 23:19:00
9645	2014-08-06 23:20:00	2014-08-06 23:29:00
9646	2014-08-06 23:30:00	2014-08-06 23:39:00
9647	2014-08-06 23:40:00	2014-08-06 23:49:00
9648	2014-08-06 23:50:00	2014-08-06 23:59:00
9649	2014-08-07 00:00:00	2014-08-07 00:09:00
9650	2014-08-07 00:10:00	2014-08-07 00:19:00
9651	2014-08-07 00:20:00	2014-08-07 00:29:00
9652	2014-08-07 00:30:00	2014-08-07 00:39:00
9653	2014-08-07 00:40:00	2014-08-07 00:49:00
9654	2014-08-07 00:50:00	2014-08-07 00:59:00
9655	2014-08-07 01:00:00	2014-08-07 01:09:00
9656	2014-08-07 01:10:00	2014-08-07 01:19:00
9657	2014-08-07 01:20:00	2014-08-07 01:29:00
9658	2014-08-07 01:30:00	2014-08-07 01:39:00
9659	2014-08-07 01:40:00	2014-08-07 01:49:00
9660	2014-08-07 01:50:00	2014-08-07 01:59:00
9661	2014-08-07 02:00:00	2014-08-07 02:09:00
9662	2014-08-07 02:10:00	2014-08-07 02:19:00
9663	2014-08-07 02:20:00	2014-08-07 02:29:00
9664	2014-08-07 02:30:00	2014-08-07 02:39:00
9665	2014-08-07 02:40:00	2014-08-07 02:49:00
9666	2014-08-07 02:50:00	2014-08-07 02:59:00
9667	2014-08-07 03:00:00	2014-08-07 03:09:00
9668	2014-08-07 03:10:00	2014-08-07 03:19:00
9669	2014-08-07 03:20:00	2014-08-07 03:29:00
9670	2014-08-07 03:30:00	2014-08-07 03:39:00
9671	2014-08-07 03:40:00	2014-08-07 03:49:00
9672	2014-08-07 03:50:00	2014-08-07 03:59:00
9673	2014-08-07 04:00:00	2014-08-07 04:09:00
9674	2014-08-07 04:10:00	2014-08-07 04:19:00
9675	2014-08-07 04:20:00	2014-08-07 04:29:00
9676	2014-08-07 04:30:00	2014-08-07 04:39:00
9677	2014-08-07 04:40:00	2014-08-07 04:49:00
9678	2014-08-07 04:50:00	2014-08-07 04:59:00
9679	2014-08-07 05:00:00	2014-08-07 05:09:00
9680	2014-08-07 05:10:00	2014-08-07 05:19:00
9681	2014-08-07 05:20:00	2014-08-07 05:29:00
9682	2014-08-07 05:30:00	2014-08-07 05:39:00
9683	2014-08-07 05:40:00	2014-08-07 05:49:00
9684	2014-08-07 05:50:00	2014-08-07 05:59:00
9685	2014-08-07 06:00:00	2014-08-07 06:09:00
9686	2014-08-07 06:10:00	2014-08-07 06:19:00
9687	2014-08-07 06:20:00	2014-08-07 06:29:00
9688	2014-08-07 06:30:00	2014-08-07 06:39:00
9689	2014-08-07 06:40:00	2014-08-07 06:49:00
9690	2014-08-07 06:50:00	2014-08-07 06:59:00
9691	2014-08-07 07:00:00	2014-08-07 07:09:00
9692	2014-08-07 07:10:00	2014-08-07 07:19:00
9693	2014-08-07 07:20:00	2014-08-07 07:29:00
9694	2014-08-07 07:30:00	2014-08-07 07:39:00
9695	2014-08-07 07:40:00	2014-08-07 07:49:00
9696	2014-08-07 07:50:00	2014-08-07 07:59:00
9697	2014-08-07 08:00:00	2014-08-07 08:09:00
9698	2014-08-07 08:10:00	2014-08-07 08:19:00
9699	2014-08-07 08:20:00	2014-08-07 08:29:00
9700	2014-08-07 08:30:00	2014-08-07 08:39:00
9701	2014-08-07 08:40:00	2014-08-07 08:49:00
9702	2014-08-07 08:50:00	2014-08-07 08:59:00
9703	2014-08-07 09:00:00	2014-08-07 09:09:00
9704	2014-08-07 09:10:00	2014-08-07 09:19:00
9705	2014-08-07 09:20:00	2014-08-07 09:29:00
9706	2014-08-07 09:30:00	2014-08-07 09:39:00
9707	2014-08-07 09:40:00	2014-08-07 09:49:00
9708	2014-08-07 09:50:00	2014-08-07 09:59:00
9709	2014-08-07 10:00:00	2014-08-07 10:09:00
9710	2014-08-07 10:10:00	2014-08-07 10:19:00
9711	2014-08-07 10:20:00	2014-08-07 10:29:00
9712	2014-08-07 10:30:00	2014-08-07 10:39:00
9713	2014-08-07 10:40:00	2014-08-07 10:49:00
9714	2014-08-07 10:50:00	2014-08-07 10:59:00
9715	2014-08-07 11:00:00	2014-08-07 11:09:00
9716	2014-08-07 11:10:00	2014-08-07 11:19:00
9717	2014-08-07 11:20:00	2014-08-07 11:29:00
9718	2014-08-07 11:30:00	2014-08-07 11:39:00
9719	2014-08-07 11:40:00	2014-08-07 11:49:00
9720	2014-08-07 11:50:00	2014-08-07 11:59:00
9721	2014-08-07 12:00:00	2014-08-07 12:09:00
9722	2014-08-07 12:10:00	2014-08-07 12:19:00
9723	2014-08-07 12:20:00	2014-08-07 12:29:00
9724	2014-08-07 12:30:00	2014-08-07 12:39:00
9725	2014-08-07 12:40:00	2014-08-07 12:49:00
9726	2014-08-07 12:50:00	2014-08-07 12:59:00
9727	2014-08-07 13:00:00	2014-08-07 13:09:00
9728	2014-08-07 13:10:00	2014-08-07 13:19:00
9729	2014-08-07 13:20:00	2014-08-07 13:29:00
9730	2014-08-07 13:30:00	2014-08-07 13:39:00
9731	2014-08-07 13:40:00	2014-08-07 13:49:00
9732	2014-08-07 13:50:00	2014-08-07 13:59:00
9733	2014-08-07 14:00:00	2014-08-07 14:09:00
9734	2014-08-07 14:10:00	2014-08-07 14:19:00
9735	2014-08-07 14:20:00	2014-08-07 14:29:00
9736	2014-08-07 14:30:00	2014-08-07 14:39:00
9737	2014-08-07 14:40:00	2014-08-07 14:49:00
9738	2014-08-07 14:50:00	2014-08-07 14:59:00
9739	2014-08-07 15:00:00	2014-08-07 15:09:00
9740	2014-08-07 15:10:00	2014-08-07 15:19:00
9741	2014-08-07 15:20:00	2014-08-07 15:29:00
9742	2014-08-07 15:30:00	2014-08-07 15:39:00
9743	2014-08-07 15:40:00	2014-08-07 15:49:00
9744	2014-08-07 15:50:00	2014-08-07 15:59:00
9745	2014-08-07 16:00:00	2014-08-07 16:09:00
9746	2014-08-07 16:10:00	2014-08-07 16:19:00
9747	2014-08-07 16:20:00	2014-08-07 16:29:00
9748	2014-08-07 16:30:00	2014-08-07 16:39:00
9749	2014-08-07 16:40:00	2014-08-07 16:49:00
9750	2014-08-07 16:50:00	2014-08-07 16:59:00
9751	2014-08-07 17:00:00	2014-08-07 17:09:00
9752	2014-08-07 17:10:00	2014-08-07 17:19:00
9753	2014-08-07 17:20:00	2014-08-07 17:29:00
9754	2014-08-07 17:30:00	2014-08-07 17:39:00
9755	2014-08-07 17:40:00	2014-08-07 17:49:00
9756	2014-08-07 17:50:00	2014-08-07 17:59:00
9757	2014-08-07 18:00:00	2014-08-07 18:09:00
9758	2014-08-07 18:10:00	2014-08-07 18:19:00
9759	2014-08-07 18:20:00	2014-08-07 18:29:00
9760	2014-08-07 18:30:00	2014-08-07 18:39:00
9761	2014-08-07 18:40:00	2014-08-07 18:49:00
9762	2014-08-07 18:50:00	2014-08-07 18:59:00
9763	2014-08-07 19:00:00	2014-08-07 19:09:00
9764	2014-08-07 19:10:00	2014-08-07 19:19:00
9765	2014-08-07 19:20:00	2014-08-07 19:29:00
9766	2014-08-07 19:30:00	2014-08-07 19:39:00
9767	2014-08-07 19:40:00	2014-08-07 19:49:00
9768	2014-08-07 19:50:00	2014-08-07 19:59:00
9769	2014-08-07 20:00:00	2014-08-07 20:09:00
9770	2014-08-07 20:10:00	2014-08-07 20:19:00
9771	2014-08-07 20:20:00	2014-08-07 20:29:00
9772	2014-08-07 20:30:00	2014-08-07 20:39:00
9773	2014-08-07 20:40:00	2014-08-07 20:49:00
9774	2014-08-07 20:50:00	2014-08-07 20:59:00
9775	2014-08-07 21:00:00	2014-08-07 21:09:00
9776	2014-08-07 21:10:00	2014-08-07 21:19:00
9777	2014-08-07 21:20:00	2014-08-07 21:29:00
9778	2014-08-07 21:30:00	2014-08-07 21:39:00
9779	2014-08-07 21:40:00	2014-08-07 21:49:00
9780	2014-08-07 21:50:00	2014-08-07 21:59:00
9781	2014-08-07 22:00:00	2014-08-07 22:09:00
9782	2014-08-07 22:10:00	2014-08-07 22:19:00
9783	2014-08-07 22:20:00	2014-08-07 22:29:00
9784	2014-08-07 22:30:00	2014-08-07 22:39:00
9785	2014-08-07 22:40:00	2014-08-07 22:49:00
9786	2014-08-07 22:50:00	2014-08-07 22:59:00
9787	2014-08-07 23:00:00	2014-08-07 23:09:00
9788	2014-08-07 23:10:00	2014-08-07 23:19:00
9789	2014-08-07 23:20:00	2014-08-07 23:29:00
9790	2014-08-07 23:30:00	2014-08-07 23:39:00
9791	2014-08-07 23:40:00	2014-08-07 23:49:00
9792	2014-08-07 23:50:00	2014-08-07 23:59:00
9793	2014-08-08 00:00:00	2014-08-08 00:09:00
9794	2014-08-08 00:10:00	2014-08-08 00:19:00
9795	2014-08-08 00:20:00	2014-08-08 00:29:00
9796	2014-08-08 00:30:00	2014-08-08 00:39:00
9797	2014-08-08 00:40:00	2014-08-08 00:49:00
9798	2014-08-08 00:50:00	2014-08-08 00:59:00
9799	2014-08-08 01:00:00	2014-08-08 01:09:00
9800	2014-08-08 01:10:00	2014-08-08 01:19:00
9801	2014-08-08 01:20:00	2014-08-08 01:29:00
9802	2014-08-08 01:30:00	2014-08-08 01:39:00
9803	2014-08-08 01:40:00	2014-08-08 01:49:00
9804	2014-08-08 01:50:00	2014-08-08 01:59:00
9805	2014-08-08 02:00:00	2014-08-08 02:09:00
9806	2014-08-08 02:10:00	2014-08-08 02:19:00
9807	2014-08-08 02:20:00	2014-08-08 02:29:00
9808	2014-08-08 02:30:00	2014-08-08 02:39:00
9809	2014-08-08 02:40:00	2014-08-08 02:49:00
9810	2014-08-08 02:50:00	2014-08-08 02:59:00
9811	2014-08-08 03:00:00	2014-08-08 03:09:00
9812	2014-08-08 03:10:00	2014-08-08 03:19:00
9813	2014-08-08 03:20:00	2014-08-08 03:29:00
9814	2014-08-08 03:30:00	2014-08-08 03:39:00
9815	2014-08-08 03:40:00	2014-08-08 03:49:00
9816	2014-08-08 03:50:00	2014-08-08 03:59:00
9817	2014-08-08 04:00:00	2014-08-08 04:09:00
9818	2014-08-08 04:10:00	2014-08-08 04:19:00
9819	2014-08-08 04:20:00	2014-08-08 04:29:00
9820	2014-08-08 04:30:00	2014-08-08 04:39:00
9821	2014-08-08 04:40:00	2014-08-08 04:49:00
9822	2014-08-08 04:50:00	2014-08-08 04:59:00
9823	2014-08-08 05:00:00	2014-08-08 05:09:00
9824	2014-08-08 05:10:00	2014-08-08 05:19:00
9825	2014-08-08 05:20:00	2014-08-08 05:29:00
9826	2014-08-08 05:30:00	2014-08-08 05:39:00
9827	2014-08-08 05:40:00	2014-08-08 05:49:00
9828	2014-08-08 05:50:00	2014-08-08 05:59:00
9829	2014-08-08 06:00:00	2014-08-08 06:09:00
9830	2014-08-08 06:10:00	2014-08-08 06:19:00
9831	2014-08-08 06:20:00	2014-08-08 06:29:00
9832	2014-08-08 06:30:00	2014-08-08 06:39:00
9833	2014-08-08 06:40:00	2014-08-08 06:49:00
9834	2014-08-08 06:50:00	2014-08-08 06:59:00
9835	2014-08-08 07:00:00	2014-08-08 07:09:00
9836	2014-08-08 07:10:00	2014-08-08 07:19:00
9837	2014-08-08 07:20:00	2014-08-08 07:29:00
9838	2014-08-08 07:30:00	2014-08-08 07:39:00
9839	2014-08-08 07:40:00	2014-08-08 07:49:00
9840	2014-08-08 07:50:00	2014-08-08 07:59:00
9841	2014-08-08 08:00:00	2014-08-08 08:09:00
9842	2014-08-08 08:10:00	2014-08-08 08:19:00
9843	2014-08-08 08:20:00	2014-08-08 08:29:00
9844	2014-08-08 08:30:00	2014-08-08 08:39:00
9845	2014-08-08 08:40:00	2014-08-08 08:49:00
9846	2014-08-08 08:50:00	2014-08-08 08:59:00
9847	2014-08-08 09:00:00	2014-08-08 09:09:00
9848	2014-08-08 09:10:00	2014-08-08 09:19:00
9849	2014-08-08 09:20:00	2014-08-08 09:29:00
9850	2014-08-08 09:30:00	2014-08-08 09:39:00
9851	2014-08-08 09:40:00	2014-08-08 09:49:00
9852	2014-08-08 09:50:00	2014-08-08 09:59:00
9853	2014-08-08 10:00:00	2014-08-08 10:09:00
9854	2014-08-08 10:10:00	2014-08-08 10:19:00
9855	2014-08-08 10:20:00	2014-08-08 10:29:00
9856	2014-08-08 10:30:00	2014-08-08 10:39:00
9857	2014-08-08 10:40:00	2014-08-08 10:49:00
9858	2014-08-08 10:50:00	2014-08-08 10:59:00
9859	2014-08-08 11:00:00	2014-08-08 11:09:00
9860	2014-08-08 11:10:00	2014-08-08 11:19:00
9861	2014-08-08 11:20:00	2014-08-08 11:29:00
9862	2014-08-08 11:30:00	2014-08-08 11:39:00
9863	2014-08-08 11:40:00	2014-08-08 11:49:00
9864	2014-08-08 11:50:00	2014-08-08 11:59:00
9865	2014-08-08 12:00:00	2014-08-08 12:09:00
9866	2014-08-08 12:10:00	2014-08-08 12:19:00
9867	2014-08-08 12:20:00	2014-08-08 12:29:00
9868	2014-08-08 12:30:00	2014-08-08 12:39:00
9869	2014-08-08 12:40:00	2014-08-08 12:49:00
9870	2014-08-08 12:50:00	2014-08-08 12:59:00
9871	2014-08-08 13:00:00	2014-08-08 13:09:00
9872	2014-08-08 13:10:00	2014-08-08 13:19:00
9873	2014-08-08 13:20:00	2014-08-08 13:29:00
9874	2014-08-08 13:30:00	2014-08-08 13:39:00
9875	2014-08-08 13:40:00	2014-08-08 13:49:00
9876	2014-08-08 13:50:00	2014-08-08 13:59:00
9877	2014-08-08 14:00:00	2014-08-08 14:09:00
9878	2014-08-08 14:10:00	2014-08-08 14:19:00
9879	2014-08-08 14:20:00	2014-08-08 14:29:00
9880	2014-08-08 14:30:00	2014-08-08 14:39:00
9881	2014-08-08 14:40:00	2014-08-08 14:49:00
9882	2014-08-08 14:50:00	2014-08-08 14:59:00
9883	2014-08-08 15:00:00	2014-08-08 15:09:00
9884	2014-08-08 15:10:00	2014-08-08 15:19:00
9885	2014-08-08 15:20:00	2014-08-08 15:29:00
9886	2014-08-08 15:30:00	2014-08-08 15:39:00
9887	2014-08-08 15:40:00	2014-08-08 15:49:00
9888	2014-08-08 15:50:00	2014-08-08 15:59:00
9889	2014-08-08 16:00:00	2014-08-08 16:09:00
9890	2014-08-08 16:10:00	2014-08-08 16:19:00
9891	2014-08-08 16:20:00	2014-08-08 16:29:00
9892	2014-08-08 16:30:00	2014-08-08 16:39:00
9893	2014-08-08 16:40:00	2014-08-08 16:49:00
9894	2014-08-08 16:50:00	2014-08-08 16:59:00
9895	2014-08-08 17:00:00	2014-08-08 17:09:00
9896	2014-08-08 17:10:00	2014-08-08 17:19:00
9897	2014-08-08 17:20:00	2014-08-08 17:29:00
9898	2014-08-08 17:30:00	2014-08-08 17:39:00
9899	2014-08-08 17:40:00	2014-08-08 17:49:00
9900	2014-08-08 17:50:00	2014-08-08 17:59:00
9901	2014-08-08 18:00:00	2014-08-08 18:09:00
9902	2014-08-08 18:10:00	2014-08-08 18:19:00
9903	2014-08-08 18:20:00	2014-08-08 18:29:00
9904	2014-08-08 18:30:00	2014-08-08 18:39:00
9905	2014-08-08 18:40:00	2014-08-08 18:49:00
9906	2014-08-08 18:50:00	2014-08-08 18:59:00
9907	2014-08-08 19:00:00	2014-08-08 19:09:00
9908	2014-08-08 19:10:00	2014-08-08 19:19:00
9909	2014-08-08 19:20:00	2014-08-08 19:29:00
9910	2014-08-08 19:30:00	2014-08-08 19:39:00
9911	2014-08-08 19:40:00	2014-08-08 19:49:00
9912	2014-08-08 19:50:00	2014-08-08 19:59:00
9913	2014-08-08 20:00:00	2014-08-08 20:09:00
9914	2014-08-08 20:10:00	2014-08-08 20:19:00
9915	2014-08-08 20:20:00	2014-08-08 20:29:00
9916	2014-08-08 20:30:00	2014-08-08 20:39:00
9917	2014-08-08 20:40:00	2014-08-08 20:49:00
9918	2014-08-08 20:50:00	2014-08-08 20:59:00
9919	2014-08-08 21:00:00	2014-08-08 21:09:00
9920	2014-08-08 21:10:00	2014-08-08 21:19:00
9921	2014-08-08 21:20:00	2014-08-08 21:29:00
9922	2014-08-08 21:30:00	2014-08-08 21:39:00
9923	2014-08-08 21:40:00	2014-08-08 21:49:00
9924	2014-08-08 21:50:00	2014-08-08 21:59:00
9925	2014-08-08 22:00:00	2014-08-08 22:09:00
9926	2014-08-08 22:10:00	2014-08-08 22:19:00
9927	2014-08-08 22:20:00	2014-08-08 22:29:00
9928	2014-08-08 22:30:00	2014-08-08 22:39:00
9929	2014-08-08 22:40:00	2014-08-08 22:49:00
9930	2014-08-08 22:50:00	2014-08-08 22:59:00
9931	2014-08-08 23:00:00	2014-08-08 23:09:00
9932	2014-08-08 23:10:00	2014-08-08 23:19:00
9933	2014-08-08 23:20:00	2014-08-08 23:29:00
9934	2014-08-08 23:30:00	2014-08-08 23:39:00
9935	2014-08-08 23:40:00	2014-08-08 23:49:00
9936	2014-08-08 23:50:00	2014-08-08 23:59:00
9937	2014-08-09 00:00:00	2014-08-09 00:09:00
9938	2014-08-09 00:10:00	2014-08-09 00:19:00
9939	2014-08-09 00:20:00	2014-08-09 00:29:00
9940	2014-08-09 00:30:00	2014-08-09 00:39:00
9941	2014-08-09 00:40:00	2014-08-09 00:49:00
9942	2014-08-09 00:50:00	2014-08-09 00:59:00
9943	2014-08-09 01:00:00	2014-08-09 01:09:00
9944	2014-08-09 01:10:00	2014-08-09 01:19:00
9945	2014-08-09 01:20:00	2014-08-09 01:29:00
9946	2014-08-09 01:30:00	2014-08-09 01:39:00
9947	2014-08-09 01:40:00	2014-08-09 01:49:00
9948	2014-08-09 01:50:00	2014-08-09 01:59:00
9949	2014-08-09 02:00:00	2014-08-09 02:09:00
9950	2014-08-09 02:10:00	2014-08-09 02:19:00
9951	2014-08-09 02:20:00	2014-08-09 02:29:00
9952	2014-08-09 02:30:00	2014-08-09 02:39:00
9953	2014-08-09 02:40:00	2014-08-09 02:49:00
9954	2014-08-09 02:50:00	2014-08-09 02:59:00
9955	2014-08-09 03:00:00	2014-08-09 03:09:00
9956	2014-08-09 03:10:00	2014-08-09 03:19:00
9957	2014-08-09 03:20:00	2014-08-09 03:29:00
9958	2014-08-09 03:30:00	2014-08-09 03:39:00
9959	2014-08-09 03:40:00	2014-08-09 03:49:00
9960	2014-08-09 03:50:00	2014-08-09 03:59:00
9961	2014-08-09 04:00:00	2014-08-09 04:09:00
9962	2014-08-09 04:10:00	2014-08-09 04:19:00
9963	2014-08-09 04:20:00	2014-08-09 04:29:00
9964	2014-08-09 04:30:00	2014-08-09 04:39:00
9965	2014-08-09 04:40:00	2014-08-09 04:49:00
9966	2014-08-09 04:50:00	2014-08-09 04:59:00
9967	2014-08-09 05:00:00	2014-08-09 05:09:00
9968	2014-08-09 05:10:00	2014-08-09 05:19:00
9969	2014-08-09 05:20:00	2014-08-09 05:29:00
9970	2014-08-09 05:30:00	2014-08-09 05:39:00
9971	2014-08-09 05:40:00	2014-08-09 05:49:00
9972	2014-08-09 05:50:00	2014-08-09 05:59:00
9973	2014-08-09 06:00:00	2014-08-09 06:09:00
9974	2014-08-09 06:10:00	2014-08-09 06:19:00
9975	2014-08-09 06:20:00	2014-08-09 06:29:00
9976	2014-08-09 06:30:00	2014-08-09 06:39:00
9977	2014-08-09 06:40:00	2014-08-09 06:49:00
9978	2014-08-09 06:50:00	2014-08-09 06:59:00
9979	2014-08-09 07:00:00	2014-08-09 07:09:00
9980	2014-08-09 07:10:00	2014-08-09 07:19:00
9981	2014-08-09 07:20:00	2014-08-09 07:29:00
9982	2014-08-09 07:30:00	2014-08-09 07:39:00
9983	2014-08-09 07:40:00	2014-08-09 07:49:00
9984	2014-08-09 07:50:00	2014-08-09 07:59:00
9985	2014-08-09 08:00:00	2014-08-09 08:09:00
9986	2014-08-09 08:10:00	2014-08-09 08:19:00
9987	2014-08-09 08:20:00	2014-08-09 08:29:00
9988	2014-08-09 08:30:00	2014-08-09 08:39:00
9989	2014-08-09 08:40:00	2014-08-09 08:49:00
9990	2014-08-09 08:50:00	2014-08-09 08:59:00
9991	2014-08-09 09:00:00	2014-08-09 09:09:00
9992	2014-08-09 09:10:00	2014-08-09 09:19:00
9993	2014-08-09 09:20:00	2014-08-09 09:29:00
9994	2014-08-09 09:30:00	2014-08-09 09:39:00
9995	2014-08-09 09:40:00	2014-08-09 09:49:00
9996	2014-08-09 09:50:00	2014-08-09 09:59:00
9997	2014-08-09 10:00:00	2014-08-09 10:09:00
9998	2014-08-09 10:10:00	2014-08-09 10:19:00
9999	2014-08-09 10:20:00	2014-08-09 10:29:00
10000	2014-08-09 10:30:00	2014-08-09 10:39:00
10001	2014-08-09 10:40:00	2014-08-09 10:49:00
10002	2014-08-09 10:50:00	2014-08-09 10:59:00
10003	2014-08-09 11:00:00	2014-08-09 11:09:00
10004	2014-08-09 11:10:00	2014-08-09 11:19:00
10005	2014-08-09 11:20:00	2014-08-09 11:29:00
10006	2014-08-09 11:30:00	2014-08-09 11:39:00
10007	2014-08-09 11:40:00	2014-08-09 11:49:00
10008	2014-08-09 11:50:00	2014-08-09 11:59:00
10009	2014-08-09 12:00:00	2014-08-09 12:09:00
10010	2014-08-09 12:10:00	2014-08-09 12:19:00
10011	2014-08-09 12:20:00	2014-08-09 12:29:00
10012	2014-08-09 12:30:00	2014-08-09 12:39:00
10013	2014-08-09 12:40:00	2014-08-09 12:49:00
10014	2014-08-09 12:50:00	2014-08-09 12:59:00
10015	2014-08-09 13:00:00	2014-08-09 13:09:00
10016	2014-08-09 13:10:00	2014-08-09 13:19:00
10017	2014-08-09 13:20:00	2014-08-09 13:29:00
10018	2014-08-09 13:30:00	2014-08-09 13:39:00
10019	2014-08-09 13:40:00	2014-08-09 13:49:00
10020	2014-08-09 13:50:00	2014-08-09 13:59:00
10021	2014-08-09 14:00:00	2014-08-09 14:09:00
10022	2014-08-09 14:10:00	2014-08-09 14:19:00
10023	2014-08-09 14:20:00	2014-08-09 14:29:00
10024	2014-08-09 14:30:00	2014-08-09 14:39:00
10025	2014-08-09 14:40:00	2014-08-09 14:49:00
10026	2014-08-09 14:50:00	2014-08-09 14:59:00
10027	2014-08-09 15:00:00	2014-08-09 15:09:00
10028	2014-08-09 15:10:00	2014-08-09 15:19:00
10029	2014-08-09 15:20:00	2014-08-09 15:29:00
10030	2014-08-09 15:30:00	2014-08-09 15:39:00
10031	2014-08-09 15:40:00	2014-08-09 15:49:00
10032	2014-08-09 15:50:00	2014-08-09 15:59:00
10033	2014-08-09 16:00:00	2014-08-09 16:09:00
10034	2014-08-09 16:10:00	2014-08-09 16:19:00
10035	2014-08-09 16:20:00	2014-08-09 16:29:00
10036	2014-08-09 16:30:00	2014-08-09 16:39:00
10037	2014-08-09 16:40:00	2014-08-09 16:49:00
10038	2014-08-09 16:50:00	2014-08-09 16:59:00
10039	2014-08-09 17:00:00	2014-08-09 17:09:00
10040	2014-08-09 17:10:00	2014-08-09 17:19:00
10041	2014-08-09 17:20:00	2014-08-09 17:29:00
10042	2014-08-09 17:30:00	2014-08-09 17:39:00
10043	2014-08-09 17:40:00	2014-08-09 17:49:00
10044	2014-08-09 17:50:00	2014-08-09 17:59:00
10045	2014-08-09 18:00:00	2014-08-09 18:09:00
10046	2014-08-09 18:10:00	2014-08-09 18:19:00
10047	2014-08-09 18:20:00	2014-08-09 18:29:00
10048	2014-08-09 18:30:00	2014-08-09 18:39:00
10049	2014-08-09 18:40:00	2014-08-09 18:49:00
10050	2014-08-09 18:50:00	2014-08-09 18:59:00
10051	2014-08-09 19:00:00	2014-08-09 19:09:00
10052	2014-08-09 19:10:00	2014-08-09 19:19:00
10053	2014-08-09 19:20:00	2014-08-09 19:29:00
10054	2014-08-09 19:30:00	2014-08-09 19:39:00
10055	2014-08-09 19:40:00	2014-08-09 19:49:00
10056	2014-08-09 19:50:00	2014-08-09 19:59:00
10057	2014-08-09 20:00:00	2014-08-09 20:09:00
10058	2014-08-09 20:10:00	2014-08-09 20:19:00
10059	2014-08-09 20:20:00	2014-08-09 20:29:00
10060	2014-08-09 20:30:00	2014-08-09 20:39:00
10061	2014-08-09 20:40:00	2014-08-09 20:49:00
10062	2014-08-09 20:50:00	2014-08-09 20:59:00
10063	2014-08-09 21:00:00	2014-08-09 21:09:00
10064	2014-08-09 21:10:00	2014-08-09 21:19:00
10065	2014-08-09 21:20:00	2014-08-09 21:29:00
10066	2014-08-09 21:30:00	2014-08-09 21:39:00
10067	2014-08-09 21:40:00	2014-08-09 21:49:00
10068	2014-08-09 21:50:00	2014-08-09 21:59:00
10069	2014-08-09 22:00:00	2014-08-09 22:09:00
10070	2014-08-09 22:10:00	2014-08-09 22:19:00
10071	2014-08-09 22:20:00	2014-08-09 22:29:00
10072	2014-08-09 22:30:00	2014-08-09 22:39:00
10073	2014-08-09 22:40:00	2014-08-09 22:49:00
10074	2014-08-09 22:50:00	2014-08-09 22:59:00
10075	2014-08-09 23:00:00	2014-08-09 23:09:00
10076	2014-08-09 23:10:00	2014-08-09 23:19:00
10077	2014-08-09 23:20:00	2014-08-09 23:29:00
10078	2014-08-09 23:30:00	2014-08-09 23:39:00
10079	2014-08-09 23:40:00	2014-08-09 23:49:00
10080	2014-08-09 23:50:00	2014-08-09 23:59:00
10081	2014-08-10 00:00:00	2014-08-10 00:09:00
10082	2014-08-10 00:10:00	2014-08-10 00:19:00
10083	2014-08-10 00:20:00	2014-08-10 00:29:00
10084	2014-08-10 00:30:00	2014-08-10 00:39:00
10085	2014-08-10 00:40:00	2014-08-10 00:49:00
10086	2014-08-10 00:50:00	2014-08-10 00:59:00
10087	2014-08-10 01:00:00	2014-08-10 01:09:00
10088	2014-08-10 01:10:00	2014-08-10 01:19:00
10089	2014-08-10 01:20:00	2014-08-10 01:29:00
10090	2014-08-10 01:30:00	2014-08-10 01:39:00
10091	2014-08-10 01:40:00	2014-08-10 01:49:00
10092	2014-08-10 01:50:00	2014-08-10 01:59:00
10093	2014-08-10 02:00:00	2014-08-10 02:09:00
10094	2014-08-10 02:10:00	2014-08-10 02:19:00
10095	2014-08-10 02:20:00	2014-08-10 02:29:00
10096	2014-08-10 02:30:00	2014-08-10 02:39:00
10097	2014-08-10 02:40:00	2014-08-10 02:49:00
10098	2014-08-10 02:50:00	2014-08-10 02:59:00
10099	2014-08-10 03:00:00	2014-08-10 03:09:00
10100	2014-08-10 03:10:00	2014-08-10 03:19:00
10101	2014-08-10 03:20:00	2014-08-10 03:29:00
10102	2014-08-10 03:30:00	2014-08-10 03:39:00
10103	2014-08-10 03:40:00	2014-08-10 03:49:00
10104	2014-08-10 03:50:00	2014-08-10 03:59:00
10105	2014-08-10 04:00:00	2014-08-10 04:09:00
10106	2014-08-10 04:10:00	2014-08-10 04:19:00
10107	2014-08-10 04:20:00	2014-08-10 04:29:00
10108	2014-08-10 04:30:00	2014-08-10 04:39:00
10109	2014-08-10 04:40:00	2014-08-10 04:49:00
10110	2014-08-10 04:50:00	2014-08-10 04:59:00
10111	2014-08-10 05:00:00	2014-08-10 05:09:00
10112	2014-08-10 05:10:00	2014-08-10 05:19:00
10113	2014-08-10 05:20:00	2014-08-10 05:29:00
10114	2014-08-10 05:30:00	2014-08-10 05:39:00
10115	2014-08-10 05:40:00	2014-08-10 05:49:00
10116	2014-08-10 05:50:00	2014-08-10 05:59:00
10117	2014-08-10 06:00:00	2014-08-10 06:09:00
10118	2014-08-10 06:10:00	2014-08-10 06:19:00
10119	2014-08-10 06:20:00	2014-08-10 06:29:00
10120	2014-08-10 06:30:00	2014-08-10 06:39:00
10121	2014-08-10 06:40:00	2014-08-10 06:49:00
10122	2014-08-10 06:50:00	2014-08-10 06:59:00
10123	2014-08-10 07:00:00	2014-08-10 07:09:00
10124	2014-08-10 07:10:00	2014-08-10 07:19:00
10125	2014-08-10 07:20:00	2014-08-10 07:29:00
10126	2014-08-10 07:30:00	2014-08-10 07:39:00
10127	2014-08-10 07:40:00	2014-08-10 07:49:00
10128	2014-08-10 07:50:00	2014-08-10 07:59:00
10129	2014-08-10 08:00:00	2014-08-10 08:09:00
10130	2014-08-10 08:10:00	2014-08-10 08:19:00
10131	2014-08-10 08:20:00	2014-08-10 08:29:00
10132	2014-08-10 08:30:00	2014-08-10 08:39:00
10133	2014-08-10 08:40:00	2014-08-10 08:49:00
10134	2014-08-10 08:50:00	2014-08-10 08:59:00
10135	2014-08-10 09:00:00	2014-08-10 09:09:00
10136	2014-08-10 09:10:00	2014-08-10 09:19:00
10137	2014-08-10 09:20:00	2014-08-10 09:29:00
10138	2014-08-10 09:30:00	2014-08-10 09:39:00
10139	2014-08-10 09:40:00	2014-08-10 09:49:00
10140	2014-08-10 09:50:00	2014-08-10 09:59:00
10141	2014-08-10 10:00:00	2014-08-10 10:09:00
10142	2014-08-10 10:10:00	2014-08-10 10:19:00
10143	2014-08-10 10:20:00	2014-08-10 10:29:00
10144	2014-08-10 10:30:00	2014-08-10 10:39:00
10145	2014-08-10 10:40:00	2014-08-10 10:49:00
10146	2014-08-10 10:50:00	2014-08-10 10:59:00
10147	2014-08-10 11:00:00	2014-08-10 11:09:00
10148	2014-08-10 11:10:00	2014-08-10 11:19:00
10149	2014-08-10 11:20:00	2014-08-10 11:29:00
10150	2014-08-10 11:30:00	2014-08-10 11:39:00
10151	2014-08-10 11:40:00	2014-08-10 11:49:00
10152	2014-08-10 11:50:00	2014-08-10 11:59:00
10153	2014-08-10 12:00:00	2014-08-10 12:09:00
10154	2014-08-10 12:10:00	2014-08-10 12:19:00
10155	2014-08-10 12:20:00	2014-08-10 12:29:00
10156	2014-08-10 12:30:00	2014-08-10 12:39:00
10157	2014-08-10 12:40:00	2014-08-10 12:49:00
10158	2014-08-10 12:50:00	2014-08-10 12:59:00
10159	2014-08-10 13:00:00	2014-08-10 13:09:00
10160	2014-08-10 13:10:00	2014-08-10 13:19:00
10161	2014-08-10 13:20:00	2014-08-10 13:29:00
10162	2014-08-10 13:30:00	2014-08-10 13:39:00
10163	2014-08-10 13:40:00	2014-08-10 13:49:00
10164	2014-08-10 13:50:00	2014-08-10 13:59:00
10165	2014-08-10 14:00:00	2014-08-10 14:09:00
10166	2014-08-10 14:10:00	2014-08-10 14:19:00
10167	2014-08-10 14:20:00	2014-08-10 14:29:00
10168	2014-08-10 14:30:00	2014-08-10 14:39:00
10169	2014-08-10 14:40:00	2014-08-10 14:49:00
10170	2014-08-10 14:50:00	2014-08-10 14:59:00
10171	2014-08-10 15:00:00	2014-08-10 15:09:00
10172	2014-08-10 15:10:00	2014-08-10 15:19:00
10173	2014-08-10 15:20:00	2014-08-10 15:29:00
10174	2014-08-10 15:30:00	2014-08-10 15:39:00
10175	2014-08-10 15:40:00	2014-08-10 15:49:00
10176	2014-08-10 15:50:00	2014-08-10 15:59:00
10177	2014-08-10 16:00:00	2014-08-10 16:09:00
10178	2014-08-10 16:10:00	2014-08-10 16:19:00
10179	2014-08-10 16:20:00	2014-08-10 16:29:00
10180	2014-08-10 16:30:00	2014-08-10 16:39:00
10181	2014-08-10 16:40:00	2014-08-10 16:49:00
10182	2014-08-10 16:50:00	2014-08-10 16:59:00
10183	2014-08-10 17:00:00	2014-08-10 17:09:00
10184	2014-08-10 17:10:00	2014-08-10 17:19:00
10185	2014-08-10 17:20:00	2014-08-10 17:29:00
10186	2014-08-10 17:30:00	2014-08-10 17:39:00
10187	2014-08-10 17:40:00	2014-08-10 17:49:00
10188	2014-08-10 17:50:00	2014-08-10 17:59:00
10189	2014-08-10 18:00:00	2014-08-10 18:09:00
10190	2014-08-10 18:10:00	2014-08-10 18:19:00
10191	2014-08-10 18:20:00	2014-08-10 18:29:00
10192	2014-08-10 18:30:00	2014-08-10 18:39:00
10193	2014-08-10 18:40:00	2014-08-10 18:49:00
10194	2014-08-10 18:50:00	2014-08-10 18:59:00
10195	2014-08-10 19:00:00	2014-08-10 19:09:00
10196	2014-08-10 19:10:00	2014-08-10 19:19:00
10197	2014-08-10 19:20:00	2014-08-10 19:29:00
10198	2014-08-10 19:30:00	2014-08-10 19:39:00
10199	2014-08-10 19:40:00	2014-08-10 19:49:00
10200	2014-08-10 19:50:00	2014-08-10 19:59:00
10201	2014-08-10 20:00:00	2014-08-10 20:09:00
10202	2014-08-10 20:10:00	2014-08-10 20:19:00
10203	2014-08-10 20:20:00	2014-08-10 20:29:00
10204	2014-08-10 20:30:00	2014-08-10 20:39:00
10205	2014-08-10 20:40:00	2014-08-10 20:49:00
10206	2014-08-10 20:50:00	2014-08-10 20:59:00
10207	2014-08-10 21:00:00	2014-08-10 21:09:00
10208	2014-08-10 21:10:00	2014-08-10 21:19:00
10209	2014-08-10 21:20:00	2014-08-10 21:29:00
10210	2014-08-10 21:30:00	2014-08-10 21:39:00
10211	2014-08-10 21:40:00	2014-08-10 21:49:00
10212	2014-08-10 21:50:00	2014-08-10 21:59:00
10213	2014-08-10 22:00:00	2014-08-10 22:09:00
10214	2014-08-10 22:10:00	2014-08-10 22:19:00
10215	2014-08-10 22:20:00	2014-08-10 22:29:00
10216	2014-08-10 22:30:00	2014-08-10 22:39:00
10217	2014-08-10 22:40:00	2014-08-10 22:49:00
10218	2014-08-10 22:50:00	2014-08-10 22:59:00
10219	2014-08-10 23:00:00	2014-08-10 23:09:00
10220	2014-08-10 23:10:00	2014-08-10 23:19:00
10221	2014-08-10 23:20:00	2014-08-10 23:29:00
10222	2014-08-10 23:30:00	2014-08-10 23:39:00
10223	2014-08-10 23:40:00	2014-08-10 23:49:00
10224	2014-08-10 23:50:00	2014-08-10 23:59:00
10225	2014-08-11 00:00:00	2014-08-11 00:09:00
10226	2014-08-11 00:10:00	2014-08-11 00:19:00
10227	2014-08-11 00:20:00	2014-08-11 00:29:00
10228	2014-08-11 00:30:00	2014-08-11 00:39:00
10229	2014-08-11 00:40:00	2014-08-11 00:49:00
10230	2014-08-11 00:50:00	2014-08-11 00:59:00
10231	2014-08-11 01:00:00	2014-08-11 01:09:00
10232	2014-08-11 01:10:00	2014-08-11 01:19:00
10233	2014-08-11 01:20:00	2014-08-11 01:29:00
10234	2014-08-11 01:30:00	2014-08-11 01:39:00
10235	2014-08-11 01:40:00	2014-08-11 01:49:00
10236	2014-08-11 01:50:00	2014-08-11 01:59:00
10237	2014-08-11 02:00:00	2014-08-11 02:09:00
10238	2014-08-11 02:10:00	2014-08-11 02:19:00
10239	2014-08-11 02:20:00	2014-08-11 02:29:00
10240	2014-08-11 02:30:00	2014-08-11 02:39:00
10241	2014-08-11 02:40:00	2014-08-11 02:49:00
10242	2014-08-11 02:50:00	2014-08-11 02:59:00
10243	2014-08-11 03:00:00	2014-08-11 03:09:00
10244	2014-08-11 03:10:00	2014-08-11 03:19:00
10245	2014-08-11 03:20:00	2014-08-11 03:29:00
10246	2014-08-11 03:30:00	2014-08-11 03:39:00
10247	2014-08-11 03:40:00	2014-08-11 03:49:00
10248	2014-08-11 03:50:00	2014-08-11 03:59:00
10249	2014-08-11 04:00:00	2014-08-11 04:09:00
10250	2014-08-11 04:10:00	2014-08-11 04:19:00
10251	2014-08-11 04:20:00	2014-08-11 04:29:00
10252	2014-08-11 04:30:00	2014-08-11 04:39:00
10253	2014-08-11 04:40:00	2014-08-11 04:49:00
10254	2014-08-11 04:50:00	2014-08-11 04:59:00
10255	2014-08-11 05:00:00	2014-08-11 05:09:00
10256	2014-08-11 05:10:00	2014-08-11 05:19:00
10257	2014-08-11 05:20:00	2014-08-11 05:29:00
10258	2014-08-11 05:30:00	2014-08-11 05:39:00
10259	2014-08-11 05:40:00	2014-08-11 05:49:00
10260	2014-08-11 05:50:00	2014-08-11 05:59:00
10261	2014-08-11 06:00:00	2014-08-11 06:09:00
10262	2014-08-11 06:10:00	2014-08-11 06:19:00
10263	2014-08-11 06:20:00	2014-08-11 06:29:00
10264	2014-08-11 06:30:00	2014-08-11 06:39:00
10265	2014-08-11 06:40:00	2014-08-11 06:49:00
10266	2014-08-11 06:50:00	2014-08-11 06:59:00
10267	2014-08-11 07:00:00	2014-08-11 07:09:00
10268	2014-08-11 07:10:00	2014-08-11 07:19:00
10269	2014-08-11 07:20:00	2014-08-11 07:29:00
10270	2014-08-11 07:30:00	2014-08-11 07:39:00
10271	2014-08-11 07:40:00	2014-08-11 07:49:00
10272	2014-08-11 07:50:00	2014-08-11 07:59:00
10273	2014-08-11 08:00:00	2014-08-11 08:09:00
10274	2014-08-11 08:10:00	2014-08-11 08:19:00
10275	2014-08-11 08:20:00	2014-08-11 08:29:00
10276	2014-08-11 08:30:00	2014-08-11 08:39:00
10277	2014-08-11 08:40:00	2014-08-11 08:49:00
10278	2014-08-11 08:50:00	2014-08-11 08:59:00
10279	2014-08-11 09:00:00	2014-08-11 09:09:00
10280	2014-08-11 09:10:00	2014-08-11 09:19:00
10281	2014-08-11 09:20:00	2014-08-11 09:29:00
10282	2014-08-11 09:30:00	2014-08-11 09:39:00
10283	2014-08-11 09:40:00	2014-08-11 09:49:00
10284	2014-08-11 09:50:00	2014-08-11 09:59:00
10285	2014-08-11 10:00:00	2014-08-11 10:09:00
10286	2014-08-11 10:10:00	2014-08-11 10:19:00
10287	2014-08-11 10:20:00	2014-08-11 10:29:00
10288	2014-08-11 10:30:00	2014-08-11 10:39:00
10289	2014-08-11 10:40:00	2014-08-11 10:49:00
10290	2014-08-11 10:50:00	2014-08-11 10:59:00
10291	2014-08-11 11:00:00	2014-08-11 11:09:00
10292	2014-08-11 11:10:00	2014-08-11 11:19:00
10293	2014-08-11 11:20:00	2014-08-11 11:29:00
10294	2014-08-11 11:30:00	2014-08-11 11:39:00
10295	2014-08-11 11:40:00	2014-08-11 11:49:00
10296	2014-08-11 11:50:00	2014-08-11 11:59:00
10297	2014-08-11 12:00:00	2014-08-11 12:09:00
10298	2014-08-11 12:10:00	2014-08-11 12:19:00
10299	2014-08-11 12:20:00	2014-08-11 12:29:00
10300	2014-08-11 12:30:00	2014-08-11 12:39:00
10301	2014-08-11 12:40:00	2014-08-11 12:49:00
10302	2014-08-11 12:50:00	2014-08-11 12:59:00
10303	2014-08-11 13:00:00	2014-08-11 13:09:00
10304	2014-08-11 13:10:00	2014-08-11 13:19:00
10305	2014-08-11 13:20:00	2014-08-11 13:29:00
10306	2014-08-11 13:30:00	2014-08-11 13:39:00
10307	2014-08-11 13:40:00	2014-08-11 13:49:00
10308	2014-08-11 13:50:00	2014-08-11 13:59:00
10309	2014-08-11 14:00:00	2014-08-11 14:09:00
10310	2014-08-11 14:10:00	2014-08-11 14:19:00
10311	2014-08-11 14:20:00	2014-08-11 14:29:00
10312	2014-08-11 14:30:00	2014-08-11 14:39:00
10313	2014-08-11 14:40:00	2014-08-11 14:49:00
10314	2014-08-11 14:50:00	2014-08-11 14:59:00
10315	2014-08-11 15:00:00	2014-08-11 15:09:00
10316	2014-08-11 15:10:00	2014-08-11 15:19:00
10317	2014-08-11 15:20:00	2014-08-11 15:29:00
10318	2014-08-11 15:30:00	2014-08-11 15:39:00
10319	2014-08-11 15:40:00	2014-08-11 15:49:00
10320	2014-08-11 15:50:00	2014-08-11 15:59:00
10321	2014-08-11 16:00:00	2014-08-11 16:09:00
10322	2014-08-11 16:10:00	2014-08-11 16:19:00
10323	2014-08-11 16:20:00	2014-08-11 16:29:00
10324	2014-08-11 16:30:00	2014-08-11 16:39:00
10325	2014-08-11 16:40:00	2014-08-11 16:49:00
10326	2014-08-11 16:50:00	2014-08-11 16:59:00
10327	2014-08-11 17:00:00	2014-08-11 17:09:00
10328	2014-08-11 17:10:00	2014-08-11 17:19:00
10329	2014-08-11 17:20:00	2014-08-11 17:29:00
10330	2014-08-11 17:30:00	2014-08-11 17:39:00
10331	2014-08-11 17:40:00	2014-08-11 17:49:00
10332	2014-08-11 17:50:00	2014-08-11 17:59:00
10333	2014-08-11 18:00:00	2014-08-11 18:09:00
10334	2014-08-11 18:10:00	2014-08-11 18:19:00
10335	2014-08-11 18:20:00	2014-08-11 18:29:00
10336	2014-08-11 18:30:00	2014-08-11 18:39:00
10337	2014-08-11 18:40:00	2014-08-11 18:49:00
10338	2014-08-11 18:50:00	2014-08-11 18:59:00
10339	2014-08-11 19:00:00	2014-08-11 19:09:00
10340	2014-08-11 19:10:00	2014-08-11 19:19:00
10341	2014-08-11 19:20:00	2014-08-11 19:29:00
10342	2014-08-11 19:30:00	2014-08-11 19:39:00
10343	2014-08-11 19:40:00	2014-08-11 19:49:00
10344	2014-08-11 19:50:00	2014-08-11 19:59:00
10345	2014-08-11 20:00:00	2014-08-11 20:09:00
10346	2014-08-11 20:10:00	2014-08-11 20:19:00
10347	2014-08-11 20:20:00	2014-08-11 20:29:00
10348	2014-08-11 20:30:00	2014-08-11 20:39:00
10349	2014-08-11 20:40:00	2014-08-11 20:49:00
10350	2014-08-11 20:50:00	2014-08-11 20:59:00
10351	2014-08-11 21:00:00	2014-08-11 21:09:00
10352	2014-08-11 21:10:00	2014-08-11 21:19:00
10353	2014-08-11 21:20:00	2014-08-11 21:29:00
10354	2014-08-11 21:30:00	2014-08-11 21:39:00
10355	2014-08-11 21:40:00	2014-08-11 21:49:00
10356	2014-08-11 21:50:00	2014-08-11 21:59:00
10357	2014-08-11 22:00:00	2014-08-11 22:09:00
10358	2014-08-11 22:10:00	2014-08-11 22:19:00
10359	2014-08-11 22:20:00	2014-08-11 22:29:00
10360	2014-08-11 22:30:00	2014-08-11 22:39:00
10361	2014-08-11 22:40:00	2014-08-11 22:49:00
10362	2014-08-11 22:50:00	2014-08-11 22:59:00
10363	2014-08-11 23:00:00	2014-08-11 23:09:00
10364	2014-08-11 23:10:00	2014-08-11 23:19:00
10365	2014-08-11 23:20:00	2014-08-11 23:29:00
10366	2014-08-11 23:30:00	2014-08-11 23:39:00
10367	2014-08-11 23:40:00	2014-08-11 23:49:00
10368	2014-08-11 23:50:00	2014-08-11 23:59:00
\.


--
-- TOC entry 2335 (class 0 OID 0)
-- Dependencies: 203
-- Name: scheduling_blocks_id_block_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('scheduling_blocks_id_block_seq', 1, false);


--
-- TOC entry 2272 (class 0 OID 50504)
-- Dependencies: 202
-- Data for Name: schedulings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY schedulings (id_sched, id_off_veh, run_driv, run_cli) FROM stdin;
\.


--
-- TOC entry 2336 (class 0 OID 0)
-- Dependencies: 201
-- Name: schedulings_id_sched_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('schedulings_id_sched_seq', 1, false);


--
-- TOC entry 2289 (class 0 OID 50699)
-- Dependencies: 219
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: Andres
--

COPY schema_migrations (version) FROM stdin;
20140625044208
\.


--
-- TOC entry 2277 (class 0 OID 50531)
-- Dependencies: 207
-- Data for Name: state_histories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY state_histories (id_trav, id_stat) FROM stdin;
\.


--
-- TOC entry 2276 (class 0 OID 50524)
-- Dependencies: 206
-- Data for Name: states; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY states (id_stat, nom_est) FROM stdin;
\.


--
-- TOC entry 2337 (class 0 OID 0)
-- Dependencies: 205
-- Name: states_id_stat_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('states_id_stat_seq', 1, false);


--
-- TOC entry 2279 (class 0 OID 50538)
-- Dependencies: 209
-- Data for Name: technical_review_alerts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY technical_review_alerts (id_tec_rev, plant_alert_rev_tec) FROM stdin;
\.


--
-- TOC entry 2338 (class 0 OID 0)
-- Dependencies: 208
-- Name: technical_review_alerts_id_tec_rev_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('technical_review_alerts_id_tec_rev_seq', 1, false);


--
-- TOC entry 2281 (class 0 OID 50550)
-- Dependencies: 211
-- Data for Name: technical_review_expirations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY technical_review_expirations (id_tec_rev_ex, mes_venc_rev_tec, num_venc_rev_tec) FROM stdin;
\.


--
-- TOC entry 2339 (class 0 OID 0)
-- Dependencies: 210
-- Name: technical_review_expirations_id_tec_rev_ex_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('technical_review_expirations_id_tec_rev_ex_seq', 1, false);


--
-- TOC entry 2282 (class 0 OID 50557)
-- Dependencies: 212
-- Data for Name: transitions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY transitions (id_stat, sta_id_stat) FROM stdin;
\.


--
-- TOC entry 2286 (class 0 OID 50575)
-- Dependencies: 216
-- Data for Name: travel_requests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY travel_requests (id_trav_req, run_cli, dir_orig_sol, dir_dest_sol, com_orig_sol, com_dest_sol, cant_pasaj_sol, fecha_crea_sol, fecha_serv_sol, est_sol) FROM stdin;
1	5610320-1	Los Juncos 921	Matucana 100	Lo Prado	Santiago	3	2014-06-30	2014-06-30 18:50:00	Pendiente
\.


--
-- TOC entry 2340 (class 0 OID 0)
-- Dependencies: 215
-- Name: travel_requests_id_trav_req_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('travel_requests_id_trav_req_seq', 1, true);


--
-- TOC entry 2284 (class 0 OID 50564)
-- Dependencies: 214
-- Data for Name: travels; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY travels (id_trav, run_driv, id_trav_req, hora_ini_via, tiemp_est_via, dist_est_via, val_via) FROM stdin;
\.


--
-- TOC entry 2341 (class 0 OID 0)
-- Dependencies: 213
-- Name: travels_id_trav_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('travels_id_trav_seq', 1, false);


--
-- TOC entry 2291 (class 0 OID 50705)
-- Dependencies: 221
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: Andres
--

COPY users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, tipo, rut, nombre, apellidos, telefono1, telefono2, venc_lic_cond, created_at, updated_at) FROM stdin;
7	operador@activecab.cl	$2a$10$pvkavLfpISPitzI6aaWd.OcHWnYhOceGkqeB522QVSHCWNuZ5l.h2	\N	\N	\N	3	2014-06-30 11:59:30.805112	2014-06-30 09:32:51.090281	127.0.0.1	127.0.0.1	operador	21028729-9	Franco	Fredes	87653344	23450999	\N	2014-06-30 04:08:11.289187	2014-06-30 11:59:30.811112
10	romisq@live.cl	$2a$10$t8dvI6RcjKLlUl93a4FVB.qKwduXsbd9tExh/lsxcdg/iobCsfJAG	\N	\N	\N	1	2014-07-01 23:52:21.825846	2014-07-01 23:52:21.825846	127.0.0.1	127.0.0.1	cli_nat	18561819-6	Romina	Silva	61216985		\N	2014-07-01 23:52:21.504828	2014-07-01 23:52:21.830846
5	administrador2@activecab.cl	$2a$10$BZjMm/iVYbq19.rQRlCRO..r3cySSpcntXokLo9G.Ya.MoPqa1VOu	\N	\N	\N	1	2014-06-30 04:04:43.203286	2014-06-30 04:04:43.203286	127.0.0.1	127.0.0.1	administrador	15714729-3	Nicolás	Fuentes	0227995679	74533322	\N	2014-06-30 04:04:43.193285	2014-06-30 04:04:43.205286
6	conductor2@activecab.cl	$2a$10$UMfTHGZIaZyQk.OTREiLheOgvFhocftqJZbGV1dHckSbjzhi2SS8i	\N	\N	\N	1	2014-06-30 04:05:46.654915	2014-06-30 04:05:46.654915	127.0.0.1	127.0.0.1	conductor	21186873-2	Camilo	Torres	234765422	72533322	\N	2014-06-30 04:05:46.645914	2014-06-30 04:05:46.657915
2	administrador@activecab.cl	$2a$10$dFId0UF0OmKgolx1Fsmuie553VxTeFinLoNIVDHLER4qKg04E9M.q	\N	\N	\N	2	2014-06-30 04:19:52.197277	2014-06-30 03:58:23.044542	127.0.0.1	127.0.0.1	administrador	17579248-1	Andrés	Cifuentes	0224567809	1234673	\N	2014-06-30 03:58:23.001539	2014-06-30 04:19:52.202277
3	cliente@activecab.cl	$2a$10$UJxtJ/yT/7jNcj/83RJEJ.tlQO02nuk9ORvt.SD/myP3BPpBOuivi	\N	\N	\N	2	2014-06-30 04:53:23.304306	2014-06-30 03:59:46.298304	127.0.0.1	127.0.0.1	cli_nat	5610320-1	Claudio	Cortés	0227345679	77747523	\N	2014-06-30 03:59:46.285303	2014-06-30 04:53:23.311306
4	conductor@activecab.cl	$2a$10$1GCErDjO.lfGP8juWy.Gle5.tN1wwMnU93f8M6uFMK.KhyHTr.p9.	\N	\N	\N	2	2014-06-30 05:41:28.256316	2014-06-30 04:02:47.142647	127.0.0.1	127.0.0.1	conductor	20124182-0	Miguel	Cifuentes	25467655	72223344	\N	2014-06-30 04:02:47.130647	2014-06-30 05:41:28.260316
9	operador2@activecab.cl	$2a$10$zVA8/1TZBUda6ya4i4SuM.Ypz3.seqqZiJ74X.oKvZzgnXYGx9GDS	\N	\N	\N	5	2014-06-30 09:58:25.691055	2014-06-30 09:18:30.503058	127.0.0.1	127.0.0.1	operador	11123301-2	Ricardo	Rojas	23476544	0224563212	\N	2014-06-30 04:10:01.922515	2014-06-30 09:58:25.696055
\.


--
-- TOC entry 2342 (class 0 OID 0)
-- Dependencies: 220
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Andres
--

SELECT pg_catalog.setval('users_id_seq', 10, true);


--
-- TOC entry 2288 (class 0 OID 50585)
-- Dependencies: 218
-- Data for Name: vehicles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY vehicles (id_veh, run_own, pat_veh, mar_veh, model_veh, tipo_veh, km_sem_veh) FROM stdin;
1	23031109-9	BF DK 45	Subaru	XV	sedan	0
2	11152081-k	BC DJ 34	Kia	Rio	sedan	0
\.


--
-- TOC entry 2343 (class 0 OID 0)
-- Dependencies: 217
-- Name: vehicles_id_veh_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('vehicles_id_veh_seq', 2, true);


--
-- TOC entry 2015 (class 2606 OID 50352)
-- Name: pk_assigneds; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY assigneds
    ADD CONSTRAINT pk_assigneds PRIMARY KEY (id);


--
-- TOC entry 2020 (class 2606 OID 50363)
-- Name: pk_base_prices; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY base_prices
    ADD CONSTRAINT pk_base_prices PRIMARY KEY (id_base_pr);


--
-- TOC entry 2027 (class 2606 OID 50382)
-- Name: pk_bill_details; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bill_details
    ADD CONSTRAINT pk_bill_details PRIMARY KEY (id_bill_det);


--
-- TOC entry 2023 (class 2606 OID 50372)
-- Name: pk_bills; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bills
    ADD CONSTRAINT pk_bills PRIMARY KEY (id_bil);


--
-- TOC entry 2032 (class 2606 OID 50390)
-- Name: pk_clients; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY clients
    ADD CONSTRAINT pk_clients PRIMARY KEY (run_cli);


--
-- TOC entry 2035 (class 2606 OID 50399)
-- Name: pk_comunnes; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY comunnes
    ADD CONSTRAINT pk_comunnes PRIMARY KEY (id_comun);


--
-- TOC entry 2038 (class 2606 OID 50408)
-- Name: pk_concepts; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY concepts
    ADD CONSTRAINT pk_concepts PRIMARY KEY (id_conc);


--
-- TOC entry 2041 (class 2606 OID 50414)
-- Name: pk_drivers; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY drivers
    ADD CONSTRAINT pk_drivers PRIMARY KEY (run_driv);


--
-- TOC entry 2044 (class 2606 OID 50426)
-- Name: pk_drivers_license_alerts; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY drivers_license_alerts
    ADD CONSTRAINT pk_drivers_license_alerts PRIMARY KEY (id_mens_alert_licenc);


--
-- TOC entry 2046 (class 2606 OID 50435)
-- Name: pk_enterprise_clients; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY enterprise_clients
    ADD CONSTRAINT pk_enterprise_clients PRIMARY KEY (id_cli_ent);


--
-- TOC entry 2050 (class 2606 OID 50444)
-- Name: pk_external_enterprises; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY external_enterprises
    ADD CONSTRAINT pk_external_enterprises PRIMARY KEY (rut_ent);


--
-- TOC entry 2053 (class 2606 OID 50453)
-- Name: pk_fixed_rates; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY fixed_rates
    ADD CONSTRAINT pk_fixed_rates PRIMARY KEY (id_fix_rat);


--
-- TOC entry 2056 (class 2606 OID 50462)
-- Name: pk_kilometers_prices; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY kilometers_prices
    ADD CONSTRAINT pk_kilometers_prices PRIMARY KEY (id_km_pr);


--
-- TOC entry 2059 (class 2606 OID 50471)
-- Name: pk_log_sqls; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY log_sqls
    ADD CONSTRAINT pk_log_sqls PRIMARY KEY (id_log_sql);


--
-- TOC entry 2062 (class 2606 OID 50483)
-- Name: pk_offer_vehicles; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY offer_vehicles
    ADD CONSTRAINT pk_offer_vehicles PRIMARY KEY (id_off_veh);


--
-- TOC entry 2070 (class 2606 OID 50500)
-- Name: pk_owner_commissions; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY owner_commissions
    ADD CONSTRAINT pk_owner_commissions PRIMARY KEY (id_own_com);


--
-- TOC entry 2067 (class 2606 OID 50491)
-- Name: pk_owners; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY owners
    ADD CONSTRAINT pk_owners PRIMARY KEY (run_own);


--
-- TOC entry 2077 (class 2606 OID 50520)
-- Name: pk_scheduling_blocks; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY scheduling_blocks
    ADD CONSTRAINT pk_scheduling_blocks PRIMARY KEY (id_block);


--
-- TOC entry 2072 (class 2606 OID 50509)
-- Name: pk_schedulings; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY schedulings
    ADD CONSTRAINT pk_schedulings PRIMARY KEY (id_sched);


--
-- TOC entry 2080 (class 2606 OID 50529)
-- Name: pk_states; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY states
    ADD CONSTRAINT pk_states PRIMARY KEY (id_stat);


--
-- TOC entry 2085 (class 2606 OID 50546)
-- Name: pk_technical_review_alerts; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY technical_review_alerts
    ADD CONSTRAINT pk_technical_review_alerts PRIMARY KEY (id_tec_rev);


--
-- TOC entry 2088 (class 2606 OID 50555)
-- Name: pk_technical_review_expiration; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY technical_review_expirations
    ADD CONSTRAINT pk_technical_review_expiration PRIMARY KEY (id_tec_rev_ex);


--
-- TOC entry 2098 (class 2606 OID 50580)
-- Name: pk_travel_requests; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY travel_requests
    ADD CONSTRAINT pk_travel_requests PRIMARY KEY (id_trav_req);


--
-- TOC entry 2093 (class 2606 OID 50569)
-- Name: pk_travels; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY travels
    ADD CONSTRAINT pk_travels PRIMARY KEY (id_trav);


--
-- TOC entry 2102 (class 2606 OID 50590)
-- Name: pk_vehicles; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY vehicles
    ADD CONSTRAINT pk_vehicles PRIMARY KEY (id_veh);


--
-- TOC entry 2109 (class 2606 OID 50716)
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: Andres; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 2013 (class 1259 OID 50353)
-- Name: assigned_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX assigned_pk ON assigneds USING btree (id);


--
-- TOC entry 2018 (class 1259 OID 50364)
-- Name: base_prices_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX base_prices_pk ON base_prices USING btree (id_base_pr);


--
-- TOC entry 2025 (class 1259 OID 50383)
-- Name: bill_details_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX bill_details_pk ON bill_details USING btree (id_bill_det);


--
-- TOC entry 2021 (class 1259 OID 50373)
-- Name: bills_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX bills_pk ON bills USING btree (id_bil);


--
-- TOC entry 2030 (class 1259 OID 50391)
-- Name: clients_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX clients_pk ON clients USING btree (run_cli);


--
-- TOC entry 2033 (class 1259 OID 50400)
-- Name: comunne_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX comunne_pk ON comunnes USING btree (id_comun);


--
-- TOC entry 2036 (class 1259 OID 50409)
-- Name: concepts_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX concepts_pk ON concepts USING btree (id_conc);


--
-- TOC entry 2042 (class 1259 OID 50427)
-- Name: drivers_license_alerts_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX drivers_license_alerts_pk ON drivers_license_alerts USING btree (id_mens_alert_licenc);


--
-- TOC entry 2039 (class 1259 OID 50415)
-- Name: drivers_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX drivers_pk ON drivers USING btree (run_driv);


--
-- TOC entry 2048 (class 1259 OID 50445)
-- Name: external_enterprises_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX external_enterprises_pk ON external_enterprises USING btree (rut_ent);


--
-- TOC entry 2051 (class 1259 OID 50454)
-- Name: fixed_rates_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX fixed_rates_pk ON fixed_rates USING btree (id_fix_rat);


--
-- TOC entry 2106 (class 1259 OID 50717)
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: Andres; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- TOC entry 2107 (class 1259 OID 50718)
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: Andres; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- TOC entry 2054 (class 1259 OID 50463)
-- Name: kilometers_prices_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX kilometers_prices_pk ON kilometers_prices USING btree (id_km_pr);


--
-- TOC entry 2057 (class 1259 OID 50472)
-- Name: log_sqls_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX log_sqls_pk ON log_sqls USING btree (id_log_sql);


--
-- TOC entry 2060 (class 1259 OID 50484)
-- Name: offer_vehicles_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX offer_vehicles_pk ON offer_vehicles USING btree (id_off_veh);


--
-- TOC entry 2068 (class 1259 OID 50501)
-- Name: owner_commissions_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX owner_commissions_pk ON owner_commissions USING btree (id_own_com);


--
-- TOC entry 2065 (class 1259 OID 50492)
-- Name: owners_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX owners_pk ON owners USING btree (run_own);


--
-- TOC entry 2024 (class 1259 OID 50374)
-- Name: relationship_10_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX relationship_10_fk ON bills USING btree (rut_ent);


--
-- TOC entry 2073 (class 1259 OID 50510)
-- Name: relationship_11_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX relationship_11_fk ON schedulings USING btree (run_driv);


--
-- TOC entry 2074 (class 1259 OID 50511)
-- Name: relationship_12_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX relationship_12_fk ON schedulings USING btree (run_cli);


--
-- TOC entry 2094 (class 1259 OID 50572)
-- Name: relationship_13_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX relationship_13_fk ON travels USING btree (run_driv);


--
-- TOC entry 2028 (class 1259 OID 50384)
-- Name: relationship_15_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX relationship_15_fk ON bill_details USING btree (id_bil);


--
-- TOC entry 2029 (class 1259 OID 50385)
-- Name: relationship_16_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX relationship_16_fk ON bill_details USING btree (id_conc);


--
-- TOC entry 2075 (class 1259 OID 50512)
-- Name: relationship_17_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX relationship_17_fk ON schedulings USING btree (id_off_veh);


--
-- TOC entry 2063 (class 1259 OID 50485)
-- Name: relationship_18_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX relationship_18_fk ON offer_vehicles USING btree (id_block);


--
-- TOC entry 2064 (class 1259 OID 50486)
-- Name: relationship_19_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX relationship_19_fk ON offer_vehicles USING btree (run_driv);


--
-- TOC entry 2047 (class 1259 OID 50436)
-- Name: relationship_20_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX relationship_20_fk ON enterprise_clients USING btree (rut_ent);


--
-- TOC entry 2016 (class 1259 OID 50354)
-- Name: relationship_21_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX relationship_21_fk ON assigneds USING btree (run_driv);


--
-- TOC entry 2017 (class 1259 OID 50355)
-- Name: relationship_22_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX relationship_22_fk ON assigneds USING btree (id_veh);


--
-- TOC entry 2095 (class 1259 OID 50571)
-- Name: relationship_2_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX relationship_2_fk ON travels USING btree (id_trav_req);


--
-- TOC entry 2103 (class 1259 OID 50592)
-- Name: relationship_3_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX relationship_3_fk ON vehicles USING btree (run_own);


--
-- TOC entry 2099 (class 1259 OID 50582)
-- Name: relationship_4_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX relationship_4_fk ON travel_requests USING btree (run_cli);


--
-- TOC entry 2090 (class 1259 OID 50560)
-- Name: relationship_5_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX relationship_5_fk ON transitions USING btree (sta_id_stat);


--
-- TOC entry 2091 (class 1259 OID 50561)
-- Name: relationship_6_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX relationship_6_fk ON transitions USING btree (id_stat);


--
-- TOC entry 2082 (class 1259 OID 50534)
-- Name: relationship_7_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX relationship_7_fk ON state_histories USING btree (id_trav);


--
-- TOC entry 2083 (class 1259 OID 50535)
-- Name: relationship_8_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX relationship_8_fk ON state_histories USING btree (id_stat);


--
-- TOC entry 2078 (class 1259 OID 50521)
-- Name: scheduling_blocks_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX scheduling_blocks_pk ON scheduling_blocks USING btree (id_block);


--
-- TOC entry 2081 (class 1259 OID 50530)
-- Name: states_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX states_pk ON states USING btree (id_stat);


--
-- TOC entry 2086 (class 1259 OID 50547)
-- Name: technical_review_alerts_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX technical_review_alerts_pk ON technical_review_alerts USING btree (id_tec_rev);


--
-- TOC entry 2089 (class 1259 OID 50556)
-- Name: technical_review_expirations_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX technical_review_expirations_pk ON technical_review_expirations USING btree (id_tec_rev_ex);


--
-- TOC entry 2100 (class 1259 OID 50581)
-- Name: travel_requests_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX travel_requests_pk ON travel_requests USING btree (id_trav_req);


--
-- TOC entry 2096 (class 1259 OID 50570)
-- Name: travels_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX travels_pk ON travels USING btree (id_trav);


--
-- TOC entry 2105 (class 1259 OID 50702)
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: Andres; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- TOC entry 2104 (class 1259 OID 50591)
-- Name: vehicles_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX vehicles_pk ON vehicles USING btree (id_veh);


--
-- TOC entry 2131 (class 2620 OID 50720)
-- Name: trg_insert_users; Type: TRIGGER; Schema: public; Owner: Andres
--

CREATE TRIGGER trg_insert_users AFTER INSERT ON users FOR EACH ROW EXECUTE PROCEDURE insertar_clients();


--
-- TOC entry 2132 (class 2620 OID 50722)
-- Name: trg_update_users; Type: TRIGGER; Schema: public; Owner: Andres
--

CREATE TRIGGER trg_update_users AFTER UPDATE ON users FOR EACH ROW EXECUTE PROCEDURE actualizar_tipo_users();


--
-- TOC entry 2110 (class 2606 OID 50593)
-- Name: fk_assigned_relations_drivers; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY assigneds
    ADD CONSTRAINT fk_assigned_relations_drivers FOREIGN KEY (run_driv) REFERENCES drivers(run_driv) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2111 (class 2606 OID 50598)
-- Name: fk_assigned_relations_vehicles; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY assigneds
    ADD CONSTRAINT fk_assigned_relations_vehicles FOREIGN KEY (id_veh) REFERENCES vehicles(id_veh) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2113 (class 2606 OID 50608)
-- Name: fk_bill_det_relations_bills; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY bill_details
    ADD CONSTRAINT fk_bill_det_relations_bills FOREIGN KEY (id_bil) REFERENCES bills(id_bil) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2114 (class 2606 OID 50613)
-- Name: fk_bill_det_relations_concepts; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY bill_details
    ADD CONSTRAINT fk_bill_det_relations_concepts FOREIGN KEY (id_conc) REFERENCES concepts(id_conc) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2112 (class 2606 OID 50603)
-- Name: fk_bills_relations_external; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY bills
    ADD CONSTRAINT fk_bills_relations_external FOREIGN KEY (rut_ent) REFERENCES external_enterprises(rut_ent) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2115 (class 2606 OID 50618)
-- Name: fk_enterpri_cliente_clients; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY enterprise_clients
    ADD CONSTRAINT fk_enterpri_cliente_clients FOREIGN KEY (run_cli) REFERENCES clients(run_cli) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2116 (class 2606 OID 50623)
-- Name: fk_enterpri_relations_external; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY enterprise_clients
    ADD CONSTRAINT fk_enterpri_relations_external FOREIGN KEY (rut_ent) REFERENCES external_enterprises(rut_ent) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2117 (class 2606 OID 50628)
-- Name: fk_natural__cliente2_clients; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY natural_clients
    ADD CONSTRAINT fk_natural__cliente2_clients FOREIGN KEY (run_cli) REFERENCES clients(run_cli) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2119 (class 2606 OID 50638)
-- Name: fk_offer_ve_relations_drivers; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY offer_vehicles
    ADD CONSTRAINT fk_offer_ve_relations_drivers FOREIGN KEY (run_driv) REFERENCES drivers(run_driv) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2118 (class 2606 OID 50633)
-- Name: fk_offer_ve_relations_scheduli; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY offer_vehicles
    ADD CONSTRAINT fk_offer_ve_relations_scheduli FOREIGN KEY (id_block) REFERENCES scheduling_blocks(id_block) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2121 (class 2606 OID 50648)
-- Name: fk_scheduli_relations_clients; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY schedulings
    ADD CONSTRAINT fk_scheduli_relations_clients FOREIGN KEY (run_cli) REFERENCES clients(run_cli) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2120 (class 2606 OID 50643)
-- Name: fk_scheduli_relations_drivers; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY schedulings
    ADD CONSTRAINT fk_scheduli_relations_drivers FOREIGN KEY (run_driv) REFERENCES drivers(run_driv) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2122 (class 2606 OID 50653)
-- Name: fk_scheduli_relations_offer_ve; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY schedulings
    ADD CONSTRAINT fk_scheduli_relations_offer_ve FOREIGN KEY (id_off_veh) REFERENCES offer_vehicles(id_off_veh) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2124 (class 2606 OID 50663)
-- Name: fk_state_hi_relations_states; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY state_histories
    ADD CONSTRAINT fk_state_hi_relations_states FOREIGN KEY (id_stat) REFERENCES states(id_stat) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2123 (class 2606 OID 50658)
-- Name: fk_state_hi_relations_travels; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY state_histories
    ADD CONSTRAINT fk_state_hi_relations_travels FOREIGN KEY (id_trav) REFERENCES travels(id_trav) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2126 (class 2606 OID 50673)
-- Name: fk_transiti_relations_states; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY transitions
    ADD CONSTRAINT fk_transiti_relations_states FOREIGN KEY (id_stat) REFERENCES states(id_stat) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2125 (class 2606 OID 50668)
-- Name: fk_transiti_relations_states2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY transitions
    ADD CONSTRAINT fk_transiti_relations_states2 FOREIGN KEY (sta_id_stat) REFERENCES states(id_stat) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2129 (class 2606 OID 50688)
-- Name: fk_travel_r_relations_clients; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY travel_requests
    ADD CONSTRAINT fk_travel_r_relations_clients FOREIGN KEY (run_cli) REFERENCES clients(run_cli) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2127 (class 2606 OID 50678)
-- Name: fk_travels_relations_drivers; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY travels
    ADD CONSTRAINT fk_travels_relations_drivers FOREIGN KEY (run_driv) REFERENCES drivers(run_driv) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2128 (class 2606 OID 50683)
-- Name: fk_travels_relations_travel_r; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY travels
    ADD CONSTRAINT fk_travels_relations_travel_r FOREIGN KEY (id_trav_req) REFERENCES travel_requests(id_trav_req) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2130 (class 2606 OID 50693)
-- Name: fk_vehicles_relations_owners; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY vehicles
    ADD CONSTRAINT fk_vehicles_relations_owners FOREIGN KEY (run_own) REFERENCES owners(run_own) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2298 (class 0 OID 0)
-- Dependencies: 5
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2014-07-01 22:54:24

--
-- PostgreSQL database dump complete
--

