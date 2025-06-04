--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

-- Started on 2025-06-04 08:44:08

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 225 (class 1259 OID 16500)
-- Name: business_values_labels; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.business_values_labels (
    table_name text NOT NULL,
    column_name text NOT NULL,
    label_value text NOT NULL,
    business_meaning text
);


ALTER TABLE public.business_values_labels OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16493)
-- Name: definition_business_colonnes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.definition_business_colonnes (
    table_name text NOT NULL,
    column_name text NOT NULL,
    business_meaning text
);


ALTER TABLE public.definition_business_colonnes OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16395)
-- Name: dim_clmbr_prfl; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_clmbr_prfl (
    user_id text NOT NULL,
    dob_dt timestamp with time zone,
    frst_name text,
    lst_name text,
    gndr_cd text,
    loc text,
    mem_type_cd text
);


ALTER TABLE public.dim_clmbr_prfl OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16400)
-- Name: dim_gym; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_gym (
    gym_id text NOT NULL,
    gym_name text,
    gym_loc text,
    gym_capacity integer
);


ALTER TABLE public.dim_gym OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16405)
-- Name: dim_mbs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_mbs (
    mem_type_cd text NOT NULL,
    mem_lbl_txt text,
    prc_eur numeric,
    shop_disc_pct numeric
);


ALTER TABLE public.dim_mbs OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16410)
-- Name: dim_rt_catlg; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_rt_catlg (
    rt_id text NOT NULL,
    gym_id text,
    rt_type text,
    rt_sty_cd text,
    grade text,
    lvl_cd integer,
    date_added timestamp with time zone,
    rt_sttr text
);


ALTER TABLE public.dim_rt_catlg OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16415)
-- Name: dim_time; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_time (
    date date NOT NULL,
    cal_qrter smallint,
    cal_yr smallint,
    cal_sem smallint
);


ALTER TABLE public.dim_time OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16418)
-- Name: fact_rt_clmb_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fact_rt_clmb_log (
    log_id text NOT NULL,
    user_id text,
    visit_id text,
    rt_id text,
    attmp_cnt smallint,
    ascnt_flg boolean
);


ALTER TABLE public.fact_rt_clmb_log OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16390)
-- Name: fact_visit_trx; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fact_visit_trx (
    visit_date date,
    visit_timea time with time zone,
    visit_timeb time with time zone,
    visit_id text NOT NULL,
    user_id text,
    gym_id text
);


ALTER TABLE public.fact_visit_trx OWNER TO postgres;

--
-- TOC entry 4960 (class 0 OID 16500)
-- Dependencies: 225
-- Data for Name: business_values_labels; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.business_values_labels (table_name, column_name, label_value, business_meaning) FROM stdin;
Fact_RT_CLMB_LOG	ascnt_flg	0	the route was not ascended
Fact_RT_CLMB_LOG	ascnt_flg	1	the route was successfully ascended
DIM_CLMBR_PRFL	gndr_cd	m	male gender
DIM_CLMBR_PRFL	gndr_cd	f	female gender
DIM_CLMBR_PRFL	mem_type_cd	b	identifier of the basic membership type
DIM_CLMBR_PRFL	mem_type_cd	p	identifier of the premium membership type
DIM_CLMBR_PRFL	mem_type_cd	s	identifier of the student membership type
DIM_MBS	mem_lbl_txt	basic membership	correspond to the basic membership type including only access to the gym
DIM_RT_CATLG	mem_lbl_txt	premium membership	correspond to the premium membership type including access to the gym, coaching sessions, and discounts in the shop
DIM_RT_CATLG	mem_lbl_txt	student discount	correspond to the student membership type including access to the gym for half of the price of the basic membership
DIM_RT_CATLG	rt_type	b	boulder route
DIM_RT_CATLG	rt_type	l 	lead climbing route
DIM_RT_CATLG	rt_type	tr	top-rope climbing route
DIM_RT_CATLG	rt_sty_cd	sb	slab route style
DIM_RT_CATLG	rt_sty_cd	over	overhang route style
DIM_RT_CATLG	rt_sty_cd	v	vertical route style
\.


--
-- TOC entry 4959 (class 0 OID 16493)
-- Dependencies: 224
-- Data for Name: definition_business_colonnes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.definition_business_colonnes (table_name, column_name, business_meaning) FROM stdin;
fact_visit_trx	visit_id	unique identifier of a gym visit
fact_visit_trx	user_id	identifier of the climber who made the visit
fact_visit_trx	gym_id	identifier of the climbing gym visited by the climber
fact_visit_trx	visit_date	date of the gym visit
fact_visit_trx	visit_timea	time of entry to the gym
fact_visit_trx	visit_timeb	time of exit from the gym
fact_rt_clmb_log	log_id	unique identifier of a climb log
fact_rt_clmb_log	user_id	identifier of the climber who attempted the route
fact_rt_clmb_log	visit_id	identifier of the visit during which the climb was logged
fact_rt_clmb_log	rt_id	identifier of the route attempted by climber
fact_rt_clmb_log	attmp_cnt	number of attempts of the climber on the route
fact_rt_clmb_log	ascnt_flg	whether the route was successfully ascended (1=yes, 0=no)
dim_time	date	calendar date
dim_time	cal_qrter	calendar quarter of the year
dim_time	cal_yr	calendar year
dim_time	cal_sem	calendar semester (1 or 2)
dim_clmbr_prfl	user_id	unique identifier for the climber
dim_clmbr_prfl	frst_name	climber's first name
dim_clmbr_prfl	lst_name	climber's last name
dim_clmbr_prfl	dob_dt	date of birth of the climber
dim_clmbr_prfl	gndr_cd	gender code of climber
dim_clmbr_prfl	loc	city where climber lives
dim_clmbr_prfl	mem_type_cd	membership type code of the climber
dim_mbs	mem_type_cd	membership type code
dim_mbs	mem_lbl_txt	label of the membership
dim_mbs	prc_eur	monthly price in euros of the membership
dim_mbs	shop_disc_pct	discount percentage in shop
dim_rt_catlg	rt_id	unique identifier for a climbing route
dim_rt_catlg	gym_id	identifier of the gym where route is located
dim_rt_catlg	rt_type	type of route (boulder, rope,…)
dim_rt_catlg	rt_sty_cd	style of the route (overhang, slab,…)
dim_rt_catlg	grade	precise grade of difficulty
dim_rt_catlg	lvl_cd	difficulty level category
dim_rt_catlg	date_added	date route was added to the gym
dim_rt_catlg	rt_sttr	route setter's name
dim_gym	gym_id	unique identifier for a gym
dim_gym	gym_name	name of the gym
dim_gym	gym_capacity	maximum number of climbers allowed in the gym
dim_gym_loc	gym_loc	city where gym is located
\.


--
-- TOC entry 4953 (class 0 OID 16395)
-- Dependencies: 218
-- Data for Name: dim_clmbr_prfl; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_clmbr_prfl (user_id, dob_dt, frst_name, lst_name, gndr_cd, loc, mem_type_cd) FROM stdin;
USR0020	1984-03-15 00:00:00+01	kris	taylor	f	brussels	b
USR0021	1989-10-22 00:00:00+01	taylor	lee	m	charleroi	s
USR0022	1990-06-08 00:00:00+02	drew	clark	m	brussels	b
USR0023	2002-09-01 00:00:00+02	alex	walker	m	antwerp	b
USR0024	2007-01-02 00:00:00+01	kris	clark	f	namur	s
USR0025	1981-03-10 00:00:00+01	robin	lee	m	brussels	s
USR0026	2005-03-05 00:00:00+01	casey	young	m	charleroi	s
USR0027	1988-12-01 00:00:00+01	sam	young	f	liège	s
USR0028	2012-02-13 00:00:00+01	drew	clark	f	brussels	p
USR0029	2009-02-24 00:00:00+01	robin	young	f	namur	s
USR0030	2011-06-17 00:00:00+02	jordan	lee	f	brussels	p
USR0031	2004-06-11 00:00:00+02	robin	johnson	m	ghent	p
USR0032	1998-10-26 00:00:00+01	casey	clark	m	liège	p
USR0033	1989-11-20 00:00:00+01	jordan	brown	m	namur	b
USR0034	2000-02-24 00:00:00+01	drew	walker	m	namur	p
USR0035	2006-06-07 00:00:00+02	casey	young	f	antwerp	p
USR0036	1992-06-23 00:00:00+02	jamie	young	m	charleroi	b
USR0037	2016-04-22 00:00:00+02	sam	smith	m	antwerp	b
USR0038	2018-12-29 00:00:00+01	drew	martin	f	namur	b
USR0039	1980-04-16 00:00:00+02	jamie	clark	m	liège	s
USR0040	2014-01-14 00:00:00+01	kris	lewis	m	brussels	b
USR0041	2016-02-23 00:00:00+01	drew	young	m	brussels	b
USR0042	1987-02-28 00:00:00+01	kris	walker	m	liège	p
USR0043	2011-04-26 00:00:00+02	jordan	brown	m	namur	b
USR0044	1998-12-16 00:00:00+01	jamie	young	m	brussels	s
USR0045	1995-04-06 00:00:00+02	sam	brown	f	brussels	b
USR0046	1992-06-18 00:00:00+02	casey	lee	f	brussels	s
USR0047	1986-12-22 00:00:00+01	jess	lee	m	charleroi	b
USR0048	1989-08-28 00:00:00+02	robin	martin	m	charleroi	b
USR0049	2014-04-01 00:00:00+02	alex	johnson	f	ghent	b
USR0050	1995-02-05 00:00:00+01	sam	lewis	m	antwerp	b
USR0051	1984-08-01 00:00:00+02	jamie	smith	m	liège	s
USR0052	1984-02-28 00:00:00+01	jess	martin	m	liège	s
USR0053	1997-01-15 00:00:00+01	sam	taylor	f	liège	p
USR0054	1984-05-03 00:00:00+02	jamie	smith	m	ghent	s
USR0055	1996-02-07 00:00:00+01	taylor	clark	f	charleroi	b
USR0056	2018-01-06 00:00:00+01	taylor	walker	m	namur	p
USR0057	1995-06-06 00:00:00+02	kris	taylor	f	namur	p
USR0058	2007-01-30 00:00:00+01	sam	taylor	f	ghent	p
USR0059	1991-11-12 00:00:00+01	taylor	martin	m	namur	b
USR0060	2016-03-15 00:00:00+01	jamie	johnson	f	liège	s
USR0061	1981-12-12 00:00:00+01	kris	martin	m	antwerp	b
USR0062	2012-09-24 00:00:00+02	jamie	clark	f	brussels	p
USR0063	2000-08-10 00:00:00+02	kris	young	m	charleroi	b
USR0064	2004-01-20 00:00:00+01	sam	young	m	charleroi	b
USR0065	1985-08-07 00:00:00+02	jess	johnson	f	ghent	s
USR0066	1996-12-23 00:00:00+01	casey	clark	m	charleroi	s
USR0067	1983-07-15 00:00:00+02	drew	johnson	m	liège	p
USR0068	2004-10-05 00:00:00+02	jess	brown	f	namur	b
USR0069	1993-02-24 00:00:00+01	jordan	young	m	liège	b
USR0070	2017-03-15 00:00:00+01	jamie	taylor	m	ghent	s
USR0071	2008-03-13 00:00:00+01	jordan	lewis	f	liège	b
USR0072	2007-09-29 00:00:00+02	jess	walker	f	namur	b
USR0073	2019-09-20 00:00:00+02	kris	clark	m	antwerp	b
USR0074	2018-08-27 00:00:00+02	drew	smith	m	ghent	s
USR0075	1996-03-22 00:00:00+01	drew	johnson	f	antwerp	p
USR0076	2005-11-24 00:00:00+01	alex	walker	f	brussels	p
USR0077	1988-08-16 00:00:00+02	drew	smith	m	antwerp	b
USR0078	2011-08-09 00:00:00+02	casey	walker	f	brussels	p
USR0079	1983-02-13 00:00:00+01	drew	lewis	m	brussels	s
USR0080	1982-01-20 00:00:00+01	jess	smith	m	antwerp	s
USR0081	2009-08-30 00:00:00+02	alex	martin	m	ghent	p
USR0082	1990-03-22 00:00:00+01	jess	lee	m	namur	p
USR0083	2014-09-04 00:00:00+02	jess	martin	m	liège	b
USR0084	1992-12-24 00:00:00+01	robin	young	f	liège	p
USR0085	1983-07-31 00:00:00+02	alex	lee	f	namur	b
USR0086	2018-05-14 00:00:00+02	jess	martin	f	brussels	b
USR0087	1990-06-11 00:00:00+02	robin	lee	f	brussels	s
USR0088	2018-11-13 00:00:00+01	robin	lee	m	ghent	s
USR0089	1984-07-12 00:00:00+02	alex	taylor	m	charleroi	s
USR0090	1997-01-18 00:00:00+01	jordan	johnson	m	antwerp	s
USR0091	1992-06-20 00:00:00+02	kris	johnson	m	brussels	p
USR0092	2000-05-03 00:00:00+02	casey	taylor	f	liège	s
USR0093	2008-07-07 00:00:00+02	kris	walker	m	ghent	p
USR0094	2017-06-01 00:00:00+02	drew	brown	m	antwerp	s
USR0095	1996-05-13 00:00:00+02	casey	walker	f	ghent	p
USR0096	1987-04-18 00:00:00+02	drew	smith	f	antwerp	b
USR0097	1996-08-09 00:00:00+02	jess	smith	f	antwerp	p
USR0098	1995-12-08 00:00:00+01	jamie	lee	f	namur	p
USR0099	1989-05-25 00:00:00+02	alex	martin	m	brussels	s
USR0100	2010-01-23 00:00:00+01	casey	martin	m	ghent	p
USR0101	1991-12-23 00:00:00+01	casey	johnson	f	ghent	b
USR0102	2011-06-25 00:00:00+02	jess	clark	m	namur	b
USR0103	2010-08-30 00:00:00+02	jordan	walker	m	liège	s
USR0104	2009-01-25 00:00:00+01	robin	young	m	liège	b
USR0105	1983-03-15 00:00:00+01	jess	lewis	f	brussels	p
USR0106	2007-04-29 00:00:00+02	taylor	martin	m	brussels	b
USR0107	2008-06-25 00:00:00+02	robin	lewis	f	charleroi	s
USR0108	1987-09-04 00:00:00+02	alex	lee	m	namur	p
USR0109	2003-12-17 00:00:00+01	robin	lewis	m	liège	s
USR0110	2012-09-15 00:00:00+02	jordan	young	m	antwerp	p
USR0111	1990-12-24 00:00:00+01	robin	taylor	f	ghent	b
USR0112	1987-05-01 00:00:00+02	alex	young	m	brussels	s
USR0113	2000-09-25 00:00:00+02	jordan	lewis	f	ghent	s
USR0114	1997-01-07 00:00:00+01	kris	young	f	ghent	p
USR0115	1992-02-09 00:00:00+01	casey	brown	f	charleroi	s
USR0116	2008-09-15 00:00:00+02	casey	lee	m	liège	p
USR0117	2010-11-13 00:00:00+01	drew	walker	m	brussels	p
USR0118	2004-12-25 00:00:00+01	kris	taylor	m	ghent	p
USR0119	1989-11-07 00:00:00+01	kris	martin	m	brussels	p
USR0120	2010-09-16 00:00:00+02	robin	smith	f	antwerp	b
USR0121	1994-07-19 00:00:00+02	casey	walker	f	charleroi	p
USR0122	2017-10-22 00:00:00+02	alex	smith	f	antwerp	s
USR0123	2014-06-19 00:00:00+02	sam	lee	m	brussels	b
USR0124	2014-10-22 00:00:00+02	sam	taylor	f	brussels	s
USR0125	1982-07-05 00:00:00+02	jordan	johnson	m	liège	b
USR0126	1990-04-10 00:00:00+02	casey	martin	f	ghent	p
USR0127	2016-11-11 00:00:00+01	casey	brown	m	ghent	b
USR0128	1981-06-09 00:00:00+02	sam	johnson	m	antwerp	b
USR0129	2016-02-10 00:00:00+01	casey	lee	f	charleroi	s
USR0130	1994-02-24 00:00:00+01	robin	walker	f	namur	s
USR0131	1997-12-29 00:00:00+01	taylor	brown	f	ghent	p
USR0132	1992-01-04 00:00:00+01	jamie	young	f	liège	b
USR0133	1982-12-20 00:00:00+01	kris	lewis	m	antwerp	b
USR0134	1989-06-18 00:00:00+02	drew	brown	f	antwerp	b
USR0135	2020-12-16 00:00:00+01	jordan	lee	f	namur	p
USR0136	2005-06-10 00:00:00+02	taylor	clark	f	liège	p
USR0137	2019-04-24 00:00:00+02	sam	lewis	m	charleroi	p
USR0138	2012-03-15 00:00:00+01	kris	smith	m	liège	p
USR0139	1994-02-11 00:00:00+01	casey	martin	f	charleroi	p
USR0140	1989-07-15 00:00:00+02	drew	smith	m	liège	s
USR0141	2009-05-26 00:00:00+02	casey	brown	f	liège	b
USR0142	2002-05-24 00:00:00+02	alex	smith	m	brussels	b
USR0143	1997-09-30 00:00:00+02	alex	lee	m	antwerp	b
USR0144	2019-09-07 00:00:00+02	drew	young	m	liège	b
USR0145	2021-01-08 00:00:00+01	drew	walker	m	namur	b
USR0146	2008-11-01 00:00:00+01	sam	martin	f	liège	b
USR0147	2000-07-31 00:00:00+02	drew	smith	f	ghent	b
USR0148	1986-05-29 00:00:00+02	robin	smith	f	antwerp	b
USR0149	1991-11-18 00:00:00+01	casey	brown	m	ghent	s
USR0150	1986-04-06 00:00:00+02	taylor	walker	f	antwerp	b
USR0151	1991-01-23 00:00:00+01	jess	johnson	f	ghent	s
USR0152	2013-06-01 00:00:00+02	drew	smith	f	liège	p
USR0153	2005-03-07 00:00:00+01	jordan	lee	m	liège	b
USR0154	2004-03-05 00:00:00+01	alex	clark	m	brussels	p
USR0155	1991-10-14 00:00:00+01	robin	martin	m	namur	p
USR0156	2013-07-05 00:00:00+02	kris	smith	f	ghent	p
USR0157	2006-03-22 00:00:00+01	jess	lee	f	charleroi	s
USR0158	1999-03-21 00:00:00+01	taylor	lee	f	brussels	p
USR0159	2020-04-09 00:00:00+02	jess	martin	m	ghent	p
USR0160	2006-03-05 00:00:00+01	drew	johnson	m	ghent	p
USR0161	1997-11-30 00:00:00+01	sam	lee	f	brussels	b
USR0162	1996-03-27 00:00:00+01	alex	clark	m	liège	b
USR0163	1989-11-02 00:00:00+01	alex	lee	m	ghent	s
USR0164	1986-03-16 00:00:00+01	kris	lee	m	liège	s
USR0165	2002-11-09 00:00:00+01	sam	lee	m	brussels	b
USR0166	2002-02-19 00:00:00+01	casey	young	f	liège	s
USR0167	1984-01-29 00:00:00+01	jamie	young	m	antwerp	b
USR0168	2013-11-25 00:00:00+01	robin	johnson	m	charleroi	p
USR0169	1982-02-10 00:00:00+01	alex	smith	m	ghent	p
USR0170	2018-08-17 00:00:00+02	jordan	lee	m	namur	s
USR0171	1984-12-01 00:00:00+01	alex	walker	f	charleroi	b
USR0172	1986-11-09 00:00:00+01	jess	smith	f	liège	b
USR0173	2008-02-23 00:00:00+01	alex	johnson	m	ghent	s
USR0174	1987-03-06 00:00:00+01	alex	taylor	m	liège	b
USR0175	2015-07-13 00:00:00+02	jamie	smith	m	antwerp	p
USR0176	2010-07-11 00:00:00+02	jamie	smith	m	brussels	s
USR0177	1998-12-08 00:00:00+01	taylor	lewis	m	ghent	s
USR0178	2006-10-02 00:00:00+02	casey	brown	m	antwerp	b
USR0179	1982-11-06 00:00:00+01	jordan	lewis	f	antwerp	s
USR0180	1997-04-05 00:00:00+02	alex	clark	m	ghent	b
USR0181	1997-02-12 00:00:00+01	alex	young	f	liège	b
USR0182	2006-09-24 00:00:00+02	robin	young	f	namur	b
USR0183	2000-12-29 00:00:00+01	jamie	brown	m	antwerp	b
USR0184	2003-09-26 00:00:00+02	jordan	martin	f	charleroi	b
USR0185	1991-04-12 00:00:00+02	kris	martin	f	antwerp	s
USR0186	2004-10-25 00:00:00+02	taylor	johnson	f	namur	p
USR0187	2018-08-12 00:00:00+02	casey	brown	f	liège	p
USR0188	1980-07-07 00:00:00+02	sam	smith	f	liège	s
USR0189	2010-07-07 00:00:00+02	casey	martin	f	charleroi	s
USR0190	2012-04-30 00:00:00+02	jess	lee	m	antwerp	p
USR0191	1985-02-19 00:00:00+01	alex	walker	f	liège	p
USR0192	2010-07-31 00:00:00+02	taylor	smith	f	namur	p
USR0193	2019-09-09 00:00:00+02	jess	clark	f	ghent	p
USR0194	2004-02-01 00:00:00+01	jordan	lee	m	brussels	p
USR0195	2013-09-06 00:00:00+02	sam	lee	f	brussels	b
USR0196	1991-12-20 00:00:00+01	jamie	brown	m	brussels	s
USR0197	2014-06-23 00:00:00+02	taylor	johnson	f	antwerp	b
USR0198	2008-10-01 00:00:00+02	taylor	clark	m	charleroi	p
USR0199	1995-04-05 00:00:00+02	alex	martin	m	liège	p
USR0200	1985-01-01 00:00:00+01	drew	brown	f	ghent	p
USR0201	1993-03-01 00:00:00+01	taylor	martin	f	namur	b
USR0202	1999-07-03 00:00:00+02	robin	brown	m	ghent	b
USR0203	1987-02-04 00:00:00+01	sam	brown	f	namur	p
USR0204	2000-05-08 00:00:00+02	sam	brown	m	antwerp	b
USR0205	1980-02-23 00:00:00+01	robin	johnson	m	brussels	b
USR0206	2012-05-22 00:00:00+02	kris	brown	m	antwerp	p
USR0207	2019-04-15 00:00:00+02	robin	taylor	m	charleroi	b
USR0208	2012-04-13 00:00:00+02	robin	walker	m	charleroi	s
USR0209	1991-10-25 00:00:00+01	sam	martin	f	namur	s
USR0211	2014-03-06 00:00:00+01	sam	lewis	m	liège	s
USR0212	1988-01-06 00:00:00+01	drew	clark	f	namur	p
USR0213	2002-10-09 00:00:00+02	alex	young	m	charleroi	p
USR0214	2020-12-08 00:00:00+01	jess	johnson	f	charleroi	p
USR0215	1984-10-09 00:00:00+01	casey	smith	f	charleroi	s
USR0216	2019-01-18 00:00:00+01	jamie	lee	f	antwerp	s
USR0217	2008-01-18 00:00:00+01	jess	taylor	m	charleroi	b
USR0218	1993-05-21 00:00:00+02	alex	young	m	ghent	b
USR0219	2017-10-02 00:00:00+02	drew	lewis	m	brussels	s
USR0220	2008-08-29 00:00:00+02	drew	smith	f	charleroi	s
USR0221	2002-10-09 00:00:00+02	jamie	young	m	namur	s
USR0222	2007-04-26 00:00:00+02	casey	smith	f	brussels	s
USR0223	1988-12-02 00:00:00+01	kris	taylor	m	antwerp	b
USR0224	1986-11-09 00:00:00+01	robin	lewis	f	namur	s
USR0225	1996-10-09 00:00:00+02	casey	lee	m	brussels	b
USR0226	2014-03-15 00:00:00+01	kris	brown	m	namur	s
USR0227	1987-03-31 00:00:00+02	drew	martin	m	antwerp	s
USR0228	2004-03-12 00:00:00+01	sam	lee	f	ghent	s
USR0229	2014-12-05 00:00:00+01	alex	brown	f	antwerp	b
USR0210	2002-06-15 00:00:00+02	casey	smith	m	liège	s
USR0230	2003-10-16 00:00:00+02	jamie	johnson	m	antwerp	b
USR0231	1980-01-10 00:00:00+01	alex	walker	m	namur	p
USR0232	2006-11-13 00:00:00+01	jordan	clark	f	liège	s
USR0233	1994-07-16 00:00:00+02	jordan	clark	f	charleroi	p
USR0234	2001-12-01 00:00:00+01	casey	martin	f	charleroi	p
USR0235	1980-11-15 00:00:00+01	drew	lewis	m	ghent	b
USR0236	1985-01-06 00:00:00+01	drew	taylor	f	ghent	b
USR0237	1996-04-13 00:00:00+02	robin	lewis	m	charleroi	p
USR0238	2019-06-01 00:00:00+02	robin	taylor	f	liège	s
USR0239	2017-04-22 00:00:00+02	robin	lewis	m	charleroi	b
USR0240	2016-03-10 00:00:00+01	sam	walker	f	liège	s
USR0241	1993-10-17 00:00:00+01	jess	johnson	f	ghent	s
USR0242	1990-09-28 00:00:00+02	taylor	johnson	f	brussels	p
USR0243	1982-08-07 00:00:00+02	jess	brown	f	namur	p
USR0244	1990-10-21 00:00:00+01	alex	young	f	ghent	p
USR0245	2019-05-21 00:00:00+02	jess	johnson	m	ghent	p
USR0246	2005-06-13 00:00:00+02	sam	johnson	f	antwerp	b
USR0247	1983-07-14 00:00:00+02	alex	lee	f	antwerp	b
USR0248	1983-11-04 00:00:00+01	jess	lee	f	antwerp	p
USR0249	2012-10-30 00:00:00+01	sam	brown	m	namur	b
USR0250	2001-10-19 00:00:00+02	taylor	young	f	antwerp	p
USR0251	2016-08-08 00:00:00+02	jess	martin	m	liège	s
USR0252	1983-02-07 00:00:00+01	sam	lee	f	charleroi	s
USR0253	2014-02-12 00:00:00+01	robin	martin	f	brussels	s
USR0254	2003-11-23 00:00:00+01	drew	smith	m	ghent	p
USR0255	2014-05-09 00:00:00+02	robin	lee	f	liège	s
USR0256	1985-08-22 00:00:00+02	drew	walker	m	brussels	b
USR0257	1985-10-04 00:00:00+01	jamie	young	m	liège	s
USR0258	2009-08-05 00:00:00+02	jamie	brown	f	liège	s
USR0259	2001-04-27 00:00:00+02	jamie	smith	m	ghent	s
USR0260	2004-08-29 00:00:00+02	taylor	young	f	charleroi	b
USR0261	1987-05-29 00:00:00+02	robin	walker	f	antwerp	p
USR0262	1991-11-21 00:00:00+01	drew	young	m	namur	b
USR0263	2003-09-02 00:00:00+02	sam	walker	m	charleroi	p
USR0264	2019-02-18 00:00:00+01	alex	walker	m	namur	p
USR0265	2007-03-18 00:00:00+01	sam	martin	m	ghent	s
USR0266	1998-12-24 00:00:00+01	alex	lewis	f	ghent	p
USR0267	1989-07-02 00:00:00+02	jordan	smith	f	ghent	b
USR0268	2004-03-10 00:00:00+01	sam	young	m	brussels	b
USR0269	2013-11-17 00:00:00+01	jess	taylor	f	namur	p
USR0270	2012-09-28 00:00:00+02	jess	smith	f	charleroi	s
USR0271	2010-12-11 00:00:00+01	casey	lewis	f	charleroi	s
USR0272	1989-01-08 00:00:00+01	robin	smith	f	liège	b
USR0273	2011-12-24 00:00:00+01	alex	johnson	m	liège	s
USR0274	1993-12-25 00:00:00+01	alex	taylor	m	liège	p
USR0275	1997-11-24 00:00:00+01	robin	lewis	f	ghent	p
USR0276	2010-02-16 00:00:00+01	taylor	martin	m	charleroi	b
USR0277	2009-02-24 00:00:00+01	casey	young	m	namur	p
USR0278	1996-10-01 00:00:00+02	taylor	clark	m	ghent	b
USR0279	1999-08-26 00:00:00+02	taylor	lewis	f	brussels	p
USR0280	2020-05-09 00:00:00+02	taylor	brown	f	liège	b
USR0281	2003-03-20 00:00:00+01	robin	young	f	ghent	s
USR0282	2000-04-02 00:00:00+02	taylor	lewis	m	ghent	p
USR0283	1985-06-05 00:00:00+02	jess	johnson	f	brussels	p
USR0284	1991-02-13 00:00:00+01	jamie	clark	f	antwerp	b
USR0285	1990-01-29 00:00:00+01	jordan	johnson	m	charleroi	b
USR0286	1982-11-15 00:00:00+01	alex	clark	f	namur	p
USR0287	1995-03-02 00:00:00+01	alex	brown	f	antwerp	b
USR0288	1980-12-10 00:00:00+01	jordan	young	m	liège	p
USR0289	2006-05-22 00:00:00+02	robin	martin	m	ghent	s
USR0290	2004-11-05 00:00:00+01	sam	johnson	m	brussels	b
USR0291	1990-04-28 00:00:00+02	robin	johnson	f	brussels	p
USR0292	2006-05-25 00:00:00+02	alex	walker	f	charleroi	s
USR0293	1989-11-17 00:00:00+01	alex	clark	f	antwerp	s
USR0294	1980-04-27 00:00:00+02	jordan	lee	m	charleroi	p
USR0295	1983-03-09 00:00:00+01	taylor	young	m	ghent	b
USR0296	2011-10-02 00:00:00+02	robin	clark	f	charleroi	p
USR0297	2008-04-22 00:00:00+02	drew	walker	f	namur	s
USR0298	1982-08-22 00:00:00+02	jordan	smith	m	brussels	p
USR0299	1990-04-08 00:00:00+02	jess	clark	m	brussels	b
USR0300	1983-01-09 00:00:00+01	alex	martin	m	liège	s
USR0301	2020-08-12 00:00:00+02	jordan	young	m	liège	p
USR0302	1981-05-29 00:00:00+02	robin	walker	f	ghent	b
USR0303	2018-07-24 00:00:00+02	alex	smith	m	namur	s
USR0304	1994-10-27 00:00:00+01	sam	taylor	f	antwerp	b
USR0305	1983-03-06 00:00:00+01	jordan	walker	f	charleroi	s
USR0306	2003-01-23 00:00:00+01	casey	taylor	f	ghent	p
USR0307	1990-09-04 00:00:00+02	alex	young	m	liège	b
USR0308	1992-06-28 00:00:00+02	robin	johnson	m	charleroi	s
USR0309	2010-01-03 00:00:00+01	jamie	walker	m	liège	b
USR0310	2001-10-10 00:00:00+02	drew	brown	m	charleroi	b
USR0311	1989-08-11 00:00:00+02	kris	taylor	f	antwerp	p
USR0312	2004-03-09 00:00:00+01	taylor	martin	m	ghent	b
USR0313	1985-12-07 00:00:00+01	kris	brown	m	charleroi	s
USR0314	2012-06-12 00:00:00+02	robin	lewis	f	namur	s
USR0315	2019-07-31 00:00:00+02	jess	lewis	m	brussels	s
USR0316	2005-08-12 00:00:00+02	jess	smith	f	namur	s
USR0317	2005-11-05 00:00:00+01	jamie	johnson	f	namur	p
USR0318	2001-03-15 00:00:00+01	taylor	young	f	brussels	b
USR0319	1990-11-25 00:00:00+01	casey	walker	f	namur	p
USR0320	2015-03-13 00:00:00+01	jamie	lee	f	charleroi	b
USR0321	2001-03-20 00:00:00+01	kris	martin	f	charleroi	b
USR0322	2016-03-22 00:00:00+01	jamie	taylor	f	charleroi	b
USR0323	1998-04-05 00:00:00+02	kris	young	f	brussels	p
USR0324	1988-07-16 00:00:00+02	alex	brown	m	namur	b
USR0325	1984-03-25 00:00:00+01	jess	lewis	m	brussels	p
USR0326	1984-05-07 00:00:00+02	alex	martin	m	charleroi	s
USR0327	2009-07-23 00:00:00+02	drew	lee	m	namur	s
USR0328	1999-05-03 00:00:00+02	taylor	walker	f	namur	b
USR0329	1995-11-22 00:00:00+01	casey	smith	m	liège	p
USR0330	1998-12-31 00:00:00+01	kris	lee	f	liège	s
USR0331	1998-06-10 00:00:00+02	casey	martin	m	antwerp	p
USR0332	2000-12-12 00:00:00+01	kris	lee	m	ghent	p
USR0333	2018-10-01 00:00:00+02	robin	martin	m	liège	b
USR0334	2012-09-14 00:00:00+02	jamie	martin	f	brussels	s
USR0335	1982-06-06 00:00:00+02	drew	clark	m	liège	b
USR0336	2010-03-16 00:00:00+01	jess	taylor	f	antwerp	b
USR0337	2009-04-24 00:00:00+02	kris	lewis	f	namur	s
USR0338	2008-12-26 00:00:00+01	casey	clark	m	antwerp	s
USR0339	1984-05-31 00:00:00+02	drew	walker	m	namur	p
USR0340	1982-09-20 00:00:00+02	sam	clark	m	namur	s
USR0341	1998-01-22 00:00:00+01	sam	johnson	f	ghent	p
USR0342	2012-08-31 00:00:00+02	alex	johnson	m	liège	p
USR0343	1995-03-22 00:00:00+01	jess	lewis	f	brussels	p
USR0344	2015-11-29 00:00:00+01	robin	lee	f	brussels	s
USR0345	2018-08-26 00:00:00+02	casey	taylor	m	charleroi	b
USR0346	1984-11-25 00:00:00+01	jamie	lewis	m	namur	p
USR0347	1991-02-25 00:00:00+01	jamie	martin	f	brussels	b
USR0348	1988-08-05 00:00:00+02	casey	brown	f	ghent	b
USR0349	1988-07-13 00:00:00+02	taylor	taylor	f	namur	s
USR0350	2004-01-21 00:00:00+01	robin	taylor	m	ghent	b
USR0351	2000-02-15 00:00:00+01	drew	martin	f	brussels	b
USR0352	1986-04-15 00:00:00+02	kris	martin	m	brussels	s
USR0353	1998-12-04 00:00:00+01	taylor	smith	f	charleroi	p
USR0354	1988-03-25 00:00:00+01	kris	lewis	f	brussels	b
USR0355	1992-06-29 00:00:00+02	kris	martin	m	namur	s
USR0356	2000-10-01 00:00:00+02	taylor	johnson	f	namur	b
USR0357	1991-03-16 00:00:00+01	alex	walker	m	namur	b
USR0358	2019-03-24 00:00:00+01	sam	brown	m	charleroi	p
USR0359	1983-05-20 00:00:00+02	kris	lewis	f	charleroi	b
USR0360	1999-11-17 00:00:00+01	taylor	young	m	brussels	s
USR0361	2016-03-30 00:00:00+02	taylor	johnson	m	antwerp	b
USR0362	2018-08-21 00:00:00+02	jordan	lee	f	antwerp	p
USR0363	2018-05-25 00:00:00+02	alex	martin	m	charleroi	p
USR0364	2004-09-07 00:00:00+02	jess	young	m	brussels	s
USR0365	1984-05-23 00:00:00+02	jordan	martin	m	antwerp	p
USR0366	1982-04-08 00:00:00+02	jordan	taylor	f	brussels	b
USR0367	2009-04-02 00:00:00+02	casey	johnson	m	brussels	p
USR0368	2004-03-31 00:00:00+02	sam	taylor	f	brussels	s
USR0369	2017-07-02 00:00:00+02	taylor	smith	f	liège	p
USR0370	1980-08-29 00:00:00+02	sam	taylor	m	namur	p
USR0371	1984-03-08 00:00:00+01	robin	smith	m	brussels	p
USR0372	2013-10-20 00:00:00+02	casey	smith	m	liège	s
USR0373	2018-01-26 00:00:00+01	jess	young	f	charleroi	p
USR0374	1990-08-08 00:00:00+02	sam	martin	m	antwerp	p
USR0375	1987-06-17 00:00:00+02	jamie	lee	m	namur	b
USR0376	1998-03-25 00:00:00+01	kris	taylor	m	antwerp	s
USR0377	2001-10-13 00:00:00+02	robin	johnson	m	namur	p
USR0378	2001-08-04 00:00:00+02	alex	smith	m	antwerp	s
USR0379	1989-08-03 00:00:00+02	jess	martin	f	namur	p
USR0380	2018-10-14 00:00:00+02	robin	brown	f	antwerp	p
USR0381	1997-12-27 00:00:00+01	kris	lewis	m	antwerp	p
USR0382	2020-06-24 00:00:00+02	casey	young	m	antwerp	b
USR0383	1982-08-18 00:00:00+02	kris	lee	m	antwerp	b
USR0384	1987-05-21 00:00:00+02	jordan	clark	m	charleroi	b
USR0385	1996-12-31 00:00:00+01	kris	young	f	brussels	s
USR0386	1980-02-05 00:00:00+01	jordan	brown	m	ghent	s
USR0387	1997-07-06 00:00:00+02	casey	lewis	f	liège	b
USR0388	1991-11-24 00:00:00+01	drew	brown	f	ghent	s
USR0389	2015-03-04 00:00:00+01	jordan	taylor	m	ghent	p
USR0390	2015-03-21 00:00:00+01	alex	smith	f	namur	p
USR0391	2000-05-29 00:00:00+02	kris	lee	f	brussels	p
USR0392	1992-10-17 00:00:00+01	kris	walker	f	namur	b
USR0393	1998-12-22 00:00:00+01	alex	smith	f	brussels	s
USR0394	2011-03-31 00:00:00+02	jamie	walker	m	brussels	b
USR0395	2012-10-07 00:00:00+02	taylor	lewis	m	antwerp	s
USR0396	2015-02-20 00:00:00+01	drew	martin	f	charleroi	p
USR0397	2004-12-05 00:00:00+01	jess	clark	m	antwerp	b
USR0398	2009-09-09 00:00:00+02	jordan	johnson	m	charleroi	s
USR0399	2012-03-23 00:00:00+01	alex	smith	m	namur	s
USR0400	2001-10-30 00:00:00+01	casey	lee	m	charleroi	p
USR0401	1986-12-11 00:00:00+01	jordan	brown	m	namur	b
USR0402	1988-07-08 00:00:00+02	taylor	lee	f	ghent	b
USR0403	1993-04-23 00:00:00+02	casey	lewis	m	ghent	b
USR0404	1989-10-06 00:00:00+01	robin	walker	m	charleroi	p
USR0405	1982-08-16 00:00:00+02	kris	brown	m	charleroi	b
USR0406	2005-12-24 00:00:00+01	robin	johnson	m	namur	p
USR0407	2013-01-01 00:00:00+01	jordan	johnson	f	antwerp	p
USR0408	2004-04-27 00:00:00+02	taylor	smith	f	namur	p
USR0409	1982-09-25 00:00:00+02	drew	lewis	f	antwerp	s
USR0410	2013-07-20 00:00:00+02	jordan	martin	f	ghent	b
USR0411	1994-01-25 00:00:00+01	alex	lewis	m	brussels	b
USR0412	1982-07-25 00:00:00+02	sam	walker	f	charleroi	p
USR0413	1982-04-01 00:00:00+02	jordan	lee	m	antwerp	p
USR0414	2006-03-16 00:00:00+01	kris	johnson	m	namur	b
USR0415	2001-05-21 00:00:00+02	kris	lee	m	ghent	p
USR0416	2002-07-22 00:00:00+02	jordan	lee	m	antwerp	b
USR0418	2003-10-28 00:00:00+01	sam	johnson	f	charleroi	p
USR0419	1987-01-23 00:00:00+01	alex	young	f	charleroi	b
USR0420	1982-07-20 00:00:00+02	jordan	taylor	f	liège	p
USR0421	2002-10-12 00:00:00+02	casey	walker	f	brussels	b
USR0422	1983-08-05 00:00:00+02	kris	young	m	liège	b
USR0423	2018-03-10 00:00:00+01	kris	walker	f	ghent	p
USR0424	1988-05-02 00:00:00+02	taylor	brown	m	antwerp	s
USR0425	1983-01-27 00:00:00+01	jordan	lewis	f	ghent	b
USR0426	2006-09-10 00:00:00+02	sam	lewis	m	namur	b
USR0427	1983-01-18 00:00:00+01	jamie	clark	m	charleroi	b
USR0428	2010-04-15 00:00:00+02	sam	lewis	f	liège	s
USR0429	2018-08-29 00:00:00+02	kris	johnson	m	liège	s
USR0430	1990-07-20 00:00:00+02	kris	martin	m	liège	p
USR0431	1998-02-10 00:00:00+01	robin	smith	f	ghent	s
USR0432	1985-05-18 00:00:00+02	kris	clark	m	charleroi	p
USR0433	2019-12-08 00:00:00+01	alex	smith	f	antwerp	p
USR0434	2005-07-21 00:00:00+02	jess	walker	f	namur	s
USR0001	2008-09-06 00:00:00+02	jordan	taylor	f	ghent	b
USR0002	1984-12-29 00:00:00+01	casey	walker	f	antwerp	b
USR0003	1981-02-13 00:00:00+01	kris	martin	m	antwerp	p
USR0004	2013-04-06 00:00:00+02	robin	johnson	f	namur	p
USR0005	1992-05-03 00:00:00+02	casey	smith	m	ghent	b
USR0006	1990-12-26 00:00:00+01	jess	taylor	f	liège	s
USR0007	1990-01-05 00:00:00+01	jordan	walker	m	liège	p
USR0008	1986-04-05 00:00:00+02	sam	johnson	f	antwerp	s
USR0009	2013-01-13 00:00:00+01	jess	walker	m	ghent	b
USR0010	1984-08-06 00:00:00+02	jess	clark	f	ghent	p
USR0011	2010-05-10 00:00:00+02	robin	taylor	m	namur	s
USR0012	2013-03-23 00:00:00+01	taylor	johnson	f	charleroi	p
USR0013	2020-01-08 00:00:00+01	jordan	young	m	liège	b
USR0014	2004-06-18 00:00:00+02	jamie	lee	f	namur	s
USR0015	1983-11-25 00:00:00+01	jess	lee	m	brussels	b
USR0016	2006-06-27 00:00:00+02	taylor	johnson	m	liège	b
USR0017	1998-12-04 00:00:00+01	jamie	walker	f	namur	p
USR0018	1981-06-04 00:00:00+02	jordan	taylor	f	liège	s
USR0019	1981-05-03 00:00:00+02	alex	lee	m	charleroi	b
USR0417	2018-04-01 00:00:00+02	casey	lee	m	namur	s
USR0435	1991-01-16 00:00:00+01	jordan	smith	f	antwerp	p
USR0436	2005-12-20 00:00:00+01	sam	smith	m	ghent	s
USR0437	2006-09-01 00:00:00+02	jess	clark	m	namur	p
USR0438	1981-10-13 00:00:00+01	casey	brown	m	liège	s
USR0480	1992-10-13 00:00:00+01	jordan	johnson	m	antwerp	p
USR0481	1987-01-28 00:00:00+01	drew	johnson	m	namur	p
USR0482	1999-08-28 00:00:00+02	jess	taylor	f	liège	b
USR0483	2017-05-26 00:00:00+02	robin	taylor	m	charleroi	s
USR0484	2004-05-14 00:00:00+02	alex	young	m	ghent	s
USR0485	2011-07-23 00:00:00+02	robin	lee	f	liège	b
USR0486	1993-07-27 00:00:00+02	sam	taylor	m	antwerp	p
USR0487	2007-06-09 00:00:00+02	jamie	young	f	liège	b
USR0488	2016-03-15 00:00:00+01	alex	lewis	m	brussels	b
USR0489	2009-05-02 00:00:00+02	casey	martin	f	ghent	b
USR0490	2003-09-23 00:00:00+02	jess	martin	m	antwerp	p
USR0491	1980-05-08 00:00:00+02	casey	lewis	m	charleroi	b
USR0492	2009-12-16 00:00:00+01	jordan	clark	f	namur	p
USR0493	2016-08-26 00:00:00+02	alex	young	m	antwerp	b
USR0494	2004-11-16 00:00:00+01	casey	young	f	charleroi	s
USR0495	1993-06-06 00:00:00+02	casey	lewis	m	namur	b
USR0496	2009-10-03 00:00:00+02	drew	brown	f	namur	b
USR0497	1984-08-24 00:00:00+02	robin	walker	f	antwerp	s
USR0498	2019-05-23 00:00:00+02	drew	smith	f	liège	p
USR0499	1986-01-09 00:00:00+01	alex	lewis	f	liège	p
USR0500	1991-11-12 00:00:00+01	alex	taylor	m	namur	b
USR0439	2007-10-13 00:00:00+02	jamie	lee	f	brussels	s
USR0440	1983-09-05 00:00:00+02	alex	lewis	m	ghent	p
USR0441	1998-10-21 00:00:00+02	sam	lewis	f	ghent	b
USR0442	2009-06-27 00:00:00+02	jess	johnson	f	charleroi	p
USR0443	2006-03-07 00:00:00+01	jamie	clark	m	antwerp	s
USR0444	2005-05-09 00:00:00+02	robin	johnson	f	ghent	b
USR0445	2003-06-14 00:00:00+02	alex	martin	m	ghent	p
USR0446	1994-03-11 00:00:00+01	alex	martin	m	liège	p
USR0447	1991-09-12 00:00:00+02	robin	johnson	m	liège	p
USR0448	1989-02-28 00:00:00+01	jordan	clark	m	namur	b
USR0449	2010-01-15 00:00:00+01	robin	johnson	m	brussels	s
USR0450	2012-02-16 00:00:00+01	alex	lewis	f	charleroi	p
USR0451	1994-02-03 00:00:00+01	alex	young	f	brussels	p
USR0452	1990-09-15 00:00:00+02	jess	taylor	f	namur	p
USR0453	1991-11-30 00:00:00+01	kris	smith	m	liège	p
USR0454	1997-10-02 00:00:00+02	jamie	taylor	m	antwerp	p
USR0455	1985-11-14 00:00:00+01	robin	clark	m	liège	s
USR0456	2010-02-16 00:00:00+01	jamie	taylor	f	charleroi	s
USR0457	2008-12-14 00:00:00+01	robin	martin	m	liège	p
USR0458	1993-06-16 00:00:00+02	casey	walker	f	charleroi	b
USR0459	2000-07-05 00:00:00+02	alex	smith	f	charleroi	s
USR0460	1994-03-08 00:00:00+01	kris	lee	m	charleroi	b
USR0461	2013-09-22 00:00:00+02	jess	clark	m	namur	s
USR0462	1983-04-03 00:00:00+02	kris	smith	f	charleroi	p
USR0463	1980-06-01 00:00:00+02	kris	taylor	m	charleroi	s
USR0464	2000-07-22 00:00:00+02	kris	martin	f	antwerp	p
USR0465	2007-11-12 00:00:00+01	jamie	brown	m	brussels	s
USR0466	2005-04-03 00:00:00+02	robin	young	m	ghent	p
USR0467	1984-06-26 00:00:00+02	drew	lee	f	brussels	p
USR0468	1983-04-15 00:00:00+02	casey	young	m	charleroi	p
USR0469	2004-02-12 00:00:00+01	sam	smith	f	antwerp	p
USR0470	1989-07-24 00:00:00+02	kris	martin	m	liège	b
USR0471	2002-09-10 00:00:00+02	jordan	martin	f	antwerp	p
USR0472	1991-11-24 00:00:00+01	jamie	taylor	f	charleroi	b
USR0473	1985-12-10 00:00:00+01	jess	lewis	m	antwerp	b
USR0474	1995-08-28 00:00:00+02	sam	taylor	f	antwerp	p
USR0475	2019-07-07 00:00:00+02	drew	lewis	m	charleroi	b
USR0476	1983-02-01 00:00:00+01	jordan	lewis	m	namur	s
USR0477	2019-06-10 00:00:00+02	drew	lee	m	antwerp	p
USR0478	1990-12-16 00:00:00+01	sam	taylor	f	ghent	b
USR0479	1996-07-29 00:00:00+02	kris	brown	f	ghent	p
\.


--
-- TOC entry 4954 (class 0 OID 16400)
-- Dependencies: 219
-- Data for Name: dim_gym; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_gym (gym_id, gym_name, gym_loc, gym_capacity) FROM stdin;
GYM001	The Crux	Antwerpen	202
GYM002	Zenith bloc	Brussels	279
GYM003	Grimpark	Mons	192
GYM004	Gravita	Namur	114
GYM005	Altitude 0	Liège	206
GYM006	Bloc & Vertige	Arlon	171
\.


--
-- TOC entry 4955 (class 0 OID 16405)
-- Dependencies: 220
-- Data for Name: dim_mbs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_mbs (mem_type_cd, mem_lbl_txt, prc_eur, shop_disc_pct) FROM stdin;
b	basic membership	30	0
p	premium membership	50	10
s	student discount	20	5
\.


--
-- TOC entry 4956 (class 0 OID 16410)
-- Dependencies: 221
-- Data for Name: dim_rt_catlg; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_rt_catlg (rt_id, gym_id, rt_type, rt_sty_cd, grade, lvl_cd, date_added, rt_sttr) FROM stdin;
RT00001	GYM004	b	sb	8a	8	2023-03-14 00:00:00+01	Léa Robert
RT00002	GYM006	l	over	6b	6	2023-01-14 00:00:00+01	Juliette Gauthier
RT00003	GYM005	b	over	6a	6	2024-03-08 00:00:00+01	Nina Renard
RT00004	GYM003	tr	sb	5a	5	2023-06-06 00:00:00+02	Jules Chevalier
RT00005	GYM006	tr	sb	7b	7	2023-05-12 00:00:00+02	Sacha Fabre
RT00006	GYM002	b	over	6a	6	2023-12-04 00:00:00+01	Hugo Richard
RT00007	GYM004	tr	sb	7b	7	2024-02-08 00:00:00+01	Nathan Simon
RT00008	GYM003	b	over	6b	6	2024-01-11 00:00:00+01	Alice Martin
RT00009	GYM003	l	sb	5b	5	2024-07-12 00:00:00+02	Arthur Moulin
RT00010	GYM005	b	sb	7b	7	2023-04-17 00:00:00+02	Manon Laurent
RT00011	GYM003	l	sb	8a	8	2024-09-11 00:00:00+02	Tom Barbier
RT00012	GYM002	tr	over	7a	7	2023-09-22 00:00:00+02	Louna Garnier
RT00013	GYM002	l	sb	6a	6	2023-07-24 00:00:00+02	Zoé Lemoine
RT00014	GYM001	tr	over	6b	6	2023-03-20 00:00:00+01	Chloé Durand
RT00015	GYM002	b	over	6b	6	2023-06-04 00:00:00+02	Léa Robert
RT00016	GYM006	tr	sb	7b	7	2023-09-04 00:00:00+02	Arthur Moulin
RT00017	GYM003	b	sb	5b	5	2024-06-14 00:00:00+02	Hugo Richard
RT00018	GYM002	b	over	5a	5	2024-06-21 00:00:00+02	Camille Michel
RT00019	GYM005	l	over	6a	6	2024-12-29 00:00:00+01	Juliette Gauthier
RT00020	GYM001	l	v	6b	6	2023-06-03 00:00:00+02	Manon Laurent
RT00021	GYM003	l	over	5b	5	2023-06-03 00:00:00+02	Nina Renard
RT00022	GYM001	l	v	7a	7	2024-11-16 00:00:00+01	Jules Chevalier
RT00023	GYM003	tr	v	6b	6	2023-04-02 00:00:00+02	Mila Caron
RT00024	GYM005	tr	v	5b	5	2024-03-08 00:00:00+01	Liam Moreau
RT00025	GYM001	tr	sb	5a	5	2023-12-04 00:00:00+01	Arthur Moulin
RT00026	GYM004	b	sb	5a	5	2024-04-24 00:00:00+02	Inès Fournier
RT00027	GYM006	tr	over	6b	6	2024-11-23 00:00:00+01	Liam Moreau
RT00028	GYM006	tr	v	8a	8	2023-05-11 00:00:00+02	Louna Garnier
RT00029	GYM003	tr	sb	6b	6	2024-03-25 00:00:00+01	Sacha Fabre
RT00030	GYM004	l	sb	7b	7	2023-09-30 00:00:00+02	Élise Rolland
RT00031	GYM001	tr	sb	6a	6	2024-08-10 00:00:00+02	Anna Marchand
RT00032	GYM004	b	sb	5b	5	2023-06-26 00:00:00+02	Théo Adam
RT00033	GYM004	l	sb	6b	6	2024-11-26 00:00:00+01	Théo Adam
RT00034	GYM001	b	v	6a	6	2024-10-04 00:00:00+02	Manon Laurent
RT00035	GYM005	tr	v	7b	7	2023-02-18 00:00:00+01	Jules Chevalier
RT00036	GYM004	l	v	6a	6	2024-07-20 00:00:00+02	Gabriel Lefebvre
RT00037	GYM004	b	v	6b	6	2024-10-27 00:00:00+02	Alice Martin
RT00038	GYM005	tr	over	5a	5	2023-12-21 00:00:00+01	Lucas Bernard
RT00039	GYM004	b	v	5b	5	2024-12-12 00:00:00+01	Sarah Lopez
RT00040	GYM004	b	sb	5b	5	2023-11-04 00:00:00+01	Sarah Lopez
RT00041	GYM004	b	v	5a	5	2024-09-21 00:00:00+02	Ethan Picard
RT00042	GYM006	tr	over	8a	8	2023-02-15 00:00:00+01	Chloé Durand
RT00043	GYM002	tr	sb	6b	6	2023-10-29 00:00:00+02	Mila Caron
RT00044	GYM005	b	v	5b	5	2024-02-12 00:00:00+01	Louis Girard
RT00045	GYM004	l	v	6b	6	2023-07-08 00:00:00+02	Sarah Lopez
RT00046	GYM006	l	v	7b	7	2023-05-09 00:00:00+02	Juliette Gauthier
RT00047	GYM005	tr	sb	6b	6	2024-07-14 00:00:00+02	Louis Girard
RT00048	GYM003	tr	sb	6a	6	2024-06-20 00:00:00+02	Arthur Moulin
RT00049	GYM003	tr	over	5a	5	2023-09-23 00:00:00+02	Arthur Moulin
RT00050	GYM004	tr	sb	8a	8	2023-04-28 00:00:00+02	Louna Garnier
RT00051	GYM006	tr	sb	6b	6	2024-04-08 00:00:00+02	Manon Laurent
RT00052	GYM006	l	v	8a	8	2023-05-24 00:00:00+02	Mila Caron
RT00053	GYM005	tr	sb	8a	8	2024-03-17 00:00:00+01	Camille Michel
RT00054	GYM005	b	v	7b	7	2023-07-19 00:00:00+02	Zoé Lemoine
RT00055	GYM006	b	v	7a	7	2023-06-06 00:00:00+02	Élise Rolland
RT00056	GYM005	l	sb	5a	5	2024-05-01 00:00:00+02	Maël Perrin
RT00057	GYM006	b	over	8a	8	2023-05-14 00:00:00+02	Mila Caron
RT00058	GYM002	l	over	5b	5	2023-05-28 00:00:00+02	Anna Marchand
RT00059	GYM006	l	sb	6a	6	2023-12-02 00:00:00+01	Hugo Richard
RT00060	GYM003	b	over	5b	5	2023-03-12 00:00:00+01	Ethan Picard
RT00061	GYM005	tr	v	7b	7	2023-08-21 00:00:00+02	Sarah Lopez
RT00062	GYM006	b	v	7b	7	2023-11-30 00:00:00+01	Emma Dubois
RT00063	GYM006	b	sb	5b	5	2024-10-27 00:00:00+02	Sarah Lopez
RT00064	GYM005	l	over	5a	5	2023-03-31 00:00:00+02	Alice Martin
RT00065	GYM002	b	over	5b	5	2023-11-30 00:00:00+01	Hugo Richard
RT00066	GYM002	l	v	6b	6	2023-07-18 00:00:00+02	Liam Moreau
RT00067	GYM005	tr	sb	5b	5	2023-06-10 00:00:00+02	Noah Petit
RT00068	GYM001	tr	over	6a	6	2024-06-21 00:00:00+02	Mila Caron
RT00069	GYM005	tr	sb	6a	6	2023-05-01 00:00:00+02	Liam Moreau
RT00070	GYM005	b	over	7a	7	2023-10-28 00:00:00+02	Louis Girard
RT00071	GYM002	l	v	6a	6	2024-12-24 00:00:00+01	Zoé Lemoine
RT00072	GYM002	tr	v	5b	5	2024-07-28 00:00:00+02	Louna Garnier
RT00073	GYM005	l	sb	6a	6	2024-03-11 00:00:00+01	Chloé Durand
RT00074	GYM005	l	v	5a	5	2023-03-09 00:00:00+01	Chloé Durand
RT00075	GYM005	tr	over	8a	8	2024-04-03 00:00:00+02	Alice Martin
RT00076	GYM002	tr	v	6a	6	2024-05-28 00:00:00+02	Emma Dubois
RT00077	GYM005	l	sb	6b	6	2024-02-02 00:00:00+01	Noah Petit
RT00078	GYM005	tr	sb	5a	5	2024-09-11 00:00:00+02	Alice Martin
RT00079	GYM004	l	sb	7a	7	2023-10-13 00:00:00+02	Théo Adam
RT00080	GYM001	l	over	6b	6	2024-07-14 00:00:00+02	Gabriel Lefebvre
RT00081	GYM003	tr	over	5b	5	2023-05-20 00:00:00+02	Nathan Simon
RT00082	GYM001	b	over	8a	8	2024-12-30 00:00:00+01	Lucas Bernard
RT00083	GYM004	tr	over	5b	5	2024-07-09 00:00:00+02	Manon Laurent
RT00084	GYM003	b	over	8a	8	2024-08-12 00:00:00+02	Maël Perrin
RT00085	GYM005	l	v	8a	8	2024-12-28 00:00:00+01	Théo Adam
RT00086	GYM004	l	over	5b	5	2024-09-01 00:00:00+02	Lucas Bernard
RT00087	GYM005	b	over	6b	6	2023-10-09 00:00:00+02	Élise Rolland
RT00088	GYM002	l	v	6b	6	2024-10-22 00:00:00+02	Inès Fournier
RT00089	GYM006	b	over	8a	8	2024-07-31 00:00:00+02	Hugo Richard
RT00090	GYM004	b	sb	6b	6	2024-04-01 00:00:00+02	Sacha Fabre
RT00091	GYM002	l	over	8a	8	2023-03-28 00:00:00+02	Nina Renard
RT00092	GYM004	b	over	8a	8	2023-03-20 00:00:00+01	Juliette Gauthier
RT00093	GYM004	tr	sb	5a	5	2023-07-24 00:00:00+02	Camille Michel
RT00094	GYM002	tr	sb	7b	7	2023-12-03 00:00:00+01	Théo Adam
RT00095	GYM003	l	sb	5a	5	2023-09-11 00:00:00+02	Louna Garnier
RT00096	GYM001	l	sb	5b	5	2023-10-31 00:00:00+01	Zoé Lemoine
RT00097	GYM005	b	over	7b	7	2024-01-15 00:00:00+01	Zoé Lemoine
RT00098	GYM004	b	sb	6a	6	2023-05-10 00:00:00+02	Alice Martin
RT00099	GYM005	b	sb	5b	5	2024-08-18 00:00:00+02	Emma Dubois
RT00100	GYM006	b	v	7a	7	2023-10-03 00:00:00+02	Hugo Richard
RT00101	GYM002	tr	sb	5a	5	2024-11-29 00:00:00+01	Louna Garnier
RT00102	GYM005	tr	sb	6b	6	2024-07-11 00:00:00+02	Arthur Moulin
RT00103	GYM002	l	v	5a	5	2023-07-02 00:00:00+02	Ethan Picard
RT00104	GYM005	b	v	6b	6	2023-09-25 00:00:00+02	Chloé Durand
RT00105	GYM001	b	over	7b	7	2023-11-18 00:00:00+01	Jules Chevalier
RT00106	GYM001	l	v	7a	7	2024-05-26 00:00:00+02	Théo Adam
RT00107	GYM001	b	over	7b	7	2024-09-03 00:00:00+02	Liam Moreau
RT00108	GYM001	b	v	7a	7	2023-03-19 00:00:00+01	Arthur Moulin
RT00109	GYM001	b	v	5a	5	2023-12-05 00:00:00+01	Chloé Durand
RT00110	GYM001	b	over	6b	6	2024-11-04 00:00:00+01	Gabriel Lefebvre
RT00111	GYM002	b	v	7b	7	2024-07-09 00:00:00+02	Ethan Picard
RT00112	GYM004	l	over	7a	7	2024-05-23 00:00:00+02	Zoé Lemoine
RT00113	GYM005	b	v	8a	8	2023-08-26 00:00:00+02	Manon Laurent
RT00114	GYM001	l	sb	5b	5	2023-05-14 00:00:00+02	Emma Dubois
RT00115	GYM002	b	v	5b	5	2023-07-11 00:00:00+02	Gabriel Lefebvre
RT00116	GYM002	tr	over	7b	7	2023-12-22 00:00:00+01	Jules Chevalier
RT00117	GYM002	tr	v	6b	6	2023-10-05 00:00:00+02	Élise Rolland
RT00118	GYM004	tr	over	8a	8	2023-01-18 00:00:00+01	Inès Fournier
RT00119	GYM005	tr	over	7b	7	2024-06-07 00:00:00+02	Jules Chevalier
RT00120	GYM004	l	sb	5a	5	2023-06-29 00:00:00+02	Chloé Durand
RT00121	GYM003	l	sb	7a	7	2023-05-03 00:00:00+02	Nina Renard
RT00122	GYM002	b	over	5a	5	2023-09-03 00:00:00+02	Mila Caron
RT00123	GYM003	tr	v	5b	5	2024-01-08 00:00:00+01	Juliette Gauthier
RT00124	GYM006	l	over	7a	7	2023-02-20 00:00:00+01	Tom Barbier
RT00125	GYM001	b	over	7b	7	2023-03-12 00:00:00+01	Louna Garnier
RT00126	GYM001	b	v	5a	5	2024-04-24 00:00:00+02	Juliette Gauthier
RT00127	GYM004	l	v	6a	6	2024-07-13 00:00:00+02	Arthur Moulin
RT00128	GYM005	tr	v	6b	6	2023-01-19 00:00:00+01	Jules Chevalier
RT00129	GYM003	b	v	8a	8	2023-03-25 00:00:00+01	Inès Fournier
RT00130	GYM005	tr	over	8a	8	2023-06-04 00:00:00+02	Zoé Lemoine
RT00131	GYM004	tr	over	6b	6	2024-07-18 00:00:00+02	Alice Martin
RT00132	GYM001	tr	sb	6a	6	2024-09-10 00:00:00+02	Ethan Picard
RT00133	GYM005	b	over	5b	5	2023-12-23 00:00:00+01	Léa Robert
RT00134	GYM005	tr	v	7a	7	2024-10-08 00:00:00+02	Noah Petit
RT00135	GYM001	b	sb	6b	6	2024-03-18 00:00:00+01	Nathan Simon
RT00136	GYM003	tr	v	6a	6	2023-03-10 00:00:00+01	Léa Robert
RT00137	GYM001	b	over	7b	7	2024-06-06 00:00:00+02	Mila Caron
RT00138	GYM005	tr	sb	8a	8	2023-05-23 00:00:00+02	Léa Robert
RT00139	GYM003	l	v	6a	6	2023-07-11 00:00:00+02	Théo Adam
RT00140	GYM003	tr	sb	5b	5	2024-01-22 00:00:00+01	Emma Dubois
RT00141	GYM001	tr	sb	5b	5	2024-01-13 00:00:00+01	Ethan Picard
RT00142	GYM005	b	over	5a	5	2024-08-03 00:00:00+02	Sacha Fabre
RT00143	GYM004	b	v	6b	6	2024-06-18 00:00:00+02	Léa Robert
RT00144	GYM005	tr	sb	5a	5	2024-11-23 00:00:00+01	Élise Rolland
RT00145	GYM002	l	sb	8a	8	2023-10-20 00:00:00+02	Nina Renard
RT00146	GYM006	l	v	6a	6	2023-01-09 00:00:00+01	Ethan Picard
RT00147	GYM004	b	sb	7a	7	2023-09-28 00:00:00+02	Manon Laurent
RT00148	GYM003	l	sb	7a	7	2024-01-22 00:00:00+01	Chloé Durand
RT00149	GYM004	tr	sb	5b	5	2023-04-03 00:00:00+02	Chloé Durand
RT00150	GYM003	b	v	7a	7	2024-06-12 00:00:00+02	Liam Moreau
RT00151	GYM003	tr	v	7a	7	2023-06-03 00:00:00+02	Léa Robert
RT00152	GYM004	b	v	8a	8	2024-02-09 00:00:00+01	Manon Laurent
RT00153	GYM003	b	v	7a	7	2023-05-29 00:00:00+02	Zoé Lemoine
RT00154	GYM003	b	over	6a	6	2023-09-24 00:00:00+02	Louis Girard
RT00155	GYM002	b	sb	7a	7	2024-02-26 00:00:00+01	Alice Martin
RT00156	GYM005	l	v	7b	7	2024-09-09 00:00:00+02	Théo Adam
RT00157	GYM005	tr	sb	7a	7	2024-04-16 00:00:00+02	Nina Renard
RT00158	GYM006	tr	sb	7a	7	2024-06-30 00:00:00+02	Liam Moreau
RT00159	GYM006	tr	over	5a	5	2024-09-22 00:00:00+02	Mila Caron
RT00160	GYM002	b	v	6a	6	2024-06-09 00:00:00+02	Nina Renard
RT00161	GYM006	l	v	5b	5	2024-05-17 00:00:00+02	Lucas Bernard
RT00162	GYM004	tr	sb	5a	5	2023-01-14 00:00:00+01	Anna Marchand
RT00163	GYM001	l	v	6b	6	2024-10-13 00:00:00+02	Sarah Lopez
RT00164	GYM001	b	sb	6a	6	2023-12-30 00:00:00+01	Liam Moreau
RT00165	GYM001	tr	sb	7b	7	2023-04-29 00:00:00+02	Liam Moreau
RT00166	GYM002	l	over	6a	6	2023-08-26 00:00:00+02	Zoé Lemoine
RT00167	GYM002	b	over	6b	6	2024-06-29 00:00:00+02	Zoé Lemoine
RT00168	GYM003	l	over	6b	6	2023-06-18 00:00:00+02	Mila Caron
RT00169	GYM001	tr	sb	6b	6	2024-06-05 00:00:00+02	Arthur Moulin
RT00170	GYM004	tr	v	8a	8	2024-09-25 00:00:00+02	Gabriel Lefebvre
RT00171	GYM006	b	over	5b	5	2024-10-18 00:00:00+02	Alice Martin
RT00172	GYM004	b	v	7a	7	2024-05-30 00:00:00+02	Noah Petit
RT00173	GYM006	b	over	6a	6	2024-02-01 00:00:00+01	Anna Marchand
RT00174	GYM001	l	over	8a	8	2023-04-16 00:00:00+02	Alice Martin
RT00175	GYM001	l	sb	7a	7	2023-03-26 00:00:00+01	Théo Adam
RT00176	GYM001	l	over	7a	7	2023-08-02 00:00:00+02	Noah Petit
RT00177	GYM002	b	over	7b	7	2023-05-01 00:00:00+02	Emma Dubois
RT00178	GYM006	tr	sb	6b	6	2023-05-12 00:00:00+02	Louna Garnier
RT00179	GYM002	tr	v	5b	5	2023-07-16 00:00:00+02	Hugo Richard
RT00180	GYM002	l	over	7b	7	2023-01-19 00:00:00+01	Juliette Gauthier
RT00181	GYM005	l	sb	5a	5	2024-10-03 00:00:00+02	Emma Dubois
RT00182	GYM004	tr	over	8a	8	2023-01-12 00:00:00+01	Tom Barbier
RT00183	GYM004	tr	sb	8a	8	2023-03-22 00:00:00+01	Alice Martin
RT00184	GYM003	l	v	5b	5	2023-11-26 00:00:00+01	Zoé Lemoine
RT00185	GYM002	l	v	7a	7	2024-01-27 00:00:00+01	Léa Robert
RT00186	GYM006	tr	sb	8a	8	2024-09-28 00:00:00+02	Théo Adam
RT00187	GYM005	b	sb	5b	5	2023-11-03 00:00:00+01	Raphaël Rousseau
RT00188	GYM005	l	sb	8a	8	2023-09-24 00:00:00+02	Anna Marchand
RT00189	GYM004	tr	v	8a	8	2024-03-22 00:00:00+01	Arthur Moulin
RT00190	GYM002	tr	over	6b	6	2024-03-16 00:00:00+01	Camille Michel
RT00191	GYM003	tr	v	5a	5	2024-10-13 00:00:00+02	Chloé Durand
RT00192	GYM002	tr	sb	6b	6	2023-01-02 00:00:00+01	Jules Chevalier
RT00193	GYM001	b	sb	5a	5	2024-06-03 00:00:00+02	Nina Renard
RT00194	GYM002	tr	v	8a	8	2024-10-12 00:00:00+02	Sacha Fabre
RT00195	GYM001	l	sb	7b	7	2024-09-27 00:00:00+02	Élise Rolland
RT00196	GYM001	b	v	7a	7	2023-11-05 00:00:00+01	Maël Perrin
RT00197	GYM003	tr	sb	8a	8	2024-06-05 00:00:00+02	Louis Girard
RT00198	GYM006	b	over	5a	5	2024-04-13 00:00:00+02	Emma Dubois
RT00199	GYM004	l	over	5a	5	2023-07-31 00:00:00+02	Louna Garnier
RT00200	GYM002	tr	sb	5a	5	2023-04-22 00:00:00+02	Louna Garnier
RT00201	GYM001	l	v	8a	8	2023-01-08 00:00:00+01	Liam Moreau
RT00202	GYM002	tr	over	5b	5	2024-04-21 00:00:00+02	Nathan Simon
RT00203	GYM006	tr	v	7b	7	2024-04-04 00:00:00+02	Nathan Simon
RT00204	GYM004	tr	sb	5b	5	2023-09-10 00:00:00+02	Chloé Durand
RT00205	GYM006	tr	v	7a	7	2024-06-09 00:00:00+02	Arthur Moulin
RT00206	GYM004	tr	over	8a	8	2024-03-13 00:00:00+01	Nathan Simon
RT00207	GYM005	b	v	5a	5	2024-10-22 00:00:00+02	Gabriel Lefebvre
RT00208	GYM004	tr	v	7b	7	2023-08-24 00:00:00+02	Camille Michel
RT00209	GYM003	tr	sb	7b	7	2023-11-02 00:00:00+01	Inès Fournier
RT00210	GYM006	b	sb	6a	6	2024-04-22 00:00:00+02	Arthur Moulin
RT00211	GYM001	b	sb	7a	7	2024-11-09 00:00:00+01	Théo Adam
RT00212	GYM005	b	over	7b	7	2023-01-20 00:00:00+01	Emma Dubois
RT00213	GYM003	b	over	8a	8	2023-08-04 00:00:00+02	Anna Marchand
RT00214	GYM002	b	sb	5a	5	2023-05-15 00:00:00+02	Théo Adam
RT00215	GYM006	b	sb	5a	5	2023-05-09 00:00:00+02	Arthur Moulin
RT00216	GYM001	tr	over	7b	7	2024-02-14 00:00:00+01	Jules Chevalier
RT00217	GYM004	tr	over	5b	5	2024-02-26 00:00:00+01	Sacha Fabre
RT00218	GYM001	l	over	7a	7	2023-10-21 00:00:00+02	Sacha Fabre
RT00219	GYM002	tr	over	5a	5	2023-09-03 00:00:00+02	Léa Robert
RT00220	GYM005	tr	sb	7b	7	2024-12-01 00:00:00+01	Sacha Fabre
RT00221	GYM005	b	over	5a	5	2024-07-09 00:00:00+02	Liam Moreau
RT00222	GYM006	b	sb	7b	7	2023-03-27 00:00:00+02	Maël Perrin
RT00223	GYM005	tr	v	7a	7	2024-07-09 00:00:00+02	Anna Marchand
RT00224	GYM006	l	v	7b	7	2024-01-10 00:00:00+01	Juliette Gauthier
RT00225	GYM006	b	over	6a	6	2024-03-21 00:00:00+01	Noah Petit
RT00226	GYM006	tr	v	7b	7	2024-01-13 00:00:00+01	Léa Robert
RT00227	GYM004	tr	v	7b	7	2024-01-25 00:00:00+01	Zoé Lemoine
RT00228	GYM003	l	v	8a	8	2024-10-18 00:00:00+02	Mila Caron
RT00229	GYM006	l	over	7a	7	2023-02-20 00:00:00+01	Inès Fournier
RT00230	GYM006	b	over	8a	8	2023-08-30 00:00:00+02	Maël Perrin
RT00231	GYM003	l	v	7b	7	2023-10-21 00:00:00+02	Sacha Fabre
RT00232	GYM001	tr	sb	7a	7	2024-07-16 00:00:00+02	Zoé Lemoine
RT00233	GYM006	tr	v	6a	6	2023-09-23 00:00:00+02	Juliette Gauthier
RT00234	GYM004	l	over	7a	7	2023-04-30 00:00:00+02	Louis Girard
RT00235	GYM005	l	over	5a	5	2024-12-12 00:00:00+01	Mila Caron
RT00236	GYM005	l	over	8a	8	2023-09-05 00:00:00+02	Hugo Richard
RT00237	GYM002	l	v	7a	7	2023-03-11 00:00:00+01	Maël Perrin
RT00238	GYM002	b	sb	6a	6	2023-02-26 00:00:00+01	Inès Fournier
RT00239	GYM005	l	over	6b	6	2024-01-17 00:00:00+01	Léa Robert
RT00240	GYM005	b	over	7b	7	2023-02-08 00:00:00+01	Chloé Durand
RT00241	GYM004	tr	v	7a	7	2024-03-18 00:00:00+01	Alice Martin
RT00242	GYM003	l	sb	7b	7	2023-01-18 00:00:00+01	Nathan Simon
RT00243	GYM002	b	v	5b	5	2023-12-18 00:00:00+01	Théo Adam
RT00244	GYM003	l	over	5a	5	2023-10-25 00:00:00+02	Hugo Richard
RT00245	GYM004	tr	sb	8a	8	2023-10-10 00:00:00+02	Manon Laurent
RT00246	GYM005	tr	sb	5a	5	2024-08-08 00:00:00+02	Alice Martin
RT00247	GYM006	tr	over	5b	5	2023-04-20 00:00:00+02	Tom Barbier
RT00248	GYM003	l	sb	5b	5	2023-06-29 00:00:00+02	Manon Laurent
RT00249	GYM005	l	sb	8a	8	2024-06-27 00:00:00+02	Arthur Moulin
RT00250	GYM005	b	v	7a	7	2023-01-25 00:00:00+01	Lucas Bernard
RT00251	GYM001	tr	over	5b	5	2023-02-26 00:00:00+01	Chloé Durand
RT00252	GYM003	l	over	6b	6	2023-06-29 00:00:00+02	Inès Fournier
RT00253	GYM006	tr	over	7b	7	2023-08-20 00:00:00+02	Camille Michel
RT00254	GYM003	tr	over	7b	7	2023-12-09 00:00:00+01	Zoé Lemoine
RT00255	GYM005	b	over	6a	6	2024-04-21 00:00:00+02	Noah Petit
RT00256	GYM006	b	sb	5b	5	2024-07-29 00:00:00+02	Sarah Lopez
RT00257	GYM004	b	v	5b	5	2024-03-30 00:00:00+01	Noah Petit
RT00258	GYM001	b	over	6b	6	2023-08-20 00:00:00+02	Théo Adam
RT00259	GYM005	tr	v	5a	5	2023-10-16 00:00:00+02	Maël Perrin
RT00260	GYM002	b	v	5a	5	2023-08-01 00:00:00+02	Inès Fournier
RT00261	GYM002	b	sb	7b	7	2023-09-15 00:00:00+02	Maël Perrin
RT00262	GYM001	b	over	7b	7	2024-06-13 00:00:00+02	Raphaël Rousseau
RT00263	GYM004	b	sb	7a	7	2024-11-17 00:00:00+01	Louis Girard
RT00264	GYM005	tr	over	8a	8	2023-08-17 00:00:00+02	Raphaël Rousseau
RT00265	GYM003	b	sb	6b	6	2023-08-14 00:00:00+02	Arthur Moulin
RT00266	GYM001	tr	v	8a	8	2024-08-18 00:00:00+02	Gabriel Lefebvre
RT00267	GYM004	l	over	8a	8	2024-03-10 00:00:00+01	Raphaël Rousseau
RT00268	GYM003	tr	v	6a	6	2024-02-06 00:00:00+01	Élise Rolland
RT00269	GYM002	tr	v	8a	8	2024-09-13 00:00:00+02	Manon Laurent
RT00270	GYM002	b	sb	6a	6	2023-03-29 00:00:00+02	Sacha Fabre
RT00271	GYM003	l	over	8a	8	2024-08-06 00:00:00+02	Nathan Simon
RT00272	GYM001	l	v	6b	6	2024-06-25 00:00:00+02	Élise Rolland
RT00273	GYM002	l	sb	6a	6	2024-11-14 00:00:00+01	Manon Laurent
RT00274	GYM005	l	over	5a	5	2023-11-05 00:00:00+01	Arthur Moulin
RT00275	GYM006	tr	over	6a	6	2023-12-09 00:00:00+01	Lucas Bernard
RT00276	GYM003	l	v	6a	6	2024-03-11 00:00:00+01	Tom Barbier
RT00277	GYM003	tr	over	6b	6	2023-06-26 00:00:00+02	Sacha Fabre
RT00278	GYM002	tr	v	6b	6	2023-05-19 00:00:00+02	Liam Moreau
RT00279	GYM001	tr	over	6a	6	2023-07-13 00:00:00+02	Théo Adam
RT00280	GYM005	l	sb	5b	5	2023-07-05 00:00:00+02	Sarah Lopez
RT00281	GYM001	b	v	6b	6	2023-08-06 00:00:00+02	Zoé Lemoine
RT00282	GYM004	b	v	7a	7	2023-06-13 00:00:00+02	Arthur Moulin
RT00283	GYM004	l	over	7a	7	2023-06-10 00:00:00+02	Hugo Richard
RT00284	GYM006	b	over	5a	5	2024-06-08 00:00:00+02	Arthur Moulin
RT00285	GYM002	b	v	8a	8	2024-08-23 00:00:00+02	Tom Barbier
RT00286	GYM002	tr	over	6a	6	2023-02-11 00:00:00+01	Nathan Simon
RT00287	GYM002	tr	sb	5b	5	2023-07-29 00:00:00+02	Tom Barbier
RT00288	GYM006	l	over	5a	5	2023-10-02 00:00:00+02	Liam Moreau
RT00289	GYM004	l	sb	6a	6	2023-10-06 00:00:00+02	Camille Michel
RT00290	GYM001	b	sb	6b	6	2023-09-08 00:00:00+02	Élise Rolland
RT00291	GYM006	tr	sb	7a	7	2023-11-06 00:00:00+01	Nathan Simon
RT00292	GYM006	l	sb	7b	7	2024-12-20 00:00:00+01	Anna Marchand
RT00293	GYM001	l	sb	5b	5	2023-05-20 00:00:00+02	Anna Marchand
RT00294	GYM002	l	over	7b	7	2024-06-29 00:00:00+02	Nathan Simon
RT00295	GYM005	l	sb	7a	7	2024-06-13 00:00:00+02	Lucas Bernard
RT00296	GYM001	l	over	8a	8	2023-02-26 00:00:00+01	Camille Michel
RT00297	GYM004	l	sb	8a	8	2023-04-22 00:00:00+02	Maël Perrin
RT00298	GYM003	b	v	7b	7	2023-01-05 00:00:00+01	Élise Rolland
RT00299	GYM003	tr	sb	6b	6	2024-02-14 00:00:00+01	Tom Barbier
RT00300	GYM006	tr	v	6a	6	2024-02-18 00:00:00+01	Inès Fournier
RT00301	GYM003	l	sb	6b	6	2023-07-01 00:00:00+02	Tom Barbier
RT00302	GYM005	tr	sb	7b	7	2023-01-13 00:00:00+01	Anna Marchand
RT00303	GYM002	tr	sb	6b	6	2023-12-05 00:00:00+01	Gabriel Lefebvre
RT00304	GYM004	tr	v	7a	7	2023-09-16 00:00:00+02	Léa Robert
RT00305	GYM005	l	v	5b	5	2023-03-31 00:00:00+02	Sacha Fabre
RT00306	GYM004	l	sb	6b	6	2024-09-07 00:00:00+02	Manon Laurent
RT00307	GYM004	tr	over	7a	7	2024-11-28 00:00:00+01	Mila Caron
RT00308	GYM002	tr	sb	5b	5	2023-09-07 00:00:00+02	Élise Rolland
RT00309	GYM006	l	v	8a	8	2023-09-12 00:00:00+02	Juliette Gauthier
RT00310	GYM003	b	sb	6a	6	2024-08-10 00:00:00+02	Sacha Fabre
RT00311	GYM002	tr	v	7b	7	2023-04-18 00:00:00+02	Raphaël Rousseau
RT00312	GYM005	b	v	8a	8	2024-10-29 00:00:00+01	Léa Robert
RT00313	GYM006	tr	v	6a	6	2024-08-16 00:00:00+02	Alice Martin
RT00314	GYM005	b	sb	8a	8	2024-08-11 00:00:00+02	Liam Moreau
RT00315	GYM006	b	v	5a	5	2024-04-29 00:00:00+02	Théo Adam
RT00316	GYM005	b	v	8a	8	2023-09-15 00:00:00+02	Nina Renard
RT00317	GYM002	l	sb	7a	7	2024-09-30 00:00:00+02	Sacha Fabre
RT00318	GYM006	b	v	5b	5	2023-10-09 00:00:00+02	Inès Fournier
RT00319	GYM006	b	sb	8a	8	2023-03-29 00:00:00+02	Théo Adam
RT00320	GYM004	b	v	6b	6	2023-07-23 00:00:00+02	Hugo Richard
RT00321	GYM004	tr	over	6a	6	2023-01-16 00:00:00+01	Gabriel Lefebvre
RT00322	GYM001	b	over	8a	8	2023-05-31 00:00:00+02	Nathan Simon
RT00323	GYM005	tr	v	5b	5	2023-09-11 00:00:00+02	Lucas Bernard
RT00324	GYM004	b	over	7a	7	2023-07-07 00:00:00+02	Théo Adam
RT00325	GYM001	b	sb	5a	5	2023-11-25 00:00:00+01	Noah Petit
RT00326	GYM004	l	over	6a	6	2024-06-27 00:00:00+02	Nathan Simon
RT00327	GYM005	tr	v	7b	7	2024-02-01 00:00:00+01	Nina Renard
RT00328	GYM006	b	v	5b	5	2024-05-31 00:00:00+02	Mila Caron
RT00329	GYM003	tr	sb	7b	7	2024-04-03 00:00:00+02	Camille Michel
RT00330	GYM005	tr	v	5b	5	2023-11-26 00:00:00+01	Raphaël Rousseau
RT00331	GYM002	l	sb	5b	5	2023-06-18 00:00:00+02	Alice Martin
RT00332	GYM004	l	over	7a	7	2024-11-23 00:00:00+01	Liam Moreau
RT00333	GYM004	l	over	7a	7	2024-01-01 00:00:00+01	Sarah Lopez
RT00334	GYM006	l	sb	7a	7	2023-06-27 00:00:00+02	Liam Moreau
RT00335	GYM002	l	sb	8a	8	2024-10-16 00:00:00+02	Tom Barbier
RT00336	GYM006	l	v	6b	6	2023-12-28 00:00:00+01	Nina Renard
RT00337	GYM002	l	over	5b	5	2024-09-30 00:00:00+02	Ethan Picard
RT00338	GYM003	l	sb	6a	6	2023-02-09 00:00:00+01	Sarah Lopez
RT00339	GYM004	b	over	7b	7	2024-02-20 00:00:00+01	Anna Marchand
RT00340	GYM004	tr	sb	7a	7	2023-12-21 00:00:00+01	Raphaël Rousseau
RT00341	GYM003	l	over	8a	8	2023-09-12 00:00:00+02	Alice Martin
RT00342	GYM001	l	v	7a	7	2023-05-23 00:00:00+02	Liam Moreau
RT00343	GYM006	tr	over	7b	7	2024-12-10 00:00:00+01	Louis Girard
RT00344	GYM003	b	over	7b	7	2024-07-30 00:00:00+02	Arthur Moulin
RT00345	GYM006	tr	over	5b	5	2023-01-11 00:00:00+01	Alice Martin
RT00346	GYM005	tr	over	7a	7	2024-09-11 00:00:00+02	Raphaël Rousseau
RT00347	GYM004	l	over	7b	7	2023-01-26 00:00:00+01	Emma Dubois
RT00348	GYM006	tr	v	6b	6	2024-02-25 00:00:00+01	Tom Barbier
RT00349	GYM002	tr	sb	6b	6	2024-10-24 00:00:00+02	Raphaël Rousseau
RT00350	GYM006	l	over	7a	7	2023-08-09 00:00:00+02	Alice Martin
RT00351	GYM005	l	v	8a	8	2024-05-10 00:00:00+02	Mila Caron
RT00352	GYM004	l	over	7b	7	2023-08-25 00:00:00+02	Théo Adam
RT00353	GYM003	l	over	5b	5	2023-08-25 00:00:00+02	Maël Perrin
RT00354	GYM005	tr	sb	5b	5	2023-08-07 00:00:00+02	Zoé Lemoine
RT00355	GYM004	tr	over	8a	8	2024-05-01 00:00:00+02	Jules Chevalier
RT00356	GYM006	b	v	5b	5	2024-04-05 00:00:00+02	Ethan Picard
RT00357	GYM001	b	v	5a	5	2024-10-24 00:00:00+02	Sacha Fabre
RT00358	GYM001	tr	sb	7a	7	2024-09-26 00:00:00+02	Tom Barbier
RT00359	GYM002	b	over	5b	5	2023-05-24 00:00:00+02	Liam Moreau
RT00360	GYM004	tr	v	6b	6	2023-07-08 00:00:00+02	Zoé Lemoine
RT00361	GYM001	b	over	7b	7	2023-09-12 00:00:00+02	Louis Girard
RT00362	GYM003	l	over	6a	6	2023-03-09 00:00:00+01	Sarah Lopez
RT00363	GYM004	b	over	8a	8	2024-09-07 00:00:00+02	Hugo Richard
RT00364	GYM003	l	sb	6a	6	2023-12-02 00:00:00+01	Lucas Bernard
RT00365	GYM003	l	over	5b	5	2024-11-01 00:00:00+01	Noah Petit
RT00366	GYM001	l	v	6a	6	2024-02-13 00:00:00+01	Manon Laurent
RT00367	GYM004	l	over	6a	6	2023-10-27 00:00:00+02	Lucas Bernard
RT00368	GYM006	b	v	5a	5	2024-08-24 00:00:00+02	Jules Chevalier
RT00369	GYM005	tr	over	6b	6	2023-12-23 00:00:00+01	Nathan Simon
RT00370	GYM001	l	v	8a	8	2023-09-13 00:00:00+02	Inès Fournier
RT00371	GYM001	b	v	6b	6	2023-12-19 00:00:00+01	Emma Dubois
RT00372	GYM006	l	over	5a	5	2024-06-04 00:00:00+02	Zoé Lemoine
RT00373	GYM004	b	over	5a	5	2024-06-07 00:00:00+02	Gabriel Lefebvre
RT00374	GYM004	b	v	6a	6	2024-11-24 00:00:00+01	Louis Girard
RT00375	GYM003	b	sb	7a	7	2023-10-11 00:00:00+02	Manon Laurent
RT00376	GYM006	tr	over	7b	7	2023-11-08 00:00:00+01	Alice Martin
RT00377	GYM006	b	sb	7b	7	2023-04-09 00:00:00+02	Raphaël Rousseau
RT00378	GYM004	b	over	6a	6	2023-07-16 00:00:00+02	Noah Petit
RT00379	GYM003	tr	over	7b	7	2024-04-26 00:00:00+02	Manon Laurent
RT00380	GYM001	tr	over	5a	5	2023-08-14 00:00:00+02	Sacha Fabre
RT00381	GYM002	b	over	6b	6	2024-09-06 00:00:00+02	Juliette Gauthier
RT00382	GYM005	tr	sb	7b	7	2024-09-09 00:00:00+02	Raphaël Rousseau
RT00383	GYM001	l	over	8a	8	2023-12-31 00:00:00+01	Arthur Moulin
RT00384	GYM004	l	v	6a	6	2024-01-03 00:00:00+01	Zoé Lemoine
RT00385	GYM005	tr	v	7a	7	2024-07-23 00:00:00+02	Sacha Fabre
RT00386	GYM002	tr	sb	6a	6	2024-08-12 00:00:00+02	Noah Petit
RT00387	GYM002	b	over	5b	5	2023-03-16 00:00:00+01	Chloé Durand
RT00388	GYM003	tr	v	6a	6	2023-02-11 00:00:00+01	Léa Robert
RT00389	GYM005	b	sb	5a	5	2024-02-26 00:00:00+01	Raphaël Rousseau
RT00390	GYM003	l	over	6b	6	2023-06-30 00:00:00+02	Juliette Gauthier
RT00391	GYM001	tr	v	6b	6	2024-06-28 00:00:00+02	Théo Adam
RT00392	GYM006	b	v	8a	8	2023-03-12 00:00:00+01	Mila Caron
RT00393	GYM006	b	sb	7b	7	2024-07-21 00:00:00+02	Maël Perrin
RT00394	GYM006	l	over	5a	5	2023-04-15 00:00:00+02	Lucas Bernard
RT00395	GYM005	tr	over	5b	5	2023-07-19 00:00:00+02	Emma Dubois
RT00396	GYM006	l	v	5a	5	2023-04-11 00:00:00+02	Alice Martin
RT00397	GYM001	b	v	6a	6	2023-11-03 00:00:00+01	Arthur Moulin
RT00398	GYM003	b	v	5a	5	2024-08-08 00:00:00+02	Mila Caron
RT00399	GYM005	tr	over	5a	5	2024-11-13 00:00:00+01	Jules Chevalier
RT00400	GYM003	b	sb	8a	8	2024-01-12 00:00:00+01	Inès Fournier
RT00401	GYM005	tr	sb	5b	5	2024-10-16 00:00:00+02	Inès Fournier
RT00402	GYM003	l	over	6a	6	2024-11-08 00:00:00+01	Louna Garnier
RT00403	GYM002	tr	sb	7a	7	2024-02-03 00:00:00+01	Noah Petit
RT00404	GYM003	tr	v	8a	8	2023-08-09 00:00:00+02	Raphaël Rousseau
RT00405	GYM006	b	sb	7a	7	2024-08-17 00:00:00+02	Mila Caron
RT00406	GYM002	b	sb	8a	8	2023-07-01 00:00:00+02	Théo Adam
RT00407	GYM003	tr	sb	6b	6	2023-11-03 00:00:00+01	Mila Caron
RT00408	GYM005	b	v	8a	8	2024-06-05 00:00:00+02	Emma Dubois
RT00409	GYM005	b	over	7b	7	2024-01-31 00:00:00+01	Lucas Bernard
RT00410	GYM005	b	v	5a	5	2023-01-04 00:00:00+01	Chloé Durand
RT00411	GYM004	tr	over	6b	6	2023-10-08 00:00:00+02	Lucas Bernard
RT00412	GYM001	b	over	5b	5	2023-08-03 00:00:00+02	Inès Fournier
RT00413	GYM005	tr	over	7a	7	2024-09-01 00:00:00+02	Raphaël Rousseau
RT00414	GYM002	b	sb	8a	8	2024-02-24 00:00:00+01	Inès Fournier
RT00415	GYM005	l	sb	5a	5	2023-04-11 00:00:00+02	Manon Laurent
RT00416	GYM004	b	over	5b	5	2024-06-04 00:00:00+02	Emma Dubois
RT00417	GYM006	b	over	7b	7	2024-07-26 00:00:00+02	Jules Chevalier
RT00418	GYM002	tr	sb	5b	5	2023-11-05 00:00:00+01	Anna Marchand
RT00419	GYM004	tr	v	5a	5	2024-10-19 00:00:00+02	Jules Chevalier
RT00420	GYM006	b	over	7b	7	2024-05-24 00:00:00+02	Inès Fournier
RT00421	GYM002	l	v	5b	5	2023-03-04 00:00:00+01	Anna Marchand
RT00422	GYM003	b	sb	7b	7	2024-09-24 00:00:00+02	Raphaël Rousseau
RT00423	GYM001	b	over	8a	8	2023-08-14 00:00:00+02	Liam Moreau
RT00424	GYM001	l	v	8a	8	2023-04-15 00:00:00+02	Gabriel Lefebvre
RT00425	GYM004	tr	v	5a	5	2024-02-29 00:00:00+01	Nina Renard
RT00426	GYM006	b	v	5a	5	2023-09-12 00:00:00+02	Élise Rolland
RT00427	GYM001	tr	sb	7b	7	2024-03-04 00:00:00+01	Raphaël Rousseau
RT00428	GYM006	tr	sb	6a	6	2024-03-09 00:00:00+01	Zoé Lemoine
RT00429	GYM006	l	v	6b	6	2023-07-26 00:00:00+02	Élise Rolland
RT00430	GYM004	l	v	5b	5	2023-01-28 00:00:00+01	Tom Barbier
RT00431	GYM004	tr	sb	5b	5	2024-11-12 00:00:00+01	Zoé Lemoine
RT00432	GYM004	b	v	6a	6	2023-12-02 00:00:00+01	Théo Adam
RT00433	GYM001	tr	v	6a	6	2024-08-10 00:00:00+02	Louis Girard
RT00434	GYM004	b	sb	6a	6	2024-09-19 00:00:00+02	Arthur Moulin
RT00435	GYM001	b	v	7a	7	2023-03-10 00:00:00+01	Gabriel Lefebvre
RT00436	GYM004	l	v	7a	7	2024-05-27 00:00:00+02	Hugo Richard
RT00437	GYM005	b	v	7b	7	2023-06-16 00:00:00+02	Liam Moreau
RT00438	GYM006	b	sb	7a	7	2024-12-30 00:00:00+01	Nathan Simon
RT00439	GYM004	tr	v	8a	8	2024-01-03 00:00:00+01	Manon Laurent
RT00440	GYM002	l	sb	8a	8	2023-09-08 00:00:00+02	Lucas Bernard
RT00441	GYM006	b	sb	5a	5	2024-11-16 00:00:00+01	Ethan Picard
RT00442	GYM006	b	over	7b	7	2023-06-19 00:00:00+02	Sarah Lopez
RT00443	GYM004	l	over	5b	5	2023-03-31 00:00:00+02	Liam Moreau
RT00444	GYM003	tr	v	6b	6	2024-07-14 00:00:00+02	Lucas Bernard
RT00445	GYM004	l	sb	5a	5	2024-03-21 00:00:00+01	Manon Laurent
RT00446	GYM006	l	over	5b	5	2023-10-21 00:00:00+02	Anna Marchand
RT00447	GYM002	b	v	5b	5	2023-05-30 00:00:00+02	Théo Adam
RT00448	GYM006	b	over	7b	7	2023-05-12 00:00:00+02	Nina Renard
RT00449	GYM002	tr	over	6a	6	2024-03-08 00:00:00+01	Arthur Moulin
RT00450	GYM001	b	sb	6a	6	2023-02-28 00:00:00+01	Léa Robert
RT00451	GYM005	b	sb	5a	5	2023-07-18 00:00:00+02	Nina Renard
RT00452	GYM006	l	over	6a	6	2023-08-03 00:00:00+02	Alice Martin
RT00453	GYM004	b	over	5b	5	2024-07-14 00:00:00+02	Louna Garnier
RT00454	GYM001	tr	sb	6a	6	2024-04-16 00:00:00+02	Arthur Moulin
RT00455	GYM005	l	v	7a	7	2023-09-04 00:00:00+02	Inès Fournier
RT00456	GYM004	tr	sb	6a	6	2024-01-17 00:00:00+01	Sarah Lopez
RT00457	GYM003	l	over	5b	5	2023-08-27 00:00:00+02	Louna Garnier
RT00458	GYM004	b	v	7b	7	2024-01-02 00:00:00+01	Anna Marchand
RT00459	GYM002	l	over	5a	5	2023-06-17 00:00:00+02	Inès Fournier
RT00460	GYM002	l	v	6b	6	2024-07-13 00:00:00+02	Louna Garnier
RT00461	GYM003	b	over	6a	6	2023-02-20 00:00:00+01	Théo Adam
RT00462	GYM001	b	v	8a	8	2024-09-01 00:00:00+02	Juliette Gauthier
RT00463	GYM005	tr	v	8a	8	2024-12-28 00:00:00+01	Alice Martin
RT00464	GYM004	tr	over	5b	5	2024-11-19 00:00:00+01	Anna Marchand
RT00465	GYM002	b	v	6b	6	2024-01-15 00:00:00+01	Alice Martin
RT00466	GYM001	b	sb	6b	6	2024-04-18 00:00:00+02	Chloé Durand
RT00467	GYM003	b	over	7a	7	2023-03-21 00:00:00+01	Nina Renard
RT00468	GYM006	l	sb	6b	6	2024-11-27 00:00:00+01	Manon Laurent
RT00469	GYM002	l	over	8a	8	2024-01-02 00:00:00+01	Théo Adam
RT00470	GYM003	l	v	7b	7	2024-04-05 00:00:00+02	Théo Adam
RT00471	GYM004	b	v	5b	5	2024-06-22 00:00:00+02	Camille Michel
RT00472	GYM005	tr	v	5b	5	2024-03-27 00:00:00+01	Emma Dubois
RT00473	GYM002	b	over	6a	6	2024-04-08 00:00:00+02	Chloé Durand
RT00474	GYM002	l	sb	6a	6	2024-04-22 00:00:00+02	Gabriel Lefebvre
RT00475	GYM004	l	sb	6a	6	2024-02-24 00:00:00+01	Noah Petit
RT00476	GYM006	b	over	8a	8	2024-12-07 00:00:00+01	Hugo Richard
RT00477	GYM001	b	over	8a	8	2023-08-02 00:00:00+02	Léa Robert
RT00478	GYM005	l	sb	8a	8	2024-01-04 00:00:00+01	Sarah Lopez
RT00479	GYM002	l	sb	8a	8	2023-04-24 00:00:00+02	Lucas Bernard
RT00480	GYM005	l	sb	8a	8	2024-05-17 00:00:00+02	Nina Renard
RT00481	GYM002	b	sb	8a	8	2024-09-27 00:00:00+02	Mila Caron
RT00482	GYM005	l	over	7b	7	2024-08-10 00:00:00+02	Zoé Lemoine
RT00483	GYM003	l	over	8a	8	2023-11-07 00:00:00+01	Alice Martin
RT00484	GYM002	tr	v	6b	6	2024-04-13 00:00:00+02	Arthur Moulin
RT00485	GYM005	b	sb	6b	6	2024-12-08 00:00:00+01	Chloé Durand
RT00486	GYM001	tr	v	7a	7	2023-02-13 00:00:00+01	Zoé Lemoine
RT00487	GYM003	tr	over	7b	7	2024-02-19 00:00:00+01	Léa Robert
RT00488	GYM003	l	over	6a	6	2024-11-28 00:00:00+01	Maël Perrin
RT00489	GYM001	b	v	5a	5	2023-09-03 00:00:00+02	Nina Renard
RT00490	GYM005	l	sb	8a	8	2023-03-25 00:00:00+01	Louis Girard
RT00491	GYM004	b	sb	7a	7	2023-07-26 00:00:00+02	Manon Laurent
RT00492	GYM001	tr	sb	5a	5	2023-05-31 00:00:00+02	Sarah Lopez
RT00493	GYM005	b	sb	6b	6	2024-10-29 00:00:00+01	Noah Petit
RT00494	GYM001	l	v	7a	7	2024-06-11 00:00:00+02	Théo Adam
RT00495	GYM001	l	v	7a	7	2023-06-14 00:00:00+02	Anna Marchand
RT00496	GYM002	l	over	5b	5	2023-05-25 00:00:00+02	Hugo Richard
RT00497	GYM005	b	sb	6b	6	2023-02-06 00:00:00+01	Zoé Lemoine
RT00498	GYM004	tr	sb	6b	6	2023-11-29 00:00:00+01	Camille Michel
RT00499	GYM002	tr	sb	7b	7	2024-02-07 00:00:00+01	Chloé Durand
RT00500	GYM001	b	v	7a	7	2024-02-18 00:00:00+01	Zoé Lemoine
RT00501	GYM006	l	sb	8a	8	2023-02-14 00:00:00+01	Sarah Lopez
RT00502	GYM001	tr	v	6b	6	2024-02-06 00:00:00+01	Emma Dubois
RT00503	GYM001	l	sb	7a	7	2023-07-25 00:00:00+02	Noah Petit
RT00504	GYM005	b	sb	7b	7	2023-03-03 00:00:00+01	Gabriel Lefebvre
RT00505	GYM005	l	over	8a	8	2024-02-24 00:00:00+01	Lucas Bernard
RT00506	GYM002	tr	sb	7b	7	2024-04-12 00:00:00+02	Ethan Picard
RT00507	GYM004	tr	sb	5b	5	2023-01-19 00:00:00+01	Jules Chevalier
RT00508	GYM002	l	over	8a	8	2023-12-31 00:00:00+01	Jules Chevalier
RT00509	GYM003	b	v	7a	7	2023-10-27 00:00:00+02	Camille Michel
RT00510	GYM001	l	v	6b	6	2023-01-07 00:00:00+01	Nina Renard
RT00511	GYM006	b	sb	6b	6	2024-03-03 00:00:00+01	Gabriel Lefebvre
RT00512	GYM001	l	v	7a	7	2023-04-27 00:00:00+02	Jules Chevalier
RT00513	GYM001	tr	sb	7a	7	2024-08-02 00:00:00+02	Jules Chevalier
RT00514	GYM002	b	over	7a	7	2024-05-21 00:00:00+02	Zoé Lemoine
RT00515	GYM006	b	over	6a	6	2024-06-29 00:00:00+02	Léa Robert
RT00516	GYM006	b	sb	8a	8	2024-12-06 00:00:00+01	Louis Girard
RT00517	GYM006	tr	over	6b	6	2023-11-21 00:00:00+01	Lucas Bernard
RT00518	GYM002	l	over	8a	8	2023-02-24 00:00:00+01	Tom Barbier
RT00519	GYM001	tr	sb	7b	7	2023-02-11 00:00:00+01	Juliette Gauthier
RT00520	GYM002	b	sb	6b	6	2023-10-24 00:00:00+02	Arthur Moulin
RT00521	GYM005	l	over	6a	6	2023-08-19 00:00:00+02	Hugo Richard
RT00522	GYM005	tr	v	7a	7	2024-03-28 00:00:00+01	Sacha Fabre
RT00523	GYM002	b	v	5b	5	2024-01-29 00:00:00+01	Nathan Simon
RT00524	GYM006	b	sb	7a	7	2024-06-05 00:00:00+02	Ethan Picard
RT00525	GYM001	tr	sb	7a	7	2023-12-24 00:00:00+01	Inès Fournier
RT00526	GYM002	tr	v	6a	6	2024-03-19 00:00:00+01	Sarah Lopez
RT00527	GYM002	tr	over	8a	8	2023-05-08 00:00:00+02	Zoé Lemoine
RT00528	GYM002	b	v	6b	6	2024-11-21 00:00:00+01	Gabriel Lefebvre
RT00529	GYM003	tr	v	7a	7	2024-02-09 00:00:00+01	Camille Michel
RT00530	GYM005	b	v	6b	6	2024-01-27 00:00:00+01	Hugo Richard
RT00531	GYM006	tr	v	5a	5	2023-07-12 00:00:00+02	Nathan Simon
RT00532	GYM004	b	sb	7b	7	2024-08-26 00:00:00+02	Sarah Lopez
RT00533	GYM006	b	sb	8a	8	2023-03-19 00:00:00+01	Hugo Richard
RT00534	GYM004	l	over	6b	6	2023-03-26 00:00:00+01	Inès Fournier
RT00535	GYM003	tr	over	5b	5	2023-01-30 00:00:00+01	Emma Dubois
RT00536	GYM002	tr	over	7b	7	2024-12-25 00:00:00+01	Théo Adam
RT00537	GYM003	b	over	5b	5	2023-02-18 00:00:00+01	Nina Renard
RT00538	GYM003	b	v	7a	7	2023-05-25 00:00:00+02	Gabriel Lefebvre
RT00539	GYM001	b	sb	7b	7	2023-03-10 00:00:00+01	Nathan Simon
RT00540	GYM005	l	sb	6b	6	2023-02-27 00:00:00+01	Maël Perrin
RT00541	GYM004	l	over	7b	7	2024-11-27 00:00:00+01	Théo Adam
RT00542	GYM002	b	over	7a	7	2024-07-27 00:00:00+02	Nina Renard
RT00543	GYM004	tr	v	6a	6	2024-04-23 00:00:00+02	Théo Adam
RT00544	GYM006	tr	v	8a	8	2024-03-20 00:00:00+01	Louis Girard
RT00545	GYM004	l	over	5b	5	2023-10-23 00:00:00+02	Chloé Durand
RT00546	GYM006	l	sb	7a	7	2024-11-08 00:00:00+01	Élise Rolland
RT00547	GYM005	b	sb	6a	6	2023-06-20 00:00:00+02	Arthur Moulin
RT00548	GYM006	tr	sb	7b	7	2024-07-28 00:00:00+02	Chloé Durand
RT00549	GYM004	b	over	7b	7	2023-05-27 00:00:00+02	Inès Fournier
RT00550	GYM004	l	sb	7a	7	2024-04-28 00:00:00+02	Mila Caron
RT00551	GYM006	tr	v	6b	6	2023-11-02 00:00:00+01	Tom Barbier
RT00552	GYM003	tr	v	7b	7	2024-11-03 00:00:00+01	Louis Girard
RT00553	GYM005	l	over	6b	6	2024-10-14 00:00:00+02	Nathan Simon
RT00554	GYM001	b	v	6b	6	2024-08-31 00:00:00+02	Inès Fournier
RT00555	GYM002	b	over	8a	8	2024-03-21 00:00:00+01	Anna Marchand
RT00556	GYM004	tr	sb	6b	6	2023-08-09 00:00:00+02	Manon Laurent
RT00557	GYM002	l	sb	5a	5	2024-07-08 00:00:00+02	Juliette Gauthier
RT00558	GYM001	tr	sb	8a	8	2024-01-13 00:00:00+01	Camille Michel
RT00559	GYM002	l	v	6a	6	2024-09-11 00:00:00+02	Nina Renard
RT00560	GYM001	b	over	6a	6	2023-09-23 00:00:00+02	Élise Rolland
RT00561	GYM006	l	sb	7b	7	2023-04-05 00:00:00+02	Tom Barbier
RT00562	GYM003	b	over	7b	7	2023-09-19 00:00:00+02	Sarah Lopez
RT00563	GYM004	l	sb	6b	6	2023-03-12 00:00:00+01	Tom Barbier
RT00564	GYM001	tr	v	8a	8	2023-08-07 00:00:00+02	Léa Robert
RT00565	GYM002	b	v	8a	8	2024-06-16 00:00:00+02	Léa Robert
RT00566	GYM004	tr	over	5a	5	2023-04-02 00:00:00+02	Juliette Gauthier
RT00567	GYM003	tr	v	6b	6	2023-05-07 00:00:00+02	Lucas Bernard
RT00568	GYM006	b	v	5a	5	2023-03-21 00:00:00+01	Ethan Picard
RT00569	GYM004	b	over	6b	6	2023-08-26 00:00:00+02	Théo Adam
RT00570	GYM001	tr	sb	5b	5	2024-01-07 00:00:00+01	Hugo Richard
RT00571	GYM003	tr	v	5b	5	2024-04-30 00:00:00+02	Anna Marchand
RT00572	GYM002	tr	over	7a	7	2024-11-24 00:00:00+01	Anna Marchand
RT00573	GYM003	tr	v	6b	6	2023-01-25 00:00:00+01	Raphaël Rousseau
RT00574	GYM003	b	v	8a	8	2023-06-05 00:00:00+02	Raphaël Rousseau
RT00575	GYM005	b	v	7b	7	2024-05-31 00:00:00+02	Juliette Gauthier
RT00576	GYM003	tr	v	6a	6	2024-09-23 00:00:00+02	Élise Rolland
RT00577	GYM003	l	over	7a	7	2024-06-13 00:00:00+02	Camille Michel
RT00578	GYM004	l	over	7b	7	2024-12-10 00:00:00+01	Mila Caron
RT00579	GYM002	b	over	5b	5	2023-02-26 00:00:00+01	Maël Perrin
RT00580	GYM004	tr	v	6b	6	2024-08-27 00:00:00+02	Nina Renard
RT00581	GYM004	tr	v	7a	7	2023-01-19 00:00:00+01	Noah Petit
RT00582	GYM001	b	v	6b	6	2024-01-19 00:00:00+01	Louis Girard
RT00583	GYM004	l	over	5b	5	2023-07-12 00:00:00+02	Élise Rolland
RT00584	GYM005	l	v	7a	7	2023-08-25 00:00:00+02	Nathan Simon
RT00585	GYM005	l	sb	5b	5	2024-01-22 00:00:00+01	Liam Moreau
RT00586	GYM001	b	v	5a	5	2024-03-01 00:00:00+01	Jules Chevalier
RT00587	GYM006	l	sb	5b	5	2023-10-04 00:00:00+02	Théo Adam
RT00588	GYM002	b	v	8a	8	2023-08-15 00:00:00+02	Raphaël Rousseau
RT00589	GYM002	b	over	8a	8	2024-07-05 00:00:00+02	Chloé Durand
RT00590	GYM004	tr	v	6b	6	2023-11-19 00:00:00+01	Tom Barbier
RT00591	GYM004	l	sb	6a	6	2023-06-02 00:00:00+02	Louis Girard
RT00592	GYM006	b	sb	5b	5	2024-09-30 00:00:00+02	Juliette Gauthier
RT00593	GYM004	l	v	7b	7	2023-08-25 00:00:00+02	Juliette Gauthier
RT00594	GYM002	l	sb	8a	8	2023-02-24 00:00:00+01	Jules Chevalier
RT00595	GYM003	tr	sb	6a	6	2024-03-11 00:00:00+01	Raphaël Rousseau
RT00596	GYM005	l	over	5a	5	2024-11-14 00:00:00+01	Alice Martin
RT00597	GYM003	tr	v	7a	7	2023-04-19 00:00:00+02	Théo Adam
RT00598	GYM003	b	v	7a	7	2023-07-03 00:00:00+02	Mila Caron
RT00599	GYM002	l	v	8a	8	2024-01-03 00:00:00+01	Mila Caron
RT00600	GYM003	b	sb	6a	6	2023-07-17 00:00:00+02	Inès Fournier
RT00601	GYM006	l	v	8a	8	2024-01-06 00:00:00+01	Noah Petit
RT00602	GYM001	b	v	7a	7	2024-01-08 00:00:00+01	Sacha Fabre
RT00603	GYM004	l	over	5b	5	2024-05-11 00:00:00+02	Maël Perrin
RT00604	GYM001	l	over	6a	6	2024-08-21 00:00:00+02	Tom Barbier
RT00605	GYM005	l	over	6b	6	2023-07-20 00:00:00+02	Sacha Fabre
RT00606	GYM004	l	sb	5b	5	2024-05-23 00:00:00+02	Jules Chevalier
RT00607	GYM003	l	v	5b	5	2023-11-18 00:00:00+01	Louna Garnier
RT00608	GYM005	l	over	5b	5	2023-10-02 00:00:00+02	Lucas Bernard
RT00609	GYM004	l	over	6b	6	2023-07-30 00:00:00+02	Inès Fournier
RT00610	GYM006	l	over	5a	5	2024-05-18 00:00:00+02	Nathan Simon
RT00611	GYM006	l	v	7b	7	2023-04-28 00:00:00+02	Tom Barbier
RT00612	GYM006	b	v	8a	8	2024-12-03 00:00:00+01	Lucas Bernard
RT00613	GYM006	tr	v	7a	7	2024-07-07 00:00:00+02	Juliette Gauthier
RT00614	GYM003	l	sb	8a	8	2023-02-11 00:00:00+01	Juliette Gauthier
RT00615	GYM001	tr	sb	6a	6	2023-11-11 00:00:00+01	Zoé Lemoine
RT00616	GYM004	l	over	5a	5	2023-11-25 00:00:00+01	Nathan Simon
RT00617	GYM003	l	v	6a	6	2023-01-17 00:00:00+01	Juliette Gauthier
RT00618	GYM006	b	over	8a	8	2023-10-10 00:00:00+02	Chloé Durand
RT00619	GYM001	b	v	7a	7	2023-09-15 00:00:00+02	Tom Barbier
RT00620	GYM005	tr	v	6b	6	2024-07-28 00:00:00+02	Inès Fournier
RT00621	GYM005	b	v	8a	8	2024-07-27 00:00:00+02	Louna Garnier
RT00622	GYM005	b	sb	5b	5	2024-09-03 00:00:00+02	Nina Renard
RT00623	GYM006	tr	sb	8a	8	2023-01-19 00:00:00+01	Hugo Richard
RT00624	GYM005	b	v	5b	5	2024-06-12 00:00:00+02	Chloé Durand
RT00625	GYM002	l	over	6b	6	2024-02-27 00:00:00+01	Raphaël Rousseau
RT00626	GYM004	tr	v	8a	8	2024-04-10 00:00:00+02	Inès Fournier
RT00627	GYM004	tr	v	5a	5	2024-01-08 00:00:00+01	Alice Martin
RT00628	GYM006	l	over	5a	5	2023-03-22 00:00:00+01	Zoé Lemoine
RT00629	GYM002	b	v	6a	6	2024-07-04 00:00:00+02	Chloé Durand
RT00630	GYM003	tr	over	6b	6	2024-07-01 00:00:00+02	Manon Laurent
RT00631	GYM003	tr	sb	5a	5	2024-02-28 00:00:00+01	Raphaël Rousseau
RT00632	GYM005	l	sb	8a	8	2024-03-04 00:00:00+01	Mila Caron
RT00633	GYM001	l	over	6b	6	2024-01-23 00:00:00+01	Nina Renard
RT00634	GYM003	b	sb	7a	7	2024-12-09 00:00:00+01	Raphaël Rousseau
RT00635	GYM001	tr	sb	5b	5	2024-10-31 00:00:00+01	Théo Adam
RT00636	GYM004	b	over	8a	8	2023-07-23 00:00:00+02	Juliette Gauthier
RT00637	GYM001	b	sb	5b	5	2023-07-15 00:00:00+02	Maël Perrin
RT00638	GYM004	l	v	5b	5	2024-12-28 00:00:00+01	Anna Marchand
RT00639	GYM002	tr	v	6b	6	2023-10-12 00:00:00+02	Alice Martin
RT00640	GYM002	tr	over	6b	6	2023-07-15 00:00:00+02	Alice Martin
RT00641	GYM006	tr	sb	6a	6	2023-11-03 00:00:00+01	Gabriel Lefebvre
RT00642	GYM006	l	v	5b	5	2024-10-25 00:00:00+02	Inès Fournier
RT00643	GYM005	l	v	6a	6	2023-01-14 00:00:00+01	Liam Moreau
RT00644	GYM003	l	sb	5b	5	2023-05-26 00:00:00+02	Maël Perrin
RT00645	GYM005	l	sb	6a	6	2023-02-26 00:00:00+01	Hugo Richard
RT00646	GYM004	l	v	6a	6	2024-12-23 00:00:00+01	Gabriel Lefebvre
RT00647	GYM005	tr	v	7a	7	2023-07-29 00:00:00+02	Jules Chevalier
RT00648	GYM001	b	over	6a	6	2024-06-12 00:00:00+02	Noah Petit
RT00649	GYM004	tr	over	6b	6	2023-12-10 00:00:00+01	Manon Laurent
RT00650	GYM006	b	v	6a	6	2024-12-15 00:00:00+01	Sarah Lopez
RT00651	GYM002	l	over	5b	5	2024-09-02 00:00:00+02	Ethan Picard
RT00652	GYM006	b	v	6a	6	2023-10-06 00:00:00+02	Ethan Picard
RT00653	GYM003	tr	v	5a	5	2023-07-28 00:00:00+02	Zoé Lemoine
RT00654	GYM004	tr	over	7b	7	2024-10-02 00:00:00+02	Nina Renard
RT00655	GYM004	b	over	5b	5	2023-12-01 00:00:00+01	Zoé Lemoine
RT00656	GYM001	l	sb	5a	5	2023-10-15 00:00:00+02	Manon Laurent
RT00657	GYM003	l	sb	5b	5	2023-09-09 00:00:00+02	Léa Robert
RT00658	GYM002	tr	sb	6b	6	2023-09-22 00:00:00+02	Nina Renard
RT00659	GYM004	b	v	7b	7	2023-09-28 00:00:00+02	Élise Rolland
RT00660	GYM004	l	over	7b	7	2024-11-30 00:00:00+01	Liam Moreau
RT00661	GYM001	l	v	6b	6	2024-02-23 00:00:00+01	Emma Dubois
RT00662	GYM005	tr	over	7b	7	2024-12-26 00:00:00+01	Camille Michel
RT00663	GYM002	l	v	6b	6	2023-07-30 00:00:00+02	Nina Renard
RT00664	GYM006	b	sb	5a	5	2023-12-31 00:00:00+01	Sacha Fabre
RT00665	GYM003	tr	sb	7a	7	2023-03-17 00:00:00+01	Tom Barbier
RT00666	GYM004	tr	sb	5b	5	2024-10-21 00:00:00+02	Noah Petit
RT00667	GYM004	b	v	6b	6	2023-11-17 00:00:00+01	Juliette Gauthier
RT00668	GYM006	tr	over	5b	5	2024-12-25 00:00:00+01	Jules Chevalier
RT00669	GYM002	l	over	5a	5	2024-03-08 00:00:00+01	Anna Marchand
RT00670	GYM005	l	sb	7a	7	2023-04-19 00:00:00+02	Jules Chevalier
RT00671	GYM004	b	sb	5a	5	2024-10-02 00:00:00+02	Juliette Gauthier
RT00672	GYM002	l	sb	7b	7	2024-06-05 00:00:00+02	Sarah Lopez
RT00673	GYM006	b	sb	5b	5	2023-02-16 00:00:00+01	Manon Laurent
RT00674	GYM001	b	over	8a	8	2024-01-14 00:00:00+01	Sacha Fabre
RT00675	GYM005	l	v	7a	7	2023-04-06 00:00:00+02	Maël Perrin
RT00676	GYM003	b	v	7b	7	2023-04-13 00:00:00+02	Élise Rolland
RT00677	GYM004	l	v	7a	7	2023-05-26 00:00:00+02	Tom Barbier
RT00678	GYM002	tr	v	7b	7	2023-01-27 00:00:00+01	Sacha Fabre
RT00679	GYM001	tr	sb	5a	5	2024-06-13 00:00:00+02	Hugo Richard
RT00680	GYM003	b	sb	6b	6	2024-11-09 00:00:00+01	Ethan Picard
RT00681	GYM002	l	sb	5b	5	2023-03-23 00:00:00+01	Inès Fournier
RT00682	GYM002	l	v	6a	6	2024-03-03 00:00:00+01	Anna Marchand
RT00683	GYM003	tr	sb	6a	6	2024-08-06 00:00:00+02	Lucas Bernard
RT00684	GYM001	tr	sb	5a	5	2024-04-23 00:00:00+02	Alice Martin
RT00685	GYM006	l	over	5b	5	2023-06-11 00:00:00+02	Gabriel Lefebvre
RT00686	GYM001	b	over	5b	5	2024-02-06 00:00:00+01	Théo Adam
RT00687	GYM005	tr	sb	5a	5	2024-05-22 00:00:00+02	Ethan Picard
RT00688	GYM004	b	over	5b	5	2023-02-07 00:00:00+01	Emma Dubois
RT00689	GYM003	b	over	6b	6	2024-05-25 00:00:00+02	Gabriel Lefebvre
RT00690	GYM006	tr	sb	5a	5	2024-01-28 00:00:00+01	Nathan Simon
RT00691	GYM003	b	sb	6b	6	2024-12-13 00:00:00+01	Arthur Moulin
RT00692	GYM003	b	sb	5b	5	2024-05-08 00:00:00+02	Ethan Picard
RT00693	GYM001	l	sb	5a	5	2023-07-19 00:00:00+02	Élise Rolland
RT00694	GYM004	b	v	5b	5	2023-09-12 00:00:00+02	Théo Adam
RT00695	GYM005	l	v	5a	5	2023-06-28 00:00:00+02	Liam Moreau
RT00696	GYM002	tr	sb	5b	5	2024-06-30 00:00:00+02	Tom Barbier
RT00697	GYM002	tr	over	6b	6	2024-08-16 00:00:00+02	Élise Rolland
RT00698	GYM003	l	sb	8a	8	2024-01-24 00:00:00+01	Nathan Simon
RT00699	GYM004	tr	sb	6b	6	2024-02-02 00:00:00+01	Sarah Lopez
RT00700	GYM006	b	over	5b	5	2023-06-07 00:00:00+02	Hugo Richard
RT00701	GYM001	b	v	5a	5	2023-01-04 00:00:00+01	Emma Dubois
RT00702	GYM004	b	sb	6a	6	2023-06-16 00:00:00+02	Sacha Fabre
RT00703	GYM004	tr	sb	6b	6	2024-04-12 00:00:00+02	Léa Robert
RT00704	GYM001	b	v	6b	6	2024-02-13 00:00:00+01	Zoé Lemoine
RT00705	GYM003	tr	v	7b	7	2024-02-16 00:00:00+01	Manon Laurent
RT00706	GYM004	b	over	6a	6	2023-07-23 00:00:00+02	Nina Renard
RT00707	GYM002	l	v	5b	5	2023-07-13 00:00:00+02	Sacha Fabre
RT00708	GYM001	tr	v	8a	8	2023-08-23 00:00:00+02	Zoé Lemoine
RT00709	GYM006	tr	v	5a	5	2024-12-18 00:00:00+01	Sarah Lopez
RT00710	GYM005	b	over	7b	7	2023-05-30 00:00:00+02	Louna Garnier
RT00711	GYM003	tr	v	5b	5	2023-06-08 00:00:00+02	Juliette Gauthier
RT00712	GYM001	tr	v	7a	7	2023-10-06 00:00:00+02	Camille Michel
RT00713	GYM005	l	over	8a	8	2024-02-08 00:00:00+01	Alice Martin
RT00714	GYM005	l	v	6b	6	2024-11-08 00:00:00+01	Ethan Picard
RT00715	GYM006	b	v	7a	7	2023-11-07 00:00:00+01	Lucas Bernard
RT00716	GYM004	l	over	6b	6	2023-03-09 00:00:00+01	Liam Moreau
RT00717	GYM006	b	sb	6b	6	2024-04-07 00:00:00+02	Camille Michel
RT00718	GYM004	b	over	7a	7	2023-03-29 00:00:00+02	Alice Martin
RT00719	GYM004	b	v	8a	8	2023-08-05 00:00:00+02	Léa Robert
RT00720	GYM001	tr	v	7a	7	2023-01-01 00:00:00+01	Élise Rolland
RT00721	GYM001	l	v	5b	5	2023-05-15 00:00:00+02	Manon Laurent
RT00722	GYM003	b	over	7b	7	2024-11-27 00:00:00+01	Léa Robert
RT00723	GYM004	l	v	7b	7	2023-12-17 00:00:00+01	Nathan Simon
RT00724	GYM005	b	v	7a	7	2023-05-20 00:00:00+02	Nina Renard
RT00725	GYM002	l	over	5b	5	2024-09-09 00:00:00+02	Élise Rolland
RT00726	GYM003	l	sb	7b	7	2023-05-13 00:00:00+02	Liam Moreau
RT00727	GYM001	b	sb	5b	5	2024-09-11 00:00:00+02	Chloé Durand
RT00728	GYM006	tr	v	5b	5	2023-06-27 00:00:00+02	Noah Petit
RT00729	GYM003	l	over	6b	6	2023-12-24 00:00:00+01	Mila Caron
RT00730	GYM003	tr	v	7b	7	2024-01-15 00:00:00+01	Arthur Moulin
RT00731	GYM003	tr	over	7b	7	2024-10-19 00:00:00+02	Louna Garnier
RT00732	GYM003	b	over	6b	6	2024-03-25 00:00:00+01	Jules Chevalier
RT00733	GYM002	b	sb	7a	7	2024-08-08 00:00:00+02	Sacha Fabre
RT00734	GYM006	b	sb	6b	6	2024-04-07 00:00:00+02	Raphaël Rousseau
RT00735	GYM006	l	over	7b	7	2023-04-18 00:00:00+02	Nina Renard
RT00736	GYM006	b	v	7b	7	2023-05-02 00:00:00+02	Mila Caron
RT00737	GYM004	b	sb	8a	8	2023-01-17 00:00:00+01	Louna Garnier
RT00738	GYM005	l	v	7a	7	2023-07-15 00:00:00+02	Chloé Durand
RT00739	GYM006	l	sb	6b	6	2023-11-23 00:00:00+01	Nina Renard
RT00740	GYM003	b	sb	5a	5	2023-11-14 00:00:00+01	Inès Fournier
RT00741	GYM003	b	v	5a	5	2024-04-23 00:00:00+02	Noah Petit
RT00742	GYM006	b	sb	7a	7	2023-09-09 00:00:00+02	Sacha Fabre
RT00743	GYM006	b	sb	6b	6	2024-05-17 00:00:00+02	Alice Martin
RT00744	GYM003	tr	v	6b	6	2023-04-29 00:00:00+02	Nina Renard
RT00745	GYM004	tr	sb	5b	5	2024-11-04 00:00:00+01	Manon Laurent
RT00746	GYM001	b	sb	7b	7	2024-12-10 00:00:00+01	Jules Chevalier
RT00747	GYM001	tr	sb	6a	6	2024-05-12 00:00:00+02	Inès Fournier
RT00748	GYM006	l	v	8a	8	2024-04-30 00:00:00+02	Louis Girard
RT00749	GYM002	tr	over	7a	7	2023-02-14 00:00:00+01	Sarah Lopez
RT00750	GYM006	tr	v	6a	6	2023-11-10 00:00:00+01	Alice Martin
RT00751	GYM006	b	over	6a	6	2023-06-28 00:00:00+02	Hugo Richard
RT00752	GYM001	tr	sb	7a	7	2024-02-22 00:00:00+01	Sacha Fabre
RT00753	GYM003	tr	over	6b	6	2024-07-09 00:00:00+02	Nathan Simon
RT00754	GYM006	tr	v	7a	7	2023-03-19 00:00:00+01	Sarah Lopez
RT00755	GYM003	tr	v	6a	6	2023-11-22 00:00:00+01	Ethan Picard
RT00756	GYM003	l	sb	7b	7	2024-11-20 00:00:00+01	Anna Marchand
RT00757	GYM002	b	over	8a	8	2023-12-23 00:00:00+01	Noah Petit
RT00758	GYM003	b	sb	8a	8	2024-02-20 00:00:00+01	Sarah Lopez
RT00759	GYM001	l	sb	7b	7	2024-05-29 00:00:00+02	Juliette Gauthier
RT00760	GYM004	tr	v	7b	7	2023-08-02 00:00:00+02	Mila Caron
RT00761	GYM004	l	over	6b	6	2023-03-15 00:00:00+01	Jules Chevalier
RT00762	GYM005	tr	over	5a	5	2024-07-16 00:00:00+02	Nina Renard
RT00763	GYM006	l	over	7a	7	2024-08-01 00:00:00+02	Nina Renard
RT00764	GYM001	b	over	8a	8	2024-05-23 00:00:00+02	Jules Chevalier
RT00765	GYM003	b	sb	7b	7	2023-11-28 00:00:00+01	Lucas Bernard
RT00766	GYM004	b	sb	7a	7	2023-04-03 00:00:00+02	Juliette Gauthier
RT00767	GYM001	tr	v	8a	8	2024-11-18 00:00:00+01	Louna Garnier
RT00768	GYM004	tr	sb	7b	7	2024-10-18 00:00:00+02	Zoé Lemoine
RT00769	GYM003	l	sb	8a	8	2024-06-02 00:00:00+02	Hugo Richard
RT00770	GYM004	l	v	6b	6	2023-09-26 00:00:00+02	Louna Garnier
RT00771	GYM006	b	v	5a	5	2024-01-11 00:00:00+01	Louis Girard
RT00772	GYM006	tr	v	5a	5	2023-01-04 00:00:00+01	Emma Dubois
RT00773	GYM005	l	sb	7b	7	2023-05-18 00:00:00+02	Sarah Lopez
RT00774	GYM005	tr	sb	8a	8	2023-08-19 00:00:00+02	Zoé Lemoine
RT00775	GYM004	tr	v	6b	6	2024-08-22 00:00:00+02	Hugo Richard
RT00776	GYM001	b	v	5b	5	2024-06-12 00:00:00+02	Juliette Gauthier
RT00777	GYM006	b	v	7a	7	2023-02-21 00:00:00+01	Nina Renard
RT00778	GYM001	tr	sb	7a	7	2024-10-07 00:00:00+02	Tom Barbier
RT00779	GYM001	tr	sb	6a	6	2024-12-23 00:00:00+01	Camille Michel
RT00780	GYM004	tr	over	6b	6	2023-11-21 00:00:00+01	Emma Dubois
RT00781	GYM001	tr	sb	8a	8	2024-12-31 00:00:00+01	Sarah Lopez
RT00782	GYM006	b	sb	6a	6	2024-12-17 00:00:00+01	Manon Laurent
RT00783	GYM003	l	sb	7b	7	2024-12-23 00:00:00+01	Anna Marchand
RT00784	GYM005	b	v	8a	8	2023-10-04 00:00:00+02	Lucas Bernard
RT00785	GYM003	l	sb	6a	6	2024-06-19 00:00:00+02	Inès Fournier
RT00786	GYM001	tr	v	5a	5	2024-04-30 00:00:00+02	Sarah Lopez
RT00787	GYM003	l	over	7a	7	2024-05-30 00:00:00+02	Louis Girard
RT00788	GYM006	b	over	8a	8	2023-06-01 00:00:00+02	Zoé Lemoine
RT00789	GYM006	b	v	6a	6	2024-04-27 00:00:00+02	Zoé Lemoine
RT00790	GYM001	tr	v	5a	5	2023-09-16 00:00:00+02	Hugo Richard
RT00791	GYM004	b	v	6b	6	2023-11-20 00:00:00+01	Louna Garnier
RT00792	GYM003	tr	sb	6a	6	2023-06-17 00:00:00+02	Emma Dubois
RT00793	GYM004	b	over	7b	7	2024-11-18 00:00:00+01	Arthur Moulin
RT00794	GYM004	b	v	7b	7	2023-11-06 00:00:00+01	Jules Chevalier
RT00795	GYM002	tr	sb	7b	7	2024-04-23 00:00:00+02	Louis Girard
RT00796	GYM001	l	over	8a	8	2023-02-25 00:00:00+01	Anna Marchand
RT00797	GYM005	b	sb	7a	7	2024-09-11 00:00:00+02	Liam Moreau
RT00798	GYM006	l	over	6a	6	2024-04-17 00:00:00+02	Nina Renard
RT00799	GYM006	b	sb	6b	6	2023-10-23 00:00:00+02	Nina Renard
RT00800	GYM001	b	over	6a	6	2024-04-05 00:00:00+02	Juliette Gauthier
RT00801	GYM005	b	over	7a	7	2023-11-20 00:00:00+01	Maël Perrin
RT00802	GYM006	b	sb	5a	5	2023-05-21 00:00:00+02	Hugo Richard
RT00803	GYM001	l	v	7a	7	2024-10-28 00:00:00+01	Noah Petit
RT00804	GYM006	l	over	7b	7	2023-09-19 00:00:00+02	Camille Michel
RT00805	GYM004	b	v	8a	8	2024-02-24 00:00:00+01	Alice Martin
RT00806	GYM003	b	sb	5a	5	2023-08-29 00:00:00+02	Nina Renard
RT00807	GYM003	l	v	8a	8	2023-12-21 00:00:00+01	Sacha Fabre
RT00808	GYM006	tr	v	7b	7	2024-08-11 00:00:00+02	Gabriel Lefebvre
RT00809	GYM002	tr	v	5b	5	2023-06-29 00:00:00+02	Nina Renard
RT00810	GYM005	l	v	7a	7	2023-03-07 00:00:00+01	Léa Robert
RT00811	GYM005	b	v	7a	7	2023-12-14 00:00:00+01	Louis Girard
RT00812	GYM005	b	over	6b	6	2023-06-20 00:00:00+02	Maël Perrin
RT00813	GYM004	tr	over	6a	6	2024-04-18 00:00:00+02	Louna Garnier
RT00814	GYM005	tr	over	5a	5	2024-06-17 00:00:00+02	Tom Barbier
RT00815	GYM003	l	sb	8a	8	2024-01-02 00:00:00+01	Inès Fournier
RT00816	GYM004	tr	v	5a	5	2023-04-17 00:00:00+02	Alice Martin
RT00817	GYM001	l	over	6b	6	2024-03-14 00:00:00+01	Lucas Bernard
RT00818	GYM005	tr	sb	6b	6	2023-08-15 00:00:00+02	Élise Rolland
RT00819	GYM005	tr	over	8a	8	2024-03-19 00:00:00+01	Raphaël Rousseau
RT00820	GYM001	tr	over	6a	6	2024-03-17 00:00:00+01	Hugo Richard
RT00821	GYM005	b	v	8a	8	2024-01-31 00:00:00+01	Hugo Richard
RT00822	GYM001	b	sb	8a	8	2024-12-28 00:00:00+01	Lucas Bernard
RT00823	GYM004	b	v	7b	7	2024-08-03 00:00:00+02	Raphaël Rousseau
RT00824	GYM003	tr	v	6a	6	2023-03-25 00:00:00+01	Sacha Fabre
RT00825	GYM001	l	over	7a	7	2024-09-06 00:00:00+02	Zoé Lemoine
RT00826	GYM002	l	v	7b	7	2024-07-04 00:00:00+02	Emma Dubois
RT00827	GYM001	l	sb	5b	5	2023-01-13 00:00:00+01	Juliette Gauthier
RT00828	GYM005	l	v	6a	6	2024-11-23 00:00:00+01	Gabriel Lefebvre
RT00829	GYM004	b	v	6b	6	2024-05-07 00:00:00+02	Jules Chevalier
RT00830	GYM006	b	v	7b	7	2023-09-25 00:00:00+02	Tom Barbier
RT00831	GYM004	tr	over	6a	6	2024-06-08 00:00:00+02	Nathan Simon
RT00832	GYM006	tr	sb	5a	5	2023-04-30 00:00:00+02	Camille Michel
RT00833	GYM001	l	over	8a	8	2023-12-19 00:00:00+01	Jules Chevalier
RT00834	GYM003	b	over	5b	5	2023-02-26 00:00:00+01	Camille Michel
RT00835	GYM002	l	over	7a	7	2023-02-09 00:00:00+01	Arthur Moulin
RT00836	GYM004	tr	over	8a	8	2023-12-02 00:00:00+01	Sacha Fabre
RT00837	GYM005	tr	over	5a	5	2024-10-01 00:00:00+02	Manon Laurent
RT00838	GYM006	l	sb	5a	5	2023-06-22 00:00:00+02	Liam Moreau
RT00839	GYM005	tr	v	5b	5	2024-06-30 00:00:00+02	Gabriel Lefebvre
RT00840	GYM003	l	over	7a	7	2023-09-16 00:00:00+02	Théo Adam
RT00841	GYM006	b	over	6b	6	2024-05-31 00:00:00+02	Sacha Fabre
RT00842	GYM004	l	sb	7b	7	2024-12-30 00:00:00+01	Camille Michel
RT00843	GYM001	b	sb	7a	7	2024-06-06 00:00:00+02	Nina Renard
RT00844	GYM005	b	v	6a	6	2023-04-27 00:00:00+02	Inès Fournier
RT00845	GYM003	tr	sb	5a	5	2023-07-03 00:00:00+02	Élise Rolland
RT00846	GYM004	tr	v	6a	6	2023-04-26 00:00:00+02	Noah Petit
RT00847	GYM004	tr	over	6b	6	2023-06-11 00:00:00+02	Juliette Gauthier
RT00848	GYM004	l	over	6a	6	2024-08-01 00:00:00+02	Mila Caron
RT00849	GYM004	l	v	7a	7	2024-12-12 00:00:00+01	Noah Petit
RT00850	GYM006	tr	sb	6a	6	2024-06-26 00:00:00+02	Emma Dubois
RT00851	GYM004	l	v	6b	6	2024-08-09 00:00:00+02	Jules Chevalier
RT00852	GYM005	tr	sb	6b	6	2023-08-25 00:00:00+02	Tom Barbier
RT00853	GYM003	l	over	6b	6	2023-03-07 00:00:00+01	Théo Adam
RT00854	GYM006	b	sb	7a	7	2023-03-11 00:00:00+01	Tom Barbier
RT00855	GYM004	b	v	6b	6	2024-03-22 00:00:00+01	Gabriel Lefebvre
RT00856	GYM002	tr	v	5a	5	2024-02-20 00:00:00+01	Anna Marchand
RT00857	GYM002	l	over	8a	8	2024-06-15 00:00:00+02	Raphaël Rousseau
RT00858	GYM003	l	sb	6b	6	2024-03-16 00:00:00+01	Ethan Picard
RT00859	GYM001	b	sb	6a	6	2024-04-08 00:00:00+02	Nathan Simon
RT00860	GYM001	b	sb	7b	7	2024-01-31 00:00:00+01	Maël Perrin
RT00861	GYM006	tr	over	6a	6	2024-12-11 00:00:00+01	Léa Robert
RT00862	GYM006	b	sb	7b	7	2024-07-04 00:00:00+02	Manon Laurent
RT00863	GYM006	tr	v	6a	6	2024-10-18 00:00:00+02	Emma Dubois
RT00864	GYM001	b	sb	7a	7	2024-07-10 00:00:00+02	Gabriel Lefebvre
RT00865	GYM002	b	over	6a	6	2024-01-30 00:00:00+01	Chloé Durand
RT00866	GYM001	l	sb	7a	7	2023-11-22 00:00:00+01	Jules Chevalier
RT00867	GYM005	b	sb	7a	7	2023-04-01 00:00:00+02	Raphaël Rousseau
RT00868	GYM004	b	v	6b	6	2023-03-11 00:00:00+01	Louis Girard
RT00869	GYM006	tr	sb	5a	5	2023-06-15 00:00:00+02	Gabriel Lefebvre
RT00870	GYM002	b	v	7b	7	2024-10-03 00:00:00+02	Inès Fournier
RT00871	GYM003	tr	v	6b	6	2023-08-02 00:00:00+02	Léa Robert
RT00872	GYM003	b	over	6b	6	2024-08-23 00:00:00+02	Élise Rolland
RT00873	GYM004	b	v	8a	8	2023-12-01 00:00:00+01	Hugo Richard
RT00874	GYM002	tr	v	7a	7	2024-01-04 00:00:00+01	Camille Michel
RT00875	GYM001	l	over	7a	7	2024-08-06 00:00:00+02	Anna Marchand
RT00876	GYM001	tr	v	7b	7	2024-11-07 00:00:00+01	Noah Petit
RT00877	GYM005	tr	over	6a	6	2023-02-18 00:00:00+01	Élise Rolland
RT00878	GYM005	tr	sb	6a	6	2023-02-21 00:00:00+01	Zoé Lemoine
RT00879	GYM001	l	over	6b	6	2023-10-16 00:00:00+02	Théo Adam
RT00880	GYM003	b	v	5b	5	2024-09-17 00:00:00+02	Ethan Picard
RT00881	GYM006	tr	over	5b	5	2023-08-27 00:00:00+02	Alice Martin
RT00882	GYM003	tr	v	6a	6	2023-05-13 00:00:00+02	Alice Martin
RT00883	GYM005	l	sb	5b	5	2023-06-15 00:00:00+02	Nina Renard
RT00884	GYM004	tr	over	8a	8	2024-01-09 00:00:00+01	Noah Petit
RT00885	GYM001	b	sb	6a	6	2024-01-08 00:00:00+01	Inès Fournier
RT00886	GYM005	l	v	7a	7	2024-04-22 00:00:00+02	Maël Perrin
RT00887	GYM005	b	v	6b	6	2024-04-23 00:00:00+02	Sarah Lopez
RT00888	GYM006	b	sb	5a	5	2024-10-11 00:00:00+02	Camille Michel
RT00889	GYM001	l	over	6b	6	2024-08-13 00:00:00+02	Nathan Simon
RT00890	GYM006	tr	over	6a	6	2024-11-12 00:00:00+01	Gabriel Lefebvre
RT00891	GYM001	b	v	8a	8	2024-09-26 00:00:00+02	Maël Perrin
RT00892	GYM006	b	sb	6a	6	2024-11-18 00:00:00+01	Lucas Bernard
RT00893	GYM003	b	sb	6b	6	2023-10-27 00:00:00+02	Camille Michel
RT00894	GYM004	b	over	8a	8	2023-03-23 00:00:00+01	Gabriel Lefebvre
RT00895	GYM004	l	over	8a	8	2023-03-28 00:00:00+02	Chloé Durand
RT00896	GYM001	l	over	8a	8	2023-08-13 00:00:00+02	Jules Chevalier
RT00897	GYM002	b	sb	7b	7	2023-01-16 00:00:00+01	Ethan Picard
RT00898	GYM005	tr	over	6a	6	2023-12-24 00:00:00+01	Anna Marchand
RT00899	GYM005	b	over	5b	5	2023-06-12 00:00:00+02	Ethan Picard
RT00900	GYM001	tr	v	5b	5	2024-09-01 00:00:00+02	Anna Marchand
RT00901	GYM006	b	over	6a	6	2024-10-29 00:00:00+01	Hugo Richard
RT00902	GYM002	tr	over	6a	6	2024-05-28 00:00:00+02	Lucas Bernard
RT00903	GYM003	b	sb	7b	7	2023-12-16 00:00:00+01	Élise Rolland
RT00904	GYM006	tr	sb	5b	5	2024-11-11 00:00:00+01	Chloé Durand
RT00905	GYM006	b	v	6a	6	2024-04-08 00:00:00+02	Nina Renard
RT00906	GYM001	b	over	6a	6	2024-01-10 00:00:00+01	Raphaël Rousseau
RT00907	GYM001	tr	v	7b	7	2023-04-02 00:00:00+02	Élise Rolland
RT00908	GYM005	l	sb	7b	7	2023-06-30 00:00:00+02	Emma Dubois
RT00909	GYM001	tr	v	6b	6	2023-10-28 00:00:00+02	Inès Fournier
RT00910	GYM001	l	sb	7b	7	2024-10-21 00:00:00+02	Raphaël Rousseau
RT00911	GYM001	b	v	5a	5	2023-07-08 00:00:00+02	Inès Fournier
RT00912	GYM005	tr	v	5b	5	2023-11-10 00:00:00+01	Hugo Richard
RT00913	GYM003	tr	over	6b	6	2024-05-07 00:00:00+02	Nathan Simon
RT00914	GYM003	tr	v	5a	5	2023-05-08 00:00:00+02	Tom Barbier
RT00915	GYM001	l	over	6a	6	2024-06-02 00:00:00+02	Noah Petit
RT00916	GYM005	l	over	6a	6	2024-03-01 00:00:00+01	Louna Garnier
RT00917	GYM003	b	over	6b	6	2024-07-12 00:00:00+02	Noah Petit
RT00918	GYM006	l	over	7b	7	2024-07-18 00:00:00+02	Zoé Lemoine
RT00919	GYM003	l	v	8a	8	2023-07-06 00:00:00+02	Zoé Lemoine
RT00920	GYM003	b	sb	8a	8	2024-07-03 00:00:00+02	Sacha Fabre
RT00921	GYM005	tr	sb	6a	6	2024-03-28 00:00:00+01	Tom Barbier
RT00922	GYM006	tr	sb	8a	8	2024-04-15 00:00:00+02	Louna Garnier
RT00923	GYM005	b	v	7a	7	2024-07-18 00:00:00+02	Juliette Gauthier
RT00924	GYM001	tr	over	6b	6	2023-08-12 00:00:00+02	Théo Adam
RT00925	GYM004	l	sb	5a	5	2023-06-03 00:00:00+02	Lucas Bernard
RT00926	GYM003	b	v	6b	6	2024-07-13 00:00:00+02	Nina Renard
RT00927	GYM004	b	over	5b	5	2023-12-17 00:00:00+01	Nathan Simon
RT00928	GYM005	b	sb	7b	7	2023-05-27 00:00:00+02	Louis Girard
RT00929	GYM005	tr	over	7b	7	2024-07-29 00:00:00+02	Chloé Durand
RT00930	GYM005	b	sb	6b	6	2023-12-15 00:00:00+01	Tom Barbier
RT00931	GYM004	b	sb	6a	6	2023-07-01 00:00:00+02	Liam Moreau
RT00932	GYM005	b	sb	6a	6	2024-09-28 00:00:00+02	Nina Renard
RT00933	GYM001	tr	over	7a	7	2023-06-28 00:00:00+02	Lucas Bernard
RT00934	GYM005	l	v	7a	7	2023-02-08 00:00:00+01	Juliette Gauthier
RT00935	GYM002	b	over	7b	7	2023-01-03 00:00:00+01	Manon Laurent
RT00936	GYM004	l	sb	7a	7	2023-03-05 00:00:00+01	Gabriel Lefebvre
RT00937	GYM002	tr	over	5a	5	2023-01-29 00:00:00+01	Gabriel Lefebvre
RT00938	GYM005	tr	v	7a	7	2024-01-07 00:00:00+01	Sacha Fabre
RT00939	GYM001	tr	over	5a	5	2024-06-06 00:00:00+02	Noah Petit
RT00940	GYM003	tr	v	7a	7	2023-04-07 00:00:00+02	Anna Marchand
RT00941	GYM006	l	v	7b	7	2024-03-17 00:00:00+01	Manon Laurent
RT00942	GYM006	b	over	7b	7	2023-07-22 00:00:00+02	Ethan Picard
RT00943	GYM005	tr	sb	5a	5	2024-02-15 00:00:00+01	Sacha Fabre
RT00944	GYM001	tr	v	6b	6	2023-01-21 00:00:00+01	Sarah Lopez
RT00945	GYM004	l	over	7b	7	2024-07-04 00:00:00+02	Zoé Lemoine
RT00946	GYM002	l	v	6b	6	2023-04-12 00:00:00+02	Manon Laurent
RT00947	GYM002	tr	sb	6a	6	2023-02-15 00:00:00+01	Louis Girard
RT00948	GYM002	b	over	5a	5	2023-03-07 00:00:00+01	Mila Caron
RT00949	GYM004	b	over	8a	8	2024-08-25 00:00:00+02	Arthur Moulin
RT00950	GYM006	tr	over	7b	7	2023-06-13 00:00:00+02	Liam Moreau
RT00951	GYM001	l	sb	5b	5	2023-04-21 00:00:00+02	Sarah Lopez
RT00952	GYM004	tr	v	6a	6	2023-12-04 00:00:00+01	Anna Marchand
RT00953	GYM002	tr	over	6b	6	2023-05-03 00:00:00+02	Sarah Lopez
RT00954	GYM005	l	v	7b	7	2024-12-05 00:00:00+01	Liam Moreau
RT00955	GYM003	tr	v	5a	5	2024-03-22 00:00:00+01	Inès Fournier
RT00956	GYM004	tr	sb	8a	8	2024-09-02 00:00:00+02	Raphaël Rousseau
RT00957	GYM004	tr	over	7a	7	2023-10-18 00:00:00+02	Chloé Durand
RT00958	GYM001	l	v	8a	8	2024-11-01 00:00:00+01	Raphaël Rousseau
RT00959	GYM001	b	over	5b	5	2024-02-16 00:00:00+01	Jules Chevalier
RT00960	GYM004	b	over	6b	6	2024-09-06 00:00:00+02	Zoé Lemoine
RT00961	GYM002	l	sb	6a	6	2023-10-08 00:00:00+02	Raphaël Rousseau
RT00962	GYM003	b	over	8a	8	2023-02-12 00:00:00+01	Manon Laurent
RT00963	GYM001	tr	over	5a	5	2024-04-30 00:00:00+02	Juliette Gauthier
RT00964	GYM002	b	v	5b	5	2024-08-18 00:00:00+02	Raphaël Rousseau
RT00965	GYM005	tr	sb	5a	5	2024-12-03 00:00:00+01	Sacha Fabre
RT00966	GYM001	b	over	7b	7	2023-02-20 00:00:00+01	Théo Adam
RT00967	GYM002	l	v	7a	7	2023-07-29 00:00:00+02	Tom Barbier
RT00968	GYM002	b	sb	6a	6	2023-05-06 00:00:00+02	Noah Petit
RT00969	GYM003	b	sb	5a	5	2024-05-06 00:00:00+02	Manon Laurent
RT00970	GYM003	b	v	6b	6	2024-05-23 00:00:00+02	Anna Marchand
RT00971	GYM005	l	v	7b	7	2024-08-03 00:00:00+02	Juliette Gauthier
RT00972	GYM002	b	v	7b	7	2023-09-15 00:00:00+02	Maël Perrin
RT00973	GYM006	l	v	6a	6	2023-07-07 00:00:00+02	Alice Martin
RT00974	GYM002	tr	v	7b	7	2023-08-18 00:00:00+02	Arthur Moulin
RT00975	GYM003	b	over	6b	6	2023-07-08 00:00:00+02	Gabriel Lefebvre
RT00976	GYM006	l	over	5a	5	2024-02-19 00:00:00+01	Anna Marchand
RT00977	GYM001	l	sb	6a	6	2023-01-10 00:00:00+01	Léa Robert
RT00978	GYM001	b	over	7b	7	2023-04-24 00:00:00+02	Liam Moreau
RT00979	GYM004	tr	over	7b	7	2023-03-17 00:00:00+01	Lucas Bernard
RT00980	GYM003	l	over	6b	6	2024-11-06 00:00:00+01	Tom Barbier
RT00981	GYM004	b	v	7a	7	2024-05-16 00:00:00+02	Jules Chevalier
RT00982	GYM006	tr	sb	7a	7	2023-03-26 00:00:00+01	Chloé Durand
RT00983	GYM003	l	sb	8a	8	2023-02-18 00:00:00+01	Maël Perrin
RT00984	GYM005	l	sb	7b	7	2024-05-09 00:00:00+02	Nathan Simon
RT00985	GYM002	tr	sb	5a	5	2024-11-19 00:00:00+01	Raphaël Rousseau
RT00986	GYM005	tr	over	6a	6	2024-01-22 00:00:00+01	Nina Renard
RT00987	GYM006	b	over	7b	7	2024-01-24 00:00:00+01	Noah Petit
RT00988	GYM003	b	v	5b	5	2023-08-06 00:00:00+02	Raphaël Rousseau
RT00989	GYM006	l	sb	6a	6	2024-12-01 00:00:00+01	Léa Robert
RT00990	GYM002	tr	over	8a	8	2023-12-12 00:00:00+01	Zoé Lemoine
RT00991	GYM001	tr	over	7a	7	2023-08-18 00:00:00+02	Lucas Bernard
RT00992	GYM001	tr	v	7b	7	2023-09-12 00:00:00+02	Léa Robert
RT00993	GYM006	l	v	6b	6	2023-08-24 00:00:00+02	Gabriel Lefebvre
RT00994	GYM004	tr	v	5b	5	2023-01-26 00:00:00+01	Sarah Lopez
RT00995	GYM003	tr	over	7b	7	2024-08-06 00:00:00+02	Manon Laurent
RT00996	GYM003	l	over	8a	8	2023-09-18 00:00:00+02	Gabriel Lefebvre
RT00997	GYM001	b	v	5a	5	2023-09-28 00:00:00+02	Louis Girard
RT00998	GYM005	b	sb	5b	5	2023-05-03 00:00:00+02	Louna Garnier
RT00999	GYM002	l	v	8a	8	2024-10-17 00:00:00+02	Anna Marchand
RT01000	GYM005	tr	v	7b	7	2023-09-14 00:00:00+02	Sarah Lopez
\.


--
-- TOC entry 4957 (class 0 OID 16415)
-- Dependencies: 222
-- Data for Name: dim_time; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_time (date, cal_qrter, cal_yr, cal_sem) FROM stdin;
2023-01-01	1	2023	1
2023-01-02	1	2023	1
2023-01-03	1	2023	1
2023-01-04	1	2023	1
2023-01-05	1	2023	1
2023-01-06	1	2023	1
2023-01-07	1	2023	1
2023-01-08	1	2023	1
2023-01-09	1	2023	1
2023-01-10	1	2023	1
2023-01-11	1	2023	1
2023-01-12	1	2023	1
2023-01-13	1	2023	1
2023-01-14	1	2023	1
2023-01-15	1	2023	1
2023-01-16	1	2023	1
2023-01-17	1	2023	1
2023-01-18	1	2023	1
2023-01-19	1	2023	1
2023-01-20	1	2023	1
2023-01-21	1	2023	1
2023-01-22	1	2023	1
2023-01-23	1	2023	1
2023-01-24	1	2023	1
2023-01-25	1	2023	1
2023-01-26	1	2023	1
2023-01-27	1	2023	1
2023-01-28	1	2023	1
2023-01-29	1	2023	1
2023-01-30	1	2023	1
2023-01-31	1	2023	1
2023-02-01	1	2023	1
2023-02-02	1	2023	1
2023-02-03	1	2023	1
2023-02-04	1	2023	1
2023-02-05	1	2023	1
2023-02-06	1	2023	1
2023-02-07	1	2023	1
2023-02-08	1	2023	1
2023-02-09	1	2023	1
2023-02-10	1	2023	1
2023-02-11	1	2023	1
2023-02-12	1	2023	1
2023-02-13	1	2023	1
2023-02-14	1	2023	1
2023-02-15	1	2023	1
2023-02-16	1	2023	1
2023-02-17	1	2023	1
2023-02-18	1	2023	1
2023-02-19	1	2023	1
2023-02-20	1	2023	1
2023-02-21	1	2023	1
2023-02-22	1	2023	1
2023-02-23	1	2023	1
2023-02-24	1	2023	1
2023-02-25	1	2023	1
2023-02-26	1	2023	1
2023-02-27	1	2023	1
2023-02-28	1	2023	1
2023-03-01	1	2023	1
2023-03-02	1	2023	1
2023-03-03	1	2023	1
2023-03-04	1	2023	1
2023-03-05	1	2023	1
2023-03-06	1	2023	1
2023-03-07	1	2023	1
2023-03-08	1	2023	1
2023-03-09	1	2023	1
2023-03-10	1	2023	1
2023-03-11	1	2023	1
2023-03-12	1	2023	1
2023-03-13	1	2023	1
2023-03-14	1	2023	1
2023-03-15	1	2023	1
2023-03-16	1	2023	1
2023-03-17	1	2023	1
2023-03-18	1	2023	1
2023-03-19	1	2023	1
2023-03-20	1	2023	1
2023-03-21	1	2023	1
2023-03-22	1	2023	1
2023-03-23	1	2023	1
2023-03-24	1	2023	1
2023-03-25	1	2023	1
2023-03-26	1	2023	1
2023-03-27	1	2023	1
2023-03-28	1	2023	1
2023-03-29	1	2023	1
2023-03-30	1	2023	1
2023-03-31	1	2023	1
2023-04-01	2	2023	1
2023-04-02	2	2023	1
2023-04-03	2	2023	1
2023-04-04	2	2023	1
2023-04-05	2	2023	1
2023-04-06	2	2023	1
2023-04-07	2	2023	1
2023-04-08	2	2023	1
2023-04-09	2	2023	1
2023-04-10	2	2023	1
2023-04-11	2	2023	1
2023-04-12	2	2023	1
2023-04-13	2	2023	1
2023-04-14	2	2023	1
2023-04-15	2	2023	1
2023-04-16	2	2023	1
2023-04-17	2	2023	1
2023-04-18	2	2023	1
2023-04-19	2	2023	1
2023-04-20	2	2023	1
2023-04-21	2	2023	1
2023-04-22	2	2023	1
2023-04-23	2	2023	1
2023-04-24	2	2023	1
2023-04-25	2	2023	1
2023-04-26	2	2023	1
2023-04-27	2	2023	1
2023-04-28	2	2023	1
2023-04-29	2	2023	1
2023-04-30	2	2023	1
2023-05-01	2	2023	1
2023-05-02	2	2023	1
2023-05-03	2	2023	1
2023-05-04	2	2023	1
2023-05-05	2	2023	1
2023-05-06	2	2023	1
2023-05-07	2	2023	1
2023-05-08	2	2023	1
2023-05-09	2	2023	1
2023-05-10	2	2023	1
2023-05-11	2	2023	1
2023-05-12	2	2023	1
2023-05-13	2	2023	1
2023-05-14	2	2023	1
2023-05-15	2	2023	1
2023-05-16	2	2023	1
2023-05-17	2	2023	1
2023-05-18	2	2023	1
2023-05-19	2	2023	1
2023-05-20	2	2023	1
2023-05-21	2	2023	1
2023-05-22	2	2023	1
2023-05-23	2	2023	1
2023-05-24	2	2023	1
2023-05-25	2	2023	1
2023-05-26	2	2023	1
2023-05-27	2	2023	1
2023-05-28	2	2023	1
2023-05-29	2	2023	1
2023-05-30	2	2023	1
2023-05-31	2	2023	1
2023-06-01	2	2023	1
2023-06-02	2	2023	1
2023-06-03	2	2023	1
2023-06-04	2	2023	1
2023-06-05	2	2023	1
2023-06-06	2	2023	1
2023-06-07	2	2023	1
2023-06-08	2	2023	1
2023-06-09	2	2023	1
2023-06-10	2	2023	1
2023-06-11	2	2023	1
2023-06-12	2	2023	1
2023-06-13	2	2023	1
2023-06-14	2	2023	1
2023-06-15	2	2023	1
2023-06-16	2	2023	1
2023-06-17	2	2023	1
2023-06-18	2	2023	1
2023-06-19	2	2023	1
2023-06-20	2	2023	1
2023-06-21	2	2023	1
2023-06-22	2	2023	1
2023-06-23	2	2023	1
2023-06-24	2	2023	1
2023-06-25	2	2023	1
2023-06-26	2	2023	1
2023-06-27	2	2023	1
2023-06-28	2	2023	1
2023-06-29	2	2023	1
2023-06-30	2	2023	1
2023-07-01	3	2023	2
2023-07-02	3	2023	2
2023-07-03	3	2023	2
2023-07-04	3	2023	2
2023-07-05	3	2023	2
2023-07-06	3	2023	2
2023-07-07	3	2023	2
2023-07-08	3	2023	2
2023-07-09	3	2023	2
2023-07-10	3	2023	2
2023-07-11	3	2023	2
2023-07-12	3	2023	2
2023-07-13	3	2023	2
2023-07-14	3	2023	2
2023-07-15	3	2023	2
2023-07-16	3	2023	2
2023-07-17	3	2023	2
2023-07-18	3	2023	2
2023-07-19	3	2023	2
2023-07-20	3	2023	2
2023-07-21	3	2023	2
2023-07-22	3	2023	2
2023-07-23	3	2023	2
2023-07-24	3	2023	2
2023-07-25	3	2023	2
2023-07-26	3	2023	2
2023-07-27	3	2023	2
2023-07-28	3	2023	2
2023-07-29	3	2023	2
2023-07-30	3	2023	2
2023-07-31	3	2023	2
2023-08-01	3	2023	2
2023-08-02	3	2023	2
2023-08-03	3	2023	2
2023-08-04	3	2023	2
2023-08-05	3	2023	2
2023-08-06	3	2023	2
2023-08-07	3	2023	2
2023-08-08	3	2023	2
2023-08-09	3	2023	2
2023-08-10	3	2023	2
2023-08-11	3	2023	2
2023-08-12	3	2023	2
2023-08-13	3	2023	2
2023-08-14	3	2023	2
2023-08-15	3	2023	2
2023-08-16	3	2023	2
2023-08-17	3	2023	2
2023-08-18	3	2023	2
2023-08-19	3	2023	2
2023-08-20	3	2023	2
2023-08-21	3	2023	2
2023-08-22	3	2023	2
2023-08-23	3	2023	2
2023-08-24	3	2023	2
2023-08-25	3	2023	2
2023-08-26	3	2023	2
2023-08-27	3	2023	2
2023-08-28	3	2023	2
2023-08-29	3	2023	2
2023-08-30	3	2023	2
2023-08-31	3	2023	2
2023-09-01	3	2023	2
2023-09-02	3	2023	2
2023-09-03	3	2023	2
2023-09-04	3	2023	2
2023-09-05	3	2023	2
2023-09-06	3	2023	2
2023-09-07	3	2023	2
2023-09-08	3	2023	2
2023-09-09	3	2023	2
2023-09-10	3	2023	2
2023-09-11	3	2023	2
2023-09-12	3	2023	2
2023-09-13	3	2023	2
2023-09-14	3	2023	2
2023-09-15	3	2023	2
2023-09-16	3	2023	2
2023-09-17	3	2023	2
2023-09-18	3	2023	2
2023-09-19	3	2023	2
2023-09-20	3	2023	2
2023-09-21	3	2023	2
2023-09-22	3	2023	2
2023-09-23	3	2023	2
2023-09-24	3	2023	2
2023-09-25	3	2023	2
2023-09-26	3	2023	2
2023-09-27	3	2023	2
2023-09-28	3	2023	2
2023-09-29	3	2023	2
2023-09-30	3	2023	2
2023-10-01	4	2023	2
2023-10-02	4	2023	2
2023-10-03	4	2023	2
2023-10-04	4	2023	2
2023-10-05	4	2023	2
2023-10-06	4	2023	2
2023-10-07	4	2023	2
2023-10-08	4	2023	2
2023-10-09	4	2023	2
2023-10-10	4	2023	2
2023-10-11	4	2023	2
2023-10-12	4	2023	2
2023-10-13	4	2023	2
2023-10-14	4	2023	2
2023-10-15	4	2023	2
2023-10-16	4	2023	2
2023-10-17	4	2023	2
2023-10-18	4	2023	2
2023-10-19	4	2023	2
2023-10-20	4	2023	2
2023-10-21	4	2023	2
2023-10-22	4	2023	2
2023-10-23	4	2023	2
2023-10-24	4	2023	2
2023-10-25	4	2023	2
2023-10-26	4	2023	2
2023-10-27	4	2023	2
2023-10-28	4	2023	2
2023-10-29	4	2023	2
2023-10-30	4	2023	2
2023-10-31	4	2023	2
2023-11-01	4	2023	2
2023-11-02	4	2023	2
2023-11-03	4	2023	2
2023-11-04	4	2023	2
2023-11-05	4	2023	2
2023-11-06	4	2023	2
2023-11-07	4	2023	2
2023-11-08	4	2023	2
2023-11-09	4	2023	2
2023-11-10	4	2023	2
2023-11-11	4	2023	2
2023-11-12	4	2023	2
2023-11-13	4	2023	2
2023-11-14	4	2023	2
2023-11-15	4	2023	2
2023-11-16	4	2023	2
2023-11-17	4	2023	2
2023-11-18	4	2023	2
2023-11-19	4	2023	2
2023-11-20	4	2023	2
2023-11-21	4	2023	2
2023-11-22	4	2023	2
2023-11-23	4	2023	2
2023-11-24	4	2023	2
2023-11-25	4	2023	2
2023-11-26	4	2023	2
2023-11-27	4	2023	2
2023-11-28	4	2023	2
2023-11-29	4	2023	2
2023-11-30	4	2023	2
2023-12-01	4	2023	2
2023-12-02	4	2023	2
2023-12-03	4	2023	2
2023-12-04	4	2023	2
2023-12-05	4	2023	2
2023-12-06	4	2023	2
2023-12-07	4	2023	2
2023-12-08	4	2023	2
2023-12-09	4	2023	2
2023-12-10	4	2023	2
2023-12-11	4	2023	2
2023-12-12	4	2023	2
2023-12-13	4	2023	2
2023-12-14	4	2023	2
2023-12-15	4	2023	2
2023-12-16	4	2023	2
2023-12-17	4	2023	2
2023-12-18	4	2023	2
2023-12-19	4	2023	2
2023-12-20	4	2023	2
2023-12-21	4	2023	2
2023-12-22	4	2023	2
2023-12-23	4	2023	2
2023-12-24	4	2023	2
2023-12-25	4	2023	2
2023-12-26	4	2023	2
2023-12-27	4	2023	2
2023-12-28	4	2023	2
2023-12-29	4	2023	2
2023-12-30	4	2023	2
2023-12-31	4	2023	2
2024-01-01	1	2024	1
2024-01-02	1	2024	1
2024-01-03	1	2024	1
2024-01-04	1	2024	1
2024-01-05	1	2024	1
2024-01-06	1	2024	1
2024-01-07	1	2024	1
2024-01-08	1	2024	1
2024-01-09	1	2024	1
2024-01-10	1	2024	1
2024-01-11	1	2024	1
2024-01-12	1	2024	1
2024-01-13	1	2024	1
2024-01-14	1	2024	1
2024-01-15	1	2024	1
2024-01-16	1	2024	1
2024-01-17	1	2024	1
2024-01-18	1	2024	1
2024-01-19	1	2024	1
2024-01-20	1	2024	1
2024-01-21	1	2024	1
2024-01-22	1	2024	1
2024-01-23	1	2024	1
2024-01-24	1	2024	1
2024-01-25	1	2024	1
2024-01-26	1	2024	1
2024-01-27	1	2024	1
2024-01-28	1	2024	1
2024-01-29	1	2024	1
2024-01-30	1	2024	1
2024-01-31	1	2024	1
2024-02-01	1	2024	1
2024-02-02	1	2024	1
2024-02-03	1	2024	1
2024-02-04	1	2024	1
2024-02-05	1	2024	1
2024-02-06	1	2024	1
2024-02-07	1	2024	1
2024-02-08	1	2024	1
2024-02-09	1	2024	1
2024-02-10	1	2024	1
2024-02-11	1	2024	1
2024-02-12	1	2024	1
2024-02-13	1	2024	1
2024-02-14	1	2024	1
2024-02-15	1	2024	1
2024-02-16	1	2024	1
2024-02-17	1	2024	1
2024-02-18	1	2024	1
2024-02-19	1	2024	1
2024-02-20	1	2024	1
2024-02-21	1	2024	1
2024-02-22	1	2024	1
2024-02-23	1	2024	1
2024-02-24	1	2024	1
2024-02-25	1	2024	1
2024-02-26	1	2024	1
2024-02-27	1	2024	1
2024-02-28	1	2024	1
2024-02-29	1	2024	1
2024-03-01	1	2024	1
2024-03-02	1	2024	1
2024-03-03	1	2024	1
2024-03-04	1	2024	1
2024-03-05	1	2024	1
2024-03-06	1	2024	1
2024-03-07	1	2024	1
2024-03-08	1	2024	1
2024-03-09	1	2024	1
2024-03-10	1	2024	1
2024-03-11	1	2024	1
2024-03-12	1	2024	1
2024-03-13	1	2024	1
2024-03-14	1	2024	1
2024-03-15	1	2024	1
2024-03-16	1	2024	1
2024-03-17	1	2024	1
2024-03-18	1	2024	1
2024-03-19	1	2024	1
2024-03-20	1	2024	1
2024-03-21	1	2024	1
2024-03-22	1	2024	1
2024-03-23	1	2024	1
2024-03-24	1	2024	1
2024-03-25	1	2024	1
2024-03-26	1	2024	1
2024-03-27	1	2024	1
2024-03-28	1	2024	1
2024-03-29	1	2024	1
2024-03-30	1	2024	1
2024-03-31	1	2024	1
2024-04-01	2	2024	1
2024-04-02	2	2024	1
2024-04-03	2	2024	1
2024-04-04	2	2024	1
2024-04-05	2	2024	1
2024-04-06	2	2024	1
2024-04-07	2	2024	1
2024-04-08	2	2024	1
2024-04-09	2	2024	1
2024-04-10	2	2024	1
2024-04-11	2	2024	1
2024-04-12	2	2024	1
2024-04-13	2	2024	1
2024-04-14	2	2024	1
2024-04-15	2	2024	1
2024-04-16	2	2024	1
2024-04-17	2	2024	1
2024-04-18	2	2024	1
2024-04-19	2	2024	1
2024-04-20	2	2024	1
2024-04-21	2	2024	1
2024-04-22	2	2024	1
2024-04-23	2	2024	1
2024-04-24	2	2024	1
2024-04-25	2	2024	1
2024-04-26	2	2024	1
2024-04-27	2	2024	1
2024-04-28	2	2024	1
2024-04-29	2	2024	1
2024-04-30	2	2024	1
2024-05-01	2	2024	1
2024-05-02	2	2024	1
2024-05-03	2	2024	1
2024-05-04	2	2024	1
2024-05-05	2	2024	1
2024-05-06	2	2024	1
2024-05-07	2	2024	1
2024-05-08	2	2024	1
2024-05-09	2	2024	1
2024-05-10	2	2024	1
2024-05-11	2	2024	1
2024-05-12	2	2024	1
2024-05-13	2	2024	1
2024-05-14	2	2024	1
2024-05-15	2	2024	1
2024-05-16	2	2024	1
2024-05-17	2	2024	1
2024-05-18	2	2024	1
2024-05-19	2	2024	1
2024-05-20	2	2024	1
2024-05-21	2	2024	1
2024-05-22	2	2024	1
2024-05-23	2	2024	1
2024-05-24	2	2024	1
2024-05-25	2	2024	1
2024-05-26	2	2024	1
2024-05-27	2	2024	1
2024-05-28	2	2024	1
2024-05-29	2	2024	1
2024-05-30	2	2024	1
2024-05-31	2	2024	1
2024-06-01	2	2024	1
2024-06-02	2	2024	1
2024-06-03	2	2024	1
2024-06-04	2	2024	1
2024-06-05	2	2024	1
2024-06-06	2	2024	1
2024-06-07	2	2024	1
2024-06-08	2	2024	1
2024-06-09	2	2024	1
2024-06-10	2	2024	1
2024-06-11	2	2024	1
2024-06-12	2	2024	1
2024-06-13	2	2024	1
2024-06-14	2	2024	1
2024-06-15	2	2024	1
2024-06-16	2	2024	1
2024-06-17	2	2024	1
2024-06-18	2	2024	1
2024-06-19	2	2024	1
2024-06-20	2	2024	1
2024-06-21	2	2024	1
2024-06-22	2	2024	1
2024-06-23	2	2024	1
2024-06-24	2	2024	1
2024-06-25	2	2024	1
2024-06-26	2	2024	1
2024-06-27	2	2024	1
2024-06-28	2	2024	1
2024-06-29	2	2024	1
2024-06-30	2	2024	1
2024-07-01	3	2024	2
2024-07-02	3	2024	2
2024-07-03	3	2024	2
2024-07-04	3	2024	2
2024-07-05	3	2024	2
2024-07-06	3	2024	2
2024-07-07	3	2024	2
2024-07-08	3	2024	2
2024-07-09	3	2024	2
2024-07-10	3	2024	2
2024-07-11	3	2024	2
2024-07-12	3	2024	2
2024-07-13	3	2024	2
2024-07-14	3	2024	2
2024-07-15	3	2024	2
2024-07-16	3	2024	2
2024-07-17	3	2024	2
2024-07-18	3	2024	2
2024-07-19	3	2024	2
2024-07-20	3	2024	2
2024-07-21	3	2024	2
2024-07-22	3	2024	2
2024-07-23	3	2024	2
2024-07-24	3	2024	2
2024-07-25	3	2024	2
2024-07-26	3	2024	2
2024-07-27	3	2024	2
2024-07-28	3	2024	2
2024-07-29	3	2024	2
2024-07-30	3	2024	2
2024-07-31	3	2024	2
2024-08-01	3	2024	2
2024-08-02	3	2024	2
2024-08-03	3	2024	2
2024-08-04	3	2024	2
2024-08-05	3	2024	2
2024-08-06	3	2024	2
2024-08-07	3	2024	2
2024-08-08	3	2024	2
2024-08-09	3	2024	2
2024-08-10	3	2024	2
2024-08-11	3	2024	2
2024-08-12	3	2024	2
2024-08-13	3	2024	2
2024-08-14	3	2024	2
2024-08-15	3	2024	2
2024-08-16	3	2024	2
2024-08-17	3	2024	2
2024-08-18	3	2024	2
2024-08-19	3	2024	2
2024-08-20	3	2024	2
2024-08-21	3	2024	2
2024-08-22	3	2024	2
2024-08-23	3	2024	2
2024-08-24	3	2024	2
2024-08-25	3	2024	2
2024-08-26	3	2024	2
2024-08-27	3	2024	2
2024-08-28	3	2024	2
2024-08-29	3	2024	2
2024-08-30	3	2024	2
2024-08-31	3	2024	2
2024-09-01	3	2024	2
2024-09-02	3	2024	2
2024-09-03	3	2024	2
2024-09-04	3	2024	2
2024-09-05	3	2024	2
2024-09-06	3	2024	2
2024-09-07	3	2024	2
2024-09-08	3	2024	2
2024-09-09	3	2024	2
2024-09-10	3	2024	2
2024-09-11	3	2024	2
2024-09-12	3	2024	2
2024-09-13	3	2024	2
2024-09-14	3	2024	2
2024-09-15	3	2024	2
2024-09-16	3	2024	2
2024-09-17	3	2024	2
2024-09-18	3	2024	2
2024-09-19	3	2024	2
2024-09-20	3	2024	2
2024-09-21	3	2024	2
2024-09-22	3	2024	2
2024-09-23	3	2024	2
2024-09-24	3	2024	2
2024-09-25	3	2024	2
2024-09-26	3	2024	2
2024-09-27	3	2024	2
2024-09-28	3	2024	2
2024-09-29	3	2024	2
2024-09-30	3	2024	2
2024-10-01	4	2024	2
2024-10-02	4	2024	2
2024-10-03	4	2024	2
2024-10-04	4	2024	2
2024-10-05	4	2024	2
2024-10-06	4	2024	2
2024-10-07	4	2024	2
2024-10-08	4	2024	2
2024-10-09	4	2024	2
2024-10-10	4	2024	2
2024-10-11	4	2024	2
2024-10-12	4	2024	2
2024-10-13	4	2024	2
2024-10-14	4	2024	2
2024-10-15	4	2024	2
2024-10-16	4	2024	2
2024-10-17	4	2024	2
2024-10-18	4	2024	2
2024-10-19	4	2024	2
2024-10-20	4	2024	2
2024-10-21	4	2024	2
2024-10-22	4	2024	2
2024-10-23	4	2024	2
2024-10-24	4	2024	2
2024-10-25	4	2024	2
2024-10-26	4	2024	2
2024-10-27	4	2024	2
2024-10-28	4	2024	2
2024-10-29	4	2024	2
2024-10-30	4	2024	2
2024-10-31	4	2024	2
2024-11-01	4	2024	2
2024-11-02	4	2024	2
2024-11-03	4	2024	2
2024-11-04	4	2024	2
2024-11-05	4	2024	2
2024-11-06	4	2024	2
2024-11-07	4	2024	2
2024-11-08	4	2024	2
2024-11-09	4	2024	2
2024-11-10	4	2024	2
2024-11-11	4	2024	2
2024-11-12	4	2024	2
2024-11-13	4	2024	2
2024-11-14	4	2024	2
2024-11-15	4	2024	2
2024-11-16	4	2024	2
2024-11-17	4	2024	2
2024-11-18	4	2024	2
2024-11-19	4	2024	2
2024-11-20	4	2024	2
2024-11-21	4	2024	2
2024-11-22	4	2024	2
2024-11-23	4	2024	2
2024-11-24	4	2024	2
2024-11-25	4	2024	2
2024-11-26	4	2024	2
2024-11-27	4	2024	2
2024-11-28	4	2024	2
2024-11-29	4	2024	2
2024-11-30	4	2024	2
2024-12-01	4	2024	2
2024-12-02	4	2024	2
2024-12-03	4	2024	2
2024-12-04	4	2024	2
2024-12-05	4	2024	2
2024-12-06	4	2024	2
2024-12-07	4	2024	2
2024-12-08	4	2024	2
2024-12-09	4	2024	2
2024-12-10	4	2024	2
2024-12-11	4	2024	2
2024-12-12	4	2024	2
2024-12-13	4	2024	2
2024-12-14	4	2024	2
2024-12-15	4	2024	2
2024-12-16	4	2024	2
2024-12-17	4	2024	2
2024-12-18	4	2024	2
2024-12-19	4	2024	2
2024-12-20	4	2024	2
2024-12-21	4	2024	2
2024-12-22	4	2024	2
2024-12-23	4	2024	2
2024-12-24	4	2024	2
2024-12-25	4	2024	2
2024-12-26	4	2024	2
2024-12-27	4	2024	2
2024-12-28	4	2024	2
2024-12-29	4	2024	2
2024-12-30	4	2024	2
2024-12-31	4	2024	2
\.


--
-- TOC entry 4958 (class 0 OID 16418)
-- Dependencies: 223
-- Data for Name: fact_rt_clmb_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fact_rt_clmb_log (log_id, user_id, visit_id, rt_id, attmp_cnt, ascnt_flg) FROM stdin;
LOG0000001	USR0064	VST000662	RT00225	2	f
LOG0000002	USR0263	VST004853	RT00954	1	t
LOG0000003	USR0454	VST003740	RT00437	2	f
LOG0000004	USR0120	VST003184	RT00214	2	f
LOG0000005	USR0278	VST001486	RT00943	2	t
LOG0000006	USR0202	VST002410	RT00900	3	f
LOG0000007	USR0046	VST004299	RT00166	2	f
LOG0000008	USR0168	VST002535	RT00373	1	t
LOG0000009	USR0445	VST000004	RT00653	2	f
LOG0000010	USR0110	VST003098	RT00829	3	f
LOG0000011	USR0046	VST002849	RT00507	2	t
LOG0000012	USR0212	VST000027	RT00983	4	t
LOG0000013	USR0028	VST000965	RT00576	1	f
LOG0000014	USR0087	VST003097	RT00333	2	f
LOG0000015	USR0291	VST000072	RT00212	1	f
LOG0000016	USR0385	VST002948	RT00289	3	t
LOG0000017	USR0157	VST002316	RT00610	1	t
LOG0000018	USR0265	VST003898	RT00166	4	f
LOG0000019	USR0265	VST004491	RT00126	4	t
LOG0000020	USR0022	VST004965	RT00157	1	t
LOG0000021	USR0256	VST002412	RT00762	3	f
LOG0000022	USR0191	VST000117	RT00573	1	t
LOG0000023	USR0450	VST002212	RT00032	2	t
LOG0000024	USR0464	VST002925	RT00907	2	t
LOG0000025	USR0232	VST002838	RT00274	1	t
LOG0000026	USR0186	VST000577	RT00301	2	f
LOG0000027	USR0326	VST000772	RT00021	2	t
LOG0000028	USR0183	VST000200	RT00524	3	f
LOG0000029	USR0397	VST001756	RT00756	1	f
LOG0000030	USR0481	VST000180	RT00615	2	f
LOG0000031	USR0403	VST002406	RT00276	1	f
LOG0000032	USR0463	VST003324	RT00007	1	t
LOG0000033	USR0417	VST004749	RT00859	2	f
LOG0000034	USR0202	VST004774	RT00455	3	f
LOG0000035	USR0065	VST002302	RT00130	3	t
LOG0000036	USR0444	VST002989	RT00299	4	t
LOG0000037	USR0396	VST001603	RT00097	1	t
LOG0000038	USR0043	VST001120	RT00277	4	f
LOG0000039	USR0221	VST002215	RT00285	3	f
LOG0000040	USR0017	VST001912	RT00800	2	t
LOG0000041	USR0324	VST002902	RT00173	2	t
LOG0000042	USR0285	VST001086	RT00332	3	f
LOG0000043	USR0183	VST000174	RT00205	3	t
LOG0000044	USR0391	VST003533	RT00103	1	t
LOG0000045	USR0044	VST004720	RT00625	4	f
LOG0000046	USR0461	VST001239	RT00955	4	t
LOG0000047	USR0389	VST003311	RT00360	3	t
LOG0000048	USR0188	VST004835	RT00131	1	t
LOG0000049	USR0390	VST003814	RT00039	2	t
LOG0000050	USR0482	VST003817	RT00307	3	t
LOG0000051	USR0263	VST004771	RT00884	4	t
LOG0000052	USR0174	VST001974	RT00520	1	f
LOG0000053	USR0441	VST003783	RT00878	1	f
LOG0000054	USR0054	VST002245	RT00046	1	t
LOG0000055	USR0220	VST001658	RT00194	4	f
LOG0000056	USR0046	VST000413	RT00518	1	t
LOG0000057	USR0394	VST003411	RT00880	2	f
LOG0000058	USR0260	VST004093	RT00570	4	t
LOG0000059	USR0195	VST001383	RT00169	3	f
LOG0000060	USR0409	VST001124	RT00122	1	t
LOG0000061	USR0471	VST004330	RT00249	4	t
LOG0000062	USR0347	VST004013	RT00207	3	t
LOG0000063	USR0462	VST002244	RT00115	3	f
LOG0000064	USR0061	VST002590	RT00239	2	f
LOG0000065	USR0166	VST001779	RT00566	3	f
LOG0000066	USR0160	VST001130	RT00076	2	t
LOG0000067	USR0151	VST000645	RT00169	4	f
LOG0000068	USR0111	VST003523	RT00048	2	f
LOG0000069	USR0488	VST001558	RT00736	4	t
LOG0000070	USR0037	VST004502	RT00070	4	t
LOG0000071	USR0003	VST002774	RT00508	1	f
LOG0000072	USR0483	VST002786	RT00155	2	t
LOG0000073	USR0013	VST001707	RT00559	4	f
LOG0000074	USR0162	VST002602	RT00461	1	t
LOG0000075	USR0344	VST003644	RT00373	2	t
LOG0000076	USR0449	VST000375	RT00791	2	f
LOG0000077	USR0332	VST001613	RT00202	3	t
LOG0000078	USR0264	VST000455	RT00654	1	t
LOG0000079	USR0083	VST004298	RT00317	3	t
LOG0000080	USR0265	VST001476	RT00451	4	t
LOG0000081	USR0412	VST000854	RT00638	2	t
LOG0000082	USR0334	VST000724	RT00844	4	t
LOG0000083	USR0380	VST001392	RT00665	1	t
LOG0000084	USR0219	VST002388	RT00577	2	t
LOG0000085	USR0146	VST000262	RT00096	4	t
LOG0000086	USR0298	VST000543	RT00920	2	t
LOG0000087	USR0297	VST000551	RT00693	3	t
LOG0000088	USR0454	VST003798	RT00496	1	t
LOG0000089	USR0161	VST000638	RT00362	1	f
LOG0000090	USR0229	VST000165	RT00457	1	t
LOG0000091	USR0234	VST002806	RT00178	2	t
LOG0000092	USR0089	VST000621	RT00129	4	t
LOG0000093	USR0333	VST001224	RT00490	4	f
LOG0000094	USR0310	VST003343	RT00039	1	f
LOG0000095	USR0215	VST000051	RT00458	2	f
LOG0000096	USR0420	VST000489	RT00812	2	f
LOG0000097	USR0097	VST000665	RT00873	2	t
LOG0000098	USR0213	VST001247	RT00350	4	t
LOG0000099	USR0354	VST002711	RT00645	1	t
LOG0000100	USR0312	VST004362	RT00891	4	f
LOG0000101	USR0100	VST004169	RT00452	3	t
LOG0000102	USR0145	VST003953	RT00380	2	f
LOG0000103	USR0010	VST002592	RT00109	3	f
LOG0000104	USR0471	VST000881	RT00584	1	f
LOG0000105	USR0044	VST000435	RT00208	1	t
LOG0000106	USR0251	VST001985	RT00577	4	t
LOG0000107	USR0386	VST004453	RT00241	1	t
LOG0000108	USR0227	VST004114	RT00591	1	t
LOG0000109	USR0398	VST003871	RT00088	4	f
LOG0000110	USR0249	VST002623	RT00399	4	t
LOG0000111	USR0495	VST001793	RT00690	4	t
LOG0000112	USR0493	VST002799	RT00262	4	t
LOG0000113	USR0169	VST003513	RT00578	1	f
LOG0000114	USR0130	VST001494	RT00325	3	f
LOG0000115	USR0019	VST002680	RT00371	4	t
LOG0000116	USR0336	VST001626	RT00935	1	t
LOG0000117	USR0235	VST002420	RT00105	1	f
LOG0000118	USR0492	VST003018	RT00098	1	f
LOG0000119	USR0345	VST001848	RT00487	1	t
LOG0000120	USR0001	VST003247	RT00096	1	f
LOG0000121	USR0130	VST001539	RT00925	4	f
LOG0000122	USR0496	VST001317	RT00989	4	f
LOG0000123	USR0027	VST001720	RT00472	2	f
LOG0000124	USR0002	VST001951	RT00046	2	f
LOG0000125	USR0250	VST000224	RT00890	4	f
LOG0000126	USR0222	VST002027	RT00031	4	f
LOG0000127	USR0435	VST001548	RT00408	4	t
LOG0000128	USR0138	VST003779	RT00375	3	f
LOG0000129	USR0275	VST003724	RT00382	4	t
LOG0000130	USR0490	VST001524	RT00911	1	t
LOG0000131	USR0464	VST002704	RT00716	3	t
LOG0000132	USR0141	VST001973	RT00660	3	t
LOG0000133	USR0432	VST004529	RT00644	1	t
LOG0000134	USR0256	VST004605	RT00698	1	t
LOG0000135	USR0370	VST004604	RT00973	2	f
LOG0000136	USR0312	VST000617	RT00701	1	f
LOG0000137	USR0456	VST004516	RT00489	4	t
LOG0000138	USR0440	VST004170	RT00639	4	t
LOG0000139	USR0434	VST002622	RT00876	2	f
LOG0000140	USR0095	VST004242	RT00906	3	f
LOG0000141	USR0173	VST002094	RT00809	3	t
LOG0000142	USR0473	VST001765	RT00309	2	t
LOG0000143	USR0443	VST003177	RT00599	4	t
LOG0000144	USR0423	VST001133	RT00967	2	f
LOG0000145	USR0405	VST004217	RT00633	4	f
LOG0000146	USR0439	VST003571	RT00844	4	f
LOG0000147	USR0057	VST001067	RT00816	1	t
LOG0000148	USR0498	VST002147	RT00911	2	f
LOG0000149	USR0102	VST000706	RT00135	2	t
LOG0000150	USR0169	VST002359	RT00328	4	t
LOG0000151	USR0477	VST003535	RT00199	4	f
LOG0000152	USR0070	VST003813	RT00683	1	f
LOG0000153	USR0338	VST002471	RT00260	4	f
LOG0000154	USR0049	VST004068	RT00124	4	t
LOG0000155	USR0428	VST003461	RT00754	3	f
LOG0000156	USR0419	VST003769	RT00947	2	t
LOG0000157	USR0347	VST001935	RT00583	1	f
LOG0000158	USR0005	VST002320	RT00382	1	t
LOG0000159	USR0455	VST002873	RT00507	4	f
LOG0000160	USR0202	VST000210	RT00571	2	t
LOG0000161	USR0202	VST004835	RT00109	3	f
LOG0000162	USR0179	VST002808	RT00041	1	t
LOG0000163	USR0057	VST004255	RT00445	4	f
LOG0000164	USR0186	VST003963	RT00798	2	f
LOG0000165	USR0092	VST004837	RT00891	3	f
LOG0000166	USR0292	VST001954	RT00146	2	f
LOG0000167	USR0394	VST002391	RT00798	1	t
LOG0000168	USR0434	VST003526	RT00903	4	f
LOG0000169	USR0483	VST004795	RT00564	4	t
LOG0000170	USR0227	VST003215	RT00176	1	f
LOG0000171	USR0421	VST002445	RT00279	1	f
LOG0000172	USR0112	VST002584	RT00380	2	f
LOG0000173	USR0148	VST000141	RT00165	1	f
LOG0000174	USR0269	VST004336	RT00839	2	t
LOG0000175	USR0203	VST000292	RT00486	4	t
LOG0000176	USR0378	VST002865	RT00989	3	f
LOG0000177	USR0365	VST004178	RT00994	4	t
LOG0000178	USR0403	VST002608	RT00764	4	t
LOG0000179	USR0348	VST003937	RT00615	3	f
LOG0000180	USR0358	VST002918	RT00565	3	f
LOG0000181	USR0056	VST002219	RT00767	3	t
LOG0000182	USR0301	VST001798	RT00361	4	t
LOG0000183	USR0316	VST000977	RT00173	1	f
LOG0000184	USR0452	VST000580	RT00763	4	f
LOG0000185	USR0185	VST002574	RT00177	1	f
LOG0000186	USR0054	VST002590	RT00049	2	f
LOG0000187	USR0037	VST003284	RT00111	4	f
LOG0000188	USR0211	VST001800	RT00210	3	f
LOG0000189	USR0293	VST001462	RT00760	4	f
LOG0000190	USR0270	VST004418	RT00687	4	f
LOG0000191	USR0351	VST004069	RT00619	3	f
LOG0000192	USR0220	VST002948	RT00665	2	f
LOG0000193	USR0228	VST000714	RT00859	2	t
LOG0000194	USR0428	VST002424	RT00155	2	t
LOG0000195	USR0358	VST001891	RT00652	2	t
LOG0000196	USR0211	VST003568	RT00663	4	f
LOG0000197	USR0298	VST001679	RT00273	4	t
LOG0000198	USR0001	VST002148	RT00556	3	f
LOG0000199	USR0023	VST000918	RT00583	1	f
LOG0000200	USR0448	VST002267	RT00637	3	f
LOG0000201	USR0284	VST002525	RT00664	2	t
LOG0000202	USR0496	VST001807	RT00455	1	f
LOG0000203	USR0388	VST004052	RT00861	3	f
LOG0000204	USR0425	VST000560	RT00316	2	t
LOG0000205	USR0188	VST000629	RT00821	1	f
LOG0000206	USR0018	VST003067	RT00732	1	t
LOG0000207	USR0447	VST001912	RT00215	2	t
LOG0000208	USR0445	VST003763	RT00330	1	f
LOG0000209	USR0049	VST003552	RT00144	3	t
LOG0000210	USR0047	VST001809	RT00619	3	t
LOG0000211	USR0115	VST002387	RT00354	3	f
LOG0000212	USR0039	VST001896	RT00281	1	f
LOG0000213	USR0217	VST003931	RT00322	1	f
LOG0000214	USR0210	VST001007	RT00306	2	f
LOG0000215	USR0262	VST000049	RT00837	2	t
LOG0000216	USR0211	VST001851	RT00846	1	f
LOG0000217	USR0053	VST001930	RT00479	3	t
LOG0000218	USR0460	VST002133	RT00936	1	f
LOG0000219	USR0281	VST001526	RT00390	4	t
LOG0000220	USR0355	VST000329	RT00064	3	f
LOG0000221	USR0321	VST002658	RT00796	4	t
LOG0000222	USR0133	VST004530	RT00265	2	f
LOG0000223	USR0449	VST000588	RT00006	1	t
LOG0000224	USR0264	VST003206	RT00913	4	f
LOG0000225	USR0295	VST001599	RT00168	1	t
LOG0000226	USR0111	VST003852	RT00355	4	f
LOG0000227	USR0043	VST002473	RT00972	1	f
LOG0000228	USR0338	VST002818	RT00173	3	f
LOG0000229	USR0238	VST004608	RT00850	2	f
LOG0000230	USR0379	VST001409	RT00119	3	f
LOG0000231	USR0457	VST001012	RT00939	2	t
LOG0000232	USR0389	VST004660	RT00226	3	t
LOG0000233	USR0247	VST004399	RT00174	2	t
LOG0000234	USR0004	VST004045	RT00959	3	f
LOG0000235	USR0364	VST001330	RT00129	1	f
LOG0000236	USR0349	VST002605	RT00187	3	t
LOG0000237	USR0385	VST002024	RT00063	4	f
LOG0000238	USR0350	VST004508	RT00975	4	t
LOG0000239	USR0312	VST003186	RT00893	1	f
LOG0000240	USR0173	VST004604	RT00274	1	t
LOG0000241	USR0193	VST004152	RT00598	1	t
LOG0000242	USR0003	VST002594	RT00210	4	t
LOG0000243	USR0278	VST003342	RT00193	3	f
LOG0000244	USR0456	VST000196	RT00750	1	t
LOG0000245	USR0056	VST001791	RT00532	3	t
LOG0000246	USR0274	VST001107	RT00952	2	f
LOG0000247	USR0409	VST002790	RT00182	3	f
LOG0000248	USR0176	VST002185	RT00560	3	f
LOG0000249	USR0116	VST000539	RT00228	4	t
LOG0000250	USR0084	VST004785	RT00566	3	f
LOG0000251	USR0159	VST000719	RT00614	4	f
LOG0000252	USR0286	VST003996	RT00089	2	f
LOG0000253	USR0080	VST000306	RT00144	4	f
LOG0000254	USR0066	VST000388	RT00660	2	f
LOG0000255	USR0209	VST000725	RT00742	2	t
LOG0000256	USR0010	VST002597	RT00815	1	t
LOG0000257	USR0199	VST002436	RT00250	3	f
LOG0000258	USR0059	VST002341	RT00225	3	f
LOG0000259	USR0234	VST000179	RT00903	1	f
LOG0000260	USR0307	VST001904	RT00919	1	t
LOG0000261	USR0244	VST001705	RT00971	3	t
LOG0000262	USR0379	VST003384	RT00673	1	t
LOG0000263	USR0393	VST004176	RT00168	1	f
LOG0000264	USR0054	VST004543	RT00110	2	t
LOG0000265	USR0446	VST004862	RT00773	1	t
LOG0000266	USR0337	VST004666	RT00173	1	t
LOG0000267	USR0393	VST000096	RT00511	4	f
LOG0000268	USR0009	VST001284	RT00879	3	t
LOG0000269	USR0101	VST000248	RT00297	4	t
LOG0000270	USR0408	VST000982	RT00904	1	t
LOG0000271	USR0295	VST004364	RT00243	1	f
LOG0000272	USR0203	VST001566	RT00209	4	t
LOG0000273	USR0392	VST002142	RT00243	1	f
LOG0000274	USR0153	VST000736	RT00254	2	f
LOG0000275	USR0110	VST003388	RT00082	4	t
LOG0000276	USR0322	VST002660	RT00434	4	f
LOG0000277	USR0266	VST000449	RT00475	3	t
LOG0000278	USR0373	VST001836	RT00543	4	t
LOG0000279	USR0152	VST004716	RT00004	2	f
LOG0000280	USR0496	VST000614	RT00194	1	t
LOG0000281	USR0464	VST001434	RT00056	4	t
LOG0000282	USR0083	VST000877	RT00261	4	t
LOG0000283	USR0443	VST002576	RT00593	3	f
LOG0000284	USR0415	VST001134	RT00566	3	f
LOG0000285	USR0395	VST004871	RT00380	1	f
LOG0000286	USR0134	VST000672	RT00487	4	t
LOG0000287	USR0326	VST001631	RT00096	2	t
LOG0000288	USR0160	VST003319	RT00861	1	f
LOG0000289	USR0039	VST000361	RT00336	2	f
LOG0000290	USR0176	VST002393	RT00769	4	t
LOG0000291	USR0013	VST003902	RT00716	1	f
LOG0000292	USR0315	VST000798	RT00723	3	t
LOG0000293	USR0067	VST001784	RT00329	3	f
LOG0000294	USR0440	VST000067	RT00496	2	t
LOG0000295	USR0248	VST003035	RT00829	1	t
LOG0000296	USR0041	VST002091	RT00638	2	t
LOG0000297	USR0184	VST002277	RT00519	3	f
LOG0000298	USR0035	VST003516	RT00926	4	t
LOG0000299	USR0422	VST000234	RT00125	3	f
LOG0000300	USR0337	VST001223	RT00783	4	t
LOG0000301	USR0451	VST002545	RT00620	2	t
LOG0000302	USR0290	VST001056	RT00260	2	t
LOG0000303	USR0076	VST004555	RT00831	2	f
LOG0000304	USR0472	VST003348	RT00582	4	t
LOG0000305	USR0070	VST001170	RT00550	2	f
LOG0000306	USR0234	VST004102	RT00687	2	t
LOG0000307	USR0011	VST000494	RT00700	1	t
LOG0000308	USR0368	VST003180	RT00739	4	f
LOG0000309	USR0283	VST003844	RT00770	2	f
LOG0000310	USR0304	VST001364	RT00709	2	t
LOG0000311	USR0024	VST003399	RT00008	4	f
LOG0000312	USR0274	VST001057	RT00563	4	t
LOG0000313	USR0027	VST000143	RT00373	3	f
LOG0000314	USR0054	VST003316	RT00222	3	t
LOG0000315	USR0055	VST004832	RT00880	1	f
LOG0000316	USR0376	VST002774	RT00531	2	f
LOG0000317	USR0233	VST001885	RT00350	4	f
LOG0000318	USR0277	VST002265	RT00759	2	f
LOG0000319	USR0443	VST001925	RT00031	3	t
LOG0000320	USR0371	VST004046	RT00592	3	f
LOG0000321	USR0418	VST002482	RT00358	3	f
LOG0000322	USR0120	VST001891	RT00022	4	f
LOG0000323	USR0225	VST003126	RT00289	2	t
LOG0000324	USR0058	VST000942	RT00754	4	t
LOG0000325	USR0255	VST001616	RT00214	2	f
LOG0000326	USR0176	VST001969	RT00712	1	t
LOG0000327	USR0054	VST003223	RT00165	3	t
LOG0000328	USR0146	VST004151	RT00140	3	f
LOG0000329	USR0259	VST001472	RT00370	3	t
LOG0000330	USR0152	VST001059	RT00965	3	f
LOG0000331	USR0385	VST001007	RT00320	4	f
LOG0000332	USR0262	VST003191	RT00409	3	t
LOG0000333	USR0019	VST001221	RT00438	2	t
LOG0000334	USR0342	VST004662	RT00797	2	f
LOG0000335	USR0371	VST004867	RT00013	3	f
LOG0000336	USR0171	VST001798	RT00501	3	f
LOG0000337	USR0379	VST004974	RT00026	4	t
LOG0000338	USR0392	VST002872	RT00534	4	t
LOG0000339	USR0197	VST000514	RT00861	2	t
LOG0000340	USR0436	VST001618	RT00076	2	t
LOG0000341	USR0073	VST004518	RT00366	1	f
LOG0000342	USR0303	VST004613	RT00491	2	t
LOG0000343	USR0085	VST003758	RT00092	1	t
LOG0000344	USR0284	VST002033	RT00841	3	t
LOG0000345	USR0302	VST003211	RT00887	3	f
LOG0000346	USR0132	VST000705	RT00266	3	t
LOG0000347	USR0120	VST001674	RT00560	2	f
LOG0000348	USR0216	VST003700	RT00499	2	t
LOG0000349	USR0136	VST002092	RT00170	3	f
LOG0000350	USR0116	VST004954	RT00346	4	f
LOG0000351	USR0061	VST002849	RT00757	3	f
LOG0000352	USR0017	VST004315	RT00228	1	f
LOG0000353	USR0034	VST004664	RT00699	4	t
LOG0000354	USR0020	VST001778	RT00949	4	t
LOG0000355	USR0208	VST004354	RT00680	2	t
LOG0000356	USR0458	VST000893	RT00203	2	f
LOG0000357	USR0162	VST000972	RT00446	1	f
LOG0000358	USR0299	VST000103	RT00518	3	f
LOG0000359	USR0010	VST001108	RT00132	3	f
LOG0000360	USR0094	VST003247	RT00245	2	t
LOG0000361	USR0414	VST003713	RT00091	2	t
LOG0000362	USR0371	VST003418	RT00823	3	f
LOG0000363	USR0409	VST004152	RT00126	4	t
LOG0000364	USR0383	VST003660	RT00472	1	f
LOG0000365	USR0441	VST004927	RT00965	1	t
LOG0000366	USR0366	VST000920	RT00242	1	t
LOG0000367	USR0447	VST004553	RT00502	2	f
LOG0000368	USR0107	VST004228	RT00761	4	t
LOG0000369	USR0105	VST004589	RT00387	1	f
LOG0000370	USR0071	VST002158	RT00007	4	t
LOG0000371	USR0431	VST000582	RT00088	2	f
LOG0000372	USR0084	VST000796	RT00598	2	f
LOG0000373	USR0209	VST003198	RT00908	3	f
LOG0000374	USR0259	VST001884	RT00867	4	t
LOG0000375	USR0239	VST003368	RT00145	4	t
LOG0000376	USR0302	VST000810	RT00451	4	f
LOG0000377	USR0232	VST002934	RT00331	3	f
LOG0000378	USR0420	VST003269	RT00710	1	t
LOG0000379	USR0282	VST004869	RT00875	1	f
LOG0000380	USR0394	VST002985	RT00164	2	f
LOG0000381	USR0418	VST000573	RT00657	3	t
LOG0000382	USR0206	VST001207	RT00342	4	f
LOG0000383	USR0264	VST004905	RT00001	3	f
LOG0000384	USR0311	VST004975	RT00120	2	f
LOG0000385	USR0347	VST003081	RT00579	1	t
LOG0000386	USR0394	VST002461	RT00464	1	t
LOG0000387	USR0185	VST001742	RT00867	2	f
LOG0000388	USR0114	VST004006	RT00462	3	f
LOG0000389	USR0079	VST004926	RT00049	2	t
LOG0000390	USR0357	VST002614	RT00819	4	f
LOG0000391	USR0342	VST001716	RT00327	4	f
LOG0000392	USR0301	VST001570	RT00474	2	f
LOG0000393	USR0050	VST000677	RT00888	4	t
LOG0000394	USR0320	VST001834	RT00939	4	t
LOG0000395	USR0095	VST002514	RT00368	1	t
LOG0000396	USR0258	VST000801	RT00287	3	f
LOG0000397	USR0429	VST001142	RT00024	1	f
LOG0000398	USR0351	VST003053	RT00723	1	t
LOG0000399	USR0062	VST002032	RT00293	3	f
LOG0000400	USR0142	VST001509	RT00449	1	t
LOG0000401	USR0330	VST001111	RT00985	4	f
LOG0000402	USR0222	VST004330	RT00063	2	t
LOG0000403	USR0356	VST000913	RT00568	2	t
LOG0000404	USR0111	VST001056	RT00458	3	t
LOG0000405	USR0104	VST004190	RT00530	2	f
LOG0000406	USR0015	VST001751	RT00874	2	f
LOG0000407	USR0270	VST003172	RT00961	2	t
LOG0000408	USR0159	VST004154	RT00413	2	f
LOG0000409	USR0157	VST003013	RT00589	1	t
LOG0000410	USR0027	VST003429	RT00260	4	t
LOG0000411	USR0085	VST003563	RT00633	4	t
LOG0000412	USR0009	VST000357	RT00908	2	t
LOG0000413	USR0276	VST004392	RT00184	3	f
LOG0000414	USR0227	VST004621	RT00048	1	t
LOG0000415	USR0186	VST001618	RT00147	2	f
LOG0000416	USR0079	VST001624	RT00794	2	t
LOG0000417	USR0216	VST001666	RT00876	3	t
LOG0000418	USR0433	VST003200	RT00806	1	t
LOG0000419	USR0057	VST004497	RT00592	2	t
LOG0000420	USR0144	VST001596	RT00748	3	t
LOG0000421	USR0356	VST001990	RT00409	1	t
LOG0000422	USR0331	VST002787	RT00440	1	t
LOG0000423	USR0392	VST000529	RT00458	2	f
LOG0000424	USR0067	VST002605	RT00229	3	f
LOG0000425	USR0275	VST003196	RT00284	3	f
LOG0000426	USR0494	VST002408	RT00573	2	f
LOG0000427	USR0105	VST000064	RT00732	2	f
LOG0000428	USR0451	VST003961	RT00345	2	t
LOG0000429	USR0420	VST002813	RT00601	3	t
LOG0000430	USR0473	VST002822	RT00947	1	f
LOG0000431	USR0188	VST004028	RT00908	2	t
LOG0000432	USR0164	VST000102	RT00264	4	t
LOG0000433	USR0267	VST003349	RT00740	4	t
LOG0000434	USR0051	VST003299	RT00378	2	f
LOG0000435	USR0126	VST003095	RT00103	4	f
LOG0000436	USR0080	VST002892	RT00954	1	f
LOG0000437	USR0183	VST003136	RT00600	1	t
LOG0000438	USR0310	VST001181	RT00023	4	f
LOG0000439	USR0017	VST002887	RT00293	3	t
LOG0000440	USR0446	VST002729	RT00267	2	t
LOG0000441	USR0170	VST002693	RT00529	3	t
LOG0000442	USR0280	VST000399	RT00476	1	t
LOG0000443	USR0401	VST000405	RT00952	4	t
LOG0000444	USR0304	VST002874	RT00949	2	f
LOG0000445	USR0340	VST003269	RT00451	4	f
LOG0000446	USR0214	VST002695	RT00898	4	f
LOG0000447	USR0198	VST002083	RT00285	3	t
LOG0000448	USR0007	VST002468	RT00313	3	f
LOG0000449	USR0398	VST004473	RT00162	4	f
LOG0000450	USR0011	VST004316	RT00590	1	t
LOG0000451	USR0012	VST001922	RT00122	2	f
LOG0000452	USR0110	VST003960	RT00481	4	t
LOG0000453	USR0133	VST001541	RT00112	4	t
LOG0000454	USR0389	VST002390	RT00239	4	t
LOG0000455	USR0128	VST004849	RT00210	4	t
LOG0000456	USR0148	VST002464	RT00349	3	f
LOG0000457	USR0054	VST003369	RT00511	3	f
LOG0000458	USR0311	VST002986	RT00002	1	t
LOG0000459	USR0442	VST000680	RT00892	2	f
LOG0000460	USR0079	VST000748	RT00715	4	f
LOG0000461	USR0346	VST002854	RT00799	1	t
LOG0000462	USR0097	VST001322	RT00629	3	t
LOG0000463	USR0249	VST003749	RT00881	2	t
LOG0000464	USR0127	VST004151	RT00461	1	f
LOG0000465	USR0030	VST004790	RT00812	2	f
LOG0000466	USR0024	VST000534	RT00895	2	t
LOG0000467	USR0471	VST001819	RT00858	2	t
LOG0000468	USR0201	VST004201	RT00952	3	t
LOG0000469	USR0131	VST002342	RT00482	4	f
LOG0000470	USR0122	VST002423	RT00950	2	t
LOG0000471	USR0356	VST004546	RT00949	1	f
LOG0000472	USR0432	VST001469	RT00626	2	t
LOG0000473	USR0327	VST004908	RT00586	2	f
LOG0000474	USR0150	VST004486	RT00972	3	f
LOG0000475	USR0014	VST001236	RT00241	1	t
LOG0000476	USR0304	VST002715	RT00982	2	f
LOG0000477	USR0029	VST001709	RT00814	3	f
LOG0000478	USR0050	VST001146	RT00054	3	f
LOG0000479	USR0464	VST001476	RT00671	4	t
LOG0000480	USR0240	VST003924	RT00467	4	f
LOG0000481	USR0482	VST002922	RT00109	4	f
LOG0000482	USR0394	VST001856	RT00280	2	f
LOG0000483	USR0455	VST003225	RT00665	2	t
LOG0000484	USR0473	VST003965	RT00675	2	t
LOG0000485	USR0283	VST003380	RT00057	3	t
LOG0000486	USR0335	VST004939	RT00840	2	f
LOG0000487	USR0352	VST001605	RT00837	3	t
LOG0000488	USR0156	VST003280	RT00214	1	t
LOG0000489	USR0137	VST000552	RT00508	2	t
LOG0000490	USR0327	VST002005	RT00028	1	t
LOG0000491	USR0336	VST001837	RT00204	4	f
LOG0000492	USR0154	VST001125	RT00545	1	t
LOG0000493	USR0483	VST001383	RT00309	1	t
LOG0000494	USR0081	VST001771	RT00634	3	t
LOG0000495	USR0087	VST003864	RT00528	3	t
LOG0000496	USR0264	VST003401	RT00666	3	f
LOG0000497	USR0258	VST000035	RT00908	3	f
LOG0000498	USR0479	VST002205	RT00343	4	t
LOG0000499	USR0185	VST005000	RT00218	1	f
LOG0000500	USR0180	VST003345	RT00617	4	f
LOG0000501	USR0186	VST003015	RT00589	4	t
LOG0000502	USR0123	VST004492	RT00087	3	f
LOG0000503	USR0377	VST004303	RT00031	1	t
LOG0000504	USR0096	VST001781	RT00100	1	f
LOG0000505	USR0093	VST001629	RT00667	4	t
LOG0000506	USR0003	VST001330	RT00804	3	f
LOG0000507	USR0392	VST001560	RT00315	4	f
LOG0000508	USR0443	VST000805	RT00495	1	t
LOG0000509	USR0002	VST002510	RT00618	3	f
LOG0000510	USR0479	VST004348	RT00471	4	t
LOG0000511	USR0446	VST001291	RT00742	1	f
LOG0000512	USR0371	VST004305	RT00515	2	t
LOG0000513	USR0305	VST002587	RT00734	3	f
LOG0000514	USR0357	VST004931	RT00633	1	f
LOG0000515	USR0148	VST002551	RT00672	3	f
LOG0000516	USR0285	VST000956	RT00783	1	f
LOG0000517	USR0145	VST004610	RT00998	3	f
LOG0000518	USR0330	VST000580	RT00331	2	t
LOG0000519	USR0361	VST001938	RT00194	4	t
LOG0000520	USR0406	VST001998	RT00730	4	t
LOG0000521	USR0262	VST001666	RT00191	4	t
LOG0000522	USR0062	VST002131	RT00252	2	f
LOG0000523	USR0491	VST003741	RT00738	3	t
LOG0000524	USR0226	VST002501	RT00001	3	t
LOG0000525	USR0031	VST001643	RT00459	1	f
LOG0000526	USR0190	VST004713	RT00645	1	t
LOG0000527	USR0375	VST001498	RT00090	3	f
LOG0000528	USR0268	VST004603	RT00518	2	t
LOG0000529	USR0012	VST003205	RT00483	2	f
LOG0000530	USR0191	VST000622	RT00756	4	f
LOG0000531	USR0400	VST003145	RT00645	4	f
LOG0000532	USR0025	VST001952	RT00116	4	t
LOG0000533	USR0406	VST001460	RT00073	3	f
LOG0000534	USR0091	VST000293	RT00156	1	t
LOG0000535	USR0088	VST000655	RT00723	3	f
LOG0000536	USR0332	VST002985	RT00069	3	f
LOG0000537	USR0274	VST003844	RT00471	2	f
LOG0000538	USR0301	VST002805	RT00492	2	f
LOG0000539	USR0111	VST002715	RT00300	1	f
LOG0000540	USR0080	VST001622	RT00144	1	f
LOG0000541	USR0324	VST004015	RT00711	3	t
LOG0000542	USR0140	VST003254	RT00206	3	f
LOG0000543	USR0433	VST002847	RT00918	3	f
LOG0000544	USR0417	VST004881	RT00713	3	t
LOG0000545	USR0214	VST004863	RT00751	2	t
LOG0000546	USR0447	VST003506	RT00407	4	f
LOG0000547	USR0018	VST000519	RT00939	4	f
LOG0000548	USR0054	VST002686	RT00580	4	f
LOG0000549	USR0368	VST000028	RT00683	1	f
LOG0000550	USR0097	VST000266	RT00922	1	t
LOG0000551	USR0283	VST001307	RT00297	1	t
LOG0000552	USR0234	VST004054	RT00582	1	t
LOG0000553	USR0467	VST003455	RT00799	2	t
LOG0000554	USR0240	VST000811	RT00529	3	t
LOG0000555	USR0334	VST004677	RT00137	1	f
LOG0000556	USR0409	VST003391	RT00219	4	t
LOG0000557	USR0418	VST000611	RT00823	1	f
LOG0000558	USR0344	VST004289	RT00518	4	t
LOG0000559	USR0486	VST002275	RT00710	3	t
LOG0000560	USR0444	VST004547	RT00448	2	f
LOG0000561	USR0054	VST000203	RT00132	2	f
LOG0000562	USR0087	VST000402	RT00363	1	f
LOG0000563	USR0261	VST002028	RT00963	1	f
LOG0000564	USR0236	VST003851	RT00344	4	f
LOG0000565	USR0123	VST000890	RT00696	1	f
LOG0000566	USR0420	VST000179	RT00018	2	t
LOG0000567	USR0054	VST001980	RT00416	1	t
LOG0000568	USR0216	VST002511	RT00725	4	t
LOG0000569	USR0420	VST002883	RT00560	3	t
LOG0000570	USR0197	VST003985	RT00541	2	t
LOG0000571	USR0039	VST002045	RT00928	2	t
LOG0000572	USR0454	VST002984	RT00153	3	t
LOG0000573	USR0365	VST000351	RT00332	3	t
LOG0000574	USR0228	VST004283	RT00750	2	f
LOG0000575	USR0237	VST003419	RT00319	4	t
LOG0000576	USR0132	VST003831	RT00777	4	t
LOG0000577	USR0330	VST001968	RT00199	1	f
LOG0000578	USR0500	VST004405	RT00526	4	f
LOG0000579	USR0321	VST002225	RT00788	2	t
LOG0000580	USR0469	VST004523	RT00980	1	f
LOG0000581	USR0168	VST002788	RT00010	4	f
LOG0000582	USR0487	VST004627	RT00139	3	f
LOG0000583	USR0037	VST004344	RT00167	4	f
LOG0000584	USR0067	VST004312	RT00147	1	t
LOG0000585	USR0111	VST004809	RT00403	3	f
LOG0000586	USR0415	VST000438	RT00757	1	t
LOG0000587	USR0219	VST002359	RT00939	1	f
LOG0000588	USR0209	VST003855	RT00445	3	f
LOG0000589	USR0381	VST000383	RT00070	1	f
LOG0000590	USR0087	VST004217	RT00328	2	f
LOG0000591	USR0461	VST000407	RT00833	1	f
LOG0000592	USR0303	VST004341	RT00919	2	f
LOG0000593	USR0411	VST000066	RT00616	3	f
LOG0000594	USR0179	VST002990	RT00229	1	f
LOG0000595	USR0404	VST000228	RT00828	4	f
LOG0000596	USR0494	VST004978	RT00650	1	t
LOG0000597	USR0013	VST002185	RT00319	2	t
LOG0000598	USR0447	VST002242	RT00898	2	t
LOG0000599	USR0300	VST004802	RT00036	4	f
LOG0000600	USR0408	VST004754	RT00630	3	f
LOG0000601	USR0125	VST001513	RT00255	2	f
LOG0000602	USR0375	VST000930	RT00313	2	t
LOG0000603	USR0233	VST004037	RT00962	2	f
LOG0000604	USR0251	VST002604	RT00335	1	t
LOG0000605	USR0387	VST001181	RT00020	1	t
LOG0000606	USR0126	VST001040	RT00298	1	f
LOG0000607	USR0235	VST001102	RT00021	1	t
LOG0000608	USR0138	VST002100	RT00478	1	f
LOG0000609	USR0449	VST000514	RT00768	4	t
LOG0000610	USR0049	VST004840	RT00760	2	f
LOG0000611	USR0380	VST003133	RT00472	4	f
LOG0000612	USR0186	VST001833	RT00962	2	f
LOG0000613	USR0205	VST004639	RT00678	1	f
LOG0000614	USR0078	VST002458	RT00470	1	f
LOG0000615	USR0481	VST002203	RT00349	3	t
LOG0000616	USR0386	VST002681	RT00767	3	f
LOG0000617	USR0194	VST002099	RT00590	4	f
LOG0000618	USR0103	VST003167	RT00965	2	t
LOG0000619	USR0105	VST001928	RT00792	4	t
LOG0000620	USR0376	VST004451	RT00794	3	f
LOG0000621	USR0287	VST003117	RT00386	2	t
LOG0000622	USR0324	VST002888	RT00942	4	f
LOG0000623	USR0482	VST004344	RT00877	3	f
LOG0000624	USR0211	VST004629	RT00546	1	f
LOG0000625	USR0250	VST003531	RT00446	4	t
LOG0000626	USR0293	VST000790	RT00983	1	f
LOG0000627	USR0201	VST001301	RT00937	4	f
LOG0000628	USR0024	VST001948	RT00099	2	f
LOG0000629	USR0461	VST002243	RT00655	2	f
LOG0000630	USR0300	VST001095	RT00055	2	f
LOG0000631	USR0478	VST001359	RT00003	2	f
LOG0000632	USR0083	VST003657	RT00332	3	f
LOG0000633	USR0297	VST000308	RT00934	1	t
LOG0000634	USR0458	VST001451	RT00435	3	f
LOG0000635	USR0179	VST002124	RT00913	4	f
LOG0000636	USR0298	VST004883	RT00486	4	f
LOG0000637	USR0364	VST002843	RT00219	1	t
LOG0000638	USR0206	VST001665	RT00211	1	t
LOG0000639	USR0040	VST003949	RT00817	3	f
LOG0000640	USR0304	VST001395	RT00496	2	f
LOG0000641	USR0113	VST004073	RT00661	3	t
LOG0000642	USR0340	VST003635	RT00232	3	f
LOG0000643	USR0004	VST000215	RT00600	4	f
LOG0000644	USR0486	VST003073	RT00920	3	f
LOG0000645	USR0108	VST004055	RT00723	1	f
LOG0000646	USR0316	VST004473	RT00735	2	t
LOG0000647	USR0114	VST002460	RT00808	4	f
LOG0000648	USR0167	VST003707	RT00148	1	t
LOG0000649	USR0261	VST003272	RT00207	4	f
LOG0000650	USR0106	VST001207	RT00360	3	t
LOG0000651	USR0224	VST000410	RT00419	3	f
LOG0000652	USR0262	VST003470	RT00944	1	f
LOG0000653	USR0251	VST000216	RT00739	1	t
LOG0000654	USR0014	VST004848	RT00417	4	f
LOG0000655	USR0198	VST000349	RT00872	2	t
LOG0000656	USR0126	VST003652	RT00696	4	t
LOG0000657	USR0206	VST002879	RT00553	3	f
LOG0000658	USR0140	VST003666	RT00182	1	f
LOG0000659	USR0062	VST004750	RT00556	1	t
LOG0000660	USR0283	VST003070	RT00210	4	t
LOG0000661	USR0054	VST003995	RT00849	1	t
LOG0000662	USR0346	VST003113	RT00968	1	f
LOG0000663	USR0012	VST000003	RT00250	3	f
LOG0000664	USR0136	VST001118	RT00512	2	f
LOG0000665	USR0330	VST001083	RT00596	1	t
LOG0000666	USR0144	VST004503	RT00139	1	f
LOG0000667	USR0436	VST001518	RT00990	4	t
LOG0000668	USR0282	VST004847	RT00987	2	t
LOG0000669	USR0136	VST001896	RT00231	3	t
LOG0000670	USR0489	VST003580	RT00910	1	f
LOG0000671	USR0301	VST002634	RT00938	2	f
LOG0000672	USR0221	VST004984	RT00975	2	t
LOG0000673	USR0340	VST002380	RT00012	4	t
LOG0000674	USR0209	VST001013	RT00980	3	t
LOG0000675	USR0403	VST004265	RT00273	2	t
LOG0000676	USR0401	VST002824	RT00488	3	f
LOG0000677	USR0359	VST000849	RT00090	2	f
LOG0000678	USR0380	VST001705	RT00974	1	t
LOG0000679	USR0449	VST004094	RT00025	3	f
LOG0000680	USR0123	VST000206	RT00538	4	f
LOG0000681	USR0116	VST001893	RT00943	2	f
LOG0000682	USR0157	VST000521	RT00665	1	f
LOG0000683	USR0270	VST003577	RT00985	2	t
LOG0000684	USR0017	VST002352	RT00572	1	f
LOG0000685	USR0269	VST002135	RT00060	3	t
LOG0000686	USR0349	VST004839	RT00795	4	f
LOG0000687	USR0482	VST002476	RT00171	1	t
LOG0000688	USR0219	VST004546	RT00588	2	t
LOG0000689	USR0319	VST000786	RT00788	1	f
LOG0000690	USR0238	VST004098	RT00447	1	f
LOG0000691	USR0033	VST002791	RT00720	4	f
LOG0000692	USR0285	VST002158	RT00921	3	f
LOG0000693	USR0037	VST000679	RT00667	1	t
LOG0000694	USR0103	VST003529	RT00692	1	t
LOG0000695	USR0211	VST003560	RT00594	2	f
LOG0000696	USR0430	VST000371	RT00010	2	t
LOG0000697	USR0280	VST002938	RT00243	3	t
LOG0000698	USR0142	VST000722	RT00178	3	f
LOG0000699	USR0239	VST004401	RT00798	3	f
LOG0000700	USR0229	VST000924	RT00257	2	t
LOG0000701	USR0133	VST000836	RT00310	1	f
LOG0000702	USR0125	VST002494	RT00516	3	f
LOG0000703	USR0053	VST002980	RT00215	2	t
LOG0000704	USR0088	VST002326	RT00903	2	t
LOG0000705	USR0098	VST003925	RT00030	3	f
LOG0000706	USR0370	VST002425	RT00346	2	t
LOG0000707	USR0095	VST004522	RT00065	1	t
LOG0000708	USR0414	VST003127	RT00636	4	f
LOG0000709	USR0188	VST002377	RT00797	2	t
LOG0000710	USR0376	VST000454	RT00153	2	f
LOG0000711	USR0256	VST003460	RT00040	4	f
LOG0000712	USR0073	VST004860	RT00026	1	t
LOG0000713	USR0475	VST003502	RT00273	3	t
LOG0000714	USR0412	VST003548	RT00159	2	f
LOG0000715	USR0362	VST001149	RT00701	1	t
LOG0000716	USR0282	VST000523	RT00776	3	t
LOG0000717	USR0018	VST004578	RT00581	1	f
LOG0000718	USR0164	VST000122	RT00001	4	t
LOG0000719	USR0392	VST003619	RT00079	2	t
LOG0000720	USR0146	VST004677	RT00228	1	t
LOG0000721	USR0468	VST003723	RT00327	3	f
LOG0000722	USR0314	VST003084	RT00558	3	t
LOG0000723	USR0253	VST002173	RT00620	3	f
LOG0000724	USR0160	VST002707	RT00501	4	t
LOG0000725	USR0349	VST004814	RT00475	1	t
LOG0000726	USR0049	VST003308	RT00355	1	f
LOG0000727	USR0176	VST003643	RT00124	3	t
LOG0000728	USR0466	VST002818	RT00987	3	t
LOG0000729	USR0327	VST004502	RT00660	3	t
LOG0000730	USR0065	VST001485	RT00978	4	f
LOG0000731	USR0476	VST000277	RT00424	4	f
LOG0000732	USR0289	VST001249	RT00252	2	f
LOG0000733	USR0050	VST001125	RT00514	2	t
LOG0000734	USR0004	VST002902	RT00734	2	f
LOG0000735	USR0119	VST001658	RT00701	3	t
LOG0000736	USR0340	VST001754	RT00507	4	t
LOG0000737	USR0373	VST004603	RT00486	4	f
LOG0000738	USR0500	VST003659	RT00478	2	f
LOG0000739	USR0164	VST003403	RT00583	3	t
LOG0000740	USR0223	VST004333	RT00871	1	f
LOG0000741	USR0358	VST000752	RT00333	3	f
LOG0000742	USR0156	VST000165	RT00609	3	t
LOG0000743	USR0387	VST001693	RT00232	2	t
LOG0000744	USR0262	VST001957	RT00542	4	t
LOG0000745	USR0173	VST003861	RT00030	4	f
LOG0000746	USR0023	VST002776	RT00727	1	t
LOG0000747	USR0391	VST003290	RT00173	4	f
LOG0000748	USR0376	VST001769	RT00792	4	t
LOG0000749	USR0061	VST002424	RT00468	1	f
LOG0000750	USR0356	VST004527	RT00476	1	f
LOG0000751	USR0321	VST003697	RT00952	2	t
LOG0000752	USR0134	VST000783	RT00723	2	f
LOG0000753	USR0024	VST003779	RT00317	2	f
LOG0000754	USR0293	VST000955	RT00397	2	f
LOG0000755	USR0045	VST001993	RT00125	4	t
LOG0000756	USR0179	VST001660	RT00080	2	f
LOG0000757	USR0356	VST000141	RT00696	3	t
LOG0000758	USR0472	VST000720	RT00527	1	t
LOG0000759	USR0358	VST001651	RT00523	2	f
LOG0000760	USR0429	VST003574	RT00396	1	f
LOG0000761	USR0063	VST003475	RT00854	4	t
LOG0000762	USR0029	VST001016	RT00089	2	t
LOG0000763	USR0357	VST004384	RT00003	3	f
LOG0000764	USR0365	VST000343	RT00536	1	t
LOG0000765	USR0096	VST003184	RT00601	2	t
LOG0000766	USR0409	VST002702	RT00521	3	t
LOG0000767	USR0266	VST000976	RT00988	4	f
LOG0000768	USR0291	VST002584	RT00558	3	f
LOG0000769	USR0055	VST003121	RT00606	4	t
LOG0000770	USR0153	VST001824	RT00071	1	f
LOG0000771	USR0219	VST004427	RT00700	2	f
LOG0000772	USR0173	VST004461	RT00139	3	t
LOG0000773	USR0096	VST000011	RT00010	3	t
LOG0000774	USR0123	VST004605	RT00515	3	f
LOG0000775	USR0012	VST002628	RT00531	4	f
LOG0000776	USR0004	VST001469	RT00130	1	f
LOG0000777	USR0362	VST001114	RT00401	1	f
LOG0000778	USR0346	VST000622	RT00221	2	f
LOG0000779	USR0067	VST000901	RT00642	2	f
LOG0000780	USR0145	VST003748	RT00437	1	f
LOG0000781	USR0457	VST004065	RT00400	1	t
LOG0000782	USR0477	VST001472	RT00113	1	f
LOG0000783	USR0065	VST003104	RT00650	3	f
LOG0000784	USR0082	VST000327	RT00452	4	f
LOG0000785	USR0105	VST000074	RT00555	1	f
LOG0000786	USR0181	VST000251	RT00218	2	t
LOG0000787	USR0340	VST002498	RT00058	4	t
LOG0000788	USR0441	VST002403	RT00113	3	t
LOG0000789	USR0105	VST004629	RT00700	4	f
LOG0000790	USR0226	VST000296	RT00122	1	f
LOG0000791	USR0371	VST000298	RT00408	4	t
LOG0000792	USR0028	VST000302	RT00460	2	t
LOG0000793	USR0496	VST004608	RT00085	4	f
LOG0000794	USR0483	VST000585	RT00618	1	f
LOG0000795	USR0016	VST003625	RT00400	4	f
LOG0000796	USR0277	VST001635	RT00356	4	t
LOG0000797	USR0333	VST000053	RT00099	4	f
LOG0000798	USR0483	VST002277	RT00521	2	t
LOG0000799	USR0298	VST002688	RT00518	4	t
LOG0000800	USR0054	VST002845	RT00108	4	t
LOG0000801	USR0288	VST004887	RT00961	3	f
LOG0000802	USR0114	VST004591	RT00974	4	f
LOG0000803	USR0038	VST004949	RT00152	4	t
LOG0000804	USR0454	VST002719	RT00906	3	t
LOG0000805	USR0370	VST003936	RT00850	2	t
LOG0000806	USR0230	VST000663	RT00749	2	f
LOG0000807	USR0166	VST000008	RT00969	3	f
LOG0000808	USR0182	VST003684	RT00027	3	f
LOG0000809	USR0444	VST003088	RT00119	4	t
LOG0000810	USR0205	VST004762	RT00723	2	f
LOG0000811	USR0366	VST000669	RT00100	2	f
LOG0000812	USR0245	VST003165	RT00003	4	f
LOG0000813	USR0359	VST001286	RT00806	1	f
LOG0000814	USR0333	VST003621	RT00969	4	t
LOG0000815	USR0431	VST000161	RT00842	1	f
LOG0000816	USR0396	VST002399	RT00329	4	f
LOG0000817	USR0309	VST003246	RT00529	3	t
LOG0000818	USR0417	VST000018	RT00106	4	t
LOG0000819	USR0412	VST002534	RT00230	3	f
LOG0000820	USR0121	VST004447	RT00304	1	f
LOG0000821	USR0259	VST002576	RT00177	1	t
LOG0000822	USR0210	VST004968	RT00939	3	t
LOG0000823	USR0410	VST002318	RT00084	3	f
LOG0000824	USR0310	VST002919	RT00263	2	f
LOG0000825	USR0296	VST001054	RT00196	2	f
LOG0000826	USR0194	VST000316	RT00249	4	t
LOG0000827	USR0068	VST004833	RT00382	3	t
LOG0000828	USR0114	VST002212	RT00458	1	f
LOG0000829	USR0220	VST000320	RT00661	2	f
LOG0000830	USR0220	VST004528	RT00718	3	t
LOG0000831	USR0473	VST002716	RT00409	1	t
LOG0000832	USR0218	VST000634	RT00081	1	t
LOG0000833	USR0237	VST001706	RT00701	3	t
LOG0000834	USR0431	VST004821	RT00412	4	f
LOG0000835	USR0386	VST000673	RT00206	2	f
LOG0000836	USR0298	VST002280	RT00820	2	t
LOG0000837	USR0418	VST003548	RT00781	3	t
LOG0000838	USR0094	VST000471	RT00802	4	t
LOG0000839	USR0253	VST003232	RT00895	1	t
LOG0000840	USR0405	VST002608	RT00873	4	f
LOG0000841	USR0492	VST003333	RT00963	2	t
LOG0000842	USR0357	VST002621	RT00388	3	f
LOG0000843	USR0428	VST004698	RT00812	2	f
LOG0000844	USR0215	VST001383	RT00894	3	f
LOG0000845	USR0481	VST004376	RT00767	4	f
LOG0000846	USR0380	VST001186	RT00399	2	f
LOG0000847	USR0258	VST001911	RT00980	4	t
LOG0000848	USR0347	VST000916	RT00008	2	f
LOG0000849	USR0240	VST001618	RT00626	4	t
LOG0000850	USR0315	VST001684	RT00517	2	t
LOG0000851	USR0214	VST002426	RT00450	3	f
LOG0000852	USR0098	VST000426	RT00476	4	t
LOG0000853	USR0016	VST001788	RT00342	4	t
LOG0000854	USR0404	VST002585	RT00073	3	t
LOG0000855	USR0154	VST004649	RT00860	1	f
LOG0000856	USR0016	VST000169	RT00121	2	f
LOG0000857	USR0198	VST000515	RT00302	2	f
LOG0000858	USR0493	VST003436	RT00961	3	t
LOG0000859	USR0108	VST004526	RT00884	2	t
LOG0000860	USR0023	VST002617	RT00996	4	t
LOG0000861	USR0042	VST002378	RT00881	4	t
LOG0000862	USR0037	VST000691	RT00234	3	f
LOG0000863	USR0328	VST003205	RT00066	4	f
LOG0000864	USR0390	VST002505	RT00230	1	f
LOG0000865	USR0165	VST000353	RT00922	2	t
LOG0000866	USR0116	VST001118	RT00543	3	t
LOG0000867	USR0150	VST001406	RT00819	3	t
LOG0000868	USR0006	VST003940	RT00809	2	t
LOG0000869	USR0032	VST004175	RT00051	1	f
LOG0000870	USR0145	VST000678	RT00659	3	t
LOG0000871	USR0294	VST000551	RT00607	2	f
LOG0000872	USR0401	VST000820	RT00329	1	f
LOG0000873	USR0293	VST000214	RT00387	3	t
LOG0000874	USR0407	VST001667	RT00038	1	f
LOG0000875	USR0177	VST004765	RT00710	3	f
LOG0000876	USR0445	VST000894	RT00753	2	t
LOG0000877	USR0177	VST004255	RT00173	2	f
LOG0000878	USR0061	VST004077	RT00493	2	t
LOG0000879	USR0077	VST003906	RT00768	1	t
LOG0000880	USR0416	VST002787	RT00455	4	f
LOG0000881	USR0383	VST002249	RT00041	1	t
LOG0000882	USR0086	VST000022	RT00921	2	f
LOG0000883	USR0191	VST003314	RT00985	3	f
LOG0000884	USR0007	VST001262	RT00946	4	f
LOG0000885	USR0406	VST001173	RT00129	1	f
LOG0000886	USR0085	VST004881	RT00054	1	f
LOG0000887	USR0262	VST002055	RT00086	3	f
LOG0000888	USR0445	VST001893	RT00724	3	t
LOG0000889	USR0398	VST002816	RT00269	2	f
LOG0000890	USR0400	VST004675	RT00296	1	f
LOG0000891	USR0259	VST004585	RT00021	3	t
LOG0000892	USR0393	VST001788	RT00215	3	t
LOG0000893	USR0047	VST001991	RT00425	4	f
LOG0000894	USR0341	VST004318	RT00189	2	t
LOG0000895	USR0498	VST002461	RT00161	2	f
LOG0000896	USR0094	VST002632	RT00713	1	t
LOG0000897	USR0478	VST002269	RT00541	3	t
LOG0000898	USR0426	VST002177	RT00381	2	t
LOG0000899	USR0426	VST000877	RT00244	1	f
LOG0000900	USR0224	VST003493	RT00183	2	t
LOG0000901	USR0279	VST004259	RT00544	1	t
LOG0000902	USR0003	VST000955	RT00779	3	f
LOG0000903	USR0129	VST004120	RT00948	2	f
LOG0000904	USR0323	VST004289	RT00548	1	t
LOG0000905	USR0249	VST000878	RT00093	1	t
LOG0000906	USR0229	VST004486	RT00368	3	t
LOG0000907	USR0327	VST002545	RT00159	2	f
LOG0000908	USR0131	VST002177	RT00398	1	f
LOG0000909	USR0228	VST002601	RT00959	1	t
LOG0000910	USR0177	VST003108	RT00180	1	f
LOG0000911	USR0323	VST003529	RT00438	1	t
LOG0000912	USR0311	VST002409	RT00373	2	t
LOG0000913	USR0388	VST004861	RT00306	4	f
LOG0000914	USR0031	VST001974	RT00985	2	f
LOG0000915	USR0066	VST003949	RT00379	1	f
LOG0000916	USR0206	VST001239	RT00950	2	f
LOG0000917	USR0101	VST002335	RT00218	2	t
LOG0000918	USR0320	VST000768	RT00982	3	t
LOG0000919	USR0031	VST002417	RT00329	3	f
LOG0000920	USR0373	VST004995	RT00865	1	t
LOG0000921	USR0191	VST003546	RT00343	4	f
LOG0000922	USR0066	VST002310	RT00739	3	f
LOG0000923	USR0415	VST004884	RT00724	2	t
LOG0000924	USR0303	VST004207	RT00865	1	f
LOG0000925	USR0235	VST004237	RT00163	4	t
LOG0000926	USR0278	VST000745	RT00878	3	f
LOG0000927	USR0202	VST002583	RT00158	1	t
LOG0000928	USR0500	VST004175	RT00110	4	f
LOG0000929	USR0350	VST001518	RT00567	1	t
LOG0000930	USR0225	VST002557	RT00350	4	f
LOG0000931	USR0083	VST004162	RT00726	3	f
LOG0000932	USR0046	VST003984	RT00365	2	f
LOG0000933	USR0089	VST001395	RT00897	2	t
LOG0000934	USR0186	VST000287	RT00015	3	f
LOG0000935	USR0375	VST003248	RT00153	3	f
LOG0000936	USR0189	VST004219	RT00532	3	f
LOG0000937	USR0246	VST002603	RT00967	4	f
LOG0000938	USR0046	VST000004	RT00400	4	f
LOG0000939	USR0257	VST000412	RT00052	4	t
LOG0000940	USR0352	VST004346	RT00855	4	t
LOG0000941	USR0409	VST003728	RT00469	4	t
LOG0000942	USR0061	VST001918	RT00321	4	f
LOG0000943	USR0105	VST001357	RT00879	4	t
LOG0000944	USR0337	VST000158	RT00596	3	f
LOG0000945	USR0014	VST001601	RT00367	4	t
LOG0000946	USR0301	VST002885	RT00979	1	t
LOG0000947	USR0077	VST003490	RT00838	4	t
LOG0000948	USR0230	VST002383	RT00486	2	f
LOG0000949	USR0167	VST000153	RT00736	2	f
LOG0000950	USR0066	VST001630	RT00641	3	f
LOG0000951	USR0032	VST002797	RT00862	2	t
LOG0000952	USR0096	VST002882	RT00894	2	f
LOG0000953	USR0058	VST003803	RT00016	2	f
LOG0000954	USR0104	VST002806	RT00411	3	t
LOG0000955	USR0312	VST004081	RT00274	3	t
LOG0000956	USR0134	VST003471	RT00589	4	f
LOG0000957	USR0217	VST001056	RT00812	2	t
LOG0000958	USR0067	VST002580	RT00306	4	f
LOG0000959	USR0466	VST004149	RT00092	3	t
LOG0000960	USR0178	VST002766	RT00458	4	f
LOG0000961	USR0374	VST001329	RT00270	4	f
LOG0000962	USR0247	VST004045	RT00052	2	t
LOG0000963	USR0294	VST002393	RT00861	3	t
LOG0000964	USR0235	VST003154	RT00121	2	f
LOG0000965	USR0131	VST000001	RT00971	4	t
LOG0000966	USR0112	VST000167	RT00050	3	f
LOG0000967	USR0389	VST003255	RT00891	4	t
LOG0000968	USR0408	VST001886	RT00475	4	f
LOG0000969	USR0054	VST004369	RT00492	2	t
LOG0000970	USR0290	VST000900	RT00785	3	f
LOG0000971	USR0239	VST002249	RT00380	3	t
LOG0000972	USR0240	VST003264	RT00632	2	f
LOG0000973	USR0295	VST003413	RT00387	1	f
LOG0000974	USR0112	VST003578	RT00958	2	t
LOG0000975	USR0088	VST002188	RT00607	2	t
LOG0000976	USR0228	VST001220	RT00661	1	f
LOG0000977	USR0476	VST003133	RT00289	3	f
LOG0000978	USR0304	VST000360	RT00769	1	t
LOG0000979	USR0305	VST002040	RT00454	4	t
LOG0000980	USR0290	VST003938	RT00371	4	f
LOG0000981	USR0208	VST003155	RT00184	2	f
LOG0000982	USR0356	VST000334	RT00772	4	f
LOG0000983	USR0391	VST000731	RT00662	1	t
LOG0000984	USR0274	VST001498	RT00205	4	t
LOG0000985	USR0070	VST001418	RT00954	3	f
LOG0000986	USR0370	VST003764	RT00172	2	t
LOG0000987	USR0220	VST001744	RT00825	2	f
LOG0000988	USR0231	VST004117	RT00222	3	f
LOG0000989	USR0290	VST001974	RT00168	3	t
LOG0000990	USR0307	VST000879	RT00244	2	t
LOG0000991	USR0361	VST004273	RT00218	3	t
LOG0000992	USR0349	VST002885	RT00056	4	f
LOG0000993	USR0255	VST003008	RT00575	4	t
LOG0000994	USR0452	VST002596	RT00615	4	t
LOG0000995	USR0142	VST002298	RT00885	4	t
LOG0000996	USR0069	VST000661	RT00167	1	f
LOG0000997	USR0089	VST003145	RT00519	1	f
LOG0000998	USR0359	VST003163	RT00142	1	f
LOG0000999	USR0136	VST004222	RT00125	1	t
LOG0001000	USR0143	VST003986	RT00090	4	f
LOG0001001	USR0339	VST001270	RT00914	4	f
LOG0001002	USR0187	VST004707	RT00311	3	f
LOG0001003	USR0011	VST001295	RT00371	1	t
LOG0001004	USR0148	VST001010	RT00952	1	f
LOG0001005	USR0439	VST002092	RT00216	2	f
LOG0001006	USR0292	VST001758	RT00441	3	f
LOG0001007	USR0338	VST001965	RT00635	4	t
LOG0001008	USR0398	VST004644	RT00884	3	f
LOG0001009	USR0442	VST001192	RT00186	3	f
LOG0001010	USR0038	VST001054	RT00883	2	f
LOG0001011	USR0345	VST002842	RT00153	2	t
LOG0001012	USR0208	VST002405	RT00761	3	t
LOG0001013	USR0210	VST003563	RT00626	1	f
LOG0001014	USR0001	VST003705	RT00096	4	f
LOG0001015	USR0360	VST001823	RT00710	2	f
LOG0001016	USR0065	VST001272	RT00336	2	t
LOG0001017	USR0001	VST001720	RT00515	4	t
LOG0001018	USR0243	VST000253	RT00149	2	t
LOG0001019	USR0469	VST002769	RT00928	3	t
LOG0001020	USR0381	VST001560	RT00898	4	f
LOG0001021	USR0316	VST000737	RT00623	1	f
LOG0001022	USR0025	VST004996	RT00532	2	t
LOG0001023	USR0347	VST001929	RT00715	2	t
LOG0001024	USR0394	VST002191	RT00883	3	t
LOG0001025	USR0050	VST001003	RT00402	1	f
LOG0001026	USR0396	VST002986	RT00694	2	t
LOG0001027	USR0348	VST001923	RT00331	4	t
LOG0001028	USR0241	VST003753	RT00227	4	t
LOG0001029	USR0032	VST004138	RT00804	3	t
LOG0001030	USR0033	VST003703	RT00358	3	t
LOG0001031	USR0200	VST003193	RT00588	2	f
LOG0001032	USR0234	VST003835	RT00829	3	t
LOG0001033	USR0026	VST004439	RT00316	4	t
LOG0001034	USR0042	VST004428	RT00735	3	f
LOG0001035	USR0434	VST003528	RT00885	4	t
LOG0001036	USR0061	VST000341	RT00036	2	t
LOG0001037	USR0041	VST002389	RT00509	4	t
LOG0001038	USR0441	VST003488	RT00478	3	f
LOG0001039	USR0130	VST001701	RT00428	4	t
LOG0001040	USR0355	VST001234	RT00836	4	f
LOG0001041	USR0354	VST002571	RT00450	1	f
LOG0001042	USR0198	VST002299	RT00812	1	t
LOG0001043	USR0287	VST000138	RT00845	2	f
LOG0001044	USR0151	VST002799	RT00090	4	t
LOG0001045	USR0204	VST002931	RT00541	4	f
LOG0001046	USR0182	VST003921	RT00176	4	f
LOG0001047	USR0371	VST004183	RT00420	1	f
LOG0001048	USR0412	VST001834	RT00732	4	t
LOG0001049	USR0207	VST002140	RT00648	1	t
LOG0001050	USR0147	VST000208	RT00901	2	f
LOG0001051	USR0204	VST002234	RT00864	4	t
LOG0001052	USR0498	VST001851	RT00990	4	f
LOG0001053	USR0048	VST001688	RT00974	3	t
LOG0001054	USR0258	VST002204	RT00687	1	f
LOG0001055	USR0139	VST002209	RT00638	3	t
LOG0001056	USR0172	VST000851	RT00171	2	f
LOG0001057	USR0101	VST002204	RT00394	1	t
LOG0001058	USR0187	VST003691	RT00266	4	t
LOG0001059	USR0384	VST003356	RT00504	4	t
LOG0001060	USR0315	VST002610	RT00134	4	t
LOG0001061	USR0376	VST000224	RT00784	4	t
LOG0001062	USR0294	VST003775	RT00956	2	f
LOG0001063	USR0409	VST001412	RT00026	4	f
LOG0001064	USR0363	VST004393	RT00277	4	t
LOG0001065	USR0021	VST000323	RT00100	4	t
LOG0001066	USR0298	VST001512	RT00442	3	f
LOG0001067	USR0420	VST002087	RT00425	2	t
LOG0001068	USR0393	VST004601	RT00874	1	t
LOG0001069	USR0396	VST002288	RT00030	2	t
LOG0001070	USR0010	VST000687	RT00645	2	t
LOG0001071	USR0187	VST002018	RT00906	2	f
LOG0001072	USR0494	VST001469	RT00496	4	t
LOG0001073	USR0133	VST003924	RT00863	3	f
LOG0001074	USR0033	VST004836	RT00651	3	f
LOG0001075	USR0069	VST000997	RT00998	3	f
LOG0001076	USR0080	VST002535	RT00191	3	f
LOG0001077	USR0191	VST002813	RT00903	1	t
LOG0001078	USR0101	VST000623	RT00187	3	f
LOG0001079	USR0485	VST003825	RT00140	4	t
LOG0001080	USR0285	VST002784	RT00320	4	t
LOG0001081	USR0402	VST004394	RT00891	3	f
LOG0001082	USR0221	VST001076	RT00749	1	f
LOG0001083	USR0390	VST000304	RT00369	3	t
LOG0001084	USR0053	VST000664	RT00297	4	t
LOG0001085	USR0466	VST002947	RT00956	4	f
LOG0001086	USR0160	VST003995	RT00200	4	f
LOG0001087	USR0380	VST001993	RT00796	2	t
LOG0001088	USR0042	VST003496	RT00379	4	f
LOG0001089	USR0047	VST002695	RT00080	3	f
LOG0001090	USR0159	VST004305	RT00447	4	t
LOG0001091	USR0446	VST003199	RT00501	1	t
LOG0001092	USR0184	VST000519	RT00259	2	t
LOG0001093	USR0246	VST004434	RT00613	1	t
LOG0001094	USR0011	VST001870	RT00544	4	t
LOG0001095	USR0154	VST003811	RT00789	2	t
LOG0001096	USR0220	VST000913	RT00121	2	f
LOG0001097	USR0155	VST003935	RT00055	2	t
LOG0001098	USR0339	VST004903	RT00493	4	t
LOG0001099	USR0441	VST003189	RT00018	1	t
LOG0001100	USR0365	VST001316	RT00309	4	f
LOG0001101	USR0283	VST003229	RT00880	2	f
LOG0001102	USR0187	VST000572	RT00633	4	t
LOG0001103	USR0062	VST003256	RT00110	2	t
LOG0001104	USR0148	VST002472	RT00331	2	f
LOG0001105	USR0387	VST000098	RT00573	2	f
LOG0001106	USR0144	VST004034	RT00946	4	t
LOG0001107	USR0103	VST001640	RT00264	4	f
LOG0001108	USR0300	VST004843	RT00268	2	f
LOG0001109	USR0093	VST004028	RT00435	3	f
LOG0001110	USR0463	VST000261	RT00450	1	t
LOG0001111	USR0286	VST000936	RT00297	2	f
LOG0001112	USR0424	VST001798	RT00918	2	f
LOG0001113	USR0119	VST000332	RT00639	2	t
LOG0001114	USR0497	VST004211	RT00137	2	f
LOG0001115	USR0449	VST000268	RT00590	2	f
LOG0001116	USR0029	VST002060	RT00719	3	f
LOG0001117	USR0030	VST000073	RT00907	4	t
LOG0001118	USR0360	VST002922	RT00397	3	t
LOG0001119	USR0366	VST002454	RT00184	2	t
LOG0001120	USR0288	VST003889	RT00412	2	f
LOG0001121	USR0138	VST000178	RT00601	2	f
LOG0001122	USR0475	VST002000	RT00320	4	f
LOG0001123	USR0051	VST000772	RT00741	1	t
LOG0001124	USR0392	VST000946	RT00576	1	t
LOG0001125	USR0435	VST004496	RT00326	3	f
LOG0001126	USR0292	VST000270	RT00567	3	t
LOG0001127	USR0234	VST001856	RT00805	1	t
LOG0001128	USR0055	VST001656	RT00417	2	f
LOG0001129	USR0419	VST003753	RT00793	4	f
LOG0001130	USR0292	VST002534	RT00882	3	t
LOG0001131	USR0240	VST004155	RT00791	4	t
LOG0001132	USR0312	VST002690	RT00700	2	t
LOG0001133	USR0036	VST004983	RT00952	2	f
LOG0001134	USR0089	VST004362	RT00703	3	t
LOG0001135	USR0212	VST002123	RT00904	1	f
LOG0001136	USR0445	VST003162	RT00785	1	t
LOG0001137	USR0318	VST000505	RT00607	1	t
LOG0001138	USR0500	VST002405	RT00090	2	f
LOG0001139	USR0365	VST002202	RT00759	2	f
LOG0001140	USR0245	VST003290	RT00441	4	t
LOG0001141	USR0465	VST004582	RT00075	4	t
LOG0001142	USR0087	VST001154	RT00574	4	f
LOG0001143	USR0409	VST004162	RT00734	2	t
LOG0001144	USR0240	VST002428	RT00267	1	f
LOG0001145	USR0320	VST001337	RT00963	2	f
LOG0001146	USR0188	VST000407	RT00936	4	t
LOG0001147	USR0057	VST003479	RT00936	4	f
LOG0001148	USR0113	VST004045	RT00633	4	f
LOG0001149	USR0223	VST000277	RT00312	4	t
LOG0001150	USR0070	VST003481	RT00821	3	t
LOG0001151	USR0227	VST002362	RT00853	4	t
LOG0001152	USR0256	VST002597	RT00483	2	t
LOG0001153	USR0180	VST001969	RT00028	3	t
LOG0001154	USR0184	VST000461	RT00342	1	t
LOG0001155	USR0191	VST002447	RT00426	2	t
LOG0001156	USR0452	VST003740	RT00883	2	t
LOG0001157	USR0232	VST001583	RT00814	1	t
LOG0001158	USR0276	VST003518	RT00786	2	f
LOG0001159	USR0233	VST004803	RT00535	3	t
LOG0001160	USR0054	VST004199	RT00410	1	f
LOG0001161	USR0257	VST002376	RT00611	3	t
LOG0001162	USR0493	VST002740	RT00285	4	t
LOG0001163	USR0090	VST000972	RT00820	1	f
LOG0001164	USR0226	VST001326	RT00622	3	f
LOG0001165	USR0247	VST000153	RT00715	4	f
LOG0001166	USR0394	VST003609	RT00106	3	f
LOG0001167	USR0151	VST003961	RT00504	3	t
LOG0001168	USR0435	VST003107	RT00046	2	t
LOG0001169	USR0113	VST003087	RT00769	4	t
LOG0001170	USR0408	VST000730	RT00447	2	t
LOG0001171	USR0269	VST003968	RT00144	4	t
LOG0001172	USR0157	VST004170	RT00537	4	t
LOG0001173	USR0442	VST004952	RT00062	2	f
LOG0001174	USR0366	VST004003	RT00742	2	t
LOG0001175	USR0347	VST002333	RT00082	2	f
LOG0001176	USR0351	VST001574	RT00336	4	t
LOG0001177	USR0299	VST003269	RT00211	4	t
LOG0001178	USR0394	VST004376	RT00400	4	f
LOG0001179	USR0159	VST004883	RT00709	4	t
LOG0001180	USR0487	VST000686	RT00347	4	t
LOG0001181	USR0330	VST003889	RT00198	4	f
LOG0001182	USR0472	VST001580	RT00377	3	f
LOG0001183	USR0225	VST000969	RT00162	2	t
LOG0001184	USR0014	VST003738	RT00208	4	f
LOG0001185	USR0355	VST002034	RT00821	3	f
LOG0001186	USR0109	VST000768	RT00919	1	f
LOG0001187	USR0418	VST000646	RT00427	3	t
LOG0001188	USR0401	VST004122	RT00044	2	f
LOG0001189	USR0405	VST001080	RT00800	1	t
LOG0001190	USR0096	VST000637	RT00491	4	f
LOG0001191	USR0195	VST004326	RT00279	2	f
LOG0001192	USR0058	VST002101	RT00916	1	f
LOG0001193	USR0463	VST000101	RT00787	3	f
LOG0001194	USR0392	VST003918	RT00733	1	t
LOG0001195	USR0352	VST004900	RT00968	2	t
LOG0001196	USR0294	VST000869	RT00797	1	t
LOG0001197	USR0154	VST004098	RT00146	3	f
LOG0001198	USR0064	VST000022	RT00069	1	f
LOG0001199	USR0158	VST002626	RT00652	3	f
LOG0001200	USR0265	VST001904	RT00522	1	t
LOG0001201	USR0121	VST002577	RT00111	3	f
LOG0001202	USR0288	VST004110	RT00549	3	f
LOG0001203	USR0011	VST004615	RT00593	3	t
LOG0001204	USR0214	VST003294	RT00608	4	f
LOG0001205	USR0162	VST001936	RT00055	3	t
LOG0001206	USR0105	VST000616	RT00644	2	t
LOG0001207	USR0402	VST002451	RT00223	3	t
LOG0001208	USR0147	VST003585	RT00896	4	f
LOG0001209	USR0182	VST000287	RT00575	4	f
LOG0001210	USR0338	VST003319	RT00986	2	f
LOG0001211	USR0037	VST001924	RT00524	3	t
LOG0001212	USR0082	VST004922	RT00146	4	f
LOG0001213	USR0012	VST002774	RT00264	4	t
LOG0001214	USR0004	VST002091	RT00544	1	t
LOG0001215	USR0495	VST002802	RT00468	1	f
LOG0001216	USR0043	VST000993	RT00561	2	f
LOG0001217	USR0411	VST001585	RT00872	1	t
LOG0001218	USR0051	VST001904	RT00959	3	t
LOG0001219	USR0261	VST000876	RT00973	1	f
LOG0001220	USR0134	VST004830	RT00187	4	f
LOG0001221	USR0461	VST001886	RT00343	2	t
LOG0001222	USR0087	VST000144	RT00963	1	t
LOG0001223	USR0362	VST002257	RT00099	2	f
LOG0001224	USR0056	VST001123	RT00679	3	t
LOG0001225	USR0217	VST000700	RT00306	3	f
LOG0001226	USR0366	VST004210	RT00725	1	f
LOG0001227	USR0068	VST000271	RT00199	1	t
LOG0001228	USR0500	VST000063	RT00758	1	t
LOG0001229	USR0352	VST001008	RT00154	4	f
LOG0001230	USR0044	VST002844	RT00919	3	t
LOG0001231	USR0143	VST002273	RT00096	4	f
LOG0001232	USR0346	VST001983	RT00575	1	t
LOG0001233	USR0042	VST002429	RT00706	3	t
LOG0001234	USR0139	VST003725	RT00935	4	t
LOG0001235	USR0073	VST004414	RT00834	4	t
LOG0001236	USR0267	VST002756	RT00359	2	f
LOG0001237	USR0194	VST003735	RT00814	4	f
LOG0001238	USR0493	VST001293	RT00399	1	f
LOG0001239	USR0155	VST004510	RT00784	1	t
LOG0001240	USR0246	VST004321	RT00376	4	f
LOG0001241	USR0314	VST001178	RT00602	2	t
LOG0001242	USR0218	VST004717	RT00328	2	t
LOG0001243	USR0456	VST002621	RT00272	2	f
LOG0001244	USR0384	VST002537	RT00597	4	f
LOG0001245	USR0253	VST001969	RT00295	4	t
LOG0001246	USR0277	VST001196	RT00395	2	t
LOG0001247	USR0277	VST002832	RT00472	4	t
LOG0001248	USR0072	VST000508	RT00548	3	t
LOG0001249	USR0129	VST000405	RT00018	1	t
LOG0001250	USR0358	VST001295	RT00919	4	t
LOG0001251	USR0186	VST003626	RT00077	3	f
LOG0001252	USR0013	VST002820	RT00049	4	f
LOG0001253	USR0329	VST004760	RT00498	3	t
LOG0001254	USR0220	VST003638	RT00426	2	f
LOG0001255	USR0006	VST001874	RT00871	1	f
LOG0001256	USR0239	VST001407	RT00748	4	f
LOG0001257	USR0471	VST003584	RT00556	3	f
LOG0001258	USR0112	VST001578	RT00621	3	f
LOG0001259	USR0228	VST004377	RT00129	2	f
LOG0001260	USR0442	VST003428	RT00519	1	f
LOG0001261	USR0017	VST000637	RT00304	1	f
LOG0001262	USR0073	VST000808	RT00112	1	t
LOG0001263	USR0012	VST002396	RT00725	3	f
LOG0001264	USR0086	VST004525	RT00912	4	t
LOG0001265	USR0499	VST001416	RT00816	4	f
LOG0001266	USR0180	VST002450	RT00974	2	t
LOG0001267	USR0122	VST004761	RT00939	1	t
LOG0001268	USR0204	VST004846	RT00819	4	f
LOG0001269	USR0070	VST003497	RT00363	3	t
LOG0001270	USR0108	VST003589	RT00066	3	f
LOG0001271	USR0201	VST004030	RT00031	1	f
LOG0001272	USR0052	VST004733	RT00295	2	f
LOG0001273	USR0037	VST000515	RT00777	2	f
LOG0001274	USR0117	VST003295	RT00809	1	t
LOG0001275	USR0259	VST002909	RT00319	3	f
LOG0001276	USR0482	VST002499	RT00014	2	t
LOG0001277	USR0264	VST001367	RT00570	3	t
LOG0001278	USR0394	VST000341	RT00970	3	f
LOG0001279	USR0303	VST003973	RT00856	4	t
LOG0001280	USR0425	VST001561	RT00242	2	t
LOG0001281	USR0064	VST002469	RT00353	3	t
LOG0001282	USR0042	VST002429	RT00248	4	f
LOG0001283	USR0043	VST003689	RT00610	3	t
LOG0001284	USR0125	VST002696	RT00468	1	f
LOG0001285	USR0393	VST002028	RT00960	2	f
LOG0001286	USR0270	VST003753	RT00924	3	f
LOG0001287	USR0485	VST000316	RT00388	2	f
LOG0001288	USR0347	VST003990	RT00674	4	t
LOG0001289	USR0233	VST001102	RT00900	2	t
LOG0001290	USR0480	VST000531	RT00759	3	t
LOG0001291	USR0132	VST002403	RT00838	2	f
LOG0001292	USR0002	VST001860	RT00442	1	f
LOG0001293	USR0115	VST004758	RT00342	1	f
LOG0001294	USR0481	VST001220	RT00516	4	t
LOG0001295	USR0469	VST004223	RT00818	3	f
LOG0001296	USR0001	VST004445	RT00773	2	t
LOG0001297	USR0492	VST001767	RT00843	4	t
LOG0001298	USR0331	VST001068	RT00045	4	f
LOG0001299	USR0065	VST000728	RT00419	3	f
LOG0001300	USR0430	VST000244	RT00723	2	t
LOG0001301	USR0443	VST001786	RT00756	4	t
LOG0001302	USR0459	VST000712	RT00203	4	f
LOG0001303	USR0125	VST002894	RT00715	3	f
LOG0001304	USR0256	VST003151	RT00885	3	f
LOG0001305	USR0391	VST004182	RT00539	4	f
LOG0001306	USR0322	VST001509	RT00386	2	t
LOG0001307	USR0143	VST000271	RT00950	4	f
LOG0001308	USR0328	VST001798	RT00630	1	t
LOG0001309	USR0246	VST002561	RT00968	3	f
LOG0001310	USR0116	VST003561	RT00738	1	f
LOG0001311	USR0377	VST004004	RT00360	2	t
LOG0001312	USR0303	VST002178	RT00468	3	f
LOG0001313	USR0090	VST000838	RT00983	2	t
LOG0001314	USR0296	VST002818	RT00975	1	f
LOG0001315	USR0042	VST003715	RT00944	2	t
LOG0001316	USR0435	VST003079	RT00205	3	t
LOG0001317	USR0035	VST002900	RT00247	1	t
LOG0001318	USR0500	VST001777	RT00991	3	f
LOG0001319	USR0494	VST001651	RT00049	1	t
LOG0001320	USR0489	VST002949	RT00366	4	t
LOG0001321	USR0041	VST002521	RT00253	2	f
LOG0001322	USR0341	VST002386	RT00078	2	t
LOG0001323	USR0124	VST004415	RT00769	3	t
LOG0001324	USR0057	VST002769	RT00632	4	f
LOG0001325	USR0294	VST004239	RT00987	3	f
LOG0001326	USR0456	VST002705	RT00417	3	f
LOG0001327	USR0235	VST001173	RT00035	1	t
LOG0001328	USR0096	VST002519	RT00438	4	t
LOG0001329	USR0392	VST000363	RT00312	1	t
LOG0001330	USR0492	VST000650	RT00143	3	f
LOG0001331	USR0458	VST002257	RT00197	1	f
LOG0001332	USR0319	VST003137	RT00997	1	t
LOG0001333	USR0343	VST004645	RT00260	2	t
LOG0001334	USR0132	VST001136	RT00366	4	f
LOG0001335	USR0176	VST004359	RT00596	2	t
LOG0001336	USR0052	VST003148	RT00192	4	t
LOG0001337	USR0038	VST004862	RT00487	2	f
LOG0001338	USR0478	VST000876	RT00534	3	t
LOG0001339	USR0489	VST003743	RT00024	2	f
LOG0001340	USR0343	VST003852	RT00943	4	t
LOG0001341	USR0005	VST001153	RT00075	4	t
LOG0001342	USR0213	VST001923	RT00878	4	t
LOG0001343	USR0120	VST000629	RT00646	2	t
LOG0001344	USR0326	VST003020	RT00923	1	f
LOG0001345	USR0369	VST001725	RT00394	2	f
LOG0001346	USR0209	VST004749	RT00679	1	t
LOG0001347	USR0217	VST001129	RT00458	2	t
LOG0001348	USR0024	VST004562	RT00110	3	t
LOG0001349	USR0342	VST000764	RT00090	3	f
LOG0001350	USR0205	VST001020	RT00037	2	t
LOG0001351	USR0401	VST003974	RT00822	2	f
LOG0001352	USR0462	VST003928	RT00993	2	f
LOG0001353	USR0226	VST002842	RT00563	3	t
LOG0001354	USR0218	VST002948	RT00572	1	f
LOG0001355	USR0211	VST000675	RT00584	4	f
LOG0001356	USR0026	VST001009	RT00640	1	f
LOG0001357	USR0252	VST001227	RT00307	2	f
LOG0001358	USR0003	VST001636	RT00062	3	f
LOG0001359	USR0002	VST004377	RT00305	4	f
LOG0001360	USR0092	VST000324	RT00179	1	f
LOG0001361	USR0002	VST002839	RT00540	2	f
LOG0001362	USR0150	VST003811	RT00752	3	f
LOG0001363	USR0071	VST001686	RT00932	3	f
LOG0001364	USR0004	VST003713	RT00744	4	f
LOG0001365	USR0497	VST000542	RT00665	1	t
LOG0001366	USR0038	VST002945	RT00932	3	f
LOG0001367	USR0359	VST001328	RT00845	2	t
LOG0001368	USR0468	VST000639	RT00444	2	t
LOG0001369	USR0070	VST004532	RT00519	4	t
LOG0001370	USR0201	VST002261	RT00577	1	t
LOG0001371	USR0308	VST001430	RT00969	3	f
LOG0001372	USR0252	VST002866	RT00635	4	f
LOG0001373	USR0287	VST000962	RT00988	1	f
LOG0001374	USR0410	VST002963	RT00036	1	t
LOG0001375	USR0292	VST002469	RT00750	3	f
LOG0001376	USR0154	VST003229	RT00478	4	t
LOG0001377	USR0412	VST000129	RT00073	4	t
LOG0001378	USR0133	VST004400	RT00030	4	t
LOG0001379	USR0371	VST003967	RT00739	4	t
LOG0001380	USR0074	VST000917	RT00303	1	f
LOG0001381	USR0274	VST001251	RT00347	4	t
LOG0001382	USR0271	VST002199	RT00797	4	f
LOG0001383	USR0185	VST004689	RT00511	3	f
LOG0001384	USR0353	VST004074	RT00517	2	t
LOG0001385	USR0005	VST003788	RT00065	1	f
LOG0001386	USR0293	VST000940	RT00747	3	t
LOG0001387	USR0360	VST002279	RT00627	3	t
LOG0001388	USR0086	VST001002	RT00453	3	f
LOG0001389	USR0214	VST003773	RT00831	1	f
LOG0001390	USR0406	VST002213	RT00758	2	f
LOG0001391	USR0436	VST001611	RT00861	1	f
LOG0001392	USR0015	VST001628	RT00952	4	f
LOG0001393	USR0273	VST003138	RT00529	2	t
LOG0001394	USR0051	VST003992	RT00895	1	f
LOG0001395	USR0253	VST001104	RT00819	1	f
LOG0001396	USR0045	VST002188	RT00369	4	t
LOG0001397	USR0191	VST004226	RT00037	1	t
LOG0001398	USR0122	VST003033	RT00856	2	t
LOG0001399	USR0412	VST002814	RT00884	3	f
LOG0001400	USR0187	VST002494	RT00381	1	t
LOG0001401	USR0214	VST003904	RT00219	1	t
LOG0001402	USR0149	VST000029	RT00649	2	t
LOG0001403	USR0170	VST004060	RT00246	1	f
LOG0001404	USR0209	VST001261	RT00550	3	f
LOG0001405	USR0453	VST003671	RT00251	4	t
LOG0001406	USR0082	VST004895	RT00565	4	f
LOG0001407	USR0401	VST003511	RT00909	4	f
LOG0001408	USR0196	VST002337	RT00346	3	f
LOG0001409	USR0246	VST003324	RT00821	4	t
LOG0001410	USR0391	VST000100	RT00715	2	t
LOG0001411	USR0345	VST003657	RT00887	2	t
LOG0001412	USR0357	VST004518	RT00472	3	t
LOG0001413	USR0040	VST000694	RT00887	3	t
LOG0001414	USR0168	VST004802	RT00993	3	f
LOG0001415	USR0043	VST000018	RT00561	2	f
LOG0001416	USR0329	VST003710	RT00122	3	t
LOG0001417	USR0211	VST002771	RT00326	3	f
LOG0001418	USR0179	VST001031	RT00931	4	t
LOG0001419	USR0457	VST004476	RT00528	3	f
LOG0001420	USR0023	VST004210	RT00781	1	f
LOG0001421	USR0095	VST001620	RT00748	4	t
LOG0001422	USR0160	VST000851	RT00121	2	t
LOG0001423	USR0244	VST001897	RT00139	2	f
LOG0001424	USR0415	VST000976	RT00087	2	f
LOG0001425	USR0017	VST002517	RT00130	4	t
LOG0001426	USR0112	VST004189	RT00252	2	f
LOG0001427	USR0103	VST001516	RT00862	4	t
LOG0001428	USR0314	VST001126	RT00787	4	t
LOG0001429	USR0086	VST000493	RT00360	1	t
LOG0001430	USR0035	VST003037	RT00813	1	f
LOG0001431	USR0030	VST002527	RT00430	1	t
LOG0001432	USR0192	VST000167	RT00047	1	t
LOG0001433	USR0437	VST004236	RT00945	1	t
LOG0001434	USR0179	VST004190	RT00591	2	t
LOG0001435	USR0104	VST000576	RT00501	2	f
LOG0001436	USR0165	VST000606	RT00810	2	t
LOG0001437	USR0474	VST003344	RT00929	1	t
LOG0001438	USR0122	VST001819	RT00876	3	f
LOG0001439	USR0134	VST001156	RT00425	2	t
LOG0001440	USR0290	VST004680	RT00375	2	t
LOG0001441	USR0312	VST000816	RT00965	3	t
LOG0001442	USR0224	VST002641	RT00854	1	t
LOG0001443	USR0025	VST001536	RT00731	4	f
LOG0001444	USR0371	VST002734	RT00111	3	f
LOG0001445	USR0013	VST000963	RT00227	3	f
LOG0001446	USR0319	VST003035	RT00787	2	f
LOG0001447	USR0230	VST002048	RT00768	2	f
LOG0001448	USR0102	VST004542	RT00039	1	f
LOG0001449	USR0450	VST003861	RT00135	4	t
LOG0001450	USR0378	VST001515	RT00295	4	f
LOG0001451	USR0376	VST003352	RT00610	3	t
LOG0001452	USR0389	VST001068	RT00034	1	t
LOG0001453	USR0203	VST000882	RT00987	4	f
LOG0001454	USR0267	VST003640	RT00428	3	t
LOG0001455	USR0472	VST001550	RT00965	2	t
LOG0001456	USR0462	VST002738	RT00068	4	t
LOG0001457	USR0365	VST004558	RT00703	3	f
LOG0001458	USR0222	VST000101	RT00199	4	t
LOG0001459	USR0104	VST003533	RT00560	1	f
LOG0001460	USR0111	VST002817	RT00259	3	f
LOG0001461	USR0428	VST000408	RT00725	1	t
LOG0001462	USR0483	VST002516	RT00674	3	f
LOG0001463	USR0469	VST001740	RT00625	2	t
LOG0001464	USR0069	VST004053	RT00137	4	f
LOG0001465	USR0358	VST000259	RT00829	2	f
LOG0001466	USR0258	VST000509	RT00916	1	f
LOG0001467	USR0168	VST003822	RT00936	4	f
LOG0001468	USR0293	VST004405	RT00381	2	t
LOG0001469	USR0374	VST003684	RT00524	3	f
LOG0001470	USR0049	VST004721	RT00871	3	t
LOG0001471	USR0250	VST003727	RT00238	2	t
LOG0001472	USR0482	VST000679	RT00284	4	t
LOG0001473	USR0331	VST001284	RT00688	1	t
LOG0001474	USR0420	VST004838	RT00737	3	f
LOG0001475	USR0075	VST000907	RT00458	1	f
LOG0001476	USR0201	VST000268	RT00587	4	t
LOG0001477	USR0454	VST003104	RT00135	4	t
LOG0001478	USR0034	VST004907	RT00082	3	t
LOG0001479	USR0314	VST001201	RT00595	1	f
LOG0001480	USR0111	VST001117	RT00654	4	f
LOG0001481	USR0421	VST000899	RT00209	1	t
LOG0001482	USR0352	VST002791	RT00727	3	f
LOG0001483	USR0316	VST002645	RT00403	3	f
LOG0001484	USR0396	VST001059	RT00822	4	f
LOG0001485	USR0237	VST000688	RT00767	4	f
LOG0001486	USR0032	VST000788	RT00188	1	t
LOG0001487	USR0209	VST004495	RT00493	4	f
LOG0001488	USR0132	VST002645	RT00759	3	t
LOG0001489	USR0106	VST002165	RT00255	4	t
LOG0001490	USR0033	VST004458	RT00323	2	f
LOG0001491	USR0043	VST000204	RT00674	3	t
LOG0001492	USR0368	VST003218	RT00857	1	f
LOG0001493	USR0107	VST002492	RT00425	4	f
LOG0001494	USR0265	VST004823	RT00415	4	t
LOG0001495	USR0226	VST002039	RT00167	3	t
LOG0001496	USR0487	VST003369	RT00590	3	f
LOG0001497	USR0179	VST003559	RT00485	1	t
LOG0001498	USR0222	VST004058	RT00436	3	t
LOG0001499	USR0370	VST004863	RT00687	1	f
LOG0001500	USR0125	VST001227	RT00532	4	f
LOG0001501	USR0276	VST004491	RT00608	1	t
LOG0001502	USR0167	VST004344	RT00481	1	t
LOG0001503	USR0151	VST003512	RT00180	1	f
LOG0001504	USR0041	VST000914	RT00607	4	f
LOG0001505	USR0300	VST001420	RT00071	2	f
LOG0001506	USR0381	VST002704	RT00702	2	f
LOG0001507	USR0035	VST000356	RT00901	1	t
LOG0001508	USR0407	VST003473	RT00441	3	f
LOG0001509	USR0314	VST000241	RT00644	2	f
LOG0001510	USR0304	VST001911	RT00139	4	f
LOG0001511	USR0231	VST002277	RT00787	1	f
LOG0001512	USR0215	VST000621	RT00102	2	f
LOG0001513	USR0314	VST000855	RT00468	4	f
LOG0001514	USR0101	VST003744	RT00283	1	f
LOG0001515	USR0057	VST002315	RT00029	2	t
LOG0001516	USR0215	VST003201	RT00018	1	f
LOG0001517	USR0423	VST003625	RT00933	2	f
LOG0001518	USR0156	VST001061	RT00957	2	t
LOG0001519	USR0064	VST000382	RT00756	3	t
LOG0001520	USR0062	VST001133	RT00687	2	t
LOG0001521	USR0339	VST002477	RT00508	3	t
LOG0001522	USR0369	VST003136	RT00601	4	f
LOG0001523	USR0368	VST002839	RT00020	2	t
LOG0001524	USR0062	VST002080	RT00326	1	t
LOG0001525	USR0094	VST000945	RT00356	3	t
LOG0001526	USR0469	VST003963	RT00433	2	f
LOG0001527	USR0472	VST004202	RT00399	3	f
LOG0001528	USR0341	VST002530	RT00018	1	f
LOG0001529	USR0026	VST004302	RT00550	1	t
LOG0001530	USR0435	VST003319	RT00376	1	f
LOG0001531	USR0121	VST000835	RT00601	4	f
LOG0001532	USR0050	VST003751	RT00340	4	f
LOG0001533	USR0371	VST004185	RT00150	1	t
LOG0001534	USR0252	VST003388	RT00716	4	f
LOG0001535	USR0036	VST004992	RT00233	4	f
LOG0001536	USR0410	VST004239	RT00104	4	t
LOG0001537	USR0289	VST000207	RT00956	4	f
LOG0001538	USR0379	VST003535	RT00623	4	t
LOG0001539	USR0100	VST002053	RT00737	4	f
LOG0001540	USR0324	VST004307	RT00221	1	t
LOG0001541	USR0329	VST000029	RT00962	4	f
LOG0001542	USR0136	VST001214	RT00026	4	t
LOG0001543	USR0194	VST000188	RT00064	3	t
LOG0001544	USR0221	VST001861	RT00254	3	t
LOG0001545	USR0279	VST002573	RT00249	4	t
LOG0001546	USR0326	VST004015	RT00736	2	f
LOG0001547	USR0055	VST004253	RT00826	2	t
LOG0001548	USR0427	VST002128	RT00131	4	t
LOG0001549	USR0484	VST001892	RT00030	1	f
LOG0001550	USR0110	VST002708	RT00787	1	t
LOG0001551	USR0149	VST001742	RT00010	3	t
LOG0001552	USR0406	VST002674	RT00089	1	t
LOG0001553	USR0265	VST001814	RT00430	1	f
LOG0001554	USR0162	VST004328	RT00147	1	f
LOG0001555	USR0187	VST000160	RT00127	4	f
LOG0001556	USR0410	VST000344	RT00698	4	f
LOG0001557	USR0129	VST000205	RT00124	2	t
LOG0001558	USR0484	VST003043	RT00619	3	t
LOG0001559	USR0108	VST002886	RT00341	2	f
LOG0001560	USR0389	VST000305	RT00518	1	t
LOG0001561	USR0425	VST002718	RT00051	1	f
LOG0001562	USR0447	VST003942	RT00398	2	t
LOG0001563	USR0406	VST000400	RT00314	2	f
LOG0001564	USR0068	VST003521	RT00648	4	f
LOG0001565	USR0432	VST000986	RT00514	4	f
LOG0001566	USR0066	VST001806	RT00502	3	f
LOG0001567	USR0144	VST002097	RT00530	4	t
LOG0001568	USR0464	VST004302	RT00761	1	f
LOG0001569	USR0053	VST001460	RT00982	1	f
LOG0001570	USR0128	VST001346	RT00697	2	t
LOG0001571	USR0470	VST000231	RT00734	3	f
LOG0001572	USR0491	VST003783	RT00740	4	f
LOG0001573	USR0321	VST003501	RT00860	3	t
LOG0001574	USR0207	VST000883	RT00419	1	t
LOG0001575	USR0320	VST002774	RT00194	1	f
LOG0001576	USR0216	VST002332	RT00312	4	t
LOG0001577	USR0068	VST000433	RT00996	4	f
LOG0001578	USR0447	VST001209	RT00722	4	f
LOG0001579	USR0062	VST002681	RT00299	2	t
LOG0001580	USR0210	VST002264	RT00329	1	f
LOG0001581	USR0337	VST003003	RT00476	2	t
LOG0001582	USR0327	VST002413	RT00584	1	t
LOG0001583	USR0370	VST001818	RT00117	4	t
LOG0001584	USR0429	VST000618	RT00264	1	f
LOG0001585	USR0052	VST004493	RT00517	1	f
LOG0001586	USR0116	VST002506	RT00781	3	t
LOG0001587	USR0381	VST000318	RT00519	1	t
LOG0001588	USR0458	VST000457	RT00021	1	t
LOG0001589	USR0383	VST000501	RT00477	3	t
LOG0001590	USR0065	VST004419	RT00549	4	f
LOG0001591	USR0130	VST002316	RT00173	3	f
LOG0001592	USR0177	VST003875	RT00948	4	t
LOG0001593	USR0278	VST004974	RT00944	4	f
LOG0001594	USR0480	VST004775	RT00062	4	t
LOG0001595	USR0413	VST001004	RT00206	1	t
LOG0001596	USR0163	VST004251	RT00613	3	f
LOG0001597	USR0465	VST004197	RT00631	3	t
LOG0001598	USR0332	VST001067	RT00179	3	t
LOG0001599	USR0152	VST004717	RT00644	3	f
LOG0001600	USR0350	VST001629	RT00888	2	t
LOG0001601	USR0236	VST003235	RT00342	1	t
LOG0001602	USR0158	VST002282	RT00440	2	f
LOG0001603	USR0468	VST004499	RT00075	1	f
LOG0001604	USR0426	VST002399	RT00290	3	f
LOG0001605	USR0327	VST003239	RT00557	2	f
LOG0001606	USR0106	VST004355	RT00144	4	f
LOG0001607	USR0306	VST003670	RT00649	3	t
LOG0001608	USR0255	VST004716	RT00208	3	t
LOG0001609	USR0358	VST001466	RT00743	4	f
LOG0001610	USR0455	VST001962	RT00272	3	f
LOG0001611	USR0444	VST000876	RT00607	1	f
LOG0001612	USR0113	VST004070	RT00415	3	f
LOG0001613	USR0030	VST003902	RT00397	1	f
LOG0001614	USR0012	VST000543	RT00384	1	t
LOG0001615	USR0177	VST003517	RT00261	3	f
LOG0001616	USR0479	VST003866	RT00891	4	f
LOG0001617	USR0338	VST004549	RT00639	1	t
LOG0001618	USR0046	VST004500	RT00943	2	f
LOG0001619	USR0171	VST001019	RT00167	1	t
LOG0001620	USR0130	VST001429	RT00018	4	f
LOG0001621	USR0245	VST004979	RT00660	3	t
LOG0001622	USR0353	VST000575	RT00247	4	f
LOG0001623	USR0203	VST001459	RT00642	4	f
LOG0001624	USR0226	VST001500	RT00296	3	t
LOG0001625	USR0080	VST001492	RT00414	2	t
LOG0001626	USR0310	VST003173	RT00778	2	f
LOG0001627	USR0035	VST002471	RT00320	1	t
LOG0001628	USR0052	VST003428	RT00554	1	f
LOG0001629	USR0161	VST002516	RT00715	2	t
LOG0001630	USR0469	VST003552	RT00693	3	t
LOG0001631	USR0084	VST004207	RT00861	4	f
LOG0001632	USR0328	VST002201	RT00181	3	f
LOG0001633	USR0435	VST002965	RT00296	4	t
LOG0001634	USR0026	VST003314	RT00656	4	f
LOG0001635	USR0225	VST002928	RT00944	2	t
LOG0001636	USR0446	VST000682	RT00893	2	f
LOG0001637	USR0317	VST004865	RT00061	3	f
LOG0001638	USR0154	VST000279	RT00988	4	t
LOG0001639	USR0293	VST004459	RT00209	3	f
LOG0001640	USR0414	VST001649	RT00166	1	t
LOG0001641	USR0095	VST004697	RT00882	2	t
LOG0001642	USR0225	VST001159	RT00300	2	f
LOG0001643	USR0267	VST002342	RT00655	4	f
LOG0001644	USR0437	VST001519	RT00351	2	t
LOG0001645	USR0041	VST001839	RT00061	3	t
LOG0001646	USR0133	VST000871	RT00263	4	t
LOG0001647	USR0066	VST003278	RT00124	4	t
LOG0001648	USR0397	VST001342	RT00238	1	t
LOG0001649	USR0447	VST002307	RT00542	3	f
LOG0001650	USR0210	VST001172	RT00932	4	t
LOG0001651	USR0474	VST004073	RT00767	2	t
LOG0001652	USR0153	VST001129	RT00881	2	t
LOG0001653	USR0172	VST003628	RT00090	4	t
LOG0001654	USR0398	VST004000	RT00139	2	t
LOG0001655	USR0325	VST003888	RT00891	4	t
LOG0001656	USR0059	VST001285	RT00966	4	t
LOG0001657	USR0184	VST000571	RT00362	4	t
LOG0001658	USR0490	VST002865	RT00413	2	t
LOG0001659	USR0180	VST003985	RT00860	2	t
LOG0001660	USR0322	VST003142	RT00719	3	f
LOG0001661	USR0324	VST001978	RT00093	1	f
LOG0001662	USR0012	VST000447	RT00134	2	f
LOG0001663	USR0459	VST004879	RT00880	4	t
LOG0001664	USR0068	VST001281	RT00204	2	t
LOG0001665	USR0427	VST000637	RT00819	2	t
LOG0001666	USR0329	VST002974	RT00848	4	t
LOG0001667	USR0202	VST004627	RT00622	3	t
LOG0001668	USR0475	VST000119	RT00038	4	f
LOG0001669	USR0006	VST004162	RT00457	3	t
LOG0001670	USR0015	VST002293	RT00534	2	t
LOG0001671	USR0042	VST002105	RT00737	4	t
LOG0001672	USR0031	VST001068	RT00858	2	t
LOG0001673	USR0470	VST000424	RT00438	4	t
LOG0001674	USR0181	VST003820	RT00680	2	t
LOG0001675	USR0262	VST004491	RT00647	2	f
LOG0001676	USR0289	VST001281	RT00622	2	t
LOG0001677	USR0413	VST001820	RT00224	4	f
LOG0001678	USR0021	VST003433	RT00168	3	t
LOG0001679	USR0380	VST000763	RT00107	2	t
LOG0001680	USR0182	VST001630	RT00380	4	t
LOG0001681	USR0184	VST000443	RT00024	4	f
LOG0001682	USR0244	VST003015	RT00511	2	t
LOG0001683	USR0350	VST002582	RT00809	2	f
LOG0001684	USR0149	VST001498	RT00307	3	t
LOG0001685	USR0256	VST004253	RT00935	2	t
LOG0001686	USR0100	VST000089	RT00358	3	t
LOG0001687	USR0055	VST002250	RT00370	1	t
LOG0001688	USR0186	VST000980	RT00997	4	f
LOG0001689	USR0320	VST000462	RT00723	3	t
LOG0001690	USR0086	VST003553	RT00171	2	f
LOG0001691	USR0174	VST002757	RT00581	3	f
LOG0001692	USR0468	VST003629	RT00222	2	t
LOG0001693	USR0022	VST002502	RT00443	3	f
LOG0001694	USR0244	VST000380	RT00153	4	f
LOG0001695	USR0060	VST004497	RT00862	3	t
LOG0001696	USR0104	VST004647	RT00376	1	f
LOG0001697	USR0139	VST002984	RT00281	4	f
LOG0001698	USR0303	VST003061	RT00713	3	t
LOG0001699	USR0159	VST002951	RT00219	1	t
LOG0001700	USR0499	VST004541	RT00920	1	f
LOG0001701	USR0232	VST003731	RT00958	3	f
LOG0001702	USR0077	VST004425	RT00616	4	f
LOG0001703	USR0018	VST001932	RT00811	3	f
LOG0001704	USR0022	VST003422	RT00827	4	f
LOG0001705	USR0184	VST001991	RT00822	4	t
LOG0001706	USR0145	VST004866	RT00486	3	f
LOG0001707	USR0038	VST003857	RT00510	1	f
LOG0001708	USR0281	VST001483	RT00335	4	t
LOG0001709	USR0288	VST002546	RT00742	2	t
LOG0001710	USR0143	VST004221	RT00410	2	f
LOG0001711	USR0013	VST004300	RT00054	1	t
LOG0001712	USR0186	VST002816	RT00701	1	f
LOG0001713	USR0474	VST000643	RT00734	3	t
LOG0001714	USR0434	VST004686	RT00075	4	t
LOG0001715	USR0267	VST003919	RT00349	3	t
LOG0001716	USR0269	VST001587	RT00975	2	t
LOG0001717	USR0097	VST002410	RT00684	2	t
LOG0001718	USR0434	VST003850	RT00393	4	f
LOG0001719	USR0357	VST000055	RT00554	4	f
LOG0001720	USR0294	VST000842	RT00157	2	t
LOG0001721	USR0001	VST004588	RT00847	3	t
LOG0001722	USR0295	VST000985	RT00081	4	t
LOG0001723	USR0027	VST002621	RT00208	3	t
LOG0001724	USR0036	VST002907	RT00826	4	f
LOG0001725	USR0160	VST001995	RT00086	1	t
LOG0001726	USR0425	VST001933	RT00744	3	t
LOG0001727	USR0399	VST002273	RT00447	2	f
LOG0001728	USR0031	VST000103	RT00177	1	t
LOG0001729	USR0127	VST000970	RT00511	3	f
LOG0001730	USR0262	VST001072	RT00619	4	t
LOG0001731	USR0345	VST000737	RT00139	2	t
LOG0001732	USR0497	VST001366	RT00102	4	f
LOG0001733	USR0436	VST003631	RT00473	3	t
LOG0001734	USR0210	VST000228	RT00822	1	f
LOG0001735	USR0150	VST003571	RT00542	3	f
LOG0001736	USR0031	VST000445	RT00194	2	f
LOG0001737	USR0100	VST001620	RT00833	1	f
LOG0001738	USR0329	VST004694	RT00756	2	t
LOG0001739	USR0302	VST002205	RT00486	4	t
LOG0001740	USR0451	VST002704	RT00314	1	f
LOG0001741	USR0353	VST003051	RT00697	3	f
LOG0001742	USR0219	VST003503	RT00805	4	f
LOG0001743	USR0253	VST003627	RT00247	4	f
LOG0001744	USR0171	VST001182	RT00630	3	f
LOG0001745	USR0257	VST003257	RT00438	4	t
LOG0001746	USR0428	VST000798	RT00073	2	t
LOG0001747	USR0057	VST000835	RT00069	3	f
LOG0001748	USR0009	VST003000	RT00754	4	t
LOG0001749	USR0005	VST002033	RT00152	1	t
LOG0001750	USR0335	VST004453	RT00831	3	f
LOG0001751	USR0114	VST002765	RT00987	3	t
LOG0001752	USR0265	VST002410	RT00094	4	f
LOG0001753	USR0173	VST003685	RT00435	3	f
LOG0001754	USR0220	VST003276	RT00783	3	t
LOG0001755	USR0205	VST000008	RT00431	3	t
LOG0001756	USR0024	VST002520	RT00457	3	f
LOG0001757	USR0493	VST002220	RT00430	3	t
LOG0001758	USR0458	VST003875	RT00229	3	f
LOG0001759	USR0170	VST003729	RT00030	2	f
LOG0001760	USR0406	VST003330	RT00625	4	f
LOG0001761	USR0103	VST003372	RT00335	2	f
LOG0001762	USR0060	VST000614	RT00660	4	f
LOG0001763	USR0086	VST000689	RT00569	3	f
LOG0001764	USR0255	VST000898	RT00177	4	f
LOG0001765	USR0165	VST000110	RT00824	2	t
LOG0001766	USR0372	VST004806	RT00568	4	t
LOG0001767	USR0167	VST003013	RT00409	3	f
LOG0001768	USR0084	VST002919	RT00777	3	t
LOG0001769	USR0458	VST001161	RT00237	3	t
LOG0001770	USR0202	VST003982	RT00278	2	f
LOG0001771	USR0090	VST003611	RT00077	1	f
LOG0001772	USR0089	VST004745	RT00933	3	t
LOG0001773	USR0437	VST002004	RT00636	3	f
LOG0001774	USR0120	VST001528	RT00540	4	t
LOG0001775	USR0156	VST001914	RT00654	1	f
LOG0001776	USR0461	VST004342	RT00158	4	f
LOG0001777	USR0399	VST003182	RT00167	2	f
LOG0001778	USR0188	VST004894	RT00185	1	f
LOG0001779	USR0188	VST003347	RT00389	3	t
LOG0001780	USR0262	VST002864	RT00012	1	f
LOG0001781	USR0052	VST004611	RT00931	3	f
LOG0001782	USR0140	VST000506	RT00169	2	f
LOG0001783	USR0019	VST004251	RT00831	4	t
LOG0001784	USR0480	VST002007	RT00426	2	t
LOG0001785	USR0075	VST004207	RT00893	2	f
LOG0001786	USR0230	VST002856	RT00449	3	f
LOG0001787	USR0481	VST003965	RT00494	4	f
LOG0001788	USR0130	VST001675	RT00449	2	f
LOG0001789	USR0055	VST001191	RT00106	1	t
LOG0001790	USR0271	VST002393	RT00766	2	t
LOG0001791	USR0448	VST001922	RT00427	3	f
LOG0001792	USR0100	VST004390	RT00956	1	f
LOG0001793	USR0069	VST002693	RT00916	1	t
LOG0001794	USR0399	VST004434	RT00098	4	f
LOG0001795	USR0299	VST001828	RT00631	1	f
LOG0001796	USR0458	VST002500	RT00226	1	t
LOG0001797	USR0017	VST000717	RT00447	3	f
LOG0001798	USR0354	VST000631	RT00887	4	t
LOG0001799	USR0116	VST004861	RT00664	2	f
LOG0001800	USR0152	VST000085	RT00476	1	f
LOG0001801	USR0330	VST003769	RT00203	2	t
LOG0001802	USR0116	VST000737	RT00968	2	t
LOG0001803	USR0030	VST002708	RT00675	2	t
LOG0001804	USR0323	VST000227	RT00297	4	t
LOG0001805	USR0051	VST003358	RT00634	2	t
LOG0001806	USR0060	VST001308	RT00016	3	t
LOG0001807	USR0229	VST004205	RT00378	4	f
LOG0001808	USR0259	VST004231	RT00336	4	f
LOG0001809	USR0360	VST004387	RT00618	4	t
LOG0001810	USR0005	VST003959	RT00774	4	f
LOG0001811	USR0028	VST001653	RT00020	1	f
LOG0001812	USR0254	VST001868	RT00440	1	t
LOG0001813	USR0364	VST000027	RT00244	2	f
LOG0001814	USR0462	VST004650	RT00244	1	t
LOG0001815	USR0231	VST000933	RT00971	4	t
LOG0001816	USR0395	VST003459	RT00392	2	t
LOG0001817	USR0456	VST000467	RT00724	3	t
LOG0001818	USR0357	VST002701	RT00736	1	t
LOG0001819	USR0200	VST001499	RT00865	4	t
LOG0001820	USR0332	VST000618	RT00262	2	t
LOG0001821	USR0271	VST003778	RT00220	1	t
LOG0001822	USR0339	VST004554	RT00008	4	f
LOG0001823	USR0304	VST002688	RT00446	2	t
LOG0001824	USR0383	VST001505	RT00014	1	f
LOG0001825	USR0046	VST003968	RT00387	3	t
LOG0001826	USR0028	VST000180	RT00642	1	f
LOG0001827	USR0007	VST002586	RT00022	4	t
LOG0001828	USR0232	VST002070	RT00225	4	t
LOG0001829	USR0199	VST004859	RT00235	3	f
LOG0001830	USR0094	VST000922	RT00341	3	f
LOG0001831	USR0082	VST003093	RT00966	2	t
LOG0001832	USR0088	VST004841	RT01000	2	t
LOG0001833	USR0390	VST001511	RT00711	4	f
LOG0001834	USR0186	VST003600	RT00134	1	t
LOG0001835	USR0243	VST003277	RT00178	3	f
LOG0001836	USR0068	VST002720	RT00556	2	t
LOG0001837	USR0311	VST004733	RT00520	4	t
LOG0001838	USR0451	VST001024	RT00792	4	f
LOG0001839	USR0433	VST000152	RT00539	4	t
LOG0001840	USR0374	VST000013	RT00437	3	t
LOG0001841	USR0435	VST000715	RT00051	3	t
LOG0001842	USR0187	VST003151	RT00924	3	f
LOG0001843	USR0239	VST003626	RT00443	1	t
LOG0001844	USR0390	VST000249	RT00581	3	f
LOG0001845	USR0218	VST001145	RT00979	4	f
LOG0001846	USR0108	VST004483	RT00969	3	f
LOG0001847	USR0307	VST004535	RT00281	1	f
LOG0001848	USR0038	VST003344	RT00044	1	t
LOG0001849	USR0395	VST000721	RT00687	4	f
LOG0001850	USR0436	VST004569	RT00631	2	f
LOG0001851	USR0349	VST003230	RT00365	3	t
LOG0001852	USR0276	VST001007	RT00888	3	t
LOG0001853	USR0010	VST004729	RT00269	1	f
LOG0001854	USR0026	VST003299	RT00693	1	f
LOG0001855	USR0048	VST002469	RT00565	2	t
LOG0001856	USR0347	VST004120	RT00293	1	t
LOG0001857	USR0370	VST003814	RT00703	1	t
LOG0001858	USR0014	VST000538	RT00194	1	f
LOG0001859	USR0100	VST002825	RT00371	1	f
LOG0001860	USR0187	VST002686	RT00552	2	f
LOG0001861	USR0012	VST001981	RT00078	3	t
LOG0001862	USR0372	VST000540	RT00189	3	f
LOG0001863	USR0379	VST003885	RT00607	3	f
LOG0001864	USR0279	VST004054	RT00390	3	t
LOG0001865	USR0341	VST003200	RT00025	3	f
LOG0001866	USR0328	VST004517	RT00615	4	t
LOG0001867	USR0167	VST000484	RT00302	4	t
LOG0001868	USR0122	VST001029	RT00671	1	t
LOG0001869	USR0393	VST000052	RT00358	4	t
LOG0001870	USR0472	VST000243	RT00720	3	f
LOG0001871	USR0095	VST001687	RT00959	1	f
LOG0001872	USR0025	VST002822	RT00859	3	t
LOG0001873	USR0017	VST001841	RT00094	3	f
LOG0001874	USR0426	VST000425	RT00836	1	f
LOG0001875	USR0029	VST002128	RT00551	3	t
LOG0001876	USR0444	VST000695	RT00336	4	f
LOG0001877	USR0323	VST000354	RT00164	1	t
LOG0001878	USR0341	VST003691	RT00903	2	f
LOG0001879	USR0313	VST001690	RT00341	2	f
LOG0001880	USR0072	VST000293	RT00834	2	t
LOG0001881	USR0270	VST000717	RT00567	3	t
LOG0001882	USR0250	VST004625	RT00072	3	t
LOG0001883	USR0295	VST004576	RT00042	3	f
LOG0001884	USR0144	VST004573	RT00411	3	f
LOG0001885	USR0274	VST004121	RT00898	1	f
LOG0001886	USR0223	VST002479	RT00838	2	t
LOG0001887	USR0075	VST002365	RT00644	4	f
LOG0001888	USR0102	VST000638	RT00021	1	t
LOG0001889	USR0020	VST002406	RT00001	2	t
LOG0001890	USR0117	VST001300	RT00678	2	t
LOG0001891	USR0174	VST003949	RT00572	1	f
LOG0001892	USR0373	VST000690	RT00076	1	t
LOG0001893	USR0173	VST004440	RT00603	1	f
LOG0001894	USR0004	VST002607	RT00398	4	t
LOG0001895	USR0340	VST000712	RT00719	2	t
LOG0001896	USR0479	VST002611	RT00088	4	f
LOG0001897	USR0148	VST000439	RT00594	4	t
LOG0001898	USR0395	VST003534	RT00017	4	f
LOG0001899	USR0114	VST003879	RT00329	4	t
LOG0001900	USR0321	VST003342	RT00943	4	f
LOG0001901	USR0492	VST003093	RT00210	1	t
LOG0001902	USR0402	VST004239	RT00824	4	t
LOG0001903	USR0167	VST001784	RT00383	3	t
LOG0001904	USR0300	VST000868	RT00565	1	f
LOG0001905	USR0481	VST001489	RT00640	2	t
LOG0001906	USR0118	VST000468	RT00146	2	t
LOG0001907	USR0100	VST004973	RT00453	1	f
LOG0001908	USR0274	VST003922	RT00816	4	f
LOG0001909	USR0175	VST001418	RT00393	1	f
LOG0001910	USR0159	VST001777	RT00310	2	f
LOG0001911	USR0384	VST001082	RT00931	2	t
LOG0001912	USR0227	VST004937	RT00492	1	t
LOG0001913	USR0423	VST002926	RT00760	3	t
LOG0001914	USR0038	VST004085	RT00430	3	t
LOG0001915	USR0463	VST004062	RT00001	3	t
LOG0001916	USR0431	VST001012	RT00041	2	f
LOG0001917	USR0198	VST000814	RT00585	3	t
LOG0001918	USR0136	VST003947	RT00672	3	f
LOG0001919	USR0104	VST002317	RT00212	1	t
LOG0001920	USR0470	VST002144	RT00333	4	t
LOG0001921	USR0193	VST000273	RT00808	4	f
LOG0001922	USR0250	VST003645	RT00651	1	f
LOG0001923	USR0013	VST001717	RT00446	4	t
LOG0001924	USR0055	VST002976	RT00942	3	t
LOG0001925	USR0344	VST004101	RT00304	2	t
LOG0001926	USR0085	VST000357	RT00555	3	f
LOG0001927	USR0109	VST000204	RT00691	1	t
LOG0001928	USR0043	VST003746	RT00701	4	f
LOG0001929	USR0388	VST001597	RT00758	1	f
LOG0001930	USR0071	VST000497	RT00810	1	f
LOG0001931	USR0444	VST004798	RT00154	3	f
LOG0001932	USR0268	VST004933	RT00616	4	f
LOG0001933	USR0059	VST000063	RT00523	2	f
LOG0001934	USR0461	VST001580	RT00025	3	f
LOG0001935	USR0438	VST004335	RT00808	1	t
LOG0001936	USR0044	VST000540	RT00025	1	f
LOG0001937	USR0272	VST004294	RT00596	4	f
LOG0001938	USR0390	VST004877	RT00106	1	t
LOG0001939	USR0014	VST004126	RT00753	1	t
LOG0001940	USR0371	VST002714	RT00119	3	f
LOG0001941	USR0112	VST001081	RT00971	4	t
LOG0001942	USR0379	VST001856	RT00108	3	t
LOG0001943	USR0314	VST003505	RT00330	2	f
LOG0001944	USR0415	VST003380	RT00180	1	t
LOG0001945	USR0228	VST001599	RT00881	3	f
LOG0001946	USR0485	VST001629	RT00131	3	t
LOG0001947	USR0169	VST003179	RT00807	4	f
LOG0001948	USR0376	VST002648	RT00603	1	t
LOG0001949	USR0291	VST003373	RT00931	3	f
LOG0001950	USR0246	VST001070	RT00753	1	f
LOG0001951	USR0266	VST002777	RT00759	2	f
LOG0001952	USR0337	VST001193	RT00168	1	f
LOG0001953	USR0243	VST000814	RT00223	1	t
LOG0001954	USR0490	VST001153	RT00469	3	f
LOG0001955	USR0158	VST002756	RT00278	4	t
LOG0001956	USR0300	VST001884	RT00190	4	t
LOG0001957	USR0439	VST000268	RT00531	4	f
LOG0001958	USR0327	VST003672	RT00526	2	f
LOG0001959	USR0018	VST002813	RT00997	2	t
LOG0001960	USR0083	VST004681	RT00755	3	t
LOG0001961	USR0335	VST004086	RT00621	4	f
LOG0001962	USR0231	VST000384	RT00946	2	f
LOG0001963	USR0492	VST003957	RT00190	4	f
LOG0001964	USR0342	VST002851	RT00983	4	f
LOG0001965	USR0253	VST004526	RT00218	2	t
LOG0001966	USR0167	VST003412	RT00299	4	f
LOG0001967	USR0042	VST001050	RT00311	1	f
LOG0001968	USR0249	VST001834	RT00236	3	t
LOG0001969	USR0248	VST000798	RT00168	2	f
LOG0001970	USR0438	VST004468	RT00780	2	t
LOG0001971	USR0380	VST002976	RT00193	4	f
LOG0001972	USR0286	VST001291	RT00242	2	f
LOG0001973	USR0020	VST002188	RT00162	1	f
LOG0001974	USR0382	VST000067	RT00876	4	t
LOG0001975	USR0352	VST001393	RT00339	1	f
LOG0001976	USR0381	VST003992	RT00791	3	t
LOG0001977	USR0042	VST003022	RT00455	3	f
LOG0001978	USR0345	VST001702	RT00135	1	f
LOG0001979	USR0087	VST000579	RT00193	4	f
LOG0001980	USR0261	VST001606	RT00402	3	t
LOG0001981	USR0306	VST004044	RT00392	4	f
LOG0001982	USR0297	VST001979	RT00601	4	f
LOG0001983	USR0350	VST004506	RT00042	3	f
LOG0001984	USR0240	VST002881	RT00093	3	t
LOG0001985	USR0167	VST002671	RT00215	1	t
LOG0001986	USR0313	VST003717	RT00349	4	f
LOG0001987	USR0219	VST004936	RT00513	1	t
LOG0001988	USR0441	VST004285	RT00335	2	t
LOG0001989	USR0490	VST004373	RT00399	2	f
LOG0001990	USR0421	VST002155	RT00924	2	t
LOG0001991	USR0391	VST002805	RT00164	2	t
LOG0001992	USR0133	VST002221	RT00106	3	t
LOG0001993	USR0207	VST003990	RT00232	3	t
LOG0001994	USR0051	VST000999	RT00992	1	f
LOG0001995	USR0106	VST000722	RT00558	3	t
LOG0001996	USR0392	VST001215	RT00717	3	f
LOG0001997	USR0184	VST001694	RT00533	3	f
LOG0001998	USR0201	VST003395	RT00177	2	f
LOG0001999	USR0011	VST004026	RT00679	1	f
LOG0002000	USR0254	VST003580	RT00294	4	t
LOG0002001	USR0150	VST002804	RT00265	4	t
LOG0002002	USR0354	VST002231	RT00788	4	f
LOG0002003	USR0355	VST004813	RT00852	2	t
LOG0002004	USR0461	VST000459	RT00520	3	t
LOG0002005	USR0395	VST001702	RT00270	3	f
LOG0002006	USR0444	VST000627	RT00830	4	f
LOG0002007	USR0096	VST002457	RT00212	4	f
LOG0002008	USR0106	VST000207	RT00163	1	t
LOG0002009	USR0143	VST003317	RT00823	2	f
LOG0002010	USR0166	VST001357	RT00557	3	f
LOG0002011	USR0001	VST004769	RT00917	4	t
LOG0002012	USR0046	VST003597	RT00745	4	f
LOG0002013	USR0242	VST001940	RT00053	1	t
LOG0002014	USR0344	VST002796	RT00233	3	t
LOG0002015	USR0427	VST004369	RT00438	3	f
LOG0002016	USR0488	VST002674	RT00854	1	f
LOG0002017	USR0278	VST001050	RT00683	1	f
LOG0002018	USR0003	VST002592	RT00518	3	f
LOG0002019	USR0142	VST003790	RT00951	1	t
LOG0002020	USR0386	VST004005	RT00044	4	f
LOG0002021	USR0061	VST000091	RT00603	3	f
LOG0002022	USR0416	VST000476	RT00708	2	t
LOG0002023	USR0496	VST002047	RT00516	3	f
LOG0002024	USR0294	VST004822	RT00633	1	f
LOG0002025	USR0225	VST003691	RT00575	2	t
LOG0002026	USR0302	VST004026	RT00092	4	f
LOG0002027	USR0170	VST003267	RT00759	4	t
LOG0002028	USR0134	VST004630	RT00731	4	f
LOG0002029	USR0041	VST002746	RT00954	1	f
LOG0002030	USR0231	VST000085	RT00438	3	t
LOG0002031	USR0409	VST002640	RT00337	1	t
LOG0002032	USR0226	VST004937	RT00743	3	f
LOG0002033	USR0139	VST000077	RT00294	1	f
LOG0002034	USR0110	VST002431	RT00700	4	t
LOG0002035	USR0485	VST003505	RT00820	1	f
LOG0002036	USR0297	VST002425	RT00925	3	f
LOG0002037	USR0455	VST002222	RT00680	4	f
LOG0002038	USR0057	VST000406	RT00967	4	f
LOG0002039	USR0430	VST002130	RT00264	2	f
LOG0002040	USR0123	VST004117	RT00105	3	f
LOG0002041	USR0240	VST000398	RT00993	2	t
LOG0002042	USR0086	VST001801	RT00224	2	f
LOG0002043	USR0176	VST003474	RT00419	2	f
LOG0002044	USR0063	VST001809	RT00978	4	f
LOG0002045	USR0039	VST004990	RT00115	2	f
LOG0002046	USR0138	VST003927	RT00891	3	t
LOG0002047	USR0469	VST001945	RT00235	3	f
LOG0002048	USR0454	VST000438	RT00784	2	f
LOG0002049	USR0241	VST000223	RT00274	2	f
LOG0002050	USR0449	VST001611	RT00955	2	t
LOG0002051	USR0226	VST001961	RT00230	2	f
LOG0002052	USR0443	VST004605	RT00729	2	f
LOG0002053	USR0206	VST004001	RT00034	2	t
LOG0002054	USR0164	VST002665	RT00388	1	t
LOG0002055	USR0027	VST001066	RT00709	4	t
LOG0002056	USR0457	VST001277	RT00501	4	t
LOG0002057	USR0183	VST000604	RT00895	4	t
LOG0002058	USR0198	VST000189	RT00462	2	f
LOG0002059	USR0479	VST000676	RT00449	1	f
LOG0002060	USR0337	VST000638	RT00829	4	f
LOG0002061	USR0437	VST001997	RT00214	3	t
LOG0002062	USR0107	VST001845	RT00046	4	t
LOG0002063	USR0444	VST000047	RT00405	4	f
LOG0002064	USR0189	VST000820	RT00333	4	t
LOG0002065	USR0036	VST003808	RT00240	4	t
LOG0002066	USR0085	VST003023	RT00254	3	t
LOG0002067	USR0155	VST001081	RT00228	2	f
LOG0002068	USR0169	VST003147	RT00733	3	t
LOG0002069	USR0284	VST001278	RT00891	3	f
LOG0002070	USR0272	VST003735	RT00166	2	f
LOG0002071	USR0035	VST002218	RT00585	3	t
LOG0002072	USR0420	VST002887	RT00737	3	f
LOG0002073	USR0184	VST000796	RT00511	4	t
LOG0002074	USR0099	VST003329	RT00598	4	t
LOG0002075	USR0237	VST003007	RT00593	2	f
LOG0002076	USR0403	VST003185	RT00956	4	t
LOG0002077	USR0441	VST002390	RT00727	2	f
LOG0002078	USR0469	VST004144	RT00676	2	t
LOG0002079	USR0122	VST003859	RT00390	1	f
LOG0002080	USR0417	VST001219	RT00752	2	f
LOG0002081	USR0023	VST001761	RT00423	3	t
LOG0002082	USR0375	VST000725	RT00925	2	f
LOG0002083	USR0063	VST001345	RT00411	1	f
LOG0002084	USR0326	VST000138	RT00581	3	f
LOG0002085	USR0480	VST004451	RT00649	1	t
LOG0002086	USR0150	VST004907	RT00664	4	f
LOG0002087	USR0195	VST003555	RT00447	3	t
LOG0002088	USR0483	VST002760	RT00403	2	t
LOG0002089	USR0080	VST000059	RT00097	1	f
LOG0002090	USR0490	VST000771	RT00379	2	t
LOG0002091	USR0315	VST000389	RT00670	4	t
LOG0002092	USR0153	VST003925	RT00186	3	f
LOG0002093	USR0017	VST003423	RT00680	2	t
LOG0002094	USR0039	VST004435	RT00244	4	t
LOG0002095	USR0333	VST004853	RT00631	2	t
LOG0002096	USR0348	VST000596	RT00708	3	f
LOG0002097	USR0459	VST000436	RT00503	4	t
LOG0002098	USR0202	VST001474	RT00288	4	f
LOG0002099	USR0423	VST004473	RT00369	1	f
LOG0002100	USR0280	VST001983	RT00065	3	f
LOG0002101	USR0422	VST002439	RT00162	4	f
LOG0002102	USR0088	VST002869	RT00597	3	t
LOG0002103	USR0481	VST004210	RT00927	2	f
LOG0002104	USR0465	VST003818	RT00571	3	t
LOG0002105	USR0441	VST000774	RT00974	1	t
LOG0002106	USR0300	VST001927	RT00794	3	f
LOG0002107	USR0292	VST002220	RT00662	3	f
LOG0002108	USR0355	VST000018	RT00418	2	t
LOG0002109	USR0070	VST004331	RT00481	1	f
LOG0002110	USR0378	VST003967	RT00633	2	f
LOG0002111	USR0124	VST001693	RT00269	4	f
LOG0002112	USR0080	VST002771	RT00767	2	t
LOG0002113	USR0045	VST004377	RT00736	1	t
LOG0002114	USR0476	VST004927	RT00567	1	t
LOG0002115	USR0233	VST003268	RT00648	3	t
LOG0002116	USR0480	VST001139	RT00190	1	f
LOG0002117	USR0154	VST001696	RT00406	2	t
LOG0002118	USR0395	VST001587	RT00765	1	t
LOG0002119	USR0180	VST004514	RT00489	4	t
LOG0002120	USR0409	VST002332	RT00312	1	t
LOG0002121	USR0031	VST004681	RT00596	1	t
LOG0002122	USR0085	VST002670	RT00917	2	f
LOG0002123	USR0045	VST002269	RT00866	3	t
LOG0002124	USR0371	VST002057	RT00689	3	f
LOG0002125	USR0323	VST004928	RT00094	2	t
LOG0002126	USR0332	VST002423	RT00390	3	t
LOG0002127	USR0243	VST004630	RT00547	4	f
LOG0002128	USR0040	VST003487	RT00411	4	t
LOG0002129	USR0430	VST002750	RT00212	3	f
LOG0002130	USR0182	VST004042	RT00638	2	t
LOG0002131	USR0297	VST002825	RT00369	2	f
LOG0002132	USR0473	VST001406	RT00742	3	t
LOG0002133	USR0376	VST001887	RT00168	1	f
LOG0002134	USR0081	VST002988	RT00014	3	t
LOG0002135	USR0038	VST003576	RT00586	4	f
LOG0002136	USR0356	VST004543	RT00564	4	t
LOG0002137	USR0420	VST002728	RT00874	1	t
LOG0002138	USR0467	VST004721	RT00207	4	f
LOG0002139	USR0428	VST001864	RT00808	2	f
LOG0002140	USR0057	VST002354	RT00043	1	f
LOG0002141	USR0322	VST002897	RT00880	1	f
LOG0002142	USR0465	VST004828	RT00442	1	t
LOG0002143	USR0030	VST002502	RT00515	2	f
LOG0002144	USR0495	VST000938	RT00911	4	f
LOG0002145	USR0266	VST002081	RT00941	3	t
LOG0002146	USR0227	VST001756	RT00607	4	f
LOG0002147	USR0317	VST003391	RT00395	3	f
LOG0002148	USR0447	VST001217	RT00238	1	f
LOG0002149	USR0500	VST001204	RT00679	3	t
LOG0002150	USR0292	VST001891	RT00531	4	f
LOG0002151	USR0054	VST003032	RT00719	2	t
LOG0002152	USR0097	VST000391	RT00742	4	t
LOG0002153	USR0449	VST002512	RT00404	2	t
LOG0002154	USR0466	VST002978	RT00214	2	t
LOG0002155	USR0004	VST003747	RT00967	2	t
LOG0002156	USR0439	VST000099	RT00568	3	t
LOG0002157	USR0310	VST002196	RT00846	1	f
LOG0002158	USR0367	VST004666	RT00374	1	f
LOG0002159	USR0091	VST004823	RT00132	1	f
LOG0002160	USR0089	VST001002	RT00009	2	t
LOG0002161	USR0320	VST001571	RT00743	3	f
LOG0002162	USR0375	VST004399	RT00153	3	t
LOG0002163	USR0092	VST003630	RT00431	3	t
LOG0002164	USR0150	VST001064	RT00483	4	f
LOG0002165	USR0234	VST000639	RT00997	3	f
LOG0002166	USR0409	VST002743	RT00305	3	f
LOG0002167	USR0337	VST001143	RT00923	3	f
LOG0002168	USR0059	VST002121	RT00284	1	f
LOG0002169	USR0185	VST000552	RT00472	2	t
LOG0002170	USR0438	VST003276	RT00993	4	t
LOG0002171	USR0044	VST000977	RT00993	1	t
LOG0002172	USR0180	VST004192	RT00190	3	f
LOG0002173	USR0076	VST003351	RT00528	2	t
LOG0002174	USR0144	VST003215	RT00512	2	f
LOG0002175	USR0101	VST003548	RT00343	2	t
LOG0002176	USR0381	VST002932	RT00430	2	f
LOG0002177	USR0272	VST004070	RT00715	3	t
LOG0002178	USR0465	VST003986	RT00686	4	t
LOG0002179	USR0055	VST004142	RT00680	3	t
LOG0002180	USR0189	VST000346	RT00851	2	t
LOG0002181	USR0351	VST004943	RT00034	3	f
LOG0002182	USR0335	VST002943	RT00471	2	t
LOG0002183	USR0077	VST001077	RT00394	3	t
LOG0002184	USR0296	VST001172	RT00741	4	t
LOG0002185	USR0219	VST003771	RT00495	2	t
LOG0002186	USR0277	VST003162	RT00513	3	t
LOG0002187	USR0066	VST000233	RT00322	1	f
LOG0002188	USR0136	VST003799	RT00115	4	t
LOG0002189	USR0234	VST004147	RT00214	1	t
LOG0002190	USR0199	VST004761	RT00766	3	t
LOG0002191	USR0266	VST003908	RT00145	4	f
LOG0002192	USR0441	VST003700	RT00559	4	t
LOG0002193	USR0388	VST000451	RT00792	4	f
LOG0002194	USR0043	VST001363	RT00178	3	t
LOG0002195	USR0361	VST000351	RT00725	4	f
LOG0002196	USR0228	VST002697	RT00360	4	f
LOG0002197	USR0227	VST001309	RT00285	1	f
LOG0002198	USR0063	VST004005	RT00245	3	f
LOG0002199	USR0171	VST002926	RT00765	2	f
LOG0002200	USR0451	VST004679	RT00206	3	f
LOG0002201	USR0250	VST000245	RT00584	3	t
LOG0002202	USR0338	VST004646	RT00734	4	t
LOG0002203	USR0250	VST004824	RT00342	1	f
LOG0002204	USR0307	VST004735	RT00727	1	f
LOG0002205	USR0238	VST004680	RT00360	3	t
LOG0002206	USR0056	VST002274	RT00499	2	f
LOG0002207	USR0171	VST000441	RT00141	3	t
LOG0002208	USR0408	VST003546	RT00960	2	f
LOG0002209	USR0480	VST001468	RT00668	2	t
LOG0002210	USR0034	VST000412	RT00222	3	f
LOG0002211	USR0315	VST000814	RT00389	4	f
LOG0002212	USR0130	VST004342	RT00330	4	t
LOG0002213	USR0130	VST004679	RT00743	2	t
LOG0002214	USR0394	VST001731	RT00393	1	f
LOG0002215	USR0151	VST001975	RT00654	4	t
LOG0002216	USR0143	VST000550	RT00358	4	f
LOG0002217	USR0118	VST001938	RT00394	2	f
LOG0002218	USR0204	VST000204	RT00929	2	f
LOG0002219	USR0384	VST004447	RT00587	2	f
LOG0002220	USR0235	VST004415	RT00040	4	t
LOG0002221	USR0017	VST003589	RT00902	4	f
LOG0002222	USR0082	VST002537	RT00273	1	f
LOG0002223	USR0014	VST000107	RT00420	1	t
LOG0002224	USR0081	VST003812	RT00070	3	t
LOG0002225	USR0207	VST002702	RT00829	2	f
LOG0002226	USR0204	VST003898	RT00623	4	f
LOG0002227	USR0379	VST002220	RT00458	1	f
LOG0002228	USR0272	VST003937	RT00945	2	f
LOG0002229	USR0032	VST004091	RT00234	2	t
LOG0002230	USR0023	VST000958	RT00197	3	f
LOG0002231	USR0102	VST002576	RT00851	2	t
LOG0002232	USR0162	VST002368	RT00711	1	f
LOG0002233	USR0098	VST001061	RT00509	3	t
LOG0002234	USR0144	VST002547	RT00536	4	t
LOG0002235	USR0418	VST003737	RT00819	3	f
LOG0002236	USR0104	VST003767	RT00938	2	t
LOG0002237	USR0382	VST001673	RT00147	2	t
LOG0002238	USR0455	VST000402	RT00574	1	t
LOG0002239	USR0417	VST000602	RT00459	2	t
LOG0002240	USR0324	VST003000	RT00067	4	f
LOG0002241	USR0171	VST004314	RT00030	1	t
LOG0002242	USR0064	VST004282	RT00107	2	f
LOG0002243	USR0244	VST003453	RT00678	4	t
LOG0002244	USR0071	VST003635	RT00390	1	f
LOG0002245	USR0274	VST000288	RT00879	2	f
LOG0002246	USR0452	VST000088	RT00995	4	t
LOG0002247	USR0369	VST002206	RT00406	4	f
LOG0002248	USR0125	VST002968	RT00121	3	t
LOG0002249	USR0383	VST004251	RT00011	1	f
LOG0002250	USR0317	VST003535	RT00584	3	t
LOG0002251	USR0331	VST000220	RT00347	4	t
LOG0002252	USR0107	VST001483	RT00253	3	f
LOG0002253	USR0148	VST003239	RT00797	3	f
LOG0002254	USR0395	VST000322	RT00119	3	t
LOG0002255	USR0463	VST002739	RT00887	1	t
LOG0002256	USR0430	VST004937	RT00520	2	t
LOG0002257	USR0192	VST001837	RT00215	3	t
LOG0002258	USR0337	VST002560	RT00733	2	f
LOG0002259	USR0226	VST001569	RT00080	1	f
LOG0002260	USR0242	VST002323	RT00419	2	f
LOG0002261	USR0496	VST004721	RT00584	1	f
LOG0002262	USR0460	VST002964	RT00712	2	t
LOG0002263	USR0362	VST000353	RT00685	1	t
LOG0002264	USR0284	VST001029	RT00289	4	f
LOG0002265	USR0432	VST004571	RT00234	1	t
LOG0002266	USR0163	VST002010	RT00261	2	t
LOG0002267	USR0008	VST000928	RT00958	3	f
LOG0002268	USR0347	VST000030	RT00933	4	f
LOG0002269	USR0406	VST002541	RT00657	3	f
LOG0002270	USR0377	VST003820	RT00022	2	f
LOG0002271	USR0152	VST000495	RT00078	3	f
LOG0002272	USR0322	VST004484	RT00742	3	f
LOG0002273	USR0095	VST000873	RT00672	1	f
LOG0002274	USR0214	VST000835	RT00014	2	t
LOG0002275	USR0064	VST003325	RT00748	3	t
LOG0002276	USR0065	VST000630	RT00148	3	t
LOG0002277	USR0381	VST002987	RT00662	3	f
LOG0002278	USR0270	VST000030	RT00030	2	f
LOG0002279	USR0025	VST003783	RT00438	4	f
LOG0002280	USR0484	VST000807	RT00673	3	t
LOG0002281	USR0100	VST001969	RT00773	3	f
LOG0002282	USR0105	VST003469	RT00530	4	t
LOG0002283	USR0131	VST003581	RT00063	4	f
LOG0002284	USR0389	VST001961	RT00430	4	t
LOG0002285	USR0321	VST004340	RT00135	3	t
LOG0002286	USR0438	VST000221	RT00157	1	f
LOG0002287	USR0019	VST001344	RT00569	2	f
LOG0002288	USR0225	VST004627	RT00943	3	t
LOG0002289	USR0106	VST002263	RT00777	4	t
LOG0002290	USR0054	VST002415	RT00254	4	f
LOG0002291	USR0478	VST002162	RT00187	4	f
LOG0002292	USR0460	VST004121	RT00880	4	f
LOG0002293	USR0394	VST002982	RT00873	1	f
LOG0002294	USR0226	VST000858	RT00379	2	t
LOG0002295	USR0400	VST004994	RT00327	1	f
LOG0002296	USR0360	VST000773	RT00199	1	t
LOG0002297	USR0430	VST002493	RT00881	2	f
LOG0002298	USR0413	VST000020	RT00171	3	t
LOG0002299	USR0015	VST000806	RT00315	3	f
LOG0002300	USR0048	VST001381	RT00006	1	t
LOG0002301	USR0139	VST002176	RT00878	2	f
LOG0002302	USR0492	VST002406	RT00256	4	f
LOG0002303	USR0034	VST003364	RT00879	2	f
LOG0002304	USR0420	VST003427	RT00821	3	f
LOG0002305	USR0414	VST000881	RT00320	1	t
LOG0002306	USR0355	VST003109	RT01000	4	f
LOG0002307	USR0457	VST001334	RT00248	3	f
LOG0002308	USR0210	VST001685	RT00731	4	f
LOG0002309	USR0019	VST002965	RT00004	2	f
LOG0002310	USR0487	VST001606	RT00513	2	t
LOG0002311	USR0196	VST002558	RT00838	3	f
LOG0002312	USR0326	VST000444	RT00506	3	t
LOG0002313	USR0115	VST002043	RT00031	4	f
LOG0002314	USR0417	VST000779	RT00833	4	f
LOG0002315	USR0352	VST003160	RT00629	2	t
LOG0002316	USR0464	VST001747	RT00965	1	f
LOG0002317	USR0075	VST003941	RT00275	4	f
LOG0002318	USR0150	VST000421	RT00709	2	f
LOG0002319	USR0036	VST001852	RT00886	1	f
LOG0002320	USR0242	VST002109	RT00325	3	f
LOG0002321	USR0151	VST004675	RT00177	3	t
LOG0002322	USR0063	VST003997	RT00287	4	f
LOG0002323	USR0154	VST001359	RT00956	1	f
LOG0002324	USR0188	VST003911	RT00748	2	f
LOG0002325	USR0223	VST002627	RT00967	4	t
LOG0002326	USR0093	VST002688	RT00079	2	t
LOG0002327	USR0005	VST004207	RT00243	1	t
LOG0002328	USR0438	VST000491	RT00823	4	f
LOG0002329	USR0166	VST001296	RT00501	1	f
LOG0002330	USR0446	VST002082	RT00205	1	f
LOG0002331	USR0025	VST003372	RT00460	1	f
LOG0002332	USR0098	VST002173	RT00383	2	f
LOG0002333	USR0268	VST003175	RT00723	3	t
LOG0002334	USR0150	VST004065	RT00333	4	f
LOG0002335	USR0393	VST003754	RT00603	2	t
LOG0002336	USR0252	VST004990	RT00166	1	t
LOG0002337	USR0084	VST003830	RT00161	2	t
LOG0002338	USR0285	VST001950	RT00006	1	f
LOG0002339	USR0172	VST003381	RT00653	1	f
LOG0002340	USR0221	VST000412	RT00205	1	t
LOG0002341	USR0109	VST001423	RT00973	1	t
LOG0002342	USR0027	VST002982	RT00532	2	t
LOG0002343	USR0246	VST001677	RT00100	1	t
LOG0002344	USR0055	VST001647	RT00677	2	t
LOG0002345	USR0465	VST002712	RT00045	2	f
LOG0002346	USR0133	VST003960	RT00457	3	t
LOG0002347	USR0052	VST001240	RT00849	2	t
LOG0002348	USR0493	VST000603	RT00227	3	f
LOG0002349	USR0253	VST001938	RT00315	3	t
LOG0002350	USR0269	VST000026	RT00052	3	t
LOG0002351	USR0298	VST004680	RT00146	2	t
LOG0002352	USR0399	VST001068	RT00281	3	t
LOG0002353	USR0079	VST000380	RT00123	4	f
LOG0002354	USR0018	VST001285	RT00719	1	f
LOG0002355	USR0306	VST004465	RT00471	2	t
LOG0002356	USR0258	VST003183	RT00897	1	t
LOG0002357	USR0343	VST003748	RT00297	2	t
LOG0002358	USR0107	VST002257	RT00614	3	t
LOG0002359	USR0397	VST003928	RT00512	4	f
LOG0002360	USR0491	VST004121	RT00786	3	f
LOG0002361	USR0452	VST000546	RT00641	2	f
LOG0002362	USR0047	VST000275	RT00502	3	t
LOG0002363	USR0246	VST003442	RT00679	4	f
LOG0002364	USR0089	VST002270	RT00202	1	t
LOG0002365	USR0203	VST003109	RT00415	1	t
LOG0002366	USR0434	VST002923	RT00614	3	f
LOG0002367	USR0240	VST003388	RT00583	2	t
LOG0002368	USR0490	VST001871	RT00422	2	f
LOG0002369	USR0268	VST004014	RT00520	1	f
LOG0002370	USR0013	VST000111	RT00674	4	t
LOG0002371	USR0137	VST001756	RT00073	3	f
LOG0002372	USR0315	VST004804	RT00345	3	t
LOG0002373	USR0173	VST001368	RT00027	1	t
LOG0002374	USR0230	VST001529	RT00169	2	f
LOG0002375	USR0198	VST000552	RT00775	3	f
LOG0002376	USR0491	VST000134	RT00800	2	f
LOG0002377	USR0243	VST002912	RT00585	2	f
LOG0002378	USR0043	VST002014	RT00209	1	f
LOG0002379	USR0330	VST003263	RT00611	2	t
LOG0002380	USR0279	VST001061	RT00880	4	t
LOG0002381	USR0079	VST002508	RT00912	4	f
LOG0002382	USR0429	VST002023	RT00898	1	f
LOG0002383	USR0279	VST002187	RT00939	3	f
LOG0002384	USR0232	VST002666	RT00543	2	t
LOG0002385	USR0101	VST003171	RT00848	4	t
LOG0002386	USR0162	VST002728	RT00943	1	t
LOG0002387	USR0144	VST003336	RT00545	1	f
LOG0002388	USR0447	VST002647	RT00725	2	t
LOG0002389	USR0109	VST000596	RT00657	1	f
LOG0002390	USR0435	VST004107	RT00611	3	f
LOG0002391	USR0233	VST002375	RT00822	2	f
LOG0002392	USR0111	VST003422	RT00310	3	t
LOG0002393	USR0416	VST002279	RT00947	4	t
LOG0002394	USR0422	VST001165	RT00180	4	f
LOG0002395	USR0232	VST000618	RT00647	4	f
LOG0002396	USR0440	VST004861	RT00438	4	f
LOG0002397	USR0238	VST004145	RT00477	1	t
LOG0002398	USR0197	VST000451	RT00395	3	t
LOG0002399	USR0273	VST001799	RT00702	1	f
LOG0002400	USR0086	VST004587	RT00542	1	f
LOG0002401	USR0295	VST001893	RT00594	4	f
LOG0002402	USR0041	VST002455	RT00057	3	f
LOG0002403	USR0048	VST002223	RT00174	2	t
LOG0002404	USR0466	VST003809	RT00720	2	t
LOG0002405	USR0412	VST001285	RT00326	2	t
LOG0002406	USR0077	VST002528	RT00322	3	f
LOG0002407	USR0178	VST001758	RT00183	4	t
LOG0002408	USR0490	VST000223	RT00235	4	t
LOG0002409	USR0257	VST004365	RT00619	3	t
LOG0002410	USR0117	VST000901	RT00186	4	f
LOG0002411	USR0434	VST002366	RT00266	3	t
LOG0002412	USR0019	VST004481	RT00644	3	t
LOG0002413	USR0482	VST001610	RT00842	2	f
LOG0002414	USR0059	VST004722	RT00329	2	f
LOG0002415	USR0196	VST003291	RT00830	1	f
LOG0002416	USR0107	VST001224	RT00365	3	f
LOG0002417	USR0451	VST001908	RT00683	2	t
LOG0002418	USR0425	VST001363	RT00810	2	f
LOG0002419	USR0394	VST002752	RT00024	2	t
LOG0002420	USR0284	VST003970	RT00261	4	f
LOG0002421	USR0034	VST001269	RT00355	2	f
LOG0002422	USR0295	VST004938	RT00196	4	t
LOG0002423	USR0495	VST001232	RT00611	2	f
LOG0002424	USR0251	VST004069	RT00490	4	f
LOG0002425	USR0126	VST001748	RT00888	4	t
LOG0002426	USR0339	VST002559	RT00333	2	t
LOG0002427	USR0106	VST000738	RT00613	3	f
LOG0002428	USR0440	VST004437	RT00864	1	f
LOG0002429	USR0180	VST002980	RT00941	1	f
LOG0002430	USR0110	VST001952	RT00955	3	t
LOG0002431	USR0228	VST001782	RT00632	2	t
LOG0002432	USR0121	VST000530	RT00321	3	f
LOG0002433	USR0107	VST004130	RT00447	2	t
LOG0002434	USR0131	VST004419	RT00377	2	t
LOG0002435	USR0023	VST001205	RT00203	2	f
LOG0002436	USR0145	VST001987	RT00090	2	f
LOG0002437	USR0327	VST000347	RT00707	2	f
LOG0002438	USR0154	VST001216	RT00177	3	f
LOG0002439	USR0107	VST002769	RT00627	3	t
LOG0002440	USR0146	VST000245	RT00845	1	f
LOG0002441	USR0252	VST002726	RT00032	2	f
LOG0002442	USR0494	VST003052	RT00880	3	t
LOG0002443	USR0302	VST000133	RT00946	3	t
LOG0002444	USR0070	VST001371	RT00727	2	t
LOG0002445	USR0031	VST002097	RT00954	2	t
LOG0002446	USR0093	VST001088	RT00820	3	t
LOG0002447	USR0137	VST001648	RT00791	2	t
LOG0002448	USR0374	VST001892	RT00243	4	t
LOG0002449	USR0163	VST001721	RT00798	3	f
LOG0002450	USR0081	VST004003	RT00070	1	f
LOG0002451	USR0316	VST002261	RT00071	2	t
LOG0002452	USR0076	VST000119	RT00623	4	f
LOG0002453	USR0063	VST002904	RT00158	1	t
LOG0002454	USR0100	VST002809	RT00549	1	f
LOG0002455	USR0436	VST000895	RT00816	1	t
LOG0002456	USR0048	VST001266	RT00928	2	t
LOG0002457	USR0445	VST000363	RT00326	1	t
LOG0002458	USR0408	VST001774	RT00035	3	t
LOG0002459	USR0074	VST000314	RT00480	3	t
LOG0002460	USR0314	VST001707	RT00460	2	t
LOG0002461	USR0192	VST003466	RT00836	2	f
LOG0002462	USR0030	VST004368	RT00416	1	f
LOG0002463	USR0157	VST001790	RT00571	2	f
LOG0002464	USR0487	VST002394	RT00886	3	f
LOG0002465	USR0266	VST003611	RT00419	3	f
LOG0002466	USR0256	VST003695	RT00511	3	f
LOG0002467	USR0039	VST002281	RT00368	2	t
LOG0002468	USR0055	VST000990	RT00912	3	t
LOG0002469	USR0028	VST003681	RT00887	2	f
LOG0002470	USR0402	VST002464	RT00883	4	t
LOG0002471	USR0425	VST000905	RT00207	1	f
LOG0002472	USR0118	VST003045	RT00361	4	f
LOG0002473	USR0370	VST003398	RT00436	3	t
LOG0002474	USR0209	VST003998	RT00578	1	t
LOG0002475	USR0075	VST004840	RT00774	3	f
LOG0002476	USR0065	VST000911	RT00270	3	t
LOG0002477	USR0337	VST002608	RT00233	4	t
LOG0002478	USR0356	VST001746	RT00669	3	f
LOG0002479	USR0100	VST002124	RT00106	1	f
LOG0002480	USR0046	VST004343	RT00666	3	f
LOG0002481	USR0316	VST001852	RT00018	1	f
LOG0002482	USR0393	VST004672	RT00495	4	t
LOG0002483	USR0429	VST003766	RT00260	2	f
LOG0002484	USR0444	VST001616	RT00485	3	t
LOG0002485	USR0156	VST002391	RT00313	4	t
LOG0002486	USR0240	VST002763	RT00631	3	f
LOG0002487	USR0353	VST001206	RT00821	1	t
LOG0002488	USR0259	VST004027	RT00102	3	f
LOG0002489	USR0435	VST002680	RT00537	2	t
LOG0002490	USR0136	VST002447	RT00943	3	t
LOG0002491	USR0370	VST003313	RT00180	2	t
LOG0002492	USR0198	VST004388	RT00510	2	f
LOG0002493	USR0187	VST002102	RT00477	3	t
LOG0002494	USR0116	VST003217	RT00674	4	f
LOG0002495	USR0445	VST003670	RT00400	3	t
LOG0002496	USR0058	VST003031	RT00997	2	f
LOG0002497	USR0070	VST002525	RT00350	4	t
LOG0002498	USR0093	VST004118	RT00215	2	t
LOG0002499	USR0229	VST003308	RT00383	2	t
LOG0002500	USR0396	VST002743	RT00124	3	f
LOG0002501	USR0137	VST001962	RT00292	1	t
LOG0002502	USR0105	VST004626	RT00668	3	f
LOG0002503	USR0305	VST003622	RT00705	1	t
LOG0002504	USR0339	VST000101	RT00328	1	f
LOG0002505	USR0017	VST001314	RT00565	3	t
LOG0002506	USR0054	VST003449	RT00682	1	t
LOG0002507	USR0112	VST003245	RT00847	2	t
LOG0002508	USR0172	VST001902	RT00098	4	f
LOG0002509	USR0416	VST004675	RT00659	3	f
LOG0002510	USR0419	VST001215	RT00300	1	t
LOG0002511	USR0462	VST003627	RT00030	2	f
LOG0002512	USR0305	VST000790	RT00074	4	f
LOG0002513	USR0438	VST001367	RT00172	1	t
LOG0002514	USR0144	VST003624	RT00885	1	t
LOG0002515	USR0085	VST000503	RT00923	2	t
LOG0002516	USR0012	VST000173	RT00084	4	t
LOG0002517	USR0252	VST000887	RT00985	4	f
LOG0002518	USR0216	VST001418	RT00585	2	f
LOG0002519	USR0126	VST003533	RT00744	4	t
LOG0002520	USR0098	VST004369	RT00290	3	f
LOG0002521	USR0392	VST003430	RT00639	4	f
LOG0002522	USR0492	VST001410	RT00085	1	f
LOG0002523	USR0405	VST002924	RT00254	4	t
LOG0002524	USR0304	VST004954	RT00664	3	t
LOG0002525	USR0392	VST001911	RT00824	3	t
LOG0002526	USR0028	VST000261	RT00519	1	t
LOG0002527	USR0336	VST003353	RT00452	1	t
LOG0002528	USR0266	VST001353	RT00307	3	f
LOG0002529	USR0052	VST001500	RT00648	2	t
LOG0002530	USR0143	VST004374	RT00184	3	t
LOG0002531	USR0132	VST002141	RT00973	4	f
LOG0002532	USR0346	VST003007	RT00314	1	t
LOG0002533	USR0207	VST003619	RT00341	2	f
LOG0002534	USR0484	VST000823	RT00227	3	f
LOG0002535	USR0480	VST000532	RT00837	1	t
LOG0002536	USR0062	VST002821	RT00756	4	f
LOG0002537	USR0363	VST000167	RT00264	2	f
LOG0002538	USR0486	VST004927	RT00450	2	f
LOG0002539	USR0132	VST004332	RT00251	2	t
LOG0002540	USR0041	VST001056	RT00408	4	f
LOG0002541	USR0201	VST001255	RT00170	1	f
LOG0002542	USR0099	VST004287	RT00566	3	f
LOG0002543	USR0311	VST004008	RT00912	1	f
LOG0002544	USR0284	VST004709	RT00132	4	f
LOG0002545	USR0357	VST001532	RT00827	1	t
LOG0002546	USR0047	VST003529	RT00606	2	f
LOG0002547	USR0137	VST004043	RT00046	3	f
LOG0002548	USR0130	VST000973	RT00350	4	t
LOG0002549	USR0195	VST003825	RT00099	2	f
LOG0002550	USR0117	VST004745	RT00746	1	f
LOG0002551	USR0364	VST000106	RT00781	2	f
LOG0002552	USR0432	VST001605	RT00037	1	t
LOG0002553	USR0069	VST003774	RT00438	1	t
LOG0002554	USR0458	VST004288	RT00945	4	t
LOG0002555	USR0028	VST001003	RT00075	1	f
LOG0002556	USR0335	VST004731	RT00058	2	f
LOG0002557	USR0014	VST000085	RT00019	4	t
LOG0002558	USR0046	VST002996	RT00402	3	t
LOG0002559	USR0471	VST004824	RT00188	4	t
LOG0002560	USR0397	VST003288	RT00913	2	t
LOG0002561	USR0016	VST004166	RT00139	1	t
LOG0002562	USR0478	VST000154	RT00143	4	f
LOG0002563	USR0424	VST001462	RT00968	4	f
LOG0002564	USR0456	VST002813	RT00108	4	f
LOG0002565	USR0209	VST002020	RT00221	2	f
LOG0002566	USR0158	VST001098	RT00145	1	f
LOG0002567	USR0337	VST000571	RT00858	3	f
LOG0002568	USR0227	VST000149	RT00510	3	f
LOG0002569	USR0449	VST003578	RT00376	1	f
LOG0002570	USR0241	VST002692	RT00005	3	f
LOG0002571	USR0058	VST002110	RT00957	1	t
LOG0002572	USR0472	VST001919	RT00388	4	f
LOG0002573	USR0304	VST004870	RT00568	4	f
LOG0002574	USR0305	VST003656	RT00767	2	f
LOG0002575	USR0345	VST001713	RT00984	4	t
LOG0002576	USR0130	VST002493	RT00971	2	t
LOG0002577	USR0217	VST001345	RT00734	3	f
LOG0002578	USR0014	VST003966	RT00872	3	f
LOG0002579	USR0359	VST001107	RT00560	4	f
LOG0002580	USR0377	VST003506	RT00816	1	f
LOG0002581	USR0243	VST004113	RT00163	3	t
LOG0002582	USR0481	VST000583	RT00748	3	t
LOG0002583	USR0145	VST004351	RT00760	3	f
LOG0002584	USR0379	VST002691	RT00365	1	t
LOG0002585	USR0415	VST004657	RT00417	4	t
LOG0002586	USR0394	VST002581	RT00509	2	t
LOG0002587	USR0326	VST000320	RT00612	1	t
LOG0002588	USR0103	VST004316	RT00021	1	f
LOG0002589	USR0217	VST004795	RT00614	3	t
LOG0002590	USR0358	VST001438	RT00517	2	t
LOG0002591	USR0421	VST000032	RT00960	1	f
LOG0002592	USR0064	VST000715	RT00197	3	f
LOG0002593	USR0158	VST001040	RT00661	1	f
LOG0002594	USR0162	VST000409	RT00345	3	f
LOG0002595	USR0018	VST001128	RT00330	2	t
LOG0002596	USR0216	VST000707	RT00378	2	f
LOG0002597	USR0319	VST003840	RT00211	3	t
LOG0002598	USR0049	VST003024	RT00160	4	f
LOG0002599	USR0056	VST003660	RT00658	1	t
LOG0002600	USR0347	VST000783	RT00570	4	f
LOG0002601	USR0058	VST002180	RT00354	1	f
LOG0002602	USR0155	VST001179	RT00240	2	t
LOG0002603	USR0055	VST002407	RT00079	1	f
LOG0002604	USR0487	VST002808	RT00152	3	f
LOG0002605	USR0341	VST004261	RT00517	3	f
LOG0002606	USR0019	VST002765	RT00383	3	f
LOG0002607	USR0487	VST002725	RT00693	4	f
LOG0002608	USR0151	VST002536	RT00352	2	f
LOG0002609	USR0359	VST000213	RT00201	2	f
LOG0002610	USR0368	VST001949	RT00951	2	f
LOG0002611	USR0108	VST004862	RT00133	3	f
LOG0002612	USR0047	VST003147	RT00965	2	f
LOG0002613	USR0207	VST001202	RT00634	4	t
LOG0002614	USR0363	VST001820	RT00169	4	t
LOG0002615	USR0450	VST002890	RT00866	4	t
LOG0002616	USR0483	VST000645	RT00391	3	t
LOG0002617	USR0435	VST002360	RT00858	1	f
LOG0002618	USR0340	VST004223	RT00385	2	t
LOG0002619	USR0412	VST004473	RT00820	4	f
LOG0002620	USR0128	VST004321	RT00098	1	f
LOG0002621	USR0185	VST003089	RT00794	1	t
LOG0002622	USR0058	VST000497	RT00377	4	f
LOG0002623	USR0143	VST002017	RT00992	4	t
LOG0002624	USR0400	VST000473	RT00959	2	t
LOG0002625	USR0097	VST001889	RT00780	2	t
LOG0002626	USR0047	VST003383	RT00838	1	t
LOG0002627	USR0191	VST001161	RT00340	1	f
LOG0002628	USR0140	VST002523	RT00531	1	t
LOG0002629	USR0103	VST004313	RT00976	3	t
LOG0002630	USR0231	VST000196	RT00132	1	f
LOG0002631	USR0427	VST002249	RT00608	3	t
LOG0002632	USR0340	VST004462	RT00210	2	f
LOG0002633	USR0413	VST002767	RT00005	1	t
LOG0002634	USR0491	VST001552	RT00377	2	t
LOG0002635	USR0049	VST002448	RT00640	1	f
LOG0002636	USR0387	VST004310	RT00054	2	f
LOG0002637	USR0112	VST002389	RT00498	1	f
LOG0002638	USR0453	VST003007	RT00198	3	t
LOG0002639	USR0316	VST000119	RT00441	4	t
LOG0002640	USR0322	VST003497	RT00718	2	t
LOG0002641	USR0087	VST001717	RT00180	2	f
LOG0002642	USR0382	VST002884	RT00241	4	f
LOG0002643	USR0474	VST004938	RT00786	1	t
LOG0002644	USR0282	VST002915	RT00320	3	f
LOG0002645	USR0327	VST001673	RT00501	3	t
LOG0002646	USR0252	VST001203	RT00650	3	t
LOG0002647	USR0074	VST001456	RT00023	1	f
LOG0002648	USR0453	VST004662	RT00632	2	f
LOG0002649	USR0047	VST003979	RT00627	1	t
LOG0002650	USR0076	VST002472	RT00594	3	f
LOG0002651	USR0096	VST000118	RT00708	4	t
LOG0002652	USR0426	VST000368	RT00180	3	f
LOG0002653	USR0031	VST003177	RT00864	2	f
LOG0002654	USR0022	VST003375	RT00175	1	f
LOG0002655	USR0017	VST003813	RT00198	1	t
LOG0002656	USR0212	VST002198	RT00538	3	t
LOG0002657	USR0148	VST004912	RT00454	2	t
LOG0002658	USR0235	VST002130	RT00099	2	t
LOG0002659	USR0392	VST000901	RT00745	4	f
LOG0002660	USR0495	VST000193	RT00427	3	f
LOG0002661	USR0354	VST002771	RT00453	4	t
LOG0002662	USR0305	VST003349	RT00191	1	t
LOG0002663	USR0087	VST000951	RT00974	1	t
LOG0002664	USR0038	VST003607	RT00578	2	f
LOG0002665	USR0053	VST000258	RT00758	4	f
LOG0002666	USR0028	VST001222	RT00499	2	f
LOG0002667	USR0077	VST000651	RT00616	3	t
LOG0002668	USR0413	VST002319	RT00191	2	t
LOG0002669	USR0200	VST004492	RT00141	1	f
LOG0002670	USR0395	VST002426	RT00691	1	t
LOG0002671	USR0431	VST000923	RT00773	2	t
LOG0002672	USR0173	VST003160	RT00175	3	f
LOG0002673	USR0274	VST000398	RT00420	4	t
LOG0002674	USR0050	VST002915	RT00676	1	f
LOG0002675	USR0345	VST000561	RT00434	1	t
LOG0002676	USR0177	VST000190	RT00440	3	t
LOG0002677	USR0406	VST000205	RT00531	2	t
LOG0002678	USR0301	VST003016	RT00532	1	f
LOG0002679	USR0445	VST004140	RT00918	1	f
LOG0002680	USR0227	VST003372	RT00799	3	t
LOG0002681	USR0127	VST003042	RT00361	2	t
LOG0002682	USR0349	VST001706	RT00751	3	f
LOG0002683	USR0021	VST000713	RT00446	3	t
LOG0002684	USR0199	VST003457	RT00556	2	t
LOG0002685	USR0189	VST002685	RT00708	1	f
LOG0002686	USR0332	VST004407	RT00707	4	t
LOG0002687	USR0420	VST004974	RT00357	4	t
LOG0002688	USR0152	VST003600	RT00857	4	t
LOG0002689	USR0160	VST004953	RT00561	3	t
LOG0002690	USR0347	VST002322	RT00997	1	f
LOG0002691	USR0480	VST003878	RT00059	1	f
LOG0002692	USR0443	VST003523	RT00644	1	f
LOG0002693	USR0096	VST004627	RT00885	1	t
LOG0002694	USR0352	VST004113	RT00167	3	f
LOG0002695	USR0474	VST002766	RT00647	4	t
LOG0002696	USR0075	VST004566	RT00967	4	t
LOG0002697	USR0366	VST004907	RT00945	2	t
LOG0002698	USR0082	VST000555	RT00601	1	f
LOG0002699	USR0128	VST002141	RT00783	4	t
LOG0002700	USR0359	VST004978	RT00263	4	t
LOG0002701	USR0133	VST002679	RT00431	1	t
LOG0002702	USR0400	VST004917	RT00628	1	f
LOG0002703	USR0139	VST000584	RT00196	4	t
LOG0002704	USR0246	VST004942	RT00354	2	f
LOG0002705	USR0291	VST001997	RT00886	1	f
LOG0002706	USR0112	VST000842	RT00941	4	t
LOG0002707	USR0203	VST002376	RT00620	2	t
LOG0002708	USR0170	VST004039	RT00874	3	f
LOG0002709	USR0087	VST001805	RT00915	2	f
LOG0002710	USR0119	VST000730	RT00047	1	f
LOG0002711	USR0098	VST004350	RT00753	3	f
LOG0002712	USR0240	VST001464	RT00309	2	t
LOG0002713	USR0337	VST004947	RT00230	4	t
LOG0002714	USR0138	VST002168	RT00411	1	f
LOG0002715	USR0082	VST004918	RT00901	3	f
LOG0002716	USR0236	VST001573	RT00757	4	f
LOG0002717	USR0136	VST004967	RT00316	3	t
LOG0002718	USR0282	VST001394	RT00762	2	f
LOG0002719	USR0003	VST000257	RT00077	4	f
LOG0002720	USR0059	VST000128	RT00062	1	f
LOG0002721	USR0116	VST001383	RT00571	4	f
LOG0002722	USR0472	VST003729	RT00238	2	f
LOG0002723	USR0131	VST004652	RT00701	3	f
LOG0002724	USR0422	VST002701	RT00568	4	f
LOG0002725	USR0386	VST003148	RT00078	3	f
LOG0002726	USR0483	VST002206	RT00734	1	t
LOG0002727	USR0401	VST004181	RT00559	4	t
LOG0002728	USR0201	VST000322	RT00944	3	t
LOG0002729	USR0292	VST002357	RT00650	1	f
LOG0002730	USR0342	VST004380	RT00416	2	t
LOG0002731	USR0479	VST003114	RT00961	4	f
LOG0002732	USR0098	VST001918	RT00024	4	t
LOG0002733	USR0216	VST003957	RT00029	4	f
LOG0002734	USR0124	VST004710	RT00491	3	t
LOG0002735	USR0073	VST002697	RT00135	3	t
LOG0002736	USR0366	VST001517	RT00351	1	f
LOG0002737	USR0378	VST003294	RT00913	4	t
LOG0002738	USR0491	VST004325	RT00350	1	t
LOG0002739	USR0130	VST003046	RT00281	4	t
LOG0002740	USR0469	VST000119	RT00476	2	t
LOG0002741	USR0418	VST002372	RT00292	4	f
LOG0002742	USR0027	VST004416	RT00189	1	f
LOG0002743	USR0165	VST003919	RT00583	3	f
LOG0002744	USR0455	VST003261	RT00419	2	f
LOG0002745	USR0406	VST002586	RT00888	2	f
LOG0002746	USR0068	VST004797	RT00468	4	t
LOG0002747	USR0014	VST002442	RT00206	2	f
LOG0002748	USR0098	VST002700	RT00242	1	f
LOG0002749	USR0279	VST001018	RT00306	1	f
LOG0002750	USR0428	VST004502	RT00184	4	f
LOG0002751	USR0490	VST003048	RT00478	3	f
LOG0002752	USR0473	VST002069	RT00504	2	f
LOG0002753	USR0449	VST003666	RT00128	2	t
LOG0002754	USR0371	VST004251	RT00449	4	t
LOG0002755	USR0247	VST004963	RT00230	2	f
LOG0002756	USR0112	VST004655	RT00041	3	f
LOG0002757	USR0207	VST000194	RT00793	4	f
LOG0002758	USR0352	VST002447	RT00674	1	t
LOG0002759	USR0334	VST001400	RT00392	2	f
LOG0002760	USR0233	VST002520	RT00824	4	t
LOG0002761	USR0061	VST003928	RT00340	1	t
LOG0002762	USR0085	VST003688	RT00670	1	f
LOG0002763	USR0183	VST004898	RT00836	1	t
LOG0002764	USR0239	VST000553	RT00021	4	t
LOG0002765	USR0250	VST000730	RT00347	4	f
LOG0002766	USR0071	VST002561	RT00010	1	t
LOG0002767	USR0228	VST003998	RT00087	1	t
LOG0002768	USR0085	VST004267	RT00545	4	f
LOG0002769	USR0306	VST004946	RT00971	4	f
LOG0002770	USR0488	VST000794	RT00873	3	t
LOG0002771	USR0396	VST000125	RT00339	1	f
LOG0002772	USR0463	VST000175	RT00715	2	f
LOG0002773	USR0271	VST002552	RT00004	2	f
LOG0002774	USR0401	VST003849	RT00023	4	f
LOG0002775	USR0290	VST003457	RT00197	2	t
LOG0002776	USR0236	VST002759	RT00821	4	f
LOG0002777	USR0291	VST003840	RT00881	3	f
LOG0002778	USR0039	VST003756	RT00498	4	f
LOG0002779	USR0486	VST003643	RT00901	1	f
LOG0002780	USR0206	VST004202	RT00786	4	t
LOG0002781	USR0183	VST001971	RT00273	2	t
LOG0002782	USR0187	VST001661	RT00954	2	t
LOG0002783	USR0133	VST002576	RT00451	2	t
LOG0002784	USR0030	VST000038	RT00107	1	t
LOG0002785	USR0388	VST004491	RT00881	4	f
LOG0002786	USR0255	VST002525	RT00378	4	t
LOG0002787	USR0143	VST004818	RT00200	2	f
LOG0002788	USR0103	VST003577	RT00952	1	t
LOG0002789	USR0419	VST001309	RT00936	2	f
LOG0002790	USR0493	VST003536	RT00855	2	t
LOG0002791	USR0074	VST004461	RT00727	1	f
LOG0002792	USR0055	VST002229	RT00002	2	t
LOG0002793	USR0450	VST004830	RT00121	3	f
LOG0002794	USR0236	VST002924	RT00615	1	t
LOG0002795	USR0060	VST003042	RT00149	2	f
LOG0002796	USR0024	VST002709	RT00948	4	t
LOG0002797	USR0476	VST004340	RT00152	3	f
LOG0002798	USR0022	VST004409	RT00565	4	f
LOG0002799	USR0428	VST004172	RT00678	4	t
LOG0002800	USR0032	VST003953	RT00916	3	f
LOG0002801	USR0351	VST002310	RT00306	1	t
LOG0002802	USR0339	VST000231	RT00679	2	f
LOG0002803	USR0435	VST002751	RT00828	4	f
LOG0002804	USR0469	VST002694	RT00882	4	t
LOG0002805	USR0003	VST002805	RT00475	4	f
LOG0002806	USR0070	VST000842	RT00364	1	f
LOG0002807	USR0160	VST003584	RT00807	4	f
LOG0002808	USR0386	VST004612	RT00071	4	t
LOG0002809	USR0088	VST002490	RT00640	4	t
LOG0002810	USR0365	VST004915	RT00033	3	f
LOG0002811	USR0059	VST003535	RT00157	3	t
LOG0002812	USR0252	VST000608	RT00330	4	t
LOG0002813	USR0219	VST004619	RT00778	1	t
LOG0002814	USR0201	VST003961	RT00716	1	f
LOG0002815	USR0077	VST004258	RT00707	2	t
LOG0002816	USR0255	VST002032	RT00387	3	f
LOG0002817	USR0247	VST000202	RT00973	1	t
LOG0002818	USR0270	VST001365	RT00621	4	f
LOG0002819	USR0307	VST000752	RT00159	3	f
LOG0002820	USR0139	VST001206	RT00795	1	f
LOG0002821	USR0078	VST001321	RT00966	2	f
LOG0002822	USR0080	VST003888	RT00539	4	t
LOG0002823	USR0010	VST001331	RT00227	3	t
LOG0002824	USR0468	VST000431	RT00252	2	t
LOG0002825	USR0336	VST002166	RT00367	2	t
LOG0002826	USR0124	VST004684	RT00777	3	t
LOG0002827	USR0186	VST003118	RT00262	1	f
LOG0002828	USR0034	VST002275	RT00646	4	f
LOG0002829	USR0121	VST003366	RT01000	2	t
LOG0002830	USR0080	VST001264	RT00538	2	t
LOG0002831	USR0206	VST002396	RT00043	3	t
LOG0002832	USR0053	VST004237	RT00531	3	f
LOG0002833	USR0156	VST004300	RT00016	3	f
LOG0002834	USR0274	VST003734	RT00105	2	f
LOG0002835	USR0410	VST001666	RT00791	1	t
LOG0002836	USR0358	VST000861	RT00203	1	f
LOG0002837	USR0135	VST000845	RT00720	4	t
LOG0002838	USR0429	VST003043	RT00925	3	t
LOG0002839	USR0098	VST003341	RT00678	4	f
LOG0002840	USR0495	VST003490	RT00059	2	t
LOG0002841	USR0241	VST001939	RT00048	2	t
LOG0002842	USR0045	VST000137	RT00660	2	f
LOG0002843	USR0199	VST003233	RT00277	4	f
LOG0002844	USR0481	VST002221	RT00412	3	t
LOG0002845	USR0291	VST001154	RT00178	4	t
LOG0002846	USR0436	VST004175	RT00801	4	t
LOG0002847	USR0114	VST000979	RT00114	2	t
LOG0002848	USR0487	VST000569	RT00296	2	t
LOG0002849	USR0277	VST002911	RT00730	1	t
LOG0002850	USR0241	VST002411	RT00438	3	t
LOG0002851	USR0156	VST003407	RT00266	3	t
LOG0002852	USR0352	VST000134	RT00162	3	t
LOG0002853	USR0044	VST002062	RT00841	4	f
LOG0002854	USR0080	VST004379	RT00504	2	t
LOG0002855	USR0312	VST002854	RT00036	2	f
LOG0002856	USR0138	VST003731	RT00587	1	t
LOG0002857	USR0151	VST003493	RT00458	4	f
LOG0002858	USR0432	VST000127	RT00647	3	f
LOG0002859	USR0436	VST001796	RT00371	4	t
LOG0002860	USR0242	VST001850	RT00486	2	f
LOG0002861	USR0143	VST004314	RT00272	1	f
LOG0002862	USR0311	VST003977	RT00179	4	f
LOG0002863	USR0299	VST004841	RT00986	2	f
LOG0002864	USR0050	VST002728	RT00480	4	t
LOG0002865	USR0262	VST003727	RT00957	2	f
LOG0002866	USR0161	VST003561	RT00159	4	t
LOG0002867	USR0062	VST000260	RT00755	3	f
LOG0002868	USR0055	VST001242	RT00928	4	f
LOG0002869	USR0423	VST001844	RT00813	4	t
LOG0002870	USR0396	VST001513	RT00204	3	f
LOG0002871	USR0372	VST004195	RT00795	4	t
LOG0002872	USR0484	VST004278	RT00278	2	t
LOG0002873	USR0031	VST002217	RT00143	2	t
LOG0002874	USR0330	VST002281	RT00520	2	f
LOG0002875	USR0437	VST000956	RT00512	2	f
LOG0002876	USR0290	VST004568	RT00964	2	t
LOG0002877	USR0169	VST001109	RT00116	3	t
LOG0002878	USR0266	VST004775	RT00392	3	f
LOG0002879	USR0308	VST001543	RT00343	4	f
LOG0002880	USR0459	VST000381	RT00373	2	t
LOG0002881	USR0185	VST001256	RT00784	4	f
LOG0002882	USR0334	VST002299	RT00688	2	t
LOG0002883	USR0003	VST002241	RT00930	4	f
LOG0002884	USR0441	VST001659	RT00726	3	t
LOG0002885	USR0161	VST002985	RT00369	2	f
LOG0002886	USR0391	VST002649	RT00215	3	f
LOG0002887	USR0260	VST003959	RT00511	4	f
LOG0002888	USR0423	VST003372	RT00569	3	f
LOG0002889	USR0048	VST003430	RT00901	3	t
LOG0002890	USR0254	VST001581	RT00741	3	f
LOG0002891	USR0074	VST004861	RT00812	1	t
LOG0002892	USR0335	VST002933	RT00327	4	t
LOG0002893	USR0400	VST001587	RT00037	4	t
LOG0002894	USR0166	VST002113	RT00986	2	f
LOG0002895	USR0260	VST003638	RT00380	2	t
LOG0002896	USR0004	VST004562	RT00796	2	t
LOG0002897	USR0376	VST004984	RT00512	3	t
LOG0002898	USR0119	VST002522	RT00324	4	t
LOG0002899	USR0484	VST003752	RT00369	3	t
LOG0002900	USR0411	VST002703	RT00224	4	f
LOG0002901	USR0470	VST000019	RT00934	3	f
LOG0002902	USR0470	VST002570	RT00814	2	f
LOG0002903	USR0273	VST000784	RT00713	3	f
LOG0002904	USR0493	VST001707	RT00100	1	f
LOG0002905	USR0226	VST000415	RT00794	2	f
LOG0002906	USR0352	VST000364	RT00075	1	t
LOG0002907	USR0500	VST002576	RT00724	1	t
LOG0002908	USR0070	VST001104	RT00437	2	t
LOG0002909	USR0182	VST004892	RT00703	1	f
LOG0002910	USR0353	VST001172	RT00368	1	t
LOG0002911	USR0264	VST001699	RT00063	4	t
LOG0002912	USR0370	VST000443	RT00624	3	f
LOG0002913	USR0181	VST003944	RT00934	1	f
LOG0002914	USR0484	VST004746	RT00655	3	f
LOG0002915	USR0005	VST004605	RT00099	1	f
LOG0002916	USR0197	VST004562	RT00777	2	f
LOG0002917	USR0047	VST002413	RT00225	2	t
LOG0002918	USR0458	VST002590	RT00075	4	t
LOG0002919	USR0040	VST001840	RT00790	2	f
LOG0002920	USR0122	VST001504	RT00710	4	f
LOG0002921	USR0135	VST000723	RT00184	2	f
LOG0002922	USR0140	VST000842	RT00293	3	f
LOG0002923	USR0350	VST002348	RT00057	1	f
LOG0002924	USR0153	VST002222	RT00249	1	t
LOG0002925	USR0028	VST000646	RT00956	4	t
LOG0002926	USR0427	VST000024	RT00626	2	f
LOG0002927	USR0077	VST003273	RT00469	3	f
LOG0002928	USR0175	VST004827	RT00140	3	f
LOG0002929	USR0049	VST000007	RT00903	2	f
LOG0002930	USR0342	VST003702	RT00962	1	t
LOG0002931	USR0310	VST003233	RT00359	2	f
LOG0002932	USR0274	VST002926	RT00553	1	f
LOG0002933	USR0027	VST001272	RT00408	2	f
LOG0002934	USR0328	VST004262	RT00474	1	t
LOG0002935	USR0390	VST004524	RT00665	4	t
LOG0002936	USR0459	VST002193	RT00446	3	f
LOG0002937	USR0221	VST002557	RT00980	2	f
LOG0002938	USR0122	VST002955	RT00232	1	t
LOG0002939	USR0361	VST001600	RT00617	1	f
LOG0002940	USR0069	VST001667	RT00618	1	t
LOG0002941	USR0071	VST004920	RT00300	4	f
LOG0002942	USR0150	VST001062	RT00642	1	t
LOG0002943	USR0187	VST004662	RT00426	3	t
LOG0002944	USR0431	VST003802	RT00995	4	f
LOG0002945	USR0373	VST001164	RT00161	1	f
LOG0002946	USR0246	VST003880	RT00401	3	t
LOG0002947	USR0196	VST001282	RT00378	1	f
LOG0002948	USR0032	VST002665	RT00959	3	f
LOG0002949	USR0467	VST002896	RT00918	3	f
LOG0002950	USR0109	VST001209	RT00257	1	f
LOG0002951	USR0353	VST000303	RT00741	3	t
LOG0002952	USR0001	VST000756	RT00862	2	t
LOG0002953	USR0182	VST004260	RT00494	1	t
LOG0002954	USR0174	VST001227	RT00966	2	f
LOG0002955	USR0169	VST001234	RT00489	3	f
LOG0002956	USR0248	VST003518	RT00182	4	f
LOG0002957	USR0108	VST000898	RT00526	4	f
LOG0002958	USR0370	VST004879	RT00100	3	t
LOG0002959	USR0297	VST003311	RT00737	2	f
LOG0002960	USR0264	VST004823	RT00358	1	t
LOG0002961	USR0416	VST003363	RT00231	4	f
LOG0002962	USR0030	VST002420	RT00565	2	t
LOG0002963	USR0302	VST002910	RT00006	4	f
LOG0002964	USR0476	VST001455	RT00090	4	t
LOG0002965	USR0361	VST002328	RT00064	3	f
LOG0002966	USR0436	VST002364	RT00088	1	t
LOG0002967	USR0352	VST002013	RT00033	2	f
LOG0002968	USR0473	VST001101	RT00072	2	f
LOG0002969	USR0482	VST000816	RT00556	1	f
LOG0002970	USR0317	VST004247	RT00253	2	f
LOG0002971	USR0225	VST001321	RT00107	4	t
LOG0002972	USR0397	VST004765	RT00802	1	t
LOG0002973	USR0089	VST004503	RT00930	4	t
LOG0002974	USR0234	VST002335	RT00920	4	f
LOG0002975	USR0168	VST004588	RT00514	4	f
LOG0002976	USR0231	VST001033	RT00136	1	f
LOG0002977	USR0126	VST001156	RT00629	2	f
LOG0002978	USR0061	VST001101	RT00409	4	t
LOG0002979	USR0120	VST002786	RT00121	1	t
LOG0002980	USR0428	VST000997	RT00478	1	t
LOG0002981	USR0497	VST001436	RT00800	3	t
LOG0002982	USR0190	VST002546	RT00824	3	t
LOG0002983	USR0121	VST003701	RT00094	3	f
LOG0002984	USR0428	VST004985	RT00505	2	t
LOG0002985	USR0048	VST000354	RT00007	2	t
LOG0002986	USR0202	VST002319	RT00944	2	t
LOG0002987	USR0059	VST004528	RT00600	2	t
LOG0002988	USR0185	VST000739	RT00694	4	f
LOG0002989	USR0223	VST002520	RT00191	1	f
LOG0002990	USR0492	VST004604	RT00457	1	f
LOG0002991	USR0011	VST000055	RT00720	3	t
LOG0002992	USR0281	VST002085	RT00386	1	t
LOG0002993	USR0189	VST000900	RT00803	2	t
LOG0002994	USR0302	VST002103	RT00866	1	f
LOG0002995	USR0310	VST000524	RT00278	4	f
LOG0002996	USR0500	VST000463	RT00979	4	f
LOG0002997	USR0237	VST004793	RT00448	3	t
LOG0002998	USR0034	VST001502	RT00827	2	f
LOG0002999	USR0340	VST003877	RT00945	1	f
LOG0003000	USR0135	VST000716	RT00052	3	f
LOG0003001	USR0481	VST003298	RT00405	1	t
LOG0003002	USR0062	VST002780	RT00396	3	t
LOG0003003	USR0313	VST003612	RT00779	3	f
LOG0003004	USR0227	VST000989	RT00756	4	f
LOG0003005	USR0093	VST001829	RT00694	4	f
LOG0003006	USR0116	VST000212	RT00211	4	f
LOG0003007	USR0332	VST003147	RT00890	3	t
LOG0003008	USR0133	VST000754	RT00710	4	t
LOG0003009	USR0332	VST003751	RT00270	4	f
LOG0003010	USR0477	VST003690	RT00545	2	f
LOG0003011	USR0419	VST003223	RT00614	1	f
LOG0003012	USR0468	VST000436	RT00845	1	f
LOG0003013	USR0293	VST001902	RT00282	2	f
LOG0003014	USR0444	VST004180	RT00398	2	t
LOG0003015	USR0193	VST001236	RT00749	4	t
LOG0003016	USR0400	VST000779	RT00216	4	t
LOG0003017	USR0030	VST004930	RT00432	1	f
LOG0003018	USR0457	VST003853	RT00321	2	f
LOG0003019	USR0298	VST001961	RT00814	2	t
LOG0003020	USR0061	VST004273	RT00639	4	f
LOG0003021	USR0458	VST001807	RT00493	1	t
LOG0003022	USR0461	VST003231	RT00951	3	f
LOG0003023	USR0304	VST001725	RT00606	2	t
LOG0003024	USR0446	VST000186	RT00586	1	t
LOG0003025	USR0340	VST001495	RT00128	1	f
LOG0003026	USR0349	VST001980	RT00074	1	f
LOG0003027	USR0448	VST004054	RT00476	2	f
LOG0003028	USR0441	VST000246	RT00452	3	t
LOG0003029	USR0324	VST004048	RT00462	4	t
LOG0003030	USR0302	VST000384	RT00908	3	f
LOG0003031	USR0369	VST000285	RT00438	1	t
LOG0003032	USR0028	VST003995	RT00256	2	t
LOG0003033	USR0485	VST000300	RT00448	2	t
LOG0003034	USR0077	VST000901	RT00102	3	f
LOG0003035	USR0121	VST001460	RT00559	3	t
LOG0003036	USR0003	VST002922	RT00677	2	f
LOG0003037	USR0037	VST002534	RT00970	3	f
LOG0003038	USR0432	VST000806	RT00768	4	t
LOG0003039	USR0147	VST002229	RT00937	4	t
LOG0003040	USR0092	VST001922	RT00283	4	f
LOG0003041	USR0339	VST004973	RT00938	1	t
LOG0003042	USR0273	VST004790	RT00760	3	t
LOG0003043	USR0466	VST002388	RT00204	2	f
LOG0003044	USR0466	VST002539	RT00086	1	f
LOG0003045	USR0377	VST001997	RT00324	2	t
LOG0003046	USR0087	VST004826	RT00925	3	t
LOG0003047	USR0040	VST002504	RT00164	3	f
LOG0003048	USR0178	VST000105	RT00877	1	t
LOG0003049	USR0329	VST000439	RT00057	1	f
LOG0003050	USR0285	VST001522	RT00206	4	f
LOG0003051	USR0435	VST001352	RT00908	1	f
LOG0003052	USR0042	VST002699	RT00429	4	f
LOG0003053	USR0285	VST003613	RT00148	1	f
LOG0003054	USR0066	VST000509	RT00301	4	t
LOG0003055	USR0124	VST004347	RT00791	3	t
LOG0003056	USR0145	VST004975	RT00958	2	f
LOG0003057	USR0120	VST001275	RT00982	3	f
LOG0003058	USR0109	VST002823	RT00290	4	f
LOG0003059	USR0415	VST000064	RT00021	3	f
LOG0003060	USR0092	VST003922	RT00947	1	f
LOG0003061	USR0491	VST004416	RT00137	1	f
LOG0003062	USR0368	VST000860	RT00970	2	t
LOG0003063	USR0308	VST002828	RT00369	2	f
LOG0003064	USR0423	VST001548	RT00522	3	f
LOG0003065	USR0060	VST002077	RT00820	2	t
LOG0003066	USR0350	VST000437	RT00557	1	t
LOG0003067	USR0227	VST003658	RT00436	1	f
LOG0003068	USR0240	VST000763	RT00761	1	f
LOG0003069	USR0435	VST000736	RT00030	4	f
LOG0003070	USR0212	VST003665	RT00448	4	f
LOG0003071	USR0400	VST004095	RT00225	3	f
LOG0003072	USR0098	VST004729	RT00386	4	f
LOG0003073	USR0014	VST001579	RT00689	2	t
LOG0003074	USR0218	VST003730	RT00608	1	f
LOG0003075	USR0468	VST001077	RT00429	3	f
LOG0003076	USR0170	VST002281	RT00529	4	t
LOG0003077	USR0307	VST001831	RT00028	3	f
LOG0003078	USR0280	VST001899	RT00126	3	t
LOG0003079	USR0363	VST004296	RT00813	2	t
LOG0003080	USR0210	VST000674	RT00785	2	t
LOG0003081	USR0256	VST000549	RT00499	2	f
LOG0003082	USR0171	VST000937	RT00187	3	t
LOG0003083	USR0073	VST004145	RT00654	3	t
LOG0003084	USR0147	VST000896	RT00372	2	f
LOG0003085	USR0340	VST002570	RT00138	4	t
LOG0003086	USR0317	VST002088	RT00994	1	t
LOG0003087	USR0106	VST000914	RT00974	2	t
LOG0003088	USR0094	VST001177	RT00337	4	f
LOG0003089	USR0063	VST004772	RT00741	3	t
LOG0003090	USR0154	VST004866	RT00214	3	t
LOG0003091	USR0255	VST004307	RT00786	4	f
LOG0003092	USR0351	VST003274	RT00291	4	t
LOG0003093	USR0035	VST004243	RT00944	3	f
LOG0003094	USR0323	VST001523	RT00570	3	t
LOG0003095	USR0312	VST002803	RT00371	3	f
LOG0003096	USR0296	VST003123	RT00530	3	f
LOG0003097	USR0253	VST004591	RT00692	2	t
LOG0003098	USR0157	VST002457	RT00670	3	t
LOG0003099	USR0134	VST001650	RT00768	3	f
LOG0003100	USR0436	VST002321	RT00549	4	t
LOG0003101	USR0129	VST002506	RT00296	4	f
LOG0003102	USR0436	VST001144	RT00774	4	t
LOG0003103	USR0280	VST003773	RT00591	3	t
LOG0003104	USR0358	VST000046	RT00419	4	f
LOG0003105	USR0418	VST003315	RT00666	3	t
LOG0003106	USR0371	VST004407	RT00361	3	t
LOG0003107	USR0252	VST002610	RT00859	4	t
LOG0003108	USR0135	VST004427	RT00158	1	t
LOG0003109	USR0331	VST004107	RT00075	2	f
LOG0003110	USR0011	VST003120	RT00372	2	f
LOG0003111	USR0292	VST001401	RT00920	1	f
LOG0003112	USR0148	VST001592	RT00890	1	f
LOG0003113	USR0319	VST000008	RT00567	3	t
LOG0003114	USR0080	VST000984	RT00718	4	f
LOG0003115	USR0191	VST003598	RT00727	2	f
LOG0003116	USR0453	VST001751	RT00521	2	f
LOG0003117	USR0344	VST003512	RT00106	1	t
LOG0003118	USR0030	VST003829	RT00830	4	t
LOG0003119	USR0414	VST000566	RT00367	2	f
LOG0003120	USR0359	VST002321	RT00402	2	t
LOG0003121	USR0368	VST000901	RT00757	3	t
LOG0003122	USR0495	VST002179	RT00819	3	f
LOG0003123	USR0229	VST003593	RT00103	3	f
LOG0003124	USR0481	VST002772	RT00787	2	f
LOG0003125	USR0084	VST000114	RT00325	2	t
LOG0003126	USR0150	VST000532	RT00373	3	f
LOG0003127	USR0361	VST001523	RT00338	3	t
LOG0003128	USR0189	VST003411	RT00891	4	t
LOG0003129	USR0021	VST001045	RT00033	2	f
LOG0003130	USR0037	VST000033	RT00108	2	t
LOG0003131	USR0246	VST000133	RT00422	1	t
LOG0003132	USR0283	VST002968	RT00269	3	f
LOG0003133	USR0102	VST001727	RT00945	3	t
LOG0003134	USR0419	VST000026	RT00073	3	t
LOG0003135	USR0294	VST002649	RT00858	2	t
LOG0003136	USR0232	VST004641	RT00181	4	t
LOG0003137	USR0316	VST001262	RT00897	2	t
LOG0003138	USR0326	VST002066	RT00780	1	t
LOG0003139	USR0288	VST003346	RT00152	1	f
LOG0003140	USR0336	VST000934	RT00512	4	f
LOG0003141	USR0476	VST001051	RT00897	3	f
LOG0003142	USR0464	VST000817	RT00068	1	f
LOG0003143	USR0411	VST004204	RT00903	2	t
LOG0003144	USR0245	VST000738	RT00372	1	f
LOG0003145	USR0387	VST002915	RT00348	1	f
LOG0003146	USR0177	VST003603	RT00997	4	f
LOG0003147	USR0213	VST000793	RT00709	4	f
LOG0003148	USR0358	VST003176	RT00807	2	f
LOG0003149	USR0102	VST001356	RT00032	3	f
LOG0003150	USR0286	VST001386	RT00945	4	f
LOG0003151	USR0022	VST003993	RT00927	4	f
LOG0003152	USR0019	VST004385	RT00620	3	f
LOG0003153	USR0287	VST001061	RT00079	1	f
LOG0003154	USR0276	VST001372	RT00259	2	f
LOG0003155	USR0495	VST004139	RT00497	2	t
LOG0003156	USR0147	VST001150	RT00878	1	f
LOG0003157	USR0386	VST003203	RT00175	3	t
LOG0003158	USR0040	VST003354	RT00367	3	f
LOG0003159	USR0167	VST002943	RT00015	4	f
LOG0003160	USR0091	VST004629	RT00051	3	t
LOG0003161	USR0072	VST003449	RT00107	2	t
LOG0003162	USR0365	VST003048	RT00722	2	t
LOG0003163	USR0438	VST002711	RT00469	2	t
LOG0003164	USR0283	VST001501	RT00202	3	t
LOG0003165	USR0335	VST000069	RT00789	1	t
LOG0003166	USR0140	VST001867	RT00218	2	t
LOG0003167	USR0239	VST001949	RT00041	2	f
LOG0003168	USR0078	VST003902	RT00888	1	t
LOG0003169	USR0199	VST003509	RT00771	4	t
LOG0003170	USR0017	VST000301	RT00385	3	t
LOG0003171	USR0218	VST004123	RT00917	2	t
LOG0003172	USR0229	VST002978	RT00715	3	f
LOG0003173	USR0340	VST002601	RT00336	2	t
LOG0003174	USR0138	VST002154	RT00611	2	t
LOG0003175	USR0147	VST004682	RT00661	4	t
LOG0003176	USR0210	VST004906	RT00105	1	t
LOG0003177	USR0158	VST004730	RT00203	1	t
LOG0003178	USR0414	VST004019	RT00510	1	f
LOG0003179	USR0153	VST003083	RT00095	4	f
LOG0003180	USR0344	VST004755	RT00177	4	f
LOG0003181	USR0330	VST001240	RT00065	1	t
LOG0003182	USR0383	VST002934	RT00553	3	t
LOG0003183	USR0450	VST002369	RT00224	3	f
LOG0003184	USR0358	VST000460	RT00579	4	f
LOG0003185	USR0352	VST004029	RT00380	3	f
LOG0003186	USR0163	VST002627	RT00255	1	f
LOG0003187	USR0307	VST003764	RT00992	2	f
LOG0003188	USR0101	VST002802	RT00298	3	f
LOG0003189	USR0327	VST004256	RT00581	1	f
LOG0003190	USR0327	VST000464	RT00953	1	f
LOG0003191	USR0155	VST000998	RT00171	1	f
LOG0003192	USR0010	VST003007	RT00613	3	f
LOG0003193	USR0353	VST001679	RT00652	2	f
LOG0003194	USR0427	VST000865	RT00718	3	t
LOG0003195	USR0183	VST001191	RT00832	1	f
LOG0003196	USR0455	VST002698	RT00364	1	t
LOG0003197	USR0134	VST002375	RT00819	1	t
LOG0003198	USR0006	VST000865	RT00073	4	t
LOG0003199	USR0333	VST002577	RT00060	3	t
LOG0003200	USR0432	VST003916	RT00455	2	t
LOG0003201	USR0333	VST002927	RT00336	3	f
LOG0003202	USR0258	VST004430	RT00668	1	t
LOG0003203	USR0211	VST002398	RT00124	1	f
LOG0003204	USR0051	VST002222	RT00455	4	f
LOG0003205	USR0445	VST001783	RT00014	1	f
LOG0003206	USR0147	VST003999	RT00416	3	f
LOG0003207	USR0498	VST002804	RT00776	3	t
LOG0003208	USR0377	VST004168	RT00027	3	t
LOG0003209	USR0128	VST004548	RT00757	1	t
LOG0003210	USR0486	VST002959	RT00050	4	f
LOG0003211	USR0258	VST001779	RT00187	3	t
LOG0003212	USR0051	VST000826	RT00057	2	f
LOG0003213	USR0154	VST003662	RT00771	2	t
LOG0003214	USR0070	VST003370	RT00667	2	f
LOG0003215	USR0276	VST003096	RT00990	3	f
LOG0003216	USR0279	VST002158	RT00034	4	t
LOG0003217	USR0310	VST000052	RT00538	1	t
LOG0003218	USR0399	VST003362	RT00762	4	f
LOG0003219	USR0134	VST003516	RT00997	1	t
LOG0003220	USR0220	VST004563	RT00936	1	f
LOG0003221	USR0163	VST003331	RT00371	1	t
LOG0003222	USR0459	VST001675	RT00086	1	f
LOG0003223	USR0136	VST002866	RT00160	3	f
LOG0003224	USR0057	VST001362	RT00425	2	f
LOG0003225	USR0434	VST000787	RT00898	3	t
LOG0003226	USR0177	VST000556	RT00879	4	f
LOG0003227	USR0115	VST002040	RT00712	1	f
LOG0003228	USR0499	VST001763	RT00106	3	f
LOG0003229	USR0472	VST002113	RT00391	3	t
LOG0003230	USR0149	VST002211	RT00512	3	t
LOG0003231	USR0241	VST001702	RT00275	1	f
LOG0003232	USR0123	VST002087	RT00289	1	t
LOG0003233	USR0292	VST002713	RT00258	1	f
LOG0003234	USR0327	VST002408	RT00963	3	f
LOG0003235	USR0069	VST002317	RT00220	3	t
LOG0003236	USR0314	VST001611	RT00974	4	f
LOG0003237	USR0063	VST004353	RT00527	2	f
LOG0003238	USR0221	VST004706	RT00533	2	t
LOG0003239	USR0016	VST001128	RT00846	1	f
LOG0003240	USR0390	VST000905	RT00059	2	f
LOG0003241	USR0078	VST000164	RT00360	1	t
LOG0003242	USR0122	VST001137	RT00594	1	f
LOG0003243	USR0436	VST004711	RT00630	3	f
LOG0003244	USR0258	VST002026	RT00113	2	f
LOG0003245	USR0217	VST000106	RT00807	4	f
LOG0003246	USR0479	VST004795	RT00276	1	t
LOG0003247	USR0114	VST004460	RT00257	1	f
LOG0003248	USR0370	VST003093	RT00329	4	f
LOG0003249	USR0461	VST002022	RT00777	2	t
LOG0003250	USR0380	VST001153	RT00235	4	t
LOG0003251	USR0146	VST000699	RT00051	2	f
LOG0003252	USR0465	VST003868	RT00678	2	t
LOG0003253	USR0237	VST003271	RT00743	2	t
LOG0003254	USR0476	VST000747	RT00221	2	f
LOG0003255	USR0460	VST000961	RT00783	2	f
LOG0003256	USR0419	VST003492	RT00596	2	t
LOG0003257	USR0086	VST003298	RT00230	1	t
LOG0003258	USR0167	VST002978	RT00809	3	f
LOG0003259	USR0129	VST000209	RT00222	1	f
LOG0003260	USR0165	VST003317	RT00943	1	t
LOG0003261	USR0277	VST001892	RT00666	4	t
LOG0003262	USR0257	VST001177	RT00054	3	f
LOG0003263	USR0132	VST003507	RT00631	3	t
LOG0003264	USR0480	VST002040	RT00710	3	t
LOG0003265	USR0058	VST003290	RT00935	2	t
LOG0003266	USR0257	VST001453	RT00273	2	f
LOG0003267	USR0141	VST004762	RT00198	2	t
LOG0003268	USR0174	VST003861	RT00128	1	t
LOG0003269	USR0175	VST001618	RT00604	3	f
LOG0003270	USR0209	VST000435	RT00009	3	t
LOG0003271	USR0204	VST002328	RT00987	1	f
LOG0003272	USR0007	VST001647	RT00227	2	f
LOG0003273	USR0051	VST003164	RT00558	4	f
LOG0003274	USR0259	VST004763	RT00134	3	f
LOG0003275	USR0178	VST001441	RT00964	1	t
LOG0003276	USR0410	VST004444	RT00016	2	f
LOG0003277	USR0031	VST004861	RT00215	1	t
LOG0003278	USR0356	VST000934	RT00112	4	f
LOG0003279	USR0318	VST004279	RT00855	4	t
LOG0003280	USR0154	VST002556	RT00157	2	f
LOG0003281	USR0451	VST001147	RT00425	1	t
LOG0003282	USR0364	VST003997	RT00452	2	f
LOG0003283	USR0055	VST000381	RT00318	1	f
LOG0003284	USR0156	VST000825	RT00360	1	f
LOG0003285	USR0044	VST001539	RT00376	4	f
LOG0003286	USR0081	VST003376	RT00936	1	f
LOG0003287	USR0166	VST001638	RT00958	1	t
LOG0003288	USR0495	VST004288	RT00920	4	f
LOG0003289	USR0030	VST000525	RT00902	3	f
LOG0003290	USR0322	VST003108	RT00296	3	t
LOG0003291	USR0136	VST001094	RT00198	3	t
LOG0003292	USR0014	VST000105	RT00570	3	f
LOG0003293	USR0357	VST001740	RT00398	1	f
LOG0003294	USR0483	VST002361	RT00590	3	f
LOG0003295	USR0106	VST003127	RT00242	3	t
LOG0003296	USR0359	VST001677	RT00429	1	t
LOG0003297	USR0318	VST002355	RT00879	3	f
LOG0003298	USR0075	VST004917	RT00611	3	f
LOG0003299	USR0447	VST004132	RT00006	2	f
LOG0003300	USR0079	VST002935	RT00791	3	t
LOG0003301	USR0194	VST001873	RT00318	2	f
LOG0003302	USR0485	VST001043	RT00212	3	f
LOG0003303	USR0363	VST003435	RT00273	1	f
LOG0003304	USR0096	VST001442	RT00084	3	f
LOG0003305	USR0040	VST001846	RT00624	4	f
LOG0003306	USR0256	VST003502	RT00710	1	f
LOG0003307	USR0397	VST001542	RT00360	3	f
LOG0003308	USR0107	VST000467	RT00381	3	t
LOG0003309	USR0017	VST002945	RT00540	1	t
LOG0003310	USR0015	VST004295	RT00141	4	t
LOG0003311	USR0417	VST001592	RT00925	1	t
LOG0003312	USR0499	VST002816	RT00510	4	t
LOG0003313	USR0272	VST004073	RT00173	1	f
LOG0003314	USR0499	VST003573	RT00020	1	t
LOG0003315	USR0013	VST004337	RT00954	2	f
LOG0003316	USR0247	VST001194	RT00977	2	t
LOG0003317	USR0214	VST000294	RT00629	1	f
LOG0003318	USR0151	VST000922	RT00503	2	t
LOG0003319	USR0292	VST001339	RT00566	3	t
LOG0003320	USR0043	VST003199	RT00227	3	f
LOG0003321	USR0434	VST004564	RT00109	3	t
LOG0003322	USR0114	VST002415	RT00743	2	f
LOG0003323	USR0330	VST004854	RT00320	2	f
LOG0003324	USR0081	VST003476	RT00308	3	t
LOG0003325	USR0350	VST001542	RT00741	1	t
LOG0003326	USR0141	VST002499	RT00811	3	t
LOG0003327	USR0030	VST000908	RT00087	2	f
LOG0003328	USR0441	VST002494	RT00786	4	t
LOG0003329	USR0494	VST002128	RT00228	3	f
LOG0003330	USR0030	VST003089	RT00852	3	t
LOG0003331	USR0455	VST004648	RT00310	2	t
LOG0003332	USR0266	VST003991	RT00828	2	f
LOG0003333	USR0099	VST003752	RT00379	2	t
LOG0003334	USR0450	VST002098	RT00583	2	t
LOG0003335	USR0094	VST003175	RT00740	3	f
LOG0003336	USR0211	VST000388	RT00385	2	t
LOG0003337	USR0295	VST000299	RT00113	4	f
LOG0003338	USR0037	VST004435	RT00293	1	t
LOG0003339	USR0387	VST003461	RT00305	2	t
LOG0003340	USR0089	VST004062	RT00291	2	t
LOG0003341	USR0418	VST000474	RT00105	3	t
LOG0003342	USR0255	VST004712	RT00963	1	f
LOG0003343	USR0214	VST004888	RT00291	1	f
LOG0003344	USR0422	VST003214	RT00477	1	t
LOG0003345	USR0014	VST004109	RT00521	2	f
LOG0003346	USR0192	VST000449	RT00677	3	t
LOG0003347	USR0295	VST002222	RT00060	3	f
LOG0003348	USR0182	VST001983	RT00312	2	t
LOG0003349	USR0130	VST003612	RT00106	1	f
LOG0003350	USR0224	VST002643	RT00623	1	f
LOG0003351	USR0043	VST001921	RT00089	3	f
LOG0003352	USR0181	VST002317	RT00268	4	f
LOG0003353	USR0387	VST001275	RT00742	2	t
LOG0003354	USR0169	VST004869	RT00839	4	f
LOG0003355	USR0264	VST001616	RT00583	4	f
LOG0003356	USR0474	VST004984	RT00119	1	f
LOG0003357	USR0096	VST003619	RT00900	4	f
LOG0003358	USR0203	VST002307	RT00445	2	f
LOG0003359	USR0498	VST000260	RT00429	3	f
LOG0003360	USR0447	VST003207	RT00351	2	f
LOG0003361	USR0321	VST001513	RT00946	2	t
LOG0003362	USR0335	VST004739	RT00306	2	t
LOG0003363	USR0388	VST002129	RT00615	2	t
LOG0003364	USR0068	VST003439	RT00202	4	f
LOG0003365	USR0092	VST002177	RT00944	1	f
LOG0003366	USR0266	VST004508	RT00023	3	t
LOG0003367	USR0331	VST003509	RT00090	1	t
LOG0003368	USR0178	VST004711	RT00471	4	t
LOG0003369	USR0151	VST004995	RT00093	1	f
LOG0003370	USR0317	VST003081	RT00776	1	t
LOG0003371	USR0047	VST000232	RT00979	4	t
LOG0003372	USR0003	VST000730	RT00285	1	f
LOG0003373	USR0487	VST003013	RT00683	3	t
LOG0003374	USR0103	VST002930	RT00309	4	t
LOG0003375	USR0273	VST000318	RT00902	3	f
LOG0003376	USR0022	VST001531	RT00733	1	f
LOG0003377	USR0116	VST001111	RT00536	2	t
LOG0003378	USR0347	VST000716	RT00376	2	t
LOG0003379	USR0400	VST001342	RT00714	4	t
LOG0003380	USR0464	VST003405	RT00499	2	t
LOG0003381	USR0104	VST003313	RT00636	2	f
LOG0003382	USR0259	VST003121	RT00142	2	f
LOG0003383	USR0308	VST003088	RT00052	4	f
LOG0003384	USR0367	VST000202	RT00070	3	f
LOG0003385	USR0417	VST002141	RT00260	2	f
LOG0003386	USR0298	VST001673	RT00698	4	f
LOG0003387	USR0130	VST001057	RT00884	3	t
LOG0003388	USR0295	VST003672	RT00719	4	t
LOG0003389	USR0302	VST000419	RT00293	2	t
LOG0003390	USR0048	VST002599	RT00816	2	f
LOG0003391	USR0027	VST000626	RT00378	1	t
LOG0003392	USR0015	VST004941	RT00039	1	f
LOG0003393	USR0263	VST003831	RT00348	1	f
LOG0003394	USR0365	VST001879	RT00578	3	f
LOG0003395	USR0441	VST001945	RT00525	4	f
LOG0003396	USR0298	VST002930	RT00706	3	f
LOG0003397	USR0265	VST002768	RT00828	1	t
LOG0003398	USR0361	VST003384	RT00506	1	f
LOG0003399	USR0134	VST003541	RT00382	2	t
LOG0003400	USR0441	VST000394	RT00425	3	f
LOG0003401	USR0076	VST002857	RT00800	2	t
LOG0003402	USR0030	VST002920	RT00436	2	t
LOG0003403	USR0439	VST002619	RT00645	4	t
LOG0003404	USR0340	VST000632	RT00707	1	t
LOG0003405	USR0126	VST002857	RT00322	2	t
LOG0003406	USR0084	VST000322	RT00590	2	f
LOG0003407	USR0054	VST003507	RT00250	1	t
LOG0003408	USR0366	VST004670	RT00744	1	f
LOG0003409	USR0283	VST001694	RT00180	4	t
LOG0003410	USR0340	VST001064	RT00894	4	f
LOG0003411	USR0443	VST003112	RT00689	2	f
LOG0003412	USR0263	VST001477	RT00029	2	f
LOG0003413	USR0424	VST002918	RT00496	2	t
LOG0003414	USR0360	VST003262	RT00678	3	f
LOG0003415	USR0222	VST002794	RT00326	4	t
LOG0003416	USR0328	VST003087	RT00738	2	f
LOG0003417	USR0002	VST003812	RT00648	1	t
LOG0003418	USR0398	VST003971	RT00187	4	f
LOG0003419	USR0394	VST003352	RT00055	4	t
LOG0003420	USR0306	VST000959	RT00878	2	f
LOG0003421	USR0146	VST004144	RT00514	3	f
LOG0003422	USR0018	VST001583	RT00410	2	f
LOG0003423	USR0016	VST003177	RT00831	3	t
LOG0003424	USR0308	VST002417	RT00017	3	f
LOG0003425	USR0453	VST000460	RT00571	1	f
LOG0003426	USR0436	VST002295	RT00088	2	f
LOG0003427	USR0159	VST002312	RT00223	3	f
LOG0003428	USR0485	VST001230	RT00784	4	t
LOG0003429	USR0340	VST001531	RT00058	2	t
LOG0003430	USR0407	VST004626	RT00704	3	t
LOG0003431	USR0352	VST001388	RT00562	4	f
LOG0003432	USR0298	VST002798	RT00725	1	t
LOG0003433	USR0209	VST001364	RT00230	1	f
LOG0003434	USR0446	VST004503	RT00154	2	f
LOG0003435	USR0205	VST000453	RT00273	2	f
LOG0003436	USR0113	VST003905	RT00882	2	t
LOG0003437	USR0178	VST004910	RT00046	2	f
LOG0003438	USR0461	VST000578	RT00874	2	t
LOG0003439	USR0209	VST003920	RT00895	3	f
LOG0003440	USR0124	VST003013	RT00452	4	t
LOG0003441	USR0015	VST003265	RT00306	2	t
LOG0003442	USR0346	VST001932	RT00427	4	t
LOG0003443	USR0428	VST004243	RT00118	3	f
LOG0003444	USR0476	VST004502	RT00688	3	t
LOG0003445	USR0298	VST000183	RT00580	3	t
LOG0003446	USR0045	VST003178	RT00251	2	f
LOG0003447	USR0094	VST000236	RT00403	1	t
LOG0003448	USR0107	VST000638	RT00742	1	t
LOG0003449	USR0419	VST003006	RT00921	2	t
LOG0003450	USR0278	VST004275	RT00200	2	f
LOG0003451	USR0128	VST002480	RT00146	2	t
LOG0003452	USR0458	VST003473	RT00051	3	t
LOG0003453	USR0459	VST000525	RT00914	1	t
LOG0003454	USR0038	VST002791	RT00368	1	f
LOG0003455	USR0097	VST002371	RT00698	4	t
LOG0003456	USR0198	VST001285	RT00320	4	t
LOG0003457	USR0192	VST001636	RT00199	1	f
LOG0003458	USR0357	VST001724	RT00441	1	t
LOG0003459	USR0007	VST002447	RT00145	3	t
LOG0003460	USR0044	VST004433	RT00059	4	t
LOG0003461	USR0332	VST004215	RT00707	2	f
LOG0003462	USR0007	VST001582	RT00982	3	t
LOG0003463	USR0194	VST002461	RT00143	4	f
LOG0003464	USR0316	VST000580	RT00223	2	t
LOG0003465	USR0001	VST003942	RT00100	2	t
LOG0003466	USR0062	VST000196	RT00026	1	f
LOG0003467	USR0343	VST000333	RT00432	1	t
LOG0003468	USR0089	VST003092	RT00526	2	t
LOG0003469	USR0018	VST004719	RT00122	2	f
LOG0003470	USR0108	VST000658	RT00465	1	f
LOG0003471	USR0135	VST000704	RT00265	1	f
LOG0003472	USR0371	VST004979	RT00007	1	t
LOG0003473	USR0310	VST001450	RT00731	1	f
LOG0003474	USR0067	VST001253	RT00220	4	t
LOG0003475	USR0093	VST000524	RT00695	1	f
LOG0003476	USR0138	VST002265	RT00396	3	f
LOG0003477	USR0189	VST002423	RT00913	3	f
LOG0003478	USR0059	VST000036	RT00457	3	t
LOG0003479	USR0187	VST000776	RT00108	1	t
LOG0003480	USR0235	VST000028	RT00492	2	t
LOG0003481	USR0069	VST000086	RT00904	2	f
LOG0003482	USR0447	VST002236	RT00859	4	t
LOG0003483	USR0098	VST002353	RT00636	1	t
LOG0003484	USR0008	VST003494	RT00682	3	f
LOG0003485	USR0462	VST004282	RT00460	2	t
LOG0003486	USR0488	VST004654	RT00933	1	f
LOG0003487	USR0311	VST002557	RT00916	3	f
LOG0003488	USR0134	VST004313	RT00769	3	t
LOG0003489	USR0385	VST000257	RT00009	3	f
LOG0003490	USR0056	VST003807	RT00367	3	t
LOG0003491	USR0481	VST001448	RT00792	3	f
LOG0003492	USR0360	VST004420	RT00125	4	t
LOG0003493	USR0459	VST002245	RT00162	3	t
LOG0003494	USR0114	VST004600	RT00036	4	t
LOG0003495	USR0088	VST003344	RT00004	3	f
LOG0003496	USR0138	VST000694	RT00413	3	t
LOG0003497	USR0108	VST002066	RT00087	3	f
LOG0003498	USR0500	VST003601	RT00483	3	t
LOG0003499	USR0023	VST004221	RT00912	4	t
LOG0003500	USR0144	VST000483	RT00776	1	f
LOG0003501	USR0357	VST003666	RT00603	2	t
LOG0003502	USR0144	VST003076	RT00807	4	t
LOG0003503	USR0056	VST002675	RT00058	4	f
LOG0003504	USR0108	VST002399	RT00140	4	t
LOG0003505	USR0351	VST000351	RT00172	1	t
LOG0003506	USR0006	VST000649	RT00260	2	f
LOG0003507	USR0030	VST003871	RT00495	1	t
LOG0003508	USR0447	VST000228	RT00025	2	t
LOG0003509	USR0485	VST002064	RT00198	2	f
LOG0003510	USR0385	VST000425	RT00579	2	f
LOG0003511	USR0307	VST002512	RT00423	1	t
LOG0003512	USR0362	VST004820	RT00118	2	f
LOG0003513	USR0345	VST001822	RT00792	3	t
LOG0003514	USR0127	VST004890	RT00981	4	f
LOG0003515	USR0302	VST004273	RT00006	2	t
LOG0003516	USR0121	VST002591	RT00097	4	f
LOG0003517	USR0405	VST002557	RT00072	1	t
LOG0003518	USR0099	VST001586	RT00929	1	t
LOG0003519	USR0166	VST001679	RT00432	3	t
LOG0003520	USR0325	VST004660	RT00963	2	f
LOG0003521	USR0319	VST002281	RT00380	4	f
LOG0003522	USR0241	VST003750	RT00770	4	t
LOG0003523	USR0050	VST002539	RT00550	4	f
LOG0003524	USR0268	VST001017	RT00808	1	f
LOG0003525	USR0325	VST000444	RT00056	2	f
LOG0003526	USR0073	VST002068	RT00615	3	f
LOG0003527	USR0300	VST003683	RT00103	3	f
LOG0003528	USR0052	VST003799	RT00216	1	f
LOG0003529	USR0265	VST003628	RT00021	2	t
LOG0003530	USR0227	VST000111	RT00627	3	t
LOG0003531	USR0193	VST002535	RT00210	3	f
LOG0003532	USR0374	VST000089	RT00291	1	f
LOG0003533	USR0239	VST003391	RT00715	4	f
LOG0003534	USR0010	VST001942	RT00971	3	t
LOG0003535	USR0302	VST003311	RT00835	1	t
LOG0003536	USR0359	VST000072	RT00188	3	f
LOG0003537	USR0228	VST000822	RT00151	3	t
LOG0003538	USR0442	VST003471	RT00961	1	t
LOG0003539	USR0293	VST000816	RT00191	1	t
LOG0003540	USR0052	VST000404	RT00407	2	t
LOG0003541	USR0240	VST001699	RT00214	3	t
LOG0003542	USR0099	VST004347	RT00891	4	t
LOG0003543	USR0081	VST002917	RT00554	4	f
LOG0003544	USR0013	VST002043	RT00478	2	t
LOG0003545	USR0390	VST001954	RT00960	2	f
LOG0003546	USR0442	VST004964	RT00194	1	f
LOG0003547	USR0357	VST003294	RT00250	4	t
LOG0003548	USR0128	VST003703	RT00593	3	t
LOG0003549	USR0304	VST003254	RT00041	1	f
LOG0003550	USR0416	VST004992	RT00370	3	t
LOG0003551	USR0011	VST003802	RT00020	4	f
LOG0003552	USR0081	VST000256	RT00009	1	f
LOG0003553	USR0261	VST001932	RT00825	3	t
LOG0003554	USR0006	VST001112	RT00636	2	t
LOG0003555	USR0458	VST000873	RT00203	3	t
LOG0003556	USR0373	VST004588	RT00913	3	f
LOG0003557	USR0481	VST001562	RT00590	1	f
LOG0003558	USR0222	VST004729	RT00722	4	t
LOG0003559	USR0405	VST004458	RT00018	3	t
LOG0003560	USR0298	VST000894	RT00748	3	t
LOG0003561	USR0081	VST002685	RT00319	3	t
LOG0003562	USR0411	VST001247	RT00712	3	f
LOG0003563	USR0003	VST000747	RT00861	2	t
LOG0003564	USR0060	VST004054	RT00968	4	f
LOG0003565	USR0221	VST004086	RT00282	4	t
LOG0003566	USR0450	VST001007	RT00476	1	f
LOG0003567	USR0349	VST002741	RT00968	3	f
LOG0003568	USR0049	VST004311	RT00252	1	f
LOG0003569	USR0228	VST004323	RT00340	2	t
LOG0003570	USR0290	VST000891	RT00751	2	t
LOG0003571	USR0293	VST002492	RT00968	3	t
LOG0003572	USR0298	VST002877	RT00462	1	f
LOG0003573	USR0193	VST001632	RT00781	1	t
LOG0003574	USR0444	VST003704	RT00631	4	t
LOG0003575	USR0474	VST002027	RT01000	1	t
LOG0003576	USR0257	VST004108	RT00401	2	f
LOG0003577	USR0443	VST003323	RT00371	2	t
LOG0003578	USR0388	VST000742	RT00282	3	f
LOG0003579	USR0103	VST003009	RT00390	1	f
LOG0003580	USR0398	VST001977	RT00337	1	t
LOG0003581	USR0366	VST003663	RT00900	2	t
LOG0003582	USR0146	VST003801	RT00345	3	f
LOG0003583	USR0290	VST003572	RT00519	4	t
LOG0003584	USR0257	VST002912	RT00273	4	f
LOG0003585	USR0309	VST003085	RT00253	3	f
LOG0003586	USR0278	VST000774	RT00854	3	f
LOG0003587	USR0464	VST002145	RT00640	4	t
LOG0003588	USR0189	VST000993	RT00374	2	f
LOG0003589	USR0406	VST001839	RT00604	1	f
LOG0003590	USR0178	VST003814	RT00818	4	t
LOG0003591	USR0016	VST004908	RT00896	3	f
LOG0003592	USR0412	VST003322	RT00006	3	f
LOG0003593	USR0476	VST003843	RT00414	1	t
LOG0003594	USR0375	VST003254	RT00586	3	f
LOG0003595	USR0086	VST001876	RT00498	2	t
LOG0003596	USR0248	VST003238	RT00056	3	t
LOG0003597	USR0454	VST000004	RT00807	1	f
LOG0003598	USR0217	VST000165	RT00398	4	t
LOG0003599	USR0042	VST004440	RT00822	2	f
LOG0003600	USR0194	VST001898	RT00238	3	t
LOG0003601	USR0327	VST003241	RT00490	1	f
LOG0003602	USR0373	VST002568	RT00022	4	t
LOG0003603	USR0465	VST003508	RT00441	4	f
LOG0003604	USR0163	VST002560	RT00041	1	f
LOG0003605	USR0276	VST001339	RT00858	4	t
LOG0003606	USR0364	VST004638	RT00778	4	f
LOG0003607	USR0130	VST000613	RT00258	4	f
LOG0003608	USR0263	VST004996	RT00451	4	t
LOG0003609	USR0480	VST001885	RT00048	1	t
LOG0003610	USR0177	VST004025	RT00810	1	t
LOG0003611	USR0467	VST003135	RT00503	3	f
LOG0003612	USR0460	VST001056	RT00139	3	f
LOG0003613	USR0265	VST001623	RT00202	2	f
LOG0003614	USR0027	VST003283	RT00652	4	t
LOG0003615	USR0462	VST002611	RT00509	4	f
LOG0003616	USR0386	VST003070	RT00654	2	f
LOG0003617	USR0085	VST001256	RT00286	1	f
LOG0003618	USR0196	VST002661	RT00233	1	t
LOG0003619	USR0316	VST004225	RT00316	2	t
LOG0003620	USR0243	VST001043	RT00461	3	f
LOG0003621	USR0469	VST004453	RT00670	3	t
LOG0003622	USR0368	VST001443	RT00550	4	t
LOG0003623	USR0342	VST003678	RT00587	3	f
LOG0003624	USR0177	VST004177	RT00321	1	t
LOG0003625	USR0130	VST003687	RT00987	2	t
LOG0003626	USR0145	VST001905	RT00175	2	t
LOG0003627	USR0083	VST002714	RT00039	2	f
LOG0003628	USR0360	VST001878	RT00433	3	t
LOG0003629	USR0088	VST000791	RT00485	2	t
LOG0003630	USR0020	VST000225	RT00585	2	f
LOG0003631	USR0230	VST003035	RT00058	3	f
LOG0003632	USR0460	VST004876	RT00496	1	f
LOG0003633	USR0473	VST004233	RT00875	4	f
LOG0003634	USR0126	VST000226	RT00986	1	f
LOG0003635	USR0471	VST003406	RT00601	3	t
LOG0003636	USR0498	VST003180	RT00785	2	f
LOG0003637	USR0354	VST000812	RT00134	4	t
LOG0003638	USR0416	VST002493	RT00655	1	f
LOG0003639	USR0051	VST004103	RT00509	4	t
LOG0003640	USR0088	VST004224	RT00963	1	f
LOG0003641	USR0170	VST004067	RT00607	1	t
LOG0003642	USR0063	VST004363	RT00156	3	f
LOG0003643	USR0089	VST004310	RT00201	1	t
LOG0003644	USR0189	VST000247	RT00940	2	t
LOG0003645	USR0190	VST001619	RT00499	3	f
LOG0003646	USR0387	VST001828	RT00402	4	t
LOG0003647	USR0089	VST003446	RT00496	3	t
LOG0003648	USR0348	VST000421	RT00488	1	f
LOG0003649	USR0332	VST002765	RT00160	4	t
LOG0003650	USR0026	VST001372	RT00211	2	t
LOG0003651	USR0176	VST004239	RT00453	3	f
LOG0003652	USR0364	VST002189	RT00684	1	t
LOG0003653	USR0264	VST002613	RT00070	4	f
LOG0003654	USR0389	VST002081	RT00831	2	t
LOG0003655	USR0395	VST004325	RT00972	2	t
LOG0003656	USR0042	VST002736	RT00314	3	t
LOG0003657	USR0483	VST000830	RT00431	4	t
LOG0003658	USR0475	VST003059	RT00382	1	f
LOG0003659	USR0119	VST000850	RT00657	4	f
LOG0003660	USR0169	VST002781	RT00167	2	t
LOG0003661	USR0108	VST001154	RT00955	4	t
LOG0003662	USR0486	VST004941	RT00391	3	f
LOG0003663	USR0147	VST003830	RT00319	4	f
LOG0003664	USR0176	VST002683	RT00117	4	f
LOG0003665	USR0437	VST003080	RT00697	3	t
LOG0003666	USR0439	VST000403	RT00512	4	t
LOG0003667	USR0376	VST002976	RT00203	3	t
LOG0003668	USR0189	VST001603	RT00162	3	f
LOG0003669	USR0160	VST004723	RT00821	3	t
LOG0003670	USR0302	VST000981	RT00962	2	f
LOG0003671	USR0348	VST002295	RT00462	4	f
LOG0003672	USR0420	VST002385	RT00850	3	t
LOG0003673	USR0402	VST003353	RT00944	1	f
LOG0003674	USR0074	VST004129	RT00700	1	t
LOG0003675	USR0352	VST000799	RT00555	2	f
LOG0003676	USR0018	VST002596	RT00201	3	t
LOG0003677	USR0140	VST001367	RT00231	3	t
LOG0003678	USR0115	VST002939	RT00516	2	f
LOG0003679	USR0328	VST001263	RT00752	4	f
LOG0003680	USR0225	VST002777	RT00206	3	t
LOG0003681	USR0046	VST003249	RT00331	3	t
LOG0003682	USR0439	VST000304	RT00606	1	f
LOG0003683	USR0038	VST001694	RT00744	3	t
LOG0003684	USR0206	VST002317	RT00875	2	t
LOG0003685	USR0386	VST004496	RT00347	1	f
LOG0003686	USR0009	VST000922	RT00349	2	f
LOG0003687	USR0253	VST000421	RT00948	2	f
LOG0003688	USR0108	VST002179	RT00160	3	t
LOG0003689	USR0389	VST003810	RT00625	4	t
LOG0003690	USR0098	VST001167	RT00252	3	f
LOG0003691	USR0275	VST004674	RT00222	4	f
LOG0003692	USR0071	VST000540	RT00858	1	f
LOG0003693	USR0039	VST003500	RT00606	2	t
LOG0003694	USR0298	VST001461	RT00947	2	t
LOG0003695	USR0401	VST004688	RT00394	3	t
LOG0003696	USR0447	VST004740	RT00396	4	f
LOG0003697	USR0090	VST000328	RT00993	2	f
LOG0003698	USR0430	VST002860	RT00994	2	t
LOG0003699	USR0219	VST002094	RT00978	4	f
LOG0003700	USR0107	VST002132	RT00167	2	f
LOG0003701	USR0476	VST002842	RT00976	2	f
LOG0003702	USR0404	VST000352	RT00452	2	t
LOG0003703	USR0454	VST004733	RT00138	4	f
LOG0003704	USR0392	VST003909	RT00860	4	f
LOG0003705	USR0096	VST000234	RT00873	1	f
LOG0003706	USR0403	VST003123	RT00210	2	f
LOG0003707	USR0032	VST004877	RT00768	2	t
LOG0003708	USR0126	VST002729	RT00585	1	t
LOG0003709	USR0147	VST000933	RT00214	4	t
LOG0003710	USR0280	VST001824	RT00778	4	t
LOG0003711	USR0024	VST003501	RT00360	3	f
LOG0003712	USR0440	VST004074	RT00663	4	t
LOG0003713	USR0209	VST003346	RT00235	3	f
LOG0003714	USR0120	VST000861	RT00973	1	f
LOG0003715	USR0274	VST001231	RT00728	4	f
LOG0003716	USR0140	VST002196	RT00397	1	f
LOG0003717	USR0297	VST004396	RT00304	3	t
LOG0003718	USR0343	VST001477	RT00109	2	t
LOG0003719	USR0432	VST002024	RT00857	2	f
LOG0003720	USR0082	VST002597	RT00812	1	t
LOG0003721	USR0448	VST002431	RT00861	2	t
LOG0003722	USR0400	VST003690	RT00976	1	f
LOG0003723	USR0208	VST000534	RT00832	3	t
LOG0003724	USR0484	VST001257	RT00808	2	f
LOG0003725	USR0407	VST001658	RT00390	3	f
LOG0003726	USR0470	VST001153	RT00120	4	f
LOG0003727	USR0423	VST003894	RT00840	2	t
LOG0003728	USR0033	VST001753	RT00610	2	f
LOG0003729	USR0024	VST001684	RT00210	2	f
LOG0003730	USR0061	VST002979	RT00427	1	f
LOG0003731	USR0311	VST004333	RT00544	4	t
LOG0003732	USR0189	VST003654	RT00945	4	f
LOG0003733	USR0084	VST003014	RT00330	4	f
LOG0003734	USR0225	VST000701	RT00226	3	f
LOG0003735	USR0479	VST004671	RT00727	4	f
LOG0003736	USR0168	VST003065	RT00635	1	t
LOG0003737	USR0186	VST004867	RT00147	1	f
LOG0003738	USR0375	VST001765	RT00340	3	t
LOG0003739	USR0072	VST004319	RT00564	3	f
LOG0003740	USR0074	VST001123	RT00180	4	t
LOG0003741	USR0385	VST003831	RT00290	4	f
LOG0003742	USR0341	VST002959	RT00187	1	t
LOG0003743	USR0153	VST002321	RT00486	1	t
LOG0003744	USR0096	VST001423	RT00337	4	f
LOG0003745	USR0053	VST001541	RT00108	1	f
LOG0003746	USR0445	VST004526	RT00126	3	f
LOG0003747	USR0174	VST000523	RT00773	1	t
LOG0003748	USR0110	VST003008	RT00706	4	t
LOG0003749	USR0458	VST002499	RT00809	3	t
LOG0003750	USR0316	VST002090	RT00034	1	t
LOG0003751	USR0051	VST001739	RT00438	3	f
LOG0003752	USR0377	VST004190	RT00276	4	t
LOG0003753	USR0253	VST002534	RT00494	1	f
LOG0003754	USR0496	VST002565	RT00182	4	t
LOG0003755	USR0073	VST002765	RT00239	2	f
LOG0003756	USR0212	VST000499	RT00834	4	t
LOG0003757	USR0432	VST002419	RT00348	2	t
LOG0003758	USR0212	VST002747	RT00146	3	f
LOG0003759	USR0251	VST000485	RT00044	3	t
LOG0003760	USR0168	VST000665	RT00871	2	t
LOG0003761	USR0263	VST003455	RT00816	3	t
LOG0003762	USR0331	VST000628	RT00499	3	f
LOG0003763	USR0469	VST001685	RT00803	4	t
LOG0003764	USR0230	VST000732	RT00975	2	f
LOG0003765	USR0239	VST004288	RT00879	1	t
LOG0003766	USR0275	VST001245	RT00295	3	t
LOG0003767	USR0494	VST002175	RT01000	3	f
LOG0003768	USR0143	VST003875	RT00999	1	f
LOG0003769	USR0070	VST002775	RT00771	4	f
LOG0003770	USR0445	VST003079	RT00531	4	t
LOG0003771	USR0312	VST004792	RT00727	4	f
LOG0003772	USR0394	VST001140	RT00211	1	t
LOG0003773	USR0174	VST004660	RT00893	4	t
LOG0003774	USR0336	VST003118	RT00402	3	f
LOG0003775	USR0109	VST002441	RT00990	4	t
LOG0003776	USR0203	VST004119	RT00231	3	t
LOG0003777	USR0185	VST003203	RT00339	1	t
LOG0003778	USR0291	VST003199	RT00005	4	t
LOG0003779	USR0328	VST004541	RT00311	4	f
LOG0003780	USR0092	VST004873	RT00781	3	t
LOG0003781	USR0259	VST002045	RT00162	1	t
LOG0003782	USR0322	VST000708	RT00216	4	f
LOG0003783	USR0437	VST000433	RT00786	1	f
LOG0003784	USR0206	VST000473	RT00836	3	t
LOG0003785	USR0052	VST000048	RT00612	3	f
LOG0003786	USR0349	VST001915	RT00968	4	f
LOG0003787	USR0181	VST001106	RT00171	1	t
LOG0003788	USR0438	VST003181	RT00961	3	f
LOG0003789	USR0303	VST001891	RT00252	1	t
LOG0003790	USR0003	VST000358	RT00681	2	t
LOG0003791	USR0449	VST000568	RT00038	2	t
LOG0003792	USR0399	VST000480	RT00228	4	f
LOG0003793	USR0084	VST000867	RT00934	1	t
LOG0003794	USR0214	VST003261	RT00909	1	t
LOG0003795	USR0034	VST004060	RT00637	3	t
LOG0003796	USR0050	VST001029	RT00278	1	f
LOG0003797	USR0289	VST003358	RT00285	1	f
LOG0003798	USR0329	VST001814	RT00510	3	t
LOG0003799	USR0259	VST003729	RT00649	4	t
LOG0003800	USR0258	VST003527	RT00987	3	f
LOG0003801	USR0388	VST004804	RT00366	2	t
LOG0003802	USR0272	VST001051	RT00620	1	f
LOG0003803	USR0182	VST000127	RT00068	1	t
LOG0003804	USR0033	VST003607	RT00104	4	f
LOG0003805	USR0265	VST002379	RT00401	2	t
LOG0003806	USR0313	VST001653	RT00246	1	t
LOG0003807	USR0040	VST000008	RT00677	3	f
LOG0003808	USR0486	VST004709	RT00192	1	f
LOG0003809	USR0308	VST001285	RT00707	4	f
LOG0003810	USR0210	VST004694	RT00644	3	t
LOG0003811	USR0272	VST004482	RT00296	1	f
LOG0003812	USR0136	VST000179	RT00144	4	f
LOG0003813	USR0087	VST003596	RT00907	2	f
LOG0003814	USR0060	VST004911	RT00731	3	f
LOG0003815	USR0164	VST003818	RT00026	3	f
LOG0003816	USR0003	VST003255	RT00251	2	f
LOG0003817	USR0015	VST004454	RT00607	3	t
LOG0003818	USR0102	VST002424	RT00866	4	f
LOG0003819	USR0255	VST004798	RT00712	2	f
LOG0003820	USR0225	VST001751	RT00615	1	f
LOG0003821	USR0210	VST004878	RT00193	4	t
LOG0003822	USR0023	VST004178	RT00381	2	f
LOG0003823	USR0235	VST003430	RT00002	1	t
LOG0003824	USR0131	VST000185	RT00759	4	f
LOG0003825	USR0158	VST002336	RT00603	4	t
LOG0003826	USR0173	VST003134	RT00045	3	f
LOG0003827	USR0017	VST004979	RT00939	3	t
LOG0003828	USR0370	VST000507	RT00003	2	t
LOG0003829	USR0442	VST004126	RT00930	1	f
LOG0003830	USR0314	VST001933	RT00848	4	t
LOG0003831	USR0480	VST001197	RT00449	4	f
LOG0003832	USR0366	VST003686	RT00576	2	t
LOG0003833	USR0185	VST004182	RT00135	3	t
LOG0003834	USR0391	VST001339	RT00291	4	t
LOG0003835	USR0423	VST002621	RT00278	4	t
LOG0003836	USR0334	VST000683	RT00176	3	f
LOG0003837	USR0442	VST003515	RT00928	1	f
LOG0003838	USR0184	VST004368	RT00282	1	f
LOG0003839	USR0143	VST002161	RT00120	3	t
LOG0003840	USR0044	VST001730	RT00774	4	t
LOG0003841	USR0012	VST001418	RT00174	3	f
LOG0003842	USR0008	VST004015	RT00439	1	f
LOG0003843	USR0080	VST000019	RT00459	2	f
LOG0003844	USR0297	VST002653	RT00991	2	t
LOG0003845	USR0162	VST003801	RT00630	1	t
LOG0003846	USR0302	VST000465	RT00951	1	f
LOG0003847	USR0216	VST000691	RT00341	1	f
LOG0003848	USR0248	VST001011	RT00697	3	f
LOG0003849	USR0029	VST003062	RT00755	2	t
LOG0003850	USR0272	VST004021	RT00726	1	t
LOG0003851	USR0133	VST000163	RT00121	4	f
LOG0003852	USR0005	VST001636	RT00575	2	f
LOG0003853	USR0244	VST002747	RT00897	3	t
LOG0003854	USR0030	VST000295	RT00661	4	f
LOG0003855	USR0117	VST000579	RT00493	3	f
LOG0003856	USR0178	VST001586	RT00276	1	f
LOG0003857	USR0498	VST003381	RT00969	1	t
LOG0003858	USR0261	VST002350	RT00987	1	f
LOG0003859	USR0235	VST002172	RT00029	4	t
LOG0003860	USR0141	VST000195	RT00811	1	f
LOG0003861	USR0483	VST000842	RT00737	2	t
LOG0003862	USR0305	VST004008	RT00685	1	t
LOG0003863	USR0345	VST004585	RT00244	2	f
LOG0003864	USR0050	VST002932	RT00321	4	t
LOG0003865	USR0270	VST000446	RT00643	3	t
LOG0003866	USR0108	VST000080	RT00352	3	f
LOG0003867	USR0046	VST004841	RT00532	2	f
LOG0003868	USR0474	VST002746	RT00081	4	t
LOG0003869	USR0082	VST003689	RT00293	2	f
LOG0003870	USR0126	VST001861	RT00294	1	f
LOG0003871	USR0084	VST000931	RT00497	1	f
LOG0003872	USR0290	VST001935	RT00458	1	f
LOG0003873	USR0071	VST004368	RT00747	3	f
LOG0003874	USR0175	VST002172	RT00813	2	f
LOG0003875	USR0316	VST003295	RT00733	4	f
LOG0003876	USR0330	VST004782	RT00682	2	t
LOG0003877	USR0463	VST004748	RT00558	2	f
LOG0003878	USR0337	VST004393	RT00060	2	f
LOG0003879	USR0395	VST002835	RT00608	1	f
LOG0003880	USR0354	VST004717	RT00781	1	f
LOG0003881	USR0091	VST001655	RT00543	2	f
LOG0003882	USR0469	VST002929	RT00380	1	f
LOG0003883	USR0351	VST003604	RT00324	3	t
LOG0003884	USR0434	VST001673	RT00628	1	f
LOG0003885	USR0249	VST004351	RT00062	3	t
LOG0003886	USR0132	VST001288	RT00945	3	t
LOG0003887	USR0169	VST002727	RT00146	2	t
LOG0003888	USR0443	VST004125	RT00843	2	t
LOG0003889	USR0060	VST001059	RT00362	1	f
LOG0003890	USR0369	VST004845	RT00053	4	f
LOG0003891	USR0337	VST000602	RT00402	2	f
LOG0003892	USR0241	VST003275	RT00563	3	t
LOG0003893	USR0190	VST002979	RT00681	3	f
LOG0003894	USR0496	VST000131	RT00869	1	t
LOG0003895	USR0340	VST000111	RT00993	3	t
LOG0003896	USR0281	VST002572	RT00869	2	f
LOG0003897	USR0232	VST003360	RT00707	1	t
LOG0003898	USR0471	VST002735	RT00449	1	f
LOG0003899	USR0463	VST000831	RT00083	4	t
LOG0003900	USR0289	VST000666	RT00379	1	t
LOG0003901	USR0275	VST001067	RT00646	4	f
LOG0003902	USR0313	VST004971	RT00458	2	t
LOG0003903	USR0015	VST003789	RT00933	3	f
LOG0003904	USR0041	VST001318	RT00780	2	f
LOG0003905	USR0453	VST000285	RT00081	1	f
LOG0003906	USR0208	VST004660	RT00731	4	t
LOG0003907	USR0060	VST004115	RT00514	3	f
LOG0003908	USR0365	VST003579	RT00309	1	f
LOG0003909	USR0240	VST004643	RT00921	2	f
LOG0003910	USR0096	VST000048	RT00763	1	f
LOG0003911	USR0278	VST001769	RT00494	4	t
LOG0003912	USR0427	VST004315	RT00236	2	f
LOG0003913	USR0160	VST004862	RT00668	1	f
LOG0003914	USR0397	VST003260	RT00941	4	f
LOG0003915	USR0422	VST002079	RT00037	1	f
LOG0003916	USR0282	VST002307	RT00741	4	f
LOG0003917	USR0500	VST003416	RT00657	1	t
LOG0003918	USR0209	VST004404	RT00325	2	f
LOG0003919	USR0133	VST003143	RT00056	2	t
LOG0003920	USR0381	VST000568	RT00121	2	f
LOG0003921	USR0433	VST004327	RT00314	2	t
LOG0003922	USR0097	VST004066	RT00211	2	f
LOG0003923	USR0219	VST000082	RT00772	3	t
LOG0003924	USR0389	VST003006	RT00103	1	t
LOG0003925	USR0485	VST000217	RT00439	2	f
LOG0003926	USR0071	VST000335	RT00817	3	t
LOG0003927	USR0432	VST000559	RT00747	3	f
LOG0003928	USR0274	VST002912	RT00038	1	f
LOG0003929	USR0351	VST000874	RT00813	4	t
LOG0003930	USR0134	VST000753	RT00620	1	t
LOG0003931	USR0066	VST003762	RT00414	1	t
LOG0003932	USR0127	VST000594	RT00224	4	f
LOG0003933	USR0205	VST002752	RT00293	4	t
LOG0003934	USR0298	VST001679	RT00696	2	t
LOG0003935	USR0117	VST003898	RT00155	4	t
LOG0003936	USR0436	VST004649	RT00032	4	f
LOG0003937	USR0267	VST001483	RT00234	1	f
LOG0003938	USR0282	VST000783	RT00907	1	t
LOG0003939	USR0149	VST002135	RT00489	1	t
LOG0003940	USR0194	VST003587	RT00762	4	t
LOG0003941	USR0168	VST003795	RT00570	3	f
LOG0003942	USR0312	VST004609	RT00333	2	t
LOG0003943	USR0374	VST000984	RT00675	1	t
LOG0003944	USR0179	VST004683	RT00017	3	f
LOG0003945	USR0148	VST000743	RT00414	2	f
LOG0003946	USR0465	VST004545	RT00766	1	t
LOG0003947	USR0464	VST004684	RT00658	3	t
LOG0003948	USR0057	VST004356	RT00741	2	f
LOG0003949	USR0490	VST003609	RT00240	1	t
LOG0003950	USR0005	VST003272	RT00286	1	f
LOG0003951	USR0014	VST002511	RT00346	3	t
LOG0003952	USR0280	VST004011	RT00375	4	t
LOG0003953	USR0499	VST000094	RT00016	4	t
LOG0003954	USR0324	VST001376	RT00587	1	f
LOG0003955	USR0436	VST001132	RT00950	3	t
LOG0003956	USR0304	VST002517	RT00260	4	f
LOG0003957	USR0216	VST004964	RT00895	4	t
LOG0003958	USR0175	VST000091	RT00361	4	f
LOG0003959	USR0316	VST001480	RT00399	3	t
LOG0003960	USR0457	VST000955	RT00460	3	f
LOG0003961	USR0003	VST002432	RT00923	2	f
LOG0003962	USR0375	VST000023	RT00516	4	t
LOG0003963	USR0137	VST001726	RT00931	3	f
LOG0003964	USR0466	VST004119	RT00763	2	t
LOG0003965	USR0100	VST003306	RT00085	1	t
LOG0003966	USR0083	VST001722	RT00063	2	t
LOG0003967	USR0280	VST001441	RT00100	4	f
LOG0003968	USR0132	VST004671	RT00834	3	t
LOG0003969	USR0393	VST002151	RT00755	4	t
LOG0003970	USR0481	VST002548	RT00295	4	t
LOG0003971	USR0001	VST004924	RT00924	1	f
LOG0003972	USR0116	VST003555	RT00162	3	t
LOG0003973	USR0499	VST000189	RT00929	3	t
LOG0003974	USR0419	VST000460	RT00178	1	t
LOG0003975	USR0202	VST002237	RT00444	3	t
LOG0003976	USR0140	VST004447	RT00328	2	f
LOG0003977	USR0146	VST000581	RT00328	4	t
LOG0003978	USR0462	VST002162	RT00764	1	t
LOG0003979	USR0266	VST004716	RT00042	1	t
LOG0003980	USR0202	VST001532	RT00242	4	f
LOG0003981	USR0402	VST001369	RT00342	1	t
LOG0003982	USR0152	VST002435	RT00091	3	t
LOG0003983	USR0385	VST002992	RT00028	3	t
LOG0003984	USR0222	VST002903	RT00459	4	t
LOG0003985	USR0079	VST002531	RT00667	1	t
LOG0003986	USR0200	VST000473	RT00631	2	t
LOG0003987	USR0250	VST000859	RT00385	4	f
LOG0003988	USR0099	VST002990	RT00487	3	f
LOG0003989	USR0466	VST002441	RT00220	3	t
LOG0003990	USR0489	VST003707	RT00859	3	f
LOG0003991	USR0400	VST001713	RT00264	2	f
LOG0003992	USR0213	VST000516	RT00121	3	f
LOG0003993	USR0143	VST002394	RT00046	4	t
LOG0003994	USR0190	VST001376	RT00280	4	t
LOG0003995	USR0389	VST003670	RT00115	4	f
LOG0003996	USR0301	VST002391	RT00168	3	t
LOG0003997	USR0374	VST003263	RT00435	2	f
LOG0003998	USR0052	VST004639	RT00246	2	t
LOG0003999	USR0455	VST002867	RT00484	3	f
LOG0004000	USR0112	VST001060	RT00375	1	t
LOG0004001	USR0135	VST000757	RT00280	1	t
LOG0004002	USR0411	VST003496	RT00746	4	f
LOG0004003	USR0473	VST000188	RT00022	2	t
LOG0004004	USR0470	VST002382	RT00714	3	t
LOG0004005	USR0112	VST004579	RT00068	2	f
LOG0004006	USR0013	VST002715	RT00648	2	t
LOG0004007	USR0273	VST000296	RT00743	1	f
LOG0004008	USR0233	VST003534	RT00058	2	f
LOG0004009	USR0044	VST004141	RT00527	2	f
LOG0004010	USR0397	VST004043	RT00264	3	f
LOG0004011	USR0474	VST002043	RT00989	3	t
LOG0004012	USR0073	VST004271	RT00682	2	t
LOG0004013	USR0261	VST003052	RT00423	2	f
LOG0004014	USR0231	VST001801	RT00499	3	t
LOG0004015	USR0033	VST003905	RT00291	1	t
LOG0004016	USR0388	VST003782	RT00169	3	t
LOG0004017	USR0476	VST002262	RT00560	3	t
LOG0004018	USR0410	VST001523	RT00462	3	f
LOG0004019	USR0068	VST004854	RT00608	3	t
LOG0004020	USR0016	VST001421	RT00839	3	f
LOG0004021	USR0485	VST004593	RT00556	1	f
LOG0004022	USR0150	VST000105	RT00353	4	t
LOG0004023	USR0292	VST003624	RT00240	3	t
LOG0004024	USR0102	VST000479	RT00803	3	t
LOG0004025	USR0186	VST000693	RT00283	1	f
LOG0004026	USR0439	VST003039	RT00449	4	f
LOG0004027	USR0419	VST002970	RT00582	2	t
LOG0004028	USR0025	VST000194	RT00765	1	t
LOG0004029	USR0072	VST001490	RT00066	3	f
LOG0004030	USR0081	VST000059	RT00327	2	f
LOG0004031	USR0061	VST001887	RT00456	1	t
LOG0004032	USR0018	VST003610	RT00959	2	t
LOG0004033	USR0242	VST004574	RT00477	1	t
LOG0004034	USR0058	VST002581	RT00848	1	f
LOG0004035	USR0332	VST001969	RT00285	2	f
LOG0004036	USR0377	VST004688	RT00031	4	t
LOG0004037	USR0057	VST004935	RT00448	2	f
LOG0004038	USR0097	VST004054	RT00214	2	f
LOG0004039	USR0215	VST004645	RT00693	4	f
LOG0004040	USR0319	VST003086	RT00714	2	t
LOG0004041	USR0012	VST000221	RT00580	4	t
LOG0004042	USR0011	VST000876	RT00025	4	t
LOG0004043	USR0397	VST003463	RT00760	4	f
LOG0004044	USR0163	VST002726	RT00373	3	f
LOG0004045	USR0283	VST001197	RT00397	1	t
LOG0004046	USR0217	VST002710	RT00337	3	t
LOG0004047	USR0360	VST002732	RT00936	1	f
LOG0004048	USR0323	VST000336	RT00968	3	t
LOG0004049	USR0241	VST000225	RT00855	4	f
LOG0004050	USR0345	VST003942	RT00903	3	t
LOG0004051	USR0045	VST004284	RT00672	1	t
LOG0004052	USR0458	VST001248	RT00280	3	t
LOG0004053	USR0081	VST002691	RT00769	2	f
LOG0004054	USR0255	VST003958	RT00623	2	t
LOG0004055	USR0067	VST004590	RT00559	4	t
LOG0004056	USR0493	VST001887	RT00691	3	t
LOG0004057	USR0406	VST000311	RT00548	3	f
LOG0004058	USR0102	VST002569	RT00923	1	f
LOG0004059	USR0462	VST001605	RT00198	1	t
LOG0004060	USR0091	VST003983	RT00554	3	t
LOG0004061	USR0042	VST000369	RT00479	1	t
LOG0004062	USR0276	VST003547	RT00844	2	t
LOG0004063	USR0304	VST004842	RT00602	2	t
LOG0004064	USR0274	VST000998	RT00857	4	f
LOG0004065	USR0384	VST000497	RT00580	2	f
LOG0004066	USR0077	VST000964	RT00070	1	f
LOG0004067	USR0234	VST002005	RT00505	1	t
LOG0004068	USR0454	VST001199	RT00110	1	f
LOG0004069	USR0202	VST002346	RT00382	1	t
LOG0004070	USR0485	VST000577	RT00397	3	f
LOG0004071	USR0221	VST003161	RT00409	3	t
LOG0004072	USR0262	VST000054	RT00351	3	f
LOG0004073	USR0039	VST003433	RT00534	3	t
LOG0004074	USR0011	VST000229	RT00501	2	f
LOG0004075	USR0112	VST000779	RT00995	1	f
LOG0004076	USR0409	VST003831	RT00789	2	t
LOG0004077	USR0108	VST000985	RT00911	1	t
LOG0004078	USR0492	VST004469	RT00707	3	t
LOG0004079	USR0094	VST000469	RT00421	2	t
LOG0004080	USR0311	VST002468	RT00557	1	t
LOG0004081	USR0084	VST001850	RT00922	3	f
LOG0004082	USR0058	VST000532	RT00111	4	f
LOG0004083	USR0293	VST003036	RT00209	1	f
LOG0004084	USR0016	VST000562	RT00742	4	t
LOG0004085	USR0479	VST000090	RT00439	1	f
LOG0004086	USR0477	VST001407	RT00178	3	f
LOG0004087	USR0326	VST004465	RT00931	2	f
LOG0004088	USR0093	VST003146	RT00762	1	f
LOG0004089	USR0480	VST001293	RT00425	4	t
LOG0004090	USR0457	VST004111	RT00328	3	t
LOG0004091	USR0165	VST003782	RT00884	1	f
LOG0004092	USR0437	VST004068	RT00011	4	f
LOG0004093	USR0215	VST003506	RT00252	1	f
LOG0004094	USR0144	VST002392	RT00856	4	f
LOG0004095	USR0274	VST001219	RT00235	1	f
LOG0004096	USR0403	VST001946	RT00648	2	f
LOG0004097	USR0428	VST002253	RT00254	2	t
LOG0004098	USR0386	VST003892	RT00566	2	f
LOG0004099	USR0442	VST001675	RT00478	2	f
LOG0004100	USR0138	VST000776	RT00129	3	f
LOG0004101	USR0204	VST004782	RT00738	2	f
LOG0004102	USR0302	VST003568	RT00532	1	f
LOG0004103	USR0210	VST002766	RT00100	3	f
LOG0004104	USR0019	VST000225	RT00290	1	f
LOG0004105	USR0294	VST000064	RT00569	4	f
LOG0004106	USR0293	VST001788	RT00226	2	f
LOG0004107	USR0475	VST003851	RT00653	1	f
LOG0004108	USR0368	VST001376	RT00125	1	t
LOG0004109	USR0462	VST003535	RT00438	1	f
LOG0004110	USR0301	VST003916	RT00821	4	f
LOG0004111	USR0373	VST004453	RT00564	4	t
LOG0004112	USR0162	VST000093	RT00646	4	f
LOG0004113	USR0130	VST002743	RT00804	1	f
LOG0004114	USR0044	VST001678	RT00665	4	f
LOG0004115	USR0353	VST003667	RT00347	2	f
LOG0004116	USR0083	VST003865	RT00698	4	t
LOG0004117	USR0380	VST002482	RT00751	4	f
LOG0004118	USR0124	VST004937	RT00183	1	f
LOG0004119	USR0027	VST001402	RT00351	1	f
LOG0004120	USR0304	VST001607	RT00515	1	f
LOG0004121	USR0350	VST003957	RT00796	1	f
LOG0004122	USR0007	VST003410	RT00378	2	t
LOG0004123	USR0411	VST003072	RT00708	1	t
LOG0004124	USR0341	VST000898	RT00465	3	f
LOG0004125	USR0199	VST002932	RT00678	3	t
LOG0004126	USR0112	VST004588	RT00802	1	t
LOG0004127	USR0089	VST003714	RT00340	1	t
LOG0004128	USR0128	VST003132	RT00141	2	f
LOG0004129	USR0230	VST001533	RT00111	3	f
LOG0004130	USR0018	VST001978	RT00261	4	t
LOG0004131	USR0289	VST001799	RT00896	2	t
LOG0004132	USR0161	VST001352	RT00188	4	f
LOG0004133	USR0352	VST001839	RT00856	1	t
LOG0004134	USR0378	VST002561	RT00371	3	f
LOG0004135	USR0281	VST002992	RT00358	4	f
LOG0004136	USR0398	VST001664	RT00273	3	t
LOG0004137	USR0422	VST002398	RT00697	4	f
LOG0004138	USR0166	VST003204	RT00799	2	t
LOG0004139	USR0260	VST004642	RT00604	1	t
LOG0004140	USR0364	VST000599	RT00449	3	t
LOG0004141	USR0190	VST002045	RT00706	2	f
LOG0004142	USR0338	VST000259	RT00417	3	t
LOG0004143	USR0266	VST004572	RT00872	4	f
LOG0004144	USR0291	VST001906	RT00861	4	t
LOG0004145	USR0355	VST003020	RT00388	1	f
LOG0004146	USR0360	VST000388	RT00338	4	t
LOG0004147	USR0279	VST003870	RT00311	1	t
LOG0004148	USR0217	VST001862	RT00920	1	f
LOG0004149	USR0321	VST003633	RT00928	2	f
LOG0004150	USR0338	VST000798	RT00329	1	t
LOG0004151	USR0207	VST002504	RT00047	2	f
LOG0004152	USR0153	VST004021	RT00656	3	t
LOG0004153	USR0480	VST001926	RT00149	4	t
LOG0004154	USR0181	VST003955	RT00350	4	f
LOG0004155	USR0212	VST001628	RT00323	4	f
LOG0004156	USR0273	VST004313	RT00865	1	t
LOG0004157	USR0441	VST000789	RT00927	2	t
LOG0004158	USR0203	VST002057	RT00120	2	t
LOG0004159	USR0205	VST001064	RT00398	2	t
LOG0004160	USR0473	VST004469	RT00646	1	f
LOG0004161	USR0404	VST001448	RT00197	4	t
LOG0004162	USR0384	VST000515	RT00413	4	f
LOG0004163	USR0153	VST004460	RT00439	2	t
LOG0004164	USR0170	VST001914	RT00037	1	f
LOG0004165	USR0429	VST001952	RT00187	4	t
LOG0004166	USR0241	VST000774	RT00420	1	f
LOG0004167	USR0287	VST000329	RT00725	3	t
LOG0004168	USR0245	VST000794	RT00460	3	f
LOG0004169	USR0321	VST000962	RT00110	1	f
LOG0004170	USR0436	VST004693	RT00187	3	f
LOG0004171	USR0080	VST001411	RT00471	4	t
LOG0004172	USR0496	VST001138	RT00078	2	f
LOG0004173	USR0092	VST004667	RT00960	1	f
LOG0004174	USR0149	VST001569	RT00939	3	t
LOG0004175	USR0030	VST004473	RT00374	2	t
LOG0004176	USR0123	VST003275	RT00810	4	t
LOG0004177	USR0387	VST003274	RT00330	4	f
LOG0004178	USR0482	VST003470	RT00125	1	f
LOG0004179	USR0326	VST001964	RT00316	2	f
LOG0004180	USR0427	VST002166	RT00958	4	f
LOG0004181	USR0029	VST004637	RT00320	1	t
LOG0004182	USR0259	VST003573	RT00475	3	f
LOG0004183	USR0186	VST001876	RT00489	2	t
LOG0004184	USR0417	VST001237	RT00826	4	f
LOG0004185	USR0075	VST002747	RT00514	3	t
LOG0004186	USR0045	VST004209	RT00334	2	t
LOG0004187	USR0069	VST004469	RT00071	2	f
LOG0004188	USR0498	VST002347	RT00465	2	f
LOG0004189	USR0416	VST001043	RT00376	4	f
LOG0004190	USR0367	VST004872	RT00724	2	t
LOG0004191	USR0210	VST004767	RT00008	3	t
LOG0004192	USR0239	VST004107	RT00696	4	f
LOG0004193	USR0340	VST000008	RT00980	2	t
LOG0004194	USR0308	VST003697	RT00164	3	f
LOG0004195	USR0192	VST003732	RT00965	4	f
LOG0004196	USR0372	VST001574	RT00781	2	f
LOG0004197	USR0103	VST000461	RT00295	1	f
LOG0004198	USR0241	VST003307	RT00358	1	t
LOG0004199	USR0253	VST002303	RT00081	2	f
LOG0004200	USR0424	VST002634	RT00774	1	t
LOG0004201	USR0220	VST001352	RT00275	4	t
LOG0004202	USR0397	VST000362	RT00921	2	t
LOG0004203	USR0474	VST000788	RT00899	3	t
LOG0004204	USR0336	VST000209	RT00617	1	t
LOG0004205	USR0217	VST000267	RT00821	2	f
LOG0004206	USR0202	VST004752	RT00540	4	t
LOG0004207	USR0029	VST000554	RT00922	2	f
LOG0004208	USR0494	VST001588	RT00047	3	f
LOG0004209	USR0447	VST004517	RT00392	3	f
LOG0004210	USR0486	VST001119	RT00825	2	f
LOG0004211	USR0212	VST001514	RT00567	2	t
LOG0004212	USR0154	VST001927	RT00079	2	t
LOG0004213	USR0480	VST003404	RT00513	2	f
LOG0004214	USR0231	VST003062	RT00680	4	f
LOG0004215	USR0102	VST000221	RT00023	2	f
LOG0004216	USR0315	VST002345	RT00228	4	f
LOG0004217	USR0177	VST001972	RT00438	2	f
LOG0004218	USR0181	VST004439	RT00298	4	f
LOG0004219	USR0472	VST004689	RT00976	3	t
LOG0004220	USR0415	VST004065	RT00946	1	t
LOG0004221	USR0232	VST001985	RT00260	2	t
LOG0004222	USR0012	VST000892	RT00776	2	t
LOG0004223	USR0186	VST004803	RT00676	3	f
LOG0004224	USR0249	VST003527	RT00010	1	t
LOG0004225	USR0420	VST001206	RT00628	3	t
LOG0004226	USR0266	VST004853	RT00158	3	f
LOG0004227	USR0390	VST001219	RT00868	2	t
LOG0004228	USR0135	VST001856	RT00784	2	f
LOG0004229	USR0245	VST002000	RT00158	3	f
LOG0004230	USR0031	VST002436	RT00320	2	f
LOG0004231	USR0347	VST002975	RT00876	2	f
LOG0004232	USR0456	VST003099	RT00202	2	f
LOG0004233	USR0259	VST003387	RT00121	1	t
LOG0004234	USR0104	VST004544	RT00139	1	f
LOG0004235	USR0431	VST001817	RT00674	2	t
LOG0004236	USR0382	VST001778	RT00720	3	f
LOG0004237	USR0469	VST002505	RT00567	1	f
LOG0004238	USR0001	VST002940	RT00339	3	f
LOG0004239	USR0429	VST000839	RT00260	4	t
LOG0004240	USR0438	VST002702	RT00433	4	f
LOG0004241	USR0434	VST004760	RT00044	2	t
LOG0004242	USR0207	VST004861	RT00159	3	t
LOG0004243	USR0135	VST003139	RT00816	3	t
LOG0004244	USR0447	VST000176	RT00355	4	f
LOG0004245	USR0271	VST004606	RT00098	1	t
LOG0004246	USR0089	VST003687	RT00538	3	f
LOG0004247	USR0195	VST003163	RT00871	3	f
LOG0004248	USR0414	VST002753	RT00710	1	f
LOG0004249	USR0122	VST001190	RT00609	2	f
LOG0004250	USR0462	VST004698	RT00239	4	f
LOG0004251	USR0116	VST000838	RT00475	3	f
LOG0004252	USR0196	VST003899	RT00524	2	t
LOG0004253	USR0036	VST003852	RT00557	2	f
LOG0004254	USR0067	VST002734	RT00392	2	f
LOG0004255	USR0133	VST003811	RT00009	1	t
LOG0004256	USR0281	VST002654	RT00513	2	t
LOG0004257	USR0479	VST003251	RT00389	3	f
LOG0004258	USR0011	VST003350	RT00839	2	f
LOG0004259	USR0456	VST003311	RT00210	2	t
LOG0004260	USR0218	VST004681	RT00054	2	t
LOG0004261	USR0322	VST002387	RT00616	4	f
LOG0004262	USR0156	VST000374	RT00152	3	t
LOG0004263	USR0240	VST004676	RT00410	4	t
LOG0004264	USR0060	VST004613	RT00010	4	f
LOG0004265	USR0138	VST001262	RT00957	2	t
LOG0004266	USR0050	VST000121	RT00552	2	t
LOG0004267	USR0167	VST003846	RT00556	2	t
LOG0004268	USR0165	VST002885	RT00880	1	t
LOG0004269	USR0319	VST002618	RT00268	3	t
LOG0004270	USR0189	VST004139	RT00790	1	t
LOG0004271	USR0487	VST003269	RT00667	3	f
LOG0004272	USR0469	VST002043	RT00451	2	f
LOG0004273	USR0092	VST002120	RT00594	3	f
LOG0004274	USR0294	VST000491	RT00197	3	t
LOG0004275	USR0376	VST004845	RT00398	4	t
LOG0004276	USR0289	VST003046	RT00921	3	f
LOG0004277	USR0075	VST000383	RT00052	3	t
LOG0004278	USR0045	VST000805	RT00735	4	f
LOG0004279	USR0428	VST001178	RT00469	1	t
LOG0004280	USR0385	VST002218	RT00368	3	t
LOG0004281	USR0053	VST001296	RT00374	1	t
LOG0004282	USR0175	VST000918	RT00059	1	f
LOG0004283	USR0161	VST004247	RT00294	2	f
LOG0004284	USR0067	VST004527	RT00788	3	f
LOG0004285	USR0474	VST002415	RT00846	4	f
LOG0004286	USR0399	VST000651	RT00788	4	f
LOG0004287	USR0361	VST004916	RT00952	2	t
LOG0004288	USR0270	VST002287	RT00869	4	t
LOG0004289	USR0407	VST002752	RT00110	3	t
LOG0004290	USR0124	VST003199	RT00542	1	t
LOG0004291	USR0182	VST000942	RT00107	1	f
LOG0004292	USR0376	VST000541	RT00297	4	f
LOG0004293	USR0392	VST002681	RT00852	4	f
LOG0004294	USR0182	VST003728	RT00839	4	t
LOG0004295	USR0036	VST002530	RT00831	1	f
LOG0004296	USR0212	VST001203	RT00965	3	f
LOG0004297	USR0384	VST004965	RT00095	3	t
LOG0004298	USR0436	VST000651	RT00797	3	t
LOG0004299	USR0134	VST003007	RT00719	3	f
LOG0004300	USR0353	VST004533	RT00985	3	f
LOG0004301	USR0412	VST002905	RT00845	2	f
LOG0004302	USR0178	VST000314	RT00684	4	t
LOG0004303	USR0166	VST004115	RT00472	3	t
LOG0004304	USR0414	VST001184	RT00079	2	t
LOG0004305	USR0494	VST004914	RT00984	3	t
LOG0004306	USR0491	VST000122	RT00250	4	t
LOG0004307	USR0337	VST000169	RT00730	3	t
LOG0004308	USR0329	VST003683	RT00339	3	f
LOG0004309	USR0476	VST004725	RT00057	3	f
LOG0004310	USR0438	VST004122	RT00920	4	f
LOG0004311	USR0327	VST003969	RT00147	1	t
LOG0004312	USR0046	VST004018	RT00746	4	t
LOG0004313	USR0156	VST003698	RT00017	1	f
LOG0004314	USR0401	VST001730	RT00368	2	f
LOG0004315	USR0488	VST003556	RT00709	2	t
LOG0004316	USR0432	VST001119	RT00189	3	t
LOG0004317	USR0428	VST002169	RT00644	3	t
LOG0004318	USR0236	VST004222	RT00248	3	f
LOG0004319	USR0316	VST004782	RT00150	4	t
LOG0004320	USR0060	VST003117	RT00714	3	t
LOG0004321	USR0005	VST004731	RT00213	1	t
LOG0004322	USR0453	VST002430	RT00217	2	t
LOG0004323	USR0462	VST002008	RT00006	2	f
LOG0004324	USR0454	VST001051	RT00670	2	f
LOG0004325	USR0391	VST000705	RT00861	1	t
LOG0004326	USR0181	VST002900	RT00587	3	t
LOG0004327	USR0145	VST003208	RT00395	1	t
LOG0004328	USR0315	VST000707	RT00763	1	t
LOG0004329	USR0265	VST003833	RT00304	4	t
LOG0004330	USR0223	VST002009	RT00558	4	t
LOG0004331	USR0406	VST004722	RT00411	2	t
LOG0004332	USR0301	VST004622	RT00403	1	t
LOG0004333	USR0457	VST001598	RT00854	2	f
LOG0004334	USR0443	VST001067	RT00860	1	f
LOG0004335	USR0336	VST001947	RT00827	2	t
LOG0004336	USR0484	VST002800	RT00380	2	f
LOG0004337	USR0482	VST000096	RT00452	3	f
LOG0004338	USR0237	VST002075	RT00229	2	f
LOG0004339	USR0013	VST004932	RT00694	4	f
LOG0004340	USR0339	VST001919	RT00505	1	t
LOG0004341	USR0268	VST001266	RT00595	2	t
LOG0004342	USR0420	VST002535	RT00145	1	t
LOG0004343	USR0266	VST000240	RT00050	2	t
LOG0004344	USR0016	VST001328	RT00424	4	f
LOG0004345	USR0092	VST001143	RT00100	3	f
LOG0004346	USR0248	VST003224	RT00343	3	f
LOG0004347	USR0019	VST003849	RT00882	1	f
LOG0004348	USR0360	VST001416	RT00732	2	t
LOG0004349	USR0390	VST002399	RT00651	4	t
LOG0004350	USR0388	VST000761	RT00890	1	t
LOG0004351	USR0414	VST003643	RT00526	3	f
LOG0004352	USR0103	VST001553	RT00013	1	t
LOG0004353	USR0095	VST000863	RT00856	1	t
LOG0004354	USR0430	VST004036	RT00762	2	t
LOG0004355	USR0283	VST001156	RT00848	4	f
LOG0004356	USR0429	VST000357	RT00924	3	t
LOG0004357	USR0213	VST001672	RT00990	3	t
LOG0004358	USR0037	VST001329	RT00172	4	t
LOG0004359	USR0393	VST001030	RT00489	2	t
LOG0004360	USR0061	VST002377	RT00831	4	f
LOG0004361	USR0291	VST003242	RT00359	4	t
LOG0004362	USR0362	VST001992	RT00106	2	f
LOG0004363	USR0303	VST003872	RT00189	2	t
LOG0004364	USR0244	VST002386	RT00987	3	t
LOG0004365	USR0405	VST003141	RT00529	3	t
LOG0004366	USR0401	VST000882	RT00050	2	t
LOG0004367	USR0311	VST000539	RT00249	1	t
LOG0004368	USR0344	VST004833	RT00410	3	f
LOG0004369	USR0351	VST001858	RT00391	2	t
LOG0004370	USR0006	VST003558	RT00379	2	t
LOG0004371	USR0377	VST004539	RT00227	1	t
LOG0004372	USR0419	VST002197	RT00591	4	f
LOG0004373	USR0306	VST001951	RT00784	2	f
LOG0004374	USR0165	VST001611	RT00213	1	t
LOG0004375	USR0013	VST003164	RT00529	1	f
LOG0004376	USR0025	VST004464	RT00346	3	t
LOG0004377	USR0224	VST004008	RT00419	2	f
LOG0004378	USR0123	VST004676	RT00763	3	t
LOG0004379	USR0129	VST004752	RT00852	4	f
LOG0004380	USR0305	VST000227	RT00084	4	f
LOG0004381	USR0122	VST000592	RT00919	3	f
LOG0004382	USR0035	VST004120	RT00197	3	f
LOG0004383	USR0083	VST002076	RT00777	2	f
LOG0004384	USR0309	VST004949	RT00983	2	f
LOG0004385	USR0436	VST002672	RT00530	2	f
LOG0004386	USR0182	VST001369	RT00221	4	f
LOG0004387	USR0076	VST002023	RT00843	3	t
LOG0004388	USR0104	VST002079	RT00747	1	t
LOG0004389	USR0232	VST003951	RT00176	3	t
LOG0004390	USR0303	VST003882	RT00584	1	t
LOG0004391	USR0043	VST003322	RT00603	2	t
LOG0004392	USR0404	VST004146	RT00322	2	t
LOG0004393	USR0417	VST002437	RT00535	3	f
LOG0004394	USR0093	VST001805	RT00725	1	f
LOG0004395	USR0144	VST003360	RT00394	4	f
LOG0004396	USR0254	VST001731	RT00806	2	t
LOG0004397	USR0078	VST003663	RT00640	2	f
LOG0004398	USR0263	VST002974	RT00571	3	f
LOG0004399	USR0070	VST001030	RT00324	3	f
LOG0004400	USR0149	VST000412	RT00085	4	f
LOG0004401	USR0292	VST001982	RT00741	3	t
LOG0004402	USR0214	VST000662	RT00887	4	f
LOG0004403	USR0360	VST001348	RT00427	1	f
LOG0004404	USR0310	VST003471	RT00268	4	t
LOG0004405	USR0147	VST001306	RT00112	1	t
LOG0004406	USR0025	VST004287	RT00628	2	t
LOG0004407	USR0323	VST002834	RT00949	3	f
LOG0004408	USR0484	VST004681	RT00750	2	f
LOG0004409	USR0109	VST001854	RT00398	4	f
LOG0004410	USR0181	VST004596	RT00052	4	t
LOG0004411	USR0251	VST004676	RT00084	4	f
LOG0004412	USR0482	VST000816	RT00623	1	t
LOG0004413	USR0203	VST003506	RT00712	2	t
LOG0004414	USR0304	VST001477	RT00731	2	t
LOG0004415	USR0170	VST003514	RT00741	4	f
LOG0004416	USR0175	VST002038	RT00829	3	t
LOG0004417	USR0347	VST001331	RT00425	2	t
LOG0004418	USR0170	VST004876	RT00021	3	f
LOG0004419	USR0002	VST003807	RT00688	2	t
LOG0004420	USR0134	VST001150	RT00056	4	t
LOG0004421	USR0127	VST000007	RT00291	4	f
LOG0004422	USR0046	VST001437	RT00812	2	f
LOG0004423	USR0194	VST003251	RT00807	1	t
LOG0004424	USR0362	VST003540	RT00655	1	t
LOG0004425	USR0209	VST000695	RT00908	2	f
LOG0004426	USR0296	VST002966	RT00373	4	t
LOG0004427	USR0058	VST003300	RT00738	2	t
LOG0004428	USR0496	VST004844	RT00008	3	t
LOG0004429	USR0078	VST004242	RT00124	4	t
LOG0004430	USR0202	VST003368	RT00758	1	f
LOG0004431	USR0493	VST004953	RT00101	1	t
LOG0004432	USR0289	VST004383	RT00990	2	t
LOG0004433	USR0490	VST000026	RT00835	3	f
LOG0004434	USR0062	VST004548	RT00862	4	t
LOG0004435	USR0268	VST002154	RT00093	1	t
LOG0004436	USR0126	VST004336	RT00385	2	t
LOG0004437	USR0480	VST003490	RT00766	2	t
LOG0004438	USR0049	VST000332	RT00080	4	f
LOG0004439	USR0088	VST000645	RT00298	2	f
LOG0004440	USR0334	VST001853	RT00031	2	t
LOG0004441	USR0261	VST004131	RT00378	2	f
LOG0004442	USR0179	VST002924	RT00330	1	f
LOG0004443	USR0069	VST002432	RT00926	1	f
LOG0004444	USR0367	VST003585	RT00299	3	t
LOG0004445	USR0416	VST003810	RT00282	4	t
LOG0004446	USR0493	VST000811	RT00012	4	f
LOG0004447	USR0433	VST001312	RT00639	4	f
LOG0004448	USR0481	VST002796	RT00872	4	f
LOG0004449	USR0060	VST001895	RT00699	2	f
LOG0004450	USR0302	VST003007	RT00069	4	f
LOG0004451	USR0452	VST004301	RT00841	3	f
LOG0004452	USR0249	VST002071	RT00523	4	f
LOG0004453	USR0478	VST002657	RT00815	4	t
LOG0004454	USR0169	VST004135	RT00023	2	t
LOG0004455	USR0465	VST004269	RT00337	2	t
LOG0004456	USR0451	VST004856	RT00427	2	t
LOG0004457	USR0269	VST003485	RT00845	3	f
LOG0004458	USR0364	VST000414	RT00209	2	t
LOG0004459	USR0112	VST000692	RT00215	4	f
LOG0004460	USR0100	VST002663	RT00635	3	t
LOG0004461	USR0402	VST004118	RT00423	1	t
LOG0004462	USR0215	VST002699	RT00073	2	f
LOG0004463	USR0483	VST004310	RT00722	3	f
LOG0004464	USR0113	VST000920	RT00823	1	t
LOG0004465	USR0097	VST000907	RT00786	2	t
LOG0004466	USR0307	VST003211	RT00606	1	t
LOG0004467	USR0118	VST003729	RT00938	2	t
LOG0004468	USR0036	VST002720	RT00748	3	t
LOG0004469	USR0337	VST003667	RT00666	2	f
LOG0004470	USR0359	VST004896	RT00274	2	f
LOG0004471	USR0290	VST002365	RT00725	3	f
LOG0004472	USR0396	VST000793	RT00640	3	f
LOG0004473	USR0389	VST000576	RT00233	4	f
LOG0004474	USR0304	VST001728	RT00041	4	f
LOG0004475	USR0360	VST003228	RT00938	3	t
LOG0004476	USR0347	VST003572	RT00289	2	f
LOG0004477	USR0124	VST004187	RT00555	1	t
LOG0004478	USR0040	VST003726	RT00270	3	t
LOG0004479	USR0141	VST004857	RT00439	1	t
LOG0004480	USR0026	VST003367	RT00314	4	t
LOG0004481	USR0142	VST004866	RT00510	4	t
LOG0004482	USR0352	VST001361	RT00394	3	t
LOG0004483	USR0395	VST002049	RT00028	3	t
LOG0004484	USR0422	VST002976	RT00270	2	t
LOG0004485	USR0336	VST003197	RT00467	4	f
LOG0004486	USR0057	VST001088	RT00922	4	f
LOG0004487	USR0150	VST000206	RT00074	3	t
LOG0004488	USR0367	VST003487	RT00657	1	t
LOG0004489	USR0400	VST003316	RT00674	2	f
LOG0004490	USR0205	VST000623	RT00246	3	t
LOG0004491	USR0076	VST001678	RT00782	1	f
LOG0004492	USR0466	VST003288	RT00410	2	t
LOG0004493	USR0285	VST003013	RT00498	1	t
LOG0004494	USR0210	VST003013	RT00418	2	t
LOG0004495	USR0494	VST003638	RT00211	2	t
LOG0004496	USR0386	VST002701	RT00792	2	t
LOG0004497	USR0438	VST001872	RT00223	4	f
LOG0004498	USR0258	VST000079	RT00360	3	t
LOG0004499	USR0259	VST001477	RT00582	4	t
LOG0004500	USR0477	VST004735	RT00020	4	f
LOG0004501	USR0184	VST003229	RT00423	2	t
LOG0004502	USR0328	VST002336	RT00121	3	f
LOG0004503	USR0011	VST001726	RT00173	3	f
LOG0004504	USR0460	VST001115	RT00034	3	f
LOG0004505	USR0160	VST000161	RT00918	3	t
LOG0004506	USR0260	VST001426	RT00071	2	f
LOG0004507	USR0393	VST001734	RT00545	3	t
LOG0004508	USR0088	VST004416	RT00774	1	t
LOG0004509	USR0369	VST002412	RT00784	1	t
LOG0004510	USR0184	VST003961	RT00968	4	f
LOG0004511	USR0016	VST002523	RT00621	2	f
LOG0004512	USR0465	VST004862	RT00535	4	t
LOG0004513	USR0495	VST000602	RT00658	4	t
LOG0004514	USR0244	VST002360	RT00014	3	f
LOG0004515	USR0086	VST001556	RT00306	1	t
LOG0004516	USR0199	VST004685	RT00829	1	f
LOG0004517	USR0010	VST001521	RT00548	3	t
LOG0004518	USR0477	VST002391	RT00271	3	f
LOG0004519	USR0164	VST000906	RT00773	2	f
LOG0004520	USR0024	VST001651	RT00053	1	f
LOG0004521	USR0064	VST001118	RT00494	4	f
LOG0004522	USR0312	VST001525	RT00560	4	t
LOG0004523	USR0238	VST004268	RT00463	2	f
LOG0004524	USR0462	VST004722	RT00523	1	t
LOG0004525	USR0462	VST003081	RT00770	3	f
LOG0004526	USR0345	VST004778	RT00855	4	f
LOG0004527	USR0238	VST003241	RT00792	1	t
LOG0004528	USR0022	VST004407	RT00722	1	f
LOG0004529	USR0180	VST003802	RT00324	1	t
LOG0004530	USR0306	VST001936	RT00847	3	t
LOG0004531	USR0047	VST003628	RT00524	4	f
LOG0004532	USR0279	VST004381	RT00443	3	t
LOG0004533	USR0224	VST003710	RT00251	1	t
LOG0004534	USR0218	VST002543	RT00835	1	f
LOG0004535	USR0499	VST004451	RT00160	4	t
LOG0004536	USR0475	VST000200	RT00036	4	t
LOG0004537	USR0237	VST002184	RT00661	3	f
LOG0004538	USR0204	VST002676	RT00880	3	t
LOG0004539	USR0339	VST004037	RT00198	3	f
LOG0004540	USR0019	VST003494	RT00450	1	t
LOG0004541	USR0180	VST003973	RT00378	4	f
LOG0004542	USR0162	VST001365	RT00246	2	t
LOG0004543	USR0480	VST001853	RT00393	4	t
LOG0004544	USR0285	VST004438	RT00204	4	f
LOG0004545	USR0061	VST003602	RT00044	4	t
LOG0004546	USR0085	VST000388	RT00315	2	f
LOG0004547	USR0035	VST004100	RT00408	3	t
LOG0004548	USR0490	VST004773	RT00895	2	f
LOG0004549	USR0005	VST001663	RT00831	4	f
LOG0004550	USR0076	VST002459	RT00206	4	t
LOG0004551	USR0253	VST000213	RT00241	1	f
LOG0004552	USR0007	VST004656	RT00041	4	f
LOG0004553	USR0169	VST000558	RT00588	2	t
LOG0004554	USR0130	VST002606	RT00987	2	t
LOG0004555	USR0473	VST003120	RT00714	2	f
LOG0004556	USR0138	VST003704	RT00363	3	f
LOG0004557	USR0358	VST002692	RT00898	1	f
LOG0004558	USR0300	VST001995	RT00095	3	t
LOG0004559	USR0326	VST000475	RT00540	2	f
LOG0004560	USR0091	VST001768	RT00144	3	f
LOG0004561	USR0163	VST000042	RT00059	1	f
LOG0004562	USR0318	VST002652	RT00641	1	t
LOG0004563	USR0458	VST002096	RT00854	1	f
LOG0004564	USR0253	VST003993	RT00509	1	f
LOG0004565	USR0201	VST001987	RT00513	2	t
LOG0004566	USR0020	VST003866	RT00799	4	f
LOG0004567	USR0229	VST003658	RT00022	2	t
LOG0004568	USR0163	VST004824	RT00738	2	f
LOG0004569	USR0165	VST003518	RT00204	2	t
LOG0004570	USR0232	VST002269	RT00699	2	t
LOG0004571	USR0328	VST001645	RT00887	3	f
LOG0004572	USR0238	VST000940	RT00471	1	f
LOG0004573	USR0120	VST004439	RT00284	4	t
LOG0004574	USR0438	VST003310	RT00372	4	t
LOG0004575	USR0351	VST002986	RT00498	4	f
LOG0004576	USR0383	VST004937	RT00332	2	f
LOG0004577	USR0369	VST002028	RT00027	1	t
LOG0004578	USR0107	VST003128	RT00855	1	f
LOG0004579	USR0250	VST004990	RT00129	4	f
LOG0004580	USR0336	VST004134	RT00380	4	f
LOG0004581	USR0284	VST001365	RT00507	2	f
LOG0004582	USR0198	VST000851	RT00875	4	t
LOG0004583	USR0416	VST000231	RT00898	2	f
LOG0004584	USR0220	VST002500	RT00095	4	f
LOG0004585	USR0395	VST002305	RT00578	1	t
LOG0004586	USR0426	VST002482	RT00177	1	t
LOG0004587	USR0151	VST004305	RT00473	1	f
LOG0004588	USR0286	VST003712	RT00486	3	f
LOG0004589	USR0265	VST002904	RT00275	4	t
LOG0004590	USR0220	VST003466	RT00668	3	f
LOG0004591	USR0216	VST002769	RT00966	1	t
LOG0004592	USR0315	VST002893	RT00423	4	f
LOG0004593	USR0156	VST002084	RT00531	3	f
LOG0004594	USR0216	VST001239	RT00895	1	f
LOG0004595	USR0335	VST002075	RT00884	1	f
LOG0004596	USR0359	VST002066	RT00320	4	f
LOG0004597	USR0114	VST000630	RT00058	4	f
LOG0004598	USR0161	VST003209	RT00273	2	t
LOG0004599	USR0303	VST004675	RT00198	4	f
LOG0004600	USR0098	VST000903	RT00079	1	f
LOG0004601	USR0406	VST001054	RT00982	2	f
LOG0004602	USR0157	VST000123	RT00041	2	f
LOG0004603	USR0162	VST000957	RT00738	4	t
LOG0004604	USR0042	VST000987	RT00773	1	t
LOG0004605	USR0180	VST001252	RT00245	3	f
LOG0004606	USR0303	VST004434	RT00023	1	f
LOG0004607	USR0330	VST000991	RT00709	1	t
LOG0004608	USR0051	VST002321	RT00236	4	f
LOG0004609	USR0252	VST000902	RT00126	3	f
LOG0004610	USR0429	VST002087	RT00778	2	t
LOG0004611	USR0350	VST003993	RT00836	3	t
LOG0004612	USR0120	VST004522	RT00140	4	f
LOG0004613	USR0075	VST004710	RT00879	1	f
LOG0004614	USR0162	VST003581	RT00394	1	t
LOG0004615	USR0149	VST002803	RT00828	3	t
LOG0004616	USR0123	VST002205	RT00127	3	f
LOG0004617	USR0141	VST000872	RT00798	4	f
LOG0004618	USR0182	VST002825	RT00114	3	t
LOG0004619	USR0409	VST002903	RT00920	4	f
LOG0004620	USR0378	VST004731	RT00837	2	t
LOG0004621	USR0277	VST002504	RT00525	3	t
LOG0004622	USR0257	VST003404	RT00228	1	t
LOG0004623	USR0442	VST002192	RT00521	3	f
LOG0004624	USR0325	VST003883	RT00146	1	t
LOG0004625	USR0245	VST004583	RT00163	2	t
LOG0004626	USR0086	VST003208	RT00735	2	f
LOG0004627	USR0071	VST003659	RT00728	3	t
LOG0004628	USR0269	VST003098	RT00900	4	t
LOG0004629	USR0493	VST003079	RT00169	1	f
LOG0004630	USR0180	VST002639	RT00538	2	t
LOG0004631	USR0279	VST003087	RT00125	3	f
LOG0004632	USR0149	VST002947	RT00300	2	f
LOG0004633	USR0006	VST003472	RT00250	3	t
LOG0004634	USR0148	VST004303	RT00938	1	t
LOG0004635	USR0332	VST001625	RT00522	3	t
LOG0004636	USR0168	VST002958	RT00105	1	t
LOG0004637	USR0009	VST003288	RT00618	2	t
LOG0004638	USR0178	VST001526	RT00969	1	f
LOG0004639	USR0284	VST001483	RT00513	1	f
LOG0004640	USR0395	VST000259	RT00694	4	t
LOG0004641	USR0116	VST000454	RT00912	2	t
LOG0004642	USR0096	VST000799	RT00506	1	f
LOG0004643	USR0331	VST004471	RT00302	4	t
LOG0004644	USR0344	VST002512	RT00653	4	t
LOG0004645	USR0056	VST004171	RT00230	1	t
LOG0004646	USR0207	VST000242	RT00064	3	f
LOG0004647	USR0105	VST001713	RT00590	1	f
LOG0004648	USR0035	VST004219	RT00232	3	f
LOG0004649	USR0209	VST002003	RT00599	1	f
LOG0004650	USR0281	VST003328	RT00183	2	t
LOG0004651	USR0369	VST002282	RT00319	4	t
LOG0004652	USR0355	VST000497	RT00658	1	t
LOG0004653	USR0147	VST003112	RT00829	1	f
LOG0004654	USR0489	VST000727	RT00092	1	t
LOG0004655	USR0287	VST001832	RT00635	3	f
LOG0004656	USR0081	VST001822	RT00788	2	t
LOG0004657	USR0050	VST001817	RT00961	2	f
LOG0004658	USR0087	VST000092	RT00064	1	t
LOG0004659	USR0191	VST003433	RT00844	4	t
LOG0004660	USR0303	VST001970	RT00219	4	t
LOG0004661	USR0001	VST002385	RT00704	1	t
LOG0004662	USR0381	VST003680	RT00619	3	t
LOG0004663	USR0442	VST004609	RT00909	4	t
LOG0004664	USR0138	VST000603	RT00247	2	t
LOG0004665	USR0136	VST000428	RT00964	4	t
LOG0004666	USR0362	VST002020	RT00473	4	t
LOG0004667	USR0381	VST001457	RT00966	1	f
LOG0004668	USR0154	VST000007	RT00057	4	f
LOG0004669	USR0162	VST002435	RT00045	1	f
LOG0004670	USR0019	VST001374	RT00888	2	f
LOG0004671	USR0462	VST000641	RT00086	4	f
LOG0004672	USR0328	VST003763	RT00038	1	f
LOG0004673	USR0243	VST004006	RT00182	1	t
LOG0004674	USR0129	VST002231	RT00164	2	t
LOG0004675	USR0176	VST004661	RT00757	4	f
LOG0004676	USR0409	VST003812	RT00835	3	f
LOG0004677	USR0280	VST003307	RT00889	4	t
LOG0004678	USR0431	VST000446	RT00126	1	t
LOG0004679	USR0084	VST003942	RT00207	1	t
LOG0004680	USR0376	VST004296	RT00267	2	t
LOG0004681	USR0222	VST002996	RT00354	2	f
LOG0004682	USR0325	VST000513	RT00411	3	f
LOG0004683	USR0451	VST000990	RT00599	3	t
LOG0004684	USR0416	VST001402	RT00657	1	f
LOG0004685	USR0145	VST001813	RT00122	3	f
LOG0004686	USR0445	VST000546	RT00508	3	t
LOG0004687	USR0106	VST002534	RT00983	3	t
LOG0004688	USR0325	VST002010	RT00610	4	t
LOG0004689	USR0011	VST003433	RT00469	4	t
LOG0004690	USR0166	VST004086	RT00801	1	f
LOG0004691	USR0196	VST002216	RT00133	4	t
LOG0004692	USR0231	VST004986	RT00379	3	t
LOG0004693	USR0147	VST003666	RT00849	3	f
LOG0004694	USR0359	VST000828	RT00318	3	t
LOG0004695	USR0238	VST002185	RT00577	4	t
LOG0004696	USR0497	VST002163	RT00711	2	f
LOG0004697	USR0471	VST001276	RT00125	3	t
LOG0004698	USR0401	VST001517	RT00451	3	t
LOG0004699	USR0013	VST001313	RT00858	2	f
LOG0004700	USR0219	VST003524	RT00720	2	t
LOG0004701	USR0257	VST000516	RT00208	1	t
LOG0004702	USR0002	VST004784	RT00300	1	f
LOG0004703	USR0210	VST001020	RT00489	4	f
LOG0004704	USR0484	VST001296	RT00633	2	t
LOG0004705	USR0365	VST001050	RT00142	1	t
LOG0004706	USR0225	VST002341	RT00474	3	t
LOG0004707	USR0484	VST001258	RT00859	1	t
LOG0004708	USR0194	VST002279	RT00569	3	f
LOG0004709	USR0196	VST002986	RT00304	3	f
LOG0004710	USR0400	VST003870	RT00657	3	f
LOG0004711	USR0260	VST001145	RT00556	4	t
LOG0004712	USR0057	VST004614	RT00644	2	f
LOG0004713	USR0457	VST000706	RT00593	4	t
LOG0004714	USR0113	VST002425	RT00865	1	t
LOG0004715	USR0213	VST003572	RT00030	1	f
LOG0004716	USR0279	VST001935	RT00377	2	f
LOG0004717	USR0244	VST002485	RT00341	2	f
LOG0004718	USR0380	VST001746	RT00209	1	t
LOG0004719	USR0117	VST000970	RT00971	2	f
LOG0004720	USR0386	VST002547	RT00243	2	t
LOG0004721	USR0451	VST002648	RT00695	3	f
LOG0004722	USR0087	VST000778	RT00158	4	t
LOG0004723	USR0410	VST001334	RT00146	4	f
LOG0004724	USR0381	VST002118	RT00340	4	t
LOG0004725	USR0367	VST002389	RT00866	3	t
LOG0004726	USR0263	VST003104	RT00745	3	f
LOG0004727	USR0484	VST003115	RT00092	2	t
LOG0004728	USR0300	VST004214	RT00329	2	f
LOG0004729	USR0417	VST002937	RT00172	3	t
LOG0004730	USR0113	VST004111	RT00702	3	f
LOG0004731	USR0448	VST001346	RT00031	1	f
LOG0004732	USR0164	VST002042	RT00621	3	t
LOG0004733	USR0004	VST002675	RT00272	3	f
LOG0004734	USR0118	VST001556	RT00095	4	t
LOG0004735	USR0023	VST000690	RT00989	1	t
LOG0004736	USR0409	VST004870	RT00077	4	f
LOG0004737	USR0233	VST003453	RT00151	4	f
LOG0004738	USR0090	VST001535	RT00142	1	t
LOG0004739	USR0476	VST000120	RT00231	1	t
LOG0004740	USR0255	VST004160	RT00770	1	t
LOG0004741	USR0092	VST004556	RT00908	2	t
LOG0004742	USR0469	VST004055	RT00954	1	t
LOG0004743	USR0458	VST002853	RT00128	4	f
LOG0004744	USR0155	VST001614	RT00860	1	f
LOG0004745	USR0307	VST003034	RT00736	2	t
LOG0004746	USR0115	VST002784	RT00696	4	t
LOG0004747	USR0207	VST002937	RT00497	1	t
LOG0004748	USR0081	VST004064	RT00280	1	f
LOG0004749	USR0103	VST003889	RT00805	4	f
LOG0004750	USR0483	VST003785	RT00541	4	f
LOG0004751	USR0453	VST002627	RT00810	1	t
LOG0004752	USR0080	VST003545	RT00530	2	f
LOG0004753	USR0407	VST001150	RT00131	4	f
LOG0004754	USR0103	VST004803	RT00461	3	f
LOG0004755	USR0240	VST001710	RT00269	1	f
LOG0004756	USR0265	VST003159	RT00618	4	t
LOG0004757	USR0033	VST001367	RT00669	4	t
LOG0004758	USR0035	VST004050	RT00962	1	f
LOG0004759	USR0249	VST004491	RT00571	1	f
LOG0004760	USR0488	VST004580	RT00604	1	t
LOG0004761	USR0050	VST004762	RT00944	2	t
LOG0004762	USR0280	VST000456	RT00260	3	f
LOG0004763	USR0472	VST004306	RT00051	4	f
LOG0004764	USR0242	VST004621	RT00133	1	f
LOG0004765	USR0152	VST000676	RT00679	1	t
LOG0004766	USR0147	VST001002	RT00809	2	f
LOG0004767	USR0039	VST004072	RT00005	3	t
LOG0004768	USR0189	VST000896	RT00648	4	f
LOG0004769	USR0025	VST002355	RT00738	3	f
LOG0004770	USR0244	VST003094	RT00502	3	t
LOG0004771	USR0223	VST000060	RT00184	1	f
LOG0004772	USR0230	VST004482	RT00409	1	f
LOG0004773	USR0153	VST002765	RT00091	1	f
LOG0004774	USR0411	VST001795	RT00436	2	f
LOG0004775	USR0288	VST003263	RT00820	2	f
LOG0004776	USR0395	VST002530	RT00903	2	t
LOG0004777	USR0453	VST001943	RT00189	1	f
LOG0004778	USR0108	VST003488	RT00996	1	t
LOG0004779	USR0033	VST004892	RT00480	1	t
LOG0004780	USR0403	VST004988	RT00981	3	t
LOG0004781	USR0363	VST003422	RT00815	2	t
LOG0004782	USR0111	VST004697	RT00383	2	f
LOG0004783	USR0121	VST004079	RT00850	3	t
LOG0004784	USR0016	VST001374	RT00322	4	t
LOG0004785	USR0227	VST003554	RT00443	3	t
LOG0004786	USR0011	VST003673	RT00490	3	t
LOG0004787	USR0203	VST001083	RT00133	1	t
LOG0004788	USR0202	VST004248	RT00684	4	t
LOG0004789	USR0098	VST000934	RT00426	3	t
LOG0004790	USR0116	VST002588	RT00250	4	f
LOG0004791	USR0453	VST004086	RT00061	4	f
LOG0004792	USR0471	VST000558	RT00959	1	f
LOG0004793	USR0439	VST004714	RT00562	4	t
LOG0004794	USR0281	VST004120	RT00422	1	f
LOG0004795	USR0349	VST001543	RT00476	2	t
LOG0004796	USR0232	VST002383	RT00223	3	f
LOG0004797	USR0461	VST004099	RT00438	1	f
LOG0004798	USR0111	VST001008	RT00684	1	f
LOG0004799	USR0352	VST001282	RT00920	3	f
LOG0004800	USR0418	VST004359	RT00384	1	t
LOG0004801	USR0012	VST000121	RT00319	4	f
LOG0004802	USR0472	VST004117	RT00225	1	t
LOG0004803	USR0488	VST000905	RT00423	1	f
LOG0004804	USR0021	VST000140	RT00908	4	f
LOG0004805	USR0127	VST001816	RT00191	3	t
LOG0004806	USR0285	VST004302	RT00871	1	t
LOG0004807	USR0435	VST004139	RT00777	2	t
LOG0004808	USR0121	VST001029	RT00756	3	t
LOG0004809	USR0124	VST002255	RT00079	2	t
LOG0004810	USR0407	VST000345	RT00855	2	f
LOG0004811	USR0033	VST002420	RT00365	2	t
LOG0004812	USR0392	VST003304	RT00022	1	t
LOG0004813	USR0170	VST003236	RT00548	4	t
LOG0004814	USR0077	VST002595	RT00330	1	t
LOG0004815	USR0453	VST001388	RT00156	2	t
LOG0004816	USR0297	VST004018	RT00056	2	t
LOG0004817	USR0330	VST000984	RT00867	4	f
LOG0004818	USR0063	VST004431	RT00248	3	t
LOG0004819	USR0270	VST002123	RT00925	2	t
LOG0004820	USR0216	VST002995	RT00261	1	f
LOG0004821	USR0190	VST002901	RT00772	2	f
LOG0004822	USR0075	VST000776	RT00435	2	f
LOG0004823	USR0174	VST003919	RT00527	3	f
LOG0004824	USR0067	VST004982	RT00478	4	f
LOG0004825	USR0093	VST000736	RT00700	2	f
LOG0004826	USR0053	VST001487	RT00538	3	t
LOG0004827	USR0496	VST000396	RT00535	3	f
LOG0004828	USR0436	VST004779	RT00381	2	t
LOG0004829	USR0094	VST002002	RT00103	2	f
LOG0004830	USR0113	VST003448	RT00029	4	f
LOG0004831	USR0229	VST000364	RT00854	1	f
LOG0004832	USR0250	VST003288	RT00483	1	t
LOG0004833	USR0391	VST001855	RT00057	4	f
LOG0004834	USR0209	VST004189	RT00062	3	f
LOG0004835	USR0468	VST004362	RT00955	3	f
LOG0004836	USR0182	VST000744	RT00048	4	f
LOG0004837	USR0267	VST000374	RT00367	1	f
LOG0004838	USR0492	VST004190	RT00978	3	f
LOG0004839	USR0281	VST004128	RT00547	1	t
LOG0004840	USR0443	VST003735	RT00558	3	f
LOG0004841	USR0472	VST004085	RT00545	1	f
LOG0004842	USR0450	VST000140	RT00327	4	f
LOG0004843	USR0155	VST003021	RT00738	1	f
LOG0004844	USR0083	VST003293	RT00266	3	f
LOG0004845	USR0186	VST001565	RT00728	3	t
LOG0004846	USR0349	VST000058	RT00729	3	f
LOG0004847	USR0485	VST003497	RT00176	2	t
LOG0004848	USR0139	VST002188	RT00044	2	t
LOG0004849	USR0055	VST002949	RT00219	3	f
LOG0004850	USR0019	VST004474	RT00126	4	f
LOG0004851	USR0348	VST000373	RT00882	3	f
LOG0004852	USR0423	VST003135	RT00966	4	t
LOG0004853	USR0469	VST001588	RT00379	3	t
LOG0004854	USR0346	VST000778	RT00319	3	f
LOG0004855	USR0470	VST004263	RT00305	4	f
LOG0004856	USR0454	VST003223	RT00200	1	t
LOG0004857	USR0267	VST003679	RT00085	2	t
LOG0004858	USR0142	VST004680	RT00041	3	t
LOG0004859	USR0316	VST002549	RT00723	4	f
LOG0004860	USR0164	VST002944	RT00866	4	f
LOG0004861	USR0252	VST000999	RT00551	2	f
LOG0004862	USR0232	VST000560	RT00363	2	t
LOG0004863	USR0297	VST003344	RT00919	1	f
LOG0004864	USR0386	VST003502	RT00269	3	f
LOG0004865	USR0441	VST004015	RT00362	2	t
LOG0004866	USR0363	VST003679	RT00367	1	f
LOG0004867	USR0060	VST004329	RT00181	3	t
LOG0004868	USR0404	VST004656	RT00231	3	f
LOG0004869	USR0022	VST000921	RT00988	4	f
LOG0004870	USR0384	VST001243	RT00070	2	f
LOG0004871	USR0126	VST000081	RT00825	1	f
LOG0004872	USR0103	VST003621	RT00588	1	f
LOG0004873	USR0388	VST002662	RT00963	4	f
LOG0004874	USR0440	VST004799	RT00944	1	f
LOG0004875	USR0221	VST000541	RT00788	1	t
LOG0004876	USR0110	VST001275	RT00489	3	t
LOG0004877	USR0058	VST002786	RT00234	2	f
LOG0004878	USR0472	VST003487	RT00830	4	t
LOG0004879	USR0065	VST003158	RT00429	2	t
LOG0004880	USR0472	VST004718	RT00831	1	f
LOG0004881	USR0058	VST002244	RT00648	1	t
LOG0004882	USR0158	VST003043	RT00666	1	f
LOG0004883	USR0076	VST001321	RT00294	2	f
LOG0004884	USR0019	VST002994	RT00348	4	t
LOG0004885	USR0384	VST002092	RT00099	4	f
LOG0004886	USR0485	VST004059	RT00876	3	t
LOG0004887	USR0190	VST003026	RT00361	4	t
LOG0004888	USR0250	VST004155	RT00937	3	t
LOG0004889	USR0360	VST000479	RT00875	1	t
LOG0004890	USR0363	VST002666	RT00358	4	t
LOG0004891	USR0374	VST001757	RT00130	3	t
LOG0004892	USR0452	VST001799	RT00519	3	t
LOG0004893	USR0079	VST004880	RT00383	2	t
LOG0004894	USR0084	VST003121	RT00617	1	f
LOG0004895	USR0172	VST002988	RT00921	4	f
LOG0004896	USR0212	VST002579	RT00819	4	t
LOG0004897	USR0374	VST001027	RT00562	4	t
LOG0004898	USR0445	VST004474	RT00736	3	t
LOG0004899	USR0149	VST004668	RT00064	4	f
LOG0004900	USR0010	VST001955	RT00396	4	t
LOG0004901	USR0030	VST003314	RT00181	4	t
LOG0004902	USR0280	VST001565	RT00587	1	t
LOG0004903	USR0432	VST000587	RT00778	1	t
LOG0004904	USR0055	VST004453	RT00189	3	t
LOG0004905	USR0360	VST000685	RT00183	2	t
LOG0004906	USR0127	VST003269	RT00867	4	t
LOG0004907	USR0180	VST003491	RT00492	4	f
LOG0004908	USR0232	VST000659	RT00580	3	t
LOG0004909	USR0381	VST001297	RT00170	4	f
LOG0004910	USR0422	VST001526	RT00322	2	t
LOG0004911	USR0451	VST002083	RT00172	3	f
LOG0004912	USR0093	VST004608	RT00284	1	t
LOG0004913	USR0008	VST001072	RT00619	2	f
LOG0004914	USR0413	VST002321	RT00366	4	f
LOG0004915	USR0247	VST002575	RT00111	2	t
LOG0004916	USR0394	VST000210	RT00078	1	f
LOG0004917	USR0453	VST000624	RT00698	3	t
LOG0004918	USR0331	VST001806	RT00253	2	t
LOG0004919	USR0196	VST004269	RT00236	3	t
LOG0004920	USR0433	VST003750	RT00093	3	f
LOG0004921	USR0442	VST004543	RT00642	4	f
LOG0004922	USR0163	VST000011	RT00695	4	f
LOG0004923	USR0434	VST000761	RT00034	3	t
LOG0004924	USR0040	VST001328	RT00481	1	t
LOG0004925	USR0254	VST001178	RT00404	3	f
LOG0004926	USR0396	VST002371	RT00815	1	t
LOG0004927	USR0085	VST003609	RT00222	2	t
LOG0004928	USR0272	VST000977	RT00886	3	f
LOG0004929	USR0078	VST002493	RT00896	2	t
LOG0004930	USR0213	VST002390	RT00490	3	t
LOG0004931	USR0304	VST002458	RT00794	2	f
LOG0004932	USR0255	VST003674	RT00340	1	f
LOG0004933	USR0091	VST002553	RT00513	2	f
LOG0004934	USR0484	VST004136	RT00961	2	t
LOG0004935	USR0385	VST001483	RT00985	4	t
LOG0004936	USR0193	VST002311	RT00609	3	t
LOG0004937	USR0253	VST003742	RT00599	3	f
LOG0004938	USR0278	VST003840	RT00843	3	t
LOG0004939	USR0143	VST002756	RT00252	3	f
LOG0004940	USR0244	VST000823	RT00364	4	t
LOG0004941	USR0212	VST003598	RT00527	1	t
LOG0004942	USR0195	VST000461	RT00142	2	t
LOG0004943	USR0270	VST004313	RT00311	2	t
LOG0004944	USR0329	VST001741	RT00385	1	t
LOG0004945	USR0019	VST002125	RT00801	2	t
LOG0004946	USR0040	VST001445	RT00582	4	t
LOG0004947	USR0098	VST003098	RT00312	3	f
LOG0004948	USR0004	VST004470	RT00279	3	t
LOG0004949	USR0033	VST000654	RT00566	4	f
LOG0004950	USR0299	VST005000	RT00346	3	t
LOG0004951	USR0165	VST003542	RT00387	2	f
LOG0004952	USR0450	VST000744	RT00302	1	f
LOG0004953	USR0027	VST000853	RT00764	1	f
LOG0004954	USR0173	VST004927	RT00507	2	t
LOG0004955	USR0337	VST001562	RT00247	1	f
LOG0004956	USR0113	VST003946	RT00646	1	f
LOG0004957	USR0434	VST002677	RT00488	3	f
LOG0004958	USR0373	VST001319	RT00756	2	t
LOG0004959	USR0380	VST000122	RT00921	4	f
LOG0004960	USR0095	VST004255	RT00239	1	f
LOG0004961	USR0319	VST003728	RT00529	2	f
LOG0004962	USR0233	VST000307	RT00924	4	f
LOG0004963	USR0134	VST003983	RT00928	4	t
LOG0004964	USR0124	VST001113	RT00349	3	f
LOG0004965	USR0372	VST004847	RT00791	3	f
LOG0004966	USR0351	VST001897	RT00745	1	f
LOG0004967	USR0323	VST004687	RT00912	2	f
LOG0004968	USR0488	VST000346	RT00352	2	f
LOG0004969	USR0451	VST003912	RT00154	3	t
LOG0004970	USR0353	VST000149	RT00510	3	f
LOG0004971	USR0116	VST001040	RT00929	3	t
LOG0004972	USR0443	VST001391	RT00186	1	f
LOG0004973	USR0013	VST003905	RT00944	2	f
LOG0004974	USR0405	VST004877	RT00595	1	t
LOG0004975	USR0320	VST000118	RT00567	2	t
LOG0004976	USR0165	VST000704	RT00425	3	t
LOG0004977	USR0208	VST004384	RT00062	1	f
LOG0004978	USR0085	VST002956	RT00401	4	t
LOG0004979	USR0248	VST002025	RT00870	1	t
LOG0004980	USR0432	VST004539	RT00059	1	f
LOG0004981	USR0056	VST004997	RT00142	4	f
LOG0004982	USR0172	VST004397	RT00466	4	f
LOG0004983	USR0141	VST004346	RT00149	3	f
LOG0004984	USR0132	VST001958	RT00447	4	t
LOG0004985	USR0479	VST004782	RT00174	4	t
LOG0004986	USR0201	VST002800	RT00311	1	t
LOG0004987	USR0368	VST000998	RT00062	1	f
LOG0004988	USR0289	VST000406	RT00167	3	f
LOG0004989	USR0421	VST002849	RT00682	4	f
LOG0004990	USR0309	VST000244	RT00816	2	f
LOG0004991	USR0357	VST002415	RT00103	1	t
LOG0004992	USR0408	VST003857	RT00028	3	t
LOG0004993	USR0345	VST001606	RT00596	1	f
LOG0004994	USR0179	VST000433	RT00508	1	f
LOG0004995	USR0425	VST004279	RT00134	2	f
LOG0004996	USR0029	VST002807	RT00059	3	f
LOG0004997	USR0443	VST001142	RT00090	2	t
LOG0004998	USR0424	VST004127	RT00070	2	f
LOG0004999	USR0307	VST003025	RT00935	3	t
LOG0005000	USR0306	VST001173	RT00185	4	f
LOG0005001	USR0367	VST003457	RT00438	2	f
LOG0005002	USR0036	VST004198	RT00572	4	f
LOG0005003	USR0463	VST001096	RT00474	1	f
LOG0005004	USR0109	VST003906	RT00657	3	f
LOG0005005	USR0316	VST002853	RT00168	3	f
LOG0005006	USR0146	VST002456	RT00578	1	f
LOG0005007	USR0276	VST003924	RT00883	1	f
LOG0005008	USR0389	VST001391	RT00124	1	t
LOG0005009	USR0146	VST004926	RT00213	2	f
LOG0005010	USR0380	VST002837	RT00182	2	f
LOG0005011	USR0168	VST000618	RT00071	2	f
LOG0005012	USR0257	VST002597	RT00556	2	t
LOG0005013	USR0275	VST004387	RT00852	2	t
LOG0005014	USR0087	VST002470	RT00195	4	f
LOG0005015	USR0154	VST004277	RT00569	4	f
LOG0005016	USR0497	VST002703	RT00292	2	t
LOG0005017	USR0285	VST003166	RT00057	3	t
LOG0005018	USR0315	VST000260	RT00889	3	t
LOG0005019	USR0319	VST003179	RT00683	4	f
LOG0005020	USR0098	VST002292	RT00300	4	f
LOG0005021	USR0211	VST004431	RT00318	3	t
LOG0005022	USR0446	VST001047	RT00371	3	t
LOG0005023	USR0048	VST004367	RT00083	3	f
LOG0005024	USR0318	VST004058	RT00829	4	f
LOG0005025	USR0274	VST003212	RT00094	4	f
LOG0005026	USR0194	VST001408	RT00267	3	f
LOG0005027	USR0252	VST001401	RT00845	4	t
LOG0005028	USR0283	VST001010	RT00376	2	f
LOG0005029	USR0262	VST003407	RT00161	3	f
LOG0005030	USR0487	VST003603	RT00614	1	t
LOG0005031	USR0454	VST004228	RT00502	3	f
LOG0005032	USR0443	VST002816	RT00377	4	t
LOG0005033	USR0262	VST001745	RT00112	1	t
LOG0005034	USR0031	VST002549	RT00578	1	f
LOG0005035	USR0105	VST001546	RT00622	3	f
LOG0005036	USR0488	VST000135	RT00632	2	t
LOG0005037	USR0350	VST004863	RT00279	2	t
LOG0005038	USR0312	VST002860	RT00754	4	f
LOG0005039	USR0438	VST003479	RT00433	1	f
LOG0005040	USR0469	VST004866	RT00660	2	f
LOG0005041	USR0169	VST002142	RT00242	4	t
LOG0005042	USR0236	VST001265	RT00222	1	f
LOG0005043	USR0274	VST001773	RT00783	4	t
LOG0005044	USR0343	VST000165	RT00962	2	f
LOG0005045	USR0230	VST004421	RT00286	4	t
LOG0005046	USR0023	VST002988	RT00985	4	t
LOG0005047	USR0476	VST000620	RT00004	2	t
LOG0005048	USR0164	VST000231	RT00320	2	f
LOG0005049	USR0281	VST002781	RT00321	4	f
LOG0005050	USR0007	VST003152	RT00008	2	t
LOG0005051	USR0210	VST001378	RT00052	3	f
LOG0005052	USR0253	VST001892	RT00142	3	t
LOG0005053	USR0404	VST003753	RT00826	3	t
LOG0005054	USR0133	VST003973	RT00779	1	t
LOG0005055	USR0274	VST003233	RT00827	3	t
LOG0005056	USR0106	VST000403	RT00280	3	f
LOG0005057	USR0232	VST002775	RT00088	3	f
LOG0005058	USR0033	VST004481	RT00160	2	f
LOG0005059	USR0079	VST002608	RT00985	2	f
LOG0005060	USR0035	VST001191	RT00814	2	t
LOG0005061	USR0495	VST000389	RT00028	2	t
LOG0005062	USR0110	VST003405	RT00528	2	t
LOG0005063	USR0321	VST001774	RT00810	3	f
LOG0005064	USR0063	VST000790	RT00871	3	f
LOG0005065	USR0469	VST001495	RT00272	2	f
LOG0005066	USR0328	VST002752	RT00100	4	t
LOG0005067	USR0455	VST001548	RT00908	2	f
LOG0005068	USR0297	VST000821	RT00204	3	f
LOG0005069	USR0178	VST004037	RT00190	3	f
LOG0005070	USR0384	VST004958	RT00546	2	f
LOG0005071	USR0364	VST001480	RT00294	1	t
LOG0005072	USR0232	VST002370	RT00895	4	f
LOG0005073	USR0104	VST004066	RT00980	2	t
LOG0005074	USR0414	VST003131	RT00943	3	t
LOG0005075	USR0294	VST001464	RT00975	4	t
LOG0005076	USR0035	VST001908	RT00790	1	f
LOG0005077	USR0194	VST003066	RT00848	4	t
LOG0005078	USR0174	VST003646	RT00344	2	t
LOG0005079	USR0392	VST004029	RT00771	3	f
LOG0005080	USR0102	VST003966	RT00769	3	t
LOG0005081	USR0324	VST004847	RT00053	3	t
LOG0005082	USR0293	VST001317	RT00704	4	f
LOG0005083	USR0085	VST000182	RT00684	2	f
LOG0005084	USR0397	VST002655	RT00047	2	f
LOG0005085	USR0201	VST000961	RT00422	4	f
LOG0005086	USR0173	VST004201	RT00703	4	f
LOG0005087	USR0029	VST002655	RT00883	1	f
LOG0005088	USR0297	VST003295	RT00465	3	f
LOG0005089	USR0056	VST000990	RT00553	4	t
LOG0005090	USR0472	VST004580	RT00917	3	f
LOG0005091	USR0016	VST001726	RT00429	1	f
LOG0005092	USR0140	VST000707	RT00397	2	t
LOG0005093	USR0066	VST004116	RT00194	3	t
LOG0005094	USR0446	VST004848	RT00066	4	f
LOG0005095	USR0147	VST004331	RT00555	4	t
LOG0005096	USR0158	VST001621	RT00702	1	f
LOG0005097	USR0400	VST004702	RT00601	3	t
LOG0005098	USR0472	VST004650	RT00476	2	f
LOG0005099	USR0397	VST003422	RT00688	2	t
LOG0005100	USR0069	VST004682	RT00881	4	f
LOG0005101	USR0023	VST003581	RT00026	1	t
LOG0005102	USR0190	VST000423	RT00099	4	t
LOG0005103	USR0248	VST004016	RT00476	4	t
LOG0005104	USR0486	VST003197	RT00573	4	t
LOG0005105	USR0415	VST004554	RT00893	4	f
LOG0005106	USR0309	VST001915	RT00762	1	f
LOG0005107	USR0376	VST002602	RT00887	4	t
LOG0005108	USR0145	VST004011	RT00830	3	t
LOG0005109	USR0384	VST004086	RT00737	4	t
LOG0005110	USR0305	VST004942	RT00082	4	t
LOG0005111	USR0177	VST003183	RT00398	2	f
LOG0005112	USR0195	VST004647	RT00694	2	f
LOG0005113	USR0410	VST003751	RT00937	1	f
LOG0005114	USR0013	VST002059	RT00700	1	f
LOG0005115	USR0364	VST001646	RT00393	3	f
LOG0005116	USR0166	VST004593	RT00044	4	f
LOG0005117	USR0150	VST003088	RT00824	2	t
LOG0005118	USR0341	VST002793	RT00478	3	t
LOG0005119	USR0413	VST002537	RT00771	3	t
LOG0005120	USR0045	VST003260	RT00610	1	f
LOG0005121	USR0174	VST002512	RT00865	2	f
LOG0005122	USR0167	VST002091	RT00091	4	f
LOG0005123	USR0197	VST004635	RT00827	1	f
LOG0005124	USR0206	VST000568	RT00329	3	t
LOG0005125	USR0082	VST000121	RT00653	3	t
LOG0005126	USR0068	VST000316	RT00414	2	f
LOG0005127	USR0097	VST000621	RT00821	2	f
LOG0005128	USR0167	VST004064	RT00764	4	f
LOG0005129	USR0404	VST000454	RT00720	2	f
LOG0005130	USR0077	VST002735	RT00691	2	t
LOG0005131	USR0484	VST002672	RT00810	1	t
LOG0005132	USR0237	VST004708	RT00922	1	f
LOG0005133	USR0196	VST000959	RT00699	4	t
LOG0005134	USR0291	VST002009	RT00837	1	f
LOG0005135	USR0136	VST004743	RT00110	4	f
LOG0005136	USR0308	VST000763	RT00219	1	t
LOG0005137	USR0296	VST001361	RT00463	3	t
LOG0005138	USR0377	VST004336	RT00860	1	t
LOG0005139	USR0369	VST002052	RT00515	4	t
LOG0005140	USR0367	VST000197	RT00553	1	t
LOG0005141	USR0036	VST000261	RT00637	2	f
LOG0005142	USR0390	VST003909	RT00257	3	f
LOG0005143	USR0248	VST004190	RT00193	1	f
LOG0005144	USR0254	VST001281	RT00627	3	f
LOG0005145	USR0214	VST000136	RT00070	3	f
LOG0005146	USR0252	VST002546	RT00459	3	t
LOG0005147	USR0070	VST003486	RT00382	3	f
LOG0005148	USR0234	VST000369	RT00818	2	t
LOG0005149	USR0484	VST003663	RT00494	2	t
LOG0005150	USR0329	VST004864	RT00848	4	f
LOG0005151	USR0016	VST003455	RT00097	4	f
LOG0005152	USR0487	VST004769	RT00728	4	f
LOG0005153	USR0174	VST004607	RT00827	4	t
LOG0005154	USR0187	VST004809	RT00224	3	f
LOG0005155	USR0294	VST004916	RT00842	3	t
LOG0005156	USR0225	VST000545	RT00831	3	f
LOG0005157	USR0274	VST004600	RT00281	2	f
LOG0005158	USR0012	VST003424	RT00906	2	f
LOG0005159	USR0310	VST004901	RT00333	3	t
LOG0005160	USR0219	VST004806	RT00892	3	t
LOG0005161	USR0431	VST002373	RT00641	3	t
LOG0005162	USR0001	VST004484	RT00611	3	f
LOG0005163	USR0399	VST004336	RT00782	2	f
LOG0005164	USR0111	VST001098	RT00405	1	t
LOG0005165	USR0475	VST002079	RT00496	4	f
LOG0005166	USR0464	VST002527	RT00759	4	t
LOG0005167	USR0277	VST004164	RT00186	1	f
LOG0005168	USR0129	VST003712	RT00756	2	t
LOG0005169	USR0093	VST003054	RT00038	2	f
LOG0005170	USR0451	VST001944	RT00769	1	t
LOG0005171	USR0396	VST001720	RT00852	4	f
LOG0005172	USR0380	VST000291	RT00760	4	t
LOG0005173	USR0412	VST003690	RT00645	1	t
LOG0005174	USR0039	VST000975	RT00488	1	t
LOG0005175	USR0421	VST000415	RT00556	3	f
LOG0005176	USR0479	VST000851	RT00992	1	t
LOG0005177	USR0316	VST003778	RT00705	1	f
LOG0005178	USR0159	VST002729	RT00506	4	t
LOG0005179	USR0186	VST004642	RT00489	3	t
LOG0005180	USR0481	VST003961	RT00057	3	t
LOG0005181	USR0353	VST000742	RT00512	4	t
LOG0005182	USR0256	VST000592	RT00248	4	f
LOG0005183	USR0239	VST000750	RT00104	2	f
LOG0005184	USR0104	VST002220	RT00557	3	t
LOG0005185	USR0395	VST000838	RT00060	1	f
LOG0005186	USR0366	VST003131	RT00578	3	f
LOG0005187	USR0029	VST003482	RT00735	2	t
LOG0005188	USR0089	VST000534	RT00559	1	f
LOG0005189	USR0375	VST004461	RT00238	2	f
LOG0005190	USR0397	VST004463	RT00371	4	f
LOG0005191	USR0051	VST001774	RT00026	2	f
LOG0005192	USR0364	VST002344	RT00393	4	f
LOG0005193	USR0438	VST002654	RT00819	2	t
LOG0005194	USR0147	VST002571	RT00606	4	f
LOG0005195	USR0314	VST000265	RT00110	3	f
LOG0005196	USR0036	VST003596	RT00392	4	t
LOG0005197	USR0284	VST002035	RT00773	3	t
LOG0005198	USR0452	VST003203	RT00254	4	t
LOG0005199	USR0387	VST000382	RT00807	2	f
LOG0005200	USR0486	VST003297	RT00836	2	t
LOG0005201	USR0101	VST001167	RT00552	2	f
LOG0005202	USR0107	VST002479	RT00804	4	t
LOG0005203	USR0345	VST000389	RT00917	4	t
LOG0005204	USR0425	VST002072	RT00766	2	f
LOG0005205	USR0291	VST000395	RT00097	3	t
LOG0005206	USR0349	VST003658	RT00538	4	t
LOG0005207	USR0105	VST003257	RT00104	3	t
LOG0005208	USR0221	VST004020	RT00615	4	f
LOG0005209	USR0076	VST002240	RT00587	2	t
LOG0005210	USR0227	VST004817	RT00597	3	f
LOG0005211	USR0084	VST002860	RT00496	1	f
LOG0005212	USR0465	VST002394	RT00214	4	t
LOG0005213	USR0076	VST004569	RT00113	3	t
LOG0005214	USR0249	VST002051	RT00312	2	t
LOG0005215	USR0255	VST003122	RT00569	3	t
LOG0005216	USR0050	VST000925	RT00955	1	t
LOG0005217	USR0356	VST004972	RT00896	1	t
LOG0005218	USR0458	VST003576	RT00101	3	f
LOG0005219	USR0210	VST003283	RT00762	1	t
LOG0005220	USR0158	VST003752	RT00647	4	t
LOG0005221	USR0328	VST003355	RT00938	1	f
LOG0005222	USR0233	VST004475	RT00653	3	t
LOG0005223	USR0371	VST003398	RT00084	3	f
LOG0005224	USR0077	VST003769	RT00719	4	f
LOG0005225	USR0223	VST004221	RT00742	4	f
LOG0005226	USR0121	VST002982	RT00930	3	t
LOG0005227	USR0454	VST004576	RT00868	2	f
LOG0005228	USR0310	VST003473	RT00949	4	t
LOG0005229	USR0327	VST002618	RT00302	2	f
LOG0005230	USR0341	VST003500	RT00953	1	f
LOG0005231	USR0358	VST003593	RT00573	1	f
LOG0005232	USR0107	VST000432	RT00217	4	t
LOG0005233	USR0241	VST001113	RT00568	4	t
LOG0005234	USR0435	VST004697	RT00541	3	f
LOG0005235	USR0028	VST004952	RT00623	1	t
LOG0005236	USR0192	VST002054	RT00092	4	f
LOG0005237	USR0249	VST004254	RT00654	3	f
LOG0005238	USR0364	VST004319	RT00452	2	t
LOG0005239	USR0213	VST002450	RT00614	3	f
LOG0005240	USR0021	VST000545	RT00071	1	f
LOG0005241	USR0472	VST003159	RT00525	3	t
LOG0005242	USR0155	VST002629	RT00401	3	f
LOG0005243	USR0027	VST003452	RT00669	4	f
LOG0005244	USR0077	VST000538	RT00081	3	t
LOG0005245	USR0306	VST001437	RT00100	1	f
LOG0005246	USR0413	VST002816	RT00595	3	f
LOG0005247	USR0423	VST003766	RT00218	3	t
LOG0005248	USR0057	VST003063	RT00884	1	f
LOG0005249	USR0119	VST000260	RT00749	2	t
LOG0005250	USR0476	VST004922	RT00125	2	t
LOG0005251	USR0165	VST004412	RT00201	1	t
LOG0005252	USR0477	VST004842	RT00002	2	t
LOG0005253	USR0064	VST000719	RT00574	3	f
LOG0005254	USR0048	VST002728	RT00020	4	t
LOG0005255	USR0150	VST002902	RT00983	1	f
LOG0005256	USR0484	VST000461	RT00722	3	f
LOG0005257	USR0158	VST002855	RT00952	4	t
LOG0005258	USR0156	VST004068	RT00858	3	t
LOG0005259	USR0151	VST001703	RT00180	1	t
LOG0005260	USR0225	VST003248	RT00409	3	f
LOG0005261	USR0260	VST002978	RT00062	1	f
LOG0005262	USR0387	VST001815	RT00273	3	f
LOG0005263	USR0256	VST003481	RT00807	4	t
LOG0005264	USR0061	VST001742	RT00753	4	f
LOG0005265	USR0352	VST004072	RT00763	4	t
LOG0005266	USR0260	VST000030	RT00010	2	t
LOG0005267	USR0321	VST003494	RT00699	3	f
LOG0005268	USR0396	VST000982	RT00921	3	t
LOG0005269	USR0397	VST000231	RT00622	4	f
LOG0005270	USR0162	VST002777	RT00540	1	f
LOG0005271	USR0380	VST001252	RT00986	2	f
LOG0005272	USR0443	VST004495	RT00460	3	f
LOG0005273	USR0349	VST004191	RT00061	3	t
LOG0005274	USR0457	VST001964	RT00058	2	f
LOG0005275	USR0031	VST004571	RT00300	2	t
LOG0005276	USR0071	VST003167	RT00497	4	f
LOG0005277	USR0397	VST001779	RT00339	2	f
LOG0005278	USR0438	VST004871	RT00252	4	t
LOG0005279	USR0002	VST001148	RT00407	2	f
LOG0005280	USR0417	VST002848	RT00974	2	f
LOG0005281	USR0050	VST003851	RT00256	3	f
LOG0005282	USR0135	VST002992	RT00381	4	t
LOG0005283	USR0146	VST003071	RT00145	2	f
LOG0005284	USR0179	VST000621	RT00591	2	f
LOG0005285	USR0264	VST000964	RT00341	3	f
LOG0005286	USR0311	VST002861	RT00806	1	t
LOG0005287	USR0204	VST002143	RT00798	3	t
LOG0005288	USR0299	VST001501	RT00403	4	t
LOG0005289	USR0187	VST003190	RT00288	1	t
LOG0005290	USR0030	VST001327	RT00989	2	f
LOG0005291	USR0059	VST000122	RT00214	4	t
LOG0005292	USR0009	VST004314	RT00532	1	t
LOG0005293	USR0476	VST001077	RT00870	4	t
LOG0005294	USR0324	VST003198	RT00742	3	t
LOG0005295	USR0167	VST001183	RT00576	1	f
LOG0005296	USR0337	VST000795	RT00548	1	f
LOG0005297	USR0395	VST001625	RT00961	1	t
LOG0005298	USR0379	VST004272	RT00211	2	t
LOG0005299	USR0386	VST000292	RT00171	3	t
LOG0005300	USR0279	VST000491	RT00538	1	t
LOG0005301	USR0191	VST002809	RT00263	4	f
LOG0005302	USR0242	VST003429	RT00802	2	f
LOG0005303	USR0278	VST000634	RT00676	3	t
LOG0005304	USR0445	VST003500	RT00390	3	t
LOG0005305	USR0154	VST002173	RT00421	3	t
LOG0005306	USR0396	VST003387	RT00062	3	t
LOG0005307	USR0160	VST003908	RT00086	2	t
LOG0005308	USR0265	VST004700	RT00585	3	t
LOG0005309	USR0235	VST003469	RT00491	4	t
LOG0005310	USR0453	VST000491	RT00896	4	f
LOG0005311	USR0346	VST004661	RT00060	4	f
LOG0005312	USR0199	VST004264	RT00477	1	f
LOG0005313	USR0477	VST000759	RT00320	3	t
LOG0005314	USR0033	VST001198	RT00690	4	f
LOG0005315	USR0408	VST003444	RT00052	3	t
LOG0005316	USR0089	VST001905	RT00657	2	t
LOG0005317	USR0095	VST001651	RT00828	4	t
LOG0005318	USR0221	VST004276	RT00077	1	f
LOG0005319	USR0069	VST003192	RT00119	1	f
LOG0005320	USR0294	VST000028	RT00721	2	t
LOG0005321	USR0237	VST002751	RT00182	4	f
LOG0005322	USR0395	VST002705	RT00506	2	f
LOG0005323	USR0160	VST002880	RT00650	1	f
LOG0005324	USR0320	VST004358	RT00637	1	f
LOG0005325	USR0328	VST003726	RT00153	3	t
LOG0005326	USR0276	VST002674	RT00018	2	t
LOG0005327	USR0290	VST002833	RT00064	1	f
LOG0005328	USR0367	VST003110	RT00497	4	f
LOG0005329	USR0042	VST004293	RT00748	4	f
LOG0005330	USR0392	VST003597	RT00079	1	t
LOG0005331	USR0066	VST003696	RT00059	2	f
LOG0005332	USR0021	VST001461	RT00411	2	t
LOG0005333	USR0335	VST002922	RT00763	4	f
LOG0005334	USR0070	VST001434	RT00826	1	f
LOG0005335	USR0261	VST004429	RT00061	4	t
LOG0005336	USR0246	VST003537	RT00467	2	t
LOG0005337	USR0323	VST001182	RT00630	1	t
LOG0005338	USR0235	VST003406	RT00079	4	t
LOG0005339	USR0427	VST004175	RT00749	1	f
LOG0005340	USR0272	VST003915	RT00839	3	t
LOG0005341	USR0099	VST004293	RT00683	4	t
LOG0005342	USR0329	VST003192	RT00488	4	t
LOG0005343	USR0035	VST001784	RT00244	3	f
LOG0005344	USR0339	VST003723	RT00208	2	t
LOG0005345	USR0171	VST004322	RT00856	4	f
LOG0005346	USR0110	VST002643	RT00087	4	f
LOG0005347	USR0482	VST003712	RT00651	2	t
LOG0005348	USR0295	VST002961	RT00600	1	f
LOG0005349	USR0010	VST004831	RT00645	3	t
LOG0005350	USR0202	VST001580	RT00954	2	f
LOG0005351	USR0404	VST001620	RT00039	1	f
LOG0005352	USR0257	VST002967	RT00176	3	t
LOG0005353	USR0262	VST004316	RT00478	1	t
LOG0005354	USR0181	VST002341	RT00592	4	f
LOG0005355	USR0430	VST001228	RT00020	3	t
LOG0005356	USR0066	VST001729	RT00221	1	t
LOG0005357	USR0294	VST003586	RT00849	3	f
LOG0005358	USR0161	VST000202	RT00275	1	f
LOG0005359	USR0067	VST003161	RT00700	1	f
LOG0005360	USR0100	VST003274	RT00154	4	t
LOG0005361	USR0077	VST001714	RT00463	2	f
LOG0005362	USR0035	VST000753	RT00409	3	t
LOG0005363	USR0463	VST000115	RT00655	4	f
LOG0005364	USR0045	VST003981	RT00251	3	t
LOG0005365	USR0150	VST002819	RT00212	2	t
LOG0005366	USR0491	VST000469	RT00478	4	f
LOG0005367	USR0068	VST000426	RT00661	2	f
LOG0005368	USR0254	VST001576	RT00687	4	t
LOG0005369	USR0017	VST001866	RT00419	4	f
LOG0005370	USR0261	VST000834	RT00172	4	f
LOG0005371	USR0213	VST004107	RT00507	4	t
LOG0005372	USR0313	VST003704	RT00646	1	t
LOG0005373	USR0256	VST001409	RT00628	3	f
LOG0005374	USR0216	VST003482	RT00869	1	f
LOG0005375	USR0351	VST002171	RT00203	1	f
LOG0005376	USR0424	VST000604	RT00919	1	f
LOG0005377	USR0286	VST000213	RT00492	4	f
LOG0005378	USR0426	VST003902	RT00295	4	t
LOG0005379	USR0007	VST003739	RT00457	2	f
LOG0005380	USR0497	VST002755	RT00146	3	t
LOG0005381	USR0380	VST004636	RT00238	2	f
LOG0005382	USR0199	VST004802	RT00740	2	f
LOG0005383	USR0091	VST001759	RT00767	3	f
LOG0005384	USR0472	VST004594	RT00424	3	t
LOG0005385	USR0147	VST003069	RT00292	2	f
LOG0005386	USR0425	VST000782	RT00156	2	t
LOG0005387	USR0418	VST004222	RT00960	2	t
LOG0005388	USR0150	VST003431	RT00851	4	f
LOG0005389	USR0052	VST001527	RT00350	3	f
LOG0005390	USR0243	VST000841	RT00442	3	f
LOG0005391	USR0219	VST001342	RT00934	1	f
LOG0005392	USR0006	VST004108	RT00243	4	t
LOG0005393	USR0458	VST001501	RT00207	4	t
LOG0005394	USR0109	VST000516	RT00428	3	f
LOG0005395	USR0351	VST003463	RT00766	4	t
LOG0005396	USR0409	VST003080	RT00972	2	f
LOG0005397	USR0066	VST001148	RT00258	3	t
LOG0005398	USR0010	VST003444	RT00585	3	f
LOG0005399	USR0202	VST003257	RT00035	4	f
LOG0005400	USR0282	VST002595	RT00129	3	t
LOG0005401	USR0389	VST003657	RT00430	4	t
LOG0005402	USR0214	VST001549	RT00700	4	t
LOG0005403	USR0068	VST002087	RT00319	4	f
LOG0005404	USR0247	VST003156	RT00095	2	t
LOG0005405	USR0354	VST002351	RT00220	4	f
LOG0005406	USR0327	VST000979	RT00301	4	f
LOG0005407	USR0050	VST002306	RT00637	1	f
LOG0005408	USR0017	VST003884	RT00185	1	f
LOG0005409	USR0011	VST003048	RT00037	2	t
LOG0005410	USR0309	VST002590	RT00775	2	f
LOG0005411	USR0306	VST002007	RT00622	4	f
LOG0005412	USR0392	VST002600	RT00400	1	f
LOG0005413	USR0476	VST002509	RT00690	2	t
LOG0005414	USR0124	VST004320	RT00142	3	t
LOG0005415	USR0492	VST002140	RT00993	3	t
LOG0005416	USR0225	VST000280	RT00134	4	f
LOG0005417	USR0244	VST001194	RT00445	1	t
LOG0005418	USR0318	VST001758	RT00661	3	t
LOG0005419	USR0473	VST002046	RT00906	1	f
LOG0005420	USR0469	VST000248	RT00288	2	f
LOG0005421	USR0332	VST001385	RT00902	1	t
LOG0005422	USR0379	VST001373	RT00258	4	t
LOG0005423	USR0346	VST002914	RT00039	1	f
LOG0005424	USR0029	VST003673	RT00305	3	t
LOG0005425	USR0358	VST000045	RT00283	1	f
LOG0005426	USR0483	VST002086	RT00824	1	f
LOG0005427	USR0357	VST004512	RT00526	1	f
LOG0005428	USR0366	VST002541	RT00407	2	f
LOG0005429	USR0428	VST002371	RT00359	4	t
LOG0005430	USR0365	VST002516	RT00886	3	f
LOG0005431	USR0429	VST004183	RT00378	3	f
LOG0005432	USR0285	VST004324	RT00469	1	t
LOG0005433	USR0497	VST000623	RT00873	1	t
LOG0005434	USR0472	VST003382	RT00947	2	t
LOG0005435	USR0059	VST000485	RT00990	4	f
LOG0005436	USR0143	VST002888	RT00281	3	f
LOG0005437	USR0326	VST000025	RT00565	4	f
LOG0005438	USR0352	VST001815	RT00984	3	t
LOG0005439	USR0300	VST001226	RT00011	1	t
LOG0005440	USR0226	VST001249	RT00675	2	f
LOG0005441	USR0164	VST000779	RT00695	2	f
LOG0005442	USR0084	VST002843	RT00186	1	f
LOG0005443	USR0377	VST003701	RT00964	1	t
LOG0005444	USR0313	VST001583	RT00549	1	t
LOG0005445	USR0117	VST004849	RT00996	4	f
LOG0005446	USR0320	VST001714	RT00973	1	t
LOG0005447	USR0204	VST003592	RT00009	4	t
LOG0005448	USR0355	VST004522	RT00028	1	t
LOG0005449	USR0497	VST003139	RT00823	2	t
LOG0005450	USR0294	VST004756	RT00686	4	f
LOG0005451	USR0145	VST001518	RT00464	2	f
LOG0005452	USR0027	VST002733	RT00639	1	t
LOG0005453	USR0017	VST004643	RT00511	1	t
LOG0005454	USR0063	VST002964	RT00502	3	f
LOG0005455	USR0267	VST003864	RT00582	4	t
LOG0005456	USR0064	VST003769	RT00795	4	t
LOG0005457	USR0039	VST001497	RT00778	4	f
LOG0005458	USR0130	VST003728	RT00663	4	t
LOG0005459	USR0115	VST001736	RT00661	2	f
LOG0005460	USR0450	VST001344	RT00218	4	t
LOG0005461	USR0438	VST002268	RT00429	2	t
LOG0005462	USR0413	VST003916	RT00638	1	t
LOG0005463	USR0045	VST000049	RT00003	2	t
LOG0005464	USR0216	VST002511	RT00187	4	t
LOG0005465	USR0088	VST003335	RT00043	2	t
LOG0005466	USR0336	VST003661	RT00611	4	t
LOG0005467	USR0415	VST001747	RT00775	2	t
LOG0005468	USR0177	VST000496	RT00411	3	f
LOG0005469	USR0491	VST000634	RT00190	4	f
LOG0005470	USR0265	VST004698	RT00042	2	f
LOG0005471	USR0411	VST002818	RT00097	4	f
LOG0005472	USR0440	VST002721	RT00772	1	t
LOG0005473	USR0105	VST000176	RT00730	2	f
LOG0005474	USR0381	VST003161	RT00958	2	f
LOG0005475	USR0334	VST000639	RT00648	3	t
LOG0005476	USR0301	VST003358	RT00852	4	t
LOG0005477	USR0473	VST004393	RT00657	2	t
LOG0005478	USR0171	VST000475	RT00517	3	t
LOG0005479	USR0108	VST003828	RT00959	3	t
LOG0005480	USR0406	VST001647	RT00881	3	f
LOG0005481	USR0355	VST001959	RT00905	4	t
LOG0005482	USR0161	VST004121	RT00136	4	t
LOG0005483	USR0283	VST000349	RT00510	2	t
LOG0005484	USR0040	VST000637	RT00519	4	f
LOG0005485	USR0026	VST003615	RT00037	4	t
LOG0005486	USR0083	VST003821	RT00996	1	t
LOG0005487	USR0173	VST004323	RT00823	4	f
LOG0005488	USR0487	VST004134	RT00579	1	f
LOG0005489	USR0173	VST002618	RT00904	2	t
LOG0005490	USR0282	VST001205	RT00837	3	f
LOG0005491	USR0070	VST002162	RT00517	1	f
LOG0005492	USR0323	VST002180	RT00785	2	t
LOG0005493	USR0006	VST000348	RT00879	1	f
LOG0005494	USR0284	VST001204	RT00058	4	f
LOG0005495	USR0195	VST000983	RT00959	2	t
LOG0005496	USR0013	VST000732	RT00155	3	f
LOG0005497	USR0063	VST002601	RT00872	1	f
LOG0005498	USR0013	VST000453	RT00999	4	t
LOG0005499	USR0249	VST004074	RT00113	2	t
LOG0005500	USR0205	VST002895	RT00460	4	f
LOG0005501	USR0385	VST002235	RT00604	2	f
LOG0005502	USR0253	VST000164	RT00836	1	f
LOG0005503	USR0040	VST001448	RT00756	2	f
LOG0005504	USR0165	VST003870	RT00796	1	f
LOG0005505	USR0031	VST000102	RT00601	2	t
LOG0005506	USR0500	VST004055	RT00442	4	f
LOG0005507	USR0017	VST003708	RT00690	4	f
LOG0005508	USR0137	VST001453	RT00228	1	t
LOG0005509	USR0365	VST004787	RT00874	3	t
LOG0005510	USR0320	VST002659	RT00579	1	f
LOG0005511	USR0313	VST000536	RT00122	4	f
LOG0005512	USR0397	VST001701	RT00671	2	t
LOG0005513	USR0165	VST001464	RT00357	3	f
LOG0005514	USR0398	VST004220	RT00268	4	t
LOG0005515	USR0459	VST004345	RT00695	3	t
LOG0005516	USR0281	VST001972	RT00485	1	t
LOG0005517	USR0223	VST001453	RT00869	4	t
LOG0005518	USR0122	VST001594	RT00004	1	f
LOG0005519	USR0078	VST000713	RT00478	4	t
LOG0005520	USR0313	VST003656	RT00121	4	f
LOG0005521	USR0327	VST004343	RT00742	1	t
LOG0005522	USR0088	VST004577	RT00810	4	f
LOG0005523	USR0113	VST004085	RT00486	3	f
LOG0005524	USR0100	VST001449	RT00219	3	t
LOG0005525	USR0426	VST003649	RT00694	1	f
LOG0005526	USR0426	VST002014	RT00278	2	f
LOG0005527	USR0303	VST000459	RT00257	3	f
LOG0005528	USR0372	VST002844	RT00304	4	t
LOG0005529	USR0428	VST000593	RT00043	1	f
LOG0005530	USR0425	VST000498	RT00870	2	f
LOG0005531	USR0387	VST002135	RT00916	1	t
LOG0005532	USR0239	VST002450	RT00530	3	t
LOG0005533	USR0492	VST004293	RT00710	4	f
LOG0005534	USR0346	VST002812	RT00689	3	t
LOG0005535	USR0111	VST000027	RT00588	1	t
LOG0005536	USR0090	VST003917	RT00913	4	t
LOG0005537	USR0385	VST001718	RT00693	2	f
LOG0005538	USR0463	VST002254	RT00150	3	t
LOG0005539	USR0139	VST003643	RT00594	1	t
LOG0005540	USR0485	VST003656	RT00010	4	t
LOG0005541	USR0135	VST003299	RT00792	1	f
LOG0005542	USR0012	VST004699	RT00212	2	t
LOG0005543	USR0244	VST004458	RT00652	2	f
LOG0005544	USR0422	VST001284	RT00260	3	t
LOG0005545	USR0182	VST001087	RT00938	2	f
LOG0005546	USR0195	VST002016	RT00382	2	t
LOG0005547	USR0362	VST001716	RT00389	3	t
LOG0005548	USR0122	VST001727	RT00922	1	f
LOG0005549	USR0053	VST000908	RT00740	3	f
LOG0005550	USR0474	VST003464	RT00955	3	t
LOG0005551	USR0478	VST004342	RT00958	4	t
LOG0005552	USR0416	VST004443	RT00336	2	t
LOG0005553	USR0356	VST004468	RT00005	2	f
LOG0005554	USR0173	VST000809	RT00922	1	t
LOG0005555	USR0179	VST002897	RT00083	2	t
LOG0005556	USR0293	VST002171	RT00006	1	t
LOG0005557	USR0375	VST003129	RT00152	4	f
LOG0005558	USR0059	VST004256	RT00991	1	t
LOG0005559	USR0054	VST001151	RT00735	1	f
LOG0005560	USR0402	VST003679	RT00181	4	f
LOG0005561	USR0257	VST001335	RT00775	3	t
LOG0005562	USR0245	VST000518	RT00778	4	f
LOG0005563	USR0149	VST001289	RT00167	2	f
LOG0005564	USR0284	VST000746	RT00470	2	t
LOG0005565	USR0368	VST004516	RT00078	4	t
LOG0005566	USR0016	VST003968	RT00412	1	t
LOG0005567	USR0176	VST004236	RT00554	4	f
LOG0005568	USR0028	VST004803	RT00574	2	f
LOG0005569	USR0406	VST000698	RT00381	4	f
LOG0005570	USR0467	VST003035	RT00948	1	t
LOG0005571	USR0368	VST000475	RT00790	2	f
LOG0005572	USR0129	VST003977	RT00313	3	t
LOG0005573	USR0223	VST000511	RT00864	4	t
LOG0005574	USR0372	VST000538	RT00395	4	f
LOG0005575	USR0244	VST002261	RT00910	4	f
LOG0005576	USR0426	VST002945	RT00543	4	f
LOG0005577	USR0354	VST003875	RT00004	2	t
LOG0005578	USR0238	VST001367	RT00109	1	f
LOG0005579	USR0232	VST001062	RT00918	3	t
LOG0005580	USR0326	VST004329	RT00886	4	f
LOG0005581	USR0092	VST002308	RT00093	2	t
LOG0005582	USR0003	VST000308	RT00099	4	f
LOG0005583	USR0479	VST004499	RT00192	3	f
LOG0005584	USR0464	VST000997	RT00333	4	t
LOG0005585	USR0081	VST001285	RT00212	1	f
LOG0005586	USR0044	VST004846	RT00595	4	f
LOG0005587	USR0155	VST001130	RT00207	4	t
LOG0005588	USR0435	VST000304	RT00627	4	f
LOG0005589	USR0024	VST003892	RT00986	1	f
LOG0005590	USR0404	VST000855	RT00764	2	t
LOG0005591	USR0416	VST001746	RT00980	1	f
LOG0005592	USR0099	VST000818	RT00573	2	f
LOG0005593	USR0397	VST003650	RT00356	1	t
LOG0005594	USR0368	VST000973	RT00902	1	f
LOG0005595	USR0171	VST004134	RT00253	4	f
LOG0005596	USR0148	VST001179	RT00591	1	t
LOG0005597	USR0123	VST000105	RT00196	2	f
LOG0005598	USR0112	VST000255	RT00262	2	f
LOG0005599	USR0500	VST002536	RT00322	2	f
LOG0005600	USR0130	VST000591	RT00420	2	t
LOG0005601	USR0068	VST000525	RT00498	1	f
LOG0005602	USR0347	VST000370	RT00911	4	f
LOG0005603	USR0316	VST004198	RT00332	3	t
LOG0005604	USR0217	VST002964	RT00296	2	t
LOG0005605	USR0388	VST000664	RT00236	1	f
LOG0005606	USR0380	VST000690	RT00681	4	f
LOG0005607	USR0096	VST002647	RT00007	1	t
LOG0005608	USR0145	VST002589	RT00534	2	t
LOG0005609	USR0385	VST001536	RT00072	2	t
LOG0005610	USR0033	VST002029	RT00500	4	f
LOG0005611	USR0286	VST001857	RT00618	1	t
LOG0005612	USR0005	VST003187	RT00139	2	f
LOG0005613	USR0118	VST002770	RT00386	2	f
LOG0005614	USR0140	VST002988	RT00542	3	f
LOG0005615	USR0230	VST004476	RT00324	3	t
LOG0005616	USR0160	VST001149	RT00949	2	t
LOG0005617	USR0294	VST000781	RT00601	3	t
LOG0005618	USR0249	VST004406	RT00917	3	t
LOG0005619	USR0273	VST002154	RT00665	2	f
LOG0005620	USR0186	VST000556	RT00073	1	f
LOG0005621	USR0365	VST003297	RT00840	1	t
LOG0005622	USR0040	VST003314	RT00389	1	f
LOG0005623	USR0224	VST004493	RT00238	4	t
LOG0005624	USR0152	VST002584	RT00988	1	f
LOG0005625	USR0140	VST003708	RT00322	4	f
LOG0005626	USR0367	VST003869	RT00341	4	t
LOG0005627	USR0128	VST003044	RT00763	3	f
LOG0005628	USR0351	VST003014	RT00305	4	f
LOG0005629	USR0147	VST003845	RT00008	4	f
LOG0005630	USR0285	VST001170	RT00994	4	t
LOG0005631	USR0469	VST003263	RT00983	4	f
LOG0005632	USR0218	VST004023	RT00207	3	f
LOG0005633	USR0436	VST000201	RT00411	2	f
LOG0005634	USR0220	VST001891	RT00258	4	t
LOG0005635	USR0145	VST000012	RT00796	2	f
LOG0005636	USR0329	VST001977	RT00651	1	t
LOG0005637	USR0277	VST001326	RT00046	1	t
LOG0005638	USR0242	VST003372	RT00126	2	f
LOG0005639	USR0060	VST004071	RT00021	2	f
LOG0005640	USR0098	VST003557	RT00170	1	f
LOG0005641	USR0331	VST004967	RT00544	3	f
LOG0005642	USR0375	VST000366	RT00416	3	f
LOG0005643	USR0404	VST000657	RT00455	4	f
LOG0005644	USR0369	VST000161	RT00662	3	t
LOG0005645	USR0181	VST000175	RT00206	3	f
LOG0005646	USR0114	VST003471	RT00333	4	f
LOG0005647	USR0495	VST004061	RT00021	4	t
LOG0005648	USR0103	VST000545	RT00918	3	f
LOG0005649	USR0336	VST003855	RT00802	2	f
LOG0005650	USR0319	VST001762	RT00650	4	t
LOG0005651	USR0057	VST000957	RT00065	2	t
LOG0005652	USR0285	VST000452	RT00577	1	f
LOG0005653	USR0129	VST000082	RT00088	4	t
LOG0005654	USR0380	VST001237	RT00835	2	t
LOG0005655	USR0466	VST004912	RT00479	4	t
LOG0005656	USR0315	VST000447	RT00043	4	t
LOG0005657	USR0448	VST002166	RT00883	4	f
LOG0005658	USR0086	VST001620	RT00937	4	t
LOG0005659	USR0200	VST001794	RT00141	2	f
LOG0005660	USR0071	VST003315	RT00374	2	f
LOG0005661	USR0345	VST004845	RT00516	2	t
LOG0005662	USR0478	VST001174	RT00500	1	f
LOG0005663	USR0098	VST000646	RT00279	4	t
LOG0005664	USR0300	VST000379	RT00326	4	t
LOG0005665	USR0176	VST002656	RT00418	2	t
LOG0005666	USR0233	VST003585	RT00553	2	t
LOG0005667	USR0372	VST003734	RT00914	4	f
LOG0005668	USR0075	VST001141	RT00888	4	f
LOG0005669	USR0143	VST003736	RT00996	1	t
LOG0005670	USR0419	VST002014	RT00602	4	t
LOG0005671	USR0023	VST000662	RT00993	2	f
LOG0005672	USR0181	VST004972	RT00768	1	f
LOG0005673	USR0045	VST000012	RT00929	3	t
LOG0005674	USR0469	VST000388	RT00921	3	t
LOG0005675	USR0092	VST003024	RT00308	4	t
LOG0005676	USR0269	VST003834	RT00657	2	f
LOG0005677	USR0034	VST001920	RT00307	4	t
LOG0005678	USR0166	VST004492	RT00899	2	t
LOG0005679	USR0070	VST002593	RT00823	2	f
LOG0005680	USR0364	VST002709	RT00470	2	t
LOG0005681	USR0196	VST004736	RT00184	3	t
LOG0005682	USR0133	VST000100	RT00631	4	f
LOG0005683	USR0247	VST004553	RT00625	4	f
LOG0005684	USR0382	VST004077	RT00291	3	f
LOG0005685	USR0168	VST002772	RT00249	2	f
LOG0005686	USR0454	VST004170	RT00324	1	t
LOG0005687	USR0277	VST002378	RT00443	1	f
LOG0005688	USR0156	VST001864	RT00604	3	f
LOG0005689	USR0387	VST004020	RT00059	1	t
LOG0005690	USR0023	VST004271	RT00269	2	f
LOG0005691	USR0200	VST003759	RT00318	2	f
LOG0005692	USR0275	VST004593	RT00094	4	f
LOG0005693	USR0459	VST004524	RT00254	2	t
LOG0005694	USR0050	VST000035	RT00687	2	f
LOG0005695	USR0458	VST002167	RT00460	2	t
LOG0005696	USR0186	VST003640	RT00515	1	f
LOG0005697	USR0476	VST003973	RT00533	1	t
LOG0005698	USR0020	VST003381	RT00104	3	t
LOG0005699	USR0492	VST003177	RT00833	3	f
LOG0005700	USR0116	VST000176	RT00402	1	t
LOG0005701	USR0092	VST002154	RT00781	4	f
LOG0005702	USR0349	VST004688	RT00967	4	f
LOG0005703	USR0456	VST001587	RT00333	1	t
LOG0005704	USR0339	VST003659	RT00721	3	t
LOG0005705	USR0053	VST003003	RT00877	4	t
LOG0005706	USR0496	VST000953	RT00608	2	t
LOG0005707	USR0123	VST004957	RT00093	4	t
LOG0005708	USR0341	VST002872	RT00557	4	t
LOG0005709	USR0338	VST004330	RT00574	4	t
LOG0005710	USR0265	VST002715	RT00542	3	t
LOG0005711	USR0004	VST003657	RT00971	3	f
LOG0005712	USR0169	VST002979	RT00782	1	f
LOG0005713	USR0281	VST001810	RT00437	4	t
LOG0005714	USR0290	VST002807	RT00010	3	t
LOG0005715	USR0073	VST004152	RT00456	3	f
LOG0005716	USR0137	VST003760	RT00415	1	t
LOG0005717	USR0338	VST003329	RT00518	2	t
LOG0005718	USR0256	VST002971	RT00979	2	t
LOG0005719	USR0459	VST004909	RT00375	4	f
LOG0005720	USR0141	VST003135	RT00531	2	f
LOG0005721	USR0486	VST001960	RT00524	1	f
LOG0005722	USR0393	VST000806	RT00373	3	f
LOG0005723	USR0208	VST003101	RT00704	2	t
LOG0005724	USR0260	VST001576	RT00615	4	t
LOG0005725	USR0418	VST003731	RT00882	4	f
LOG0005726	USR0263	VST000600	RT00762	3	f
LOG0005727	USR0271	VST002616	RT00756	4	f
LOG0005728	USR0038	VST003372	RT00850	1	t
LOG0005729	USR0203	VST000612	RT00439	2	f
LOG0005730	USR0224	VST001950	RT00195	4	f
LOG0005731	USR0347	VST000561	RT00265	2	t
LOG0005732	USR0478	VST002547	RT00507	3	t
LOG0005733	USR0052	VST000627	RT00646	2	f
LOG0005734	USR0081	VST002812	RT00897	1	f
LOG0005735	USR0356	VST001611	RT00426	3	t
LOG0005736	USR0211	VST003263	RT01000	4	t
LOG0005737	USR0007	VST003783	RT00861	3	f
LOG0005738	USR0363	VST000675	RT00951	2	t
LOG0005739	USR0045	VST003723	RT00689	2	f
LOG0005740	USR0315	VST000049	RT00867	2	f
LOG0005741	USR0378	VST001387	RT00099	2	t
LOG0005742	USR0277	VST001903	RT00030	3	f
LOG0005743	USR0412	VST004723	RT00291	3	t
LOG0005744	USR0259	VST003568	RT00575	2	t
LOG0005745	USR0142	VST004373	RT00487	4	f
LOG0005746	USR0258	VST002095	RT00406	3	t
LOG0005747	USR0285	VST003843	RT00939	1	t
LOG0005748	USR0402	VST004312	RT00028	3	f
LOG0005749	USR0037	VST000230	RT00146	1	f
LOG0005750	USR0429	VST003493	RT00288	4	t
LOG0005751	USR0045	VST001686	RT00581	1	f
LOG0005752	USR0408	VST001311	RT00950	1	f
LOG0005753	USR0120	VST004142	RT00252	4	t
LOG0005754	USR0046	VST000633	RT00162	2	t
LOG0005755	USR0140	VST002423	RT00927	3	f
LOG0005756	USR0053	VST002751	RT00110	4	t
LOG0005757	USR0301	VST000333	RT00865	1	f
LOG0005758	USR0288	VST001880	RT00644	2	f
LOG0005759	USR0274	VST000507	RT00398	3	f
LOG0005760	USR0269	VST004213	RT00271	4	f
LOG0005761	USR0388	VST000943	RT00188	3	t
LOG0005762	USR0279	VST000636	RT00532	2	t
LOG0005763	USR0062	VST001590	RT00276	3	t
LOG0005764	USR0054	VST001463	RT00689	2	t
LOG0005765	USR0458	VST001992	RT00611	4	t
LOG0005766	USR0439	VST004965	RT00247	2	f
LOG0005767	USR0069	VST001735	RT00324	4	f
LOG0005768	USR0242	VST002264	RT00018	2	f
LOG0005769	USR0424	VST000113	RT00408	3	t
LOG0005770	USR0270	VST002264	RT00411	2	f
LOG0005771	USR0252	VST000427	RT00801	2	t
LOG0005772	USR0354	VST001067	RT00125	3	t
LOG0005773	USR0284	VST002812	RT00320	1	f
LOG0005774	USR0456	VST004380	RT00153	2	f
LOG0005775	USR0464	VST000834	RT00581	4	t
LOG0005776	USR0351	VST000230	RT00658	2	t
LOG0005777	USR0071	VST004481	RT00557	1	f
LOG0005778	USR0323	VST004255	RT00878	4	t
LOG0005779	USR0413	VST000824	RT00020	3	f
LOG0005780	USR0100	VST002519	RT00803	3	f
LOG0005781	USR0061	VST003668	RT00247	3	t
LOG0005782	USR0103	VST004304	RT00390	4	f
LOG0005783	USR0452	VST004270	RT00347	2	t
LOG0005784	USR0393	VST001824	RT00476	4	t
LOG0005785	USR0119	VST001105	RT00203	4	f
LOG0005786	USR0017	VST001042	RT00009	1	f
LOG0005787	USR0305	VST000708	RT00692	4	t
LOG0005788	USR0191	VST001384	RT00668	3	f
LOG0005789	USR0212	VST001892	RT00531	4	t
LOG0005790	USR0078	VST001303	RT00103	1	t
LOG0005791	USR0046	VST003022	RT00246	4	f
LOG0005792	USR0093	VST000677	RT00597	4	f
LOG0005793	USR0377	VST002565	RT00319	3	f
LOG0005794	USR0013	VST003323	RT00351	4	f
LOG0005795	USR0228	VST004758	RT00234	2	f
LOG0005796	USR0301	VST001564	RT00647	3	f
LOG0005797	USR0437	VST001261	RT00037	1	t
LOG0005798	USR0017	VST003204	RT00345	1	t
LOG0005799	USR0303	VST002354	RT00604	1	t
LOG0005800	USR0062	VST000358	RT00292	4	f
LOG0005801	USR0434	VST003235	RT00017	2	f
LOG0005802	USR0043	VST000419	RT00090	3	f
LOG0005803	USR0068	VST004738	RT00348	2	t
LOG0005804	USR0380	VST003956	RT00677	2	f
LOG0005805	USR0212	VST001594	RT00977	1	f
LOG0005806	USR0203	VST004603	RT00444	1	f
LOG0005807	USR0490	VST001386	RT00253	2	t
LOG0005808	USR0214	VST004408	RT00817	2	t
LOG0005809	USR0109	VST002752	RT00593	3	t
LOG0005810	USR0456	VST000245	RT00993	1	f
LOG0005811	USR0284	VST004573	RT00184	1	f
LOG0005812	USR0429	VST000615	RT00290	4	t
LOG0005813	USR0425	VST000250	RT00761	1	t
LOG0005814	USR0094	VST003094	RT00215	3	t
LOG0005815	USR0225	VST001596	RT00158	4	f
LOG0005816	USR0225	VST001930	RT00923	3	f
LOG0005817	USR0239	VST000511	RT00691	1	t
LOG0005818	USR0118	VST003968	RT00393	1	t
LOG0005819	USR0420	VST004870	RT00020	2	f
LOG0005820	USR0091	VST001366	RT00471	2	t
LOG0005821	USR0340	VST000924	RT00431	3	t
LOG0005822	USR0289	VST000074	RT00659	4	t
LOG0005823	USR0281	VST000809	RT00997	1	t
LOG0005824	USR0492	VST002879	RT00068	2	f
LOG0005825	USR0491	VST002268	RT00077	2	f
LOG0005826	USR0019	VST002127	RT00102	1	f
LOG0005827	USR0175	VST004331	RT00652	1	t
LOG0005828	USR0469	VST002205	RT00893	4	t
LOG0005829	USR0106	VST003680	RT00585	2	f
LOG0005830	USR0289	VST004738	RT00207	4	t
LOG0005831	USR0248	VST004717	RT00213	4	f
LOG0005832	USR0323	VST003659	RT00079	1	t
LOG0005833	USR0142	VST000985	RT00113	4	t
LOG0005834	USR0463	VST001299	RT00765	1	t
LOG0005835	USR0417	VST003745	RT00133	3	f
LOG0005836	USR0298	VST003281	RT00197	4	f
LOG0005837	USR0470	VST003956	RT00025	2	t
LOG0005838	USR0193	VST002654	RT00472	2	t
LOG0005839	USR0351	VST003688	RT00613	3	f
LOG0005840	USR0303	VST002963	RT00757	3	f
LOG0005841	USR0291	VST002947	RT00543	4	f
LOG0005842	USR0373	VST003046	RT00942	2	t
LOG0005843	USR0468	VST000860	RT00290	2	f
LOG0005844	USR0416	VST002086	RT00256	1	t
LOG0005845	USR0439	VST002728	RT00937	1	f
LOG0005846	USR0438	VST000377	RT00206	2	t
LOG0005847	USR0332	VST004472	RT00475	1	f
LOG0005848	USR0435	VST004691	RT00068	1	f
LOG0005849	USR0208	VST002795	RT00215	1	f
LOG0005850	USR0443	VST001066	RT00634	3	f
LOG0005851	USR0456	VST003683	RT00422	2	f
LOG0005852	USR0248	VST002008	RT00558	2	f
LOG0005853	USR0142	VST003202	RT00581	2	f
LOG0005854	USR0402	VST001052	RT00539	1	t
LOG0005855	USR0384	VST000629	RT00683	4	t
LOG0005856	USR0311	VST002374	RT00757	4	t
LOG0005857	USR0222	VST003975	RT00462	1	f
LOG0005858	USR0225	VST001184	RT00455	3	t
LOG0005859	USR0354	VST004842	RT00301	3	t
LOG0005860	USR0184	VST001278	RT00786	2	t
LOG0005861	USR0364	VST001952	RT00288	4	f
LOG0005862	USR0305	VST003922	RT00761	3	f
LOG0005863	USR0482	VST003425	RT00002	4	f
LOG0005864	USR0188	VST001326	RT00937	4	f
LOG0005865	USR0113	VST001172	RT00020	3	f
LOG0005866	USR0181	VST004317	RT00477	1	t
LOG0005867	USR0199	VST003770	RT00954	2	t
LOG0005868	USR0390	VST001872	RT00491	2	f
LOG0005869	USR0070	VST003632	RT00986	3	t
LOG0005870	USR0086	VST002311	RT00806	1	t
LOG0005871	USR0392	VST002344	RT00257	3	t
LOG0005872	USR0485	VST003387	RT00453	3	t
LOG0005873	USR0399	VST003068	RT00438	4	f
LOG0005874	USR0410	VST002340	RT00761	4	f
LOG0005875	USR0039	VST000684	RT00398	2	t
LOG0005876	USR0131	VST000876	RT00153	4	f
LOG0005877	USR0441	VST001055	RT00649	4	t
LOG0005878	USR0010	VST003754	RT00222	1	f
LOG0005879	USR0003	VST002603	RT00723	3	t
LOG0005880	USR0478	VST004015	RT00701	3	f
LOG0005881	USR0302	VST000349	RT00436	1	t
LOG0005882	USR0150	VST004315	RT00744	4	f
LOG0005883	USR0067	VST001023	RT00136	4	t
LOG0005884	USR0193	VST000450	RT00528	3	t
LOG0005885	USR0097	VST000504	RT00626	2	t
LOG0005886	USR0019	VST000086	RT00776	3	t
LOG0005887	USR0484	VST003323	RT00279	2	t
LOG0005888	USR0318	VST000523	RT00585	4	f
LOG0005889	USR0098	VST003152	RT00736	2	f
LOG0005890	USR0057	VST003693	RT00485	2	t
LOG0005891	USR0351	VST002509	RT00546	2	t
LOG0005892	USR0107	VST000630	RT00245	2	f
LOG0005893	USR0088	VST000018	RT00750	2	t
LOG0005894	USR0460	VST001269	RT00018	3	f
LOG0005895	USR0141	VST001177	RT00877	1	t
LOG0005896	USR0144	VST001633	RT00556	4	f
LOG0005897	USR0400	VST004596	RT00143	3	t
LOG0005898	USR0371	VST004554	RT00501	1	t
LOG0005899	USR0375	VST003770	RT00527	3	t
LOG0005900	USR0052	VST003614	RT00093	1	t
LOG0005901	USR0212	VST000115	RT00383	3	t
LOG0005902	USR0041	VST000753	RT00889	4	t
LOG0005903	USR0304	VST004865	RT00279	4	f
LOG0005904	USR0091	VST002401	RT00727	2	t
LOG0005905	USR0039	VST001871	RT00449	1	f
LOG0005906	USR0013	VST002589	RT00761	3	t
LOG0005907	USR0388	VST000322	RT00982	2	f
LOG0005908	USR0096	VST004322	RT00583	3	t
LOG0005909	USR0109	VST003828	RT00621	4	f
LOG0005910	USR0104	VST004457	RT00288	4	f
LOG0005911	USR0354	VST000834	RT00476	1	t
LOG0005912	USR0231	VST004208	RT00882	3	t
LOG0005913	USR0043	VST000212	RT00672	3	t
LOG0005914	USR0209	VST001257	RT00801	2	t
LOG0005915	USR0088	VST000159	RT00171	4	f
LOG0005916	USR0093	VST002620	RT00525	2	t
LOG0005917	USR0174	VST001348	RT00372	2	t
LOG0005918	USR0476	VST003165	RT00732	1	f
LOG0005919	USR0126	VST003213	RT00393	2	t
LOG0005920	USR0109	VST000911	RT00958	1	t
LOG0005921	USR0047	VST002452	RT00185	4	f
LOG0005922	USR0214	VST003804	RT00510	2	t
LOG0005923	USR0092	VST000404	RT00432	2	t
LOG0005924	USR0181	VST001842	RT00939	2	f
LOG0005925	USR0409	VST002649	RT00835	2	t
LOG0005926	USR0041	VST001691	RT00209	4	t
LOG0005927	USR0259	VST003486	RT00994	1	t
LOG0005928	USR0121	VST001257	RT00800	4	f
LOG0005929	USR0077	VST004289	RT00329	1	t
LOG0005930	USR0095	VST003185	RT00361	1	f
LOG0005931	USR0269	VST001643	RT00444	2	f
LOG0005932	USR0361	VST003353	RT00897	2	t
LOG0005933	USR0018	VST000523	RT00441	2	f
LOG0005934	USR0293	VST004446	RT00369	1	t
LOG0005935	USR0171	VST001945	RT00106	3	t
LOG0005936	USR0162	VST003572	RT00724	3	t
LOG0005937	USR0465	VST001561	RT00325	3	f
LOG0005938	USR0311	VST004748	RT00232	4	t
LOG0005939	USR0052	VST004731	RT00725	1	f
LOG0005940	USR0469	VST003595	RT00837	3	f
LOG0005941	USR0036	VST000593	RT00708	1	f
LOG0005942	USR0438	VST003894	RT00249	1	t
LOG0005943	USR0187	VST002669	RT00317	4	f
LOG0005944	USR0370	VST003903	RT00264	2	f
LOG0005945	USR0248	VST000756	RT00729	2	f
LOG0005946	USR0052	VST001300	RT00503	4	f
LOG0005947	USR0488	VST000497	RT00263	4	f
LOG0005948	USR0019	VST004869	RT00933	1	f
LOG0005949	USR0396	VST002422	RT00682	3	t
LOG0005950	USR0092	VST001599	RT00416	1	f
LOG0005951	USR0139	VST004280	RT00913	1	t
LOG0005952	USR0304	VST004128	RT00668	3	t
LOG0005953	USR0357	VST004379	RT00070	2	t
LOG0005954	USR0220	VST004932	RT00234	1	f
LOG0005955	USR0099	VST003591	RT00432	2	t
LOG0005956	USR0236	VST004782	RT00054	2	t
LOG0005957	USR0207	VST000462	RT00170	2	f
LOG0005958	USR0144	VST004967	RT00036	1	f
LOG0005959	USR0493	VST000368	RT00834	3	t
LOG0005960	USR0199	VST002706	RT00927	3	t
LOG0005961	USR0303	VST003324	RT00961	2	t
LOG0005962	USR0323	VST000166	RT00259	2	f
LOG0005963	USR0287	VST003687	RT00251	3	f
LOG0005964	USR0332	VST004083	RT00013	4	f
LOG0005965	USR0264	VST003048	RT00671	4	t
LOG0005966	USR0217	VST001729	RT00541	2	f
LOG0005967	USR0189	VST004698	RT00057	3	f
LOG0005968	USR0044	VST003670	RT00161	4	f
LOG0005969	USR0434	VST003175	RT00437	3	t
LOG0005970	USR0291	VST002174	RT00778	1	f
LOG0005971	USR0460	VST000038	RT00230	2	t
LOG0005972	USR0189	VST004444	RT00831	4	t
LOG0005973	USR0469	VST002022	RT00841	2	f
LOG0005974	USR0474	VST000734	RT00193	1	f
LOG0005975	USR0439	VST004522	RT00620	3	f
LOG0005976	USR0194	VST000648	RT00357	2	t
LOG0005977	USR0270	VST003303	RT00352	4	t
LOG0005978	USR0366	VST000320	RT00865	1	t
LOG0005979	USR0260	VST004608	RT00258	4	t
LOG0005980	USR0401	VST002554	RT00622	3	f
LOG0005981	USR0239	VST003179	RT00642	4	f
LOG0005982	USR0112	VST001723	RT00635	4	t
LOG0005983	USR0069	VST001757	RT00965	4	t
LOG0005984	USR0408	VST003679	RT00970	1	t
LOG0005985	USR0049	VST003779	RT00628	4	t
LOG0005986	USR0311	VST002516	RT00742	4	f
LOG0005987	USR0455	VST003848	RT00293	1	f
LOG0005988	USR0151	VST000938	RT00386	1	f
LOG0005989	USR0239	VST000765	RT00745	1	f
LOG0005990	USR0337	VST000653	RT00829	3	t
LOG0005991	USR0396	VST004081	RT00234	1	t
LOG0005992	USR0395	VST003603	RT00296	3	f
LOG0005993	USR0115	VST002130	RT00703	1	f
LOG0005994	USR0075	VST004577	RT00537	1	f
LOG0005995	USR0098	VST003965	RT00379	2	f
LOG0005996	USR0383	VST004612	RT00678	2	f
LOG0005997	USR0111	VST000187	RT00805	2	f
LOG0005998	USR0357	VST000146	RT00210	2	t
LOG0005999	USR0370	VST004248	RT00539	1	t
LOG0006000	USR0285	VST001387	RT00852	1	f
LOG0006001	USR0256	VST004189	RT00178	3	f
LOG0006002	USR0318	VST002588	RT00930	1	t
LOG0006003	USR0309	VST002697	RT00556	3	t
LOG0006004	USR0117	VST004013	RT00072	4	f
LOG0006005	USR0176	VST004698	RT00900	4	t
LOG0006006	USR0228	VST000049	RT00508	1	t
LOG0006007	USR0347	VST003330	RT00222	4	t
LOG0006008	USR0106	VST003590	RT00948	1	t
LOG0006009	USR0342	VST002589	RT00823	3	t
LOG0006010	USR0384	VST003482	RT00228	2	t
LOG0006011	USR0450	VST000775	RT00841	4	t
LOG0006012	USR0239	VST004642	RT00233	1	t
LOG0006013	USR0100	VST001261	RT00268	2	t
LOG0006014	USR0176	VST000650	RT00910	3	t
LOG0006015	USR0350	VST003440	RT00254	1	f
LOG0006016	USR0443	VST003049	RT00675	4	f
LOG0006017	USR0455	VST002024	RT00006	3	t
LOG0006018	USR0441	VST001081	RT00047	1	f
LOG0006019	USR0249	VST004271	RT00407	4	f
LOG0006020	USR0076	VST002075	RT00883	3	t
LOG0006021	USR0003	VST004243	RT00580	3	f
LOG0006022	USR0081	VST004964	RT00254	2	t
LOG0006023	USR0361	VST002313	RT00449	2	f
LOG0006024	USR0288	VST003475	RT00059	2	f
LOG0006025	USR0008	VST002306	RT00393	1	f
LOG0006026	USR0087	VST003261	RT00631	3	t
LOG0006027	USR0486	VST002875	RT00698	2	f
LOG0006028	USR0286	VST004839	RT00560	4	t
LOG0006029	USR0399	VST004806	RT00191	1	f
LOG0006030	USR0074	VST003311	RT00265	2	f
LOG0006031	USR0439	VST001351	RT00684	1	t
LOG0006032	USR0123	VST001094	RT00558	3	f
LOG0006033	USR0377	VST003777	RT00143	4	t
LOG0006034	USR0294	VST003097	RT00246	3	t
LOG0006035	USR0143	VST001855	RT00216	4	t
LOG0006036	USR0158	VST002267	RT00437	3	t
LOG0006037	USR0430	VST000561	RT00688	1	f
LOG0006038	USR0448	VST004988	RT00840	3	t
LOG0006039	USR0410	VST004693	RT00476	4	t
LOG0006040	USR0371	VST004546	RT00384	1	t
LOG0006041	USR0109	VST002384	RT00938	1	f
LOG0006042	USR0334	VST001826	RT00878	4	f
LOG0006043	USR0195	VST001684	RT00657	4	t
LOG0006044	USR0036	VST001199	RT00547	1	f
LOG0006045	USR0090	VST001010	RT00415	4	f
LOG0006046	USR0462	VST001772	RT00132	3	t
LOG0006047	USR0415	VST001708	RT00816	3	t
LOG0006048	USR0462	VST004536	RT00398	3	f
LOG0006049	USR0296	VST002273	RT00507	1	f
LOG0006050	USR0330	VST002613	RT00153	3	f
LOG0006051	USR0201	VST004342	RT00814	1	f
LOG0006052	USR0046	VST001543	RT00560	4	t
LOG0006053	USR0488	VST001238	RT00168	3	f
LOG0006054	USR0107	VST002976	RT00690	1	f
LOG0006055	USR0170	VST001725	RT00775	2	f
LOG0006056	USR0146	VST002264	RT00607	3	t
LOG0006057	USR0356	VST000283	RT00828	3	f
LOG0006058	USR0420	VST002621	RT00803	1	t
LOG0006059	USR0460	VST003287	RT00230	1	t
LOG0006060	USR0178	VST000172	RT00703	4	t
LOG0006061	USR0061	VST003457	RT00404	1	f
LOG0006062	USR0424	VST001883	RT00144	4	f
LOG0006063	USR0003	VST002276	RT00918	2	t
LOG0006064	USR0082	VST002622	RT00676	4	f
LOG0006065	USR0263	VST000601	RT00531	3	t
LOG0006066	USR0287	VST003791	RT00898	1	t
LOG0006067	USR0321	VST002024	RT00068	2	f
LOG0006068	USR0095	VST000467	RT00098	2	t
LOG0006069	USR0064	VST003951	RT00007	1	t
LOG0006070	USR0246	VST003890	RT00815	3	f
LOG0006071	USR0077	VST004393	RT00177	1	t
LOG0006072	USR0477	VST002593	RT00206	1	f
LOG0006073	USR0259	VST001020	RT00299	1	f
LOG0006074	USR0093	VST001548	RT00800	4	t
LOG0006075	USR0291	VST004757	RT00913	2	t
LOG0006076	USR0271	VST004750	RT00229	2	f
LOG0006077	USR0021	VST004898	RT00896	3	t
LOG0006078	USR0062	VST004437	RT00631	2	f
LOG0006079	USR0339	VST000704	RT00270	1	t
LOG0006080	USR0412	VST000853	RT00081	2	f
LOG0006081	USR0260	VST000306	RT00672	3	t
LOG0006082	USR0237	VST003579	RT00188	4	f
LOG0006083	USR0141	VST001934	RT00700	4	t
LOG0006084	USR0463	VST001788	RT00820	1	t
LOG0006085	USR0435	VST003788	RT00501	1	f
LOG0006086	USR0432	VST000874	RT00706	2	f
LOG0006087	USR0167	VST001582	RT00487	2	t
LOG0006088	USR0480	VST003958	RT00772	3	t
LOG0006089	USR0067	VST004591	RT00488	1	t
LOG0006090	USR0350	VST003333	RT00990	3	t
LOG0006091	USR0058	VST001686	RT00478	4	f
LOG0006092	USR0212	VST001606	RT00703	2	t
LOG0006093	USR0130	VST000896	RT00289	1	t
LOG0006094	USR0498	VST003264	RT00106	2	f
LOG0006095	USR0025	VST003425	RT00641	1	t
LOG0006096	USR0011	VST003854	RT00609	4	f
LOG0006097	USR0257	VST002347	RT00996	3	t
LOG0006098	USR0304	VST003532	RT00576	1	f
LOG0006099	USR0369	VST002475	RT00640	2	f
LOG0006100	USR0432	VST001862	RT00223	1	t
LOG0006101	USR0394	VST002764	RT00805	3	f
LOG0006102	USR0081	VST004853	RT00974	4	t
LOG0006103	USR0286	VST000031	RT00382	2	f
LOG0006104	USR0419	VST004008	RT00838	4	f
LOG0006105	USR0370	VST003456	RT00903	4	f
LOG0006106	USR0019	VST000243	RT00104	3	t
LOG0006107	USR0110	VST004782	RT00664	1	t
LOG0006108	USR0437	VST001499	RT00114	1	f
LOG0006109	USR0034	VST004669	RT00508	1	t
LOG0006110	USR0288	VST003423	RT00964	1	f
LOG0006111	USR0332	VST004004	RT00055	2	f
LOG0006112	USR0491	VST001660	RT00121	4	t
LOG0006113	USR0255	VST003229	RT00217	1	f
LOG0006114	USR0126	VST000599	RT00635	4	t
LOG0006115	USR0209	VST002196	RT00003	2	f
LOG0006116	USR0134	VST000070	RT00092	2	t
LOG0006117	USR0499	VST001394	RT00407	2	f
LOG0006118	USR0397	VST003660	RT00676	4	f
LOG0006119	USR0487	VST001650	RT00441	1	f
LOG0006120	USR0086	VST002282	RT00631	4	f
LOG0006121	USR0075	VST003683	RT00432	1	f
LOG0006122	USR0448	VST002684	RT00909	3	t
LOG0006123	USR0135	VST004563	RT00061	1	t
LOG0006124	USR0301	VST004653	RT00726	1	f
LOG0006125	USR0173	VST004990	RT00473	1	f
LOG0006126	USR0213	VST004932	RT00247	2	t
LOG0006127	USR0321	VST001311	RT00747	3	t
LOG0006128	USR0350	VST004714	RT00920	1	f
LOG0006129	USR0019	VST004230	RT00939	3	f
LOG0006130	USR0499	VST004104	RT00869	4	f
LOG0006131	USR0119	VST002076	RT00372	4	f
LOG0006132	USR0303	VST000783	RT00289	2	f
LOG0006133	USR0302	VST003807	RT00590	4	f
LOG0006134	USR0285	VST001334	RT00024	3	t
LOG0006135	USR0227	VST003718	RT00406	3	f
LOG0006136	USR0212	VST004637	RT00308	3	f
LOG0006137	USR0356	VST001058	RT00613	3	t
LOG0006138	USR0189	VST002055	RT00372	3	t
LOG0006139	USR0487	VST003402	RT00763	2	t
LOG0006140	USR0321	VST002110	RT00635	1	f
LOG0006141	USR0151	VST003158	RT00215	4	t
LOG0006142	USR0223	VST003797	RT00262	3	f
LOG0006143	USR0128	VST003649	RT00915	4	t
LOG0006144	USR0248	VST001321	RT00844	2	t
LOG0006145	USR0051	VST004418	RT00346	2	t
LOG0006146	USR0191	VST003700	RT00413	1	f
LOG0006147	USR0483	VST000733	RT00123	2	t
LOG0006148	USR0500	VST003634	RT00764	1	t
LOG0006149	USR0495	VST003550	RT00320	3	t
LOG0006150	USR0237	VST003663	RT00910	2	f
LOG0006151	USR0022	VST004645	RT00337	4	f
LOG0006152	USR0110	VST000605	RT00158	2	f
LOG0006153	USR0327	VST001723	RT00327	2	f
LOG0006154	USR0033	VST002405	RT00661	3	f
LOG0006155	USR0127	VST003483	RT00065	1	t
LOG0006156	USR0365	VST002813	RT00369	1	t
LOG0006157	USR0356	VST001582	RT00870	2	f
LOG0006158	USR0044	VST002279	RT00004	4	t
LOG0006159	USR0007	VST002351	RT00686	2	t
LOG0006160	USR0128	VST003624	RT00648	4	f
LOG0006161	USR0091	VST000715	RT00914	3	f
LOG0006162	USR0130	VST000925	RT00756	3	f
LOG0006163	USR0017	VST003163	RT00060	1	t
LOG0006164	USR0321	VST004154	RT00045	4	f
LOG0006165	USR0186	VST004530	RT00584	2	f
LOG0006166	USR0110	VST004079	RT00607	2	f
LOG0006167	USR0286	VST002570	RT00543	2	t
LOG0006168	USR0470	VST002816	RT00156	2	t
LOG0006169	USR0348	VST004579	RT00888	3	t
LOG0006170	USR0481	VST004463	RT00752	4	f
LOG0006171	USR0410	VST000889	RT00064	3	t
LOG0006172	USR0163	VST003479	RT00421	4	f
LOG0006173	USR0447	VST003590	RT00323	1	f
LOG0006174	USR0075	VST001724	RT00109	4	t
LOG0006175	USR0199	VST001259	RT00463	2	f
LOG0006176	USR0412	VST000411	RT00580	3	t
LOG0006177	USR0409	VST002231	RT00547	2	f
LOG0006178	USR0445	VST003195	RT00251	4	f
LOG0006179	USR0361	VST002206	RT00866	4	t
LOG0006180	USR0287	VST002061	RT00510	1	f
LOG0006181	USR0182	VST003899	RT00548	4	t
LOG0006182	USR0451	VST002614	RT00441	4	t
LOG0006183	USR0097	VST001813	RT00454	2	f
LOG0006184	USR0051	VST001803	RT00644	4	f
LOG0006185	USR0314	VST003907	RT00817	4	f
LOG0006186	USR0034	VST000678	RT00734	3	f
LOG0006187	USR0443	VST002911	RT00679	3	f
LOG0006188	USR0021	VST004714	RT00274	1	f
LOG0006189	USR0184	VST002252	RT00060	1	f
LOG0006190	USR0293	VST003005	RT00342	2	f
LOG0006191	USR0064	VST000795	RT00394	2	f
LOG0006192	USR0497	VST000729	RT00113	3	f
LOG0006193	USR0403	VST001694	RT00221	3	f
LOG0006194	USR0124	VST004735	RT00791	3	t
LOG0006195	USR0101	VST000191	RT00068	1	f
LOG0006196	USR0119	VST004995	RT00315	1	f
LOG0006197	USR0341	VST001997	RT00467	4	f
LOG0006198	USR0078	VST002108	RT00858	1	t
LOG0006199	USR0458	VST003867	RT00263	4	f
LOG0006200	USR0181	VST001490	RT00781	2	t
LOG0006201	USR0199	VST002110	RT00131	1	t
LOG0006202	USR0477	VST000638	RT00424	2	f
LOG0006203	USR0447	VST004046	RT00267	4	f
LOG0006204	USR0360	VST004159	RT00720	2	f
LOG0006205	USR0190	VST002820	RT00212	2	t
LOG0006206	USR0328	VST004112	RT00563	1	t
LOG0006207	USR0103	VST000842	RT00983	4	t
LOG0006208	USR0333	VST003952	RT00919	4	f
LOG0006209	USR0366	VST004059	RT00288	3	f
LOG0006210	USR0275	VST003248	RT00425	1	t
LOG0006211	USR0459	VST001217	RT00554	1	t
LOG0006212	USR0130	VST000899	RT00759	4	t
LOG0006213	USR0241	VST002223	RT00934	1	t
LOG0006214	USR0134	VST001258	RT00707	2	f
LOG0006215	USR0157	VST001515	RT00244	3	f
LOG0006216	USR0425	VST000417	RT00712	4	t
LOG0006217	USR0435	VST004547	RT00870	1	f
LOG0006218	USR0389	VST002884	RT00633	1	t
LOG0006219	USR0425	VST003827	RT01000	2	t
LOG0006220	USR0318	VST004376	RT00334	1	f
LOG0006221	USR0158	VST004340	RT00328	1	f
LOG0006222	USR0359	VST000675	RT00715	2	f
LOG0006223	USR0190	VST000103	RT00106	1	t
LOG0006224	USR0100	VST002358	RT00762	3	t
LOG0006225	USR0411	VST003994	RT00887	2	f
LOG0006226	USR0434	VST004028	RT00938	4	f
LOG0006227	USR0466	VST003709	RT00939	3	f
LOG0006228	USR0052	VST004213	RT00801	1	t
LOG0006229	USR0049	VST001496	RT00079	2	t
LOG0006230	USR0446	VST004859	RT00165	2	f
LOG0006231	USR0100	VST003393	RT00846	1	f
LOG0006232	USR0444	VST003507	RT00631	4	t
LOG0006233	USR0382	VST002786	RT00986	3	f
LOG0006234	USR0251	VST002235	RT00057	1	t
LOG0006235	USR0374	VST003660	RT00960	4	f
LOG0006236	USR0464	VST004881	RT00960	2	t
LOG0006237	USR0054	VST003733	RT00188	2	t
LOG0006238	USR0375	VST004803	RT00052	2	f
LOG0006239	USR0389	VST004892	RT00072	1	f
LOG0006240	USR0137	VST004569	RT00753	4	t
LOG0006241	USR0162	VST003526	RT00324	1	f
LOG0006242	USR0354	VST003518	RT00612	1	f
LOG0006243	USR0292	VST004778	RT00338	3	f
LOG0006244	USR0479	VST004190	RT00155	3	t
LOG0006245	USR0500	VST004832	RT00059	3	t
LOG0006246	USR0404	VST002530	RT00275	4	t
LOG0006247	USR0081	VST001914	RT00771	2	f
LOG0006248	USR0468	VST002458	RT00201	3	t
LOG0006249	USR0220	VST001151	RT00295	2	f
LOG0006250	USR0085	VST003859	RT00322	4	f
LOG0006251	USR0083	VST004138	RT00329	3	t
LOG0006252	USR0319	VST004137	RT00952	3	t
LOG0006253	USR0067	VST001511	RT00390	2	t
LOG0006254	USR0414	VST003971	RT00998	1	f
LOG0006255	USR0453	VST003916	RT00284	4	f
LOG0006256	USR0234	VST003253	RT00176	4	t
LOG0006257	USR0198	VST003750	RT00610	3	f
LOG0006258	USR0259	VST000744	RT00349	4	t
LOG0006259	USR0177	VST002766	RT00432	2	t
LOG0006260	USR0298	VST003939	RT00963	1	t
LOG0006261	USR0280	VST002512	RT00694	1	f
LOG0006262	USR0300	VST001074	RT00382	4	t
LOG0006263	USR0129	VST003218	RT00272	1	t
LOG0006264	USR0498	VST004394	RT00492	2	t
LOG0006265	USR0371	VST002193	RT00547	3	t
LOG0006266	USR0438	VST000016	RT00331	3	f
LOG0006267	USR0180	VST003554	RT00875	4	f
LOG0006268	USR0292	VST000107	RT00599	4	f
LOG0006269	USR0207	VST004315	RT00158	4	f
LOG0006270	USR0489	VST002969	RT00432	3	f
LOG0006271	USR0294	VST004467	RT00325	4	f
LOG0006272	USR0428	VST003046	RT00116	1	f
LOG0006273	USR0338	VST002858	RT00520	3	t
LOG0006274	USR0471	VST004350	RT00619	2	t
LOG0006275	USR0175	VST001429	RT00619	4	f
LOG0006276	USR0029	VST002009	RT00626	3	t
LOG0006277	USR0179	VST003102	RT00435	4	f
LOG0006278	USR0041	VST003637	RT00522	3	f
LOG0006279	USR0470	VST003472	RT00796	3	t
LOG0006280	USR0192	VST003032	RT00932	3	t
LOG0006281	USR0344	VST002922	RT00572	2	t
LOG0006282	USR0237	VST004446	RT00266	3	t
LOG0006283	USR0304	VST000879	RT00398	1	f
LOG0006284	USR0461	VST002513	RT00102	4	t
LOG0006285	USR0225	VST000311	RT00063	4	f
LOG0006286	USR0114	VST001115	RT00997	4	f
LOG0006287	USR0278	VST001322	RT00687	3	t
LOG0006288	USR0355	VST003397	RT00709	4	t
LOG0006289	USR0017	VST004376	RT00824	1	t
LOG0006290	USR0086	VST000967	RT00902	1	f
LOG0006291	USR0389	VST003190	RT00511	1	f
LOG0006292	USR0317	VST000695	RT00222	2	t
LOG0006293	USR0345	VST002615	RT00915	1	t
LOG0006294	USR0390	VST000271	RT00436	1	f
LOG0006295	USR0181	VST001412	RT00190	4	t
LOG0006296	USR0337	VST003028	RT00640	3	t
LOG0006297	USR0351	VST003125	RT00945	4	t
LOG0006298	USR0145	VST001754	RT00334	2	t
LOG0006299	USR0315	VST004937	RT00907	2	t
LOG0006300	USR0225	VST001822	RT00558	2	t
LOG0006301	USR0423	VST004336	RT00581	1	t
LOG0006302	USR0054	VST003286	RT00301	1	f
LOG0006303	USR0382	VST000361	RT00351	1	t
LOG0006304	USR0432	VST003436	RT00876	3	t
LOG0006305	USR0421	VST000734	RT00570	4	f
LOG0006306	USR0304	VST000852	RT00928	1	f
LOG0006307	USR0068	VST000860	RT00728	2	t
LOG0006308	USR0107	VST004797	RT00115	3	f
LOG0006309	USR0334	VST001351	RT00522	3	t
LOG0006310	USR0077	VST004085	RT00909	2	f
LOG0006311	USR0027	VST002884	RT00367	1	f
LOG0006312	USR0344	VST003548	RT00269	3	f
LOG0006313	USR0155	VST004919	RT00804	2	t
LOG0006314	USR0072	VST004193	RT00086	1	f
LOG0006315	USR0447	VST000327	RT00896	3	t
LOG0006316	USR0180	VST002121	RT00969	3	t
LOG0006317	USR0047	VST000994	RT00378	4	f
LOG0006318	USR0242	VST001767	RT00147	4	f
LOG0006319	USR0359	VST004429	RT00118	3	t
LOG0006320	USR0277	VST001181	RT00135	3	t
LOG0006321	USR0371	VST001965	RT00527	3	t
LOG0006322	USR0313	VST002782	RT00849	4	f
LOG0006323	USR0105	VST002906	RT00814	1	t
LOG0006324	USR0459	VST000099	RT00206	4	f
LOG0006325	USR0095	VST002780	RT00233	2	t
LOG0006326	USR0219	VST000244	RT00816	3	f
LOG0006327	USR0170	VST004038	RT00066	2	t
LOG0006328	USR0366	VST001501	RT00974	2	t
LOG0006329	USR0432	VST002710	RT00004	2	f
LOG0006330	USR0283	VST003054	RT00003	4	f
LOG0006331	USR0128	VST004463	RT00259	4	f
LOG0006332	USR0200	VST003227	RT00715	1	f
LOG0006333	USR0417	VST001048	RT00325	2	f
LOG0006334	USR0332	VST004379	RT00240	2	t
LOG0006335	USR0035	VST001316	RT00605	4	f
LOG0006336	USR0354	VST001387	RT00796	2	f
LOG0006337	USR0144	VST003921	RT00535	4	f
LOG0006338	USR0292	VST001738	RT00798	3	f
LOG0006339	USR0066	VST000422	RT00318	3	f
LOG0006340	USR0460	VST003802	RT00599	2	t
LOG0006341	USR0219	VST001412	RT00051	1	f
LOG0006342	USR0056	VST003250	RT00809	4	t
LOG0006343	USR0145	VST004571	RT00470	3	f
LOG0006344	USR0404	VST002453	RT00832	3	f
LOG0006345	USR0213	VST002084	RT00043	2	t
LOG0006346	USR0094	VST004454	RT00204	4	f
LOG0006347	USR0106	VST004654	RT00347	2	f
LOG0006348	USR0084	VST003679	RT00058	4	t
LOG0006349	USR0136	VST001351	RT00059	1	t
LOG0006350	USR0146	VST002368	RT00680	4	f
LOG0006351	USR0249	VST004834	RT00686	3	t
LOG0006352	USR0018	VST003341	RT00511	2	f
LOG0006353	USR0402	VST002573	RT00318	4	f
LOG0006354	USR0125	VST004121	RT00433	3	f
LOG0006355	USR0002	VST003845	RT00372	2	t
LOG0006356	USR0332	VST000640	RT00207	2	t
LOG0006357	USR0480	VST001575	RT00111	1	f
LOG0006358	USR0490	VST003229	RT00023	3	f
LOG0006359	USR0200	VST004270	RT00428	4	t
LOG0006360	USR0435	VST000186	RT00745	3	f
LOG0006361	USR0138	VST001319	RT00940	2	t
LOG0006362	USR0203	VST000528	RT00787	1	t
LOG0006363	USR0398	VST003260	RT00684	4	t
LOG0006364	USR0282	VST003484	RT00011	1	t
LOG0006365	USR0303	VST003020	RT00572	1	t
LOG0006366	USR0030	VST004780	RT00934	3	f
LOG0006367	USR0056	VST002234	RT00744	2	t
LOG0006368	USR0119	VST001568	RT00747	2	t
LOG0006369	USR0426	VST000575	RT00515	4	t
LOG0006370	USR0132	VST002035	RT00144	1	f
LOG0006371	USR0231	VST001325	RT00992	1	t
LOG0006372	USR0395	VST004405	RT00742	1	t
LOG0006373	USR0152	VST001213	RT00521	3	t
LOG0006374	USR0470	VST001435	RT00809	2	f
LOG0006375	USR0451	VST000538	RT00294	1	f
LOG0006376	USR0421	VST004954	RT00325	1	f
LOG0006377	USR0386	VST001575	RT00193	2	t
LOG0006378	USR0396	VST000193	RT00291	4	t
LOG0006379	USR0021	VST001187	RT00639	3	f
LOG0006380	USR0453	VST004149	RT00419	3	f
LOG0006381	USR0455	VST000475	RT00460	3	t
LOG0006382	USR0448	VST004270	RT00996	2	f
LOG0006383	USR0068	VST001814	RT00981	3	f
LOG0006384	USR0126	VST004796	RT00048	1	f
LOG0006385	USR0043	VST002438	RT00107	3	t
LOG0006386	USR0182	VST003380	RT00264	2	f
LOG0006387	USR0489	VST004553	RT00253	3	f
LOG0006388	USR0100	VST001355	RT00539	4	f
LOG0006389	USR0379	VST003401	RT00521	4	t
LOG0006390	USR0446	VST003755	RT00732	2	t
LOG0006391	USR0470	VST003530	RT00158	2	f
LOG0006392	USR0349	VST000159	RT00526	4	f
LOG0006393	USR0457	VST001838	RT00919	3	f
LOG0006394	USR0474	VST004612	RT00029	1	f
LOG0006395	USR0396	VST001026	RT00538	2	f
LOG0006396	USR0240	VST000659	RT00726	4	t
LOG0006397	USR0385	VST000678	RT00143	3	f
LOG0006398	USR0200	VST004411	RT00627	2	f
LOG0006399	USR0417	VST004047	RT00841	3	t
LOG0006400	USR0448	VST003822	RT00218	1	t
LOG0006401	USR0116	VST002376	RT00593	2	f
LOG0006402	USR0115	VST000276	RT00713	1	t
LOG0006403	USR0452	VST004548	RT00067	1	t
LOG0006404	USR0142	VST001589	RT00761	1	f
LOG0006405	USR0119	VST004582	RT00144	4	f
LOG0006406	USR0093	VST004663	RT00141	1	t
LOG0006407	USR0398	VST000246	RT00346	1	f
LOG0006408	USR0009	VST000889	RT00465	3	f
LOG0006409	USR0073	VST002212	RT00096	4	t
LOG0006410	USR0026	VST004026	RT00408	4	f
LOG0006411	USR0433	VST000001	RT00118	4	t
LOG0006412	USR0239	VST002911	RT00830	4	t
LOG0006413	USR0362	VST002185	RT00697	1	t
LOG0006414	USR0145	VST004247	RT00804	3	t
LOG0006415	USR0489	VST003252	RT00444	1	t
LOG0006416	USR0068	VST003052	RT00757	1	f
LOG0006417	USR0188	VST001511	RT00982	4	t
LOG0006418	USR0366	VST003772	RT00380	4	f
LOG0006419	USR0131	VST001129	RT00713	2	f
LOG0006420	USR0221	VST000698	RT00278	3	t
LOG0006421	USR0281	VST001089	RT00361	4	f
LOG0006422	USR0277	VST002420	RT00370	4	t
LOG0006423	USR0140	VST002629	RT00622	1	t
LOG0006424	USR0054	VST003790	RT00212	1	f
LOG0006425	USR0001	VST000686	RT00259	1	t
LOG0006426	USR0128	VST002757	RT00676	4	f
LOG0006427	USR0001	VST001843	RT00097	3	f
LOG0006428	USR0173	VST001733	RT00210	4	f
LOG0006429	USR0430	VST004836	RT00548	4	t
LOG0006430	USR0432	VST004367	RT00778	3	f
LOG0006431	USR0391	VST001973	RT00612	4	t
LOG0006432	USR0266	VST000711	RT00021	4	f
LOG0006433	USR0399	VST000325	RT00729	3	f
LOG0006434	USR0296	VST004894	RT00433	4	t
LOG0006435	USR0256	VST002968	RT00616	2	f
LOG0006436	USR0395	VST003800	RT00371	2	f
LOG0006437	USR0440	VST002595	RT00393	1	f
LOG0006438	USR0174	VST001093	RT00624	4	t
LOG0006439	USR0045	VST002956	RT00219	3	t
LOG0006440	USR0343	VST000212	RT00504	3	f
LOG0006441	USR0141	VST001582	RT00632	2	f
LOG0006442	USR0027	VST003832	RT00761	1	t
LOG0006443	USR0233	VST001444	RT00847	4	t
LOG0006444	USR0209	VST004144	RT00948	3	t
LOG0006445	USR0050	VST004327	RT00096	3	f
LOG0006446	USR0061	VST000579	RT00432	4	f
LOG0006447	USR0243	VST002998	RT00188	1	t
LOG0006448	USR0269	VST001755	RT00501	2	t
LOG0006449	USR0140	VST002980	RT00876	4	f
LOG0006450	USR0157	VST003606	RT00375	4	f
LOG0006451	USR0085	VST000422	RT00434	4	t
LOG0006452	USR0084	VST000611	RT00423	2	t
LOG0006453	USR0276	VST000446	RT00144	3	f
LOG0006454	USR0031	VST000961	RT00540	4	t
LOG0006455	USR0008	VST000131	RT00499	4	f
LOG0006456	USR0280	VST002648	RT00006	4	f
LOG0006457	USR0203	VST004080	RT00317	4	f
LOG0006458	USR0423	VST002435	RT00774	1	t
LOG0006459	USR0033	VST003730	RT00230	1	f
LOG0006460	USR0298	VST004432	RT00122	1	t
LOG0006461	USR0143	VST001025	RT00495	3	t
LOG0006462	USR0452	VST001653	RT00706	4	f
LOG0006463	USR0449	VST000538	RT00617	4	t
LOG0006464	USR0416	VST004592	RT00936	4	f
LOG0006465	USR0395	VST003084	RT00711	4	t
LOG0006466	USR0350	VST000508	RT00475	2	f
LOG0006467	USR0037	VST003925	RT00574	2	f
LOG0006468	USR0147	VST000681	RT00796	2	f
LOG0006469	USR0435	VST002613	RT00508	4	f
LOG0006470	USR0228	VST004877	RT00592	2	f
LOG0006471	USR0034	VST000760	RT00175	2	t
LOG0006472	USR0455	VST004224	RT00521	3	t
LOG0006473	USR0444	VST003148	RT00692	3	f
LOG0006474	USR0237	VST002194	RT00271	2	t
LOG0006475	USR0212	VST002547	RT00674	2	t
LOG0006476	USR0309	VST004656	RT00788	3	f
LOG0006477	USR0140	VST001223	RT00718	2	f
LOG0006478	USR0190	VST003575	RT00572	4	f
LOG0006479	USR0096	VST003024	RT00186	2	f
LOG0006480	USR0194	VST003281	RT00587	4	f
LOG0006481	USR0470	VST001072	RT00094	2	t
LOG0006482	USR0361	VST000541	RT00579	1	t
LOG0006483	USR0304	VST000511	RT00514	2	t
LOG0006484	USR0296	VST004451	RT00178	1	f
LOG0006485	USR0152	VST000345	RT00654	2	t
LOG0006486	USR0434	VST004243	RT00952	2	f
LOG0006487	USR0223	VST003370	RT00989	4	f
LOG0006488	USR0196	VST003823	RT00965	3	f
LOG0006489	USR0088	VST002380	RT00556	3	f
LOG0006490	USR0299	VST002481	RT00686	4	t
LOG0006491	USR0017	VST000399	RT00902	3	f
LOG0006492	USR0488	VST003407	RT00904	1	t
LOG0006493	USR0211	VST003281	RT00295	1	f
LOG0006494	USR0232	VST004683	RT00231	2	t
LOG0006495	USR0358	VST003767	RT00236	1	t
LOG0006496	USR0183	VST001295	RT00093	3	f
LOG0006497	USR0162	VST003252	RT00487	1	t
LOG0006498	USR0367	VST003510	RT00044	2	t
LOG0006499	USR0481	VST002036	RT00539	1	f
LOG0006500	USR0070	VST004834	RT00784	3	t
LOG0006501	USR0060	VST003850	RT00475	4	t
LOG0006502	USR0179	VST001778	RT00039	2	t
LOG0006503	USR0484	VST000380	RT01000	4	f
LOG0006504	USR0077	VST003764	RT00385	1	f
LOG0006505	USR0495	VST001662	RT00435	2	t
LOG0006506	USR0457	VST003059	RT00959	2	t
LOG0006507	USR0035	VST001307	RT00289	1	t
LOG0006508	USR0418	VST002466	RT00248	2	t
LOG0006509	USR0016	VST004452	RT00562	1	f
LOG0006510	USR0466	VST000016	RT00359	4	t
LOG0006511	USR0402	VST004411	RT00438	4	t
LOG0006512	USR0294	VST002581	RT00795	3	t
LOG0006513	USR0498	VST002593	RT00209	3	f
LOG0006514	USR0171	VST004790	RT00124	1	t
LOG0006515	USR0032	VST000069	RT00975	1	t
LOG0006516	USR0263	VST000411	RT00854	4	f
LOG0006517	USR0215	VST003124	RT00761	2	t
LOG0006518	USR0471	VST002860	RT00403	1	t
LOG0006519	USR0046	VST000919	RT00284	2	t
LOG0006520	USR0189	VST004836	RT00663	3	f
LOG0006521	USR0274	VST001491	RT00576	4	f
LOG0006522	USR0071	VST003806	RT00996	1	t
LOG0006523	USR0490	VST003344	RT00241	3	t
LOG0006524	USR0296	VST002487	RT00167	1	f
LOG0006525	USR0088	VST002578	RT00752	3	f
LOG0006526	USR0334	VST000273	RT00561	4	t
LOG0006527	USR0434	VST004555	RT00699	1	t
LOG0006528	USR0261	VST000820	RT00148	1	t
LOG0006529	USR0494	VST002616	RT00701	2	f
LOG0006530	USR0182	VST004957	RT00623	2	f
LOG0006531	USR0342	VST002545	RT00896	1	f
LOG0006532	USR0442	VST003985	RT00265	4	f
LOG0006533	USR0022	VST004891	RT00501	2	f
LOG0006534	USR0074	VST004901	RT00279	1	t
LOG0006535	USR0090	VST002982	RT00749	1	t
LOG0006536	USR0335	VST001891	RT00903	3	t
LOG0006537	USR0166	VST003040	RT00159	4	f
LOG0006538	USR0489	VST004936	RT00060	2	t
LOG0006539	USR0234	VST002683	RT00499	2	f
LOG0006540	USR0375	VST000603	RT00317	3	f
LOG0006541	USR0433	VST003938	RT00587	1	t
LOG0006542	USR0129	VST001433	RT00488	2	t
LOG0006543	USR0334	VST004463	RT00465	1	t
LOG0006544	USR0292	VST000256	RT00228	2	t
LOG0006545	USR0095	VST002488	RT00666	2	t
LOG0006546	USR0028	VST001359	RT00356	1	f
LOG0006547	USR0354	VST003702	RT00466	1	f
LOG0006548	USR0035	VST002483	RT00822	2	f
LOG0006549	USR0444	VST000690	RT00799	3	t
LOG0006550	USR0231	VST003533	RT00753	3	t
LOG0006551	USR0318	VST000308	RT00227	3	t
LOG0006552	USR0343	VST001697	RT00169	3	t
LOG0006553	USR0430	VST003167	RT00284	3	f
LOG0006554	USR0364	VST000409	RT00858	1	t
LOG0006555	USR0467	VST003952	RT00262	2	t
LOG0006556	USR0125	VST000826	RT00802	3	t
LOG0006557	USR0466	VST001192	RT00860	4	t
LOG0006558	USR0079	VST002135	RT00364	2	t
LOG0006559	USR0381	VST003095	RT00521	4	f
LOG0006560	USR0061	VST004194	RT00861	1	t
LOG0006561	USR0449	VST001775	RT00098	2	t
LOG0006562	USR0217	VST004417	RT00012	1	t
LOG0006563	USR0282	VST000534	RT00784	4	f
LOG0006564	USR0163	VST002868	RT00583	2	t
LOG0006565	USR0057	VST001208	RT00927	2	f
LOG0006566	USR0463	VST000417	RT00417	1	f
LOG0006567	USR0191	VST002777	RT00501	2	t
LOG0006568	USR0132	VST001238	RT00135	4	t
LOG0006569	USR0463	VST004944	RT00259	1	t
LOG0006570	USR0042	VST004766	RT00916	4	t
LOG0006571	USR0486	VST001944	RT00517	2	f
LOG0006572	USR0173	VST002181	RT00963	4	f
LOG0006573	USR0167	VST002101	RT00751	2	f
LOG0006574	USR0250	VST004837	RT00294	4	f
LOG0006575	USR0193	VST004119	RT00847	4	t
LOG0006576	USR0278	VST003675	RT00611	3	t
LOG0006577	USR0395	VST000460	RT00440	2	f
LOG0006578	USR0238	VST000650	RT00151	3	f
LOG0006579	USR0230	VST004578	RT00481	3	f
LOG0006580	USR0165	VST000120	RT00258	1	f
LOG0006581	USR0243	VST004769	RT00868	1	t
LOG0006582	USR0090	VST002256	RT00149	4	f
LOG0006583	USR0179	VST000318	RT00974	2	f
LOG0006584	USR0475	VST000868	RT00142	1	f
LOG0006585	USR0058	VST003227	RT00251	3	f
LOG0006586	USR0461	VST000394	RT00958	2	t
LOG0006587	USR0263	VST002553	RT00746	4	f
LOG0006588	USR0136	VST004409	RT00907	4	f
LOG0006589	USR0238	VST003229	RT00644	1	f
LOG0006590	USR0307	VST002062	RT00047	1	f
LOG0006591	USR0243	VST000077	RT00372	1	f
LOG0006592	USR0151	VST003411	RT00094	4	t
LOG0006593	USR0346	VST000409	RT00761	3	f
LOG0006594	USR0364	VST004093	RT00356	1	f
LOG0006595	USR0247	VST002268	RT00532	4	f
LOG0006596	USR0219	VST000744	RT00692	2	f
LOG0006597	USR0009	VST004529	RT00272	4	t
LOG0006598	USR0430	VST002854	RT00994	2	t
LOG0006599	USR0294	VST003835	RT00429	2	t
LOG0006600	USR0367	VST003998	RT00648	3	f
LOG0006601	USR0013	VST001832	RT00749	1	t
LOG0006602	USR0263	VST000988	RT00702	2	f
LOG0006603	USR0395	VST002702	RT00724	1	t
LOG0006604	USR0458	VST003713	RT00917	4	t
LOG0006605	USR0225	VST003908	RT00064	1	t
LOG0006606	USR0231	VST002865	RT00872	4	t
LOG0006607	USR0178	VST000755	RT00926	2	f
LOG0006608	USR0247	VST000676	RT00164	3	t
LOG0006609	USR0067	VST004928	RT00389	2	t
LOG0006610	USR0297	VST004124	RT00469	4	f
LOG0006611	USR0157	VST004512	RT00550	2	t
LOG0006612	USR0165	VST001711	RT00727	3	t
LOG0006613	USR0184	VST003476	RT00531	1	t
LOG0006614	USR0493	VST000542	RT00766	4	f
LOG0006615	USR0208	VST000165	RT00586	1	f
LOG0006616	USR0016	VST002256	RT00923	3	t
LOG0006617	USR0300	VST000985	RT00995	2	t
LOG0006618	USR0306	VST002662	RT00653	3	f
LOG0006619	USR0491	VST004469	RT00905	4	f
LOG0006620	USR0241	VST000618	RT00017	4	t
LOG0006621	USR0455	VST003914	RT00607	2	f
LOG0006622	USR0463	VST000069	RT00746	4	t
LOG0006623	USR0230	VST003425	RT00940	3	f
LOG0006624	USR0390	VST004197	RT00301	4	f
LOG0006625	USR0018	VST000001	RT00088	1	t
LOG0006626	USR0147	VST002399	RT00810	3	t
LOG0006627	USR0244	VST002055	RT00563	3	t
LOG0006628	USR0051	VST004414	RT00245	4	f
LOG0006629	USR0450	VST000186	RT00467	2	t
LOG0006630	USR0259	VST004824	RT00442	2	t
LOG0006631	USR0238	VST002510	RT00113	2	f
LOG0006632	USR0246	VST004439	RT00442	4	f
LOG0006633	USR0345	VST004809	RT00926	4	t
LOG0006634	USR0484	VST003080	RT00901	4	f
LOG0006635	USR0310	VST000136	RT00008	3	t
LOG0006636	USR0049	VST000383	RT00549	3	f
LOG0006637	USR0284	VST004282	RT00559	4	f
LOG0006638	USR0038	VST002687	RT00100	2	f
LOG0006639	USR0284	VST000928	RT00345	1	f
LOG0006640	USR0032	VST003444	RT00685	2	t
LOG0006641	USR0243	VST000561	RT00753	3	f
LOG0006642	USR0041	VST001190	RT00901	3	t
LOG0006643	USR0292	VST000898	RT00481	2	f
LOG0006644	USR0103	VST002369	RT00703	2	t
LOG0006645	USR0292	VST001739	RT00342	3	t
LOG0006646	USR0107	VST004954	RT00943	3	f
LOG0006647	USR0246	VST003046	RT00234	4	t
LOG0006648	USR0382	VST004381	RT00793	1	t
LOG0006649	USR0087	VST003873	RT00235	4	t
LOG0006650	USR0066	VST002399	RT00126	4	t
LOG0006651	USR0138	VST004762	RT00690	2	t
LOG0006652	USR0326	VST001394	RT00477	2	t
LOG0006653	USR0200	VST002589	RT00685	1	f
LOG0006654	USR0335	VST003467	RT00372	4	t
LOG0006655	USR0493	VST002025	RT00120	4	t
LOG0006656	USR0093	VST003686	RT00542	3	t
LOG0006657	USR0447	VST000930	RT00560	3	f
LOG0006658	USR0348	VST004310	RT00179	1	f
LOG0006659	USR0278	VST004400	RT00094	2	f
LOG0006660	USR0482	VST003227	RT00567	3	t
LOG0006661	USR0020	VST001404	RT00748	1	f
LOG0006662	USR0289	VST000200	RT00951	4	f
LOG0006663	USR0399	VST003752	RT00302	1	f
LOG0006664	USR0391	VST002286	RT00799	1	t
LOG0006665	USR0472	VST000671	RT00418	3	f
LOG0006666	USR0090	VST001729	RT00860	3	f
LOG0006667	USR0050	VST003239	RT00586	4	t
LOG0006668	USR0010	VST001250	RT00452	4	t
LOG0006669	USR0079	VST000879	RT00417	4	f
LOG0006670	USR0037	VST004347	RT00824	1	t
LOG0006671	USR0059	VST003352	RT00954	1	f
LOG0006672	USR0088	VST002524	RT00122	3	t
LOG0006673	USR0459	VST000498	RT00057	4	f
LOG0006674	USR0104	VST001988	RT00785	3	t
LOG0006675	USR0319	VST000978	RT00139	4	t
LOG0006676	USR0277	VST003045	RT00199	4	t
LOG0006677	USR0104	VST002749	RT00721	3	f
LOG0006678	USR0254	VST004880	RT00988	3	f
LOG0006679	USR0230	VST002477	RT00785	3	f
LOG0006680	USR0335	VST000539	RT00361	4	t
LOG0006681	USR0463	VST004041	RT00650	1	t
LOG0006682	USR0037	VST000901	RT00410	3	f
LOG0006683	USR0301	VST001467	RT00646	3	t
LOG0006684	USR0142	VST003016	RT00849	1	f
LOG0006685	USR0043	VST004306	RT00528	1	f
LOG0006686	USR0116	VST001734	RT00615	2	f
LOG0006687	USR0341	VST000491	RT00243	3	t
LOG0006688	USR0492	VST001710	RT00090	2	f
LOG0006689	USR0084	VST001754	RT00516	2	f
LOG0006690	USR0417	VST001919	RT00062	1	f
LOG0006691	USR0259	VST002035	RT00212	4	f
LOG0006692	USR0360	VST002712	RT00248	4	f
LOG0006693	USR0087	VST001487	RT00704	1	t
LOG0006694	USR0428	VST001501	RT00497	2	t
LOG0006695	USR0367	VST000198	RT00056	2	f
LOG0006696	USR0343	VST001968	RT00459	2	f
LOG0006697	USR0347	VST004617	RT00919	2	f
LOG0006698	USR0291	VST001535	RT00289	3	f
LOG0006699	USR0409	VST001714	RT00543	2	t
LOG0006700	USR0096	VST001349	RT00903	1	t
LOG0006701	USR0255	VST004784	RT00470	2	f
LOG0006702	USR0342	VST004563	RT00389	2	t
LOG0006703	USR0136	VST003845	RT00421	1	t
LOG0006704	USR0248	VST000596	RT00513	2	f
LOG0006705	USR0499	VST000139	RT00710	4	f
LOG0006706	USR0372	VST001015	RT00557	1	f
LOG0006707	USR0446	VST000242	RT00559	3	f
LOG0006708	USR0486	VST002364	RT00964	3	f
LOG0006709	USR0402	VST000733	RT00734	1	t
LOG0006710	USR0092	VST000135	RT00798	3	t
LOG0006711	USR0412	VST003260	RT00081	3	t
LOG0006712	USR0459	VST003762	RT00444	3	t
LOG0006713	USR0396	VST002627	RT00792	1	f
LOG0006714	USR0448	VST003141	RT00287	2	t
LOG0006715	USR0247	VST002487	RT00284	3	f
LOG0006716	USR0258	VST002125	RT00941	4	t
LOG0006717	USR0187	VST001511	RT00491	2	f
LOG0006718	USR0421	VST001819	RT00388	2	t
LOG0006719	USR0124	VST004854	RT00701	3	t
LOG0006720	USR0260	VST002797	RT00551	3	t
LOG0006721	USR0169	VST004513	RT00595	2	f
LOG0006722	USR0429	VST004303	RT00408	3	f
LOG0006723	USR0365	VST001644	RT00327	1	t
LOG0006724	USR0111	VST002769	RT00942	1	f
LOG0006725	USR0290	VST004407	RT00949	3	t
LOG0006726	USR0087	VST003365	RT00176	2	t
LOG0006727	USR0013	VST001400	RT00521	3	f
LOG0006728	USR0263	VST001551	RT00790	4	f
LOG0006729	USR0288	VST003412	RT00383	1	t
LOG0006730	USR0023	VST000083	RT00258	2	t
LOG0006731	USR0433	VST001480	RT00347	4	t
LOG0006732	USR0200	VST002921	RT00272	3	t
LOG0006733	USR0242	VST002284	RT00261	1	t
LOG0006734	USR0239	VST002441	RT00396	4	t
LOG0006735	USR0303	VST001783	RT00692	2	t
LOG0006736	USR0165	VST000605	RT00154	1	f
LOG0006737	USR0226	VST004334	RT00527	3	f
LOG0006738	USR0176	VST000731	RT00067	3	f
LOG0006739	USR0029	VST001361	RT00841	1	f
LOG0006740	USR0165	VST002079	RT00699	4	f
LOG0006741	USR0023	VST000978	RT00348	1	f
LOG0006742	USR0294	VST001638	RT00935	1	f
LOG0006743	USR0477	VST001982	RT00063	1	t
LOG0006744	USR0383	VST002951	RT00356	4	t
LOG0006745	USR0044	VST003301	RT00281	1	f
LOG0006746	USR0261	VST004005	RT00041	2	t
LOG0006747	USR0180	VST000583	RT00540	3	f
LOG0006748	USR0296	VST000460	RT00367	4	f
LOG0006749	USR0139	VST000136	RT00277	2	f
LOG0006750	USR0334	VST001977	RT00221	1	f
LOG0006751	USR0248	VST000978	RT00729	2	t
LOG0006752	USR0241	VST000284	RT00734	4	f
LOG0006753	USR0106	VST002898	RT00061	3	f
LOG0006754	USR0386	VST002399	RT00103	4	f
LOG0006755	USR0419	VST004113	RT00185	1	t
LOG0006756	USR0173	VST001239	RT00907	1	t
LOG0006757	USR0049	VST003467	RT00147	3	f
LOG0006758	USR0123	VST002462	RT00075	4	t
LOG0006759	USR0035	VST003167	RT00473	4	f
LOG0006760	USR0106	VST003705	RT00001	4	t
LOG0006761	USR0476	VST002054	RT00416	2	f
LOG0006762	USR0328	VST000780	RT00469	3	f
LOG0006763	USR0416	VST002135	RT00365	4	f
LOG0006764	USR0196	VST002237	RT00845	3	t
LOG0006765	USR0109	VST001640	RT00674	2	t
LOG0006766	USR0125	VST000420	RT00017	4	f
LOG0006767	USR0327	VST001827	RT00510	2	t
LOG0006768	USR0295	VST003139	RT00755	1	t
LOG0006769	USR0432	VST003690	RT00439	1	f
LOG0006770	USR0347	VST004956	RT00879	1	f
LOG0006771	USR0037	VST000207	RT00531	3	t
LOG0006772	USR0188	VST003391	RT00842	4	f
LOG0006773	USR0337	VST003871	RT00938	4	t
LOG0006774	USR0458	VST003797	RT00059	2	f
LOG0006775	USR0388	VST002535	RT00713	2	f
LOG0006776	USR0023	VST002181	RT00115	1	f
LOG0006777	USR0398	VST004211	RT00203	3	f
LOG0006778	USR0261	VST004307	RT00806	3	f
LOG0006779	USR0194	VST004228	RT00543	2	f
LOG0006780	USR0366	VST001398	RT00194	2	f
LOG0006781	USR0152	VST004250	RT00472	4	f
LOG0006782	USR0018	VST001447	RT00106	4	t
LOG0006783	USR0027	VST000952	RT00879	2	t
LOG0006784	USR0024	VST004022	RT00965	4	t
LOG0006785	USR0029	VST001718	RT00818	2	t
LOG0006786	USR0139	VST004243	RT00126	3	t
LOG0006787	USR0496	VST003806	RT00414	1	t
LOG0006788	USR0146	VST003199	RT00615	2	t
LOG0006789	USR0123	VST004811	RT00675	2	t
LOG0006790	USR0128	VST001597	RT00510	4	t
LOG0006791	USR0368	VST003734	RT00501	2	f
LOG0006792	USR0117	VST003217	RT00827	3	t
LOG0006793	USR0132	VST000907	RT00121	1	t
LOG0006794	USR0289	VST003751	RT00752	4	f
LOG0006795	USR0206	VST004059	RT00913	3	t
LOG0006796	USR0236	VST002155	RT00607	1	f
LOG0006797	USR0042	VST004925	RT00962	4	f
LOG0006798	USR0160	VST001338	RT00208	3	t
LOG0006799	USR0252	VST004107	RT00661	2	t
LOG0006800	USR0179	VST002496	RT00350	4	f
LOG0006801	USR0125	VST002975	RT00820	2	t
LOG0006802	USR0260	VST002443	RT00193	4	t
LOG0006803	USR0276	VST004474	RT00654	1	t
LOG0006804	USR0213	VST000361	RT00784	4	t
LOG0006805	USR0451	VST003065	RT00823	4	f
LOG0006806	USR0473	VST004738	RT00393	3	f
LOG0006807	USR0324	VST000573	RT00497	4	t
LOG0006808	USR0190	VST001956	RT00392	1	t
LOG0006809	USR0058	VST003045	RT00713	3	t
LOG0006810	USR0431	VST001585	RT00674	2	f
LOG0006811	USR0203	VST002234	RT00109	4	t
LOG0006812	USR0080	VST003293	RT00929	1	t
LOG0006813	USR0443	VST003247	RT00470	1	f
LOG0006814	USR0228	VST001815	RT00350	4	f
LOG0006815	USR0390	VST004042	RT00775	4	t
LOG0006816	USR0095	VST001890	RT00722	2	f
LOG0006817	USR0424	VST001900	RT00149	2	t
LOG0006818	USR0461	VST002656	RT00256	2	f
LOG0006819	USR0407	VST002330	RT00389	2	f
LOG0006820	USR0436	VST003719	RT00199	2	f
LOG0006821	USR0004	VST001057	RT00908	2	f
LOG0006822	USR0165	VST002130	RT00443	3	f
LOG0006823	USR0426	VST001507	RT00849	3	f
LOG0006824	USR0485	VST001631	RT00186	1	t
LOG0006825	USR0300	VST000992	RT00344	3	t
LOG0006826	USR0481	VST004591	RT00677	4	f
LOG0006827	USR0381	VST001194	RT00108	4	f
LOG0006828	USR0042	VST003969	RT00595	4	t
LOG0006829	USR0285	VST000703	RT00813	1	t
LOG0006830	USR0229	VST001031	RT00080	3	f
LOG0006831	USR0403	VST004922	RT00253	4	f
LOG0006832	USR0243	VST002482	RT00025	3	t
LOG0006833	USR0212	VST000563	RT00283	4	f
LOG0006834	USR0416	VST000367	RT00563	2	t
LOG0006835	USR0300	VST000794	RT00887	3	f
LOG0006836	USR0055	VST003104	RT00938	3	f
LOG0006837	USR0336	VST004732	RT00620	4	f
LOG0006838	USR0389	VST000987	RT00967	3	f
LOG0006839	USR0369	VST000958	RT00238	2	t
LOG0006840	USR0430	VST003596	RT00938	4	t
LOG0006841	USR0460	VST000855	RT00316	2	t
LOG0006842	USR0173	VST001570	RT00840	4	t
LOG0006843	USR0277	VST002257	RT00463	3	t
LOG0006844	USR0334	VST003910	RT00698	4	t
LOG0006845	USR0229	VST004104	RT00592	1	f
LOG0006846	USR0406	VST004833	RT00840	4	f
LOG0006847	USR0030	VST002223	RT00996	3	t
LOG0006848	USR0023	VST004177	RT00608	2	f
LOG0006849	USR0005	VST000238	RT00382	2	t
LOG0006850	USR0063	VST003289	RT00465	1	t
LOG0006851	USR0221	VST004283	RT00996	4	f
LOG0006852	USR0315	VST004726	RT00150	4	t
LOG0006853	USR0478	VST001733	RT00352	2	f
LOG0006854	USR0082	VST003062	RT00442	2	t
LOG0006855	USR0494	VST000815	RT00395	3	t
LOG0006856	USR0242	VST004710	RT00365	1	t
LOG0006857	USR0253	VST001187	RT00006	2	f
LOG0006858	USR0052	VST002226	RT00534	4	f
LOG0006859	USR0321	VST000985	RT00974	2	f
LOG0006860	USR0039	VST000798	RT00220	3	f
LOG0006861	USR0465	VST004163	RT00871	4	t
LOG0006862	USR0259	VST000544	RT00012	3	f
LOG0006863	USR0426	VST000520	RT00795	3	f
LOG0006864	USR0327	VST002547	RT00385	3	f
LOG0006865	USR0411	VST001455	RT00704	1	f
LOG0006866	USR0412	VST001059	RT00458	4	t
LOG0006867	USR0492	VST002237	RT00225	4	f
LOG0006868	USR0438	VST001113	RT00336	3	t
LOG0006869	USR0479	VST003407	RT00167	1	f
LOG0006870	USR0271	VST000947	RT00316	2	f
LOG0006871	USR0437	VST004031	RT00116	4	f
LOG0006872	USR0496	VST000136	RT00838	2	f
LOG0006873	USR0072	VST002594	RT00950	4	f
LOG0006874	USR0070	VST000793	RT00921	3	f
LOG0006875	USR0220	VST001137	RT00498	4	f
LOG0006876	USR0004	VST001363	RT00148	3	f
LOG0006877	USR0350	VST000555	RT00036	4	f
LOG0006878	USR0491	VST002573	RT00407	3	t
LOG0006879	USR0401	VST003404	RT00976	2	f
LOG0006880	USR0290	VST002255	RT00385	2	f
LOG0006881	USR0380	VST001367	RT00757	2	f
LOG0006882	USR0390	VST000949	RT00990	4	t
LOG0006883	USR0292	VST000104	RT00411	1	t
LOG0006884	USR0355	VST001047	RT00308	2	f
LOG0006885	USR0231	VST004027	RT00642	4	f
LOG0006886	USR0423	VST002615	RT00240	3	t
LOG0006887	USR0080	VST003332	RT00917	1	t
LOG0006888	USR0066	VST000964	RT00905	1	f
LOG0006889	USR0136	VST003272	RT00367	1	t
LOG0006890	USR0399	VST000838	RT00856	2	f
LOG0006891	USR0191	VST002459	RT00304	2	t
LOG0006892	USR0347	VST000882	RT00617	2	f
LOG0006893	USR0336	VST003189	RT00167	2	f
LOG0006894	USR0449	VST004520	RT00554	3	f
LOG0006895	USR0059	VST002203	RT00967	4	f
LOG0006896	USR0266	VST003335	RT00766	1	f
LOG0006897	USR0007	VST002199	RT00862	4	t
LOG0006898	USR0368	VST000212	RT00301	1	f
LOG0006899	USR0202	VST001216	RT00898	1	t
LOG0006900	USR0332	VST000881	RT00972	1	t
LOG0006901	USR0465	VST000755	RT00205	1	t
LOG0006902	USR0237	VST000701	RT00195	3	t
LOG0006903	USR0268	VST002220	RT00171	3	f
LOG0006904	USR0079	VST000371	RT00762	1	t
LOG0006905	USR0046	VST001733	RT00616	1	t
LOG0006906	USR0243	VST000802	RT00875	2	t
LOG0006907	USR0288	VST000990	RT00402	1	f
LOG0006908	USR0160	VST004772	RT00039	4	f
LOG0006909	USR0115	VST000416	RT00748	3	t
LOG0006910	USR0474	VST002966	RT00646	4	t
LOG0006911	USR0462	VST003338	RT00252	2	f
LOG0006912	USR0114	VST003613	RT00682	3	t
LOG0006913	USR0126	VST001621	RT00948	2	f
LOG0006914	USR0090	VST001536	RT00283	2	t
LOG0006915	USR0061	VST004345	RT00207	4	t
LOG0006916	USR0453	VST002793	RT00500	1	f
LOG0006917	USR0500	VST000573	RT00143	3	f
LOG0006918	USR0317	VST004894	RT00019	3	t
LOG0006919	USR0102	VST004857	RT00702	1	f
LOG0006920	USR0114	VST003656	RT00576	4	t
LOG0006921	USR0174	VST000293	RT00742	2	f
LOG0006922	USR0452	VST004294	RT00819	4	f
LOG0006923	USR0092	VST000080	RT00687	2	f
LOG0006924	USR0183	VST004233	RT00825	3	t
LOG0006925	USR0385	VST004309	RT00020	1	t
LOG0006926	USR0205	VST001863	RT00788	1	t
LOG0006927	USR0363	VST000619	RT00850	3	f
LOG0006928	USR0195	VST000960	RT00448	2	t
LOG0006929	USR0305	VST003279	RT00226	4	f
LOG0006930	USR0498	VST003736	RT00743	2	f
LOG0006931	USR0025	VST002214	RT00101	1	f
LOG0006932	USR0234	VST003575	RT00739	4	f
LOG0006933	USR0016	VST003997	RT00294	4	t
LOG0006934	USR0469	VST002478	RT00550	2	t
LOG0006935	USR0141	VST003252	RT00065	2	t
LOG0006936	USR0436	VST002169	RT00499	2	f
LOG0006937	USR0108	VST003246	RT00076	4	t
LOG0006938	USR0420	VST002379	RT00901	3	f
LOG0006939	USR0456	VST001723	RT00704	4	t
LOG0006940	USR0300	VST001162	RT00635	1	t
LOG0006941	USR0339	VST001890	RT00125	3	t
LOG0006942	USR0303	VST002041	RT00027	3	t
LOG0006943	USR0380	VST003972	RT00615	2	t
LOG0006944	USR0080	VST003402	RT00276	4	t
LOG0006945	USR0076	VST003310	RT00572	1	f
LOG0006946	USR0276	VST001100	RT00680	4	f
LOG0006947	USR0402	VST004019	RT00083	2	f
LOG0006948	USR0438	VST001689	RT00486	4	t
LOG0006949	USR0268	VST004133	RT00463	1	f
LOG0006950	USR0112	VST000845	RT00006	2	t
LOG0006951	USR0409	VST001644	RT00969	4	f
LOG0006952	USR0316	VST002334	RT00676	1	t
LOG0006953	USR0500	VST001264	RT00368	1	t
LOG0006954	USR0075	VST002935	RT00471	2	f
LOG0006955	USR0214	VST003686	RT00714	2	t
LOG0006956	USR0500	VST000216	RT00449	3	t
LOG0006957	USR0366	VST004777	RT00907	3	f
LOG0006958	USR0034	VST003658	RT00689	1	f
LOG0006959	USR0141	VST002341	RT00370	2	f
LOG0006960	USR0494	VST001508	RT00340	2	f
LOG0006961	USR0166	VST002091	RT00668	4	f
LOG0006962	USR0396	VST003379	RT00278	4	t
LOG0006963	USR0231	VST001117	RT00340	4	t
LOG0006964	USR0292	VST002741	RT00815	4	f
LOG0006965	USR0028	VST002162	RT00614	3	t
LOG0006966	USR0475	VST003257	RT00080	4	f
LOG0006967	USR0295	VST002969	RT00706	2	t
LOG0006968	USR0333	VST001149	RT00793	1	t
LOG0006969	USR0427	VST003177	RT00603	1	t
LOG0006970	USR0360	VST004254	RT00067	1	f
LOG0006971	USR0091	VST003346	RT00215	3	t
LOG0006972	USR0115	VST003962	RT00416	1	f
LOG0006973	USR0159	VST001141	RT00145	3	f
LOG0006974	USR0258	VST002934	RT00552	3	f
LOG0006975	USR0373	VST002108	RT00724	1	t
LOG0006976	USR0338	VST002449	RT00286	3	t
LOG0006977	USR0090	VST000828	RT00571	4	t
LOG0006978	USR0245	VST001204	RT00540	4	f
LOG0006979	USR0298	VST003304	RT00047	4	f
LOG0006980	USR0031	VST000845	RT00237	3	f
LOG0006981	USR0317	VST002972	RT00117	4	f
LOG0006982	USR0358	VST001269	RT00151	1	f
LOG0006983	USR0312	VST004734	RT00083	1	f
LOG0006984	USR0470	VST004745	RT00057	3	t
LOG0006985	USR0228	VST001630	RT00729	3	f
LOG0006986	USR0339	VST003531	RT00984	4	t
LOG0006987	USR0128	VST000804	RT00385	2	f
LOG0006988	USR0270	VST000128	RT00220	1	f
LOG0006989	USR0270	VST000952	RT00285	2	t
LOG0006990	USR0498	VST002265	RT00754	4	t
LOG0006991	USR0413	VST000020	RT00434	3	t
LOG0006992	USR0209	VST003639	RT00320	4	t
LOG0006993	USR0178	VST001782	RT00611	2	t
LOG0006994	USR0306	VST003835	RT00242	4	t
LOG0006995	USR0191	VST003132	RT00465	3	t
LOG0006996	USR0357	VST004771	RT00203	2	f
LOG0006997	USR0457	VST004835	RT00549	4	f
LOG0006998	USR0449	VST000557	RT00758	3	f
LOG0006999	USR0068	VST002245	RT00445	4	f
LOG0007000	USR0327	VST002984	RT00640	4	t
LOG0007001	USR0267	VST003564	RT00135	3	t
LOG0007002	USR0270	VST002726	RT00858	3	f
LOG0007003	USR0362	VST004600	RT00855	4	t
LOG0007004	USR0467	VST004834	RT00576	1	f
LOG0007005	USR0360	VST004888	RT00786	4	t
LOG0007006	USR0387	VST003332	RT00541	3	f
LOG0007007	USR0128	VST000197	RT00487	1	f
LOG0007008	USR0264	VST002829	RT00882	3	f
LOG0007009	USR0221	VST004840	RT00738	4	t
LOG0007010	USR0242	VST003989	RT00572	2	f
LOG0007011	USR0485	VST002470	RT00486	3	f
LOG0007012	USR0244	VST001631	RT00566	3	f
LOG0007013	USR0427	VST003279	RT00840	2	t
LOG0007014	USR0393	VST002039	RT00661	3	f
LOG0007015	USR0019	VST002480	RT00405	3	t
LOG0007016	USR0396	VST004331	RT00570	3	t
LOG0007017	USR0155	VST004575	RT00433	2	f
LOG0007018	USR0229	VST002476	RT00548	4	t
LOG0007019	USR0368	VST004762	RT00657	3	t
LOG0007020	USR0058	VST003310	RT00250	1	t
LOG0007021	USR0281	VST003179	RT00080	4	t
LOG0007022	USR0045	VST001388	RT00949	4	f
LOG0007023	USR0102	VST000642	RT00015	1	t
LOG0007024	USR0048	VST000575	RT00975	1	f
LOG0007025	USR0050	VST003145	RT00040	1	t
LOG0007026	USR0081	VST001722	RT00081	2	t
LOG0007027	USR0300	VST001019	RT00510	3	f
LOG0007028	USR0059	VST004059	RT00307	4	t
LOG0007029	USR0161	VST003421	RT00705	1	t
LOG0007030	USR0103	VST000400	RT00397	3	f
LOG0007031	USR0334	VST004691	RT00678	3	t
LOG0007032	USR0412	VST001457	RT00970	2	f
LOG0007033	USR0274	VST001596	RT00865	4	f
LOG0007034	USR0183	VST000117	RT00922	3	t
LOG0007035	USR0417	VST000383	RT00204	1	f
LOG0007036	USR0116	VST004955	RT00211	1	t
LOG0007037	USR0362	VST002130	RT00399	2	t
LOG0007038	USR0399	VST001851	RT00373	1	f
LOG0007039	USR0445	VST000832	RT00389	1	t
LOG0007040	USR0267	VST004969	RT00258	2	f
LOG0007041	USR0164	VST002701	RT00115	2	t
LOG0007042	USR0143	VST002782	RT00334	1	f
LOG0007043	USR0437	VST003482	RT00349	4	f
LOG0007044	USR0318	VST002118	RT00233	4	f
LOG0007045	USR0304	VST004483	RT00509	2	f
LOG0007046	USR0094	VST002007	RT00449	4	f
LOG0007047	USR0250	VST002572	RT00077	4	f
LOG0007048	USR0399	VST000297	RT00828	4	t
LOG0007049	USR0447	VST000719	RT00608	2	t
LOG0007050	USR0497	VST003137	RT00098	4	t
LOG0007051	USR0343	VST003080	RT00568	1	t
LOG0007052	USR0427	VST000011	RT00630	1	f
LOG0007053	USR0306	VST004881	RT00462	2	f
LOG0007054	USR0316	VST000411	RT00500	4	f
LOG0007055	USR0240	VST002940	RT00631	3	f
LOG0007056	USR0059	VST002655	RT00038	3	t
LOG0007057	USR0015	VST003187	RT00697	1	f
LOG0007058	USR0285	VST003451	RT00358	1	f
LOG0007059	USR0203	VST000599	RT00242	3	f
LOG0007060	USR0237	VST000824	RT00051	2	t
LOG0007061	USR0466	VST002398	RT00425	4	t
LOG0007062	USR0296	VST004115	RT00975	3	t
LOG0007063	USR0287	VST000313	RT00127	4	t
LOG0007064	USR0073	VST002975	RT00103	3	f
LOG0007065	USR0214	VST003739	RT00966	1	t
LOG0007066	USR0011	VST002493	RT00477	4	t
LOG0007067	USR0337	VST001946	RT00229	2	f
LOG0007068	USR0225	VST000231	RT00723	4	t
LOG0007069	USR0318	VST003741	RT00436	4	t
LOG0007070	USR0203	VST002673	RT00385	3	f
LOG0007071	USR0231	VST003455	RT00085	2	t
LOG0007072	USR0392	VST003584	RT00359	1	t
LOG0007073	USR0051	VST000044	RT00786	4	t
LOG0007074	USR0057	VST002925	RT00027	4	t
LOG0007075	USR0132	VST003694	RT00860	3	f
LOG0007076	USR0420	VST002271	RT00072	1	f
LOG0007077	USR0403	VST003458	RT00095	3	t
LOG0007078	USR0280	VST002950	RT00588	2	f
LOG0007079	USR0297	VST002319	RT00426	1	f
LOG0007080	USR0305	VST003386	RT00006	2	t
LOG0007081	USR0466	VST002295	RT00090	3	t
LOG0007082	USR0225	VST002996	RT00592	1	f
LOG0007083	USR0174	VST003639	RT00222	2	f
LOG0007084	USR0292	VST004917	RT00595	2	t
LOG0007085	USR0266	VST003368	RT00594	3	f
LOG0007086	USR0247	VST003285	RT00152	1	f
LOG0007087	USR0078	VST002343	RT00557	2	t
LOG0007088	USR0135	VST000171	RT00212	4	t
LOG0007089	USR0140	VST004342	RT00583	1	t
LOG0007090	USR0342	VST001640	RT00263	1	t
LOG0007091	USR0253	VST000617	RT00912	4	f
LOG0007092	USR0475	VST000240	RT00382	1	t
LOG0007093	USR0176	VST004494	RT00570	1	f
LOG0007094	USR0421	VST001857	RT00057	4	f
LOG0007095	USR0459	VST000923	RT00426	3	t
LOG0007096	USR0420	VST004888	RT00623	2	f
LOG0007097	USR0060	VST001905	RT00142	4	t
LOG0007098	USR0461	VST003150	RT00568	1	t
LOG0007099	USR0352	VST000813	RT00524	2	f
LOG0007100	USR0254	VST005000	RT00861	2	f
LOG0007101	USR0008	VST001731	RT00015	2	f
LOG0007102	USR0391	VST000832	RT00008	3	t
LOG0007103	USR0107	VST003425	RT00231	1	t
LOG0007104	USR0171	VST002208	RT00186	1	t
LOG0007105	USR0058	VST004840	RT00053	2	f
LOG0007106	USR0337	VST003433	RT00137	2	t
LOG0007107	USR0342	VST004909	RT00174	3	t
LOG0007108	USR0430	VST003369	RT00860	3	f
LOG0007109	USR0290	VST002228	RT00219	2	f
LOG0007110	USR0084	VST002261	RT00263	1	t
LOG0007111	USR0117	VST004626	RT00255	4	t
LOG0007112	USR0200	VST002918	RT00812	3	t
LOG0007113	USR0022	VST003521	RT00270	1	f
LOG0007114	USR0219	VST004381	RT00587	3	t
LOG0007115	USR0226	VST002709	RT00224	1	t
LOG0007116	USR0405	VST001821	RT00883	2	f
LOG0007117	USR0271	VST000649	RT00604	3	t
LOG0007118	USR0389	VST000189	RT00134	4	t
LOG0007119	USR0102	VST001223	RT00163	2	t
LOG0007120	USR0145	VST000479	RT00710	3	f
LOG0007121	USR0456	VST003063	RT00701	2	f
LOG0007122	USR0147	VST002026	RT00920	4	f
LOG0007123	USR0261	VST004613	RT00073	3	f
LOG0007124	USR0279	VST001889	RT00898	3	t
LOG0007125	USR0339	VST001551	RT00998	3	f
LOG0007126	USR0014	VST002917	RT00718	1	f
LOG0007127	USR0266	VST003256	RT00947	1	f
LOG0007128	USR0287	VST002807	RT00543	3	f
LOG0007129	USR0141	VST000034	RT00894	2	t
LOG0007130	USR0383	VST000296	RT00990	2	f
LOG0007131	USR0406	VST002501	RT00631	3	t
LOG0007132	USR0293	VST003780	RT00795	4	f
LOG0007133	USR0423	VST003577	RT00484	4	t
LOG0007134	USR0394	VST001430	RT00878	4	f
LOG0007135	USR0031	VST002190	RT00671	1	f
LOG0007136	USR0171	VST001988	RT00255	1	f
LOG0007137	USR0355	VST004744	RT00757	1	t
LOG0007138	USR0205	VST002883	RT00618	1	f
LOG0007139	USR0478	VST001710	RT00198	2	t
LOG0007140	USR0482	VST002778	RT00427	3	t
LOG0007141	USR0420	VST003698	RT00493	3	t
LOG0007142	USR0291	VST001548	RT00632	3	f
LOG0007143	USR0111	VST000463	RT00082	2	f
LOG0007144	USR0068	VST003316	RT00308	4	f
LOG0007145	USR0183	VST003305	RT00782	4	f
LOG0007146	USR0373	VST000514	RT00699	1	f
LOG0007147	USR0196	VST004097	RT00788	1	t
LOG0007148	USR0126	VST003567	RT00374	2	f
LOG0007149	USR0175	VST003804	RT00564	2	f
LOG0007150	USR0262	VST003688	RT00459	4	f
LOG0007151	USR0375	VST003939	RT00501	3	t
LOG0007152	USR0412	VST003490	RT00357	3	f
LOG0007153	USR0286	VST001472	RT00296	2	f
LOG0007154	USR0155	VST000338	RT00580	2	f
LOG0007155	USR0069	VST003082	RT00300	2	f
LOG0007156	USR0108	VST003413	RT00646	1	t
LOG0007157	USR0423	VST002393	RT00343	3	t
LOG0007158	USR0035	VST000977	RT00120	2	f
LOG0007159	USR0359	VST004979	RT00569	2	t
LOG0007160	USR0044	VST002246	RT00186	1	t
LOG0007161	USR0143	VST004069	RT00584	2	t
LOG0007162	USR0211	VST001704	RT00158	3	f
LOG0007163	USR0478	VST000872	RT00228	1	t
LOG0007164	USR0486	VST003410	RT00308	2	f
LOG0007165	USR0416	VST002590	RT00234	3	f
LOG0007166	USR0488	VST004553	RT00011	3	t
LOG0007167	USR0285	VST001550	RT00175	1	t
LOG0007168	USR0447	VST003508	RT00773	3	t
LOG0007169	USR0006	VST004462	RT00643	1	f
LOG0007170	USR0218	VST002622	RT00911	3	t
LOG0007171	USR0027	VST002530	RT00898	2	f
LOG0007172	USR0227	VST002158	RT00002	1	t
LOG0007173	USR0284	VST002357	RT00761	3	t
LOG0007174	USR0389	VST000160	RT00712	1	t
LOG0007175	USR0425	VST004940	RT00182	3	f
LOG0007176	USR0056	VST002103	RT00942	1	t
LOG0007177	USR0368	VST002809	RT00350	2	f
LOG0007178	USR0310	VST002000	RT00639	1	t
LOG0007179	USR0336	VST002582	RT00382	1	f
LOG0007180	USR0105	VST002994	RT00297	2	t
LOG0007181	USR0018	VST002935	RT00197	3	t
LOG0007182	USR0205	VST002312	RT00286	4	t
LOG0007183	USR0043	VST002796	RT00556	2	t
LOG0007184	USR0089	VST004329	RT00522	1	t
LOG0007185	USR0074	VST004329	RT00225	2	t
LOG0007186	USR0157	VST003589	RT00728	2	f
LOG0007187	USR0266	VST003117	RT00723	1	t
LOG0007188	USR0134	VST004654	RT00286	1	t
LOG0007189	USR0464	VST003748	RT00729	4	f
LOG0007190	USR0089	VST001950	RT00331	2	f
LOG0007191	USR0236	VST001460	RT00561	1	t
LOG0007192	USR0132	VST004431	RT00163	3	f
LOG0007193	USR0229	VST002452	RT00193	3	f
LOG0007194	USR0034	VST004352	RT00145	3	t
LOG0007195	USR0083	VST003068	RT00671	3	f
LOG0007196	USR0417	VST004091	RT00838	2	t
LOG0007197	USR0132	VST002989	RT00973	2	f
LOG0007198	USR0428	VST000772	RT00692	4	f
LOG0007199	USR0354	VST001112	RT00538	2	f
LOG0007200	USR0204	VST003312	RT00612	1	t
LOG0007201	USR0287	VST004407	RT00901	4	t
LOG0007202	USR0336	VST001595	RT00623	2	t
LOG0007203	USR0450	VST002730	RT00270	2	t
LOG0007204	USR0497	VST001282	RT00051	1	t
LOG0007205	USR0442	VST003586	RT00527	1	t
LOG0007206	USR0316	VST002829	RT00128	1	f
LOG0007207	USR0258	VST002374	RT00652	3	f
LOG0007208	USR0292	VST004886	RT00754	2	t
LOG0007209	USR0454	VST000342	RT00046	2	f
LOG0007210	USR0125	VST004934	RT00234	2	t
LOG0007211	USR0444	VST004724	RT00448	4	t
LOG0007212	USR0151	VST002819	RT00584	4	f
LOG0007213	USR0359	VST002926	RT00443	4	f
LOG0007214	USR0247	VST001273	RT00503	4	t
LOG0007215	USR0175	VST000710	RT00607	4	t
LOG0007216	USR0372	VST000739	RT00922	1	f
LOG0007217	USR0492	VST001779	RT00285	4	f
LOG0007218	USR0357	VST004591	RT00132	2	f
LOG0007219	USR0302	VST004131	RT00946	3	t
LOG0007220	USR0080	VST003719	RT00476	2	t
LOG0007221	USR0107	VST004914	RT00793	2	t
LOG0007222	USR0300	VST000010	RT00936	1	t
LOG0007223	USR0403	VST001738	RT00544	3	t
LOG0007224	USR0305	VST002579	RT00356	2	f
LOG0007225	USR0344	VST001559	RT00971	1	t
LOG0007226	USR0058	VST002143	RT00037	3	t
LOG0007227	USR0091	VST002624	RT00638	3	t
LOG0007228	USR0135	VST004001	RT00138	1	f
LOG0007229	USR0350	VST004546	RT00422	4	t
LOG0007230	USR0169	VST002144	RT00445	1	f
LOG0007231	USR0334	VST000865	RT00612	1	t
LOG0007232	USR0122	VST001801	RT00242	4	t
LOG0007233	USR0500	VST003453	RT00245	1	f
LOG0007234	USR0236	VST002717	RT00539	1	f
LOG0007235	USR0399	VST004303	RT00209	1	t
LOG0007236	USR0076	VST001810	RT00903	2	f
LOG0007237	USR0309	VST004946	RT00457	1	f
LOG0007238	USR0477	VST004342	RT00099	1	f
LOG0007239	USR0023	VST001998	RT00502	3	t
LOG0007240	USR0333	VST002932	RT00137	3	t
LOG0007241	USR0073	VST002131	RT00187	3	t
LOG0007242	USR0088	VST004413	RT00036	1	t
LOG0007243	USR0103	VST002693	RT00630	4	f
LOG0007244	USR0094	VST003177	RT00670	1	t
LOG0007245	USR0449	VST002797	RT00479	2	f
LOG0007246	USR0316	VST004696	RT00787	2	t
LOG0007247	USR0266	VST001556	RT00681	2	t
LOG0007248	USR0253	VST003691	RT00055	2	f
LOG0007249	USR0358	VST004937	RT00471	1	t
LOG0007250	USR0058	VST003573	RT00084	3	t
LOG0007251	USR0431	VST004444	RT00006	1	t
LOG0007252	USR0399	VST000331	RT00891	1	f
LOG0007253	USR0009	VST004706	RT00363	1	t
LOG0007254	USR0013	VST001945	RT00856	1	f
LOG0007255	USR0407	VST004840	RT00768	4	f
LOG0007256	USR0417	VST003959	RT00918	3	t
LOG0007257	USR0393	VST004665	RT00710	3	t
LOG0007258	USR0131	VST001685	RT00664	2	t
LOG0007259	USR0222	VST002437	RT00830	1	t
LOG0007260	USR0329	VST000971	RT00170	2	f
LOG0007261	USR0372	VST000747	RT00760	3	f
LOG0007262	USR0153	VST002185	RT00249	3	t
LOG0007263	USR0381	VST001385	RT00662	2	t
LOG0007264	USR0367	VST004031	RT00210	3	t
LOG0007265	USR0472	VST001019	RT00912	3	f
LOG0007266	USR0480	VST002579	RT00740	4	t
LOG0007267	USR0071	VST004112	RT00244	1	t
LOG0007268	USR0420	VST004664	RT00141	1	t
LOG0007269	USR0345	VST003941	RT00632	3	f
LOG0007270	USR0020	VST002025	RT00805	3	f
LOG0007271	USR0081	VST001543	RT00180	4	t
LOG0007272	USR0438	VST002712	RT00920	2	f
LOG0007273	USR0228	VST003047	RT00637	4	t
LOG0007274	USR0346	VST001455	RT00979	4	t
LOG0007275	USR0019	VST003004	RT00754	2	f
LOG0007276	USR0444	VST001703	RT00724	3	t
LOG0007277	USR0165	VST004421	RT00987	1	f
LOG0007278	USR0368	VST003874	RT00017	4	f
LOG0007279	USR0387	VST000122	RT00016	4	t
LOG0007280	USR0107	VST001477	RT00385	1	t
LOG0007281	USR0377	VST000266	RT00341	4	t
LOG0007282	USR0348	VST000028	RT00893	2	t
LOG0007283	USR0214	VST002125	RT00987	1	t
LOG0007284	USR0239	VST000432	RT00769	1	f
LOG0007285	USR0147	VST004975	RT00798	2	f
LOG0007286	USR0181	VST003778	RT00980	2	f
LOG0007287	USR0430	VST004532	RT00792	1	f
LOG0007288	USR0336	VST001086	RT00046	2	f
LOG0007289	USR0440	VST002095	RT00504	4	t
LOG0007290	USR0198	VST002486	RT00770	3	f
LOG0007291	USR0485	VST000101	RT00143	4	t
LOG0007292	USR0287	VST002155	RT00285	2	t
LOG0007293	USR0053	VST003049	RT00355	4	f
LOG0007294	USR0369	VST004983	RT00830	3	f
LOG0007295	USR0240	VST000800	RT00525	3	f
LOG0007296	USR0290	VST003823	RT00979	3	t
LOG0007297	USR0287	VST001296	RT00833	2	t
LOG0007298	USR0188	VST000435	RT00557	2	t
LOG0007299	USR0395	VST003805	RT00047	2	f
LOG0007300	USR0484	VST002614	RT00528	3	t
LOG0007301	USR0006	VST000916	RT00894	2	t
LOG0007302	USR0283	VST002276	RT00107	1	f
LOG0007303	USR0263	VST004641	RT00003	4	t
LOG0007304	USR0049	VST000648	RT00616	4	t
LOG0007305	USR0352	VST002296	RT00966	1	f
LOG0007306	USR0200	VST004079	RT00095	2	t
LOG0007307	USR0060	VST001432	RT00133	4	f
LOG0007308	USR0033	VST002362	RT00922	3	f
LOG0007309	USR0303	VST004133	RT00860	4	t
LOG0007310	USR0244	VST000724	RT00783	4	t
LOG0007311	USR0172	VST001548	RT00201	4	f
LOG0007312	USR0207	VST000980	RT00254	2	t
LOG0007313	USR0375	VST000084	RT00183	1	t
LOG0007314	USR0283	VST003487	RT00150	4	f
LOG0007315	USR0478	VST001366	RT00549	3	f
LOG0007316	USR0022	VST004815	RT00981	4	f
LOG0007317	USR0047	VST000550	RT00490	2	f
LOG0007318	USR0349	VST003493	RT00505	2	f
LOG0007319	USR0489	VST002763	RT00413	3	f
LOG0007320	USR0432	VST003854	RT00922	4	t
LOG0007321	USR0158	VST004683	RT00838	4	t
LOG0007322	USR0258	VST003200	RT00508	3	f
LOG0007323	USR0143	VST000152	RT00651	1	f
LOG0007324	USR0047	VST003499	RT00612	2	f
LOG0007325	USR0027	VST002213	RT00404	1	f
LOG0007326	USR0455	VST002986	RT00236	1	f
LOG0007327	USR0027	VST004095	RT00596	4	t
LOG0007328	USR0469	VST001568	RT00859	3	f
LOG0007329	USR0397	VST000212	RT00966	2	t
LOG0007330	USR0439	VST004838	RT00545	1	f
LOG0007331	USR0145	VST002180	RT00633	1	t
LOG0007332	USR0075	VST003224	RT00542	4	t
LOG0007333	USR0187	VST004192	RT00434	4	f
LOG0007334	USR0010	VST001527	RT00546	4	f
LOG0007335	USR0121	VST000522	RT00645	3	f
LOG0007336	USR0289	VST003947	RT00208	2	t
LOG0007337	USR0462	VST001703	RT00140	2	f
LOG0007338	USR0165	VST000018	RT00588	4	f
LOG0007339	USR0382	VST003481	RT00587	1	t
LOG0007340	USR0264	VST001720	RT00820	4	t
LOG0007341	USR0161	VST003317	RT00307	4	f
LOG0007342	USR0391	VST004015	RT00917	3	f
LOG0007343	USR0418	VST000879	RT00967	4	f
LOG0007344	USR0327	VST000594	RT00570	2	f
LOG0007345	USR0391	VST004739	RT00098	4	f
LOG0007346	USR0297	VST004897	RT00125	2	f
LOG0007347	USR0118	VST004551	RT00960	1	f
LOG0007348	USR0484	VST001610	RT00349	2	t
LOG0007349	USR0311	VST000876	RT00134	2	t
LOG0007350	USR0263	VST003232	RT00996	4	t
LOG0007351	USR0084	VST002449	RT00226	2	t
LOG0007352	USR0146	VST004558	RT00945	2	f
LOG0007353	USR0493	VST002137	RT00712	1	f
LOG0007354	USR0171	VST002054	RT00549	2	t
LOG0007355	USR0489	VST000084	RT00650	2	t
LOG0007356	USR0334	VST001440	RT00720	4	f
LOG0007357	USR0424	VST002669	RT00706	3	f
LOG0007358	USR0309	VST002220	RT00568	4	t
LOG0007359	USR0014	VST000699	RT00339	1	t
LOG0007360	USR0149	VST001821	RT00839	4	t
LOG0007361	USR0369	VST004626	RT00322	2	t
LOG0007362	USR0251	VST004415	RT00813	3	f
LOG0007363	USR0057	VST001099	RT00087	4	f
LOG0007364	USR0347	VST002895	RT00095	4	f
LOG0007365	USR0302	VST003418	RT00196	1	t
LOG0007366	USR0410	VST000249	RT00192	2	f
LOG0007367	USR0347	VST004483	RT00656	4	t
LOG0007368	USR0408	VST001958	RT00522	4	f
LOG0007369	USR0133	VST001891	RT00753	3	t
LOG0007370	USR0170	VST004459	RT00661	1	t
LOG0007371	USR0102	VST003368	RT00988	2	f
LOG0007372	USR0476	VST002116	RT00652	4	f
LOG0007373	USR0106	VST003064	RT00013	3	f
LOG0007374	USR0171	VST001807	RT00254	4	t
LOG0007375	USR0128	VST000296	RT01000	4	t
LOG0007376	USR0250	VST002695	RT00081	1	t
LOG0007377	USR0032	VST001992	RT00722	3	f
LOG0007378	USR0216	VST003940	RT00373	3	t
LOG0007379	USR0262	VST000032	RT00394	2	f
LOG0007380	USR0330	VST004651	RT00890	4	t
LOG0007381	USR0494	VST003876	RT00732	3	f
LOG0007382	USR0244	VST004401	RT00909	4	t
LOG0007383	USR0451	VST000793	RT00418	4	f
LOG0007384	USR0391	VST004192	RT00059	2	f
LOG0007385	USR0285	VST001090	RT00128	2	t
LOG0007386	USR0290	VST000230	RT00817	3	t
LOG0007387	USR0263	VST002781	RT00774	4	t
LOG0007388	USR0337	VST004454	RT00780	3	t
LOG0007389	USR0333	VST004498	RT00541	4	f
LOG0007390	USR0314	VST000790	RT00333	3	t
LOG0007391	USR0085	VST004195	RT00892	3	f
LOG0007392	USR0415	VST004367	RT00282	4	t
LOG0007393	USR0329	VST001799	RT00580	1	t
LOG0007394	USR0045	VST003981	RT00207	2	f
LOG0007395	USR0303	VST004458	RT00272	4	t
LOG0007396	USR0333	VST003241	RT00309	3	t
LOG0007397	USR0465	VST004636	RT00403	1	t
LOG0007398	USR0200	VST003857	RT00175	3	t
LOG0007399	USR0201	VST004929	RT00218	1	t
LOG0007400	USR0329	VST000314	RT00672	4	t
LOG0007401	USR0168	VST000233	RT00326	2	f
LOG0007402	USR0240	VST003508	RT00756	3	f
LOG0007403	USR0372	VST001030	RT00253	1	t
LOG0007404	USR0286	VST003607	RT00454	1	f
LOG0007405	USR0190	VST002712	RT00189	2	t
LOG0007406	USR0071	VST004340	RT00773	3	t
LOG0007407	USR0145	VST002289	RT00443	4	t
LOG0007408	USR0359	VST004000	RT00898	4	f
LOG0007409	USR0486	VST002606	RT00130	3	f
LOG0007410	USR0389	VST003345	RT00485	2	t
LOG0007411	USR0209	VST002123	RT00003	2	t
LOG0007412	USR0360	VST002331	RT00966	2	t
LOG0007413	USR0378	VST003780	RT00351	1	f
LOG0007414	USR0385	VST004183	RT00555	1	f
LOG0007415	USR0208	VST000881	RT00133	2	t
LOG0007416	USR0465	VST002978	RT00690	3	t
LOG0007417	USR0222	VST001173	RT00494	4	t
LOG0007418	USR0287	VST000160	RT00266	1	t
LOG0007419	USR0163	VST002494	RT00923	2	f
LOG0007420	USR0365	VST002130	RT00024	1	f
LOG0007421	USR0072	VST003079	RT00534	1	f
LOG0007422	USR0240	VST002230	RT00857	2	f
LOG0007423	USR0414	VST002918	RT00003	3	t
LOG0007424	USR0127	VST003014	RT00912	4	f
LOG0007425	USR0487	VST001550	RT00670	3	t
LOG0007426	USR0085	VST004574	RT00880	1	f
LOG0007427	USR0015	VST003386	RT00427	3	f
LOG0007428	USR0248	VST001580	RT00004	3	f
LOG0007429	USR0482	VST003372	RT00619	4	t
LOG0007430	USR0312	VST001961	RT00808	2	f
LOG0007431	USR0444	VST003845	RT00784	2	f
LOG0007432	USR0283	VST004698	RT00503	2	f
LOG0007433	USR0002	VST002391	RT00232	3	f
LOG0007434	USR0074	VST001420	RT00873	3	f
LOG0007435	USR0064	VST003918	RT00750	4	f
LOG0007436	USR0261	VST003836	RT00072	2	t
LOG0007437	USR0347	VST004429	RT00088	4	t
LOG0007438	USR0324	VST004451	RT00528	4	t
LOG0007439	USR0239	VST003631	RT00886	3	t
LOG0007440	USR0397	VST004943	RT00603	2	f
LOG0007441	USR0337	VST000163	RT00450	1	t
LOG0007442	USR0341	VST000116	RT00439	1	t
LOG0007443	USR0279	VST001471	RT00532	3	t
LOG0007444	USR0353	VST003080	RT00435	3	f
LOG0007445	USR0434	VST003853	RT00724	3	f
LOG0007446	USR0380	VST002839	RT00084	3	f
LOG0007447	USR0463	VST000543	RT00339	1	t
LOG0007448	USR0462	VST000414	RT00953	2	t
LOG0007449	USR0201	VST000682	RT00126	4	f
LOG0007450	USR0492	VST000642	RT00563	1	f
LOG0007451	USR0293	VST003979	RT00018	2	t
LOG0007452	USR0286	VST001433	RT00973	3	t
LOG0007453	USR0221	VST000669	RT00849	4	f
LOG0007454	USR0407	VST002070	RT00955	2	f
LOG0007455	USR0162	VST000969	RT00865	2	t
LOG0007456	USR0448	VST001181	RT00629	4	f
LOG0007457	USR0183	VST004820	RT00636	2	f
LOG0007458	USR0455	VST003236	RT00540	2	f
LOG0007459	USR0373	VST000252	RT00965	4	f
LOG0007460	USR0265	VST004301	RT00924	4	f
LOG0007461	USR0498	VST002880	RT00345	1	t
LOG0007462	USR0132	VST003999	RT00468	3	t
LOG0007463	USR0322	VST000791	RT00981	3	f
LOG0007464	USR0120	VST004561	RT00141	2	t
LOG0007465	USR0380	VST001496	RT00006	3	t
LOG0007466	USR0219	VST004490	RT00669	1	f
LOG0007467	USR0417	VST003069	RT00618	2	f
LOG0007468	USR0160	VST002708	RT00631	3	t
LOG0007469	USR0300	VST002578	RT00649	3	t
LOG0007470	USR0109	VST001236	RT00541	2	t
LOG0007471	USR0238	VST001059	RT00678	4	f
LOG0007472	USR0293	VST001171	RT00065	1	f
LOG0007473	USR0475	VST003619	RT00056	2	t
LOG0007474	USR0476	VST003660	RT00798	2	f
LOG0007475	USR0067	VST003656	RT00882	3	t
LOG0007476	USR0316	VST000057	RT00096	4	f
LOG0007477	USR0187	VST001893	RT00889	3	f
LOG0007478	USR0036	VST002570	RT00955	2	f
LOG0007479	USR0049	VST004081	RT00215	2	t
LOG0007480	USR0256	VST004457	RT00743	3	f
LOG0007481	USR0435	VST001949	RT00058	4	f
LOG0007482	USR0107	VST000223	RT00906	2	f
LOG0007483	USR0008	VST001640	RT00492	1	f
LOG0007484	USR0236	VST004423	RT00405	4	f
LOG0007485	USR0178	VST001758	RT00184	2	t
LOG0007486	USR0242	VST000836	RT00282	4	f
LOG0007487	USR0041	VST002537	RT00783	4	f
LOG0007488	USR0357	VST002526	RT00721	1	t
LOG0007489	USR0245	VST000985	RT00163	2	f
LOG0007490	USR0113	VST001358	RT00089	4	f
LOG0007491	USR0365	VST004888	RT00783	2	f
LOG0007492	USR0256	VST003061	RT00097	2	f
LOG0007493	USR0166	VST004478	RT00587	4	t
LOG0007494	USR0342	VST001447	RT00088	3	f
LOG0007495	USR0078	VST001372	RT00518	4	f
LOG0007496	USR0207	VST003225	RT00668	3	f
LOG0007497	USR0311	VST001875	RT00063	3	f
LOG0007498	USR0366	VST002500	RT00541	3	t
LOG0007499	USR0196	VST003362	RT00816	3	f
LOG0007500	USR0402	VST001143	RT00191	4	f
LOG0007501	USR0321	VST004310	RT00954	3	t
LOG0007502	USR0064	VST000565	RT00917	2	f
LOG0007503	USR0140	VST004828	RT00716	4	t
LOG0007504	USR0374	VST004535	RT00278	1	f
LOG0007505	USR0425	VST001589	RT00539	3	t
LOG0007506	USR0042	VST003986	RT00085	4	t
LOG0007507	USR0373	VST004725	RT00335	3	t
LOG0007508	USR0444	VST004999	RT00441	2	t
LOG0007509	USR0306	VST001471	RT00722	3	f
LOG0007510	USR0209	VST003915	RT00650	4	f
LOG0007511	USR0467	VST003114	RT00790	2	t
LOG0007512	USR0420	VST004491	RT00172	3	t
LOG0007513	USR0304	VST004343	RT00852	1	t
LOG0007514	USR0455	VST003363	RT00339	3	f
LOG0007515	USR0073	VST001637	RT00668	3	t
LOG0007516	USR0392	VST002913	RT00229	2	f
LOG0007517	USR0153	VST001473	RT00818	3	f
LOG0007518	USR0135	VST001245	RT00179	4	t
LOG0007519	USR0362	VST003738	RT00247	4	t
LOG0007520	USR0264	VST002099	RT00897	2	f
LOG0007521	USR0216	VST002598	RT00674	4	t
LOG0007522	USR0209	VST002513	RT00675	1	t
LOG0007523	USR0204	VST004515	RT00730	3	f
LOG0007524	USR0110	VST000259	RT00317	2	t
LOG0007525	USR0031	VST002359	RT00286	4	t
LOG0007526	USR0012	VST003394	RT00076	1	f
LOG0007527	USR0127	VST003779	RT00974	1	t
LOG0007528	USR0313	VST003412	RT00999	2	t
LOG0007529	USR0194	VST001269	RT00452	2	f
LOG0007530	USR0140	VST000940	RT00204	4	t
LOG0007531	USR0027	VST002377	RT00728	3	f
LOG0007532	USR0046	VST003952	RT00424	1	t
LOG0007533	USR0135	VST000196	RT00735	1	f
LOG0007534	USR0317	VST004158	RT00193	2	f
LOG0007535	USR0442	VST003097	RT00293	1	t
LOG0007536	USR0058	VST003636	RT00704	2	f
LOG0007537	USR0013	VST000562	RT00897	3	t
LOG0007538	USR0437	VST003450	RT00911	2	f
LOG0007539	USR0100	VST003367	RT00781	3	t
LOG0007540	USR0449	VST003124	RT00413	4	f
LOG0007541	USR0049	VST002892	RT00439	2	f
LOG0007542	USR0291	VST000040	RT00301	4	t
LOG0007543	USR0094	VST001768	RT00260	3	t
LOG0007544	USR0095	VST002505	RT00192	1	f
LOG0007545	USR0145	VST000788	RT00271	4	f
LOG0007546	USR0072	VST001877	RT00616	2	f
LOG0007547	USR0451	VST004098	RT00432	2	f
LOG0007548	USR0379	VST001493	RT00716	4	f
LOG0007549	USR0010	VST001130	RT00696	4	f
LOG0007550	USR0162	VST002264	RT00217	4	f
LOG0007551	USR0214	VST004873	RT00091	2	f
LOG0007552	USR0004	VST004510	RT00198	4	t
LOG0007553	USR0224	VST004022	RT00983	4	t
LOG0007554	USR0381	VST004306	RT00399	3	t
LOG0007555	USR0029	VST002186	RT00039	4	t
LOG0007556	USR0302	VST001645	RT00709	4	f
LOG0007557	USR0203	VST003561	RT00471	2	f
LOG0007558	USR0430	VST002686	RT00079	2	t
LOG0007559	USR0077	VST004822	RT00729	1	f
LOG0007560	USR0059	VST001413	RT00828	2	f
LOG0007561	USR0445	VST001222	RT00094	2	t
LOG0007562	USR0196	VST002250	RT00684	2	t
LOG0007563	USR0322	VST002240	RT00043	2	t
LOG0007564	USR0418	VST004203	RT00132	4	f
LOG0007565	USR0107	VST004423	RT00077	1	f
LOG0007566	USR0342	VST000644	RT00946	2	t
LOG0007567	USR0389	VST004453	RT00232	4	t
LOG0007568	USR0009	VST002549	RT00039	2	t
LOG0007569	USR0020	VST004604	RT00566	1	t
LOG0007570	USR0149	VST003806	RT00151	3	f
LOG0007571	USR0383	VST004291	RT00700	3	t
LOG0007572	USR0017	VST004143	RT00976	1	f
LOG0007573	USR0012	VST001386	RT00419	4	t
LOG0007574	USR0476	VST002585	RT00822	4	f
LOG0007575	USR0082	VST001602	RT00186	1	f
LOG0007576	USR0067	VST004943	RT00318	3	t
LOG0007577	USR0133	VST004805	RT00464	2	f
LOG0007578	USR0444	VST003318	RT00432	3	t
LOG0007579	USR0053	VST000808	RT00135	2	t
LOG0007580	USR0436	VST002660	RT00503	1	t
LOG0007581	USR0206	VST000115	RT00685	1	f
LOG0007582	USR0432	VST002728	RT00269	1	t
LOG0007583	USR0474	VST004727	RT00437	3	f
LOG0007584	USR0403	VST002267	RT00627	1	t
LOG0007585	USR0233	VST004293	RT00498	3	f
LOG0007586	USR0401	VST004497	RT00733	4	t
LOG0007587	USR0054	VST003902	RT00551	2	t
LOG0007588	USR0487	VST002729	RT00340	2	f
LOG0007589	USR0490	VST004172	RT00242	2	f
LOG0007590	USR0068	VST001450	RT00221	1	f
LOG0007591	USR0490	VST004383	RT00658	2	t
LOG0007592	USR0291	VST001569	RT00918	1	f
LOG0007593	USR0344	VST001323	RT00676	3	f
LOG0007594	USR0169	VST000861	RT00361	1	f
LOG0007595	USR0397	VST000742	RT00949	2	f
LOG0007596	USR0161	VST001731	RT00880	1	t
LOG0007597	USR0015	VST004905	RT00996	1	f
LOG0007598	USR0191	VST002934	RT00840	3	f
LOG0007599	USR0015	VST003519	RT00771	1	t
LOG0007600	USR0287	VST004510	RT00190	2	t
LOG0007601	USR0363	VST004527	RT00413	1	t
LOG0007602	USR0412	VST003168	RT00329	4	f
LOG0007603	USR0010	VST001919	RT00776	1	f
LOG0007604	USR0057	VST002219	RT00222	4	f
LOG0007605	USR0199	VST001341	RT00844	2	f
LOG0007606	USR0161	VST004640	RT00686	4	f
LOG0007607	USR0263	VST001515	RT00092	4	t
LOG0007608	USR0389	VST001412	RT00440	4	f
LOG0007609	USR0474	VST003037	RT00106	4	f
LOG0007610	USR0381	VST004168	RT00245	4	f
LOG0007611	USR0253	VST001023	RT00305	1	f
LOG0007612	USR0119	VST004628	RT00555	3	f
LOG0007613	USR0080	VST002287	RT00906	4	f
LOG0007614	USR0124	VST002759	RT00909	2	t
LOG0007615	USR0313	VST004673	RT00953	2	t
LOG0007616	USR0072	VST003772	RT00770	1	t
LOG0007617	USR0470	VST001113	RT00833	3	t
LOG0007618	USR0482	VST001946	RT00598	3	t
LOG0007619	USR0168	VST004809	RT00097	4	t
LOG0007620	USR0284	VST001559	RT00976	2	f
LOG0007621	USR0494	VST003880	RT00938	2	f
LOG0007622	USR0036	VST000642	RT00954	1	t
LOG0007623	USR0312	VST002238	RT00477	4	t
LOG0007624	USR0175	VST004908	RT00266	2	f
LOG0007625	USR0199	VST003487	RT00575	4	f
LOG0007626	USR0116	VST003226	RT00103	3	t
LOG0007627	USR0424	VST001015	RT00254	4	t
LOG0007628	USR0315	VST002022	RT00455	4	t
LOG0007629	USR0427	VST002677	RT00829	1	f
LOG0007630	USR0220	VST001541	RT00513	1	t
LOG0007631	USR0379	VST002937	RT00666	3	t
LOG0007632	USR0066	VST003107	RT00493	3	t
LOG0007633	USR0265	VST000784	RT00261	4	t
LOG0007634	USR0134	VST000671	RT00035	2	f
LOG0007635	USR0119	VST002770	RT00381	4	t
LOG0007636	USR0122	VST002574	RT00397	3	f
LOG0007637	USR0321	VST002585	RT00027	1	f
LOG0007638	USR0387	VST004943	RT00908	1	t
LOG0007639	USR0458	VST001278	RT00862	3	t
LOG0007640	USR0421	VST003044	RT00306	4	f
LOG0007641	USR0383	VST003173	RT00736	2	f
LOG0007642	USR0492	VST003783	RT00699	1	f
LOG0007643	USR0087	VST000178	RT00671	4	f
LOG0007644	USR0289	VST000276	RT00581	2	f
LOG0007645	USR0137	VST002360	RT00165	3	t
LOG0007646	USR0053	VST003482	RT00258	4	t
LOG0007647	USR0205	VST004887	RT00102	2	t
LOG0007648	USR0348	VST003360	RT00455	4	f
LOG0007649	USR0051	VST001425	RT00193	1	f
LOG0007650	USR0327	VST004123	RT00771	3	f
LOG0007651	USR0410	VST002961	RT00916	1	f
LOG0007652	USR0400	VST002470	RT00898	1	t
LOG0007653	USR0040	VST003086	RT00810	4	t
LOG0007654	USR0250	VST002373	RT00299	3	f
LOG0007655	USR0218	VST004069	RT00021	4	f
LOG0007656	USR0179	VST001591	RT00045	2	t
LOG0007657	USR0039	VST004381	RT00480	3	t
LOG0007658	USR0183	VST001113	RT00496	1	t
LOG0007659	USR0224	VST001069	RT00788	1	f
LOG0007660	USR0164	VST002546	RT00683	1	t
LOG0007661	USR0234	VST003650	RT00690	4	f
LOG0007662	USR0377	VST001815	RT00223	4	t
LOG0007663	USR0193	VST003908	RT00299	4	t
LOG0007664	USR0497	VST003732	RT00481	3	t
LOG0007665	USR0085	VST002193	RT00024	3	f
LOG0007666	USR0461	VST000082	RT00338	3	f
LOG0007667	USR0243	VST003707	RT00084	3	t
LOG0007668	USR0474	VST003177	RT00060	2	f
LOG0007669	USR0173	VST001826	RT00288	1	t
LOG0007670	USR0393	VST000082	RT00634	4	f
LOG0007671	USR0037	VST000094	RT00517	4	t
LOG0007672	USR0087	VST000343	RT00898	2	f
LOG0007673	USR0129	VST002409	RT00154	1	f
LOG0007674	USR0194	VST001855	RT00281	1	t
LOG0007675	USR0319	VST004000	RT00434	2	t
LOG0007676	USR0043	VST001090	RT00342	3	f
LOG0007677	USR0412	VST000624	RT00935	1	t
LOG0007678	USR0356	VST000868	RT00086	3	t
LOG0007679	USR0159	VST002477	RT00587	2	t
LOG0007680	USR0105	VST003473	RT00779	4	t
LOG0007681	USR0453	VST000171	RT00191	4	f
LOG0007682	USR0229	VST001783	RT00252	4	t
LOG0007683	USR0217	VST000578	RT00068	4	f
LOG0007684	USR0264	VST000068	RT00865	1	f
LOG0007685	USR0418	VST001516	RT00146	3	f
LOG0007686	USR0487	VST000001	RT00991	4	f
LOG0007687	USR0049	VST002199	RT00876	4	t
LOG0007688	USR0352	VST000902	RT00634	4	f
LOG0007689	USR0442	VST004846	RT00924	2	t
LOG0007690	USR0123	VST000795	RT00554	1	t
LOG0007691	USR0459	VST002067	RT00828	2	f
LOG0007692	USR0303	VST001820	RT00662	3	t
LOG0007693	USR0025	VST000371	RT00936	4	f
LOG0007694	USR0131	VST002539	RT00574	1	t
LOG0007695	USR0429	VST003908	RT00255	1	t
LOG0007696	USR0370	VST002055	RT00131	1	t
LOG0007697	USR0436	VST002597	RT00839	2	f
LOG0007698	USR0224	VST004467	RT00959	2	f
LOG0007699	USR0500	VST001689	RT00377	2	f
LOG0007700	USR0099	VST004853	RT00532	2	t
LOG0007701	USR0352	VST003322	RT00199	3	f
LOG0007702	USR0290	VST001139	RT00839	4	t
LOG0007703	USR0485	VST002622	RT00221	4	t
LOG0007704	USR0500	VST002729	RT00410	2	t
LOG0007705	USR0197	VST001166	RT00937	2	t
LOG0007706	USR0109	VST001509	RT00643	2	f
LOG0007707	USR0348	VST003842	RT00171	3	f
LOG0007708	USR0220	VST004559	RT00145	3	t
LOG0007709	USR0264	VST004577	RT00488	1	t
LOG0007710	USR0411	VST004919	RT00852	4	t
LOG0007711	USR0208	VST000524	RT00354	2	f
LOG0007712	USR0319	VST002259	RT00181	1	t
LOG0007713	USR0082	VST004340	RT00948	4	f
LOG0007714	USR0025	VST000239	RT00161	1	f
LOG0007715	USR0186	VST001221	RT00464	3	f
LOG0007716	USR0432	VST000769	RT00060	3	t
LOG0007717	USR0385	VST000235	RT00215	1	f
LOG0007718	USR0008	VST002761	RT00580	1	f
LOG0007719	USR0124	VST004593	RT00952	4	f
LOG0007720	USR0149	VST001520	RT00873	2	f
LOG0007721	USR0098	VST001904	RT00192	4	f
LOG0007722	USR0216	VST002235	RT00488	4	t
LOG0007723	USR0101	VST000936	RT00225	3	t
LOG0007724	USR0218	VST001269	RT00392	3	f
LOG0007725	USR0367	VST000819	RT00709	1	t
LOG0007726	USR0462	VST003568	RT00161	3	f
LOG0007727	USR0413	VST004118	RT00761	4	t
LOG0007728	USR0414	VST002116	RT00921	1	t
LOG0007729	USR0259	VST002440	RT00455	1	f
LOG0007730	USR0391	VST003388	RT00111	3	f
LOG0007731	USR0356	VST001089	RT00903	2	t
LOG0007732	USR0011	VST001828	RT00059	3	t
LOG0007733	USR0416	VST004825	RT00545	1	t
LOG0007734	USR0059	VST002589	RT00553	1	f
LOG0007735	USR0250	VST002616	RT00673	2	f
LOG0007736	USR0140	VST001874	RT00029	4	t
LOG0007737	USR0335	VST004308	RT00767	1	f
LOG0007738	USR0038	VST001774	RT00935	2	t
LOG0007739	USR0122	VST000200	RT00185	4	f
LOG0007740	USR0408	VST000178	RT00873	3	f
LOG0007741	USR0065	VST000931	RT00224	2	f
LOG0007742	USR0146	VST003737	RT00357	4	t
LOG0007743	USR0302	VST002037	RT00492	1	t
LOG0007744	USR0125	VST001486	RT00733	1	t
LOG0007745	USR0312	VST002092	RT00832	2	f
LOG0007746	USR0191	VST004264	RT00598	3	f
LOG0007747	USR0263	VST002385	RT00578	2	t
LOG0007748	USR0490	VST004089	RT00114	1	t
LOG0007749	USR0361	VST004682	RT00378	4	f
LOG0007750	USR0450	VST001916	RT00777	3	f
LOG0007751	USR0296	VST000016	RT00285	4	f
LOG0007752	USR0182	VST002935	RT00097	2	f
LOG0007753	USR0159	VST000837	RT00842	2	f
LOG0007754	USR0353	VST002158	RT00124	4	f
LOG0007755	USR0308	VST001577	RT00156	4	t
LOG0007756	USR0478	VST000306	RT00110	4	f
LOG0007757	USR0287	VST002054	RT00053	2	t
LOG0007758	USR0162	VST002891	RT00174	4	f
LOG0007759	USR0263	VST003345	RT00679	1	f
LOG0007760	USR0217	VST004457	RT00588	4	t
LOG0007761	USR0400	VST001209	RT00314	1	f
LOG0007762	USR0406	VST001859	RT00726	1	t
LOG0007763	USR0484	VST002704	RT00694	4	t
LOG0007764	USR0181	VST001972	RT00390	3	t
LOG0007765	USR0091	VST001114	RT00045	3	f
LOG0007766	USR0017	VST000984	RT00936	3	t
LOG0007767	USR0125	VST003311	RT00663	1	t
LOG0007768	USR0260	VST004002	RT00117	3	f
LOG0007769	USR0445	VST002772	RT00122	3	t
LOG0007770	USR0378	VST003153	RT00482	4	t
LOG0007771	USR0355	VST002163	RT00170	2	f
LOG0007772	USR0489	VST002128	RT00678	1	t
LOG0007773	USR0214	VST003640	RT00400	2	f
LOG0007774	USR0239	VST004275	RT00842	1	t
LOG0007775	USR0180	VST000561	RT00943	1	f
LOG0007776	USR0419	VST001810	RT00661	3	t
LOG0007777	USR0172	VST004388	RT00500	4	t
LOG0007778	USR0143	VST002933	RT00074	2	f
LOG0007779	USR0317	VST000291	RT00971	2	t
LOG0007780	USR0244	VST004638	RT00149	3	t
LOG0007781	USR0232	VST001910	RT00537	2	t
LOG0007782	USR0172	VST004690	RT00892	2	f
LOG0007783	USR0277	VST001429	RT00061	1	f
LOG0007784	USR0077	VST000948	RT00866	4	f
LOG0007785	USR0303	VST002528	RT00054	4	t
LOG0007786	USR0331	VST001349	RT00223	2	f
LOG0007787	USR0049	VST000381	RT00731	2	t
LOG0007788	USR0437	VST001705	RT00473	1	f
LOG0007789	USR0248	VST000310	RT00316	3	f
LOG0007790	USR0283	VST003415	RT00170	1	f
LOG0007791	USR0287	VST001499	RT00701	3	f
LOG0007792	USR0428	VST002895	RT00032	3	t
LOG0007793	USR0032	VST000661	RT00053	1	f
LOG0007794	USR0500	VST003448	RT00940	4	t
LOG0007795	USR0158	VST002274	RT00139	1	f
LOG0007796	USR0018	VST001498	RT00374	3	t
LOG0007797	USR0381	VST002073	RT00047	4	t
LOG0007798	USR0063	VST003437	RT00090	4	f
LOG0007799	USR0128	VST002143	RT00828	1	t
LOG0007800	USR0016	VST004661	RT00036	4	t
LOG0007801	USR0163	VST001606	RT00997	4	f
LOG0007802	USR0446	VST004740	RT00956	1	f
LOG0007803	USR0251	VST001432	RT00929	2	f
LOG0007804	USR0137	VST001951	RT00225	4	t
LOG0007805	USR0318	VST003923	RT00554	1	f
LOG0007806	USR0295	VST000459	RT00740	1	f
LOG0007807	USR0179	VST002949	RT00269	2	t
LOG0007808	USR0229	VST000338	RT00910	4	f
LOG0007809	USR0371	VST003944	RT00186	3	f
LOG0007810	USR0394	VST002014	RT00371	3	t
LOG0007811	USR0180	VST004021	RT00869	4	f
LOG0007812	USR0396	VST000345	RT00235	4	t
LOG0007813	USR0072	VST004672	RT00122	1	f
LOG0007814	USR0318	VST000943	RT00424	1	t
LOG0007815	USR0387	VST000346	RT00833	3	t
LOG0007816	USR0083	VST003895	RT00389	4	f
LOG0007817	USR0379	VST003320	RT00926	1	f
LOG0007818	USR0395	VST003696	RT00117	3	t
LOG0007819	USR0136	VST000325	RT00466	3	t
LOG0007820	USR0218	VST002139	RT00429	2	t
LOG0007821	USR0109	VST004390	RT00869	4	f
LOG0007822	USR0378	VST003613	RT00442	2	t
LOG0007823	USR0407	VST000524	RT00039	1	t
LOG0007824	USR0119	VST002898	RT00908	1	f
LOG0007825	USR0394	VST003741	RT00162	3	f
LOG0007826	USR0018	VST000259	RT00621	1	t
LOG0007827	USR0332	VST001111	RT00526	2	t
LOG0007828	USR0423	VST000821	RT00166	4	t
LOG0007829	USR0154	VST002789	RT00912	3	f
LOG0007830	USR0011	VST004665	RT00874	3	f
LOG0007831	USR0138	VST004605	RT00445	1	t
LOG0007832	USR0387	VST001564	RT00443	3	f
LOG0007833	USR0062	VST004621	RT00331	3	f
LOG0007834	USR0071	VST001208	RT00993	4	f
LOG0007835	USR0061	VST000309	RT00335	3	f
LOG0007836	USR0132	VST001840	RT00112	4	f
LOG0007837	USR0061	VST003353	RT00746	2	f
LOG0007838	USR0488	VST001384	RT00714	3	t
LOG0007839	USR0392	VST002307	RT00835	2	t
LOG0007840	USR0358	VST001181	RT00139	4	f
LOG0007841	USR0269	VST002473	RT00779	3	t
LOG0007842	USR0012	VST002687	RT00784	1	t
LOG0007843	USR0035	VST002968	RT00166	1	t
LOG0007844	USR0486	VST004446	RT00414	3	f
LOG0007845	USR0438	VST000961	RT00169	4	f
LOG0007846	USR0051	VST003457	RT00769	1	t
LOG0007847	USR0043	VST000438	RT00124	2	t
LOG0007848	USR0228	VST000456	RT00550	4	t
LOG0007849	USR0111	VST003818	RT00882	4	t
LOG0007850	USR0322	VST001570	RT00761	3	t
LOG0007851	USR0015	VST001104	RT00749	2	t
LOG0007852	USR0177	VST001619	RT00098	4	f
LOG0007853	USR0162	VST003613	RT00060	3	t
LOG0007854	USR0039	VST001513	RT00019	2	f
LOG0007855	USR0026	VST004739	RT00124	4	t
LOG0007856	USR0112	VST000392	RT00226	1	t
LOG0007857	USR0453	VST002622	RT00955	2	t
LOG0007858	USR0432	VST000921	RT00612	4	f
LOG0007859	USR0473	VST002458	RT00324	2	f
LOG0007860	USR0051	VST003601	RT00906	1	t
LOG0007861	USR0482	VST004509	RT00017	4	f
LOG0007862	USR0367	VST001789	RT00760	1	f
LOG0007863	USR0388	VST000261	RT00080	3	f
LOG0007864	USR0098	VST002014	RT00597	3	t
LOG0007865	USR0411	VST001336	RT00860	4	t
LOG0007866	USR0375	VST000335	RT00456	4	t
LOG0007867	USR0170	VST002780	RT00541	2	f
LOG0007868	USR0056	VST000804	RT00646	4	f
LOG0007869	USR0221	VST002438	RT00990	3	t
LOG0007870	USR0325	VST002808	RT00706	4	t
LOG0007871	USR0146	VST000941	RT00631	2	f
LOG0007872	USR0445	VST003164	RT00378	3	t
LOG0007873	USR0260	VST000903	RT00879	4	t
LOG0007874	USR0129	VST003433	RT00191	1	t
LOG0007875	USR0050	VST001269	RT00927	1	t
LOG0007876	USR0340	VST000024	RT00665	1	f
LOG0007877	USR0326	VST004653	RT00855	1	t
LOG0007878	USR0404	VST002749	RT00491	2	t
LOG0007879	USR0020	VST002451	RT00405	1	f
LOG0007880	USR0174	VST001397	RT00272	1	f
LOG0007881	USR0283	VST003358	RT00644	4	t
LOG0007882	USR0026	VST003905	RT00875	1	t
LOG0007883	USR0160	VST002489	RT00430	1	f
LOG0007884	USR0010	VST003667	RT00520	4	t
LOG0007885	USR0082	VST001758	RT00646	3	f
LOG0007886	USR0256	VST004978	RT00893	2	t
LOG0007887	USR0105	VST001879	RT00384	2	t
LOG0007888	USR0140	VST002533	RT00821	3	t
LOG0007889	USR0202	VST003515	RT00887	4	t
LOG0007890	USR0344	VST003774	RT00192	3	t
LOG0007891	USR0024	VST002079	RT00603	2	t
LOG0007892	USR0373	VST004662	RT00435	2	f
LOG0007893	USR0435	VST002058	RT00761	3	f
LOG0007894	USR0422	VST000678	RT00996	1	t
LOG0007895	USR0046	VST004947	RT00764	2	f
LOG0007896	USR0217	VST002975	RT00996	3	f
LOG0007897	USR0392	VST000285	RT00063	1	f
LOG0007898	USR0055	VST002201	RT00216	1	t
LOG0007899	USR0078	VST004467	RT00134	4	f
LOG0007900	USR0491	VST001841	RT00958	3	f
LOG0007901	USR0159	VST001879	RT00619	2	f
LOG0007902	USR0344	VST001611	RT00161	4	t
LOG0007903	USR0272	VST003963	RT00258	2	t
LOG0007904	USR0148	VST004237	RT00425	1	f
LOG0007905	USR0038	VST003160	RT00528	3	t
LOG0007906	USR0111	VST003499	RT00358	1	t
LOG0007907	USR0015	VST002132	RT00375	1	t
LOG0007908	USR0078	VST003315	RT00571	1	t
LOG0007909	USR0076	VST001379	RT00009	3	f
LOG0007910	USR0418	VST003078	RT00197	4	t
LOG0007911	USR0328	VST003015	RT00117	2	f
LOG0007912	USR0275	VST003893	RT00010	1	f
LOG0007913	USR0494	VST001716	RT00862	2	t
LOG0007914	USR0197	VST000453	RT00519	2	t
LOG0007915	USR0376	VST000342	RT00349	4	t
LOG0007916	USR0219	VST000393	RT00706	3	f
LOG0007917	USR0063	VST001270	RT00404	2	t
LOG0007918	USR0361	VST003051	RT00635	4	t
LOG0007919	USR0461	VST004060	RT00575	2	t
LOG0007920	USR0032	VST000971	RT00004	1	f
LOG0007921	USR0479	VST002206	RT00796	4	t
LOG0007922	USR0233	VST004795	RT00328	3	f
LOG0007923	USR0110	VST000166	RT00762	3	t
LOG0007924	USR0165	VST000255	RT00512	1	t
LOG0007925	USR0194	VST000302	RT00931	1	t
LOG0007926	USR0007	VST003104	RT00130	2	t
LOG0007927	USR0432	VST003841	RT00937	4	f
LOG0007928	USR0139	VST002557	RT00924	4	f
LOG0007929	USR0459	VST001506	RT00587	4	f
LOG0007930	USR0343	VST001257	RT00484	4	f
LOG0007931	USR0287	VST002263	RT00841	2	t
LOG0007932	USR0428	VST004341	RT00358	4	f
LOG0007933	USR0301	VST000210	RT00385	4	t
LOG0007934	USR0456	VST003794	RT00254	3	f
LOG0007935	USR0056	VST004522	RT00923	3	f
LOG0007936	USR0160	VST003048	RT00835	2	t
LOG0007937	USR0496	VST000981	RT00167	1	t
LOG0007938	USR0149	VST002120	RT00713	3	t
LOG0007939	USR0287	VST003746	RT00680	1	f
LOG0007940	USR0257	VST000178	RT00796	2	f
LOG0007941	USR0461	VST001547	RT00469	3	t
LOG0007942	USR0139	VST002035	RT00860	3	f
LOG0007943	USR0349	VST000299	RT00493	2	t
LOG0007944	USR0324	VST002568	RT00920	4	t
LOG0007945	USR0292	VST003567	RT00338	2	t
LOG0007946	USR0335	VST004040	RT00051	1	f
LOG0007947	USR0187	VST000275	RT00056	1	t
LOG0007948	USR0323	VST002996	RT00073	4	t
LOG0007949	USR0184	VST000053	RT00794	2	t
LOG0007950	USR0307	VST001424	RT00600	2	f
LOG0007951	USR0413	VST001628	RT00052	4	f
LOG0007952	USR0469	VST000489	RT00125	2	t
LOG0007953	USR0386	VST002355	RT00262	3	f
LOG0007954	USR0262	VST000417	RT00955	2	f
LOG0007955	USR0415	VST002557	RT00885	3	f
LOG0007956	USR0310	VST000921	RT00780	2	f
LOG0007957	USR0344	VST001554	RT00575	3	f
LOG0007958	USR0424	VST002686	RT00548	1	f
LOG0007959	USR0145	VST000666	RT00521	4	f
LOG0007960	USR0261	VST004102	RT00330	1	t
LOG0007961	USR0002	VST002470	RT00323	3	f
LOG0007962	USR0314	VST001475	RT00241	4	t
LOG0007963	USR0012	VST000338	RT00285	1	t
LOG0007964	USR0261	VST003160	RT00839	1	f
LOG0007965	USR0362	VST000269	RT00602	3	t
LOG0007966	USR0444	VST001088	RT00264	2	t
LOG0007967	USR0169	VST001294	RT00299	2	t
LOG0007968	USR0148	VST000657	RT00205	3	t
LOG0007969	USR0200	VST002829	RT00291	1	f
LOG0007970	USR0385	VST003974	RT00211	2	f
LOG0007971	USR0312	VST004958	RT00366	2	t
LOG0007972	USR0070	VST001337	RT00790	1	t
LOG0007973	USR0312	VST002357	RT00464	3	t
LOG0007974	USR0054	VST001668	RT00719	3	f
LOG0007975	USR0395	VST001826	RT00322	2	t
LOG0007976	USR0259	VST004031	RT00358	3	f
LOG0007977	USR0351	VST001213	RT00917	1	f
LOG0007978	USR0028	VST002769	RT00094	3	t
LOG0007979	USR0367	VST004416	RT00711	4	t
LOG0007980	USR0363	VST003059	RT00863	3	f
LOG0007981	USR0120	VST000445	RT00169	3	t
LOG0007982	USR0133	VST001398	RT00297	3	t
LOG0007983	USR0380	VST004382	RT00945	4	t
LOG0007984	USR0090	VST002219	RT00739	1	f
LOG0007985	USR0016	VST003677	RT00516	3	t
LOG0007986	USR0287	VST002311	RT00098	2	f
LOG0007987	USR0284	VST004041	RT00705	3	t
LOG0007988	USR0391	VST003607	RT00778	4	f
LOG0007989	USR0230	VST001828	RT00350	4	f
LOG0007990	USR0137	VST003220	RT00736	2	t
LOG0007991	USR0295	VST004689	RT00579	4	f
LOG0007992	USR0227	VST004512	RT00650	4	t
LOG0007993	USR0427	VST002073	RT00841	4	t
LOG0007994	USR0027	VST004190	RT00401	1	t
LOG0007995	USR0332	VST002331	RT00751	4	t
LOG0007996	USR0117	VST000686	RT00451	3	t
LOG0007997	USR0089	VST004959	RT00475	2	t
LOG0007998	USR0107	VST000685	RT00821	3	f
LOG0007999	USR0221	VST002938	RT00419	3	f
LOG0008000	USR0223	VST003712	RT00004	2	t
LOG0008001	USR0122	VST000341	RT00324	1	f
LOG0008002	USR0382	VST004700	RT00369	1	t
LOG0008003	USR0354	VST000734	RT00864	4	t
LOG0008004	USR0033	VST001497	RT00614	1	f
LOG0008005	USR0091	VST003894	RT00395	1	f
LOG0008006	USR0184	VST002955	RT00556	4	t
LOG0008007	USR0376	VST001132	RT00119	1	t
LOG0008008	USR0258	VST004636	RT00700	1	t
LOG0008009	USR0398	VST001733	RT00743	4	t
LOG0008010	USR0013	VST003036	RT00966	3	f
LOG0008011	USR0024	VST002714	RT00190	3	f
LOG0008012	USR0325	VST002480	RT00995	2	t
LOG0008013	USR0034	VST001420	RT00622	1	f
LOG0008014	USR0247	VST001990	RT00416	4	f
LOG0008015	USR0343	VST004711	RT00814	4	f
LOG0008016	USR0019	VST000488	RT00791	1	f
LOG0008017	USR0030	VST003820	RT00106	1	t
LOG0008018	USR0049	VST001442	RT00165	4	t
LOG0008019	USR0427	VST002391	RT00638	4	t
LOG0008020	USR0400	VST001385	RT00346	4	f
LOG0008021	USR0180	VST002157	RT00098	2	f
LOG0008022	USR0370	VST004945	RT00486	3	t
LOG0008023	USR0372	VST004397	RT00331	4	t
LOG0008024	USR0488	VST001392	RT00370	3	t
LOG0008025	USR0226	VST004801	RT00442	1	t
LOG0008026	USR0433	VST003143	RT00120	3	f
LOG0008027	USR0395	VST000269	RT00853	3	t
LOG0008028	USR0078	VST003918	RT00299	3	t
LOG0008029	USR0496	VST001525	RT00856	1	t
LOG0008030	USR0431	VST000478	RT00143	3	f
LOG0008031	USR0207	VST004272	RT00707	3	f
LOG0008032	USR0035	VST000239	RT00642	2	t
LOG0008033	USR0250	VST000610	RT00967	1	f
LOG0008034	USR0071	VST004588	RT00901	3	f
LOG0008035	USR0413	VST004425	RT00949	1	t
LOG0008036	USR0364	VST003398	RT00941	4	t
LOG0008037	USR0310	VST004541	RT00616	3	f
LOG0008038	USR0470	VST004538	RT00093	1	t
LOG0008039	USR0279	VST004891	RT00297	3	f
LOG0008040	USR0152	VST001832	RT00447	3	f
LOG0008041	USR0227	VST004987	RT00480	4	f
LOG0008042	USR0243	VST001155	RT00734	2	f
LOG0008043	USR0010	VST001752	RT00712	1	t
LOG0008044	USR0317	VST003599	RT00800	3	t
LOG0008045	USR0392	VST002486	RT00874	4	t
LOG0008046	USR0048	VST003339	RT00258	4	t
LOG0008047	USR0112	VST002334	RT00522	2	f
LOG0008048	USR0204	VST004387	RT00683	2	f
LOG0008049	USR0477	VST004464	RT00375	4	f
LOG0008050	USR0382	VST004582	RT00427	4	f
LOG0008051	USR0157	VST000168	RT00101	1	t
LOG0008052	USR0343	VST003543	RT00622	1	f
LOG0008053	USR0026	VST004010	RT00759	4	f
LOG0008054	USR0421	VST000078	RT00835	4	t
LOG0008055	USR0480	VST002899	RT00244	2	t
LOG0008056	USR0308	VST001109	RT00023	1	f
LOG0008057	USR0166	VST000892	RT00354	4	f
LOG0008058	USR0249	VST004757	RT00466	1	t
LOG0008059	USR0262	VST001225	RT00225	1	t
LOG0008060	USR0264	VST004685	RT00865	4	t
LOG0008061	USR0017	VST000565	RT00444	4	f
LOG0008062	USR0076	VST002860	RT00977	3	f
LOG0008063	USR0446	VST000302	RT00774	1	f
LOG0008064	USR0470	VST004390	RT00269	1	t
LOG0008065	USR0254	VST000109	RT00533	2	t
LOG0008066	USR0206	VST002413	RT00991	2	t
LOG0008067	USR0034	VST002648	RT00314	2	f
LOG0008068	USR0147	VST002726	RT00120	1	f
LOG0008069	USR0326	VST003339	RT00981	4	t
LOG0008070	USR0338	VST002141	RT00481	4	t
LOG0008071	USR0228	VST004524	RT00924	4	t
LOG0008072	USR0118	VST004734	RT00120	1	f
LOG0008073	USR0165	VST003814	RT00710	4	f
LOG0008074	USR0038	VST004201	RT00136	2	t
LOG0008075	USR0399	VST002257	RT00077	4	t
LOG0008076	USR0358	VST003646	RT00354	4	f
LOG0008077	USR0296	VST003060	RT00058	2	t
LOG0008078	USR0137	VST002522	RT00936	3	t
LOG0008079	USR0309	VST003418	RT00086	3	t
LOG0008080	USR0246	VST000012	RT00001	3	f
LOG0008081	USR0198	VST004745	RT00077	1	f
LOG0008082	USR0374	VST003267	RT00961	1	f
LOG0008083	USR0066	VST003146	RT00522	2	f
LOG0008084	USR0080	VST000875	RT00444	3	f
LOG0008085	USR0052	VST002434	RT00581	1	f
LOG0008086	USR0129	VST000884	RT00148	4	f
LOG0008087	USR0414	VST004651	RT00574	3	t
LOG0008088	USR0380	VST003986	RT00525	3	t
LOG0008089	USR0368	VST001580	RT00186	1	f
LOG0008090	USR0481	VST003772	RT00677	3	t
LOG0008091	USR0001	VST000353	RT00522	2	f
LOG0008092	USR0167	VST001507	RT00771	2	f
LOG0008093	USR0016	VST003488	RT00162	1	f
LOG0008094	USR0145	VST002852	RT00290	3	t
LOG0008095	USR0112	VST002030	RT00926	2	f
LOG0008096	USR0368	VST001847	RT00421	3	t
LOG0008097	USR0102	VST002391	RT00196	2	f
LOG0008098	USR0082	VST004031	RT00034	2	t
LOG0008099	USR0406	VST003439	RT00672	3	f
LOG0008100	USR0470	VST002384	RT00597	1	t
LOG0008101	USR0099	VST003368	RT00570	1	f
LOG0008102	USR0159	VST004981	RT00873	1	t
LOG0008103	USR0040	VST001466	RT00408	3	t
LOG0008104	USR0155	VST002152	RT00777	3	t
LOG0008105	USR0036	VST003484	RT00297	3	f
LOG0008106	USR0381	VST000574	RT00920	1	t
LOG0008107	USR0247	VST000775	RT00537	3	f
LOG0008108	USR0004	VST003366	RT00036	1	f
LOG0008109	USR0497	VST004339	RT00264	2	t
LOG0008110	USR0374	VST003931	RT00382	1	t
LOG0008111	USR0453	VST002681	RT00114	1	t
LOG0008112	USR0281	VST004961	RT00617	4	t
LOG0008113	USR0351	VST002221	RT00605	4	f
LOG0008114	USR0334	VST001440	RT00601	1	t
LOG0008115	USR0414	VST000714	RT00443	4	t
LOG0008116	USR0431	VST000576	RT00163	3	f
LOG0008117	USR0249	VST002982	RT00038	4	t
LOG0008118	USR0012	VST000070	RT00092	4	f
LOG0008119	USR0283	VST003765	RT00631	4	t
LOG0008120	USR0429	VST004939	RT00723	1	t
LOG0008121	USR0216	VST002377	RT00672	2	t
LOG0008122	USR0319	VST002206	RT00101	2	t
LOG0008123	USR0311	VST000918	RT00881	2	f
LOG0008124	USR0414	VST002746	RT00507	2	t
LOG0008125	USR0082	VST000743	RT00179	2	f
LOG0008126	USR0014	VST004151	RT00284	2	f
LOG0008127	USR0056	VST002534	RT00952	1	t
LOG0008128	USR0403	VST001838	RT00355	3	t
LOG0008129	USR0342	VST001377	RT00904	3	t
LOG0008130	USR0282	VST000410	RT00297	2	t
LOG0008131	USR0199	VST003008	RT00886	4	t
LOG0008132	USR0348	VST002953	RT00535	4	f
LOG0008133	USR0166	VST004243	RT00950	1	f
LOG0008134	USR0453	VST001680	RT00488	2	t
LOG0008135	USR0292	VST001715	RT00279	2	t
LOG0008136	USR0146	VST001198	RT00544	4	f
LOG0008137	USR0441	VST002338	RT00650	2	f
LOG0008138	USR0078	VST003217	RT00593	2	t
LOG0008139	USR0112	VST002957	RT00931	4	f
LOG0008140	USR0023	VST003194	RT00355	3	t
LOG0008141	USR0375	VST000027	RT00319	3	f
LOG0008142	USR0116	VST003138	RT00195	1	t
LOG0008143	USR0142	VST002974	RT00804	4	t
LOG0008144	USR0480	VST003166	RT00093	1	t
LOG0008145	USR0197	VST001091	RT00433	2	f
LOG0008146	USR0278	VST000250	RT00558	4	f
LOG0008147	USR0028	VST000142	RT00027	3	f
LOG0008148	USR0299	VST000267	RT00415	2	f
LOG0008149	USR0076	VST004311	RT00162	3	t
LOG0008150	USR0018	VST000489	RT00844	3	t
LOG0008151	USR0100	VST000496	RT00101	1	f
LOG0008152	USR0479	VST000480	RT00699	4	f
LOG0008153	USR0461	VST002691	RT00950	4	t
LOG0008154	USR0468	VST004097	RT00473	4	t
LOG0008155	USR0124	VST003081	RT00706	1	f
LOG0008156	USR0365	VST004937	RT00158	3	f
LOG0008157	USR0292	VST002428	RT00492	1	f
LOG0008158	USR0125	VST000844	RT00969	4	t
LOG0008159	USR0007	VST003216	RT00919	2	t
LOG0008160	USR0023	VST003912	RT00009	4	t
LOG0008161	USR0162	VST004078	RT00212	4	t
LOG0008162	USR0117	VST002350	RT00439	3	f
LOG0008163	USR0370	VST000650	RT00897	4	t
LOG0008164	USR0352	VST001894	RT00824	4	f
LOG0008165	USR0021	VST002857	RT00679	3	t
LOG0008166	USR0252	VST003251	RT00855	4	f
LOG0008167	USR0326	VST002387	RT00786	4	f
LOG0008168	USR0464	VST001726	RT00810	3	t
LOG0008169	USR0483	VST001355	RT00992	2	f
LOG0008170	USR0431	VST001294	RT00111	3	f
LOG0008171	USR0309	VST003047	RT00841	4	t
LOG0008172	USR0084	VST003259	RT00203	1	f
LOG0008173	USR0362	VST002714	RT00760	2	t
LOG0008174	USR0041	VST000404	RT00065	3	t
LOG0008175	USR0203	VST003973	RT00715	2	t
LOG0008176	USR0416	VST004033	RT00161	2	f
LOG0008177	USR0128	VST001547	RT00414	1	f
LOG0008178	USR0142	VST002607	RT00645	1	t
LOG0008179	USR0344	VST002826	RT00690	1	t
LOG0008180	USR0492	VST001853	RT00705	4	f
LOG0008181	USR0103	VST004207	RT00266	3	t
LOG0008182	USR0107	VST000813	RT00572	4	t
LOG0008183	USR0479	VST003375	RT00205	3	t
LOG0008184	USR0017	VST000930	RT00667	4	f
LOG0008185	USR0025	VST004982	RT00584	4	f
LOG0008186	USR0064	VST004076	RT00156	1	f
LOG0008187	USR0457	VST003324	RT00173	4	t
LOG0008188	USR0342	VST000175	RT00308	1	t
LOG0008189	USR0375	VST001364	RT00450	3	t
LOG0008190	USR0237	VST002896	RT00062	1	t
LOG0008191	USR0176	VST001038	RT00373	2	f
LOG0008192	USR0291	VST003012	RT00460	2	f
LOG0008193	USR0293	VST002091	RT00475	4	t
LOG0008194	USR0311	VST000461	RT00381	2	f
LOG0008195	USR0401	VST002753	RT00717	3	t
LOG0008196	USR0156	VST000149	RT00572	4	t
LOG0008197	USR0385	VST004434	RT00086	1	f
LOG0008198	USR0053	VST001134	RT00936	4	f
LOG0008199	USR0073	VST000354	RT00143	4	t
LOG0008200	USR0183	VST001108	RT00863	2	t
LOG0008201	USR0369	VST002603	RT00007	4	f
LOG0008202	USR0189	VST002114	RT00295	3	f
LOG0008203	USR0013	VST004095	RT00691	4	f
LOG0008204	USR0047	VST003686	RT00739	1	t
LOG0008205	USR0448	VST003207	RT00519	1	f
LOG0008206	USR0160	VST001110	RT00652	2	f
LOG0008207	USR0284	VST004180	RT00526	4	f
LOG0008208	USR0053	VST001978	RT00034	1	t
LOG0008209	USR0287	VST000227	RT00890	4	f
LOG0008210	USR0008	VST002940	RT00935	4	f
LOG0008211	USR0072	VST001013	RT00752	1	f
LOG0008212	USR0380	VST004116	RT00329	4	f
LOG0008213	USR0098	VST003107	RT00832	2	t
LOG0008214	USR0087	VST003937	RT00609	2	f
LOG0008215	USR0330	VST002803	RT00780	1	t
LOG0008216	USR0101	VST001467	RT00638	3	f
LOG0008217	USR0496	VST002989	RT00034	3	f
LOG0008218	USR0281	VST000270	RT00795	4	f
LOG0008219	USR0371	VST003807	RT00406	2	f
LOG0008220	USR0289	VST001532	RT00018	1	f
LOG0008221	USR0237	VST000304	RT00430	2	f
LOG0008222	USR0196	VST004906	RT00428	3	t
LOG0008223	USR0391	VST001933	RT00914	3	t
LOG0008224	USR0097	VST002041	RT00293	4	t
LOG0008225	USR0450	VST004022	RT00903	1	t
LOG0008226	USR0368	VST000142	RT00580	4	t
LOG0008227	USR0430	VST000809	RT00749	2	f
LOG0008228	USR0096	VST000948	RT00080	2	f
LOG0008229	USR0261	VST003952	RT00086	3	f
LOG0008230	USR0121	VST003413	RT00572	4	f
LOG0008231	USR0366	VST002293	RT00048	2	t
LOG0008232	USR0273	VST000766	RT00691	2	t
LOG0008233	USR0332	VST002924	RT00868	2	f
LOG0008234	USR0052	VST000939	RT00084	1	f
LOG0008235	USR0396	VST002497	RT00607	3	t
LOG0008236	USR0318	VST003563	RT00308	4	t
LOG0008237	USR0163	VST001263	RT00252	2	f
LOG0008238	USR0190	VST000543	RT00481	1	t
LOG0008239	USR0277	VST002680	RT00845	2	f
LOG0008240	USR0085	VST002955	RT00180	2	f
LOG0008241	USR0194	VST002932	RT00596	3	t
LOG0008242	USR0181	VST002782	RT00310	1	t
LOG0008243	USR0021	VST004240	RT00937	2	f
LOG0008244	USR0399	VST002992	RT00426	3	t
LOG0008245	USR0203	VST002613	RT00486	1	t
LOG0008246	USR0202	VST003649	RT00662	2	f
LOG0008247	USR0466	VST001200	RT00039	4	f
LOG0008248	USR0151	VST002118	RT00279	3	f
LOG0008249	USR0384	VST002681	RT00816	2	t
LOG0008250	USR0159	VST002849	RT00625	2	f
LOG0008251	USR0310	VST004689	RT00376	1	f
LOG0008252	USR0439	VST004663	RT00929	4	f
LOG0008253	USR0026	VST004787	RT00639	3	t
LOG0008254	USR0309	VST003682	RT00041	1	t
LOG0008255	USR0066	VST003496	RT00670	2	f
LOG0008256	USR0423	VST000665	RT00718	3	t
LOG0008257	USR0263	VST004502	RT00047	2	t
LOG0008258	USR0472	VST003163	RT00484	2	f
LOG0008259	USR0167	VST003366	RT00185	4	t
LOG0008260	USR0288	VST001417	RT00072	2	t
LOG0008261	USR0154	VST003109	RT00569	3	f
LOG0008262	USR0343	VST000517	RT00751	2	t
LOG0008263	USR0206	VST000850	RT00574	3	t
LOG0008264	USR0413	VST001902	RT00342	4	t
LOG0008265	USR0153	VST000908	RT00569	2	t
LOG0008266	USR0184	VST000316	RT00964	1	t
LOG0008267	USR0159	VST003244	RT00243	3	f
LOG0008268	USR0194	VST001508	RT00995	2	f
LOG0008269	USR0002	VST004123	RT00328	1	t
LOG0008270	USR0215	VST001519	RT00994	3	f
LOG0008271	USR0175	VST004151	RT00636	1	f
LOG0008272	USR0075	VST001935	RT00982	2	f
LOG0008273	USR0285	VST004345	RT00153	4	f
LOG0008274	USR0127	VST001802	RT00255	4	t
LOG0008275	USR0490	VST002623	RT00729	1	t
LOG0008276	USR0483	VST000857	RT00424	2	t
LOG0008277	USR0049	VST001877	RT00232	2	f
LOG0008278	USR0457	VST001526	RT00529	3	t
LOG0008279	USR0032	VST001417	RT00592	2	f
LOG0008280	USR0158	VST003480	RT00496	4	t
LOG0008281	USR0015	VST003872	RT00176	2	t
LOG0008282	USR0318	VST001795	RT00551	3	f
LOG0008283	USR0334	VST003066	RT00143	3	t
LOG0008284	USR0243	VST002721	RT00017	2	f
LOG0008285	USR0017	VST004205	RT00249	2	t
LOG0008286	USR0022	VST003677	RT00035	3	f
LOG0008287	USR0244	VST000353	RT00801	3	f
LOG0008288	USR0414	VST003232	RT01000	1	f
LOG0008289	USR0081	VST001428	RT00999	4	t
LOG0008290	USR0144	VST002193	RT00146	4	t
LOG0008291	USR0436	VST001778	RT00926	1	f
LOG0008292	USR0008	VST003537	RT00727	1	f
LOG0008293	USR0448	VST001117	RT00165	4	f
LOG0008294	USR0167	VST002321	RT00111	3	t
LOG0008295	USR0287	VST000534	RT00647	4	f
LOG0008296	USR0268	VST001218	RT00074	3	t
LOG0008297	USR0289	VST002989	RT00976	4	t
LOG0008298	USR0186	VST002229	RT00668	3	t
LOG0008299	USR0012	VST001980	RT00727	4	f
LOG0008300	USR0281	VST002077	RT00354	1	t
LOG0008301	USR0422	VST000532	RT00274	2	f
LOG0008302	USR0304	VST003077	RT00943	2	f
LOG0008303	USR0466	VST001945	RT00279	2	t
LOG0008304	USR0083	VST004236	RT00660	3	t
LOG0008305	USR0055	VST003100	RT00031	2	f
LOG0008306	USR0131	VST004358	RT00526	4	t
LOG0008307	USR0125	VST003830	RT00535	2	t
LOG0008308	USR0483	VST004115	RT00510	3	t
LOG0008309	USR0325	VST002585	RT00514	3	t
LOG0008310	USR0419	VST001549	RT00925	3	f
LOG0008311	USR0051	VST001489	RT00178	4	t
LOG0008312	USR0027	VST003660	RT00329	3	t
LOG0008313	USR0165	VST000228	RT00571	4	t
LOG0008314	USR0494	VST004472	RT00801	3	t
LOG0008315	USR0469	VST004832	RT00688	1	t
LOG0008316	USR0400	VST004353	RT00172	3	t
LOG0008317	USR0476	VST004929	RT00396	2	t
LOG0008318	USR0281	VST004797	RT00595	2	t
LOG0008319	USR0033	VST000699	RT00938	1	t
LOG0008320	USR0062	VST000438	RT00980	3	f
LOG0008321	USR0145	VST001685	RT00997	2	f
LOG0008322	USR0171	VST002154	RT00735	2	t
LOG0008323	USR0286	VST004711	RT00035	4	t
LOG0008324	USR0297	VST002915	RT00297	4	f
LOG0008325	USR0117	VST003218	RT00469	3	f
LOG0008326	USR0004	VST000960	RT00951	1	t
LOG0008327	USR0066	VST001840	RT00495	3	f
LOG0008328	USR0060	VST000278	RT00622	4	f
LOG0008329	USR0393	VST004221	RT00235	4	f
LOG0008330	USR0287	VST003757	RT00909	3	f
LOG0008331	USR0345	VST001344	RT00039	3	f
LOG0008332	USR0229	VST004771	RT00219	3	f
LOG0008333	USR0100	VST000715	RT00217	3	f
LOG0008334	USR0119	VST001506	RT00706	1	f
LOG0008335	USR0069	VST003922	RT00675	2	t
LOG0008336	USR0152	VST002715	RT00628	3	f
LOG0008337	USR0280	VST001348	RT00840	2	t
LOG0008338	USR0221	VST002443	RT00673	4	f
LOG0008339	USR0498	VST004869	RT00601	2	t
LOG0008340	USR0429	VST003961	RT00981	3	t
LOG0008341	USR0223	VST001753	RT00420	2	t
LOG0008342	USR0165	VST002506	RT00653	3	t
LOG0008343	USR0442	VST001738	RT00824	3	f
LOG0008344	USR0211	VST004170	RT00174	4	t
LOG0008345	USR0279	VST001109	RT00713	3	f
LOG0008346	USR0419	VST002680	RT00867	4	t
LOG0008347	USR0063	VST001038	RT00814	1	f
LOG0008348	USR0374	VST000912	RT00868	3	t
LOG0008349	USR0370	VST004890	RT00113	4	f
LOG0008350	USR0262	VST002097	RT00879	4	f
LOG0008351	USR0006	VST003014	RT00940	3	t
LOG0008352	USR0248	VST000359	RT00174	2	f
LOG0008353	USR0229	VST001077	RT00074	4	f
LOG0008354	USR0286	VST002104	RT00837	1	t
LOG0008355	USR0257	VST004975	RT00799	2	f
LOG0008356	USR0063	VST003528	RT00637	2	t
LOG0008357	USR0392	VST002303	RT00536	3	t
LOG0008358	USR0028	VST004101	RT00032	4	f
LOG0008359	USR0345	VST001605	RT00254	1	t
LOG0008360	USR0417	VST001076	RT00497	4	t
LOG0008361	USR0053	VST004049	RT00113	1	f
LOG0008362	USR0252	VST000329	RT00195	4	f
LOG0008363	USR0038	VST003233	RT00528	3	f
LOG0008364	USR0308	VST003478	RT00441	1	t
LOG0008365	USR0334	VST001003	RT00489	3	t
LOG0008366	USR0139	VST004879	RT00497	4	f
LOG0008367	USR0386	VST000577	RT00724	1	f
LOG0008368	USR0053	VST000327	RT00620	1	f
LOG0008369	USR0094	VST001528	RT00024	4	f
LOG0008370	USR0094	VST002822	RT00290	3	f
LOG0008371	USR0452	VST001466	RT00896	1	f
LOG0008372	USR0461	VST003226	RT00308	1	f
LOG0008373	USR0263	VST002282	RT00304	1	f
LOG0008374	USR0486	VST004748	RT00855	4	f
LOG0008375	USR0323	VST002381	RT00631	2	f
LOG0008376	USR0137	VST000495	RT00693	4	t
LOG0008377	USR0462	VST001139	RT00951	3	t
LOG0008378	USR0372	VST002417	RT00038	2	t
LOG0008379	USR0447	VST001357	RT00386	1	f
LOG0008380	USR0256	VST001154	RT00745	1	f
LOG0008381	USR0395	VST003250	RT00581	2	t
LOG0008382	USR0037	VST002143	RT00082	1	t
LOG0008383	USR0142	VST003389	RT00118	1	t
LOG0008384	USR0147	VST001125	RT00821	4	f
LOG0008385	USR0008	VST000802	RT00050	4	f
LOG0008386	USR0251	VST002043	RT00669	3	t
LOG0008387	USR0135	VST000208	RT00074	1	f
LOG0008388	USR0059	VST002655	RT00695	3	t
LOG0008389	USR0123	VST000473	RT00106	3	t
LOG0008390	USR0447	VST001639	RT00701	2	t
LOG0008391	USR0263	VST000136	RT00818	2	f
LOG0008392	USR0120	VST004357	RT00784	1	t
LOG0008393	USR0439	VST001171	RT00599	2	f
LOG0008394	USR0259	VST000458	RT00862	3	t
LOG0008395	USR0323	VST001437	RT00326	4	t
LOG0008396	USR0018	VST003572	RT00684	2	f
LOG0008397	USR0301	VST002149	RT00764	3	f
LOG0008398	USR0353	VST004243	RT00356	2	t
LOG0008399	USR0485	VST004813	RT00468	1	f
LOG0008400	USR0092	VST000507	RT00656	2	t
LOG0008401	USR0164	VST002606	RT00284	4	t
LOG0008402	USR0144	VST002384	RT00185	1	f
LOG0008403	USR0335	VST000446	RT00154	2	t
LOG0008404	USR0413	VST002782	RT00854	4	t
LOG0008405	USR0315	VST000444	RT00118	3	t
LOG0008406	USR0402	VST000118	RT00267	2	t
LOG0008407	USR0433	VST001541	RT00385	2	t
LOG0008408	USR0238	VST002771	RT00837	3	t
LOG0008409	USR0174	VST000567	RT00255	3	t
LOG0008410	USR0083	VST003603	RT00241	2	f
LOG0008411	USR0157	VST001937	RT00171	4	f
LOG0008412	USR0454	VST004184	RT00942	3	t
LOG0008413	USR0109	VST001653	RT00617	3	t
LOG0008414	USR0178	VST004572	RT00548	4	f
LOG0008415	USR0250	VST004391	RT00578	2	t
LOG0008416	USR0495	VST004816	RT00185	1	f
LOG0008417	USR0253	VST004782	RT00902	2	f
LOG0008418	USR0055	VST002687	RT00702	2	f
LOG0008419	USR0155	VST001204	RT00667	1	t
LOG0008420	USR0391	VST002938	RT00893	2	t
LOG0008421	USR0091	VST000406	RT00410	2	f
LOG0008422	USR0339	VST003908	RT00739	3	f
LOG0008423	USR0126	VST004215	RT00653	4	t
LOG0008424	USR0337	VST004080	RT00588	2	t
LOG0008425	USR0169	VST000313	RT00146	1	f
LOG0008426	USR0139	VST000163	RT00038	1	f
LOG0008427	USR0005	VST001529	RT00490	3	f
LOG0008428	USR0066	VST004389	RT00262	2	t
LOG0008429	USR0111	VST004786	RT00126	2	t
LOG0008430	USR0184	VST001566	RT00604	2	f
LOG0008431	USR0268	VST004769	RT00796	2	t
LOG0008432	USR0170	VST000399	RT00345	1	t
LOG0008433	USR0362	VST003587	RT00261	1	f
LOG0008434	USR0244	VST001048	RT00443	3	t
LOG0008435	USR0331	VST001943	RT00975	2	t
LOG0008436	USR0138	VST003131	RT00879	1	f
LOG0008437	USR0028	VST002797	RT00108	2	f
LOG0008438	USR0007	VST000240	RT00969	4	t
LOG0008439	USR0398	VST002359	RT00557	4	t
LOG0008440	USR0333	VST000672	RT00880	1	f
LOG0008441	USR0453	VST002620	RT00437	4	t
LOG0008442	USR0317	VST002462	RT00514	4	f
LOG0008443	USR0051	VST003394	RT00945	1	f
LOG0008444	USR0426	VST000402	RT00713	3	f
LOG0008445	USR0136	VST002107	RT00090	4	t
LOG0008446	USR0178	VST004149	RT00215	2	f
LOG0008447	USR0129	VST001088	RT00627	4	t
LOG0008448	USR0197	VST001143	RT00319	3	f
LOG0008449	USR0267	VST004382	RT00604	3	f
LOG0008450	USR0500	VST002066	RT00838	3	t
LOG0008451	USR0107	VST003909	RT00698	3	f
LOG0008452	USR0048	VST004256	RT00772	3	f
LOG0008453	USR0138	VST003960	RT00670	4	t
LOG0008454	USR0399	VST000142	RT00057	4	t
LOG0008455	USR0103	VST000397	RT00559	4	f
LOG0008456	USR0047	VST002628	RT00402	4	f
LOG0008457	USR0477	VST004630	RT00222	3	t
LOG0008458	USR0153	VST001556	RT00475	3	f
LOG0008459	USR0368	VST002509	RT00108	2	f
LOG0008460	USR0006	VST004382	RT00863	4	f
LOG0008461	USR0011	VST001029	RT00812	3	t
LOG0008462	USR0017	VST002177	RT00180	2	t
LOG0008463	USR0143	VST000671	RT00177	2	t
LOG0008464	USR0272	VST004595	RT00487	1	t
LOG0008465	USR0312	VST001856	RT00414	4	f
LOG0008466	USR0066	VST003430	RT00692	3	t
LOG0008467	USR0420	VST002079	RT00037	4	t
LOG0008468	USR0339	VST002007	RT00575	2	t
LOG0008469	USR0422	VST001689	RT00268	4	t
LOG0008470	USR0498	VST004432	RT00785	1	f
LOG0008471	USR0469	VST000570	RT00802	1	t
LOG0008472	USR0331	VST004695	RT00924	3	t
LOG0008473	USR0256	VST001147	RT00388	3	f
LOG0008474	USR0489	VST003775	RT00354	3	f
LOG0008475	USR0127	VST000865	RT00814	3	t
LOG0008476	USR0131	VST004901	RT00270	4	t
LOG0008477	USR0482	VST004410	RT00269	4	t
LOG0008478	USR0018	VST000028	RT00442	2	f
LOG0008479	USR0207	VST001030	RT00305	2	t
LOG0008480	USR0089	VST001997	RT00246	3	f
LOG0008481	USR0438	VST001342	RT00178	4	f
LOG0008482	USR0498	VST001249	RT00067	3	f
LOG0008483	USR0243	VST002137	RT00277	2	f
LOG0008484	USR0463	VST002088	RT00208	4	t
LOG0008485	USR0350	VST000681	RT00307	3	f
LOG0008486	USR0017	VST000375	RT00550	1	t
LOG0008487	USR0466	VST003370	RT00631	2	f
LOG0008488	USR0223	VST003046	RT00538	1	t
LOG0008489	USR0370	VST002338	RT00518	1	t
LOG0008490	USR0363	VST000806	RT00274	4	t
LOG0008491	USR0210	VST003040	RT00233	1	f
LOG0008492	USR0099	VST000279	RT00114	1	f
LOG0008493	USR0013	VST001406	RT00134	3	t
LOG0008494	USR0319	VST000788	RT00425	4	f
LOG0008495	USR0270	VST001333	RT00825	3	t
LOG0008496	USR0187	VST004373	RT00690	3	f
LOG0008497	USR0420	VST003148	RT00025	3	f
LOG0008498	USR0274	VST002346	RT00560	4	f
LOG0008499	USR0133	VST003450	RT00280	2	t
LOG0008500	USR0014	VST000433	RT00926	4	t
LOG0008501	USR0281	VST001010	RT00343	3	f
LOG0008502	USR0044	VST003850	RT00813	2	t
LOG0008503	USR0377	VST000317	RT00811	1	f
LOG0008504	USR0295	VST004217	RT00072	2	t
LOG0008505	USR0396	VST001366	RT00952	4	t
LOG0008506	USR0104	VST004400	RT00201	3	t
LOG0008507	USR0445	VST000936	RT00326	1	f
LOG0008508	USR0062	VST003519	RT00033	1	t
LOG0008509	USR0053	VST003788	RT00097	3	f
LOG0008510	USR0309	VST002769	RT00557	1	f
LOG0008511	USR0412	VST000496	RT00263	1	f
LOG0008512	USR0419	VST003593	RT00874	1	t
LOG0008513	USR0118	VST002233	RT00914	4	t
LOG0008514	USR0321	VST004019	RT00070	2	f
LOG0008515	USR0131	VST002936	RT00813	4	t
LOG0008516	USR0299	VST004809	RT00293	1	f
LOG0008517	USR0306	VST004446	RT00917	4	f
LOG0008518	USR0199	VST002368	RT00730	1	f
LOG0008519	USR0393	VST002585	RT00207	4	t
LOG0008520	USR0036	VST000906	RT00172	2	t
LOG0008521	USR0279	VST003228	RT00758	3	t
LOG0008522	USR0216	VST001828	RT00926	2	f
LOG0008523	USR0074	VST003723	RT00395	4	t
LOG0008524	USR0306	VST002581	RT00256	4	f
LOG0008525	USR0055	VST004598	RT00264	2	f
LOG0008526	USR0496	VST001516	RT00901	4	t
LOG0008527	USR0381	VST004623	RT00264	3	t
LOG0008528	USR0012	VST004807	RT00517	3	f
LOG0008529	USR0083	VST003004	RT00010	2	f
LOG0008530	USR0032	VST000112	RT00271	1	t
LOG0008531	USR0408	VST001673	RT00742	3	t
LOG0008532	USR0086	VST002303	RT00312	4	f
LOG0008533	USR0451	VST001651	RT00370	1	t
LOG0008534	USR0232	VST004396	RT00567	3	t
LOG0008535	USR0411	VST002475	RT00899	1	f
LOG0008536	USR0445	VST003996	RT00553	4	t
LOG0008537	USR0275	VST001891	RT00650	2	f
LOG0008538	USR0201	VST000307	RT00391	2	t
LOG0008539	USR0051	VST000121	RT00959	4	f
LOG0008540	USR0320	VST003102	RT00115	2	f
LOG0008541	USR0256	VST001278	RT00575	4	t
LOG0008542	USR0241	VST001428	RT00344	2	t
LOG0008543	USR0205	VST003103	RT00410	3	t
LOG0008544	USR0386	VST001186	RT00546	2	t
LOG0008545	USR0420	VST001456	RT00378	1	f
LOG0008546	USR0477	VST001180	RT00764	2	t
LOG0008547	USR0384	VST001347	RT00456	2	t
LOG0008548	USR0395	VST000629	RT00423	2	f
LOG0008549	USR0482	VST001215	RT00444	2	f
LOG0008550	USR0196	VST001962	RT00197	3	f
LOG0008551	USR0452	VST002996	RT00868	4	t
LOG0008552	USR0244	VST004613	RT00363	3	f
LOG0008553	USR0320	VST004941	RT00410	3	t
LOG0008554	USR0001	VST001548	RT00764	1	f
LOG0008555	USR0089	VST004916	RT00574	4	t
LOG0008556	USR0282	VST002859	RT00394	4	f
LOG0008557	USR0139	VST000762	RT00737	1	f
LOG0008558	USR0087	VST002367	RT00509	4	t
LOG0008559	USR0002	VST004207	RT00868	2	t
LOG0008560	USR0467	VST001842	RT00566	4	t
LOG0008561	USR0349	VST004903	RT00671	1	f
LOG0008562	USR0168	VST001497	RT00294	1	t
LOG0008563	USR0119	VST003920	RT00882	1	f
LOG0008564	USR0500	VST003089	RT00025	1	t
LOG0008565	USR0388	VST001244	RT00237	3	t
LOG0008566	USR0080	VST004583	RT00461	4	f
LOG0008567	USR0111	VST004907	RT00321	3	f
LOG0008568	USR0165	VST002044	RT00100	1	t
LOG0008569	USR0382	VST003377	RT00740	1	f
LOG0008570	USR0445	VST000517	RT00690	3	t
LOG0008571	USR0219	VST000835	RT00408	2	t
LOG0008572	USR0005	VST000624	RT00155	4	t
LOG0008573	USR0399	VST001048	RT00978	3	t
LOG0008574	USR0215	VST001565	RT00434	4	t
LOG0008575	USR0497	VST003983	RT00751	1	t
LOG0008576	USR0195	VST000497	RT00434	1	t
LOG0008577	USR0466	VST002430	RT00143	1	t
LOG0008578	USR0491	VST002264	RT00529	4	t
LOG0008579	USR0282	VST000543	RT00285	4	t
LOG0008580	USR0006	VST000916	RT00005	3	t
LOG0008581	USR0379	VST001802	RT00523	1	f
LOG0008582	USR0300	VST003083	RT00720	3	f
LOG0008583	USR0058	VST000082	RT00436	2	t
LOG0008584	USR0337	VST001180	RT00418	1	t
LOG0008585	USR0302	VST000166	RT00081	1	t
LOG0008586	USR0102	VST002256	RT00545	2	t
LOG0008587	USR0426	VST002072	RT00817	3	f
LOG0008588	USR0048	VST000807	RT00377	4	f
LOG0008589	USR0370	VST002739	RT00159	1	f
LOG0008590	USR0411	VST000332	RT00786	4	t
LOG0008591	USR0276	VST003591	RT00627	1	f
LOG0008592	USR0454	VST001535	RT00217	1	f
LOG0008593	USR0371	VST000181	RT00773	4	f
LOG0008594	USR0163	VST001317	RT00670	1	f
LOG0008595	USR0332	VST001107	RT00045	2	f
LOG0008596	USR0432	VST001590	RT00632	3	t
LOG0008597	USR0451	VST002487	RT00215	2	f
LOG0008598	USR0496	VST002591	RT00511	3	f
LOG0008599	USR0196	VST002241	RT00128	2	f
LOG0008600	USR0377	VST000488	RT00254	2	t
LOG0008601	USR0436	VST000612	RT00550	3	f
LOG0008602	USR0365	VST003421	RT00877	1	f
LOG0008603	USR0324	VST003195	RT00722	4	t
LOG0008604	USR0132	VST001398	RT00352	4	t
LOG0008605	USR0423	VST001457	RT00606	4	f
LOG0008606	USR0405	VST002194	RT00541	1	f
LOG0008607	USR0492	VST003075	RT00164	2	f
LOG0008608	USR0066	VST001338	RT00649	2	t
LOG0008609	USR0400	VST004423	RT00535	2	t
LOG0008610	USR0391	VST002201	RT00131	1	f
LOG0008611	USR0083	VST004498	RT00598	3	f
LOG0008612	USR0491	VST002868	RT00696	1	f
LOG0008613	USR0481	VST004584	RT00504	4	f
LOG0008614	USR0265	VST003883	RT00424	2	f
LOG0008615	USR0229	VST002115	RT00749	1	f
LOG0008616	USR0273	VST002137	RT00184	1	f
LOG0008617	USR0219	VST000079	RT00826	1	f
LOG0008618	USR0225	VST000378	RT00671	3	t
LOG0008619	USR0113	VST000165	RT00982	2	f
LOG0008620	USR0140	VST004845	RT00523	1	f
LOG0008621	USR0185	VST001721	RT00554	1	t
LOG0008622	USR0173	VST002985	RT00235	4	t
LOG0008623	USR0376	VST000155	RT00131	2	t
LOG0008624	USR0011	VST001147	RT00697	1	f
LOG0008625	USR0397	VST001064	RT00014	1	f
LOG0008626	USR0159	VST002217	RT00814	1	f
LOG0008627	USR0205	VST002840	RT00766	1	t
LOG0008628	USR0230	VST001464	RT00659	2	f
LOG0008629	USR0026	VST003471	RT00380	1	f
LOG0008630	USR0319	VST001517	RT00060	3	f
LOG0008631	USR0159	VST003051	RT00927	1	f
LOG0008632	USR0278	VST004424	RT00292	3	t
LOG0008633	USR0390	VST001527	RT00160	2	f
LOG0008634	USR0148	VST003611	RT00447	1	f
LOG0008635	USR0469	VST002393	RT00538	4	f
LOG0008636	USR0266	VST000789	RT00577	3	f
LOG0008637	USR0083	VST002549	RT00386	3	t
LOG0008638	USR0419	VST004658	RT00070	1	f
LOG0008639	USR0026	VST004609	RT00382	4	t
LOG0008640	USR0071	VST000516	RT00685	4	f
LOG0008641	USR0037	VST003063	RT00974	1	f
LOG0008642	USR0392	VST004763	RT00988	2	t
LOG0008643	USR0133	VST001568	RT00225	2	t
LOG0008644	USR0428	VST001449	RT00508	1	f
LOG0008645	USR0484	VST000967	RT00665	2	t
LOG0008646	USR0126	VST000364	RT00040	4	f
LOG0008647	USR0115	VST000108	RT00146	2	f
LOG0008648	USR0092	VST003095	RT00366	2	t
LOG0008649	USR0242	VST000623	RT00610	2	f
LOG0008650	USR0451	VST004417	RT00248	1	f
LOG0008651	USR0487	VST000510	RT00012	1	t
LOG0008652	USR0200	VST001065	RT00987	3	t
LOG0008653	USR0207	VST003866	RT00536	2	f
LOG0008654	USR0117	VST000304	RT00737	1	f
LOG0008655	USR0219	VST000969	RT00510	4	f
LOG0008656	USR0305	VST001439	RT00245	3	t
LOG0008657	USR0243	VST003522	RT00975	4	f
LOG0008658	USR0292	VST003872	RT00171	2	f
LOG0008659	USR0464	VST003501	RT00032	4	t
LOG0008660	USR0282	VST002200	RT00626	3	f
LOG0008661	USR0301	VST004355	RT00721	2	t
LOG0008662	USR0317	VST003902	RT00995	1	t
LOG0008663	USR0172	VST002271	RT00815	4	f
LOG0008664	USR0388	VST000230	RT00429	4	t
LOG0008665	USR0076	VST002487	RT00035	3	f
LOG0008666	USR0209	VST000150	RT00205	1	f
LOG0008667	USR0314	VST000910	RT00890	2	t
LOG0008668	USR0105	VST003529	RT00384	2	t
LOG0008669	USR0492	VST000978	RT00905	2	t
LOG0008670	USR0026	VST000635	RT00266	3	f
LOG0008671	USR0351	VST004718	RT00577	4	f
LOG0008672	USR0079	VST002191	RT00443	4	t
LOG0008673	USR0500	VST004150	RT00610	4	f
LOG0008674	USR0482	VST004940	RT00697	4	t
LOG0008675	USR0128	VST003475	RT00750	3	f
LOG0008676	USR0413	VST003781	RT00485	3	f
LOG0008677	USR0137	VST001866	RT00985	1	f
LOG0008678	USR0334	VST000299	RT00470	3	f
LOG0008679	USR0036	VST002740	RT00266	4	t
LOG0008680	USR0388	VST003726	RT00986	2	f
LOG0008681	USR0059	VST003392	RT00915	1	t
LOG0008682	USR0230	VST004541	RT00744	2	f
LOG0008683	USR0421	VST000098	RT00109	2	f
LOG0008684	USR0124	VST003198	RT00489	4	t
LOG0008685	USR0088	VST002106	RT00178	3	f
LOG0008686	USR0337	VST004273	RT00249	3	t
LOG0008687	USR0141	VST004815	RT00836	3	f
LOG0008688	USR0404	VST003523	RT00872	4	f
LOG0008689	USR0273	VST004419	RT00005	4	f
LOG0008690	USR0051	VST000846	RT00157	2	t
LOG0008691	USR0475	VST004186	RT00230	1	f
LOG0008692	USR0055	VST004227	RT00628	3	t
LOG0008693	USR0417	VST003882	RT00261	3	f
LOG0008694	USR0405	VST001053	RT00828	1	t
LOG0008695	USR0337	VST003849	RT00321	2	t
LOG0008696	USR0150	VST003616	RT00127	2	t
LOG0008697	USR0153	VST003158	RT00028	1	t
LOG0008698	USR0451	VST002106	RT00851	3	f
LOG0008699	USR0219	VST000994	RT00510	4	t
LOG0008700	USR0219	VST003097	RT00228	4	t
LOG0008701	USR0366	VST000190	RT00641	1	f
LOG0008702	USR0396	VST002124	RT00541	3	t
LOG0008703	USR0399	VST002419	RT00179	1	f
LOG0008704	USR0486	VST004995	RT00676	2	f
LOG0008705	USR0468	VST002899	RT00672	2	f
LOG0008706	USR0342	VST004602	RT00832	4	f
LOG0008707	USR0258	VST001967	RT00910	2	t
LOG0008708	USR0388	VST004279	RT00288	2	f
LOG0008709	USR0045	VST004250	RT00494	1	t
LOG0008710	USR0269	VST003412	RT00265	1	f
LOG0008711	USR0311	VST003947	RT00467	3	t
LOG0008712	USR0160	VST001047	RT00395	1	f
LOG0008713	USR0278	VST002574	RT00432	3	t
LOG0008714	USR0345	VST000606	RT00435	4	f
LOG0008715	USR0475	VST001367	RT00388	1	t
LOG0008716	USR0055	VST002927	RT00809	1	t
LOG0008717	USR0145	VST001959	RT00537	1	t
LOG0008718	USR0454	VST001065	RT00145	4	f
LOG0008719	USR0235	VST000518	RT00175	1	t
LOG0008720	USR0179	VST002455	RT00520	2	t
LOG0008721	USR0208	VST004234	RT00314	1	t
LOG0008722	USR0136	VST003808	RT00621	3	f
LOG0008723	USR0445	VST002590	RT00129	2	f
LOG0008724	USR0353	VST002273	RT00514	1	t
LOG0008725	USR0394	VST002309	RT00010	1	t
LOG0008726	USR0482	VST001103	RT00347	4	t
LOG0008727	USR0275	VST004793	RT00117	3	t
LOG0008728	USR0384	VST000811	RT00411	2	t
LOG0008729	USR0398	VST003764	RT00397	2	f
LOG0008730	USR0323	VST004569	RT00831	4	f
LOG0008731	USR0183	VST000077	RT00011	2	f
LOG0008732	USR0061	VST002310	RT00398	2	f
LOG0008733	USR0440	VST001026	RT00608	3	f
LOG0008734	USR0063	VST002065	RT00976	1	f
LOG0008735	USR0361	VST004440	RT00892	1	t
LOG0008736	USR0215	VST002742	RT00093	2	f
LOG0008737	USR0360	VST004942	RT00102	3	t
LOG0008738	USR0139	VST004000	RT00098	4	f
LOG0008739	USR0431	VST003229	RT00282	1	t
LOG0008740	USR0134	VST004270	RT00965	2	t
LOG0008741	USR0034	VST003559	RT00979	2	t
LOG0008742	USR0193	VST000846	RT00807	3	t
LOG0008743	USR0355	VST000693	RT00860	3	f
LOG0008744	USR0473	VST004049	RT00668	3	f
LOG0008745	USR0320	VST001333	RT00657	2	t
LOG0008746	USR0477	VST003038	RT00421	3	t
LOG0008747	USR0087	VST004333	RT00364	2	t
LOG0008748	USR0210	VST001275	RT00211	1	t
LOG0008749	USR0462	VST001245	RT00667	2	f
LOG0008750	USR0081	VST000338	RT00754	2	f
LOG0008751	USR0322	VST003295	RT00508	1	t
LOG0008752	USR0415	VST000337	RT00076	3	t
LOG0008753	USR0339	VST001868	RT00323	3	t
LOG0008754	USR0480	VST004006	RT00890	2	t
LOG0008755	USR0190	VST000495	RT00452	2	t
LOG0008756	USR0438	VST004643	RT00687	1	t
LOG0008757	USR0348	VST003887	RT00623	3	f
LOG0008758	USR0233	VST000161	RT00971	1	t
LOG0008759	USR0392	VST002037	RT00930	2	t
LOG0008760	USR0426	VST001742	RT00018	2	t
LOG0008761	USR0169	VST001508	RT00291	1	t
LOG0008762	USR0443	VST003561	RT00786	1	t
LOG0008763	USR0251	VST001376	RT00750	4	t
LOG0008764	USR0168	VST001554	RT00198	4	t
LOG0008765	USR0231	VST002282	RT00162	3	f
LOG0008766	USR0150	VST001869	RT00417	1	t
LOG0008767	USR0152	VST001602	RT00384	3	f
LOG0008768	USR0038	VST003828	RT00200	4	t
LOG0008769	USR0386	VST003481	RT00746	3	f
LOG0008770	USR0381	VST001300	RT00895	4	f
LOG0008771	USR0297	VST000711	RT00852	1	f
LOG0008772	USR0489	VST004168	RT00498	1	f
LOG0008773	USR0275	VST002047	RT00980	3	t
LOG0008774	USR0105	VST002882	RT00043	1	f
LOG0008775	USR0386	VST001818	RT00082	3	t
LOG0008776	USR0348	VST002199	RT00539	3	t
LOG0008777	USR0352	VST003333	RT00304	4	t
LOG0008778	USR0062	VST001104	RT00581	2	t
LOG0008779	USR0467	VST003178	RT00199	3	f
LOG0008780	USR0016	VST003595	RT00406	4	t
LOG0008781	USR0350	VST003475	RT00930	4	f
LOG0008782	USR0150	VST004816	RT00427	4	f
LOG0008783	USR0142	VST002178	RT00461	2	t
LOG0008784	USR0116	VST001195	RT00884	1	t
LOG0008785	USR0312	VST004502	RT00480	3	f
LOG0008786	USR0065	VST000536	RT00728	3	f
LOG0008787	USR0429	VST001070	RT00124	1	f
LOG0008788	USR0310	VST004370	RT00528	1	t
LOG0008789	USR0194	VST000133	RT00638	4	f
LOG0008790	USR0342	VST000264	RT00526	4	t
LOG0008791	USR0430	VST004463	RT00039	1	f
LOG0008792	USR0161	VST002053	RT00199	3	f
LOG0008793	USR0463	VST004947	RT00108	1	t
LOG0008794	USR0306	VST004090	RT00268	1	f
LOG0008795	USR0361	VST002848	RT00980	2	t
LOG0008796	USR0278	VST000358	RT00353	2	f
LOG0008797	USR0296	VST004421	RT00311	4	t
LOG0008798	USR0039	VST000751	RT00390	4	t
LOG0008799	USR0361	VST003251	RT00040	3	t
LOG0008800	USR0169	VST004352	RT00859	1	f
LOG0008801	USR0459	VST002259	RT00781	1	t
LOG0008802	USR0068	VST000911	RT00581	2	t
LOG0008803	USR0007	VST003811	RT00152	3	f
LOG0008804	USR0085	VST000584	RT00970	1	t
LOG0008805	USR0199	VST003439	RT00187	3	t
LOG0008806	USR0132	VST000577	RT00430	2	f
LOG0008807	USR0076	VST002577	RT00864	1	f
LOG0008808	USR0250	VST001872	RT00457	2	t
LOG0008809	USR0347	VST001153	RT00753	2	f
LOG0008810	USR0443	VST004991	RT00227	2	f
LOG0008811	USR0209	VST001784	RT00428	1	t
LOG0008812	USR0084	VST001094	RT00204	3	f
LOG0008813	USR0223	VST002100	RT00779	1	f
LOG0008814	USR0253	VST004533	RT00118	2	t
LOG0008815	USR0410	VST002142	RT00829	4	f
LOG0008816	USR0031	VST002134	RT00804	3	t
LOG0008817	USR0355	VST000518	RT00968	4	t
LOG0008818	USR0201	VST000742	RT00394	2	f
LOG0008819	USR0453	VST002478	RT00974	1	t
LOG0008820	USR0052	VST004959	RT00222	3	f
LOG0008821	USR0368	VST002877	RT00897	4	t
LOG0008822	USR0072	VST000043	RT00063	1	t
LOG0008823	USR0021	VST003442	RT00396	3	f
LOG0008824	USR0016	VST000404	RT00005	2	f
LOG0008825	USR0435	VST001327	RT00334	2	t
LOG0008826	USR0016	VST002217	RT00292	2	t
LOG0008827	USR0402	VST002150	RT00508	1	t
LOG0008828	USR0175	VST002394	RT00145	1	f
LOG0008829	USR0312	VST002651	RT00954	2	f
LOG0008830	USR0412	VST004538	RT00662	2	f
LOG0008831	USR0338	VST004346	RT00159	3	t
LOG0008832	USR0078	VST000878	RT00922	4	f
LOG0008833	USR0440	VST001887	RT00781	3	f
LOG0008834	USR0240	VST001304	RT00959	4	f
LOG0008835	USR0037	VST001741	RT00963	1	t
LOG0008836	USR0232	VST001113	RT00831	3	f
LOG0008837	USR0400	VST003877	RT00011	1	t
LOG0008838	USR0213	VST001899	RT00069	1	f
LOG0008839	USR0193	VST000248	RT00704	4	f
LOG0008840	USR0060	VST003261	RT00614	4	f
LOG0008841	USR0189	VST000568	RT00964	3	f
LOG0008842	USR0267	VST003810	RT00544	3	t
LOG0008843	USR0126	VST001189	RT00202	3	t
LOG0008844	USR0203	VST002596	RT00266	4	t
LOG0008845	USR0322	VST001354	RT00108	2	f
LOG0008846	USR0382	VST003613	RT00054	2	t
LOG0008847	USR0032	VST000981	RT00951	4	t
LOG0008848	USR0403	VST004966	RT00338	3	t
LOG0008849	USR0312	VST000169	RT00190	2	t
LOG0008850	USR0261	VST003165	RT00239	1	f
LOG0008851	USR0387	VST002672	RT00951	2	f
LOG0008852	USR0412	VST000379	RT00343	2	t
LOG0008853	USR0346	VST001933	RT00850	4	t
LOG0008854	USR0471	VST000194	RT00291	4	f
LOG0008855	USR0094	VST000264	RT00323	2	t
LOG0008856	USR0328	VST001472	RT00321	1	t
LOG0008857	USR0100	VST002016	RT00785	1	t
LOG0008858	USR0285	VST004617	RT00042	3	f
LOG0008859	USR0461	VST001301	RT00955	2	f
LOG0008860	USR0315	VST003201	RT00198	2	f
LOG0008861	USR0025	VST003374	RT00889	1	t
LOG0008862	USR0406	VST000574	RT00633	4	t
LOG0008863	USR0494	VST001538	RT00907	2	t
LOG0008864	USR0353	VST001384	RT00846	1	t
LOG0008865	USR0357	VST001381	RT00284	2	f
LOG0008866	USR0117	VST003538	RT00807	4	f
LOG0008867	USR0199	VST003160	RT00182	3	f
LOG0008868	USR0279	VST001524	RT00612	4	f
LOG0008869	USR0070	VST004992	RT00011	4	f
LOG0008870	USR0335	VST004613	RT00883	1	t
LOG0008871	USR0079	VST003933	RT00745	1	f
LOG0008872	USR0424	VST003623	RT00442	4	t
LOG0008873	USR0354	VST000896	RT00629	1	t
LOG0008874	USR0014	VST003394	RT00424	4	t
LOG0008875	USR0029	VST000465	RT00500	4	f
LOG0008876	USR0144	VST001611	RT00388	2	f
LOG0008877	USR0477	VST000613	RT00576	4	f
LOG0008878	USR0343	VST003213	RT00688	3	f
LOG0008879	USR0010	VST000605	RT00454	1	t
LOG0008880	USR0047	VST000621	RT00998	3	f
LOG0008881	USR0260	VST002603	RT00595	1	t
LOG0008882	USR0012	VST002184	RT00927	4	t
LOG0008883	USR0298	VST003801	RT00002	3	t
LOG0008884	USR0226	VST000156	RT00811	2	f
LOG0008885	USR0260	VST003354	RT00729	4	t
LOG0008886	USR0084	VST003912	RT00242	4	f
LOG0008887	USR0348	VST002918	RT00809	4	f
LOG0008888	USR0348	VST003118	RT00060	2	t
LOG0008889	USR0006	VST002716	RT00368	3	t
LOG0008890	USR0398	VST004340	RT00715	4	f
LOG0008891	USR0247	VST000450	RT00942	3	f
LOG0008892	USR0035	VST004850	RT00040	4	t
LOG0008893	USR0175	VST004502	RT00315	4	f
LOG0008894	USR0442	VST003962	RT00557	4	f
LOG0008895	USR0065	VST001070	RT00298	2	f
LOG0008896	USR0147	VST004018	RT00631	4	f
LOG0008897	USR0057	VST004845	RT00917	3	t
LOG0008898	USR0193	VST003592	RT00643	4	f
LOG0008899	USR0013	VST002820	RT00450	3	t
LOG0008900	USR0392	VST002286	RT00395	3	f
LOG0008901	USR0018	VST002036	RT00792	1	f
LOG0008902	USR0246	VST001191	RT00562	3	f
LOG0008903	USR0163	VST001400	RT00088	1	f
LOG0008904	USR0343	VST003741	RT00533	2	f
LOG0008905	USR0114	VST002249	RT00921	4	t
LOG0008906	USR0500	VST002794	RT00388	2	f
LOG0008907	USR0282	VST000724	RT00744	2	f
LOG0008908	USR0233	VST001442	RT00381	3	f
LOG0008909	USR0166	VST004821	RT00555	4	t
LOG0008910	USR0468	VST000087	RT00431	4	f
LOG0008911	USR0322	VST004150	RT00535	2	t
LOG0008912	USR0026	VST001752	RT00956	1	f
LOG0008913	USR0126	VST003421	RT00216	1	t
LOG0008914	USR0313	VST004838	RT00277	3	t
LOG0008915	USR0484	VST002484	RT00194	1	t
LOG0008916	USR0281	VST003213	RT00727	1	t
LOG0008917	USR0286	VST003923	RT00179	2	f
LOG0008918	USR0466	VST002490	RT00143	1	t
LOG0008919	USR0391	VST001487	RT00826	4	f
LOG0008920	USR0283	VST003528	RT00538	2	t
LOG0008921	USR0139	VST000073	RT00218	2	t
LOG0008922	USR0101	VST000725	RT00511	1	t
LOG0008923	USR0392	VST003755	RT00988	4	t
LOG0008924	USR0011	VST002996	RT00059	4	t
LOG0008925	USR0382	VST004366	RT00346	1	f
LOG0008926	USR0216	VST000219	RT00557	4	t
LOG0008927	USR0030	VST000547	RT00962	3	f
LOG0008928	USR0094	VST003730	RT00419	3	t
LOG0008929	USR0116	VST001969	RT00224	1	t
LOG0008930	USR0500	VST004517	RT00350	2	t
LOG0008931	USR0271	VST001260	RT00768	2	t
LOG0008932	USR0440	VST002934	RT00622	4	f
LOG0008933	USR0291	VST002510	RT00832	3	t
LOG0008934	USR0039	VST004009	RT00852	2	f
LOG0008935	USR0024	VST004073	RT00762	4	f
LOG0008936	USR0264	VST004681	RT00077	3	f
LOG0008937	USR0043	VST001563	RT00795	2	f
LOG0008938	USR0170	VST002086	RT00599	4	f
LOG0008939	USR0340	VST001790	RT00762	1	f
LOG0008940	USR0169	VST003670	RT00208	1	t
LOG0008941	USR0303	VST002482	RT00159	2	f
LOG0008942	USR0026	VST003431	RT00524	4	f
LOG0008943	USR0180	VST000205	RT00225	3	f
LOG0008944	USR0472	VST000742	RT00358	1	f
LOG0008945	USR0150	VST002889	RT00813	3	f
LOG0008946	USR0133	VST003495	RT00384	4	f
LOG0008947	USR0143	VST004264	RT00544	1	t
LOG0008948	USR0164	VST004738	RT00566	2	t
LOG0008949	USR0101	VST001106	RT00504	1	f
LOG0008950	USR0063	VST001824	RT00450	2	f
LOG0008951	USR0093	VST002648	RT00242	3	t
LOG0008952	USR0207	VST004198	RT00369	1	f
LOG0008953	USR0475	VST000089	RT00627	4	t
LOG0008954	USR0433	VST003382	RT00471	3	t
LOG0008955	USR0311	VST004704	RT00288	3	t
LOG0008956	USR0072	VST003512	RT00399	2	f
LOG0008957	USR0060	VST002207	RT00104	4	t
LOG0008958	USR0441	VST003186	RT00311	3	t
LOG0008959	USR0029	VST004382	RT00809	1	f
LOG0008960	USR0019	VST000865	RT00127	2	f
LOG0008961	USR0479	VST000055	RT00040	4	t
LOG0008962	USR0073	VST004672	RT00072	2	f
LOG0008963	USR0394	VST002081	RT00747	2	f
LOG0008964	USR0357	VST000558	RT00882	3	t
LOG0008965	USR0394	VST004827	RT00945	1	f
LOG0008966	USR0246	VST000993	RT00982	1	t
LOG0008967	USR0481	VST004897	RT00247	4	f
LOG0008968	USR0473	VST004292	RT00806	4	t
LOG0008969	USR0313	VST000448	RT00247	1	f
LOG0008970	USR0438	VST001822	RT00312	2	t
LOG0008971	USR0440	VST003820	RT00034	2	f
LOG0008972	USR0324	VST002973	RT00129	1	t
LOG0008973	USR0453	VST000092	RT00010	3	f
LOG0008974	USR0087	VST000608	RT00168	2	f
LOG0008975	USR0359	VST001252	RT00784	1	t
LOG0008976	USR0183	VST000286	RT00216	3	f
LOG0008977	USR0197	VST002922	RT00942	2	t
LOG0008978	USR0244	VST003307	RT00408	4	f
LOG0008979	USR0328	VST000102	RT00752	2	f
LOG0008980	USR0465	VST003836	RT00526	2	t
LOG0008981	USR0385	VST004236	RT00602	1	f
LOG0008982	USR0118	VST004931	RT00935	2	t
LOG0008983	USR0498	VST001679	RT00018	2	f
LOG0008984	USR0396	VST003824	RT00340	3	t
LOG0008985	USR0419	VST000535	RT00681	1	f
LOG0008986	USR0372	VST000016	RT00568	3	f
LOG0008987	USR0462	VST000561	RT00676	4	t
LOG0008988	USR0496	VST002926	RT00664	2	f
LOG0008989	USR0082	VST002384	RT00090	1	f
LOG0008990	USR0458	VST000910	RT00285	4	t
LOG0008991	USR0247	VST001414	RT00534	1	f
LOG0008992	USR0463	VST000119	RT00267	2	t
LOG0008993	USR0234	VST004063	RT00809	1	f
LOG0008994	USR0417	VST003114	RT00433	1	f
LOG0008995	USR0467	VST003061	RT00758	3	t
LOG0008996	USR0482	VST001492	RT00651	1	t
LOG0008997	USR0365	VST002097	RT00052	1	f
LOG0008998	USR0153	VST002255	RT00067	3	t
LOG0008999	USR0272	VST000514	RT00597	2	f
LOG0009000	USR0392	VST001234	RT00250	4	f
LOG0009001	USR0035	VST004133	RT00331	3	t
LOG0009002	USR0213	VST001480	RT00904	2	t
LOG0009003	USR0211	VST003350	RT00415	2	t
LOG0009004	USR0430	VST001541	RT00123	4	t
LOG0009005	USR0139	VST000130	RT00202	2	f
LOG0009006	USR0189	VST003717	RT00006	3	f
LOG0009007	USR0300	VST003744	RT00849	2	t
LOG0009008	USR0395	VST001772	RT00486	4	f
LOG0009009	USR0252	VST004455	RT00199	4	t
LOG0009010	USR0395	VST003076	RT00736	3	f
LOG0009011	USR0150	VST000506	RT00013	3	t
LOG0009012	USR0341	VST004914	RT00006	2	f
LOG0009013	USR0219	VST004890	RT00963	4	f
LOG0009014	USR0082	VST000839	RT00411	4	t
LOG0009015	USR0190	VST003872	RT00121	2	f
LOG0009016	USR0234	VST004719	RT00557	4	t
LOG0009017	USR0176	VST002677	RT00362	3	t
LOG0009018	USR0232	VST000097	RT00538	3	f
LOG0009019	USR0358	VST001964	RT00004	2	f
LOG0009020	USR0478	VST002867	RT00805	2	f
LOG0009021	USR0063	VST004027	RT00789	2	t
LOG0009022	USR0435	VST000599	RT00284	3	f
LOG0009023	USR0429	VST002982	RT00722	3	f
LOG0009024	USR0495	VST003964	RT00800	4	t
LOG0009025	USR0237	VST000429	RT00359	3	f
LOG0009026	USR0033	VST003782	RT00693	2	f
LOG0009027	USR0213	VST001325	RT00765	1	f
LOG0009028	USR0060	VST002591	RT00929	1	f
LOG0009029	USR0379	VST002415	RT00282	1	f
LOG0009030	USR0002	VST001768	RT00657	1	f
LOG0009031	USR0397	VST001517	RT00952	1	t
LOG0009032	USR0450	VST001340	RT00628	3	f
LOG0009033	USR0057	VST004095	RT00349	2	f
LOG0009034	USR0427	VST004660	RT00980	2	f
LOG0009035	USR0301	VST003404	RT00030	4	t
LOG0009036	USR0287	VST002547	RT00889	2	t
LOG0009037	USR0138	VST000977	RT00754	4	f
LOG0009038	USR0279	VST001615	RT00517	2	t
LOG0009039	USR0214	VST001585	RT00374	4	t
LOG0009040	USR0239	VST004062	RT00774	4	t
LOG0009041	USR0285	VST004652	RT00618	2	f
LOG0009042	USR0481	VST001271	RT00124	1	t
LOG0009043	USR0031	VST000219	RT00446	2	f
LOG0009044	USR0206	VST000534	RT00394	2	t
LOG0009045	USR0458	VST001496	RT00838	1	t
LOG0009046	USR0274	VST001374	RT00650	2	t
LOG0009047	USR0011	VST004140	RT00618	4	f
LOG0009048	USR0359	VST003824	RT00725	1	f
LOG0009049	USR0047	VST003950	RT00812	1	t
LOG0009050	USR0003	VST000065	RT00056	3	t
LOG0009051	USR0130	VST004342	RT00132	4	f
LOG0009052	USR0438	VST003143	RT00781	4	t
LOG0009053	USR0072	VST001725	RT00122	2	f
LOG0009054	USR0159	VST002206	RT00202	2	f
LOG0009055	USR0392	VST002986	RT00720	4	t
LOG0009056	USR0427	VST003914	RT00787	4	t
LOG0009057	USR0432	VST001049	RT00966	4	f
LOG0009058	USR0130	VST003655	RT00602	2	t
LOG0009059	USR0022	VST002873	RT00702	4	t
LOG0009060	USR0380	VST004256	RT00265	4	t
LOG0009061	USR0389	VST001005	RT00558	1	f
LOG0009062	USR0135	VST002123	RT00824	4	f
LOG0009063	USR0020	VST004575	RT00842	3	f
LOG0009064	USR0220	VST003982	RT00040	2	f
LOG0009065	USR0333	VST004483	RT00579	1	f
LOG0009066	USR0130	VST000472	RT00113	4	f
LOG0009067	USR0032	VST003406	RT00339	4	f
LOG0009068	USR0090	VST000309	RT00062	1	f
LOG0009069	USR0259	VST002935	RT00227	1	f
LOG0009070	USR0425	VST004797	RT00174	1	f
LOG0009071	USR0298	VST003048	RT00134	3	t
LOG0009072	USR0333	VST001922	RT00285	3	f
LOG0009073	USR0249	VST003000	RT00787	1	f
LOG0009074	USR0469	VST002018	RT00626	4	t
LOG0009075	USR0173	VST004882	RT00108	2	f
LOG0009076	USR0357	VST001479	RT00143	3	f
LOG0009077	USR0471	VST002353	RT00569	2	t
LOG0009078	USR0455	VST004198	RT00294	2	f
LOG0009079	USR0401	VST004871	RT00277	3	t
LOG0009080	USR0476	VST003460	RT00492	2	f
LOG0009081	USR0384	VST003755	RT00563	4	f
LOG0009082	USR0047	VST001232	RT00935	3	t
LOG0009083	USR0478	VST003121	RT00471	3	f
LOG0009084	USR0197	VST000572	RT00276	2	t
LOG0009085	USR0408	VST003590	RT00234	2	f
LOG0009086	USR0455	VST000148	RT00242	1	t
LOG0009087	USR0379	VST003444	RT00258	3	t
LOG0009088	USR0034	VST000597	RT00749	2	f
LOG0009089	USR0254	VST001071	RT00032	4	f
LOG0009090	USR0248	VST003746	RT00367	3	f
LOG0009091	USR0434	VST004251	RT00348	1	t
LOG0009092	USR0042	VST004326	RT00760	4	t
LOG0009093	USR0289	VST003372	RT00132	1	f
LOG0009094	USR0123	VST000158	RT00775	1	t
LOG0009095	USR0027	VST000923	RT00771	4	t
LOG0009096	USR0462	VST003319	RT00793	1	t
LOG0009097	USR0059	VST002347	RT00368	1	t
LOG0009098	USR0147	VST004051	RT00762	1	t
LOG0009099	USR0496	VST001247	RT00265	1	f
LOG0009100	USR0115	VST000766	RT00215	1	f
LOG0009101	USR0486	VST003652	RT00215	3	t
LOG0009102	USR0460	VST002613	RT00282	2	f
LOG0009103	USR0387	VST004563	RT01000	3	t
LOG0009104	USR0199	VST003829	RT00832	3	t
LOG0009105	USR0128	VST004582	RT00530	2	f
LOG0009106	USR0376	VST000444	RT00984	2	t
LOG0009107	USR0483	VST000905	RT00859	4	f
LOG0009108	USR0153	VST002911	RT00002	1	f
LOG0009109	USR0369	VST003210	RT00513	2	f
LOG0009110	USR0271	VST001802	RT00816	4	f
LOG0009111	USR0339	VST000926	RT00464	4	t
LOG0009112	USR0444	VST003722	RT00447	3	t
LOG0009113	USR0083	VST004388	RT00363	4	t
LOG0009114	USR0023	VST000752	RT00216	1	t
LOG0009115	USR0011	VST001235	RT00164	3	t
LOG0009116	USR0187	VST002923	RT00703	2	f
LOG0009117	USR0469	VST000663	RT00587	3	t
LOG0009118	USR0116	VST003196	RT00538	3	f
LOG0009119	USR0162	VST001585	RT00511	1	t
LOG0009120	USR0103	VST000920	RT00774	1	t
LOG0009121	USR0243	VST004220	RT00794	3	f
LOG0009122	USR0007	VST000068	RT00221	2	t
LOG0009123	USR0362	VST004571	RT00555	1	t
LOG0009124	USR0172	VST004454	RT00634	3	f
LOG0009125	USR0256	VST001767	RT00641	1	f
LOG0009126	USR0247	VST001954	RT00777	1	t
LOG0009127	USR0475	VST002569	RT00283	4	t
LOG0009128	USR0192	VST003709	RT00071	2	f
LOG0009129	USR0114	VST004929	RT00885	3	t
LOG0009130	USR0023	VST002672	RT00374	3	f
LOG0009131	USR0358	VST003400	RT00259	4	f
LOG0009132	USR0314	VST001354	RT00445	3	t
LOG0009133	USR0276	VST000443	RT00201	3	f
LOG0009134	USR0411	VST000601	RT00642	4	t
LOG0009135	USR0373	VST003167	RT00380	4	t
LOG0009136	USR0444	VST003943	RT00842	3	f
LOG0009137	USR0136	VST002810	RT00593	4	t
LOG0009138	USR0357	VST003389	RT00766	1	t
LOG0009139	USR0195	VST004583	RT00415	1	t
LOG0009140	USR0258	VST002787	RT00065	1	f
LOG0009141	USR0278	VST002696	RT00378	1	f
LOG0009142	USR0070	VST003649	RT00658	4	t
LOG0009143	USR0359	VST002053	RT00646	2	t
LOG0009144	USR0360	VST000632	RT00102	2	f
LOG0009145	USR0036	VST003443	RT00042	3	f
LOG0009146	USR0108	VST001755	RT00879	2	t
LOG0009147	USR0024	VST003034	RT00196	1	t
LOG0009148	USR0140	VST001579	RT00360	4	t
LOG0009149	USR0465	VST000026	RT00772	1	f
LOG0009150	USR0022	VST002210	RT00099	1	f
LOG0009151	USR0339	VST002903	RT00388	4	f
LOG0009152	USR0329	VST001130	RT00065	1	t
LOG0009153	USR0204	VST004997	RT00297	1	f
LOG0009154	USR0380	VST004105	RT00427	4	t
LOG0009155	USR0224	VST004146	RT00223	4	f
LOG0009156	USR0223	VST000442	RT00757	3	f
LOG0009157	USR0081	VST003896	RT00695	3	t
LOG0009158	USR0407	VST004798	RT00915	1	f
LOG0009159	USR0330	VST004850	RT00149	3	t
LOG0009160	USR0191	VST001829	RT00509	2	f
LOG0009161	USR0286	VST001536	RT00442	2	f
LOG0009162	USR0147	VST004326	RT00414	1	f
LOG0009163	USR0282	VST000560	RT00116	3	t
LOG0009164	USR0474	VST001174	RT00903	1	f
LOG0009165	USR0384	VST001879	RT00453	3	f
LOG0009166	USR0011	VST002256	RT00320	4	t
LOG0009167	USR0276	VST001085	RT00770	4	f
LOG0009168	USR0374	VST003915	RT00883	4	f
LOG0009169	USR0056	VST000239	RT00451	4	t
LOG0009170	USR0173	VST002915	RT00896	1	f
LOG0009171	USR0452	VST002096	RT00079	1	f
LOG0009172	USR0303	VST001472	RT00743	1	t
LOG0009173	USR0204	VST002046	RT00357	2	f
LOG0009174	USR0345	VST004613	RT00119	4	f
LOG0009175	USR0248	VST003684	RT00586	4	t
LOG0009176	USR0314	VST000205	RT00521	4	f
LOG0009177	USR0266	VST003601	RT00279	3	f
LOG0009178	USR0022	VST002138	RT00782	3	f
LOG0009179	USR0327	VST001214	RT00566	2	t
LOG0009180	USR0024	VST003835	RT00892	2	t
LOG0009181	USR0194	VST003092	RT00045	3	t
LOG0009182	USR0096	VST001383	RT00225	3	t
LOG0009183	USR0469	VST003681	RT00528	1	f
LOG0009184	USR0445	VST001680	RT00724	1	f
LOG0009185	USR0263	VST000007	RT00712	3	t
LOG0009186	USR0072	VST001886	RT00241	4	t
LOG0009187	USR0243	VST003499	RT00614	3	t
LOG0009188	USR0383	VST000296	RT00482	1	f
LOG0009189	USR0038	VST000264	RT00095	2	f
LOG0009190	USR0405	VST002138	RT00365	3	f
LOG0009191	USR0392	VST004949	RT00185	3	f
LOG0009192	USR0377	VST003866	RT00136	4	t
LOG0009193	USR0089	VST004497	RT00025	2	f
LOG0009194	USR0028	VST004453	RT00937	4	f
LOG0009195	USR0092	VST002547	RT00318	2	t
LOG0009196	USR0054	VST004930	RT00333	4	t
LOG0009197	USR0159	VST004531	RT00914	2	f
LOG0009198	USR0372	VST000119	RT00562	3	f
LOG0009199	USR0228	VST002396	RT00681	3	f
LOG0009200	USR0473	VST003368	RT00802	3	t
LOG0009201	USR0372	VST001703	RT00100	1	t
LOG0009202	USR0376	VST000530	RT00370	2	t
LOG0009203	USR0041	VST003675	RT00593	2	t
LOG0009204	USR0037	VST000303	RT00012	4	t
LOG0009205	USR0125	VST004068	RT00720	1	f
LOG0009206	USR0422	VST004252	RT00077	4	f
LOG0009207	USR0179	VST003969	RT00587	1	f
LOG0009208	USR0332	VST000014	RT00974	4	f
LOG0009209	USR0037	VST002804	RT00682	1	f
LOG0009210	USR0101	VST000889	RT00823	4	f
LOG0009211	USR0031	VST003529	RT00348	4	f
LOG0009212	USR0190	VST001197	RT00443	1	t
LOG0009213	USR0146	VST004541	RT00691	2	f
LOG0009214	USR0090	VST002170	RT00088	4	t
LOG0009215	USR0006	VST003569	RT00949	1	f
LOG0009216	USR0393	VST002232	RT00465	1	f
LOG0009217	USR0139	VST001844	RT00777	2	t
LOG0009218	USR0095	VST003652	RT00494	2	t
LOG0009219	USR0119	VST003877	RT00222	2	f
LOG0009220	USR0366	VST002719	RT00997	2	f
LOG0009221	USR0120	VST000049	RT00515	4	f
LOG0009222	USR0386	VST000181	RT00118	4	f
LOG0009223	USR0123	VST003879	RT00136	3	f
LOG0009224	USR0285	VST001418	RT00978	4	t
LOG0009225	USR0366	VST003465	RT00187	3	t
LOG0009226	USR0377	VST003420	RT00542	3	t
LOG0009227	USR0179	VST000530	RT00579	4	f
LOG0009228	USR0490	VST004680	RT00311	3	f
LOG0009229	USR0325	VST001287	RT00930	2	t
LOG0009230	USR0407	VST002191	RT00379	3	t
LOG0009231	USR0484	VST000707	RT00811	4	f
LOG0009232	USR0007	VST003218	RT00412	1	f
LOG0009233	USR0384	VST000294	RT00421	4	f
LOG0009234	USR0312	VST001562	RT00217	1	f
LOG0009235	USR0127	VST004518	RT00670	1	f
LOG0009236	USR0077	VST002612	RT00071	3	t
LOG0009237	USR0234	VST000661	RT00830	3	t
LOG0009238	USR0318	VST003179	RT00110	1	f
LOG0009239	USR0074	VST003390	RT00285	3	f
LOG0009240	USR0484	VST002107	RT00883	2	f
LOG0009241	USR0464	VST003064	RT00770	4	f
LOG0009242	USR0271	VST002841	RT00602	3	f
LOG0009243	USR0309	VST003497	RT00873	1	f
LOG0009244	USR0427	VST002579	RT00569	1	f
LOG0009245	USR0467	VST002052	RT00953	4	f
LOG0009246	USR0469	VST002410	RT00298	3	t
LOG0009247	USR0120	VST002954	RT00499	3	f
LOG0009248	USR0035	VST000369	RT00561	1	t
LOG0009249	USR0207	VST000539	RT00697	4	t
LOG0009250	USR0496	VST002928	RT00711	1	f
LOG0009251	USR0270	VST002394	RT00530	4	f
LOG0009252	USR0093	VST000731	RT00198	3	t
LOG0009253	USR0453	VST000897	RT00507	3	f
LOG0009254	USR0378	VST004660	RT00489	4	f
LOG0009255	USR0177	VST002369	RT00744	1	f
LOG0009256	USR0274	VST004560	RT00027	1	t
LOG0009257	USR0179	VST002681	RT00118	1	f
LOG0009258	USR0129	VST002381	RT00054	4	t
LOG0009259	USR0125	VST000015	RT00504	4	f
LOG0009260	USR0027	VST003129	RT00152	1	f
LOG0009261	USR0064	VST001354	RT00737	1	t
LOG0009262	USR0060	VST003136	RT00479	4	t
LOG0009263	USR0219	VST002278	RT00162	4	t
LOG0009264	USR0217	VST000011	RT00662	1	f
LOG0009265	USR0169	VST001657	RT00216	1	f
LOG0009266	USR0149	VST001248	RT00831	3	t
LOG0009267	USR0270	VST001661	RT00420	2	t
LOG0009268	USR0116	VST001764	RT00348	4	f
LOG0009269	USR0245	VST000542	RT00340	2	f
LOG0009270	USR0148	VST001530	RT00829	4	f
LOG0009271	USR0092	VST001181	RT00850	3	f
LOG0009272	USR0085	VST002689	RT00554	4	f
LOG0009273	USR0087	VST002618	RT00352	4	t
LOG0009274	USR0395	VST002755	RT00673	2	f
LOG0009275	USR0120	VST000929	RT00586	3	f
LOG0009276	USR0450	VST001427	RT00905	3	f
LOG0009277	USR0340	VST003660	RT00375	3	t
LOG0009278	USR0024	VST002234	RT00537	3	t
LOG0009279	USR0375	VST003910	RT00909	4	f
LOG0009280	USR0089	VST004991	RT00303	2	f
LOG0009281	USR0037	VST002062	RT00242	3	t
LOG0009282	USR0342	VST004098	RT00378	1	f
LOG0009283	USR0383	VST002564	RT00685	3	t
LOG0009284	USR0408	VST002804	RT00389	2	t
LOG0009285	USR0271	VST002294	RT00287	2	t
LOG0009286	USR0012	VST001626	RT00159	2	f
LOG0009287	USR0494	VST000572	RT00354	2	t
LOG0009288	USR0095	VST004532	RT00730	1	f
LOG0009289	USR0491	VST002401	RT00455	3	t
LOG0009290	USR0448	VST001712	RT00937	4	t
LOG0009291	USR0031	VST000383	RT00627	4	t
LOG0009292	USR0437	VST001084	RT00942	1	t
LOG0009293	USR0350	VST001950	RT00241	3	t
LOG0009294	USR0233	VST002518	RT00820	3	f
LOG0009295	USR0340	VST004170	RT00212	4	t
LOG0009296	USR0328	VST003498	RT00363	1	t
LOG0009297	USR0300	VST003315	RT00598	4	f
LOG0009298	USR0286	VST004931	RT00133	1	f
LOG0009299	USR0035	VST002676	RT00780	2	t
LOG0009300	USR0021	VST003395	RT00509	3	f
LOG0009301	USR0111	VST001204	RT00277	3	t
LOG0009302	USR0488	VST000774	RT00265	3	t
LOG0009303	USR0319	VST003057	RT00605	3	t
LOG0009304	USR0348	VST002314	RT00603	3	f
LOG0009305	USR0487	VST002598	RT00657	3	t
LOG0009306	USR0145	VST001404	RT00360	2	f
LOG0009307	USR0012	VST004173	RT00664	3	t
LOG0009308	USR0244	VST003062	RT00667	2	t
LOG0009309	USR0498	VST003326	RT00136	3	f
LOG0009310	USR0146	VST001404	RT00765	3	t
LOG0009311	USR0239	VST003321	RT00428	1	t
LOG0009312	USR0092	VST000870	RT00830	3	f
LOG0009313	USR0316	VST001084	RT00029	4	f
LOG0009314	USR0323	VST000974	RT00595	1	t
LOG0009315	USR0115	VST001226	RT00330	1	t
LOG0009316	USR0015	VST001803	RT00920	1	f
LOG0009317	USR0272	VST002965	RT00034	4	t
LOG0009318	USR0022	VST001189	RT00504	2	t
LOG0009319	USR0118	VST003444	RT00828	1	f
LOG0009320	USR0369	VST003935	RT00104	1	f
LOG0009321	USR0095	VST004410	RT00927	1	t
LOG0009322	USR0447	VST001322	RT00494	3	f
LOG0009323	USR0415	VST002024	RT00371	2	f
LOG0009324	USR0257	VST004732	RT00388	4	f
LOG0009325	USR0331	VST004513	RT00745	4	t
LOG0009326	USR0262	VST000439	RT00237	2	t
LOG0009327	USR0087	VST000165	RT00735	2	f
LOG0009328	USR0393	VST003338	RT00905	2	f
LOG0009329	USR0436	VST003351	RT00090	3	t
LOG0009330	USR0464	VST000988	RT00333	1	t
LOG0009331	USR0318	VST002530	RT00377	3	t
LOG0009332	USR0058	VST004613	RT00240	2	t
LOG0009333	USR0230	VST004178	RT00730	3	f
LOG0009334	USR0108	VST004215	RT00182	4	f
LOG0009335	USR0019	VST003846	RT00257	3	t
LOG0009336	USR0365	VST001327	RT00744	2	t
LOG0009337	USR0141	VST003287	RT00189	1	f
LOG0009338	USR0379	VST000028	RT00841	3	t
LOG0009339	USR0160	VST002025	RT00415	2	t
LOG0009340	USR0100	VST004594	RT00856	3	f
LOG0009341	USR0265	VST000194	RT00255	4	f
LOG0009342	USR0238	VST000592	RT00045	3	t
LOG0009343	USR0238	VST002490	RT00828	3	t
LOG0009344	USR0049	VST001858	RT00598	1	t
LOG0009345	USR0165	VST000113	RT00201	3	f
LOG0009346	USR0287	VST001318	RT00359	3	t
LOG0009347	USR0415	VST001738	RT00343	4	f
LOG0009348	USR0059	VST002062	RT00212	4	t
LOG0009349	USR0183	VST001691	RT00631	4	t
LOG0009350	USR0147	VST003669	RT00298	1	f
LOG0009351	USR0447	VST001395	RT00981	4	f
LOG0009352	USR0386	VST003169	RT00155	4	t
LOG0009353	USR0301	VST003560	RT00698	3	f
LOG0009354	USR0096	VST002237	RT00197	3	t
LOG0009355	USR0043	VST003884	RT00849	1	f
LOG0009356	USR0354	VST003252	RT00482	4	f
LOG0009357	USR0257	VST003933	RT00713	2	t
LOG0009358	USR0213	VST003015	RT00930	3	f
LOG0009359	USR0189	VST003487	RT00778	2	t
LOG0009360	USR0131	VST001129	RT00379	2	f
LOG0009361	USR0347	VST001697	RT00748	4	f
LOG0009362	USR0300	VST000133	RT00706	2	t
LOG0009363	USR0391	VST004666	RT00367	1	t
LOG0009364	USR0289	VST004221	RT00537	1	f
LOG0009365	USR0137	VST003540	RT00771	3	t
LOG0009366	USR0030	VST002989	RT00930	2	t
LOG0009367	USR0146	VST004303	RT00071	1	t
LOG0009368	USR0312	VST003294	RT00028	1	t
LOG0009369	USR0474	VST000312	RT00393	2	f
LOG0009370	USR0468	VST002430	RT00523	1	t
LOG0009371	USR0486	VST001786	RT00349	2	f
LOG0009372	USR0105	VST004392	RT00118	1	t
LOG0009373	USR0287	VST000402	RT00380	2	t
LOG0009374	USR0456	VST001597	RT00208	1	t
LOG0009375	USR0191	VST000122	RT00423	1	t
LOG0009376	USR0471	VST000751	RT00093	1	f
LOG0009377	USR0178	VST000106	RT00141	4	t
LOG0009378	USR0345	VST001060	RT00355	4	t
LOG0009379	USR0239	VST004168	RT00523	1	f
LOG0009380	USR0001	VST004664	RT00803	4	t
LOG0009381	USR0110	VST003239	RT00751	2	t
LOG0009382	USR0338	VST001245	RT00776	4	t
LOG0009383	USR0275	VST000076	RT00775	3	t
LOG0009384	USR0371	VST001010	RT00069	3	f
LOG0009385	USR0382	VST003283	RT00582	1	f
LOG0009386	USR0234	VST002276	RT00697	4	f
LOG0009387	USR0064	VST003809	RT00883	3	f
LOG0009388	USR0244	VST000453	RT00124	1	t
LOG0009389	USR0053	VST000766	RT00419	3	t
LOG0009390	USR0262	VST004583	RT00734	1	f
LOG0009391	USR0017	VST002716	RT00523	3	t
LOG0009392	USR0302	VST001498	RT00678	3	t
LOG0009393	USR0493	VST003947	RT00603	4	f
LOG0009394	USR0456	VST003733	RT00760	1	f
LOG0009395	USR0374	VST004926	RT00341	3	f
LOG0009396	USR0234	VST002839	RT00974	1	t
LOG0009397	USR0073	VST000490	RT00305	4	t
LOG0009398	USR0357	VST002424	RT00803	3	t
LOG0009399	USR0439	VST001936	RT00157	2	t
LOG0009400	USR0091	VST002750	RT00088	2	t
LOG0009401	USR0484	VST003297	RT00228	2	t
LOG0009402	USR0006	VST004571	RT00937	1	f
LOG0009403	USR0198	VST003692	RT00365	4	f
LOG0009404	USR0365	VST001104	RT00992	1	f
LOG0009405	USR0196	VST001600	RT00646	1	f
LOG0009406	USR0470	VST003282	RT00266	2	t
LOG0009407	USR0296	VST003161	RT00084	4	f
LOG0009408	USR0347	VST003946	RT00212	3	f
LOG0009409	USR0485	VST000226	RT00218	1	f
LOG0009410	USR0322	VST004804	RT00853	2	f
LOG0009411	USR0137	VST001715	RT00749	1	t
LOG0009412	USR0267	VST004150	RT00151	1	f
LOG0009413	USR0404	VST002244	RT00686	4	t
LOG0009414	USR0116	VST002893	RT00140	3	f
LOG0009415	USR0043	VST002346	RT00055	1	t
LOG0009416	USR0231	VST000579	RT00141	1	f
LOG0009417	USR0058	VST001699	RT00074	3	t
LOG0009418	USR0206	VST004596	RT00135	4	t
LOG0009419	USR0410	VST002672	RT00997	1	t
LOG0009420	USR0294	VST004302	RT00908	4	f
LOG0009421	USR0094	VST002928	RT00829	4	f
LOG0009422	USR0036	VST000279	RT00921	1	f
LOG0009423	USR0230	VST001469	RT00642	3	t
LOG0009424	USR0227	VST004773	RT00744	1	t
LOG0009425	USR0183	VST000941	RT00026	1	t
LOG0009426	USR0262	VST002319	RT00488	2	f
LOG0009427	USR0131	VST004537	RT00435	3	f
LOG0009428	USR0065	VST001784	RT00581	2	t
LOG0009429	USR0380	VST001876	RT00062	3	f
LOG0009430	USR0448	VST004644	RT00200	1	t
LOG0009431	USR0186	VST003227	RT00490	4	f
LOG0009432	USR0117	VST003729	RT00493	2	t
LOG0009433	USR0186	VST000986	RT00969	2	t
LOG0009434	USR0274	VST002820	RT00679	2	t
LOG0009435	USR0151	VST003971	RT00468	2	f
LOG0009436	USR0352	VST002067	RT00116	3	f
LOG0009437	USR0413	VST000425	RT00371	4	t
LOG0009438	USR0151	VST002106	RT00651	4	f
LOG0009439	USR0384	VST002471	RT00232	1	f
LOG0009440	USR0036	VST003795	RT00448	1	t
LOG0009441	USR0326	VST002892	RT00214	2	f
LOG0009442	USR0465	VST001684	RT00208	1	f
LOG0009443	USR0466	VST003174	RT00102	1	f
LOG0009444	USR0095	VST003148	RT00810	3	f
LOG0009445	USR0134	VST004062	RT00010	1	t
LOG0009446	USR0162	VST004052	RT00473	1	f
LOG0009447	USR0044	VST003652	RT00123	1	f
LOG0009448	USR0300	VST004162	RT00787	4	f
LOG0009449	USR0283	VST004911	RT00004	4	t
LOG0009450	USR0356	VST001175	RT00467	1	t
LOG0009451	USR0240	VST002950	RT00259	2	t
LOG0009452	USR0052	VST001810	RT00721	4	f
LOG0009453	USR0426	VST000437	RT00910	3	t
LOG0009454	USR0281	VST004886	RT00778	3	f
LOG0009455	USR0074	VST000235	RT00774	3	t
LOG0009456	USR0295	VST004771	RT00287	1	t
LOG0009457	USR0238	VST002146	RT00031	2	f
LOG0009458	USR0167	VST003576	RT00688	3	t
LOG0009459	USR0140	VST004857	RT00521	2	t
LOG0009460	USR0139	VST003562	RT00716	3	t
LOG0009461	USR0369	VST002475	RT00620	2	t
LOG0009462	USR0235	VST000227	RT00124	1	t
LOG0009463	USR0003	VST002611	RT00750	1	f
LOG0009464	USR0256	VST002276	RT00922	3	f
LOG0009465	USR0371	VST004802	RT00130	3	t
LOG0009466	USR0278	VST001816	RT00746	4	f
LOG0009467	USR0004	VST003855	RT00516	3	f
LOG0009468	USR0392	VST003996	RT00480	4	t
LOG0009469	USR0270	VST001411	RT00732	4	t
LOG0009470	USR0212	VST004765	RT00774	1	f
LOG0009471	USR0216	VST003380	RT00542	1	t
LOG0009472	USR0270	VST001846	RT00951	4	f
LOG0009473	USR0476	VST001338	RT00924	3	f
LOG0009474	USR0016	VST000118	RT00829	4	t
LOG0009475	USR0416	VST001869	RT00077	3	t
LOG0009476	USR0064	VST002098	RT00183	1	f
LOG0009477	USR0239	VST001814	RT00366	3	f
LOG0009478	USR0460	VST001588	RT00292	4	t
LOG0009479	USR0016	VST003253	RT00970	3	t
LOG0009480	USR0052	VST000543	RT00714	4	t
LOG0009481	USR0019	VST002375	RT00389	3	t
LOG0009482	USR0325	VST001527	RT00157	4	t
LOG0009483	USR0396	VST003568	RT00100	1	t
LOG0009484	USR0093	VST001270	RT00908	4	f
LOG0009485	USR0261	VST000602	RT00634	1	f
LOG0009486	USR0298	VST003615	RT00918	4	t
LOG0009487	USR0017	VST002150	RT00827	4	f
LOG0009488	USR0111	VST003302	RT00110	2	f
LOG0009489	USR0328	VST000388	RT00679	2	f
LOG0009490	USR0360	VST003681	RT00642	2	f
LOG0009491	USR0488	VST001603	RT00270	2	f
LOG0009492	USR0094	VST003283	RT00138	3	f
LOG0009493	USR0010	VST002697	RT00688	1	f
LOG0009494	USR0212	VST004435	RT00064	1	f
LOG0009495	USR0237	VST004152	RT00643	2	t
LOG0009496	USR0254	VST003834	RT00507	3	t
LOG0009497	USR0016	VST001306	RT00840	4	t
LOG0009498	USR0489	VST000717	RT00700	4	t
LOG0009499	USR0144	VST003656	RT00977	1	f
LOG0009500	USR0042	VST002992	RT00964	1	t
LOG0009501	USR0003	VST000314	RT00789	3	t
LOG0009502	USR0407	VST002281	RT00350	4	f
LOG0009503	USR0470	VST002623	RT00147	3	t
LOG0009504	USR0377	VST000888	RT00335	4	t
LOG0009505	USR0156	VST004343	RT00532	2	f
LOG0009506	USR0494	VST002490	RT00826	2	t
LOG0009507	USR0173	VST001923	RT00554	3	t
LOG0009508	USR0484	VST004030	RT00862	1	f
LOG0009509	USR0452	VST003064	RT00906	3	f
LOG0009510	USR0486	VST000161	RT00407	3	t
LOG0009511	USR0024	VST002188	RT00344	4	t
LOG0009512	USR0275	VST002352	RT00652	4	t
LOG0009513	USR0075	VST001484	RT00521	4	f
LOG0009514	USR0040	VST003893	RT00591	4	t
LOG0009515	USR0302	VST001738	RT00925	1	t
LOG0009516	USR0040	VST004221	RT00850	1	t
LOG0009517	USR0062	VST001909	RT00660	2	t
LOG0009518	USR0238	VST001371	RT00705	3	f
LOG0009519	USR0487	VST001978	RT00771	2	f
LOG0009520	USR0245	VST003396	RT00136	4	t
LOG0009521	USR0018	VST002455	RT00039	3	t
LOG0009522	USR0140	VST004260	RT00320	4	f
LOG0009523	USR0398	VST004958	RT00287	3	f
LOG0009524	USR0495	VST002288	RT00879	1	f
LOG0009525	USR0082	VST001237	RT00968	4	f
LOG0009526	USR0189	VST003175	RT00463	3	t
LOG0009527	USR0108	VST001207	RT00891	3	f
LOG0009528	USR0234	VST000505	RT00662	4	f
LOG0009529	USR0268	VST003768	RT00352	1	t
LOG0009530	USR0104	VST004621	RT00005	1	t
LOG0009531	USR0411	VST001404	RT00236	1	t
LOG0009532	USR0134	VST001768	RT00236	3	t
LOG0009533	USR0344	VST003734	RT00826	1	t
LOG0009534	USR0371	VST000701	RT00969	3	t
LOG0009535	USR0033	VST003205	RT00501	2	t
LOG0009536	USR0237	VST004146	RT00105	1	f
LOG0009537	USR0374	VST003006	RT00207	4	f
LOG0009538	USR0336	VST004791	RT00239	4	t
LOG0009539	USR0178	VST004122	RT00831	4	f
LOG0009540	USR0012	VST004083	RT00829	4	f
LOG0009541	USR0351	VST000011	RT00052	2	t
LOG0009542	USR0441	VST004904	RT00108	2	f
LOG0009543	USR0229	VST002059	RT00357	1	f
LOG0009544	USR0309	VST003678	RT00033	1	f
LOG0009545	USR0269	VST002820	RT00022	4	f
LOG0009546	USR0378	VST000973	RT00307	4	t
LOG0009547	USR0456	VST003793	RT00011	4	f
LOG0009548	USR0358	VST002455	RT00639	3	f
LOG0009549	USR0131	VST000842	RT00442	1	t
LOG0009550	USR0249	VST004455	RT00562	4	f
LOG0009551	USR0448	VST000285	RT00198	4	t
LOG0009552	USR0468	VST002436	RT00529	4	f
LOG0009553	USR0058	VST002832	RT00942	2	f
LOG0009554	USR0004	VST004521	RT00044	2	t
LOG0009555	USR0236	VST001030	RT00185	2	t
LOG0009556	USR0173	VST004452	RT00389	3	t
LOG0009557	USR0322	VST002967	RT00551	3	f
LOG0009558	USR0371	VST000554	RT00507	1	t
LOG0009559	USR0036	VST000268	RT00442	4	t
LOG0009560	USR0279	VST001241	RT00496	1	f
LOG0009561	USR0237	VST004160	RT00505	1	t
LOG0009562	USR0275	VST002490	RT00137	2	f
LOG0009563	USR0296	VST002589	RT00989	4	f
LOG0009564	USR0328	VST000470	RT00279	2	t
LOG0009565	USR0400	VST003288	RT00943	2	t
LOG0009566	USR0058	VST003937	RT00164	4	f
LOG0009567	USR0363	VST002020	RT00543	1	t
LOG0009568	USR0018	VST002024	RT00852	1	f
LOG0009569	USR0036	VST001590	RT00023	2	t
LOG0009570	USR0408	VST004974	RT00952	4	t
LOG0009571	USR0129	VST002061	RT00711	1	f
LOG0009572	USR0001	VST004318	RT00507	3	f
LOG0009573	USR0064	VST001420	RT00686	1	t
LOG0009574	USR0062	VST000881	RT00510	4	f
LOG0009575	USR0366	VST000839	RT00570	4	t
LOG0009576	USR0420	VST000752	RT00932	4	t
LOG0009577	USR0331	VST000270	RT00708	2	f
LOG0009578	USR0146	VST003370	RT00600	1	f
LOG0009579	USR0272	VST004828	RT00444	3	f
LOG0009580	USR0017	VST004712	RT00142	2	t
LOG0009581	USR0280	VST003504	RT00281	1	t
LOG0009582	USR0098	VST003961	RT00967	4	f
LOG0009583	USR0452	VST002076	RT00207	1	f
LOG0009584	USR0227	VST001313	RT00684	4	t
LOG0009585	USR0463	VST002285	RT00302	4	t
LOG0009586	USR0386	VST000384	RT00397	1	f
LOG0009587	USR0243	VST004181	RT00318	1	f
LOG0009588	USR0479	VST004342	RT00787	3	t
LOG0009589	USR0201	VST002809	RT00908	1	t
LOG0009590	USR0394	VST000804	RT00880	1	f
LOG0009591	USR0437	VST004336	RT00858	2	t
LOG0009592	USR0473	VST001097	RT00048	4	t
LOG0009593	USR0179	VST003743	RT00673	4	t
LOG0009594	USR0453	VST004484	RT00975	3	f
LOG0009595	USR0270	VST003720	RT00677	2	t
LOG0009596	USR0234	VST004772	RT00390	3	f
LOG0009597	USR0112	VST002697	RT00379	1	t
LOG0009598	USR0486	VST004267	RT00217	3	t
LOG0009599	USR0488	VST000809	RT00629	4	f
LOG0009600	USR0066	VST002152	RT00849	2	f
LOG0009601	USR0338	VST003294	RT00939	1	t
LOG0009602	USR0349	VST001306	RT00251	2	f
LOG0009603	USR0437	VST003460	RT00868	2	f
LOG0009604	USR0245	VST002420	RT00434	3	f
LOG0009605	USR0245	VST004225	RT00756	1	t
LOG0009606	USR0468	VST001197	RT00942	2	f
LOG0009607	USR0448	VST004568	RT00759	2	t
LOG0009608	USR0072	VST003525	RT00585	3	f
LOG0009609	USR0357	VST001526	RT00284	2	f
LOG0009610	USR0049	VST001600	RT00483	4	t
LOG0009611	USR0496	VST001045	RT00707	4	t
LOG0009612	USR0346	VST002154	RT00267	1	f
LOG0009613	USR0190	VST001868	RT00916	1	t
LOG0009614	USR0293	VST001376	RT00599	3	t
LOG0009615	USR0177	VST000612	RT00246	2	f
LOG0009616	USR0452	VST003317	RT00158	3	f
LOG0009617	USR0161	VST001599	RT00357	3	t
LOG0009618	USR0150	VST004950	RT00548	4	f
LOG0009619	USR0070	VST001978	RT00236	2	t
LOG0009620	USR0033	VST004398	RT00760	4	t
LOG0009621	USR0284	VST000639	RT00460	4	t
LOG0009622	USR0344	VST004167	RT00100	1	f
LOG0009623	USR0260	VST001923	RT00739	3	t
LOG0009624	USR0322	VST000646	RT00119	4	f
LOG0009625	USR0077	VST004270	RT00354	1	t
LOG0009626	USR0110	VST001999	RT00708	1	t
LOG0009627	USR0305	VST000090	RT00088	2	t
LOG0009628	USR0384	VST003279	RT00036	2	f
LOG0009629	USR0139	VST002367	RT00314	4	f
LOG0009630	USR0035	VST000824	RT00540	1	t
LOG0009631	USR0423	VST000551	RT00551	1	t
LOG0009632	USR0394	VST000060	RT00322	1	f
LOG0009633	USR0235	VST004223	RT00427	3	t
LOG0009634	USR0330	VST004179	RT00517	1	f
LOG0009635	USR0200	VST001244	RT00988	3	t
LOG0009636	USR0325	VST003480	RT00653	2	t
LOG0009637	USR0151	VST000946	RT00740	4	f
LOG0009638	USR0034	VST001641	RT00009	2	f
LOG0009639	USR0124	VST001953	RT00359	4	f
LOG0009640	USR0367	VST002634	RT00478	1	t
LOG0009641	USR0032	VST003502	RT00057	4	t
LOG0009642	USR0272	VST000890	RT00283	4	f
LOG0009643	USR0324	VST000574	RT00445	2	t
LOG0009644	USR0310	VST000513	RT00461	4	t
LOG0009645	USR0124	VST004161	RT00490	1	t
LOG0009646	USR0412	VST001965	RT00359	3	f
LOG0009647	USR0368	VST004052	RT00690	1	f
LOG0009648	USR0492	VST002231	RT00988	4	t
LOG0009649	USR0316	VST002284	RT00594	2	t
LOG0009650	USR0078	VST004985	RT00930	1	t
LOG0009651	USR0076	VST000612	RT00597	4	f
LOG0009652	USR0060	VST000438	RT00065	2	f
LOG0009653	USR0085	VST001460	RT00429	3	f
LOG0009654	USR0368	VST000524	RT00855	2	f
LOG0009655	USR0080	VST003578	RT00802	4	f
LOG0009656	USR0374	VST004896	RT00868	2	t
LOG0009657	USR0172	VST003399	RT00457	4	t
LOG0009658	USR0258	VST002262	RT00136	2	f
LOG0009659	USR0279	VST001024	RT00762	2	f
LOG0009660	USR0221	VST001580	RT00606	2	f
LOG0009661	USR0046	VST000322	RT00048	4	f
LOG0009662	USR0491	VST003127	RT00932	2	t
LOG0009663	USR0073	VST002832	RT00612	4	t
LOG0009664	USR0054	VST004276	RT00850	1	t
LOG0009665	USR0327	VST002428	RT00194	3	t
LOG0009666	USR0221	VST002981	RT00117	1	f
LOG0009667	USR0492	VST003758	RT00779	3	f
LOG0009668	USR0381	VST000450	RT00820	4	f
LOG0009669	USR0337	VST001285	RT00164	1	t
LOG0009670	USR0009	VST003519	RT00479	3	t
LOG0009671	USR0326	VST001661	RT00287	3	t
LOG0009672	USR0172	VST000904	RT00536	1	t
LOG0009673	USR0084	VST001178	RT00494	1	t
LOG0009674	USR0330	VST000330	RT00405	4	f
LOG0009675	USR0329	VST000637	RT00096	3	t
LOG0009676	USR0012	VST001890	RT00497	4	t
LOG0009677	USR0481	VST001868	RT00254	4	t
LOG0009678	USR0032	VST002516	RT00414	2	f
LOG0009679	USR0418	VST000413	RT00633	4	t
LOG0009680	USR0339	VST003834	RT00584	3	t
LOG0009681	USR0289	VST002416	RT00865	2	f
LOG0009682	USR0320	VST002587	RT00371	4	f
LOG0009683	USR0304	VST001565	RT00576	4	f
LOG0009684	USR0272	VST004611	RT00243	3	t
LOG0009685	USR0178	VST000481	RT00639	2	t
LOG0009686	USR0114	VST002276	RT00373	1	t
LOG0009687	USR0407	VST003841	RT00039	1	t
LOG0009688	USR0026	VST003312	RT00897	2	f
LOG0009689	USR0237	VST002883	RT00353	2	f
LOG0009690	USR0310	VST003744	RT00426	2	f
LOG0009691	USR0172	VST002520	RT00077	2	f
LOG0009692	USR0233	VST004614	RT00982	1	t
LOG0009693	USR0037	VST004401	RT00510	4	f
LOG0009694	USR0265	VST000655	RT00517	3	t
LOG0009695	USR0478	VST001978	RT00140	1	t
LOG0009696	USR0013	VST000181	RT00252	3	f
LOG0009697	USR0496	VST004126	RT00669	1	t
LOG0009698	USR0316	VST003020	RT00771	2	t
LOG0009699	USR0106	VST000765	RT00317	1	t
LOG0009700	USR0126	VST004136	RT00947	1	f
LOG0009701	USR0336	VST002367	RT00420	2	t
LOG0009702	USR0494	VST003299	RT00879	4	t
LOG0009703	USR0384	VST002780	RT00749	2	t
LOG0009704	USR0130	VST004988	RT00075	4	f
LOG0009705	USR0479	VST002372	RT00986	1	t
LOG0009706	USR0316	VST003391	RT00898	1	t
LOG0009707	USR0256	VST001783	RT00029	3	t
LOG0009708	USR0441	VST004781	RT00041	3	f
LOG0009709	USR0115	VST001065	RT00541	1	f
LOG0009710	USR0299	VST002457	RT00492	3	f
LOG0009711	USR0403	VST001347	RT00100	4	t
LOG0009712	USR0124	VST002228	RT00320	2	t
LOG0009713	USR0256	VST001183	RT00570	1	t
LOG0009714	USR0139	VST004133	RT00723	1	t
LOG0009715	USR0206	VST002454	RT00650	3	t
LOG0009716	USR0047	VST000539	RT00523	1	f
LOG0009717	USR0217	VST002424	RT00903	1	f
LOG0009718	USR0319	VST002304	RT00845	4	t
LOG0009719	USR0391	VST000249	RT00876	4	f
LOG0009720	USR0463	VST004789	RT00189	2	f
LOG0009721	USR0350	VST001041	RT00450	1	t
LOG0009722	USR0123	VST001392	RT00094	3	t
LOG0009723	USR0031	VST002173	RT00854	2	f
LOG0009724	USR0472	VST001336	RT00181	3	f
LOG0009725	USR0055	VST002260	RT00321	1	t
LOG0009726	USR0153	VST000500	RT00283	3	t
LOG0009727	USR0456	VST000811	RT00391	3	t
LOG0009728	USR0286	VST004985	RT00321	2	f
LOG0009729	USR0036	VST003714	RT00570	1	f
LOG0009730	USR0306	VST003705	RT00025	2	t
LOG0009731	USR0398	VST001211	RT00816	1	t
LOG0009732	USR0285	VST003746	RT00260	4	t
LOG0009733	USR0411	VST001987	RT00990	2	t
LOG0009734	USR0373	VST001492	RT00904	1	t
LOG0009735	USR0256	VST004271	RT00497	4	f
LOG0009736	USR0178	VST003049	RT00213	4	f
LOG0009737	USR0036	VST004920	RT00115	4	t
LOG0009738	USR0254	VST002935	RT00452	2	t
LOG0009739	USR0162	VST004365	RT00700	4	t
LOG0009740	USR0021	VST001818	RT00772	1	f
LOG0009741	USR0294	VST004320	RT00648	2	t
LOG0009742	USR0075	VST001276	RT00490	3	f
LOG0009743	USR0481	VST003023	RT00602	4	f
LOG0009744	USR0207	VST002878	RT00733	2	t
LOG0009745	USR0460	VST004015	RT00528	3	t
LOG0009746	USR0472	VST004088	RT00659	2	t
LOG0009747	USR0178	VST001148	RT00385	4	t
LOG0009748	USR0382	VST000238	RT00613	4	t
LOG0009749	USR0037	VST002123	RT00418	3	f
LOG0009750	USR0459	VST004596	RT00989	1	f
LOG0009751	USR0120	VST001546	RT00219	4	t
LOG0009752	USR0403	VST003984	RT00880	3	t
LOG0009753	USR0118	VST004364	RT00557	4	t
LOG0009754	USR0001	VST000987	RT00063	1	t
LOG0009755	USR0209	VST001624	RT00350	3	t
LOG0009756	USR0424	VST003122	RT00390	1	f
LOG0009757	USR0311	VST003727	RT00804	4	f
LOG0009758	USR0208	VST003902	RT00377	3	f
LOG0009759	USR0154	VST000723	RT00871	2	f
LOG0009760	USR0250	VST001096	RT00066	1	t
LOG0009761	USR0171	VST003828	RT00119	4	t
LOG0009762	USR0315	VST004286	RT00746	4	t
LOG0009763	USR0307	VST000996	RT00974	1	f
LOG0009764	USR0107	VST004662	RT00008	3	f
LOG0009765	USR0143	VST000993	RT00707	2	t
LOG0009766	USR0008	VST002784	RT00739	4	f
LOG0009767	USR0094	VST000156	RT00027	1	t
LOG0009768	USR0398	VST001896	RT00290	1	t
LOG0009769	USR0097	VST001777	RT00028	2	t
LOG0009770	USR0490	VST004769	RT00159	2	t
LOG0009771	USR0007	VST002117	RT00145	4	f
LOG0009772	USR0274	VST002421	RT00467	2	t
LOG0009773	USR0012	VST000055	RT00746	1	t
LOG0009774	USR0002	VST000085	RT00108	3	t
LOG0009775	USR0434	VST002889	RT00891	3	t
LOG0009776	USR0349	VST004688	RT00439	1	t
LOG0009777	USR0405	VST002780	RT00203	1	f
LOG0009778	USR0007	VST002670	RT00777	1	t
LOG0009779	USR0500	VST003837	RT00990	4	t
LOG0009780	USR0475	VST001009	RT00825	1	f
LOG0009781	USR0012	VST002365	RT00301	2	t
LOG0009782	USR0340	VST003687	RT00902	1	t
LOG0009783	USR0057	VST004348	RT00910	1	t
LOG0009784	USR0078	VST002200	RT00927	4	t
LOG0009785	USR0074	VST001360	RT00438	1	t
LOG0009786	USR0233	VST000910	RT00011	2	t
LOG0009787	USR0279	VST003440	RT00837	2	t
LOG0009788	USR0030	VST002914	RT00607	2	f
LOG0009789	USR0367	VST004696	RT00642	1	t
LOG0009790	USR0314	VST001007	RT00103	4	t
LOG0009791	USR0095	VST003053	RT00785	4	t
LOG0009792	USR0308	VST001144	RT00486	4	f
LOG0009793	USR0056	VST004399	RT00110	2	t
LOG0009794	USR0010	VST003221	RT00804	4	t
LOG0009795	USR0403	VST001225	RT00643	1	t
LOG0009796	USR0147	VST003879	RT00703	1	f
LOG0009797	USR0364	VST004496	RT00811	3	t
LOG0009798	USR0087	VST000068	RT00093	2	f
LOG0009799	USR0253	VST004250	RT00801	3	f
LOG0009800	USR0187	VST001015	RT00718	3	t
LOG0009801	USR0428	VST000182	RT00870	2	t
LOG0009802	USR0233	VST004621	RT00541	2	f
LOG0009803	USR0253	VST004116	RT00919	3	t
LOG0009804	USR0443	VST004947	RT00699	1	f
LOG0009805	USR0224	VST002946	RT00849	3	t
LOG0009806	USR0340	VST002058	RT00507	2	f
LOG0009807	USR0004	VST002748	RT00177	1	f
LOG0009808	USR0353	VST001881	RT00439	3	t
LOG0009809	USR0112	VST003603	RT00843	3	f
LOG0009810	USR0193	VST000655	RT00668	3	t
LOG0009811	USR0141	VST003687	RT00758	2	f
LOG0009812	USR0323	VST002289	RT00711	3	f
LOG0009813	USR0140	VST002200	RT00511	2	t
LOG0009814	USR0349	VST002832	RT00109	1	f
LOG0009815	USR0439	VST003409	RT00872	4	f
LOG0009816	USR0445	VST002236	RT00072	1	t
LOG0009817	USR0095	VST002512	RT00489	3	f
LOG0009818	USR0041	VST000722	RT00733	2	f
LOG0009819	USR0420	VST003249	RT00281	3	f
LOG0009820	USR0002	VST001201	RT00903	1	f
LOG0009821	USR0278	VST004977	RT00889	4	f
LOG0009822	USR0150	VST002463	RT00214	4	t
LOG0009823	USR0041	VST004674	RT00457	2	t
LOG0009824	USR0351	VST000310	RT00587	1	t
LOG0009825	USR0116	VST001026	RT00418	1	f
LOG0009826	USR0120	VST004413	RT00987	2	t
LOG0009827	USR0237	VST001533	RT00754	2	f
LOG0009828	USR0270	VST003644	RT00510	2	t
LOG0009829	USR0349	VST000368	RT00662	3	t
LOG0009830	USR0291	VST004651	RT00323	3	f
LOG0009831	USR0434	VST002653	RT00178	2	t
LOG0009832	USR0009	VST001250	RT00688	2	f
LOG0009833	USR0239	VST002984	RT00104	4	f
LOG0009834	USR0118	VST004576	RT00119	4	f
LOG0009835	USR0352	VST003029	RT00712	3	f
LOG0009836	USR0315	VST003135	RT00582	4	t
LOG0009837	USR0312	VST004096	RT00057	2	f
LOG0009838	USR0475	VST000940	RT00409	1	f
LOG0009839	USR0010	VST004110	RT00578	2	f
LOG0009840	USR0025	VST004238	RT00912	4	f
LOG0009841	USR0497	VST004024	RT00058	3	t
LOG0009842	USR0173	VST003692	RT00117	2	f
LOG0009843	USR0225	VST000590	RT00425	2	t
LOG0009844	USR0011	VST001783	RT00819	4	t
LOG0009845	USR0101	VST004569	RT00021	1	f
LOG0009846	USR0265	VST001208	RT00079	2	t
LOG0009847	USR0391	VST004413	RT00824	3	f
LOG0009848	USR0327	VST004541	RT00866	3	f
LOG0009849	USR0418	VST002344	RT00559	1	f
LOG0009850	USR0083	VST000847	RT00886	4	t
LOG0009851	USR0276	VST002425	RT00683	1	f
LOG0009852	USR0370	VST004681	RT00596	3	t
LOG0009853	USR0490	VST000799	RT00108	2	f
LOG0009854	USR0345	VST000471	RT00799	3	f
LOG0009855	USR0261	VST003910	RT00271	1	f
LOG0009856	USR0368	VST004828	RT00688	3	t
LOG0009857	USR0221	VST002095	RT00830	4	f
LOG0009858	USR0311	VST002995	RT00476	1	t
LOG0009859	USR0219	VST003130	RT00070	3	f
LOG0009860	USR0089	VST001314	RT00387	2	t
LOG0009861	USR0485	VST002879	RT00166	2	f
LOG0009862	USR0015	VST003516	RT00855	1	f
LOG0009863	USR0246	VST001048	RT00058	2	t
LOG0009864	USR0176	VST001088	RT00451	1	f
LOG0009865	USR0004	VST003682	RT00245	2	f
LOG0009866	USR0334	VST000283	RT00045	3	f
LOG0009867	USR0376	VST003649	RT00684	2	t
LOG0009868	USR0369	VST001399	RT00776	3	t
LOG0009869	USR0465	VST002734	RT00383	1	t
LOG0009870	USR0021	VST004068	RT00578	2	t
LOG0009871	USR0208	VST002358	RT00839	4	f
LOG0009872	USR0474	VST002936	RT00701	4	f
LOG0009873	USR0137	VST003819	RT00785	4	t
LOG0009874	USR0322	VST003239	RT00071	2	f
LOG0009875	USR0363	VST001773	RT00865	3	t
LOG0009876	USR0463	VST004078	RT00548	1	f
LOG0009877	USR0419	VST004103	RT00239	2	t
LOG0009878	USR0216	VST000788	RT00580	1	t
LOG0009879	USR0368	VST003225	RT00108	1	t
LOG0009880	USR0117	VST000043	RT00208	2	f
LOG0009881	USR0179	VST004297	RT00789	3	t
LOG0009882	USR0246	VST002943	RT00722	4	t
LOG0009883	USR0128	VST004644	RT00302	1	f
LOG0009884	USR0358	VST004322	RT00430	1	f
LOG0009885	USR0078	VST003906	RT00348	2	f
LOG0009886	USR0229	VST004729	RT00107	1	t
LOG0009887	USR0293	VST003411	RT00892	2	f
LOG0009888	USR0262	VST001359	RT00528	1	t
LOG0009889	USR0082	VST001205	RT00751	3	f
LOG0009890	USR0342	VST003605	RT00406	3	t
LOG0009891	USR0338	VST002994	RT00902	4	t
LOG0009892	USR0307	VST002242	RT00734	4	t
LOG0009893	USR0066	VST000538	RT00952	3	f
LOG0009894	USR0096	VST004012	RT00256	4	t
LOG0009895	USR0145	VST003869	RT00301	4	t
LOG0009896	USR0065	VST004577	RT00954	4	t
LOG0009897	USR0009	VST004526	RT00924	3	f
LOG0009898	USR0397	VST003584	RT00145	4	f
LOG0009899	USR0484	VST001351	RT00676	2	f
LOG0009900	USR0357	VST000945	RT00524	4	t
LOG0009901	USR0186	VST003857	RT00562	2	t
LOG0009902	USR0158	VST001824	RT00827	4	f
LOG0009903	USR0031	VST002626	RT00360	2	t
LOG0009904	USR0151	VST003899	RT00524	4	f
LOG0009905	USR0319	VST003488	RT00484	2	f
LOG0009906	USR0242	VST004207	RT00190	4	f
LOG0009907	USR0156	VST004308	RT00296	2	f
LOG0009908	USR0059	VST000851	RT00093	3	f
LOG0009909	USR0010	VST002926	RT00130	1	f
LOG0009910	USR0345	VST000996	RT00861	1	f
LOG0009911	USR0124	VST004762	RT00990	3	t
LOG0009912	USR0356	VST000350	RT00484	3	t
LOG0009913	USR0346	VST001538	RT00876	2	f
LOG0009914	USR0282	VST002978	RT00409	2	t
LOG0009915	USR0237	VST002729	RT00341	4	f
LOG0009916	USR0333	VST004347	RT00214	4	t
LOG0009917	USR0017	VST002367	RT00330	1	f
LOG0009918	USR0424	VST002237	RT00895	1	t
LOG0009919	USR0324	VST003876	RT00799	2	f
LOG0009920	USR0023	VST003095	RT00175	2	t
LOG0009921	USR0419	VST003602	RT00444	3	f
LOG0009922	USR0459	VST004175	RT00201	2	f
LOG0009923	USR0460	VST004642	RT00617	4	t
LOG0009924	USR0009	VST000924	RT00743	3	f
LOG0009925	USR0207	VST000619	RT00098	2	f
LOG0009926	USR0045	VST004401	RT00103	4	f
LOG0009927	USR0421	VST003263	RT00553	4	t
LOG0009928	USR0453	VST003304	RT00946	1	t
LOG0009929	USR0403	VST002602	RT00151	3	t
LOG0009930	USR0331	VST001048	RT00268	1	t
LOG0009931	USR0457	VST001699	RT00839	3	t
LOG0009932	USR0483	VST002231	RT00352	3	f
LOG0009933	USR0498	VST001869	RT00467	1	f
LOG0009934	USR0027	VST002655	RT00278	1	t
LOG0009935	USR0397	VST000083	RT00568	2	t
LOG0009936	USR0441	VST000093	RT00016	3	t
LOG0009937	USR0188	VST003157	RT00954	2	f
LOG0009938	USR0140	VST003049	RT00456	3	f
LOG0009939	USR0009	VST001468	RT00734	4	t
LOG0009940	USR0234	VST002025	RT00179	2	t
LOG0009941	USR0092	VST004870	RT00134	1	t
LOG0009942	USR0077	VST003818	RT00258	4	f
LOG0009943	USR0340	VST002699	RT00062	1	t
LOG0009944	USR0244	VST000792	RT00482	4	t
LOG0009945	USR0333	VST000476	RT00477	4	f
LOG0009946	USR0155	VST000504	RT01000	2	t
LOG0009947	USR0218	VST000231	RT00635	1	t
LOG0009948	USR0447	VST001587	RT00042	2	t
LOG0009949	USR0477	VST001775	RT00373	4	f
LOG0009950	USR0285	VST003091	RT00373	3	f
LOG0009951	USR0150	VST002257	RT00299	3	f
LOG0009952	USR0329	VST003971	RT00052	4	f
LOG0009953	USR0088	VST004227	RT00379	1	t
LOG0009954	USR0106	VST004839	RT00954	1	f
LOG0009955	USR0403	VST000384	RT00916	1	f
LOG0009956	USR0294	VST003164	RT00312	3	f
LOG0009957	USR0095	VST002410	RT00579	2	f
LOG0009958	USR0253	VST000761	RT00059	1	t
LOG0009959	USR0039	VST003953	RT00304	2	f
LOG0009960	USR0399	VST000943	RT00035	1	f
LOG0009961	USR0255	VST002696	RT00648	1	f
LOG0009962	USR0054	VST001297	RT00588	1	f
LOG0009963	USR0416	VST002403	RT00754	2	f
LOG0009964	USR0243	VST002148	RT00493	2	t
LOG0009965	USR0110	VST001640	RT00491	2	f
LOG0009966	USR0254	VST004397	RT00800	4	f
LOG0009967	USR0112	VST000609	RT00221	3	t
LOG0009968	USR0174	VST000882	RT00813	4	f
LOG0009969	USR0189	VST002251	RT00597	3	t
LOG0009970	USR0221	VST003093	RT00123	4	t
LOG0009971	USR0249	VST002160	RT00707	3	t
LOG0009972	USR0052	VST002429	RT00102	2	t
LOG0009973	USR0162	VST004851	RT00795	3	t
LOG0009974	USR0457	VST003002	RT00887	1	t
LOG0009975	USR0035	VST004892	RT00515	2	f
LOG0009976	USR0454	VST001995	RT00313	4	t
LOG0009977	USR0037	VST001324	RT00506	1	f
LOG0009978	USR0334	VST004318	RT00961	1	t
LOG0009979	USR0317	VST001012	RT00494	2	f
LOG0009980	USR0111	VST004039	RT00759	1	t
LOG0009981	USR0370	VST000689	RT00660	2	f
LOG0009982	USR0177	VST004069	RT00199	3	t
LOG0009983	USR0009	VST004214	RT00633	2	f
LOG0009984	USR0275	VST004270	RT00681	2	f
LOG0009985	USR0471	VST001243	RT00513	4	f
LOG0009986	USR0121	VST003448	RT00330	1	t
LOG0009987	USR0105	VST002045	RT00621	4	f
LOG0009988	USR0156	VST000441	RT00972	4	t
LOG0009989	USR0336	VST001225	RT00900	4	f
LOG0009990	USR0026	VST002463	RT00327	4	t
LOG0009991	USR0422	VST004179	RT00010	4	t
LOG0009992	USR0296	VST002753	RT00982	1	f
LOG0009993	USR0025	VST001753	RT00127	1	f
LOG0009994	USR0355	VST004443	RT00985	1	t
LOG0009995	USR0374	VST004630	RT00669	4	t
LOG0009996	USR0069	VST003003	RT00231	1	t
LOG0009997	USR0327	VST004547	RT00015	4	f
LOG0009998	USR0151	VST003217	RT00787	1	f
LOG0009999	USR0345	VST003360	RT00487	1	f
LOG0010000	USR0065	VST003943	RT00442	1	f
\.


--
-- TOC entry 4952 (class 0 OID 16390)
-- Dependencies: 217
-- Data for Name: fact_visit_trx; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fact_visit_trx (visit_date, visit_timea, visit_timeb, visit_id, user_id, gym_id) FROM stdin;
2023-09-30	09:58:00+02	12:44:00+02	VST000001	USR0274	GYM006
2023-08-20	09:49:00+02	11:57:00+02	VST000002	USR0337	GYM003
2024-02-24	17:26:00+02	18:44:00+02	VST000003	USR0358	GYM001
2024-03-17	10:39:00+02	11:58:00+02	VST000004	USR0237	GYM004
2024-05-10	12:38:00+02	15:22:00+02	VST000005	USR0215	GYM002
2023-01-24	12:48:00+02	14:21:00+02	VST000006	USR0366	GYM002
2023-04-19	11:35:00+02	14:30:00+02	VST000007	USR0286	GYM006
2024-12-03	13:51:00+02	15:06:00+02	VST000008	USR0378	GYM002
2024-05-16	11:28:00+02	14:20:00+02	VST000009	USR0149	GYM002
2023-01-25	12:30:00+02	15:22:00+02	VST000010	USR0318	GYM006
2023-07-06	16:37:00+02	18:53:00+02	VST000011	USR0394	GYM002
2023-10-15	16:20:00+02	17:17:00+02	VST000012	USR0376	GYM001
2024-09-19	12:17:00+02	15:14:00+02	VST000013	USR0107	GYM003
2023-12-04	08:52:00+02	10:53:00+02	VST000014	USR0141	GYM006
2023-02-06	09:34:00+02	12:01:00+02	VST000015	USR0076	GYM004
2023-05-17	15:13:00+02	17:32:00+02	VST000016	USR0009	GYM006
2024-05-22	12:43:00+02	13:39:00+02	VST000017	USR0196	GYM005
2023-08-15	08:45:00+02	09:57:00+02	VST000018	USR0295	GYM004
2023-11-16	08:03:00+02	09:19:00+02	VST000019	USR0280	GYM005
2023-07-01	13:41:00+02	16:31:00+02	VST000020	USR0381	GYM006
2023-03-27	10:13:00+02	12:25:00+02	VST000021	USR0118	GYM005
2024-04-11	12:28:00+02	15:07:00+02	VST000022	USR0290	GYM004
2023-02-22	10:45:00+02	12:41:00+02	VST000023	USR0487	GYM001
2023-08-23	15:32:00+02	16:42:00+02	VST000024	USR0061	GYM006
2024-03-08	17:24:00+02	20:10:00+02	VST000025	USR0425	GYM006
2024-05-10	15:17:00+02	17:40:00+02	VST000026	USR0389	GYM002
2023-04-10	17:34:00+02	19:34:00+02	VST000027	USR0335	GYM006
2024-08-21	08:09:00+02	09:59:00+02	VST000028	USR0306	GYM006
2024-02-07	09:54:00+02	12:44:00+02	VST000029	USR0388	GYM001
2024-01-31	09:17:00+02	11:10:00+02	VST000030	USR0051	GYM002
2024-06-10	10:32:00+02	12:37:00+02	VST000031	USR0052	GYM003
2024-02-19	17:18:00+02	19:33:00+02	VST000032	USR0122	GYM005
2024-09-04	08:36:00+02	10:56:00+02	VST000033	USR0167	GYM004
2024-11-07	14:18:00+02	16:10:00+02	VST000034	USR0008	GYM003
2024-04-07	17:56:00+02	19:27:00+02	VST000035	USR0369	GYM002
2024-06-24	17:25:00+02	20:19:00+02	VST000036	USR0045	GYM001
2024-09-17	10:31:00+02	13:20:00+02	VST000037	USR0344	GYM004
2024-09-10	15:20:00+02	16:44:00+02	VST000038	USR0245	GYM005
2023-12-30	10:10:00+02	12:16:00+02	VST000039	USR0284	GYM006
2023-05-10	08:42:00+02	11:32:00+02	VST000040	USR0375	GYM006
2023-03-25	13:15:00+02	14:50:00+02	VST000041	USR0107	GYM003
2023-09-28	14:13:00+02	16:15:00+02	VST000042	USR0027	GYM005
2023-09-01	08:40:00+02	11:05:00+02	VST000043	USR0193	GYM002
2024-01-23	14:06:00+02	16:30:00+02	VST000044	USR0418	GYM005
2023-08-02	11:35:00+02	13:46:00+02	VST000045	USR0337	GYM001
2023-06-15	12:15:00+02	12:45:00+02	VST000046	USR0357	GYM003
2023-02-28	09:45:00+02	10:23:00+02	VST000047	USR0062	GYM003
2024-08-24	14:02:00+02	15:44:00+02	VST000048	USR0062	GYM001
2024-05-18	17:33:00+02	18:07:00+02	VST000049	USR0422	GYM005
2024-12-06	14:56:00+02	17:38:00+02	VST000050	USR0282	GYM001
2023-05-03	10:38:00+02	11:42:00+02	VST000051	USR0121	GYM004
2024-10-09	12:02:00+02	13:49:00+02	VST000052	USR0280	GYM001
2024-02-17	10:46:00+02	11:17:00+02	VST000053	USR0039	GYM005
2023-05-19	11:01:00+02	12:47:00+02	VST000054	USR0380	GYM001
2023-08-17	15:02:00+02	16:28:00+02	VST000055	USR0277	GYM002
2023-10-01	08:25:00+02	09:49:00+02	VST000056	USR0094	GYM006
2024-03-14	11:03:00+02	12:53:00+02	VST000057	USR0431	GYM001
2024-07-15	13:40:00+02	14:15:00+02	VST000058	USR0115	GYM006
2023-04-28	15:01:00+02	16:41:00+02	VST000059	USR0176	GYM001
2024-12-14	12:14:00+02	15:05:00+02	VST000060	USR0121	GYM005
2024-04-27	12:33:00+02	15:13:00+02	VST000061	USR0013	GYM004
2024-01-30	10:43:00+02	13:35:00+02	VST000062	USR0485	GYM004
2024-12-03	09:50:00+02	12:46:00+02	VST000063	USR0387	GYM006
2024-04-04	14:31:00+02	17:27:00+02	VST000064	USR0416	GYM005
2024-11-23	08:39:00+02	09:48:00+02	VST000065	USR0163	GYM005
2023-03-19	16:01:00+02	16:55:00+02	VST000066	USR0275	GYM005
2024-02-16	11:47:00+02	12:26:00+02	VST000067	USR0398	GYM002
2023-03-16	11:24:00+02	13:51:00+02	VST000068	USR0176	GYM003
2023-10-22	15:51:00+02	17:52:00+02	VST000069	USR0470	GYM001
2023-01-21	13:58:00+02	15:07:00+02	VST000070	USR0337	GYM005
2023-06-20	13:12:00+02	14:17:00+02	VST000071	USR0379	GYM005
2023-01-15	11:53:00+02	13:30:00+02	VST000072	USR0324	GYM005
2023-07-30	11:48:00+02	13:51:00+02	VST000073	USR0173	GYM004
2024-07-13	08:24:00+02	11:23:00+02	VST000074	USR0488	GYM005
2023-03-27	11:17:00+02	12:50:00+02	VST000075	USR0275	GYM001
2023-05-29	14:48:00+02	16:17:00+02	VST000076	USR0064	GYM005
2024-11-30	13:36:00+02	15:11:00+02	VST000077	USR0101	GYM001
2024-01-07	12:45:00+02	14:31:00+02	VST000078	USR0322	GYM002
2024-04-24	09:11:00+02	10:04:00+02	VST000079	USR0463	GYM003
2023-05-31	12:45:00+02	15:41:00+02	VST000080	USR0066	GYM004
2023-05-21	13:59:00+02	16:11:00+02	VST000081	USR0331	GYM001
2023-03-10	16:41:00+02	19:36:00+02	VST000082	USR0045	GYM006
2023-09-17	14:49:00+02	16:14:00+02	VST000083	USR0087	GYM002
2024-06-04	17:09:00+02	17:58:00+02	VST000084	USR0458	GYM003
2024-09-24	13:39:00+02	15:32:00+02	VST000085	USR0067	GYM003
2024-01-06	08:28:00+02	11:01:00+02	VST000086	USR0453	GYM003
2024-02-23	09:58:00+02	11:12:00+02	VST000087	USR0259	GYM001
2023-04-11	12:27:00+02	15:01:00+02	VST000088	USR0422	GYM002
2024-10-22	11:02:00+02	13:59:00+02	VST000089	USR0205	GYM005
2024-10-19	17:54:00+02	18:48:00+02	VST000090	USR0426	GYM006
2023-08-31	12:31:00+02	14:17:00+02	VST000091	USR0467	GYM002
2024-05-26	08:39:00+02	09:18:00+02	VST000092	USR0424	GYM002
2024-07-08	09:51:00+02	12:48:00+02	VST000093	USR0178	GYM002
2023-04-05	15:24:00+02	17:31:00+02	VST000094	USR0419	GYM001
2023-08-14	13:53:00+02	14:43:00+02	VST000095	USR0280	GYM006
2024-06-01	13:21:00+02	14:05:00+02	VST000096	USR0344	GYM001
2023-08-02	15:26:00+02	17:21:00+02	VST000097	USR0017	GYM006
2024-12-18	16:43:00+02	18:42:00+02	VST000098	USR0296	GYM006
2023-03-08	09:58:00+02	12:19:00+02	VST000099	USR0202	GYM001
2024-01-31	14:34:00+02	16:50:00+02	VST000100	USR0450	GYM006
2024-09-03	17:50:00+02	18:50:00+02	VST000101	USR0172	GYM002
2023-01-12	11:14:00+02	12:42:00+02	VST000102	USR0407	GYM001
2023-08-25	12:20:00+02	12:52:00+02	VST000103	USR0262	GYM006
2024-02-03	08:45:00+02	10:52:00+02	VST000104	USR0194	GYM003
2024-02-11	15:26:00+02	16:09:00+02	VST000105	USR0149	GYM001
2024-04-24	08:01:00+02	09:49:00+02	VST000106	USR0375	GYM004
2024-10-08	16:52:00+02	19:36:00+02	VST000107	USR0376	GYM001
2023-08-10	17:11:00+02	17:51:00+02	VST000108	USR0035	GYM001
2023-06-05	11:21:00+02	13:12:00+02	VST000109	USR0369	GYM001
2024-10-15	14:12:00+02	17:00:00+02	VST000110	USR0029	GYM006
2024-03-03	15:21:00+02	18:15:00+02	VST000111	USR0263	GYM001
2023-06-07	09:11:00+02	10:19:00+02	VST000112	USR0221	GYM004
2024-02-20	13:38:00+02	15:31:00+02	VST000113	USR0053	GYM005
2023-11-22	13:21:00+02	15:59:00+02	VST000114	USR0421	GYM001
2024-01-06	10:07:00+02	11:33:00+02	VST000115	USR0279	GYM003
2023-12-10	13:07:00+02	14:16:00+02	VST000116	USR0353	GYM004
2023-09-19	16:39:00+02	17:21:00+02	VST000117	USR0392	GYM005
2023-10-10	13:16:00+02	15:26:00+02	VST000118	USR0076	GYM006
2023-08-17	14:58:00+02	17:22:00+02	VST000119	USR0494	GYM001
2023-10-07	13:34:00+02	16:31:00+02	VST000120	USR0176	GYM005
2023-10-17	14:52:00+02	17:31:00+02	VST000121	USR0010	GYM003
2024-11-10	13:02:00+02	13:55:00+02	VST000122	USR0463	GYM004
2023-02-16	17:27:00+02	18:53:00+02	VST000123	USR0117	GYM004
2024-12-15	10:10:00+02	12:30:00+02	VST000124	USR0280	GYM006
2023-08-02	11:16:00+02	13:00:00+02	VST000125	USR0218	GYM006
2023-01-24	15:10:00+02	17:20:00+02	VST000126	USR0175	GYM006
2023-11-17	14:28:00+02	15:35:00+02	VST000127	USR0234	GYM005
2023-10-01	10:58:00+02	12:01:00+02	VST000128	USR0437	GYM001
2024-07-09	17:42:00+02	19:38:00+02	VST000129	USR0252	GYM002
2023-11-09	13:08:00+02	13:59:00+02	VST000130	USR0295	GYM004
2023-12-29	14:55:00+02	17:26:00+02	VST000131	USR0451	GYM002
2024-10-29	17:21:00+02	20:17:00+02	VST000132	USR0322	GYM004
2024-01-15	08:00:00+02	08:42:00+02	VST000133	USR0006	GYM006
2024-12-11	13:11:00+02	16:01:00+02	VST000134	USR0021	GYM001
2024-11-04	12:53:00+02	15:05:00+02	VST000135	USR0073	GYM001
2024-04-14	11:35:00+02	13:12:00+02	VST000136	USR0330	GYM004
2024-11-05	15:20:00+02	16:11:00+02	VST000137	USR0036	GYM005
2023-04-26	17:53:00+02	20:05:00+02	VST000138	USR0387	GYM006
2024-08-27	13:29:00+02	16:07:00+02	VST000139	USR0233	GYM001
2023-02-11	15:56:00+02	18:17:00+02	VST000140	USR0216	GYM001
2024-01-14	15:32:00+02	16:35:00+02	VST000141	USR0470	GYM003
2024-12-22	15:32:00+02	16:36:00+02	VST000142	USR0497	GYM001
2023-07-25	11:38:00+02	14:11:00+02	VST000143	USR0206	GYM003
2024-04-10	16:43:00+02	19:36:00+02	VST000144	USR0426	GYM001
2023-10-07	16:04:00+02	17:24:00+02	VST000145	USR0429	GYM001
2024-10-09	10:53:00+02	13:27:00+02	VST000146	USR0044	GYM005
2024-09-09	09:26:00+02	11:37:00+02	VST000147	USR0091	GYM005
2023-04-28	12:50:00+02	15:46:00+02	VST000148	USR0417	GYM006
2023-08-25	16:47:00+02	18:07:00+02	VST000149	USR0316	GYM001
2023-11-05	13:43:00+02	16:36:00+02	VST000150	USR0470	GYM006
2024-03-31	09:35:00+02	12:19:00+02	VST000151	USR0093	GYM006
2024-04-19	12:00:00+02	13:33:00+02	VST000152	USR0467	GYM006
2023-04-10	13:17:00+02	14:49:00+02	VST000153	USR0339	GYM006
2023-09-18	11:50:00+02	12:38:00+02	VST000154	USR0454	GYM004
2023-11-01	11:23:00+02	13:01:00+02	VST000155	USR0493	GYM004
2023-12-20	10:30:00+02	12:50:00+02	VST000156	USR0083	GYM001
2023-10-13	08:25:00+02	10:17:00+02	VST000157	USR0333	GYM004
2023-11-24	08:47:00+02	11:44:00+02	VST000158	USR0282	GYM001
2023-04-13	12:10:00+02	13:02:00+02	VST000159	USR0470	GYM005
2023-03-04	16:06:00+02	17:04:00+02	VST000160	USR0021	GYM002
2024-11-17	09:14:00+02	11:29:00+02	VST000161	USR0228	GYM003
2023-10-09	15:46:00+02	18:04:00+02	VST000162	USR0376	GYM004
2024-03-16	15:04:00+02	17:07:00+02	VST000163	USR0130	GYM004
2023-10-20	17:49:00+02	19:48:00+02	VST000164	USR0175	GYM005
2023-01-07	11:19:00+02	12:37:00+02	VST000165	USR0108	GYM004
2024-09-30	14:33:00+02	16:25:00+02	VST000166	USR0414	GYM001
2023-04-02	16:26:00+02	18:24:00+02	VST000167	USR0283	GYM001
2023-07-09	14:49:00+02	15:25:00+02	VST000168	USR0071	GYM002
2024-04-20	12:09:00+02	13:57:00+02	VST000169	USR0404	GYM002
2024-05-25	10:31:00+02	11:44:00+02	VST000170	USR0050	GYM002
2024-04-06	08:05:00+02	10:04:00+02	VST000171	USR0095	GYM001
2023-02-22	09:49:00+02	12:12:00+02	VST000172	USR0279	GYM006
2024-04-30	15:15:00+02	16:22:00+02	VST000173	USR0397	GYM006
2024-10-05	11:44:00+02	14:06:00+02	VST000174	USR0337	GYM002
2024-05-04	11:00:00+02	11:41:00+02	VST000175	USR0132	GYM002
2023-12-30	16:50:00+02	18:19:00+02	VST000176	USR0398	GYM001
2023-04-22	15:55:00+02	17:16:00+02	VST000177	USR0276	GYM005
2024-02-13	08:51:00+02	10:56:00+02	VST000178	USR0380	GYM004
2023-01-07	17:30:00+02	18:39:00+02	VST000179	USR0013	GYM003
2024-10-29	12:15:00+02	13:06:00+02	VST000180	USR0003	GYM006
2023-07-16	10:04:00+02	11:02:00+02	VST000181	USR0474	GYM006
2024-01-02	15:47:00+02	16:30:00+02	VST000182	USR0474	GYM001
2023-09-07	10:16:00+02	11:48:00+02	VST000183	USR0466	GYM001
2024-08-17	15:55:00+02	17:02:00+02	VST000184	USR0224	GYM003
2023-08-28	17:03:00+02	18:46:00+02	VST000185	USR0462	GYM003
2024-01-15	17:32:00+02	18:05:00+02	VST000186	USR0175	GYM002
2024-04-15	13:24:00+02	15:21:00+02	VST000187	USR0387	GYM003
2024-12-01	15:33:00+02	16:31:00+02	VST000188	USR0385	GYM004
2024-03-30	16:36:00+02	18:24:00+02	VST000189	USR0090	GYM004
2024-01-01	15:16:00+02	17:41:00+02	VST000190	USR0408	GYM006
2023-10-17	17:21:00+02	19:51:00+02	VST000191	USR0241	GYM004
2024-02-07	15:36:00+02	16:11:00+02	VST000192	USR0035	GYM004
2023-02-27	10:42:00+02	12:36:00+02	VST000193	USR0014	GYM004
2024-06-04	16:06:00+02	17:29:00+02	VST000194	USR0195	GYM002
2023-10-31	15:40:00+02	18:27:00+02	VST000195	USR0397	GYM006
2023-04-25	12:25:00+02	13:49:00+02	VST000196	USR0431	GYM001
2023-07-29	12:13:00+02	13:35:00+02	VST000197	USR0306	GYM006
2023-02-10	12:43:00+02	15:32:00+02	VST000198	USR0334	GYM006
2023-06-22	16:53:00+02	19:36:00+02	VST000199	USR0213	GYM006
2023-08-22	16:16:00+02	17:52:00+02	VST000200	USR0410	GYM003
2024-08-12	12:04:00+02	14:54:00+02	VST000201	USR0003	GYM001
2024-09-11	12:41:00+02	15:14:00+02	VST000202	USR0179	GYM003
2024-02-07	15:30:00+02	16:36:00+02	VST000203	USR0040	GYM002
2023-02-08	09:19:00+02	09:53:00+02	VST000204	USR0452	GYM002
2023-04-29	12:52:00+02	14:58:00+02	VST000205	USR0164	GYM005
2023-12-01	12:00:00+02	14:59:00+02	VST000206	USR0307	GYM005
2023-12-02	12:38:00+02	15:22:00+02	VST000207	USR0235	GYM002
2024-06-22	13:43:00+02	14:24:00+02	VST000208	USR0257	GYM002
2024-09-07	13:27:00+02	15:02:00+02	VST000209	USR0360	GYM003
2023-03-15	17:13:00+02	18:26:00+02	VST000210	USR0495	GYM002
2023-07-10	09:22:00+02	10:07:00+02	VST000211	USR0417	GYM001
2023-11-20	10:21:00+02	12:03:00+02	VST000212	USR0391	GYM003
2023-05-27	10:34:00+02	11:55:00+02	VST000213	USR0373	GYM002
2023-10-11	11:56:00+02	13:35:00+02	VST000214	USR0116	GYM003
2023-08-01	14:32:00+02	15:15:00+02	VST000215	USR0052	GYM003
2024-09-26	10:36:00+02	13:05:00+02	VST000216	USR0376	GYM004
2024-12-18	11:39:00+02	12:11:00+02	VST000217	USR0395	GYM005
2024-01-29	09:05:00+02	09:52:00+02	VST000218	USR0411	GYM003
2023-12-05	15:04:00+02	17:13:00+02	VST000219	USR0142	GYM006
2023-01-22	14:57:00+02	16:36:00+02	VST000220	USR0086	GYM003
2023-04-15	13:38:00+02	15:40:00+02	VST000221	USR0464	GYM006
2024-04-10	17:15:00+02	18:12:00+02	VST000222	USR0046	GYM004
2024-04-03	15:57:00+02	16:31:00+02	VST000223	USR0332	GYM002
2024-03-07	15:05:00+02	16:49:00+02	VST000224	USR0497	GYM003
2024-12-16	09:03:00+02	11:11:00+02	VST000225	USR0238	GYM004
2024-09-10	11:31:00+02	13:00:00+02	VST000226	USR0010	GYM001
2023-08-09	15:10:00+02	17:17:00+02	VST000227	USR0152	GYM004
2024-01-14	14:38:00+02	17:18:00+02	VST000228	USR0061	GYM005
2023-08-10	17:58:00+02	18:53:00+02	VST000229	USR0494	GYM005
2023-09-15	08:20:00+02	10:10:00+02	VST000230	USR0018	GYM002
2024-12-13	17:49:00+02	20:23:00+02	VST000231	USR0086	GYM006
2024-01-02	14:29:00+02	17:15:00+02	VST000232	USR0137	GYM002
2023-12-15	16:08:00+02	17:00:00+02	VST000233	USR0401	GYM006
2023-08-13	08:06:00+02	09:23:00+02	VST000234	USR0230	GYM006
2024-12-14	14:00:00+02	15:20:00+02	VST000235	USR0128	GYM006
2023-08-24	13:05:00+02	15:43:00+02	VST000236	USR0104	GYM006
2023-07-02	14:39:00+02	17:06:00+02	VST000237	USR0186	GYM005
2024-12-12	15:09:00+02	18:02:00+02	VST000238	USR0397	GYM005
2024-03-19	17:11:00+02	17:46:00+02	VST000239	USR0178	GYM003
2024-09-14	17:19:00+02	17:59:00+02	VST000240	USR0357	GYM005
2023-01-06	11:45:00+02	13:18:00+02	VST000241	USR0006	GYM002
2023-08-24	16:19:00+02	19:04:00+02	VST000242	USR0341	GYM005
2023-05-07	11:44:00+02	13:32:00+02	VST000243	USR0307	GYM002
2023-04-14	12:39:00+02	14:34:00+02	VST000244	USR0036	GYM001
2024-04-24	15:26:00+02	18:01:00+02	VST000245	USR0327	GYM005
2023-06-04	16:17:00+02	18:27:00+02	VST000246	USR0356	GYM002
2023-09-14	08:29:00+02	09:39:00+02	VST000247	USR0281	GYM006
2023-08-23	14:38:00+02	15:12:00+02	VST000248	USR0395	GYM004
2024-05-14	13:44:00+02	15:42:00+02	VST000249	USR0300	GYM006
2023-10-16	14:54:00+02	16:54:00+02	VST000250	USR0014	GYM003
2024-05-24	10:49:00+02	12:49:00+02	VST000251	USR0237	GYM002
2024-07-05	15:58:00+02	17:45:00+02	VST000252	USR0285	GYM006
2024-12-09	10:10:00+02	11:40:00+02	VST000253	USR0330	GYM005
2024-07-22	17:06:00+02	19:44:00+02	VST000254	USR0050	GYM005
2023-10-25	08:27:00+02	10:07:00+02	VST000255	USR0496	GYM001
2024-09-01	14:43:00+02	15:28:00+02	VST000256	USR0261	GYM004
2023-05-17	17:37:00+02	19:12:00+02	VST000257	USR0456	GYM002
2024-01-11	08:27:00+02	10:36:00+02	VST000258	USR0110	GYM006
2023-03-28	09:25:00+02	10:02:00+02	VST000259	USR0197	GYM004
2024-02-23	15:18:00+02	18:10:00+02	VST000260	USR0378	GYM001
2023-07-18	10:18:00+02	11:59:00+02	VST000261	USR0252	GYM003
2024-04-07	15:52:00+02	17:19:00+02	VST000262	USR0088	GYM004
2024-03-12	11:06:00+02	12:14:00+02	VST000263	USR0488	GYM001
2023-11-06	08:51:00+02	10:48:00+02	VST000264	USR0313	GYM002
2024-08-18	12:26:00+02	14:36:00+02	VST000265	USR0026	GYM003
2023-10-08	14:28:00+02	15:33:00+02	VST000266	USR0262	GYM005
2023-11-19	13:35:00+02	14:27:00+02	VST000267	USR0144	GYM001
2024-12-02	11:36:00+02	13:43:00+02	VST000268	USR0060	GYM005
2023-06-01	15:45:00+02	18:28:00+02	VST000269	USR0356	GYM003
2023-10-29	13:34:00+02	15:02:00+02	VST000270	USR0268	GYM001
2023-10-05	13:45:00+02	16:01:00+02	VST000271	USR0075	GYM001
2024-10-12	14:28:00+02	15:59:00+02	VST000272	USR0003	GYM003
2024-11-18	12:44:00+02	15:40:00+02	VST000273	USR0063	GYM002
2023-01-08	15:11:00+02	16:20:00+02	VST000274	USR0236	GYM001
2023-08-23	12:18:00+02	14:37:00+02	VST000275	USR0448	GYM003
2024-11-05	09:23:00+02	11:12:00+02	VST000276	USR0446	GYM004
2024-07-14	16:01:00+02	17:55:00+02	VST000277	USR0229	GYM005
2023-10-29	08:19:00+02	10:43:00+02	VST000278	USR0390	GYM001
2023-02-07	17:12:00+02	20:00:00+02	VST000279	USR0275	GYM004
2023-05-16	08:53:00+02	09:56:00+02	VST000280	USR0018	GYM001
2024-02-25	13:58:00+02	15:20:00+02	VST000281	USR0080	GYM002
2023-08-07	11:49:00+02	12:54:00+02	VST000282	USR0215	GYM003
2023-12-14	09:10:00+02	12:08:00+02	VST000283	USR0171	GYM001
2024-06-29	08:41:00+02	11:29:00+02	VST000284	USR0485	GYM003
2023-03-20	08:31:00+02	09:52:00+02	VST000285	USR0329	GYM006
2023-09-30	12:13:00+02	13:18:00+02	VST000286	USR0255	GYM001
2023-06-10	11:24:00+02	13:13:00+02	VST000287	USR0387	GYM002
2024-11-17	08:20:00+02	11:04:00+02	VST000288	USR0126	GYM002
2023-11-04	10:36:00+02	11:40:00+02	VST000289	USR0255	GYM004
2024-01-09	12:04:00+02	14:24:00+02	VST000290	USR0072	GYM002
2023-01-09	10:09:00+02	11:16:00+02	VST000291	USR0038	GYM003
2024-03-19	16:04:00+02	18:58:00+02	VST000292	USR0324	GYM006
2023-04-23	09:57:00+02	11:07:00+02	VST000293	USR0204	GYM002
2023-07-24	17:37:00+02	19:28:00+02	VST000294	USR0172	GYM001
2024-02-09	11:43:00+02	12:30:00+02	VST000295	USR0223	GYM002
2024-11-28	15:56:00+02	18:48:00+02	VST000296	USR0217	GYM006
2023-07-16	12:22:00+02	15:08:00+02	VST000297	USR0245	GYM003
2023-04-25	14:17:00+02	15:17:00+02	VST000298	USR0336	GYM001
2023-05-01	10:51:00+02	12:08:00+02	VST000299	USR0191	GYM004
2024-10-14	09:57:00+02	11:48:00+02	VST000300	USR0298	GYM004
2023-03-06	10:47:00+02	11:54:00+02	VST000301	USR0320	GYM004
2023-10-03	13:18:00+02	13:55:00+02	VST000302	USR0182	GYM001
2023-08-27	09:50:00+02	11:41:00+02	VST000303	USR0334	GYM004
2023-10-29	17:52:00+02	20:07:00+02	VST000304	USR0383	GYM002
2024-01-27	08:26:00+02	10:41:00+02	VST000305	USR0205	GYM001
2024-06-05	13:19:00+02	15:06:00+02	VST000306	USR0361	GYM001
2024-01-04	17:49:00+02	20:12:00+02	VST000307	USR0199	GYM001
2023-08-21	14:24:00+02	16:04:00+02	VST000308	USR0332	GYM005
2023-07-14	14:46:00+02	15:54:00+02	VST000309	USR0165	GYM003
2023-01-12	11:23:00+02	12:41:00+02	VST000310	USR0242	GYM005
2024-11-19	09:17:00+02	10:14:00+02	VST000311	USR0388	GYM005
2023-06-26	12:08:00+02	13:11:00+02	VST000312	USR0130	GYM005
2023-08-05	09:44:00+02	11:01:00+02	VST000313	USR0227	GYM003
2023-01-11	13:08:00+02	13:44:00+02	VST000314	USR0122	GYM005
2024-03-21	10:03:00+02	11:41:00+02	VST000315	USR0044	GYM004
2024-09-21	17:39:00+02	20:34:00+02	VST000316	USR0451	GYM001
2023-06-13	08:42:00+02	10:11:00+02	VST000317	USR0196	GYM001
2024-07-04	13:55:00+02	15:24:00+02	VST000318	USR0358	GYM002
2023-02-22	17:05:00+02	18:34:00+02	VST000319	USR0204	GYM006
2023-08-06	15:18:00+02	15:54:00+02	VST000320	USR0467	GYM004
2024-12-18	14:19:00+02	16:20:00+02	VST000321	USR0458	GYM003
2023-12-26	09:10:00+02	10:00:00+02	VST000322	USR0318	GYM006
2024-01-20	16:38:00+02	19:10:00+02	VST000323	USR0257	GYM001
2023-02-25	13:49:00+02	14:53:00+02	VST000324	USR0017	GYM005
2023-04-28	08:12:00+02	10:50:00+02	VST000325	USR0272	GYM002
2023-09-10	15:10:00+02	17:40:00+02	VST000326	USR0009	GYM002
2023-06-29	16:21:00+02	18:26:00+02	VST000327	USR0249	GYM001
2024-02-19	09:48:00+02	11:05:00+02	VST000328	USR0437	GYM004
2023-08-23	15:23:00+02	17:32:00+02	VST000329	USR0201	GYM006
2024-12-08	14:10:00+02	16:45:00+02	VST000330	USR0059	GYM002
2023-03-21	15:50:00+02	18:21:00+02	VST000331	USR0375	GYM001
2024-10-08	10:36:00+02	11:41:00+02	VST000332	USR0393	GYM004
2023-01-22	15:25:00+02	16:36:00+02	VST000333	USR0140	GYM001
2024-04-21	11:00:00+02	12:19:00+02	VST000334	USR0119	GYM001
2024-03-15	16:54:00+02	18:21:00+02	VST000335	USR0041	GYM004
2024-07-23	12:36:00+02	13:14:00+02	VST000336	USR0399	GYM004
2023-04-03	17:11:00+02	19:25:00+02	VST000337	USR0322	GYM004
2023-07-11	16:15:00+02	16:48:00+02	VST000338	USR0331	GYM001
2023-04-13	15:56:00+02	17:35:00+02	VST000339	USR0267	GYM002
2024-01-31	15:26:00+02	17:41:00+02	VST000340	USR0008	GYM003
2023-01-07	12:34:00+02	14:00:00+02	VST000341	USR0183	GYM003
2024-10-01	13:30:00+02	14:51:00+02	VST000342	USR0480	GYM001
2024-07-20	12:11:00+02	13:33:00+02	VST000343	USR0134	GYM001
2023-08-19	09:28:00+02	10:14:00+02	VST000344	USR0181	GYM002
2024-07-27	12:45:00+02	14:00:00+02	VST000345	USR0404	GYM004
2023-08-28	15:41:00+02	18:03:00+02	VST000346	USR0423	GYM001
2023-03-31	12:09:00+02	14:44:00+02	VST000347	USR0355	GYM005
2023-08-20	15:55:00+02	17:48:00+02	VST000348	USR0072	GYM004
2024-04-01	17:43:00+02	20:10:00+02	VST000349	USR0498	GYM001
2023-08-21	14:28:00+02	16:01:00+02	VST000350	USR0113	GYM005
2023-12-20	13:44:00+02	16:03:00+02	VST000351	USR0107	GYM006
2023-11-29	08:29:00+02	10:42:00+02	VST000352	USR0290	GYM002
2024-03-14	16:26:00+02	17:06:00+02	VST000353	USR0313	GYM005
2024-01-10	13:32:00+02	15:39:00+02	VST000354	USR0117	GYM001
2023-10-19	11:06:00+02	12:56:00+02	VST000355	USR0120	GYM003
2023-12-11	16:19:00+02	18:29:00+02	VST000356	USR0147	GYM001
2024-10-25	11:37:00+02	14:33:00+02	VST000357	USR0327	GYM003
2024-03-03	14:03:00+02	16:50:00+02	VST000358	USR0415	GYM002
2024-10-18	12:24:00+02	15:08:00+02	VST000359	USR0210	GYM002
2023-05-10	13:48:00+02	14:27:00+02	VST000360	USR0296	GYM004
2023-05-21	12:46:00+02	15:29:00+02	VST000361	USR0398	GYM004
2024-02-19	12:42:00+02	13:39:00+02	VST000362	USR0103	GYM003
2023-04-03	17:29:00+02	19:54:00+02	VST000363	USR0124	GYM003
2024-09-17	08:10:00+02	10:36:00+02	VST000364	USR0245	GYM002
2023-10-11	16:49:00+02	17:29:00+02	VST000365	USR0379	GYM005
2024-10-16	11:15:00+02	12:47:00+02	VST000366	USR0356	GYM003
2023-08-11	09:27:00+02	12:09:00+02	VST000367	USR0209	GYM003
2024-04-07	12:07:00+02	14:54:00+02	VST000368	USR0421	GYM005
2024-06-28	14:56:00+02	17:07:00+02	VST000369	USR0428	GYM004
2023-10-03	16:20:00+02	17:00:00+02	VST000370	USR0393	GYM004
2024-11-12	17:28:00+02	20:20:00+02	VST000371	USR0314	GYM003
2023-05-20	12:06:00+02	14:15:00+02	VST000372	USR0404	GYM004
2023-12-23	16:07:00+02	18:49:00+02	VST000373	USR0109	GYM004
2024-12-13	16:22:00+02	17:04:00+02	VST000374	USR0377	GYM006
2023-01-23	15:38:00+02	16:56:00+02	VST000375	USR0348	GYM004
2023-09-27	08:17:00+02	10:01:00+02	VST000376	USR0050	GYM002
2024-10-26	09:35:00+02	11:57:00+02	VST000377	USR0404	GYM001
2023-11-29	13:01:00+02	15:12:00+02	VST000378	USR0105	GYM003
2023-03-26	11:46:00+02	13:33:00+02	VST000379	USR0420	GYM003
2024-09-12	14:54:00+02	16:37:00+02	VST000380	USR0373	GYM002
2023-01-31	12:09:00+02	14:37:00+02	VST000381	USR0027	GYM001
2023-08-28	13:13:00+02	14:25:00+02	VST000382	USR0456	GYM001
2023-12-29	17:55:00+02	20:13:00+02	VST000383	USR0288	GYM002
2024-01-24	14:17:00+02	16:02:00+02	VST000384	USR0257	GYM005
2024-10-14	16:04:00+02	16:47:00+02	VST000385	USR0273	GYM005
2024-10-29	17:26:00+02	20:08:00+02	VST000386	USR0137	GYM001
2023-10-26	17:03:00+02	18:09:00+02	VST000387	USR0340	GYM005
2024-01-06	13:52:00+02	16:20:00+02	VST000388	USR0301	GYM005
2023-04-09	15:15:00+02	17:40:00+02	VST000389	USR0480	GYM005
2023-02-16	17:23:00+02	18:16:00+02	VST000390	USR0322	GYM001
2024-02-26	13:38:00+02	16:16:00+02	VST000391	USR0032	GYM005
2024-04-24	14:00:00+02	14:58:00+02	VST000392	USR0045	GYM003
2024-08-01	15:44:00+02	17:00:00+02	VST000393	USR0265	GYM006
2023-03-03	12:37:00+02	15:36:00+02	VST000394	USR0030	GYM001
2023-04-19	13:13:00+02	16:02:00+02	VST000395	USR0084	GYM002
2024-11-09	12:17:00+02	13:21:00+02	VST000396	USR0166	GYM005
2024-07-02	11:56:00+02	14:06:00+02	VST000397	USR0316	GYM004
2023-04-29	10:03:00+02	12:18:00+02	VST000398	USR0001	GYM001
2024-08-20	11:17:00+02	13:09:00+02	VST000399	USR0249	GYM002
2024-01-17	13:23:00+02	15:48:00+02	VST000400	USR0261	GYM006
2024-01-27	10:02:00+02	10:38:00+02	VST000401	USR0063	GYM003
2023-02-21	17:08:00+02	18:23:00+02	VST000402	USR0483	GYM002
2024-08-25	11:09:00+02	13:35:00+02	VST000403	USR0164	GYM005
2023-10-16	11:16:00+02	12:37:00+02	VST000404	USR0321	GYM004
2023-12-03	11:41:00+02	14:07:00+02	VST000405	USR0334	GYM005
2023-07-23	16:15:00+02	17:08:00+02	VST000406	USR0201	GYM002
2023-08-26	12:43:00+02	14:17:00+02	VST000407	USR0222	GYM001
2024-01-17	16:57:00+02	18:49:00+02	VST000408	USR0152	GYM004
2024-10-28	12:49:00+02	14:00:00+02	VST000409	USR0132	GYM004
2023-05-16	09:42:00+02	10:43:00+02	VST000410	USR0114	GYM002
2024-02-11	11:18:00+02	12:11:00+02	VST000411	USR0462	GYM006
2024-05-22	13:03:00+02	14:02:00+02	VST000412	USR0217	GYM006
2023-12-28	11:52:00+02	14:17:00+02	VST000413	USR0196	GYM005
2024-01-16	14:09:00+02	16:11:00+02	VST000414	USR0281	GYM002
2024-07-29	11:03:00+02	11:54:00+02	VST000415	USR0202	GYM004
2024-09-26	13:09:00+02	15:53:00+02	VST000416	USR0483	GYM002
2023-09-11	08:14:00+02	10:22:00+02	VST000417	USR0135	GYM004
2024-04-21	17:06:00+02	19:46:00+02	VST000418	USR0234	GYM005
2023-04-24	10:09:00+02	11:19:00+02	VST000419	USR0141	GYM001
2023-01-20	12:40:00+02	14:46:00+02	VST000420	USR0196	GYM001
2024-06-11	08:46:00+02	11:36:00+02	VST000421	USR0498	GYM002
2023-05-25	08:55:00+02	11:02:00+02	VST000422	USR0043	GYM004
2023-07-27	17:26:00+02	18:07:00+02	VST000423	USR0057	GYM001
2024-06-14	12:59:00+02	14:12:00+02	VST000424	USR0420	GYM004
2024-01-11	10:09:00+02	12:04:00+02	VST000425	USR0142	GYM005
2024-05-18	16:22:00+02	19:16:00+02	VST000426	USR0210	GYM002
2023-06-15	09:45:00+02	10:53:00+02	VST000427	USR0072	GYM004
2024-07-03	08:12:00+02	09:23:00+02	VST000428	USR0224	GYM002
2023-06-30	17:47:00+02	18:54:00+02	VST000429	USR0027	GYM004
2024-09-08	12:51:00+02	14:06:00+02	VST000430	USR0128	GYM006
2024-09-03	16:00:00+02	16:43:00+02	VST000431	USR0106	GYM006
2024-08-24	16:10:00+02	18:27:00+02	VST000432	USR0165	GYM004
2024-03-19	15:31:00+02	17:19:00+02	VST000433	USR0215	GYM005
2023-11-28	13:48:00+02	15:37:00+02	VST000434	USR0071	GYM002
2024-05-17	11:08:00+02	13:32:00+02	VST000435	USR0204	GYM003
2023-03-20	08:52:00+02	10:35:00+02	VST000436	USR0153	GYM004
2024-08-07	12:18:00+02	13:34:00+02	VST000437	USR0067	GYM004
2024-11-18	16:09:00+02	17:09:00+02	VST000438	USR0090	GYM006
2024-01-31	09:56:00+02	10:59:00+02	VST000439	USR0260	GYM001
2024-08-30	09:06:00+02	10:27:00+02	VST000440	USR0362	GYM006
2023-04-13	14:50:00+02	15:20:00+02	VST000441	USR0228	GYM002
2024-02-06	16:23:00+02	17:57:00+02	VST000442	USR0079	GYM006
2023-08-12	09:15:00+02	09:48:00+02	VST000443	USR0096	GYM003
2024-06-01	17:50:00+02	20:17:00+02	VST000444	USR0349	GYM005
2024-09-25	08:54:00+02	11:31:00+02	VST000445	USR0330	GYM003
2023-08-24	10:35:00+02	13:12:00+02	VST000446	USR0469	GYM005
2024-03-02	10:32:00+02	13:21:00+02	VST000447	USR0382	GYM003
2023-04-26	17:36:00+02	18:07:00+02	VST000448	USR0246	GYM006
2023-06-12	13:11:00+02	15:47:00+02	VST000449	USR0272	GYM003
2023-08-14	09:27:00+02	10:57:00+02	VST000450	USR0495	GYM006
2023-08-18	12:14:00+02	13:39:00+02	VST000451	USR0403	GYM006
2023-07-01	10:01:00+02	13:01:00+02	VST000452	USR0157	GYM002
2023-09-06	17:31:00+02	20:02:00+02	VST000453	USR0116	GYM006
2023-11-14	15:06:00+02	17:32:00+02	VST000454	USR0435	GYM001
2023-07-29	11:51:00+02	14:05:00+02	VST000455	USR0018	GYM003
2024-10-17	16:55:00+02	19:18:00+02	VST000456	USR0442	GYM004
2024-01-27	14:29:00+02	15:19:00+02	VST000457	USR0172	GYM004
2023-04-06	15:41:00+02	16:12:00+02	VST000458	USR0016	GYM004
2023-03-27	15:33:00+02	17:05:00+02	VST000459	USR0449	GYM001
2024-02-19	13:04:00+02	15:54:00+02	VST000460	USR0240	GYM006
2024-01-29	15:19:00+02	17:00:00+02	VST000461	USR0386	GYM003
2024-11-26	13:12:00+02	16:04:00+02	VST000462	USR0056	GYM005
2024-09-24	17:42:00+02	19:05:00+02	VST000463	USR0079	GYM005
2024-05-15	09:01:00+02	09:43:00+02	VST000464	USR0103	GYM002
2024-08-26	09:41:00+02	10:58:00+02	VST000465	USR0284	GYM001
2024-08-04	11:32:00+02	12:39:00+02	VST000466	USR0193	GYM003
2023-05-13	11:36:00+02	12:20:00+02	VST000467	USR0005	GYM006
2024-10-10	12:30:00+02	14:29:00+02	VST000468	USR0106	GYM004
2023-11-10	09:23:00+02	10:02:00+02	VST000469	USR0278	GYM001
2024-11-29	10:40:00+02	11:47:00+02	VST000470	USR0373	GYM001
2023-08-09	12:05:00+02	12:43:00+02	VST000471	USR0100	GYM003
2024-03-13	10:57:00+02	13:54:00+02	VST000472	USR0238	GYM006
2023-02-15	17:25:00+02	19:11:00+02	VST000473	USR0269	GYM002
2023-07-11	09:16:00+02	11:10:00+02	VST000474	USR0321	GYM006
2024-06-03	10:40:00+02	11:32:00+02	VST000475	USR0400	GYM002
2024-01-14	08:02:00+02	08:44:00+02	VST000476	USR0489	GYM002
2024-11-21	14:58:00+02	15:55:00+02	VST000477	USR0086	GYM004
2023-11-30	15:41:00+02	17:57:00+02	VST000478	USR0320	GYM004
2023-02-08	16:01:00+02	17:16:00+02	VST000479	USR0032	GYM003
2023-10-20	12:58:00+02	14:09:00+02	VST000480	USR0336	GYM006
2024-11-20	08:33:00+02	10:15:00+02	VST000481	USR0051	GYM002
2023-06-11	11:57:00+02	14:53:00+02	VST000482	USR0079	GYM003
2023-11-27	12:55:00+02	15:48:00+02	VST000483	USR0186	GYM002
2023-04-14	12:49:00+02	14:04:00+02	VST000484	USR0174	GYM001
2023-06-10	15:44:00+02	18:10:00+02	VST000485	USR0436	GYM005
2024-09-26	09:12:00+02	12:10:00+02	VST000486	USR0106	GYM005
2023-02-23	11:59:00+02	14:01:00+02	VST000487	USR0063	GYM002
2023-02-03	12:30:00+02	13:09:00+02	VST000488	USR0076	GYM003
2023-08-30	11:22:00+02	12:15:00+02	VST000489	USR0316	GYM004
2023-04-23	15:15:00+02	17:01:00+02	VST000490	USR0321	GYM006
2023-11-14	09:57:00+02	11:49:00+02	VST000491	USR0373	GYM002
2023-01-23	17:17:00+02	19:21:00+02	VST000492	USR0081	GYM002
2024-07-11	11:50:00+02	13:57:00+02	VST000493	USR0361	GYM006
2024-10-08	10:32:00+02	11:19:00+02	VST000494	USR0128	GYM004
2023-04-28	12:32:00+02	14:51:00+02	VST000495	USR0183	GYM002
2024-12-01	10:25:00+02	13:15:00+02	VST000496	USR0243	GYM001
2024-10-04	09:13:00+02	09:59:00+02	VST000497	USR0185	GYM004
2023-07-31	09:01:00+02	10:45:00+02	VST000498	USR0498	GYM001
2024-02-22	10:49:00+02	13:19:00+02	VST000499	USR0220	GYM005
2023-04-23	13:14:00+02	14:18:00+02	VST000500	USR0071	GYM006
2023-02-13	17:42:00+02	18:43:00+02	VST000501	USR0457	GYM004
2023-05-08	12:55:00+02	14:35:00+02	VST000502	USR0342	GYM004
2023-06-07	15:29:00+02	17:23:00+02	VST000503	USR0154	GYM003
2024-01-29	10:07:00+02	12:51:00+02	VST000504	USR0245	GYM003
2024-05-26	15:59:00+02	18:14:00+02	VST000505	USR0140	GYM006
2023-02-14	13:11:00+02	15:55:00+02	VST000506	USR0071	GYM004
2023-04-18	14:52:00+02	16:15:00+02	VST000507	USR0046	GYM005
2023-08-07	12:38:00+02	14:01:00+02	VST000508	USR0047	GYM002
2024-03-18	16:32:00+02	17:16:00+02	VST000509	USR0079	GYM006
2023-11-11	17:12:00+02	18:09:00+02	VST000510	USR0422	GYM006
2023-06-26	16:25:00+02	19:21:00+02	VST000511	USR0149	GYM003
2023-08-16	15:28:00+02	18:13:00+02	VST000512	USR0398	GYM005
2024-12-03	09:22:00+02	10:14:00+02	VST000513	USR0130	GYM006
2024-11-02	08:40:00+02	11:13:00+02	VST000514	USR0456	GYM005
2023-09-24	15:22:00+02	17:05:00+02	VST000515	USR0127	GYM006
2024-01-14	13:30:00+02	15:49:00+02	VST000516	USR0365	GYM003
2024-05-03	12:16:00+02	14:07:00+02	VST000517	USR0119	GYM002
2024-12-02	08:26:00+02	10:02:00+02	VST000518	USR0454	GYM003
2024-11-17	09:33:00+02	12:17:00+02	VST000519	USR0485	GYM006
2023-10-17	11:54:00+02	14:51:00+02	VST000520	USR0357	GYM005
2023-12-23	17:49:00+02	19:49:00+02	VST000521	USR0417	GYM001
2024-10-18	08:21:00+02	09:24:00+02	VST000522	USR0489	GYM003
2023-07-23	12:35:00+02	15:29:00+02	VST000523	USR0262	GYM005
2023-08-01	17:50:00+02	20:27:00+02	VST000524	USR0244	GYM003
2024-07-05	08:41:00+02	11:24:00+02	VST000525	USR0474	GYM006
2023-11-19	10:59:00+02	13:36:00+02	VST000526	USR0382	GYM005
2024-08-16	16:01:00+02	18:37:00+02	VST000527	USR0103	GYM002
2023-06-30	16:51:00+02	18:07:00+02	VST000528	USR0489	GYM005
2024-05-13	15:32:00+02	17:01:00+02	VST000529	USR0037	GYM004
2023-11-16	12:44:00+02	14:28:00+02	VST000530	USR0142	GYM001
2023-03-24	11:05:00+02	12:24:00+02	VST000531	USR0037	GYM006
2023-10-30	17:59:00+02	18:29:00+02	VST000532	USR0008	GYM005
2023-09-19	15:26:00+02	16:26:00+02	VST000533	USR0231	GYM006
2023-07-19	16:23:00+02	16:59:00+02	VST000534	USR0333	GYM003
2023-08-28	09:33:00+02	12:02:00+02	VST000535	USR0397	GYM003
2024-11-22	16:01:00+02	17:01:00+02	VST000536	USR0296	GYM005
2024-11-13	13:56:00+02	15:19:00+02	VST000537	USR0107	GYM004
2023-10-22	14:58:00+02	17:14:00+02	VST000538	USR0348	GYM005
2024-05-26	13:41:00+02	15:56:00+02	VST000539	USR0442	GYM002
2024-11-19	13:28:00+02	14:09:00+02	VST000540	USR0018	GYM004
2024-01-31	09:47:00+02	11:42:00+02	VST000541	USR0313	GYM006
2023-05-18	10:44:00+02	12:43:00+02	VST000542	USR0083	GYM005
2023-05-09	13:37:00+02	16:30:00+02	VST000543	USR0422	GYM006
2023-02-18	15:01:00+02	16:25:00+02	VST000544	USR0288	GYM001
2024-11-06	16:27:00+02	16:59:00+02	VST000545	USR0470	GYM004
2023-10-20	12:55:00+02	14:16:00+02	VST000546	USR0194	GYM005
2024-09-19	14:50:00+02	16:32:00+02	VST000547	USR0461	GYM001
2024-06-19	17:23:00+02	18:58:00+02	VST000548	USR0215	GYM005
2023-11-07	08:37:00+02	09:24:00+02	VST000549	USR0281	GYM002
2024-06-20	15:45:00+02	17:33:00+02	VST000550	USR0220	GYM003
2024-09-30	09:30:00+02	11:16:00+02	VST000551	USR0442	GYM006
2023-08-22	13:22:00+02	16:01:00+02	VST000552	USR0459	GYM005
2023-07-28	12:18:00+02	15:08:00+02	VST000553	USR0289	GYM004
2024-08-27	13:31:00+02	15:23:00+02	VST000554	USR0344	GYM005
2023-04-04	09:58:00+02	10:29:00+02	VST000555	USR0194	GYM005
2023-11-23	14:53:00+02	15:52:00+02	VST000556	USR0158	GYM005
2023-08-13	16:46:00+02	18:41:00+02	VST000557	USR0465	GYM005
2023-01-11	08:01:00+02	09:58:00+02	VST000558	USR0104	GYM004
2023-11-25	17:15:00+02	19:26:00+02	VST000559	USR0034	GYM004
2023-01-12	15:53:00+02	18:48:00+02	VST000560	USR0102	GYM005
2023-02-04	15:03:00+02	15:40:00+02	VST000561	USR0127	GYM003
2024-03-22	08:55:00+02	10:09:00+02	VST000562	USR0214	GYM005
2024-03-27	11:12:00+02	12:31:00+02	VST000563	USR0325	GYM006
2023-08-08	16:50:00+02	18:44:00+02	VST000564	USR0432	GYM006
2024-03-16	14:10:00+02	16:06:00+02	VST000565	USR0296	GYM004
2024-10-14	16:30:00+02	19:02:00+02	VST000566	USR0179	GYM006
2024-06-18	15:32:00+02	18:03:00+02	VST000567	USR0080	GYM006
2024-08-17	08:52:00+02	09:31:00+02	VST000568	USR0141	GYM002
2023-08-17	11:28:00+02	12:32:00+02	VST000569	USR0474	GYM005
2023-12-10	12:33:00+02	15:06:00+02	VST000570	USR0031	GYM005
2023-03-21	17:22:00+02	18:31:00+02	VST000571	USR0372	GYM005
2023-12-19	10:14:00+02	12:41:00+02	VST000572	USR0423	GYM005
2024-01-31	12:54:00+02	15:41:00+02	VST000573	USR0063	GYM001
2023-10-17	15:28:00+02	17:23:00+02	VST000574	USR0048	GYM005
2024-03-30	16:16:00+02	18:44:00+02	VST000575	USR0087	GYM004
2024-11-01	10:04:00+02	12:19:00+02	VST000576	USR0304	GYM004
2023-05-08	08:29:00+02	09:13:00+02	VST000577	USR0061	GYM001
2024-12-02	12:05:00+02	14:48:00+02	VST000578	USR0396	GYM005
2024-06-26	10:42:00+02	12:28:00+02	VST000579	USR0334	GYM003
2023-12-25	13:18:00+02	16:12:00+02	VST000580	USR0440	GYM005
2024-06-10	17:24:00+02	19:14:00+02	VST000581	USR0274	GYM004
2023-11-09	08:14:00+02	11:06:00+02	VST000582	USR0411	GYM002
2023-03-16	17:25:00+02	20:12:00+02	VST000583	USR0284	GYM006
2024-06-29	14:57:00+02	15:31:00+02	VST000584	USR0466	GYM002
2023-07-15	09:35:00+02	10:58:00+02	VST000585	USR0080	GYM003
2023-01-29	11:50:00+02	14:47:00+02	VST000586	USR0180	GYM005
2024-12-06	09:56:00+02	11:50:00+02	VST000587	USR0272	GYM001
2023-01-16	15:52:00+02	17:52:00+02	VST000588	USR0077	GYM005
2024-02-27	10:00:00+02	10:46:00+02	VST000589	USR0442	GYM003
2024-08-11	10:37:00+02	11:45:00+02	VST000590	USR0221	GYM003
2024-08-15	16:30:00+02	18:11:00+02	VST000591	USR0393	GYM006
2024-02-09	12:58:00+02	13:35:00+02	VST000592	USR0282	GYM003
2024-09-27	16:41:00+02	18:37:00+02	VST000593	USR0028	GYM002
2024-06-14	12:39:00+02	14:45:00+02	VST000594	USR0361	GYM006
2024-09-05	15:05:00+02	17:51:00+02	VST000595	USR0077	GYM005
2023-03-18	16:14:00+02	17:26:00+02	VST000596	USR0164	GYM005
2023-08-17	16:03:00+02	18:59:00+02	VST000597	USR0009	GYM001
2023-10-24	12:09:00+02	14:18:00+02	VST000598	USR0175	GYM003
2024-05-24	15:47:00+02	17:04:00+02	VST000599	USR0462	GYM003
2024-12-15	17:24:00+02	18:23:00+02	VST000600	USR0307	GYM004
2024-07-26	10:28:00+02	12:16:00+02	VST000601	USR0076	GYM006
2024-06-21	14:32:00+02	16:22:00+02	VST000602	USR0245	GYM004
2024-08-05	11:15:00+02	11:53:00+02	VST000603	USR0122	GYM006
2024-09-06	16:40:00+02	18:19:00+02	VST000604	USR0185	GYM002
2023-11-22	10:19:00+02	12:34:00+02	VST000605	USR0032	GYM006
2023-12-29	09:11:00+02	10:03:00+02	VST000606	USR0486	GYM005
2024-10-30	12:42:00+02	15:19:00+02	VST000607	USR0451	GYM001
2023-12-25	15:04:00+02	16:34:00+02	VST000608	USR0250	GYM006
2024-12-06	13:48:00+02	15:53:00+02	VST000609	USR0057	GYM006
2023-11-20	16:39:00+02	19:04:00+02	VST000610	USR0310	GYM006
2024-11-28	12:33:00+02	14:20:00+02	VST000611	USR0372	GYM001
2023-11-22	08:02:00+02	09:27:00+02	VST000612	USR0144	GYM003
2024-09-16	12:49:00+02	15:33:00+02	VST000613	USR0318	GYM001
2023-06-14	13:05:00+02	14:52:00+02	VST000614	USR0084	GYM003
2024-07-26	17:53:00+02	19:07:00+02	VST000615	USR0480	GYM005
2024-08-26	16:21:00+02	17:19:00+02	VST000616	USR0056	GYM001
2024-03-30	10:32:00+02	12:37:00+02	VST000617	USR0279	GYM003
2023-06-02	15:37:00+02	16:16:00+02	VST000618	USR0273	GYM005
2023-05-07	17:11:00+02	18:32:00+02	VST000619	USR0464	GYM005
2023-07-12	16:15:00+02	17:08:00+02	VST000620	USR0166	GYM003
2024-09-18	13:53:00+02	16:16:00+02	VST000621	USR0456	GYM003
2024-06-13	13:40:00+02	16:19:00+02	VST000622	USR0467	GYM002
2023-01-10	17:25:00+02	18:01:00+02	VST000623	USR0158	GYM005
2023-04-02	17:16:00+02	19:49:00+02	VST000624	USR0249	GYM003
2023-05-19	14:26:00+02	17:04:00+02	VST000625	USR0186	GYM005
2024-04-25	15:46:00+02	16:55:00+02	VST000626	USR0482	GYM001
2024-03-24	13:29:00+02	14:47:00+02	VST000627	USR0078	GYM004
2023-11-29	11:13:00+02	13:10:00+02	VST000628	USR0022	GYM004
2023-12-06	12:04:00+02	14:37:00+02	VST000629	USR0108	GYM006
2023-02-21	17:45:00+02	20:29:00+02	VST000630	USR0273	GYM003
2024-12-07	14:32:00+02	16:21:00+02	VST000631	USR0252	GYM003
2024-04-10	11:59:00+02	13:52:00+02	VST000632	USR0015	GYM005
2024-12-18	15:00:00+02	16:06:00+02	VST000633	USR0370	GYM006
2024-04-19	08:44:00+02	09:39:00+02	VST000634	USR0304	GYM003
2024-02-05	13:25:00+02	16:07:00+02	VST000635	USR0160	GYM005
2024-03-14	16:04:00+02	17:07:00+02	VST000636	USR0205	GYM003
2024-08-27	14:30:00+02	15:52:00+02	VST000637	USR0469	GYM005
2024-10-18	14:35:00+02	15:14:00+02	VST000638	USR0113	GYM003
2024-08-20	10:35:00+02	13:02:00+02	VST000639	USR0168	GYM002
2024-05-23	16:27:00+02	18:36:00+02	VST000640	USR0353	GYM005
2023-06-02	08:37:00+02	11:20:00+02	VST000641	USR0253	GYM002
2024-05-28	10:09:00+02	11:08:00+02	VST000642	USR0441	GYM002
2024-05-17	16:34:00+02	17:05:00+02	VST000643	USR0186	GYM002
2024-11-06	13:39:00+02	15:28:00+02	VST000644	USR0347	GYM002
2023-01-06	09:42:00+02	10:23:00+02	VST000645	USR0227	GYM001
2024-05-14	15:30:00+02	16:22:00+02	VST000646	USR0016	GYM006
2024-10-22	09:42:00+02	11:37:00+02	VST000647	USR0156	GYM004
2024-12-17	16:58:00+02	19:27:00+02	VST000648	USR0354	GYM001
2023-04-28	15:47:00+02	16:28:00+02	VST000649	USR0111	GYM003
2024-04-29	08:15:00+02	09:11:00+02	VST000650	USR0001	GYM003
2024-08-23	10:27:00+02	13:10:00+02	VST000651	USR0041	GYM006
2024-10-27	14:59:00+02	16:48:00+02	VST000652	USR0048	GYM004
2024-11-09	10:38:00+02	11:13:00+02	VST000653	USR0415	GYM004
2024-04-12	09:16:00+02	12:13:00+02	VST000654	USR0420	GYM004
2023-06-10	16:00:00+02	17:49:00+02	VST000655	USR0108	GYM002
2023-09-27	12:31:00+02	13:54:00+02	VST000656	USR0161	GYM001
2023-02-25	13:46:00+02	15:38:00+02	VST000657	USR0161	GYM003
2023-08-16	14:47:00+02	16:08:00+02	VST000658	USR0359	GYM001
2023-05-29	09:22:00+02	10:41:00+02	VST000659	USR0128	GYM001
2023-02-15	13:36:00+02	15:19:00+02	VST000660	USR0210	GYM001
2023-05-24	17:06:00+02	18:46:00+02	VST000661	USR0151	GYM004
2024-09-23	14:29:00+02	17:15:00+02	VST000662	USR0444	GYM006
2023-12-06	13:24:00+02	15:15:00+02	VST000663	USR0255	GYM006
2024-02-17	16:19:00+02	18:41:00+02	VST000664	USR0471	GYM004
2024-06-03	17:14:00+02	18:14:00+02	VST000665	USR0463	GYM003
2023-12-10	08:36:00+02	10:15:00+02	VST000666	USR0218	GYM003
2024-01-22	09:10:00+02	10:18:00+02	VST000667	USR0030	GYM003
2024-04-17	12:00:00+02	13:10:00+02	VST000668	USR0473	GYM006
2023-10-02	12:54:00+02	14:34:00+02	VST000669	USR0045	GYM006
2023-12-19	11:52:00+02	12:51:00+02	VST000670	USR0080	GYM001
2023-03-07	09:32:00+02	10:05:00+02	VST000671	USR0039	GYM004
2023-03-20	15:24:00+02	18:17:00+02	VST000672	USR0240	GYM002
2024-08-20	09:40:00+02	12:21:00+02	VST000673	USR0045	GYM001
2024-09-27	09:42:00+02	10:38:00+02	VST000674	USR0078	GYM005
2023-07-21	15:34:00+02	16:56:00+02	VST000675	USR0337	GYM006
2024-10-23	10:50:00+02	13:38:00+02	VST000676	USR0396	GYM001
2024-07-11	13:06:00+02	15:05:00+02	VST000677	USR0349	GYM004
2023-04-23	08:29:00+02	11:19:00+02	VST000678	USR0288	GYM005
2023-04-01	08:47:00+02	10:38:00+02	VST000679	USR0440	GYM001
2023-05-21	13:32:00+02	15:11:00+02	VST000680	USR0280	GYM004
2023-10-16	08:57:00+02	10:03:00+02	VST000681	USR0116	GYM004
2024-12-30	13:00:00+02	14:42:00+02	VST000682	USR0269	GYM006
2024-08-11	14:07:00+02	17:03:00+02	VST000683	USR0404	GYM002
2024-02-15	14:23:00+02	15:55:00+02	VST000684	USR0335	GYM001
2024-01-12	15:21:00+02	16:34:00+02	VST000685	USR0312	GYM004
2024-01-19	10:29:00+02	11:17:00+02	VST000686	USR0053	GYM003
2023-06-01	12:10:00+02	13:59:00+02	VST000687	USR0068	GYM004
2024-09-18	17:03:00+02	18:59:00+02	VST000688	USR0182	GYM002
2023-11-15	15:01:00+02	17:49:00+02	VST000689	USR0034	GYM004
2024-01-04	17:39:00+02	20:02:00+02	VST000690	USR0284	GYM006
2024-08-28	11:04:00+02	11:46:00+02	VST000691	USR0306	GYM001
2024-07-13	10:54:00+02	11:57:00+02	VST000692	USR0386	GYM006
2024-12-03	10:59:00+02	11:36:00+02	VST000693	USR0249	GYM001
2024-04-06	09:20:00+02	11:50:00+02	VST000694	USR0111	GYM005
2023-01-12	14:31:00+02	15:13:00+02	VST000695	USR0094	GYM001
2023-06-05	12:06:00+02	13:03:00+02	VST000696	USR0410	GYM005
2024-11-14	16:29:00+02	18:37:00+02	VST000697	USR0179	GYM006
2024-04-21	17:57:00+02	18:40:00+02	VST000698	USR0047	GYM003
2024-02-05	10:26:00+02	11:18:00+02	VST000699	USR0282	GYM002
2023-06-26	11:57:00+02	14:16:00+02	VST000700	USR0340	GYM003
2023-12-07	15:52:00+02	18:02:00+02	VST000701	USR0362	GYM005
2023-02-26	12:20:00+02	13:35:00+02	VST000702	USR0092	GYM004
2024-03-23	15:50:00+02	18:14:00+02	VST000703	USR0376	GYM004
2023-07-22	12:21:00+02	14:22:00+02	VST000704	USR0212	GYM003
2024-11-27	08:09:00+02	09:58:00+02	VST000705	USR0075	GYM004
2024-09-24	15:56:00+02	17:51:00+02	VST000706	USR0378	GYM005
2023-07-21	12:54:00+02	14:14:00+02	VST000707	USR0202	GYM006
2023-11-26	17:19:00+02	20:05:00+02	VST000708	USR0445	GYM002
2023-12-29	10:41:00+02	11:31:00+02	VST000709	USR0407	GYM001
2024-03-29	09:15:00+02	11:44:00+02	VST000710	USR0421	GYM005
2023-12-22	15:32:00+02	18:27:00+02	VST000711	USR0297	GYM005
2023-08-04	13:53:00+02	14:56:00+02	VST000712	USR0308	GYM001
2024-07-08	13:06:00+02	13:59:00+02	VST000713	USR0211	GYM001
2023-01-23	15:14:00+02	17:43:00+02	VST000714	USR0493	GYM002
2023-06-04	12:16:00+02	13:10:00+02	VST000715	USR0338	GYM002
2023-07-05	15:47:00+02	18:13:00+02	VST000716	USR0433	GYM002
2023-09-06	13:09:00+02	14:58:00+02	VST000717	USR0411	GYM004
2023-05-14	11:23:00+02	13:52:00+02	VST000718	USR0134	GYM005
2023-11-17	14:33:00+02	17:03:00+02	VST000719	USR0330	GYM006
2024-01-25	16:14:00+02	17:43:00+02	VST000720	USR0066	GYM001
2024-03-09	09:49:00+02	11:16:00+02	VST000721	USR0280	GYM005
2023-01-22	12:02:00+02	13:08:00+02	VST000722	USR0422	GYM005
2024-08-22	14:30:00+02	16:06:00+02	VST000723	USR0028	GYM002
2024-10-26	17:45:00+02	19:48:00+02	VST000724	USR0412	GYM002
2023-05-05	14:07:00+02	16:17:00+02	VST000725	USR0117	GYM005
2023-03-20	17:48:00+02	19:04:00+02	VST000726	USR0493	GYM002
2023-02-20	13:02:00+02	14:56:00+02	VST000727	USR0370	GYM004
2024-12-28	13:02:00+02	14:55:00+02	VST000728	USR0487	GYM001
2023-06-25	08:22:00+02	10:48:00+02	VST000729	USR0450	GYM005
2023-09-10	14:45:00+02	17:19:00+02	VST000730	USR0317	GYM001
2023-09-03	12:41:00+02	13:18:00+02	VST000731	USR0430	GYM004
2023-04-16	08:08:00+02	08:54:00+02	VST000732	USR0325	GYM002
2023-07-12	17:39:00+02	20:10:00+02	VST000733	USR0114	GYM003
2023-11-12	08:50:00+02	09:48:00+02	VST000734	USR0075	GYM004
2023-10-29	16:28:00+02	18:27:00+02	VST000735	USR0202	GYM003
2024-07-01	12:53:00+02	15:25:00+02	VST000736	USR0427	GYM001
2024-12-16	11:55:00+02	14:23:00+02	VST000737	USR0059	GYM005
2023-09-25	14:00:00+02	15:13:00+02	VST000738	USR0386	GYM002
2023-06-19	11:44:00+02	13:26:00+02	VST000739	USR0015	GYM004
2024-07-04	11:14:00+02	13:13:00+02	VST000740	USR0231	GYM002
2024-03-30	12:16:00+02	15:13:00+02	VST000741	USR0105	GYM003
2024-10-12	10:20:00+02	11:22:00+02	VST000742	USR0165	GYM003
2023-10-19	09:39:00+02	12:19:00+02	VST000743	USR0199	GYM006
2024-07-17	08:40:00+02	09:36:00+02	VST000744	USR0404	GYM005
2023-05-21	13:16:00+02	15:29:00+02	VST000745	USR0354	GYM003
2023-05-26	15:31:00+02	16:28:00+02	VST000746	USR0035	GYM005
2024-02-29	08:34:00+02	10:27:00+02	VST000747	USR0162	GYM006
2023-11-10	17:53:00+02	20:45:00+02	VST000748	USR0245	GYM004
2023-07-03	14:13:00+02	15:01:00+02	VST000749	USR0470	GYM006
2024-10-25	10:14:00+02	12:01:00+02	VST000750	USR0287	GYM005
2024-12-13	09:32:00+02	12:18:00+02	VST000751	USR0383	GYM003
2023-05-08	13:02:00+02	15:30:00+02	VST000752	USR0471	GYM001
2023-10-14	13:34:00+02	15:46:00+02	VST000753	USR0019	GYM005
2023-09-10	15:05:00+02	17:20:00+02	VST000754	USR0452	GYM002
2024-11-30	10:59:00+02	12:30:00+02	VST000755	USR0280	GYM001
2024-01-21	11:25:00+02	12:57:00+02	VST000756	USR0340	GYM005
2023-08-18	10:15:00+02	13:05:00+02	VST000757	USR0423	GYM002
2023-09-28	17:12:00+02	18:22:00+02	VST000758	USR0348	GYM006
2024-02-19	14:14:00+02	16:47:00+02	VST000759	USR0182	GYM001
2023-07-17	17:03:00+02	19:11:00+02	VST000760	USR0423	GYM005
2023-11-19	16:33:00+02	17:19:00+02	VST000761	USR0401	GYM004
2023-02-25	12:39:00+02	14:36:00+02	VST000762	USR0147	GYM006
2023-07-22	10:48:00+02	12:11:00+02	VST000763	USR0374	GYM002
2024-09-12	12:23:00+02	14:43:00+02	VST000764	USR0176	GYM004
2024-09-19	16:13:00+02	18:34:00+02	VST000765	USR0163	GYM003
2024-08-26	13:02:00+02	15:57:00+02	VST000766	USR0416	GYM006
2023-05-18	13:46:00+02	15:43:00+02	VST000767	USR0175	GYM006
2024-02-26	09:57:00+02	12:46:00+02	VST000768	USR0494	GYM005
2023-02-26	15:59:00+02	17:29:00+02	VST000769	USR0047	GYM005
2024-07-15	09:17:00+02	10:31:00+02	VST000770	USR0256	GYM002
2023-03-12	10:24:00+02	11:13:00+02	VST000771	USR0448	GYM006
2024-08-16	11:51:00+02	14:47:00+02	VST000772	USR0174	GYM005
2024-01-07	14:46:00+02	17:20:00+02	VST000773	USR0103	GYM003
2024-09-08	17:30:00+02	18:29:00+02	VST000774	USR0121	GYM005
2024-08-22	14:14:00+02	16:42:00+02	VST000775	USR0419	GYM006
2024-05-28	09:32:00+02	11:25:00+02	VST000776	USR0350	GYM001
2023-03-25	14:44:00+02	17:36:00+02	VST000777	USR0145	GYM004
2023-02-12	08:14:00+02	09:08:00+02	VST000778	USR0042	GYM006
2024-10-27	12:30:00+02	14:53:00+02	VST000779	USR0367	GYM003
2024-08-28	17:09:00+02	18:24:00+02	VST000780	USR0029	GYM006
2023-05-13	10:06:00+02	11:54:00+02	VST000781	USR0454	GYM003
2024-01-30	15:45:00+02	17:58:00+02	VST000782	USR0380	GYM006
2023-03-06	14:17:00+02	15:04:00+02	VST000783	USR0273	GYM004
2023-10-17	12:28:00+02	13:25:00+02	VST000784	USR0465	GYM004
2024-01-11	17:58:00+02	20:05:00+02	VST000785	USR0014	GYM003
2024-04-11	14:30:00+02	16:23:00+02	VST000786	USR0408	GYM006
2023-08-01	14:20:00+02	16:56:00+02	VST000787	USR0441	GYM004
2023-05-28	09:50:00+02	10:35:00+02	VST000788	USR0306	GYM002
2024-07-26	11:59:00+02	12:52:00+02	VST000789	USR0313	GYM006
2024-04-15	16:02:00+02	17:27:00+02	VST000790	USR0485	GYM004
2023-05-29	08:25:00+02	09:30:00+02	VST000791	USR0189	GYM001
2023-03-29	17:34:00+02	20:32:00+02	VST000792	USR0360	GYM001
2023-11-20	13:35:00+02	14:05:00+02	VST000793	USR0295	GYM002
2024-01-31	11:46:00+02	12:53:00+02	VST000794	USR0183	GYM004
2024-02-08	09:04:00+02	10:12:00+02	VST000795	USR0352	GYM001
2023-03-23	15:55:00+02	18:20:00+02	VST000796	USR0036	GYM006
2024-10-02	13:09:00+02	15:55:00+02	VST000797	USR0370	GYM005
2023-10-13	14:58:00+02	16:42:00+02	VST000798	USR0037	GYM004
2024-01-17	09:59:00+02	12:08:00+02	VST000799	USR0496	GYM002
2023-09-27	10:23:00+02	13:20:00+02	VST000800	USR0014	GYM004
2023-10-19	08:46:00+02	11:10:00+02	VST000801	USR0411	GYM003
2024-03-28	08:38:00+02	09:58:00+02	VST000802	USR0123	GYM003
2024-12-15	13:11:00+02	14:33:00+02	VST000803	USR0083	GYM001
2023-01-24	16:24:00+02	18:15:00+02	VST000804	USR0159	GYM003
2023-11-07	09:58:00+02	11:44:00+02	VST000805	USR0494	GYM002
2024-04-05	09:39:00+02	12:34:00+02	VST000806	USR0329	GYM001
2023-07-27	12:00:00+02	13:47:00+02	VST000807	USR0102	GYM002
2024-12-17	17:10:00+02	19:31:00+02	VST000808	USR0337	GYM006
2024-10-25	10:18:00+02	12:16:00+02	VST000809	USR0083	GYM002
2024-03-13	14:37:00+02	15:29:00+02	VST000810	USR0044	GYM003
2024-06-21	15:44:00+02	18:43:00+02	VST000811	USR0068	GYM006
2024-12-06	14:19:00+02	14:51:00+02	VST000812	USR0048	GYM003
2023-12-02	17:13:00+02	19:53:00+02	VST000813	USR0057	GYM002
2024-02-26	15:09:00+02	17:22:00+02	VST000814	USR0075	GYM003
2023-11-17	10:38:00+02	11:40:00+02	VST000815	USR0022	GYM003
2024-05-11	15:04:00+02	16:49:00+02	VST000816	USR0132	GYM003
2024-08-09	09:41:00+02	10:26:00+02	VST000817	USR0465	GYM004
2023-06-12	16:21:00+02	18:25:00+02	VST000818	USR0456	GYM006
2024-06-24	14:57:00+02	17:47:00+02	VST000819	USR0302	GYM006
2023-06-14	12:46:00+02	13:29:00+02	VST000820	USR0443	GYM006
2024-11-28	08:33:00+02	09:03:00+02	VST000821	USR0418	GYM002
2024-07-19	14:19:00+02	17:12:00+02	VST000822	USR0267	GYM005
2023-10-22	11:42:00+02	13:43:00+02	VST000823	USR0287	GYM002
2023-02-11	15:34:00+02	16:32:00+02	VST000824	USR0395	GYM006
2023-10-12	15:35:00+02	17:17:00+02	VST000825	USR0120	GYM001
2024-01-22	12:01:00+02	12:38:00+02	VST000826	USR0246	GYM003
2023-05-18	14:11:00+02	15:41:00+02	VST000827	USR0056	GYM003
2023-07-06	09:41:00+02	12:01:00+02	VST000828	USR0038	GYM005
2024-12-16	14:16:00+02	16:26:00+02	VST000829	USR0245	GYM001
2024-03-06	17:17:00+02	19:08:00+02	VST000830	USR0021	GYM004
2024-07-07	14:07:00+02	16:14:00+02	VST000831	USR0110	GYM002
2024-02-20	09:02:00+02	11:15:00+02	VST000832	USR0094	GYM004
2024-03-01	14:47:00+02	16:54:00+02	VST000833	USR0394	GYM001
2024-02-20	12:42:00+02	15:03:00+02	VST000834	USR0410	GYM005
2023-01-26	11:14:00+02	14:03:00+02	VST000835	USR0475	GYM001
2024-01-06	10:05:00+02	11:29:00+02	VST000836	USR0136	GYM005
2024-01-20	15:45:00+02	16:59:00+02	VST000837	USR0231	GYM004
2023-02-25	09:33:00+02	12:04:00+02	VST000838	USR0008	GYM004
2023-09-10	11:37:00+02	12:42:00+02	VST000839	USR0444	GYM001
2024-09-25	08:21:00+02	09:39:00+02	VST000840	USR0328	GYM001
2023-04-16	08:51:00+02	11:43:00+02	VST000841	USR0375	GYM003
2023-05-10	13:41:00+02	15:49:00+02	VST000842	USR0290	GYM005
2024-10-31	12:09:00+02	14:11:00+02	VST000843	USR0251	GYM003
2024-01-11	10:08:00+02	12:24:00+02	VST000844	USR0400	GYM002
2023-11-04	17:38:00+02	18:47:00+02	VST000845	USR0361	GYM002
2023-04-01	11:30:00+02	13:13:00+02	VST000846	USR0397	GYM001
2024-01-28	09:10:00+02	10:12:00+02	VST000847	USR0087	GYM004
2024-06-17	17:27:00+02	18:31:00+02	VST000848	USR0204	GYM002
2023-04-20	11:32:00+02	12:04:00+02	VST000849	USR0219	GYM002
2024-07-14	18:00:00+02	18:48:00+02	VST000850	USR0406	GYM003
2024-10-02	11:41:00+02	12:15:00+02	VST000851	USR0480	GYM003
2024-08-07	11:58:00+02	13:04:00+02	VST000852	USR0241	GYM002
2023-12-06	13:36:00+02	16:10:00+02	VST000853	USR0411	GYM001
2024-07-18	10:31:00+02	12:52:00+02	VST000854	USR0320	GYM003
2023-12-22	08:02:00+02	09:06:00+02	VST000855	USR0258	GYM002
2023-06-17	12:43:00+02	13:34:00+02	VST000856	USR0109	GYM004
2024-07-10	10:28:00+02	11:33:00+02	VST000857	USR0256	GYM003
2024-03-27	10:13:00+02	12:29:00+02	VST000858	USR0481	GYM002
2023-04-15	17:13:00+02	19:39:00+02	VST000859	USR0282	GYM005
2023-05-30	12:16:00+02	14:34:00+02	VST000860	USR0220	GYM003
2023-05-26	10:58:00+02	12:14:00+02	VST000861	USR0083	GYM005
2024-12-16	09:52:00+02	12:18:00+02	VST000862	USR0107	GYM003
2023-10-26	08:26:00+02	11:06:00+02	VST000863	USR0069	GYM003
2023-06-16	10:14:00+02	12:32:00+02	VST000864	USR0097	GYM006
2024-12-13	08:15:00+02	11:06:00+02	VST000865	USR0212	GYM006
2024-10-07	14:06:00+02	16:31:00+02	VST000866	USR0286	GYM005
2024-12-23	12:03:00+02	14:11:00+02	VST000867	USR0237	GYM001
2023-02-17	13:31:00+02	15:31:00+02	VST000868	USR0008	GYM002
2024-09-29	08:16:00+02	09:43:00+02	VST000869	USR0294	GYM001
2023-08-27	10:58:00+02	12:15:00+02	VST000870	USR0189	GYM001
2023-01-07	12:31:00+02	14:49:00+02	VST000871	USR0081	GYM006
2024-04-08	08:53:00+02	09:24:00+02	VST000872	USR0108	GYM002
2024-03-28	10:09:00+02	13:06:00+02	VST000873	USR0321	GYM006
2024-01-06	15:11:00+02	17:48:00+02	VST000874	USR0067	GYM006
2024-07-02	16:58:00+02	18:28:00+02	VST000875	USR0174	GYM006
2024-05-01	09:56:00+02	12:34:00+02	VST000876	USR0346	GYM004
2023-07-30	09:05:00+02	10:43:00+02	VST000877	USR0351	GYM001
2023-06-14	16:07:00+02	18:22:00+02	VST000878	USR0328	GYM001
2023-05-05	15:39:00+02	18:28:00+02	VST000879	USR0043	GYM001
2023-12-03	14:10:00+02	17:07:00+02	VST000880	USR0187	GYM004
2023-07-11	16:45:00+02	18:48:00+02	VST000881	USR0302	GYM003
2024-12-30	09:51:00+02	10:29:00+02	VST000882	USR0200	GYM005
2023-08-02	15:42:00+02	16:21:00+02	VST000883	USR0381	GYM005
2024-07-27	16:35:00+02	19:30:00+02	VST000884	USR0419	GYM004
2023-11-24	11:46:00+02	14:19:00+02	VST000885	USR0039	GYM001
2024-01-16	08:44:00+02	10:48:00+02	VST000886	USR0220	GYM005
2024-11-03	16:53:00+02	17:51:00+02	VST000887	USR0307	GYM004
2024-07-31	13:08:00+02	16:06:00+02	VST000888	USR0004	GYM006
2023-08-27	15:49:00+02	18:22:00+02	VST000889	USR0121	GYM002
2024-06-15	08:31:00+02	09:21:00+02	VST000890	USR0336	GYM005
2024-11-30	09:02:00+02	10:08:00+02	VST000891	USR0077	GYM002
2023-03-23	16:10:00+02	18:54:00+02	VST000892	USR0468	GYM001
2023-12-29	14:51:00+02	16:32:00+02	VST000893	USR0179	GYM005
2024-05-19	15:16:00+02	17:45:00+02	VST000894	USR0133	GYM004
2023-07-21	09:50:00+02	12:32:00+02	VST000895	USR0311	GYM003
2024-05-18	16:22:00+02	17:12:00+02	VST000896	USR0229	GYM005
2024-10-05	15:34:00+02	18:17:00+02	VST000897	USR0276	GYM005
2023-02-06	09:15:00+02	10:07:00+02	VST000898	USR0152	GYM005
2024-10-05	09:22:00+02	10:54:00+02	VST000899	USR0164	GYM005
2024-08-11	13:29:00+02	15:59:00+02	VST000900	USR0290	GYM004
2024-08-23	10:31:00+02	11:20:00+02	VST000901	USR0378	GYM004
2024-02-06	09:07:00+02	11:55:00+02	VST000902	USR0109	GYM003
2024-12-06	10:09:00+02	13:07:00+02	VST000903	USR0126	GYM004
2023-06-25	12:41:00+02	14:30:00+02	VST000904	USR0240	GYM004
2024-06-28	17:59:00+02	18:42:00+02	VST000905	USR0310	GYM001
2024-07-23	17:21:00+02	19:18:00+02	VST000906	USR0418	GYM001
2024-04-11	13:32:00+02	16:18:00+02	VST000907	USR0467	GYM002
2023-07-20	14:30:00+02	15:02:00+02	VST000908	USR0401	GYM003
2024-06-23	17:03:00+02	19:33:00+02	VST000909	USR0389	GYM001
2024-06-30	13:01:00+02	15:27:00+02	VST000910	USR0345	GYM003
2024-09-28	15:44:00+02	18:25:00+02	VST000911	USR0146	GYM003
2024-01-29	16:37:00+02	19:07:00+02	VST000912	USR0252	GYM005
2023-02-11	15:20:00+02	18:16:00+02	VST000913	USR0183	GYM006
2024-08-19	09:41:00+02	11:35:00+02	VST000914	USR0309	GYM006
2024-01-28	09:57:00+02	12:14:00+02	VST000915	USR0306	GYM006
2024-11-30	17:24:00+02	19:24:00+02	VST000916	USR0072	GYM003
2024-09-14	11:40:00+02	13:25:00+02	VST000917	USR0219	GYM005
2024-03-16	15:20:00+02	17:04:00+02	VST000918	USR0207	GYM002
2024-09-08	15:42:00+02	16:54:00+02	VST000919	USR0173	GYM002
2024-05-20	11:53:00+02	12:32:00+02	VST000920	USR0141	GYM006
2023-11-16	15:03:00+02	16:50:00+02	VST000921	USR0272	GYM002
2024-07-06	13:47:00+02	16:41:00+02	VST000922	USR0214	GYM005
2023-08-03	15:44:00+02	17:20:00+02	VST000923	USR0468	GYM006
2023-03-12	14:48:00+02	15:33:00+02	VST000924	USR0269	GYM005
2024-07-21	15:05:00+02	17:36:00+02	VST000925	USR0020	GYM002
2023-08-24	09:37:00+02	12:35:00+02	VST000926	USR0066	GYM006
2023-10-08	13:20:00+02	14:33:00+02	VST000927	USR0483	GYM005
2024-09-08	15:17:00+02	18:13:00+02	VST000928	USR0303	GYM004
2023-06-11	13:20:00+02	14:03:00+02	VST000929	USR0147	GYM004
2023-07-10	12:21:00+02	14:05:00+02	VST000930	USR0429	GYM005
2023-01-09	14:23:00+02	14:59:00+02	VST000931	USR0165	GYM005
2023-03-01	10:36:00+02	12:19:00+02	VST000932	USR0378	GYM001
2023-08-13	16:05:00+02	18:39:00+02	VST000933	USR0310	GYM001
2024-11-30	09:08:00+02	09:59:00+02	VST000934	USR0006	GYM003
2024-08-04	09:33:00+02	10:35:00+02	VST000935	USR0014	GYM006
2023-10-14	09:27:00+02	12:06:00+02	VST000936	USR0132	GYM003
2023-06-18	09:35:00+02	10:24:00+02	VST000937	USR0342	GYM003
2023-03-03	15:22:00+02	17:03:00+02	VST000938	USR0243	GYM002
2023-12-15	09:38:00+02	11:12:00+02	VST000939	USR0439	GYM004
2024-03-17	14:21:00+02	15:24:00+02	VST000940	USR0231	GYM002
2023-01-14	10:13:00+02	11:54:00+02	VST000941	USR0228	GYM006
2023-06-13	17:29:00+02	19:09:00+02	VST000942	USR0162	GYM005
2024-02-24	09:01:00+02	10:36:00+02	VST000943	USR0283	GYM001
2024-06-03	18:00:00+02	18:33:00+02	VST000944	USR0263	GYM006
2024-10-27	17:35:00+02	18:33:00+02	VST000945	USR0131	GYM005
2024-07-01	17:35:00+02	18:49:00+02	VST000946	USR0431	GYM006
2024-07-13	13:37:00+02	14:45:00+02	VST000947	USR0225	GYM005
2024-08-19	10:05:00+02	12:29:00+02	VST000948	USR0258	GYM001
2023-01-28	15:00:00+02	17:04:00+02	VST000949	USR0234	GYM005
2024-12-08	14:02:00+02	15:16:00+02	VST000950	USR0336	GYM003
2024-03-21	15:13:00+02	16:49:00+02	VST000951	USR0409	GYM006
2023-07-27	08:52:00+02	10:22:00+02	VST000952	USR0316	GYM001
2024-04-14	12:54:00+02	15:28:00+02	VST000953	USR0463	GYM005
2024-12-16	13:19:00+02	14:35:00+02	VST000954	USR0024	GYM003
2023-04-14	14:00:00+02	16:45:00+02	VST000955	USR0271	GYM003
2024-03-01	09:46:00+02	10:24:00+02	VST000956	USR0095	GYM004
2023-04-11	17:51:00+02	19:48:00+02	VST000957	USR0142	GYM003
2024-06-24	16:39:00+02	17:30:00+02	VST000958	USR0182	GYM002
2024-09-30	11:37:00+02	12:44:00+02	VST000959	USR0206	GYM001
2024-06-05	10:38:00+02	11:47:00+02	VST000960	USR0390	GYM001
2023-04-16	16:13:00+02	18:49:00+02	VST000961	USR0462	GYM001
2024-11-09	11:49:00+02	14:04:00+02	VST000962	USR0081	GYM005
2023-10-04	09:50:00+02	11:58:00+02	VST000963	USR0274	GYM006
2023-03-06	13:58:00+02	15:28:00+02	VST000964	USR0276	GYM005
2023-07-07	17:29:00+02	19:51:00+02	VST000965	USR0371	GYM002
2023-11-13	14:16:00+02	15:28:00+02	VST000966	USR0446	GYM006
2023-05-18	09:57:00+02	11:20:00+02	VST000967	USR0465	GYM003
2023-12-09	12:45:00+02	15:42:00+02	VST000968	USR0208	GYM005
2023-04-15	17:47:00+02	19:45:00+02	VST000969	USR0296	GYM006
2024-06-29	11:51:00+02	12:34:00+02	VST000970	USR0039	GYM003
2024-01-15	15:19:00+02	16:56:00+02	VST000971	USR0436	GYM006
2023-04-20	17:34:00+02	18:33:00+02	VST000972	USR0288	GYM003
2024-06-28	17:30:00+02	18:13:00+02	VST000973	USR0124	GYM006
2023-12-20	08:26:00+02	09:38:00+02	VST000974	USR0364	GYM005
2023-11-13	12:33:00+02	15:01:00+02	VST000975	USR0457	GYM005
2023-09-23	08:29:00+02	10:41:00+02	VST000976	USR0283	GYM002
2024-11-24	11:04:00+02	13:35:00+02	VST000977	USR0366	GYM004
2023-03-06	12:39:00+02	14:26:00+02	VST000978	USR0180	GYM001
2023-11-29	13:16:00+02	15:47:00+02	VST000979	USR0097	GYM005
2024-05-27	13:47:00+02	16:33:00+02	VST000980	USR0191	GYM005
2023-05-13	13:59:00+02	15:28:00+02	VST000981	USR0074	GYM003
2024-08-14	08:06:00+02	10:13:00+02	VST000982	USR0447	GYM004
2024-06-23	11:05:00+02	13:14:00+02	VST000983	USR0273	GYM005
2024-06-18	10:26:00+02	12:57:00+02	VST000984	USR0497	GYM006
2024-05-10	17:39:00+02	19:16:00+02	VST000985	USR0049	GYM004
2024-09-12	14:50:00+02	15:57:00+02	VST000986	USR0484	GYM001
2024-09-10	09:11:00+02	11:56:00+02	VST000987	USR0337	GYM006
2024-10-18	10:25:00+02	12:46:00+02	VST000988	USR0210	GYM003
2024-01-04	08:31:00+02	09:04:00+02	VST000989	USR0116	GYM002
2024-10-12	09:33:00+02	11:16:00+02	VST000990	USR0023	GYM006
2023-04-09	17:03:00+02	19:27:00+02	VST000991	USR0098	GYM001
2023-11-13	11:40:00+02	13:47:00+02	VST000992	USR0328	GYM006
2023-05-03	14:25:00+02	16:15:00+02	VST000993	USR0397	GYM004
2023-11-16	15:09:00+02	17:54:00+02	VST000994	USR0407	GYM004
2024-08-15	15:44:00+02	16:24:00+02	VST000995	USR0313	GYM001
2024-05-09	13:49:00+02	14:43:00+02	VST000996	USR0190	GYM004
2024-04-01	10:41:00+02	13:27:00+02	VST000997	USR0182	GYM006
2024-06-05	14:18:00+02	16:18:00+02	VST000998	USR0148	GYM002
2024-06-03	13:19:00+02	15:39:00+02	VST000999	USR0342	GYM006
2024-12-17	13:32:00+02	15:11:00+02	VST001000	USR0495	GYM002
2023-11-11	17:41:00+02	19:36:00+02	VST001001	USR0436	GYM004
2024-12-09	09:26:00+02	11:05:00+02	VST001002	USR0023	GYM006
2024-12-10	08:53:00+02	10:31:00+02	VST001003	USR0105	GYM004
2024-06-25	10:39:00+02	11:34:00+02	VST001004	USR0163	GYM002
2024-04-23	10:41:00+02	12:16:00+02	VST001005	USR0067	GYM004
2023-01-20	08:50:00+02	11:49:00+02	VST001006	USR0290	GYM005
2024-07-13	09:23:00+02	11:33:00+02	VST001007	USR0289	GYM003
2023-05-10	12:38:00+02	15:06:00+02	VST001008	USR0046	GYM006
2023-10-20	15:33:00+02	17:04:00+02	VST001009	USR0081	GYM005
2023-05-12	15:14:00+02	18:14:00+02	VST001010	USR0429	GYM004
2023-12-22	16:17:00+02	17:36:00+02	VST001011	USR0147	GYM004
2023-02-23	15:32:00+02	18:15:00+02	VST001012	USR0222	GYM003
2024-01-22	15:04:00+02	17:00:00+02	VST001013	USR0343	GYM004
2023-09-22	12:39:00+02	13:55:00+02	VST001014	USR0015	GYM003
2023-08-03	11:40:00+02	13:30:00+02	VST001015	USR0379	GYM006
2024-04-04	16:44:00+02	19:34:00+02	VST001016	USR0121	GYM002
2024-04-02	09:56:00+02	10:28:00+02	VST001017	USR0078	GYM003
2023-02-12	13:53:00+02	14:25:00+02	VST001018	USR0322	GYM003
2024-08-08	15:20:00+02	16:07:00+02	VST001019	USR0295	GYM005
2023-10-05	09:53:00+02	10:26:00+02	VST001020	USR0241	GYM004
2023-05-10	12:50:00+02	15:05:00+02	VST001021	USR0018	GYM006
2023-12-16	16:18:00+02	17:13:00+02	VST001022	USR0256	GYM002
2024-12-06	16:59:00+02	19:43:00+02	VST001023	USR0454	GYM001
2024-06-27	13:15:00+02	14:11:00+02	VST001024	USR0443	GYM003
2023-04-16	08:46:00+02	11:10:00+02	VST001025	USR0416	GYM001
2024-12-16	11:45:00+02	13:44:00+02	VST001026	USR0277	GYM004
2023-01-01	14:44:00+02	16:10:00+02	VST001027	USR0424	GYM003
2024-08-06	08:56:00+02	10:38:00+02	VST001028	USR0476	GYM001
2024-03-07	08:07:00+02	09:41:00+02	VST001029	USR0027	GYM005
2023-11-02	11:29:00+02	12:48:00+02	VST001030	USR0002	GYM001
2024-06-10	13:08:00+02	13:46:00+02	VST001031	USR0353	GYM005
2023-02-22	11:36:00+02	12:12:00+02	VST001032	USR0464	GYM002
2024-06-03	10:20:00+02	11:13:00+02	VST001033	USR0295	GYM004
2023-11-26	12:21:00+02	13:05:00+02	VST001034	USR0470	GYM006
2024-07-11	12:56:00+02	14:21:00+02	VST001035	USR0312	GYM001
2023-11-21	13:35:00+02	14:36:00+02	VST001036	USR0363	GYM003
2023-04-24	10:02:00+02	11:02:00+02	VST001037	USR0383	GYM004
2023-05-27	08:07:00+02	08:59:00+02	VST001038	USR0239	GYM001
2023-06-15	16:29:00+02	17:32:00+02	VST001039	USR0013	GYM003
2024-01-14	15:20:00+02	17:26:00+02	VST001040	USR0382	GYM003
2023-05-19	10:59:00+02	13:53:00+02	VST001041	USR0184	GYM006
2024-09-20	10:12:00+02	11:29:00+02	VST001042	USR0194	GYM006
2023-10-26	14:29:00+02	15:27:00+02	VST001043	USR0462	GYM003
2023-10-03	17:05:00+02	18:22:00+02	VST001044	USR0056	GYM006
2023-06-27	11:55:00+02	13:29:00+02	VST001045	USR0230	GYM003
2023-12-20	16:32:00+02	18:17:00+02	VST001046	USR0489	GYM001
2023-06-03	17:32:00+02	20:01:00+02	VST001047	USR0028	GYM002
2023-07-20	14:02:00+02	14:51:00+02	VST001048	USR0320	GYM006
2023-04-25	09:13:00+02	11:39:00+02	VST001049	USR0071	GYM005
2024-11-01	14:46:00+02	16:26:00+02	VST001050	USR0210	GYM005
2024-07-07	08:43:00+02	11:02:00+02	VST001051	USR0448	GYM005
2023-03-09	15:26:00+02	17:18:00+02	VST001052	USR0184	GYM002
2024-03-20	08:19:00+02	09:54:00+02	VST001053	USR0425	GYM003
2024-03-20	15:50:00+02	17:01:00+02	VST001054	USR0375	GYM003
2023-11-22	09:19:00+02	10:07:00+02	VST001055	USR0356	GYM004
2024-12-08	13:20:00+02	15:00:00+02	VST001056	USR0041	GYM005
2024-08-24	17:49:00+02	18:34:00+02	VST001057	USR0484	GYM005
2024-09-14	15:19:00+02	17:26:00+02	VST001058	USR0492	GYM003
2023-12-25	17:47:00+02	19:56:00+02	VST001059	USR0260	GYM005
2023-05-25	14:54:00+02	16:49:00+02	VST001060	USR0441	GYM003
2023-10-02	15:07:00+02	15:52:00+02	VST001061	USR0414	GYM003
2024-05-23	12:56:00+02	14:32:00+02	VST001062	USR0344	GYM006
2023-06-28	09:57:00+02	11:34:00+02	VST001063	USR0084	GYM003
2024-04-21	14:54:00+02	16:09:00+02	VST001064	USR0046	GYM001
2024-02-18	08:21:00+02	10:43:00+02	VST001065	USR0440	GYM001
2023-06-02	13:32:00+02	14:19:00+02	VST001066	USR0159	GYM001
2023-04-14	10:55:00+02	13:30:00+02	VST001067	USR0344	GYM001
2023-03-16	15:51:00+02	17:12:00+02	VST001068	USR0007	GYM002
2023-05-08	14:10:00+02	16:20:00+02	VST001069	USR0474	GYM004
2024-12-11	09:30:00+02	10:45:00+02	VST001070	USR0333	GYM004
2024-10-27	15:27:00+02	18:02:00+02	VST001071	USR0438	GYM003
2024-07-21	09:48:00+02	10:45:00+02	VST001072	USR0136	GYM005
2023-12-11	12:09:00+02	13:15:00+02	VST001073	USR0183	GYM001
2024-06-14	15:26:00+02	18:14:00+02	VST001074	USR0197	GYM004
2023-06-08	14:50:00+02	17:10:00+02	VST001075	USR0172	GYM004
2024-06-21	16:56:00+02	18:21:00+02	VST001076	USR0397	GYM001
2024-03-01	09:20:00+02	10:17:00+02	VST001077	USR0349	GYM002
2024-11-11	14:45:00+02	17:08:00+02	VST001078	USR0276	GYM002
2023-01-23	13:17:00+02	14:53:00+02	VST001079	USR0078	GYM004
2023-02-16	13:47:00+02	14:43:00+02	VST001080	USR0416	GYM002
2024-06-08	11:46:00+02	12:24:00+02	VST001081	USR0444	GYM006
2024-12-29	13:41:00+02	14:29:00+02	VST001082	USR0178	GYM001
2024-12-06	10:52:00+02	11:40:00+02	VST001083	USR0027	GYM004
2023-05-24	09:18:00+02	12:14:00+02	VST001084	USR0120	GYM001
2024-08-07	16:42:00+02	18:16:00+02	VST001085	USR0281	GYM002
2024-10-29	09:56:00+02	12:20:00+02	VST001086	USR0308	GYM001
2024-08-11	17:03:00+02	17:37:00+02	VST001087	USR0196	GYM002
2024-02-23	16:42:00+02	19:19:00+02	VST001088	USR0277	GYM002
2024-11-11	11:18:00+02	12:26:00+02	VST001089	USR0018	GYM001
2023-03-26	13:57:00+02	14:27:00+02	VST001090	USR0295	GYM002
2024-02-20	13:59:00+02	14:38:00+02	VST001091	USR0271	GYM006
2024-11-24	10:31:00+02	12:40:00+02	VST001092	USR0053	GYM003
2024-04-26	12:01:00+02	13:39:00+02	VST001093	USR0294	GYM001
2024-03-31	09:45:00+02	10:53:00+02	VST001094	USR0432	GYM003
2023-10-24	10:29:00+02	12:23:00+02	VST001095	USR0052	GYM001
2023-04-22	12:22:00+02	14:32:00+02	VST001096	USR0216	GYM002
2023-08-18	11:22:00+02	14:19:00+02	VST001097	USR0072	GYM002
2023-04-06	10:57:00+02	11:27:00+02	VST001098	USR0028	GYM004
2024-11-10	10:36:00+02	13:17:00+02	VST001099	USR0469	GYM006
2024-01-13	09:17:00+02	11:52:00+02	VST001100	USR0400	GYM004
2023-06-05	11:01:00+02	13:33:00+02	VST001101	USR0252	GYM003
2024-02-25	16:25:00+02	18:46:00+02	VST001102	USR0374	GYM002
2023-04-15	15:55:00+02	18:08:00+02	VST001103	USR0400	GYM004
2024-12-05	17:37:00+02	18:24:00+02	VST001104	USR0035	GYM002
2023-11-26	17:53:00+02	20:41:00+02	VST001105	USR0401	GYM001
2024-03-14	15:39:00+02	17:06:00+02	VST001106	USR0201	GYM004
2023-05-12	17:38:00+02	18:08:00+02	VST001107	USR0249	GYM003
2024-01-17	13:30:00+02	15:38:00+02	VST001108	USR0099	GYM004
2023-05-18	13:23:00+02	15:56:00+02	VST001109	USR0308	GYM002
2023-09-27	10:34:00+02	11:35:00+02	VST001110	USR0477	GYM005
2024-07-03	15:30:00+02	18:25:00+02	VST001111	USR0487	GYM005
2024-01-31	09:09:00+02	11:56:00+02	VST001112	USR0466	GYM006
2024-07-10	16:00:00+02	18:01:00+02	VST001113	USR0140	GYM002
2024-04-08	15:32:00+02	17:27:00+02	VST001114	USR0083	GYM001
2024-11-05	13:10:00+02	14:57:00+02	VST001115	USR0048	GYM004
2024-03-25	12:41:00+02	14:53:00+02	VST001116	USR0278	GYM005
2023-11-27	08:57:00+02	09:41:00+02	VST001117	USR0379	GYM001
2023-09-10	14:00:00+02	14:53:00+02	VST001118	USR0248	GYM002
2024-11-11	16:39:00+02	18:42:00+02	VST001119	USR0383	GYM001
2023-10-12	09:15:00+02	12:01:00+02	VST001120	USR0177	GYM002
2023-10-01	13:17:00+02	15:14:00+02	VST001121	USR0052	GYM006
2023-01-20	15:52:00+02	16:42:00+02	VST001122	USR0079	GYM004
2023-08-27	15:42:00+02	18:09:00+02	VST001123	USR0385	GYM001
2023-09-27	08:38:00+02	10:22:00+02	VST001124	USR0322	GYM004
2024-02-22	08:58:00+02	10:19:00+02	VST001125	USR0064	GYM001
2023-11-06	14:17:00+02	15:32:00+02	VST001126	USR0008	GYM002
2023-01-31	12:53:00+02	15:44:00+02	VST001127	USR0214	GYM002
2023-04-14	09:18:00+02	09:58:00+02	VST001128	USR0025	GYM001
2024-11-12	09:32:00+02	11:40:00+02	VST001129	USR0450	GYM006
2023-07-05	16:39:00+02	17:57:00+02	VST001130	USR0256	GYM002
2023-05-08	14:33:00+02	16:19:00+02	VST001131	USR0243	GYM003
2023-07-29	15:53:00+02	18:02:00+02	VST001132	USR0457	GYM003
2024-02-18	17:54:00+02	18:51:00+02	VST001133	USR0457	GYM004
2023-10-08	17:27:00+02	19:28:00+02	VST001134	USR0461	GYM003
2023-09-10	08:42:00+02	11:16:00+02	VST001135	USR0198	GYM003
2023-01-19	15:40:00+02	16:31:00+02	VST001136	USR0094	GYM006
2024-12-12	17:45:00+02	20:07:00+02	VST001137	USR0207	GYM006
2023-05-16	11:12:00+02	12:30:00+02	VST001138	USR0435	GYM005
2023-08-11	13:29:00+02	14:34:00+02	VST001139	USR0437	GYM005
2023-01-03	16:07:00+02	16:46:00+02	VST001140	USR0015	GYM006
2023-08-24	16:33:00+02	17:52:00+02	VST001141	USR0178	GYM005
2024-04-09	10:34:00+02	11:10:00+02	VST001142	USR0455	GYM006
2023-08-16	09:03:00+02	10:34:00+02	VST001143	USR0378	GYM005
2024-10-15	15:41:00+02	18:16:00+02	VST001144	USR0075	GYM002
2024-05-13	09:45:00+02	11:54:00+02	VST001145	USR0104	GYM006
2024-06-04	13:51:00+02	14:37:00+02	VST001146	USR0294	GYM004
2024-12-02	09:26:00+02	12:14:00+02	VST001147	USR0168	GYM004
2024-11-07	16:36:00+02	18:24:00+02	VST001148	USR0450	GYM006
2023-05-19	10:56:00+02	13:33:00+02	VST001149	USR0115	GYM003
2023-10-03	08:40:00+02	11:26:00+02	VST001150	USR0496	GYM004
2023-10-18	12:13:00+02	14:38:00+02	VST001151	USR0039	GYM003
2023-02-22	15:28:00+02	16:02:00+02	VST001152	USR0458	GYM004
2024-11-17	15:29:00+02	16:08:00+02	VST001153	USR0364	GYM001
2023-04-20	16:56:00+02	18:52:00+02	VST001154	USR0273	GYM001
2024-12-15	16:55:00+02	17:39:00+02	VST001155	USR0135	GYM006
2024-10-09	10:42:00+02	12:38:00+02	VST001156	USR0374	GYM004
2023-01-04	14:12:00+02	14:52:00+02	VST001157	USR0232	GYM002
2024-10-28	14:21:00+02	16:34:00+02	VST001158	USR0039	GYM003
2024-11-14	12:49:00+02	13:49:00+02	VST001159	USR0452	GYM004
2023-02-16	14:36:00+02	16:00:00+02	VST001160	USR0291	GYM006
2023-04-04	14:58:00+02	17:41:00+02	VST001161	USR0307	GYM003
2024-07-13	13:46:00+02	16:13:00+02	VST001162	USR0047	GYM005
2023-08-01	08:53:00+02	11:40:00+02	VST001163	USR0036	GYM006
2024-03-11	13:42:00+02	14:50:00+02	VST001164	USR0320	GYM004
2024-05-22	09:07:00+02	12:05:00+02	VST001165	USR0095	GYM002
2024-10-12	13:37:00+02	15:06:00+02	VST001166	USR0473	GYM005
2023-07-24	09:36:00+02	10:24:00+02	VST001167	USR0361	GYM006
2024-01-16	17:31:00+02	18:10:00+02	VST001168	USR0013	GYM004
2023-03-14	14:35:00+02	15:41:00+02	VST001169	USR0146	GYM001
2024-05-30	12:50:00+02	15:25:00+02	VST001170	USR0405	GYM004
2023-03-17	12:18:00+02	12:52:00+02	VST001171	USR0368	GYM001
2023-03-18	10:33:00+02	13:03:00+02	VST001172	USR0065	GYM001
2024-02-14	13:41:00+02	14:22:00+02	VST001173	USR0228	GYM006
2024-09-05	09:23:00+02	10:55:00+02	VST001174	USR0242	GYM004
2023-04-16	17:56:00+02	18:59:00+02	VST001175	USR0008	GYM004
2024-07-04	10:24:00+02	10:57:00+02	VST001176	USR0500	GYM001
2024-04-20	13:58:00+02	15:12:00+02	VST001177	USR0304	GYM003
2023-10-02	13:17:00+02	13:59:00+02	VST001178	USR0341	GYM005
2023-03-29	14:41:00+02	16:29:00+02	VST001179	USR0043	GYM002
2024-12-23	10:12:00+02	11:06:00+02	VST001180	USR0244	GYM004
2023-03-18	09:26:00+02	11:52:00+02	VST001181	USR0181	GYM005
2023-03-18	13:17:00+02	14:30:00+02	VST001182	USR0085	GYM005
2024-03-17	17:32:00+02	18:18:00+02	VST001183	USR0155	GYM003
2024-06-23	14:25:00+02	15:22:00+02	VST001184	USR0275	GYM005
2023-09-02	13:36:00+02	14:35:00+02	VST001185	USR0023	GYM004
2024-07-31	10:10:00+02	12:47:00+02	VST001186	USR0115	GYM006
2024-01-17	16:59:00+02	18:25:00+02	VST001187	USR0306	GYM006
2024-12-17	09:35:00+02	10:21:00+02	VST001188	USR0435	GYM005
2024-07-23	15:13:00+02	16:34:00+02	VST001189	USR0299	GYM004
2024-12-13	16:40:00+02	18:59:00+02	VST001190	USR0099	GYM004
2023-05-22	14:10:00+02	16:06:00+02	VST001191	USR0104	GYM001
2024-01-03	08:18:00+02	10:30:00+02	VST001192	USR0372	GYM003
2023-03-25	14:11:00+02	16:04:00+02	VST001193	USR0051	GYM002
2023-05-23	13:16:00+02	14:16:00+02	VST001194	USR0362	GYM001
2023-12-18	11:04:00+02	14:01:00+02	VST001195	USR0112	GYM002
2024-06-28	11:39:00+02	14:28:00+02	VST001196	USR0453	GYM004
2023-06-01	13:49:00+02	14:54:00+02	VST001197	USR0244	GYM006
2023-06-07	16:17:00+02	18:09:00+02	VST001198	USR0169	GYM001
2024-03-21	11:16:00+02	12:40:00+02	VST001199	USR0072	GYM005
2024-10-14	11:51:00+02	12:32:00+02	VST001200	USR0139	GYM005
2023-10-30	10:20:00+02	11:34:00+02	VST001201	USR0336	GYM002
2024-09-15	10:38:00+02	12:33:00+02	VST001202	USR0231	GYM004
2024-10-17	09:19:00+02	10:05:00+02	VST001203	USR0239	GYM006
2024-03-25	13:02:00+02	14:02:00+02	VST001204	USR0472	GYM002
2024-12-21	09:43:00+02	11:23:00+02	VST001205	USR0253	GYM006
2023-08-12	16:39:00+02	17:45:00+02	VST001206	USR0469	GYM003
2023-02-12	17:12:00+02	19:28:00+02	VST001207	USR0436	GYM006
2023-09-21	16:59:00+02	18:12:00+02	VST001208	USR0407	GYM005
2023-01-03	08:38:00+02	10:42:00+02	VST001209	USR0049	GYM001
2024-09-28	13:44:00+02	16:35:00+02	VST001210	USR0422	GYM001
2023-09-25	10:14:00+02	11:26:00+02	VST001211	USR0303	GYM001
2024-08-18	14:25:00+02	16:47:00+02	VST001212	USR0072	GYM006
2023-01-16	10:37:00+02	12:09:00+02	VST001213	USR0263	GYM005
2023-11-30	10:46:00+02	13:44:00+02	VST001214	USR0322	GYM006
2024-04-08	11:05:00+02	11:45:00+02	VST001215	USR0222	GYM004
2023-02-28	10:49:00+02	11:53:00+02	VST001216	USR0077	GYM005
2023-06-26	15:28:00+02	16:23:00+02	VST001217	USR0062	GYM005
2023-03-04	08:44:00+02	10:50:00+02	VST001218	USR0471	GYM006
2024-07-14	15:00:00+02	16:10:00+02	VST001219	USR0157	GYM006
2023-11-03	14:13:00+02	14:47:00+02	VST001220	USR0294	GYM001
2023-09-03	12:03:00+02	14:37:00+02	VST001221	USR0125	GYM005
2023-10-16	15:34:00+02	16:24:00+02	VST001222	USR0229	GYM001
2023-11-28	12:51:00+02	13:22:00+02	VST001223	USR0340	GYM004
2024-06-10	15:39:00+02	16:10:00+02	VST001224	USR0161	GYM003
2023-09-12	11:59:00+02	13:14:00+02	VST001225	USR0029	GYM001
2024-08-26	17:06:00+02	17:58:00+02	VST001226	USR0114	GYM006
2024-05-24	12:04:00+02	13:46:00+02	VST001227	USR0079	GYM002
2024-12-18	13:16:00+02	15:32:00+02	VST001228	USR0023	GYM003
2024-08-28	16:00:00+02	18:31:00+02	VST001229	USR0106	GYM004
2024-04-07	11:18:00+02	12:20:00+02	VST001230	USR0131	GYM006
2023-07-18	14:16:00+02	15:38:00+02	VST001231	USR0357	GYM003
2023-09-28	17:44:00+02	18:50:00+02	VST001232	USR0477	GYM006
2024-07-11	15:31:00+02	17:10:00+02	VST001233	USR0173	GYM001
2023-03-05	15:52:00+02	18:35:00+02	VST001234	USR0264	GYM006
2023-08-18	12:48:00+02	15:13:00+02	VST001235	USR0342	GYM004
2023-09-06	14:31:00+02	16:46:00+02	VST001236	USR0373	GYM002
2023-09-03	16:34:00+02	18:05:00+02	VST001237	USR0285	GYM001
2024-08-09	17:00:00+02	18:14:00+02	VST001238	USR0002	GYM001
2023-06-06	15:08:00+02	15:47:00+02	VST001239	USR0233	GYM004
2024-12-02	10:45:00+02	12:01:00+02	VST001240	USR0369	GYM004
2024-07-17	11:24:00+02	14:01:00+02	VST001241	USR0251	GYM003
2023-03-29	10:21:00+02	11:13:00+02	VST001242	USR0434	GYM002
2023-11-09	12:16:00+02	14:03:00+02	VST001243	USR0493	GYM006
2023-03-07	08:53:00+02	10:52:00+02	VST001244	USR0321	GYM003
2024-10-23	16:12:00+02	18:29:00+02	VST001245	USR0108	GYM006
2023-01-20	14:20:00+02	14:51:00+02	VST001246	USR0276	GYM006
2023-02-02	17:27:00+02	20:19:00+02	VST001247	USR0180	GYM006
2024-07-11	09:45:00+02	11:15:00+02	VST001248	USR0213	GYM003
2023-03-14	16:48:00+02	18:07:00+02	VST001249	USR0293	GYM001
2023-12-09	10:07:00+02	11:07:00+02	VST001250	USR0072	GYM004
2023-05-13	12:51:00+02	15:36:00+02	VST001251	USR0283	GYM001
2023-02-24	09:25:00+02	10:19:00+02	VST001252	USR0175	GYM002
2023-03-02	10:44:00+02	12:46:00+02	VST001253	USR0123	GYM003
2024-06-03	12:39:00+02	15:27:00+02	VST001254	USR0227	GYM002
2023-09-29	15:40:00+02	18:19:00+02	VST001255	USR0390	GYM004
2023-09-03	16:45:00+02	18:11:00+02	VST001256	USR0444	GYM004
2023-06-25	10:30:00+02	12:58:00+02	VST001257	USR0301	GYM005
2024-09-19	15:27:00+02	16:50:00+02	VST001258	USR0428	GYM002
2023-11-13	09:33:00+02	11:13:00+02	VST001259	USR0083	GYM001
2024-12-05	11:47:00+02	12:30:00+02	VST001260	USR0253	GYM002
2024-10-23	15:41:00+02	17:00:00+02	VST001261	USR0146	GYM003
2023-05-11	13:57:00+02	14:55:00+02	VST001262	USR0120	GYM004
2023-04-12	08:27:00+02	09:35:00+02	VST001263	USR0065	GYM004
2023-11-06	15:04:00+02	17:35:00+02	VST001264	USR0281	GYM002
2023-10-19	08:54:00+02	11:31:00+02	VST001265	USR0283	GYM002
2024-12-22	14:45:00+02	16:00:00+02	VST001266	USR0391	GYM006
2024-05-09	16:34:00+02	17:44:00+02	VST001267	USR0428	GYM002
2023-12-27	14:22:00+02	15:03:00+02	VST001268	USR0106	GYM006
2023-12-04	12:01:00+02	12:44:00+02	VST001269	USR0413	GYM003
2024-08-01	14:35:00+02	16:38:00+02	VST001270	USR0479	GYM003
2023-01-10	09:23:00+02	11:05:00+02	VST001271	USR0300	GYM001
2023-02-18	14:23:00+02	15:46:00+02	VST001272	USR0107	GYM002
2024-05-01	11:49:00+02	14:10:00+02	VST001273	USR0036	GYM001
2024-09-14	08:28:00+02	10:02:00+02	VST001274	USR0147	GYM005
2023-11-17	13:26:00+02	15:21:00+02	VST001275	USR0262	GYM003
2024-12-31	09:41:00+02	12:07:00+02	VST001276	USR0409	GYM004
2024-07-22	13:43:00+02	14:24:00+02	VST001277	USR0159	GYM006
2024-09-16	10:29:00+02	11:25:00+02	VST001278	USR0265	GYM005
2023-05-13	10:20:00+02	11:03:00+02	VST001279	USR0468	GYM004
2024-08-05	08:39:00+02	11:26:00+02	VST001280	USR0202	GYM005
2023-03-24	12:53:00+02	14:08:00+02	VST001281	USR0421	GYM001
2023-02-26	16:03:00+02	17:13:00+02	VST001282	USR0155	GYM001
2024-01-11	10:22:00+02	10:59:00+02	VST001283	USR0013	GYM006
2023-12-15	16:00:00+02	18:34:00+02	VST001284	USR0297	GYM003
2023-09-28	15:39:00+02	18:20:00+02	VST001285	USR0384	GYM006
2024-04-27	08:05:00+02	09:04:00+02	VST001286	USR0322	GYM004
2023-04-21	09:21:00+02	10:09:00+02	VST001287	USR0498	GYM005
2023-03-17	08:19:00+02	09:49:00+02	VST001288	USR0085	GYM006
2023-06-07	12:22:00+02	14:45:00+02	VST001289	USR0481	GYM002
2024-06-15	11:40:00+02	14:38:00+02	VST001290	USR0280	GYM002
2024-10-04	10:33:00+02	12:26:00+02	VST001291	USR0245	GYM003
2023-11-25	17:21:00+02	19:38:00+02	VST001292	USR0300	GYM006
2023-05-02	17:00:00+02	18:20:00+02	VST001293	USR0362	GYM004
2023-02-10	15:13:00+02	17:06:00+02	VST001294	USR0354	GYM002
2023-06-16	09:53:00+02	11:21:00+02	VST001295	USR0316	GYM003
2024-10-03	12:55:00+02	13:53:00+02	VST001296	USR0009	GYM006
2023-01-23	12:03:00+02	13:56:00+02	VST001297	USR0386	GYM003
2023-10-06	13:08:00+02	14:36:00+02	VST001298	USR0247	GYM004
2024-04-13	10:04:00+02	10:59:00+02	VST001299	USR0312	GYM002
2024-02-04	08:48:00+02	10:18:00+02	VST001300	USR0414	GYM002
2023-01-09	12:04:00+02	14:19:00+02	VST001301	USR0278	GYM002
2023-01-13	15:09:00+02	16:30:00+02	VST001302	USR0238	GYM001
2023-02-21	15:48:00+02	17:54:00+02	VST001303	USR0203	GYM002
2023-07-28	09:04:00+02	10:30:00+02	VST001304	USR0247	GYM005
2024-07-03	09:53:00+02	10:41:00+02	VST001305	USR0235	GYM001
2024-09-03	16:31:00+02	19:01:00+02	VST001306	USR0081	GYM006
2024-12-05	17:08:00+02	20:07:00+02	VST001307	USR0356	GYM001
2024-02-06	08:16:00+02	10:50:00+02	VST001308	USR0013	GYM001
2023-07-10	16:47:00+02	17:30:00+02	VST001309	USR0327	GYM001
2023-02-20	17:48:00+02	20:09:00+02	VST001310	USR0016	GYM003
2024-01-28	12:07:00+02	13:14:00+02	VST001311	USR0481	GYM005
2024-10-14	10:27:00+02	11:52:00+02	VST001312	USR0045	GYM004
2024-11-10	12:58:00+02	15:24:00+02	VST001313	USR0321	GYM002
2024-09-12	15:19:00+02	16:34:00+02	VST001314	USR0139	GYM001
2024-12-19	08:01:00+02	10:10:00+02	VST001315	USR0326	GYM004
2023-10-27	14:01:00+02	16:06:00+02	VST001316	USR0148	GYM003
2024-09-13	12:06:00+02	13:10:00+02	VST001317	USR0355	GYM004
2023-07-15	17:44:00+02	20:11:00+02	VST001318	USR0236	GYM001
2024-02-21	15:06:00+02	16:25:00+02	VST001319	USR0191	GYM006
2024-10-25	11:11:00+02	13:12:00+02	VST001320	USR0101	GYM005
2024-02-24	09:27:00+02	11:06:00+02	VST001321	USR0105	GYM004
2024-10-01	16:56:00+02	18:17:00+02	VST001322	USR0474	GYM001
2024-09-08	14:09:00+02	16:04:00+02	VST001323	USR0250	GYM001
2024-06-05	09:09:00+02	10:11:00+02	VST001324	USR0396	GYM002
2023-12-22	16:58:00+02	17:36:00+02	VST001325	USR0446	GYM006
2023-05-28	17:17:00+02	20:12:00+02	VST001326	USR0094	GYM002
2023-12-31	16:39:00+02	17:24:00+02	VST001327	USR0220	GYM006
2023-12-30	16:39:00+02	18:20:00+02	VST001328	USR0475	GYM005
2024-10-13	17:27:00+02	18:31:00+02	VST001329	USR0298	GYM002
2024-12-02	08:20:00+02	09:18:00+02	VST001330	USR0339	GYM005
2024-02-06	14:39:00+02	17:08:00+02	VST001331	USR0453	GYM003
2024-08-28	16:01:00+02	18:28:00+02	VST001332	USR0442	GYM003
2024-05-06	08:44:00+02	11:01:00+02	VST001333	USR0133	GYM006
2023-08-17	14:36:00+02	15:49:00+02	VST001334	USR0361	GYM006
2024-07-28	14:22:00+02	16:19:00+02	VST001335	USR0155	GYM002
2024-06-20	12:19:00+02	13:45:00+02	VST001336	USR0028	GYM003
2023-09-25	08:16:00+02	10:01:00+02	VST001337	USR0282	GYM004
2024-02-09	14:05:00+02	15:15:00+02	VST001338	USR0475	GYM004
2023-01-11	09:09:00+02	10:22:00+02	VST001339	USR0116	GYM004
2023-11-16	13:53:00+02	16:50:00+02	VST001340	USR0305	GYM003
2024-12-13	12:06:00+02	14:57:00+02	VST001341	USR0234	GYM004
2023-05-06	09:46:00+02	11:14:00+02	VST001342	USR0405	GYM005
2023-11-02	17:55:00+02	18:47:00+02	VST001343	USR0001	GYM001
2024-12-02	13:40:00+02	15:55:00+02	VST001344	USR0348	GYM006
2024-05-25	10:16:00+02	12:59:00+02	VST001345	USR0240	GYM002
2023-03-30	08:45:00+02	11:20:00+02	VST001346	USR0058	GYM005
2023-12-21	14:00:00+02	15:25:00+02	VST001347	USR0335	GYM004
2024-09-19	17:19:00+02	19:50:00+02	VST001348	USR0183	GYM001
2023-12-18	13:46:00+02	16:14:00+02	VST001349	USR0337	GYM002
2024-11-19	10:59:00+02	12:40:00+02	VST001350	USR0026	GYM005
2023-01-14	15:55:00+02	16:28:00+02	VST001351	USR0468	GYM002
2023-09-14	16:10:00+02	18:29:00+02	VST001352	USR0409	GYM006
2023-07-28	11:06:00+02	12:39:00+02	VST001353	USR0077	GYM003
2023-10-08	10:18:00+02	11:51:00+02	VST001354	USR0417	GYM004
2024-03-18	09:04:00+02	10:57:00+02	VST001355	USR0217	GYM005
2024-01-24	15:48:00+02	18:09:00+02	VST001356	USR0328	GYM005
2024-09-08	08:37:00+02	11:35:00+02	VST001357	USR0325	GYM001
2024-04-27	13:00:00+02	14:26:00+02	VST001358	USR0262	GYM001
2023-05-27	11:26:00+02	12:34:00+02	VST001359	USR0023	GYM001
2023-10-06	08:44:00+02	11:40:00+02	VST001360	USR0244	GYM002
2024-06-04	11:24:00+02	11:55:00+02	VST001361	USR0158	GYM004
2024-09-21	08:42:00+02	10:58:00+02	VST001362	USR0206	GYM002
2024-08-28	13:23:00+02	14:04:00+02	VST001363	USR0310	GYM004
2024-03-09	13:17:00+02	13:57:00+02	VST001364	USR0087	GYM005
2023-05-24	16:47:00+02	19:17:00+02	VST001365	USR0267	GYM002
2023-10-16	14:47:00+02	17:26:00+02	VST001366	USR0415	GYM002
2024-01-21	17:16:00+02	17:54:00+02	VST001367	USR0134	GYM002
2023-01-14	16:04:00+02	18:22:00+02	VST001368	USR0267	GYM003
2023-09-14	12:19:00+02	15:04:00+02	VST001369	USR0333	GYM006
2023-12-12	08:37:00+02	10:47:00+02	VST001370	USR0268	GYM004
2024-11-28	11:15:00+02	13:47:00+02	VST001371	USR0450	GYM004
2023-12-11	12:52:00+02	13:47:00+02	VST001372	USR0053	GYM002
2024-02-04	14:05:00+02	16:30:00+02	VST001373	USR0099	GYM003
2023-07-26	08:48:00+02	11:24:00+02	VST001374	USR0247	GYM002
2023-06-21	13:39:00+02	15:10:00+02	VST001375	USR0036	GYM004
2024-04-08	12:39:00+02	13:30:00+02	VST001376	USR0401	GYM006
2023-09-27	10:07:00+02	12:59:00+02	VST001377	USR0028	GYM006
2023-08-09	14:16:00+02	14:49:00+02	VST001378	USR0220	GYM005
2023-06-01	15:27:00+02	17:41:00+02	VST001379	USR0406	GYM003
2024-09-14	14:49:00+02	16:14:00+02	VST001380	USR0102	GYM006
2023-07-02	15:30:00+02	16:33:00+02	VST001381	USR0263	GYM003
2024-02-03	14:35:00+02	16:36:00+02	VST001382	USR0271	GYM002
2023-03-13	13:47:00+02	15:32:00+02	VST001383	USR0224	GYM005
2024-02-22	11:11:00+02	12:42:00+02	VST001384	USR0139	GYM004
2023-10-10	16:28:00+02	17:21:00+02	VST001385	USR0280	GYM006
2023-03-15	16:29:00+02	17:03:00+02	VST001386	USR0451	GYM006
2023-12-21	14:16:00+02	16:48:00+02	VST001387	USR0286	GYM001
2024-12-27	16:51:00+02	18:39:00+02	VST001388	USR0454	GYM004
2024-05-11	12:33:00+02	13:44:00+02	VST001389	USR0250	GYM006
2023-11-24	09:24:00+02	11:51:00+02	VST001390	USR0322	GYM006
2024-06-18	15:14:00+02	18:10:00+02	VST001391	USR0317	GYM004
2024-08-02	09:20:00+02	12:19:00+02	VST001392	USR0078	GYM005
2024-03-22	15:20:00+02	15:56:00+02	VST001393	USR0297	GYM003
2024-01-08	11:04:00+02	13:30:00+02	VST001394	USR0338	GYM004
2023-12-28	17:18:00+02	19:46:00+02	VST001395	USR0307	GYM003
2023-04-03	13:00:00+02	14:05:00+02	VST001396	USR0428	GYM005
2023-11-17	13:28:00+02	15:41:00+02	VST001397	USR0351	GYM005
2023-11-20	09:45:00+02	11:02:00+02	VST001398	USR0013	GYM002
2024-01-19	09:21:00+02	11:25:00+02	VST001399	USR0346	GYM001
2024-07-28	13:35:00+02	16:03:00+02	VST001400	USR0492	GYM005
2023-12-12	13:02:00+02	13:32:00+02	VST001401	USR0396	GYM005
2023-04-13	13:13:00+02	14:01:00+02	VST001402	USR0082	GYM003
2023-08-03	15:36:00+02	17:44:00+02	VST001403	USR0009	GYM005
2023-07-11	15:16:00+02	17:11:00+02	VST001404	USR0497	GYM004
2024-11-02	10:50:00+02	13:35:00+02	VST001405	USR0213	GYM002
2024-12-19	15:34:00+02	16:12:00+02	VST001406	USR0048	GYM002
2023-07-13	13:59:00+02	15:44:00+02	VST001407	USR0049	GYM004
2024-01-15	15:37:00+02	17:56:00+02	VST001408	USR0309	GYM006
2024-02-07	08:43:00+02	10:22:00+02	VST001409	USR0440	GYM005
2024-10-25	14:01:00+02	16:49:00+02	VST001410	USR0040	GYM001
2024-08-22	15:25:00+02	18:22:00+02	VST001411	USR0363	GYM005
2023-01-11	12:41:00+02	14:04:00+02	VST001412	USR0280	GYM002
2023-07-06	08:58:00+02	09:48:00+02	VST001413	USR0226	GYM001
2024-12-26	09:16:00+02	11:11:00+02	VST001414	USR0456	GYM006
2023-01-15	14:55:00+02	15:39:00+02	VST001415	USR0108	GYM003
2023-10-24	14:12:00+02	16:53:00+02	VST001416	USR0245	GYM003
2024-02-15	16:45:00+02	18:48:00+02	VST001417	USR0255	GYM005
2024-08-07	10:43:00+02	11:26:00+02	VST001418	USR0033	GYM005
2023-02-21	08:31:00+02	09:29:00+02	VST001419	USR0023	GYM001
2024-10-01	10:26:00+02	12:34:00+02	VST001420	USR0333	GYM001
2023-01-28	15:28:00+02	17:31:00+02	VST001421	USR0054	GYM006
2024-07-30	08:35:00+02	11:04:00+02	VST001422	USR0309	GYM005
2023-01-17	10:09:00+02	10:49:00+02	VST001423	USR0049	GYM002
2023-12-17	09:08:00+02	11:11:00+02	VST001424	USR0462	GYM003
2024-03-03	12:01:00+02	14:04:00+02	VST001425	USR0078	GYM006
2024-10-11	14:15:00+02	15:29:00+02	VST001426	USR0336	GYM001
2023-08-17	14:10:00+02	17:03:00+02	VST001427	USR0433	GYM002
2023-07-29	14:32:00+02	15:19:00+02	VST001428	USR0358	GYM005
2024-03-06	17:40:00+02	20:33:00+02	VST001429	USR0122	GYM004
2023-10-21	08:33:00+02	09:55:00+02	VST001430	USR0444	GYM001
2024-08-04	10:37:00+02	11:42:00+02	VST001431	USR0359	GYM006
2023-04-14	15:40:00+02	17:35:00+02	VST001432	USR0090	GYM004
2023-07-23	14:19:00+02	15:50:00+02	VST001433	USR0346	GYM002
2023-02-22	14:20:00+02	17:08:00+02	VST001434	USR0193	GYM003
2024-01-10	15:34:00+02	16:33:00+02	VST001435	USR0416	GYM002
2023-02-23	09:18:00+02	11:50:00+02	VST001436	USR0377	GYM003
2023-10-03	17:47:00+02	20:45:00+02	VST001437	USR0463	GYM002
2023-12-01	10:20:00+02	11:43:00+02	VST001438	USR0244	GYM001
2023-01-31	17:02:00+02	18:29:00+02	VST001439	USR0149	GYM001
2023-05-15	14:15:00+02	16:07:00+02	VST001440	USR0146	GYM006
2023-02-27	14:47:00+02	16:47:00+02	VST001441	USR0478	GYM004
2023-04-15	13:21:00+02	14:59:00+02	VST001442	USR0316	GYM002
2023-09-23	12:45:00+02	15:23:00+02	VST001443	USR0378	GYM002
2024-06-05	12:15:00+02	14:33:00+02	VST001444	USR0141	GYM004
2024-05-10	09:56:00+02	11:36:00+02	VST001445	USR0408	GYM005
2023-09-10	08:26:00+02	09:09:00+02	VST001446	USR0286	GYM006
2023-10-22	11:10:00+02	11:56:00+02	VST001447	USR0386	GYM002
2024-10-29	16:31:00+02	18:36:00+02	VST001448	USR0339	GYM006
2023-06-07	16:50:00+02	18:48:00+02	VST001449	USR0111	GYM002
2024-07-02	14:36:00+02	17:01:00+02	VST001450	USR0108	GYM002
2024-09-22	17:35:00+02	20:09:00+02	VST001451	USR0367	GYM005
2023-03-08	10:00:00+02	12:38:00+02	VST001452	USR0281	GYM001
2023-10-26	12:28:00+02	15:12:00+02	VST001453	USR0050	GYM006
2024-04-07	12:26:00+02	13:27:00+02	VST001454	USR0014	GYM004
2024-12-25	15:36:00+02	18:06:00+02	VST001455	USR0134	GYM006
2023-04-11	11:39:00+02	14:25:00+02	VST001456	USR0076	GYM005
2023-02-25	12:52:00+02	15:38:00+02	VST001457	USR0084	GYM003
2023-11-28	16:22:00+02	18:06:00+02	VST001458	USR0343	GYM003
2024-01-28	11:24:00+02	13:49:00+02	VST001459	USR0158	GYM005
2024-01-16	10:05:00+02	12:09:00+02	VST001460	USR0286	GYM005
2023-04-02	10:18:00+02	11:04:00+02	VST001461	USR0422	GYM001
2024-03-22	09:15:00+02	10:33:00+02	VST001462	USR0314	GYM006
2023-04-19	15:42:00+02	18:09:00+02	VST001463	USR0094	GYM006
2023-11-13	10:56:00+02	11:48:00+02	VST001464	USR0297	GYM003
2023-06-17	15:35:00+02	16:25:00+02	VST001465	USR0094	GYM004
2024-03-10	09:29:00+02	11:39:00+02	VST001466	USR0057	GYM006
2024-03-17	13:27:00+02	14:42:00+02	VST001467	USR0164	GYM002
2023-08-06	13:55:00+02	15:38:00+02	VST001468	USR0320	GYM002
2023-08-10	09:06:00+02	09:55:00+02	VST001469	USR0497	GYM001
2024-11-03	17:23:00+02	18:20:00+02	VST001470	USR0098	GYM001
2024-06-11	17:15:00+02	18:27:00+02	VST001471	USR0016	GYM003
2023-10-05	12:57:00+02	14:37:00+02	VST001472	USR0344	GYM004
2024-07-22	13:07:00+02	14:05:00+02	VST001473	USR0078	GYM004
2024-07-27	10:41:00+02	11:48:00+02	VST001474	USR0346	GYM005
2024-04-10	10:58:00+02	13:35:00+02	VST001475	USR0072	GYM001
2024-08-24	14:10:00+02	15:18:00+02	VST001476	USR0270	GYM006
2024-08-06	16:40:00+02	18:02:00+02	VST001477	USR0287	GYM002
2023-01-30	11:49:00+02	14:32:00+02	VST001478	USR0066	GYM006
2023-12-25	10:04:00+02	10:39:00+02	VST001479	USR0368	GYM002
2023-10-15	11:25:00+02	13:10:00+02	VST001480	USR0068	GYM003
2023-03-27	10:22:00+02	12:38:00+02	VST001481	USR0193	GYM002
2023-08-22	12:02:00+02	14:50:00+02	VST001482	USR0055	GYM006
2023-11-09	16:25:00+02	17:28:00+02	VST001483	USR0468	GYM006
2023-12-31	08:26:00+02	10:57:00+02	VST001484	USR0379	GYM004
2023-09-26	14:09:00+02	16:07:00+02	VST001485	USR0462	GYM004
2024-11-28	17:27:00+02	19:44:00+02	VST001486	USR0168	GYM001
2023-05-11	17:46:00+02	20:09:00+02	VST001487	USR0409	GYM006
2023-12-17	14:17:00+02	14:52:00+02	VST001488	USR0025	GYM003
2023-06-29	15:58:00+02	17:42:00+02	VST001489	USR0131	GYM002
2024-04-24	17:24:00+02	18:42:00+02	VST001490	USR0325	GYM001
2023-06-12	10:12:00+02	10:58:00+02	VST001491	USR0102	GYM005
2023-04-06	09:28:00+02	10:03:00+02	VST001492	USR0374	GYM005
2024-05-24	09:07:00+02	10:36:00+02	VST001493	USR0282	GYM002
2023-12-31	13:16:00+02	15:59:00+02	VST001494	USR0296	GYM002
2023-12-19	14:47:00+02	16:42:00+02	VST001495	USR0294	GYM002
2024-03-11	16:10:00+02	18:25:00+02	VST001496	USR0422	GYM004
2023-03-24	16:58:00+02	19:56:00+02	VST001497	USR0452	GYM002
2023-08-13	15:00:00+02	16:57:00+02	VST001498	USR0263	GYM005
2024-02-16	14:59:00+02	16:52:00+02	VST001499	USR0478	GYM002
2023-04-28	17:48:00+02	20:22:00+02	VST001500	USR0414	GYM006
2024-04-26	09:15:00+02	12:00:00+02	VST001501	USR0120	GYM003
2023-07-11	10:08:00+02	12:58:00+02	VST001502	USR0403	GYM005
2024-08-13	13:24:00+02	15:47:00+02	VST001503	USR0231	GYM003
2024-08-12	09:15:00+02	11:42:00+02	VST001504	USR0291	GYM005
2024-10-20	15:40:00+02	17:27:00+02	VST001505	USR0488	GYM001
2023-04-17	15:57:00+02	18:52:00+02	VST001506	USR0161	GYM006
2024-01-17	16:49:00+02	17:52:00+02	VST001507	USR0161	GYM005
2024-01-25	13:52:00+02	15:40:00+02	VST001508	USR0078	GYM006
2023-09-01	10:11:00+02	11:24:00+02	VST001509	USR0038	GYM005
2024-08-07	17:24:00+02	19:00:00+02	VST001510	USR0394	GYM003
2024-04-12	11:06:00+02	12:34:00+02	VST001511	USR0441	GYM003
2024-06-21	10:12:00+02	12:45:00+02	VST001512	USR0028	GYM005
2023-07-29	15:23:00+02	17:28:00+02	VST001513	USR0462	GYM005
2024-08-26	16:34:00+02	18:17:00+02	VST001514	USR0100	GYM004
2024-09-28	08:56:00+02	09:38:00+02	VST001515	USR0294	GYM006
2023-03-14	10:07:00+02	11:14:00+02	VST001516	USR0400	GYM006
2024-09-26	16:50:00+02	18:50:00+02	VST001517	USR0124	GYM006
2023-11-05	10:36:00+02	12:18:00+02	VST001518	USR0405	GYM006
2024-11-26	13:11:00+02	15:37:00+02	VST001519	USR0092	GYM001
2024-11-29	10:48:00+02	12:00:00+02	VST001520	USR0255	GYM001
2024-12-10	10:45:00+02	11:56:00+02	VST001521	USR0097	GYM002
2024-08-12	13:30:00+02	16:17:00+02	VST001522	USR0006	GYM005
2023-07-05	11:50:00+02	13:33:00+02	VST001523	USR0169	GYM005
2023-09-10	13:54:00+02	15:10:00+02	VST001524	USR0383	GYM005
2023-01-13	16:51:00+02	18:05:00+02	VST001525	USR0271	GYM005
2023-10-26	12:50:00+02	13:59:00+02	VST001526	USR0108	GYM006
2023-03-17	09:20:00+02	10:31:00+02	VST001527	USR0387	GYM006
2023-02-20	12:16:00+02	13:46:00+02	VST001528	USR0299	GYM001
2023-05-29	11:21:00+02	12:20:00+02	VST001529	USR0047	GYM003
2024-12-31	17:24:00+02	18:04:00+02	VST001530	USR0099	GYM004
2023-05-02	12:41:00+02	14:32:00+02	VST001531	USR0014	GYM006
2023-07-30	10:08:00+02	13:05:00+02	VST001532	USR0194	GYM006
2023-10-07	13:10:00+02	14:12:00+02	VST001533	USR0157	GYM006
2024-06-21	17:06:00+02	19:28:00+02	VST001534	USR0388	GYM003
2024-11-15	09:35:00+02	11:11:00+02	VST001535	USR0154	GYM003
2023-06-05	16:34:00+02	18:38:00+02	VST001536	USR0115	GYM001
2023-08-26	10:52:00+02	12:09:00+02	VST001537	USR0396	GYM006
2024-01-11	17:54:00+02	19:16:00+02	VST001538	USR0258	GYM004
2023-03-23	10:37:00+02	13:30:00+02	VST001539	USR0145	GYM005
2024-05-06	10:55:00+02	11:33:00+02	VST001540	USR0291	GYM006
2023-12-22	13:45:00+02	15:36:00+02	VST001541	USR0010	GYM001
2023-09-30	17:37:00+02	19:35:00+02	VST001542	USR0368	GYM001
2024-08-02	08:42:00+02	09:49:00+02	VST001543	USR0214	GYM004
2023-02-13	08:29:00+02	10:34:00+02	VST001544	USR0233	GYM002
2024-07-26	09:23:00+02	11:47:00+02	VST001545	USR0171	GYM001
2023-05-03	08:46:00+02	11:34:00+02	VST001546	USR0021	GYM003
2023-12-15	17:50:00+02	19:01:00+02	VST001547	USR0015	GYM003
2024-12-08	12:31:00+02	15:17:00+02	VST001548	USR0419	GYM005
2023-11-26	11:35:00+02	13:22:00+02	VST001549	USR0368	GYM001
2024-02-13	17:45:00+02	18:46:00+02	VST001550	USR0126	GYM005
2023-11-19	15:06:00+02	15:42:00+02	VST001551	USR0341	GYM001
2023-04-21	08:31:00+02	10:44:00+02	VST001552	USR0341	GYM004
2023-03-30	16:29:00+02	19:06:00+02	VST001553	USR0213	GYM006
2024-03-08	17:18:00+02	18:25:00+02	VST001554	USR0188	GYM001
2024-12-10	12:56:00+02	15:23:00+02	VST001555	USR0172	GYM002
2024-12-12	13:09:00+02	15:00:00+02	VST001556	USR0480	GYM003
2023-04-09	16:14:00+02	17:23:00+02	VST001557	USR0247	GYM004
2024-06-22	12:10:00+02	12:41:00+02	VST001558	USR0005	GYM006
2024-08-23	14:55:00+02	17:44:00+02	VST001559	USR0231	GYM006
2023-05-26	13:04:00+02	15:43:00+02	VST001560	USR0201	GYM003
2024-11-24	15:44:00+02	17:38:00+02	VST001561	USR0373	GYM006
2023-09-14	09:14:00+02	10:59:00+02	VST001562	USR0402	GYM005
2023-07-08	09:01:00+02	11:32:00+02	VST001563	USR0149	GYM004
2023-08-28	10:41:00+02	12:25:00+02	VST001564	USR0072	GYM002
2024-05-17	15:30:00+02	18:26:00+02	VST001565	USR0492	GYM003
2024-12-08	15:05:00+02	16:12:00+02	VST001566	USR0500	GYM001
2024-11-07	16:15:00+02	19:09:00+02	VST001567	USR0226	GYM001
2023-09-28	15:55:00+02	18:18:00+02	VST001568	USR0074	GYM001
2024-06-03	11:28:00+02	13:24:00+02	VST001569	USR0307	GYM004
2024-07-03	13:48:00+02	14:46:00+02	VST001570	USR0169	GYM002
2023-04-24	10:27:00+02	12:59:00+02	VST001571	USR0249	GYM006
2023-12-05	13:20:00+02	14:00:00+02	VST001572	USR0280	GYM002
2024-07-21	13:26:00+02	14:31:00+02	VST001573	USR0488	GYM002
2023-12-25	13:53:00+02	16:44:00+02	VST001574	USR0152	GYM003
2024-10-11	14:48:00+02	15:47:00+02	VST001575	USR0224	GYM004
2024-09-05	10:13:00+02	12:01:00+02	VST001576	USR0225	GYM001
2023-11-30	14:19:00+02	14:55:00+02	VST001577	USR0038	GYM003
2024-11-19	16:47:00+02	18:59:00+02	VST001578	USR0044	GYM006
2023-06-18	17:35:00+02	19:01:00+02	VST001579	USR0185	GYM002
2023-12-05	09:48:00+02	12:12:00+02	VST001580	USR0499	GYM001
2023-09-18	13:26:00+02	15:27:00+02	VST001581	USR0443	GYM004
2023-07-18	12:07:00+02	13:00:00+02	VST001582	USR0241	GYM005
2023-07-30	15:57:00+02	17:50:00+02	VST001583	USR0418	GYM002
2023-10-14	10:05:00+02	10:49:00+02	VST001584	USR0331	GYM002
2024-11-22	12:33:00+02	13:52:00+02	VST001585	USR0351	GYM002
2024-04-16	15:40:00+02	18:39:00+02	VST001586	USR0210	GYM002
2024-04-26	12:13:00+02	14:57:00+02	VST001587	USR0023	GYM001
2023-01-23	10:24:00+02	11:50:00+02	VST001588	USR0124	GYM004
2024-07-13	09:39:00+02	11:20:00+02	VST001589	USR0086	GYM003
2023-04-19	08:51:00+02	10:11:00+02	VST001590	USR0043	GYM001
2023-10-23	12:57:00+02	13:32:00+02	VST001591	USR0466	GYM004
2023-01-06	14:33:00+02	15:24:00+02	VST001592	USR0040	GYM003
2024-07-03	15:08:00+02	17:55:00+02	VST001593	USR0303	GYM002
2024-11-11	12:14:00+02	14:38:00+02	VST001594	USR0169	GYM004
2023-07-22	10:43:00+02	11:35:00+02	VST001595	USR0175	GYM002
2023-11-21	13:35:00+02	16:16:00+02	VST001596	USR0487	GYM004
2023-09-01	17:51:00+02	20:01:00+02	VST001597	USR0020	GYM006
2023-11-23	13:20:00+02	14:39:00+02	VST001598	USR0461	GYM005
2023-02-16	11:14:00+02	13:49:00+02	VST001599	USR0109	GYM002
2024-08-13	10:43:00+02	12:34:00+02	VST001600	USR0193	GYM002
2024-09-13	16:30:00+02	19:10:00+02	VST001601	USR0244	GYM002
2023-01-13	16:47:00+02	17:31:00+02	VST001602	USR0324	GYM006
2024-01-15	15:58:00+02	18:00:00+02	VST001603	USR0280	GYM001
2023-12-31	16:30:00+02	18:41:00+02	VST001604	USR0228	GYM003
2024-08-24	13:15:00+02	14:22:00+02	VST001605	USR0036	GYM002
2023-12-08	16:29:00+02	18:48:00+02	VST001606	USR0045	GYM002
2023-08-09	08:23:00+02	10:27:00+02	VST001607	USR0386	GYM001
2023-03-14	09:32:00+02	11:40:00+02	VST001608	USR0028	GYM001
2024-09-16	14:42:00+02	16:47:00+02	VST001609	USR0154	GYM005
2023-02-15	16:37:00+02	17:10:00+02	VST001610	USR0023	GYM004
2024-05-18	15:48:00+02	17:30:00+02	VST001611	USR0207	GYM002
2023-10-01	12:06:00+02	14:04:00+02	VST001612	USR0420	GYM004
2024-07-08	11:40:00+02	13:39:00+02	VST001613	USR0091	GYM001
2023-07-27	17:57:00+02	19:45:00+02	VST001614	USR0390	GYM001
2024-09-06	14:01:00+02	16:25:00+02	VST001615	USR0419	GYM005
2023-05-04	08:49:00+02	11:42:00+02	VST001616	USR0359	GYM003
2023-01-10	08:51:00+02	09:43:00+02	VST001617	USR0038	GYM006
2023-11-25	12:48:00+02	14:13:00+02	VST001618	USR0419	GYM006
2023-07-06	16:26:00+02	18:49:00+02	VST001619	USR0228	GYM006
2024-06-26	16:01:00+02	18:17:00+02	VST001620	USR0202	GYM001
2024-10-29	12:52:00+02	15:15:00+02	VST001621	USR0350	GYM002
2023-03-01	17:09:00+02	18:52:00+02	VST001622	USR0309	GYM005
2024-03-17	08:08:00+02	09:19:00+02	VST001623	USR0489	GYM003
2023-08-05	09:50:00+02	12:08:00+02	VST001624	USR0254	GYM006
2023-01-02	15:21:00+02	17:37:00+02	VST001625	USR0038	GYM005
2024-06-19	10:17:00+02	11:22:00+02	VST001626	USR0221	GYM001
2024-12-18	12:30:00+02	15:30:00+02	VST001627	USR0500	GYM006
2024-12-11	14:14:00+02	15:06:00+02	VST001628	USR0187	GYM003
2023-12-22	14:52:00+02	15:58:00+02	VST001629	USR0043	GYM004
2024-09-17	14:14:00+02	15:37:00+02	VST001630	USR0359	GYM003
2024-10-28	08:46:00+02	10:33:00+02	VST001631	USR0114	GYM002
2023-06-14	14:50:00+02	17:21:00+02	VST001632	USR0260	GYM006
2023-04-01	08:52:00+02	11:36:00+02	VST001633	USR0005	GYM006
2023-06-16	17:43:00+02	19:38:00+02	VST001634	USR0068	GYM004
2023-07-26	17:35:00+02	18:21:00+02	VST001635	USR0228	GYM004
2023-10-09	11:19:00+02	13:25:00+02	VST001636	USR0123	GYM006
2023-03-06	14:11:00+02	15:03:00+02	VST001637	USR0173	GYM002
2024-05-30	17:26:00+02	17:57:00+02	VST001638	USR0336	GYM004
2023-06-06	12:55:00+02	15:09:00+02	VST001639	USR0153	GYM001
2023-11-02	09:15:00+02	10:54:00+02	VST001640	USR0462	GYM006
2024-01-30	14:35:00+02	16:51:00+02	VST001641	USR0267	GYM003
2023-03-15	16:36:00+02	17:50:00+02	VST001642	USR0157	GYM003
2023-07-06	15:41:00+02	18:33:00+02	VST001643	USR0162	GYM002
2024-07-27	17:23:00+02	19:51:00+02	VST001644	USR0214	GYM001
2023-12-03	12:46:00+02	15:41:00+02	VST001645	USR0398	GYM004
2024-11-06	10:01:00+02	11:06:00+02	VST001646	USR0376	GYM006
2024-07-21	10:11:00+02	11:32:00+02	VST001647	USR0408	GYM003
2024-09-14	09:39:00+02	10:56:00+02	VST001648	USR0443	GYM003
2024-12-30	14:43:00+02	16:50:00+02	VST001649	USR0423	GYM003
2023-08-28	14:22:00+02	16:06:00+02	VST001650	USR0026	GYM003
2024-06-16	13:47:00+02	16:38:00+02	VST001651	USR0427	GYM005
2023-05-21	17:31:00+02	20:06:00+02	VST001652	USR0292	GYM002
2023-09-22	14:14:00+02	14:54:00+02	VST001653	USR0423	GYM004
2023-05-19	10:27:00+02	12:14:00+02	VST001654	USR0189	GYM006
2024-04-03	11:23:00+02	14:22:00+02	VST001655	USR0400	GYM006
2023-03-11	16:41:00+02	18:28:00+02	VST001656	USR0122	GYM006
2024-01-20	14:51:00+02	17:27:00+02	VST001657	USR0230	GYM004
2024-09-21	16:32:00+02	19:25:00+02	VST001658	USR0059	GYM002
2023-07-17	08:41:00+02	11:09:00+02	VST001659	USR0096	GYM001
2023-07-24	08:46:00+02	10:13:00+02	VST001660	USR0262	GYM002
2024-12-26	08:39:00+02	09:15:00+02	VST001661	USR0354	GYM003
2024-07-21	10:20:00+02	10:50:00+02	VST001662	USR0312	GYM003
2024-11-17	13:41:00+02	14:50:00+02	VST001663	USR0136	GYM002
2024-10-01	16:05:00+02	17:42:00+02	VST001664	USR0350	GYM002
2024-03-06	16:51:00+02	18:37:00+02	VST001665	USR0283	GYM004
2023-11-21	15:47:00+02	18:17:00+02	VST001666	USR0455	GYM004
2024-03-17	10:32:00+02	11:33:00+02	VST001667	USR0411	GYM005
2023-10-15	16:47:00+02	18:30:00+02	VST001668	USR0473	GYM006
2023-08-14	10:23:00+02	12:39:00+02	VST001669	USR0120	GYM005
2023-03-05	13:35:00+02	14:50:00+02	VST001670	USR0430	GYM006
2024-07-13	13:26:00+02	16:01:00+02	VST001671	USR0425	GYM003
2024-12-14	10:46:00+02	12:18:00+02	VST001672	USR0463	GYM005
2024-05-12	14:42:00+02	15:19:00+02	VST001673	USR0025	GYM005
2023-03-01	13:06:00+02	14:06:00+02	VST001674	USR0342	GYM001
2024-02-01	13:44:00+02	15:24:00+02	VST001675	USR0146	GYM002
2023-09-14	16:39:00+02	19:15:00+02	VST001676	USR0012	GYM004
2024-07-30	16:41:00+02	17:28:00+02	VST001677	USR0087	GYM005
2023-08-27	17:05:00+02	19:07:00+02	VST001678	USR0435	GYM004
2023-02-07	16:21:00+02	19:19:00+02	VST001679	USR0109	GYM006
2023-01-25	17:36:00+02	20:09:00+02	VST001680	USR0423	GYM005
2024-02-14	13:06:00+02	16:00:00+02	VST001681	USR0345	GYM006
2024-04-05	16:06:00+02	18:27:00+02	VST001682	USR0266	GYM005
2024-07-24	08:17:00+02	09:53:00+02	VST001683	USR0222	GYM003
2024-02-21	14:17:00+02	16:48:00+02	VST001684	USR0074	GYM001
2023-12-23	13:39:00+02	14:39:00+02	VST001685	USR0482	GYM006
2024-01-18	09:52:00+02	11:57:00+02	VST001686	USR0494	GYM002
2023-06-07	15:06:00+02	17:47:00+02	VST001687	USR0333	GYM002
2024-07-22	17:57:00+02	20:54:00+02	VST001688	USR0310	GYM003
2024-03-08	13:15:00+02	13:49:00+02	VST001689	USR0413	GYM003
2023-02-17	08:27:00+02	10:03:00+02	VST001690	USR0102	GYM002
2023-11-24	16:05:00+02	17:16:00+02	VST001691	USR0425	GYM006
2024-03-08	12:31:00+02	15:29:00+02	VST001692	USR0493	GYM002
2024-03-06	17:52:00+02	18:36:00+02	VST001693	USR0137	GYM001
2023-02-25	17:51:00+02	18:58:00+02	VST001694	USR0191	GYM005
2024-07-30	11:53:00+02	13:44:00+02	VST001695	USR0461	GYM001
2023-09-25	08:52:00+02	11:20:00+02	VST001696	USR0421	GYM002
2023-03-10	17:57:00+02	19:01:00+02	VST001697	USR0142	GYM005
2024-12-28	16:11:00+02	18:12:00+02	VST001698	USR0357	GYM002
2024-08-23	10:54:00+02	12:05:00+02	VST001699	USR0073	GYM001
2024-03-24	16:56:00+02	17:39:00+02	VST001700	USR0328	GYM001
2023-09-14	14:29:00+02	16:08:00+02	VST001701	USR0167	GYM006
2024-11-02	10:31:00+02	12:33:00+02	VST001702	USR0168	GYM006
2024-05-04	12:08:00+02	14:25:00+02	VST001703	USR0054	GYM001
2024-10-04	08:32:00+02	10:33:00+02	VST001704	USR0259	GYM005
2023-02-18	17:46:00+02	18:28:00+02	VST001705	USR0439	GYM006
2024-10-20	09:52:00+02	11:36:00+02	VST001706	USR0111	GYM006
2023-11-12	11:15:00+02	12:59:00+02	VST001707	USR0232	GYM004
2024-02-17	08:19:00+02	11:04:00+02	VST001708	USR0161	GYM004
2024-03-09	15:31:00+02	16:20:00+02	VST001709	USR0352	GYM006
2023-01-02	13:21:00+02	16:02:00+02	VST001710	USR0327	GYM002
2023-05-25	15:08:00+02	16:27:00+02	VST001711	USR0019	GYM005
2024-01-01	10:35:00+02	11:51:00+02	VST001712	USR0290	GYM003
2024-02-24	15:02:00+02	15:56:00+02	VST001713	USR0462	GYM006
2024-07-26	11:28:00+02	12:40:00+02	VST001714	USR0050	GYM004
2024-07-14	15:00:00+02	17:49:00+02	VST001715	USR0175	GYM005
2024-03-19	16:33:00+02	18:25:00+02	VST001716	USR0302	GYM005
2024-03-09	16:02:00+02	17:52:00+02	VST001717	USR0184	GYM004
2024-10-04	09:03:00+02	10:50:00+02	VST001718	USR0185	GYM005
2024-07-08	10:21:00+02	12:00:00+02	VST001719	USR0339	GYM005
2023-02-26	16:51:00+02	18:53:00+02	VST001720	USR0307	GYM004
2024-07-15	11:32:00+02	12:26:00+02	VST001721	USR0310	GYM001
2023-06-27	17:34:00+02	20:20:00+02	VST001722	USR0346	GYM006
2023-10-20	13:32:00+02	16:30:00+02	VST001723	USR0081	GYM002
2023-02-15	16:09:00+02	18:09:00+02	VST001724	USR0374	GYM003
2023-06-19	16:58:00+02	18:04:00+02	VST001725	USR0156	GYM002
2023-09-28	14:25:00+02	14:58:00+02	VST001726	USR0275	GYM001
2024-02-21	13:21:00+02	14:26:00+02	VST001727	USR0283	GYM001
2023-05-19	10:57:00+02	13:39:00+02	VST001728	USR0432	GYM005
2023-09-04	15:50:00+02	17:32:00+02	VST001729	USR0500	GYM002
2023-05-28	17:05:00+02	19:10:00+02	VST001730	USR0249	GYM001
2023-08-18	13:50:00+02	16:24:00+02	VST001731	USR0147	GYM002
2024-09-28	17:19:00+02	19:34:00+02	VST001732	USR0481	GYM001
2024-12-04	14:02:00+02	15:59:00+02	VST001733	USR0435	GYM003
2024-01-09	12:30:00+02	13:41:00+02	VST001734	USR0007	GYM001
2023-03-21	16:15:00+02	17:11:00+02	VST001735	USR0157	GYM002
2024-08-28	11:16:00+02	12:41:00+02	VST001736	USR0171	GYM005
2023-03-06	12:12:00+02	13:21:00+02	VST001737	USR0069	GYM002
2023-03-29	12:45:00+02	15:23:00+02	VST001738	USR0094	GYM004
2023-03-29	17:31:00+02	18:57:00+02	VST001739	USR0369	GYM002
2024-12-13	13:05:00+02	14:23:00+02	VST001740	USR0363	GYM003
2024-12-26	11:50:00+02	14:43:00+02	VST001741	USR0376	GYM006
2023-07-23	13:04:00+02	15:48:00+02	VST001742	USR0186	GYM003
2024-01-17	12:55:00+02	15:41:00+02	VST001743	USR0392	GYM003
2024-08-23	11:32:00+02	14:23:00+02	VST001744	USR0170	GYM001
2024-04-20	16:20:00+02	17:19:00+02	VST001745	USR0204	GYM003
2024-07-26	13:24:00+02	15:40:00+02	VST001746	USR0042	GYM002
2024-08-28	16:11:00+02	18:38:00+02	VST001747	USR0013	GYM006
2024-06-22	13:57:00+02	14:46:00+02	VST001748	USR0154	GYM005
2023-08-02	17:33:00+02	18:32:00+02	VST001749	USR0274	GYM003
2023-03-15	12:40:00+02	13:43:00+02	VST001750	USR0298	GYM002
2023-03-02	12:54:00+02	13:28:00+02	VST001751	USR0051	GYM001
2024-11-28	10:04:00+02	12:36:00+02	VST001752	USR0500	GYM001
2024-06-26	17:47:00+02	19:46:00+02	VST001753	USR0369	GYM005
2023-08-07	17:16:00+02	19:05:00+02	VST001754	USR0212	GYM005
2023-01-12	14:28:00+02	16:30:00+02	VST001755	USR0144	GYM002
2024-02-19	14:44:00+02	15:49:00+02	VST001756	USR0357	GYM005
2023-02-01	13:53:00+02	16:16:00+02	VST001757	USR0003	GYM005
2023-06-09	10:29:00+02	13:12:00+02	VST001758	USR0254	GYM001
2023-08-25	12:57:00+02	14:54:00+02	VST001759	USR0475	GYM002
2023-06-30	08:43:00+02	09:57:00+02	VST001760	USR0335	GYM006
2024-07-11	12:54:00+02	14:41:00+02	VST001761	USR0256	GYM005
2023-12-07	09:20:00+02	09:57:00+02	VST001762	USR0098	GYM002
2024-04-02	13:54:00+02	14:54:00+02	VST001763	USR0173	GYM003
2023-03-21	15:32:00+02	16:58:00+02	VST001764	USR0150	GYM001
2024-10-08	12:22:00+02	13:24:00+02	VST001765	USR0488	GYM006
2024-04-17	16:10:00+02	17:16:00+02	VST001766	USR0279	GYM001
2024-11-01	11:39:00+02	13:07:00+02	VST001767	USR0059	GYM001
2024-12-15	11:26:00+02	13:14:00+02	VST001768	USR0446	GYM004
2023-04-22	17:11:00+02	18:13:00+02	VST001769	USR0113	GYM002
2023-10-19	12:37:00+02	14:00:00+02	VST001770	USR0324	GYM003
2024-09-22	17:35:00+02	18:38:00+02	VST001771	USR0243	GYM005
2024-01-18	12:38:00+02	13:28:00+02	VST001772	USR0310	GYM003
2023-01-17	10:20:00+02	12:38:00+02	VST001773	USR0057	GYM002
2024-05-07	09:51:00+02	10:49:00+02	VST001774	USR0489	GYM001
2023-11-27	18:00:00+02	18:49:00+02	VST001775	USR0407	GYM004
2024-04-30	12:05:00+02	12:39:00+02	VST001776	USR0367	GYM002
2024-02-10	12:08:00+02	14:41:00+02	VST001777	USR0060	GYM006
2023-04-27	08:51:00+02	11:11:00+02	VST001778	USR0329	GYM006
2024-07-08	17:03:00+02	17:43:00+02	VST001779	USR0216	GYM002
2023-04-25	11:51:00+02	13:11:00+02	VST001780	USR0469	GYM005
2024-07-02	11:58:00+02	12:55:00+02	VST001781	USR0233	GYM003
2024-09-16	08:53:00+02	09:31:00+02	VST001782	USR0494	GYM003
2024-06-30	09:42:00+02	12:23:00+02	VST001783	USR0055	GYM005
2024-10-05	15:03:00+02	15:48:00+02	VST001784	USR0373	GYM004
2023-12-02	13:38:00+02	16:08:00+02	VST001785	USR0208	GYM001
2023-12-02	16:03:00+02	17:03:00+02	VST001786	USR0063	GYM001
2023-05-27	09:42:00+02	11:16:00+02	VST001787	USR0184	GYM006
2023-05-02	10:20:00+02	11:01:00+02	VST001788	USR0311	GYM004
2023-03-22	08:05:00+02	08:51:00+02	VST001789	USR0281	GYM005
2024-11-15	17:23:00+02	19:10:00+02	VST001790	USR0026	GYM002
2024-10-27	10:41:00+02	11:13:00+02	VST001791	USR0177	GYM003
2024-10-23	14:56:00+02	15:50:00+02	VST001792	USR0063	GYM002
2024-01-10	16:07:00+02	17:08:00+02	VST001793	USR0429	GYM003
2024-07-23	16:08:00+02	17:30:00+02	VST001794	USR0073	GYM002
2023-03-04	11:24:00+02	14:24:00+02	VST001795	USR0335	GYM005
2024-05-18	12:54:00+02	14:15:00+02	VST001796	USR0167	GYM005
2024-10-29	13:28:00+02	14:45:00+02	VST001797	USR0225	GYM004
2024-03-24	12:52:00+02	14:51:00+02	VST001798	USR0065	GYM002
2024-03-03	09:00:00+02	09:37:00+02	VST001799	USR0069	GYM002
2024-03-02	09:31:00+02	10:24:00+02	VST001800	USR0440	GYM004
2024-02-25	17:47:00+02	18:54:00+02	VST001801	USR0009	GYM004
2023-11-18	11:57:00+02	13:38:00+02	VST001802	USR0236	GYM005
2024-11-10	17:07:00+02	20:05:00+02	VST001803	USR0198	GYM005
2023-06-15	08:38:00+02	10:37:00+02	VST001804	USR0412	GYM006
2024-08-19	10:59:00+02	12:59:00+02	VST001805	USR0173	GYM002
2024-10-10	15:07:00+02	16:18:00+02	VST001806	USR0282	GYM005
2024-04-05	11:00:00+02	13:38:00+02	VST001807	USR0028	GYM005
2024-04-03	08:37:00+02	10:08:00+02	VST001808	USR0296	GYM002
2023-07-08	14:46:00+02	17:25:00+02	VST001809	USR0399	GYM004
2024-04-08	16:27:00+02	19:22:00+02	VST001810	USR0134	GYM002
2024-01-14	11:10:00+02	11:57:00+02	VST001811	USR0027	GYM001
2023-01-02	12:56:00+02	13:51:00+02	VST001812	USR0038	GYM002
2024-09-09	08:38:00+02	11:36:00+02	VST001813	USR0196	GYM001
2023-12-30	08:09:00+02	08:42:00+02	VST001814	USR0203	GYM002
2023-03-13	13:05:00+02	15:50:00+02	VST001815	USR0085	GYM001
2024-03-02	17:41:00+02	19:06:00+02	VST001816	USR0320	GYM001
2024-09-29	09:49:00+02	11:08:00+02	VST001817	USR0030	GYM002
2023-06-19	13:43:00+02	15:25:00+02	VST001818	USR0466	GYM006
2023-07-24	12:51:00+02	14:04:00+02	VST001819	USR0099	GYM005
2023-12-03	15:45:00+02	18:32:00+02	VST001820	USR0387	GYM003
2024-04-16	17:16:00+02	17:47:00+02	VST001821	USR0190	GYM005
2023-07-14	16:56:00+02	17:51:00+02	VST001822	USR0012	GYM001
2024-10-31	16:25:00+02	17:49:00+02	VST001823	USR0091	GYM002
2024-10-14	10:17:00+02	12:56:00+02	VST001824	USR0030	GYM002
2023-10-02	16:36:00+02	19:07:00+02	VST001825	USR0213	GYM002
2023-01-07	15:59:00+02	18:02:00+02	VST001826	USR0038	GYM002
2024-07-19	12:39:00+02	15:39:00+02	VST001827	USR0341	GYM006
2024-09-07	11:17:00+02	12:34:00+02	VST001828	USR0060	GYM003
2024-07-26	09:55:00+02	12:17:00+02	VST001829	USR0294	GYM004
2024-08-21	13:38:00+02	14:35:00+02	VST001830	USR0360	GYM001
2023-06-27	10:46:00+02	12:02:00+02	VST001831	USR0143	GYM003
2023-08-30	15:49:00+02	17:49:00+02	VST001832	USR0402	GYM005
2023-07-22	12:23:00+02	14:30:00+02	VST001833	USR0180	GYM004
2024-06-26	11:10:00+02	13:28:00+02	VST001834	USR0285	GYM004
2024-04-06	08:14:00+02	09:38:00+02	VST001835	USR0112	GYM002
2023-03-21	13:45:00+02	16:26:00+02	VST001836	USR0230	GYM003
2024-06-06	13:02:00+02	14:30:00+02	VST001837	USR0444	GYM005
2024-02-21	17:41:00+02	19:55:00+02	VST001838	USR0021	GYM002
2024-01-19	11:17:00+02	12:15:00+02	VST001839	USR0145	GYM002
2024-01-26	10:59:00+02	12:49:00+02	VST001840	USR0489	GYM006
2024-11-18	14:55:00+02	15:56:00+02	VST001841	USR0499	GYM001
2023-05-06	15:17:00+02	17:46:00+02	VST001842	USR0146	GYM004
2024-05-08	16:47:00+02	17:45:00+02	VST001843	USR0441	GYM005
2023-02-16	13:35:00+02	16:18:00+02	VST001844	USR0375	GYM004
2024-12-18	09:28:00+02	10:32:00+02	VST001845	USR0421	GYM003
2024-04-20	14:50:00+02	17:26:00+02	VST001846	USR0316	GYM001
2024-09-10	09:37:00+02	11:39:00+02	VST001847	USR0166	GYM002
2024-04-08	11:09:00+02	12:52:00+02	VST001848	USR0140	GYM001
2023-05-03	10:23:00+02	13:15:00+02	VST001849	USR0203	GYM002
2024-04-18	16:08:00+02	16:48:00+02	VST001850	USR0496	GYM001
2023-05-14	13:31:00+02	14:22:00+02	VST001851	USR0244	GYM002
2024-09-10	12:14:00+02	14:07:00+02	VST001852	USR0113	GYM004
2024-07-15	08:06:00+02	10:42:00+02	VST001853	USR0468	GYM004
2024-08-29	12:27:00+02	13:26:00+02	VST001854	USR0201	GYM004
2023-01-23	14:32:00+02	16:40:00+02	VST001855	USR0385	GYM004
2024-07-19	12:01:00+02	13:43:00+02	VST001856	USR0314	GYM001
2023-08-23	15:37:00+02	18:03:00+02	VST001857	USR0259	GYM002
2023-02-28	12:33:00+02	14:22:00+02	VST001858	USR0255	GYM004
2023-06-13	13:37:00+02	16:00:00+02	VST001859	USR0447	GYM001
2023-08-04	13:09:00+02	14:36:00+02	VST001860	USR0405	GYM002
2023-07-02	17:56:00+02	20:47:00+02	VST001861	USR0023	GYM001
2024-07-22	17:46:00+02	20:00:00+02	VST001862	USR0393	GYM006
2024-10-18	08:11:00+02	09:55:00+02	VST001863	USR0246	GYM004
2023-03-31	12:27:00+02	14:46:00+02	VST001864	USR0339	GYM003
2023-11-07	14:08:00+02	15:26:00+02	VST001865	USR0493	GYM001
2024-07-10	12:01:00+02	12:48:00+02	VST001866	USR0311	GYM004
2023-09-14	09:03:00+02	11:34:00+02	VST001867	USR0366	GYM005
2024-06-16	10:01:00+02	12:05:00+02	VST001868	USR0372	GYM002
2024-06-16	15:56:00+02	17:11:00+02	VST001869	USR0403	GYM006
2023-02-21	13:14:00+02	13:47:00+02	VST001870	USR0318	GYM004
2023-12-04	10:43:00+02	13:18:00+02	VST001871	USR0087	GYM005
2023-06-20	14:55:00+02	15:51:00+02	VST001872	USR0219	GYM001
2023-03-08	16:34:00+02	18:45:00+02	VST001873	USR0475	GYM001
2024-09-16	13:18:00+02	15:40:00+02	VST001874	USR0423	GYM005
2023-10-27	10:00:00+02	12:43:00+02	VST001875	USR0356	GYM006
2024-11-02	13:02:00+02	13:53:00+02	VST001876	USR0460	GYM005
2023-08-20	14:16:00+02	15:16:00+02	VST001877	USR0027	GYM002
2023-03-09	11:46:00+02	12:52:00+02	VST001878	USR0430	GYM001
2024-05-20	11:44:00+02	13:55:00+02	VST001879	USR0290	GYM005
2023-01-28	10:16:00+02	12:28:00+02	VST001880	USR0289	GYM003
2024-09-19	16:09:00+02	17:05:00+02	VST001881	USR0348	GYM003
2023-02-20	10:36:00+02	11:49:00+02	VST001882	USR0223	GYM005
2024-11-23	15:45:00+02	16:31:00+02	VST001883	USR0352	GYM002
2023-09-17	14:22:00+02	16:25:00+02	VST001884	USR0178	GYM001
2024-08-13	15:05:00+02	16:25:00+02	VST001885	USR0148	GYM003
2024-09-11	17:22:00+02	19:18:00+02	VST001886	USR0424	GYM005
2024-08-08	16:02:00+02	17:23:00+02	VST001887	USR0227	GYM005
2024-11-17	17:10:00+02	19:23:00+02	VST001888	USR0351	GYM004
2023-07-03	11:43:00+02	12:44:00+02	VST001889	USR0186	GYM005
2023-01-23	12:13:00+02	13:42:00+02	VST001890	USR0415	GYM002
2023-05-09	09:23:00+02	11:41:00+02	VST001891	USR0294	GYM003
2023-10-18	16:58:00+02	19:35:00+02	VST001892	USR0470	GYM004
2024-05-15	15:37:00+02	17:18:00+02	VST001893	USR0429	GYM003
2023-07-05	17:00:00+02	19:58:00+02	VST001894	USR0041	GYM003
2024-04-23	14:10:00+02	15:49:00+02	VST001895	USR0393	GYM002
2024-07-24	09:19:00+02	11:31:00+02	VST001896	USR0500	GYM005
2024-05-06	17:37:00+02	19:38:00+02	VST001897	USR0393	GYM002
2024-05-27	09:54:00+02	12:25:00+02	VST001898	USR0191	GYM005
2024-10-04	09:03:00+02	11:16:00+02	VST001899	USR0079	GYM004
2023-03-08	17:20:00+02	19:54:00+02	VST001900	USR0205	GYM002
2024-04-11	16:37:00+02	19:17:00+02	VST001901	USR0384	GYM002
2023-10-12	11:27:00+02	13:08:00+02	VST001902	USR0278	GYM006
2024-08-23	17:46:00+02	18:53:00+02	VST001903	USR0272	GYM001
2024-02-21	17:09:00+02	19:35:00+02	VST001904	USR0032	GYM002
2023-04-10	10:33:00+02	11:30:00+02	VST001905	USR0450	GYM006
2023-07-08	10:48:00+02	11:49:00+02	VST001906	USR0474	GYM001
2024-01-23	13:35:00+02	15:09:00+02	VST001907	USR0142	GYM005
2023-08-29	16:52:00+02	19:27:00+02	VST001908	USR0251	GYM005
2024-12-31	15:32:00+02	18:09:00+02	VST001909	USR0294	GYM005
2024-02-21	09:59:00+02	11:28:00+02	VST001910	USR0098	GYM006
2023-06-25	11:30:00+02	12:34:00+02	VST001911	USR0136	GYM006
2024-01-22	17:57:00+02	18:34:00+02	VST001912	USR0484	GYM001
2024-04-15	16:20:00+02	17:15:00+02	VST001913	USR0277	GYM005
2023-08-21	09:33:00+02	10:16:00+02	VST001914	USR0312	GYM003
2024-10-24	16:42:00+02	17:29:00+02	VST001915	USR0302	GYM002
2024-03-27	15:36:00+02	18:13:00+02	VST001916	USR0043	GYM006
2023-10-04	08:56:00+02	09:32:00+02	VST001917	USR0120	GYM006
2023-08-17	15:44:00+02	16:59:00+02	VST001918	USR0220	GYM006
2023-06-20	10:15:00+02	12:22:00+02	VST001919	USR0046	GYM001
2023-08-01	16:45:00+02	18:38:00+02	VST001920	USR0236	GYM005
2023-10-09	15:05:00+02	16:14:00+02	VST001921	USR0048	GYM003
2023-02-10	15:47:00+02	17:34:00+02	VST001922	USR0198	GYM002
2023-05-02	17:37:00+02	18:31:00+02	VST001923	USR0084	GYM002
2023-08-15	08:59:00+02	09:48:00+02	VST001924	USR0031	GYM005
2023-10-21	17:32:00+02	20:15:00+02	VST001925	USR0161	GYM003
2024-08-22	15:53:00+02	18:29:00+02	VST001926	USR0428	GYM001
2023-09-24	13:15:00+02	15:44:00+02	VST001927	USR0071	GYM006
2024-06-24	08:22:00+02	09:43:00+02	VST001928	USR0008	GYM006
2024-03-26	14:45:00+02	16:30:00+02	VST001929	USR0457	GYM005
2024-03-24	12:20:00+02	14:57:00+02	VST001930	USR0386	GYM002
2023-03-02	08:03:00+02	10:38:00+02	VST001931	USR0401	GYM006
2024-05-16	11:43:00+02	14:22:00+02	VST001932	USR0052	GYM002
2023-05-27	17:52:00+02	19:28:00+02	VST001933	USR0045	GYM002
2024-11-16	09:14:00+02	12:02:00+02	VST001934	USR0293	GYM005
2023-11-30	08:46:00+02	10:43:00+02	VST001935	USR0426	GYM004
2023-05-22	15:13:00+02	18:01:00+02	VST001936	USR0300	GYM004
2023-02-13	13:52:00+02	16:41:00+02	VST001937	USR0465	GYM004
2023-05-24	09:05:00+02	09:39:00+02	VST001938	USR0373	GYM003
2023-11-29	17:14:00+02	17:52:00+02	VST001939	USR0038	GYM005
2024-05-11	09:01:00+02	11:21:00+02	VST001940	USR0355	GYM002
2024-01-31	09:10:00+02	10:10:00+02	VST001941	USR0380	GYM006
2023-02-24	16:03:00+02	18:11:00+02	VST001942	USR0495	GYM003
2023-11-03	08:32:00+02	10:57:00+02	VST001943	USR0231	GYM004
2024-02-27	12:53:00+02	14:43:00+02	VST001944	USR0478	GYM001
2024-02-21	14:58:00+02	17:04:00+02	VST001945	USR0262	GYM003
2024-11-03	11:04:00+02	13:27:00+02	VST001946	USR0068	GYM003
2023-11-21	10:18:00+02	12:45:00+02	VST001947	USR0179	GYM005
2024-12-10	15:10:00+02	15:49:00+02	VST001948	USR0357	GYM006
2024-11-01	14:23:00+02	15:01:00+02	VST001949	USR0419	GYM003
2023-03-21	14:31:00+02	15:46:00+02	VST001950	USR0186	GYM006
2023-01-31	15:39:00+02	18:31:00+02	VST001951	USR0441	GYM005
2023-04-22	14:26:00+02	16:13:00+02	VST001952	USR0201	GYM001
2024-07-11	14:24:00+02	15:36:00+02	VST001953	USR0390	GYM002
2024-12-17	09:22:00+02	11:57:00+02	VST001954	USR0013	GYM002
2024-07-17	17:12:00+02	19:32:00+02	VST001955	USR0443	GYM004
2024-10-11	10:16:00+02	11:20:00+02	VST001956	USR0214	GYM004
2024-04-16	13:56:00+02	15:45:00+02	VST001957	USR0220	GYM001
2023-03-15	10:01:00+02	12:10:00+02	VST001958	USR0286	GYM002
2024-07-06	11:02:00+02	13:36:00+02	VST001959	USR0244	GYM004
2024-04-23	17:10:00+02	18:08:00+02	VST001960	USR0356	GYM006
2024-08-11	14:42:00+02	17:37:00+02	VST001961	USR0258	GYM003
2024-01-22	17:01:00+02	19:36:00+02	VST001962	USR0058	GYM005
2024-11-29	10:10:00+02	13:01:00+02	VST001963	USR0036	GYM004
2024-07-17	11:48:00+02	14:36:00+02	VST001964	USR0328	GYM001
2024-03-08	08:03:00+02	10:59:00+02	VST001965	USR0429	GYM002
2024-02-16	08:23:00+02	10:53:00+02	VST001966	USR0490	GYM001
2024-04-11	13:05:00+02	15:36:00+02	VST001967	USR0498	GYM005
2024-08-21	15:54:00+02	18:47:00+02	VST001968	USR0393	GYM005
2024-09-12	17:17:00+02	18:27:00+02	VST001969	USR0382	GYM001
2023-09-05	15:14:00+02	17:53:00+02	VST001970	USR0193	GYM004
2024-08-03	17:04:00+02	17:48:00+02	VST001971	USR0333	GYM004
2023-04-30	14:28:00+02	16:38:00+02	VST001972	USR0050	GYM002
2023-03-08	11:55:00+02	13:32:00+02	VST001973	USR0463	GYM006
2024-07-26	12:13:00+02	14:49:00+02	VST001974	USR0032	GYM002
2023-11-23	15:51:00+02	17:57:00+02	VST001975	USR0098	GYM003
2024-12-03	13:54:00+02	15:54:00+02	VST001976	USR0043	GYM006
2024-04-14	10:38:00+02	12:20:00+02	VST001977	USR0381	GYM003
2024-05-07	12:42:00+02	14:34:00+02	VST001978	USR0351	GYM002
2024-12-01	11:13:00+02	11:58:00+02	VST001979	USR0334	GYM006
2024-10-24	09:55:00+02	10:32:00+02	VST001980	USR0310	GYM006
2023-10-13	08:32:00+02	09:13:00+02	VST001981	USR0047	GYM003
2024-08-30	15:09:00+02	16:11:00+02	VST001982	USR0270	GYM001
2023-11-08	08:16:00+02	10:19:00+02	VST001983	USR0432	GYM004
2023-11-05	12:06:00+02	14:05:00+02	VST001984	USR0311	GYM006
2023-04-07	11:31:00+02	14:30:00+02	VST001985	USR0413	GYM006
2023-04-23	09:08:00+02	09:44:00+02	VST001986	USR0431	GYM003
2024-09-28	09:43:00+02	11:40:00+02	VST001987	USR0063	GYM006
2024-03-31	08:34:00+02	10:41:00+02	VST001988	USR0019	GYM003
2024-04-07	15:37:00+02	16:31:00+02	VST001989	USR0347	GYM001
2023-05-12	08:49:00+02	11:08:00+02	VST001990	USR0393	GYM006
2023-05-01	12:10:00+02	14:08:00+02	VST001991	USR0101	GYM005
2023-07-16	08:45:00+02	10:46:00+02	VST001992	USR0037	GYM002
2024-04-26	14:51:00+02	17:06:00+02	VST001993	USR0107	GYM001
2024-09-25	15:29:00+02	17:28:00+02	VST001994	USR0092	GYM005
2023-02-08	11:59:00+02	12:43:00+02	VST001995	USR0308	GYM001
2024-07-19	17:12:00+02	18:44:00+02	VST001996	USR0185	GYM004
2024-05-26	11:42:00+02	13:15:00+02	VST001997	USR0216	GYM001
2024-04-18	08:57:00+02	10:27:00+02	VST001998	USR0028	GYM001
2023-06-10	10:23:00+02	12:12:00+02	VST001999	USR0036	GYM004
2023-10-16	16:35:00+02	17:26:00+02	VST002000	USR0372	GYM006
2023-07-19	12:56:00+02	13:42:00+02	VST002001	USR0320	GYM002
2024-06-11	11:59:00+02	13:47:00+02	VST002002	USR0018	GYM005
2024-11-15	17:49:00+02	18:48:00+02	VST002003	USR0345	GYM003
2024-05-17	13:26:00+02	15:22:00+02	VST002004	USR0419	GYM002
2023-09-05	17:51:00+02	19:04:00+02	VST002005	USR0196	GYM001
2024-01-18	13:28:00+02	14:03:00+02	VST002006	USR0078	GYM003
2023-08-06	12:02:00+02	14:49:00+02	VST002007	USR0167	GYM004
2023-03-28	13:09:00+02	15:02:00+02	VST002008	USR0090	GYM002
2023-03-23	10:26:00+02	11:05:00+02	VST002009	USR0264	GYM006
2023-03-03	16:53:00+02	19:20:00+02	VST002010	USR0472	GYM005
2024-05-14	11:46:00+02	14:04:00+02	VST002011	USR0208	GYM002
2023-02-11	15:03:00+02	17:58:00+02	VST002012	USR0212	GYM002
2023-01-12	13:07:00+02	15:48:00+02	VST002013	USR0271	GYM006
2024-10-04	12:41:00+02	14:58:00+02	VST002014	USR0263	GYM003
2023-04-25	09:02:00+02	10:40:00+02	VST002015	USR0273	GYM004
2023-08-06	17:30:00+02	18:05:00+02	VST002016	USR0342	GYM006
2024-10-10	10:59:00+02	13:29:00+02	VST002017	USR0214	GYM004
2023-04-16	15:17:00+02	18:17:00+02	VST002018	USR0374	GYM006
2024-11-21	17:29:00+02	18:04:00+02	VST002019	USR0064	GYM002
2024-06-11	16:27:00+02	18:18:00+02	VST002020	USR0012	GYM004
2024-04-16	08:48:00+02	10:54:00+02	VST002021	USR0210	GYM003
2024-01-22	13:52:00+02	16:48:00+02	VST002022	USR0312	GYM003
2023-08-14	14:30:00+02	16:39:00+02	VST002023	USR0174	GYM005
2024-04-25	16:57:00+02	18:49:00+02	VST002024	USR0431	GYM004
2024-02-12	13:26:00+02	16:22:00+02	VST002025	USR0256	GYM005
2024-04-01	15:06:00+02	16:01:00+02	VST002026	USR0463	GYM006
2024-10-14	14:58:00+02	17:33:00+02	VST002027	USR0101	GYM001
2024-12-11	10:32:00+02	11:27:00+02	VST002028	USR0016	GYM003
2024-09-15	13:07:00+02	14:29:00+02	VST002029	USR0197	GYM002
2024-09-30	14:25:00+02	16:21:00+02	VST002030	USR0258	GYM003
2023-01-21	11:08:00+02	13:45:00+02	VST002031	USR0384	GYM001
2024-10-20	17:10:00+02	19:48:00+02	VST002032	USR0244	GYM002
2024-08-23	16:04:00+02	18:00:00+02	VST002033	USR0348	GYM004
2023-07-22	12:06:00+02	13:18:00+02	VST002034	USR0249	GYM004
2024-02-21	11:50:00+02	13:36:00+02	VST002035	USR0105	GYM003
2024-02-20	13:07:00+02	15:10:00+02	VST002036	USR0182	GYM002
2024-03-23	10:27:00+02	12:48:00+02	VST002037	USR0155	GYM006
2024-05-26	15:54:00+02	17:15:00+02	VST002038	USR0287	GYM002
2023-03-26	08:59:00+02	11:36:00+02	VST002039	USR0169	GYM005
2023-06-16	17:35:00+02	18:24:00+02	VST002040	USR0420	GYM001
2024-01-19	15:02:00+02	17:49:00+02	VST002041	USR0047	GYM004
2024-04-12	15:06:00+02	16:30:00+02	VST002042	USR0043	GYM003
2023-03-13	17:30:00+02	19:13:00+02	VST002043	USR0321	GYM002
2024-06-04	17:02:00+02	18:39:00+02	VST002044	USR0306	GYM004
2024-04-17	10:17:00+02	10:59:00+02	VST002045	USR0221	GYM003
2023-09-15	14:37:00+02	16:23:00+02	VST002046	USR0001	GYM004
2023-10-02	12:08:00+02	15:04:00+02	VST002047	USR0200	GYM003
2023-01-20	12:21:00+02	14:33:00+02	VST002048	USR0441	GYM004
2024-05-04	11:28:00+02	12:55:00+02	VST002049	USR0144	GYM006
2024-05-04	13:38:00+02	14:31:00+02	VST002050	USR0378	GYM005
2023-11-22	09:20:00+02	12:18:00+02	VST002051	USR0028	GYM001
2024-06-12	15:40:00+02	16:34:00+02	VST002052	USR0342	GYM004
2023-03-30	14:19:00+02	16:15:00+02	VST002053	USR0338	GYM001
2024-04-30	09:34:00+02	11:13:00+02	VST002054	USR0278	GYM004
2024-12-08	17:08:00+02	17:55:00+02	VST002055	USR0041	GYM002
2023-12-16	11:15:00+02	14:10:00+02	VST002056	USR0332	GYM005
2023-03-25	08:52:00+02	11:37:00+02	VST002057	USR0147	GYM006
2024-01-22	12:34:00+02	15:05:00+02	VST002058	USR0345	GYM005
2023-03-28	14:26:00+02	16:45:00+02	VST002059	USR0178	GYM001
2023-11-03	08:40:00+02	10:03:00+02	VST002060	USR0315	GYM002
2023-06-03	09:14:00+02	11:12:00+02	VST002061	USR0325	GYM003
2024-03-15	11:12:00+02	12:01:00+02	VST002062	USR0418	GYM005
2023-09-21	17:32:00+02	19:19:00+02	VST002063	USR0167	GYM006
2024-02-25	11:42:00+02	14:21:00+02	VST002064	USR0123	GYM002
2024-05-07	16:10:00+02	17:56:00+02	VST002065	USR0074	GYM002
2024-09-24	11:33:00+02	13:53:00+02	VST002066	USR0239	GYM001
2024-02-15	13:40:00+02	16:28:00+02	VST002067	USR0249	GYM006
2023-06-22	13:10:00+02	15:00:00+02	VST002068	USR0263	GYM002
2023-01-04	08:15:00+02	09:36:00+02	VST002069	USR0252	GYM002
2024-10-01	11:36:00+02	13:52:00+02	VST002070	USR0357	GYM003
2024-04-16	11:14:00+02	13:26:00+02	VST002071	USR0111	GYM001
2023-04-20	10:00:00+02	11:34:00+02	VST002072	USR0180	GYM001
2023-02-06	16:10:00+02	18:51:00+02	VST002073	USR0188	GYM006
2024-08-05	12:08:00+02	14:34:00+02	VST002074	USR0308	GYM002
2023-01-31	11:29:00+02	14:19:00+02	VST002075	USR0207	GYM003
2024-01-16	14:46:00+02	16:02:00+02	VST002076	USR0234	GYM004
2023-09-25	12:05:00+02	12:39:00+02	VST002077	USR0024	GYM005
2023-01-11	17:25:00+02	20:07:00+02	VST002078	USR0026	GYM001
2023-12-10	13:29:00+02	14:46:00+02	VST002079	USR0381	GYM003
2024-06-27	12:49:00+02	15:46:00+02	VST002080	USR0218	GYM006
2024-07-22	14:29:00+02	17:06:00+02	VST002081	USR0494	GYM003
2023-06-15	15:57:00+02	17:21:00+02	VST002082	USR0346	GYM002
2024-11-30	17:06:00+02	19:35:00+02	VST002083	USR0378	GYM005
2023-12-08	14:07:00+02	15:45:00+02	VST002084	USR0010	GYM001
2024-04-26	13:15:00+02	16:01:00+02	VST002085	USR0017	GYM004
2023-01-19	12:27:00+02	14:48:00+02	VST002086	USR0245	GYM002
2024-09-19	14:08:00+02	17:02:00+02	VST002087	USR0206	GYM001
2023-07-03	16:45:00+02	17:30:00+02	VST002088	USR0258	GYM006
2024-06-28	16:29:00+02	19:12:00+02	VST002089	USR0112	GYM001
2023-01-10	15:57:00+02	17:18:00+02	VST002090	USR0205	GYM003
2024-08-14	09:40:00+02	11:43:00+02	VST002091	USR0027	GYM005
2023-07-11	16:00:00+02	18:28:00+02	VST002092	USR0457	GYM004
2023-11-16	13:27:00+02	14:34:00+02	VST002093	USR0071	GYM005
2024-12-02	11:28:00+02	12:59:00+02	VST002094	USR0176	GYM003
2024-08-02	14:19:00+02	15:27:00+02	VST002095	USR0202	GYM004
2024-04-19	13:20:00+02	15:06:00+02	VST002096	USR0248	GYM004
2024-09-28	15:03:00+02	17:24:00+02	VST002097	USR0118	GYM002
2024-03-02	08:46:00+02	11:01:00+02	VST002098	USR0009	GYM004
2023-02-28	17:36:00+02	19:27:00+02	VST002099	USR0086	GYM001
2024-03-11	11:46:00+02	12:32:00+02	VST002100	USR0023	GYM005
2023-04-07	10:29:00+02	11:51:00+02	VST002101	USR0455	GYM006
2024-05-10	08:16:00+02	10:31:00+02	VST002102	USR0240	GYM006
2024-10-22	12:27:00+02	14:05:00+02	VST002103	USR0073	GYM005
2023-10-05	17:26:00+02	19:09:00+02	VST002104	USR0027	GYM002
2023-09-22	17:58:00+02	19:09:00+02	VST002105	USR0472	GYM004
2023-01-09	17:53:00+02	19:28:00+02	VST002106	USR0349	GYM003
2024-04-01	15:07:00+02	16:37:00+02	VST002107	USR0081	GYM001
2023-09-30	13:02:00+02	15:15:00+02	VST002108	USR0084	GYM002
2023-01-08	10:36:00+02	12:07:00+02	VST002109	USR0199	GYM004
2023-07-27	11:20:00+02	12:19:00+02	VST002110	USR0043	GYM006
2024-09-28	13:37:00+02	14:45:00+02	VST002111	USR0488	GYM003
2023-05-03	11:55:00+02	13:14:00+02	VST002112	USR0263	GYM004
2023-02-02	14:28:00+02	15:05:00+02	VST002113	USR0092	GYM002
2024-05-27	17:43:00+02	19:15:00+02	VST002114	USR0339	GYM003
2023-07-23	12:11:00+02	14:00:00+02	VST002115	USR0447	GYM003
2024-06-01	16:31:00+02	18:59:00+02	VST002116	USR0084	GYM003
2024-05-31	17:23:00+02	19:57:00+02	VST002117	USR0300	GYM003
2024-03-18	13:45:00+02	16:38:00+02	VST002118	USR0423	GYM004
2024-08-14	12:23:00+02	14:44:00+02	VST002119	USR0296	GYM003
2024-11-19	16:20:00+02	18:38:00+02	VST002120	USR0135	GYM004
2023-12-05	16:22:00+02	17:01:00+02	VST002121	USR0454	GYM003
2024-03-13	15:51:00+02	17:12:00+02	VST002122	USR0281	GYM003
2024-03-20	10:52:00+02	12:02:00+02	VST002123	USR0489	GYM002
2023-05-16	14:00:00+02	15:39:00+02	VST002124	USR0059	GYM004
2024-01-22	10:53:00+02	11:57:00+02	VST002125	USR0397	GYM006
2023-01-25	10:23:00+02	11:00:00+02	VST002126	USR0359	GYM004
2024-05-20	17:19:00+02	18:55:00+02	VST002127	USR0488	GYM005
2023-11-21	16:20:00+02	18:01:00+02	VST002128	USR0342	GYM006
2024-11-25	11:08:00+02	13:58:00+02	VST002129	USR0241	GYM002
2024-11-10	17:15:00+02	18:30:00+02	VST002130	USR0465	GYM004
2023-12-04	09:00:00+02	09:40:00+02	VST002131	USR0368	GYM002
2024-11-20	16:56:00+02	19:30:00+02	VST002132	USR0342	GYM006
2023-04-05	08:34:00+02	09:09:00+02	VST002133	USR0098	GYM002
2024-06-28	09:16:00+02	10:00:00+02	VST002134	USR0062	GYM002
2024-09-14	08:49:00+02	09:40:00+02	VST002135	USR0264	GYM001
2023-05-26	08:06:00+02	09:56:00+02	VST002136	USR0113	GYM004
2023-08-19	15:02:00+02	16:48:00+02	VST002137	USR0429	GYM002
2024-05-09	10:20:00+02	11:06:00+02	VST002138	USR0146	GYM001
2023-02-07	11:56:00+02	14:10:00+02	VST002139	USR0216	GYM001
2024-02-29	09:09:00+02	11:12:00+02	VST002140	USR0256	GYM003
2024-10-08	10:34:00+02	11:27:00+02	VST002141	USR0316	GYM003
2024-03-12	08:09:00+02	10:20:00+02	VST002142	USR0316	GYM006
2024-01-03	11:43:00+02	12:48:00+02	VST002143	USR0362	GYM004
2023-12-11	16:37:00+02	18:07:00+02	VST002144	USR0258	GYM003
2023-06-09	15:46:00+02	16:44:00+02	VST002145	USR0194	GYM006
2024-07-03	14:22:00+02	17:18:00+02	VST002146	USR0347	GYM004
2024-10-23	09:01:00+02	11:39:00+02	VST002147	USR0014	GYM006
2024-06-24	16:14:00+02	17:14:00+02	VST002148	USR0304	GYM001
2023-05-24	16:19:00+02	19:02:00+02	VST002149	USR0103	GYM001
2024-08-10	08:16:00+02	11:14:00+02	VST002150	USR0245	GYM004
2024-10-18	08:06:00+02	10:50:00+02	VST002151	USR0245	GYM006
2024-07-29	17:04:00+02	18:38:00+02	VST002152	USR0312	GYM006
2023-12-11	17:24:00+02	20:01:00+02	VST002153	USR0268	GYM003
2023-09-26	15:01:00+02	15:54:00+02	VST002154	USR0224	GYM003
2024-11-26	08:12:00+02	09:42:00+02	VST002155	USR0220	GYM004
2023-09-25	08:17:00+02	09:18:00+02	VST002156	USR0311	GYM005
2023-06-18	17:02:00+02	18:52:00+02	VST002157	USR0412	GYM003
2023-02-02	12:41:00+02	14:35:00+02	VST002158	USR0366	GYM002
2024-01-12	17:08:00+02	20:07:00+02	VST002159	USR0217	GYM003
2023-08-02	12:53:00+02	15:02:00+02	VST002160	USR0004	GYM005
2024-07-15	08:17:00+02	09:47:00+02	VST002161	USR0474	GYM006
2024-03-15	16:34:00+02	18:52:00+02	VST002162	USR0036	GYM001
2024-05-06	15:20:00+02	16:45:00+02	VST002163	USR0178	GYM001
2024-01-28	11:03:00+02	12:09:00+02	VST002164	USR0387	GYM006
2024-05-03	09:49:00+02	10:46:00+02	VST002165	USR0257	GYM001
2024-12-22	09:38:00+02	10:52:00+02	VST002166	USR0017	GYM003
2023-01-29	16:56:00+02	18:20:00+02	VST002167	USR0199	GYM001
2023-02-08	10:32:00+02	12:12:00+02	VST002168	USR0318	GYM005
2024-09-03	12:06:00+02	14:28:00+02	VST002169	USR0048	GYM005
2023-06-22	11:16:00+02	13:30:00+02	VST002170	USR0062	GYM003
2023-01-17	16:59:00+02	18:34:00+02	VST002171	USR0069	GYM006
2023-02-25	12:18:00+02	15:18:00+02	VST002172	USR0147	GYM002
2023-08-14	14:02:00+02	14:46:00+02	VST002173	USR0359	GYM003
2024-07-11	12:33:00+02	15:08:00+02	VST002174	USR0366	GYM001
2023-03-08	14:46:00+02	17:32:00+02	VST002175	USR0162	GYM003
2023-07-16	09:20:00+02	11:25:00+02	VST002176	USR0227	GYM005
2024-10-15	14:22:00+02	15:20:00+02	VST002177	USR0433	GYM003
2023-01-23	14:55:00+02	16:46:00+02	VST002178	USR0464	GYM003
2024-08-28	15:50:00+02	18:39:00+02	VST002179	USR0488	GYM002
2023-08-25	17:38:00+02	19:56:00+02	VST002180	USR0498	GYM005
2024-07-19	12:09:00+02	14:40:00+02	VST002181	USR0431	GYM004
2023-05-18	11:51:00+02	13:24:00+02	VST002182	USR0487	GYM004
2024-04-17	13:07:00+02	14:48:00+02	VST002183	USR0347	GYM005
2024-07-06	09:22:00+02	10:29:00+02	VST002184	USR0489	GYM004
2024-09-01	08:32:00+02	10:34:00+02	VST002185	USR0230	GYM001
2024-11-25	09:35:00+02	12:06:00+02	VST002186	USR0370	GYM004
2024-10-01	14:55:00+02	16:59:00+02	VST002187	USR0178	GYM001
2023-08-17	14:28:00+02	16:16:00+02	VST002188	USR0345	GYM005
2023-11-13	14:26:00+02	15:01:00+02	VST002189	USR0410	GYM004
2024-08-20	17:25:00+02	18:03:00+02	VST002190	USR0056	GYM004
2024-12-21	16:07:00+02	16:50:00+02	VST002191	USR0078	GYM006
2024-12-27	08:57:00+02	10:28:00+02	VST002192	USR0270	GYM001
2024-09-03	08:09:00+02	09:43:00+02	VST002193	USR0206	GYM001
2024-07-14	10:55:00+02	13:46:00+02	VST002194	USR0281	GYM003
2023-07-20	09:24:00+02	11:32:00+02	VST002195	USR0228	GYM002
2023-09-15	16:31:00+02	18:20:00+02	VST002196	USR0388	GYM004
2024-04-24	15:24:00+02	17:26:00+02	VST002197	USR0239	GYM006
2023-06-27	13:39:00+02	14:40:00+02	VST002198	USR0463	GYM002
2023-05-03	17:39:00+02	20:25:00+02	VST002199	USR0288	GYM006
2023-12-08	09:37:00+02	11:07:00+02	VST002200	USR0082	GYM002
2023-06-20	17:00:00+02	19:23:00+02	VST002201	USR0334	GYM004
2024-10-09	08:43:00+02	10:52:00+02	VST002202	USR0250	GYM006
2023-02-28	11:55:00+02	12:27:00+02	VST002203	USR0193	GYM001
2024-12-05	11:36:00+02	13:46:00+02	VST002204	USR0106	GYM003
2024-04-09	17:40:00+02	19:15:00+02	VST002205	USR0189	GYM006
2023-09-17	16:06:00+02	17:53:00+02	VST002206	USR0276	GYM005
2024-01-08	12:37:00+02	13:30:00+02	VST002207	USR0074	GYM004
2023-04-05	08:47:00+02	10:17:00+02	VST002208	USR0010	GYM004
2023-05-05	09:16:00+02	11:02:00+02	VST002209	USR0123	GYM005
2023-02-10	12:47:00+02	14:10:00+02	VST002210	USR0216	GYM002
2023-09-11	17:16:00+02	18:27:00+02	VST002211	USR0290	GYM003
2023-01-07	17:37:00+02	19:59:00+02	VST002212	USR0445	GYM002
2024-04-15	08:33:00+02	10:24:00+02	VST002213	USR0476	GYM005
2024-12-28	11:03:00+02	13:17:00+02	VST002214	USR0411	GYM005
2024-05-25	13:22:00+02	14:00:00+02	VST002215	USR0040	GYM003
2024-08-03	08:16:00+02	09:56:00+02	VST002216	USR0193	GYM005
2023-03-10	11:32:00+02	12:22:00+02	VST002217	USR0127	GYM005
2023-03-22	10:27:00+02	13:02:00+02	VST002218	USR0289	GYM006
2024-06-25	14:47:00+02	17:17:00+02	VST002219	USR0452	GYM003
2024-08-07	09:18:00+02	11:33:00+02	VST002220	USR0071	GYM004
2023-09-19	13:06:00+02	15:01:00+02	VST002221	USR0137	GYM002
2023-03-30	10:46:00+02	13:04:00+02	VST002222	USR0144	GYM004
2023-07-27	17:37:00+02	18:32:00+02	VST002223	USR0389	GYM004
2023-08-01	12:06:00+02	13:17:00+02	VST002224	USR0354	GYM006
2023-09-23	17:40:00+02	19:16:00+02	VST002225	USR0380	GYM002
2023-10-20	14:38:00+02	17:17:00+02	VST002226	USR0407	GYM004
2023-07-26	17:13:00+02	17:59:00+02	VST002227	USR0299	GYM003
2023-11-29	13:39:00+02	15:39:00+02	VST002228	USR0370	GYM002
2023-03-18	14:33:00+02	16:50:00+02	VST002229	USR0345	GYM001
2023-10-15	10:23:00+02	13:13:00+02	VST002230	USR0441	GYM006
2023-02-16	09:20:00+02	11:13:00+02	VST002231	USR0435	GYM004
2024-09-13	16:32:00+02	18:58:00+02	VST002232	USR0269	GYM005
2023-07-19	13:54:00+02	14:31:00+02	VST002233	USR0384	GYM002
2024-03-02	08:54:00+02	09:37:00+02	VST002234	USR0408	GYM001
2023-07-29	09:40:00+02	10:57:00+02	VST002235	USR0139	GYM005
2024-02-24	15:27:00+02	17:50:00+02	VST002236	USR0052	GYM001
2023-06-03	11:57:00+02	13:01:00+02	VST002237	USR0499	GYM004
2024-06-05	09:17:00+02	09:47:00+02	VST002238	USR0017	GYM005
2024-02-19	13:48:00+02	16:00:00+02	VST002239	USR0165	GYM004
2023-12-19	14:46:00+02	16:07:00+02	VST002240	USR0013	GYM005
2023-06-06	13:34:00+02	15:22:00+02	VST002241	USR0190	GYM002
2023-09-18	08:30:00+02	10:20:00+02	VST002242	USR0475	GYM003
2023-03-18	12:39:00+02	15:36:00+02	VST002243	USR0340	GYM003
2024-05-02	15:41:00+02	16:32:00+02	VST002244	USR0353	GYM001
2023-05-11	16:22:00+02	17:20:00+02	VST002245	USR0362	GYM006
2024-08-01	11:53:00+02	13:03:00+02	VST002246	USR0352	GYM005
2024-03-30	14:04:00+02	15:37:00+02	VST002247	USR0264	GYM004
2023-06-12	17:26:00+02	20:08:00+02	VST002248	USR0312	GYM006
2023-01-15	14:24:00+02	15:27:00+02	VST002249	USR0221	GYM002
2023-08-20	15:22:00+02	17:37:00+02	VST002250	USR0104	GYM002
2023-07-14	11:10:00+02	13:01:00+02	VST002251	USR0339	GYM002
2024-06-25	17:59:00+02	20:24:00+02	VST002252	USR0198	GYM003
2023-12-25	14:29:00+02	17:01:00+02	VST002253	USR0300	GYM004
2023-11-27	09:27:00+02	10:31:00+02	VST002254	USR0444	GYM002
2024-03-02	13:02:00+02	14:38:00+02	VST002255	USR0359	GYM002
2024-05-11	12:12:00+02	13:26:00+02	VST002256	USR0368	GYM001
2024-04-30	09:15:00+02	11:08:00+02	VST002257	USR0169	GYM005
2024-03-24	09:24:00+02	11:06:00+02	VST002258	USR0149	GYM005
2024-02-17	12:34:00+02	13:54:00+02	VST002259	USR0249	GYM005
2023-11-26	10:37:00+02	11:28:00+02	VST002260	USR0256	GYM006
2023-05-27	14:29:00+02	16:45:00+02	VST002261	USR0470	GYM001
2023-09-16	10:37:00+02	12:41:00+02	VST002262	USR0042	GYM003
2023-10-19	14:38:00+02	15:54:00+02	VST002263	USR0202	GYM006
2023-05-23	13:24:00+02	15:34:00+02	VST002264	USR0458	GYM001
2024-09-18	14:09:00+02	16:15:00+02	VST002265	USR0244	GYM002
2023-12-31	09:49:00+02	12:45:00+02	VST002266	USR0157	GYM004
2023-03-31	09:33:00+02	11:00:00+02	VST002267	USR0464	GYM006
2024-12-20	08:05:00+02	08:40:00+02	VST002268	USR0449	GYM006
2023-06-13	13:15:00+02	13:50:00+02	VST002269	USR0401	GYM002
2024-04-25	15:35:00+02	18:27:00+02	VST002270	USR0286	GYM002
2023-03-25	14:08:00+02	15:36:00+02	VST002271	USR0282	GYM004
2023-03-18	12:36:00+02	13:28:00+02	VST002272	USR0437	GYM005
2024-11-03	09:44:00+02	12:12:00+02	VST002273	USR0381	GYM006
2024-05-31	10:15:00+02	11:35:00+02	VST002274	USR0238	GYM001
2024-04-29	09:29:00+02	11:06:00+02	VST002275	USR0019	GYM003
2024-08-12	11:11:00+02	12:24:00+02	VST002276	USR0053	GYM002
2024-08-25	15:21:00+02	16:03:00+02	VST002277	USR0085	GYM002
2024-08-21	15:39:00+02	17:51:00+02	VST002278	USR0273	GYM003
2023-04-14	17:30:00+02	19:49:00+02	VST002279	USR0430	GYM001
2024-03-27	17:28:00+02	19:04:00+02	VST002280	USR0360	GYM002
2024-05-01	16:44:00+02	17:52:00+02	VST002281	USR0213	GYM003
2023-12-05	14:57:00+02	15:49:00+02	VST002282	USR0437	GYM002
2024-11-17	09:45:00+02	11:49:00+02	VST002283	USR0361	GYM005
2024-07-19	08:26:00+02	09:39:00+02	VST002284	USR0104	GYM005
2024-04-22	09:31:00+02	12:26:00+02	VST002285	USR0192	GYM002
2024-12-23	14:02:00+02	15:02:00+02	VST002286	USR0429	GYM002
2024-08-29	17:27:00+02	18:00:00+02	VST002287	USR0177	GYM005
2023-08-11	09:35:00+02	12:19:00+02	VST002288	USR0147	GYM002
2023-01-09	13:32:00+02	15:53:00+02	VST002289	USR0380	GYM001
2023-02-22	14:34:00+02	17:00:00+02	VST002290	USR0455	GYM001
2023-03-18	08:12:00+02	10:48:00+02	VST002291	USR0081	GYM004
2024-12-18	12:58:00+02	13:58:00+02	VST002292	USR0193	GYM001
2024-05-17	15:03:00+02	16:30:00+02	VST002293	USR0037	GYM006
2023-11-12	14:37:00+02	15:59:00+02	VST002294	USR0377	GYM006
2024-09-15	09:26:00+02	10:44:00+02	VST002295	USR0326	GYM006
2023-06-14	17:32:00+02	19:10:00+02	VST002296	USR0154	GYM002
2023-10-06	12:08:00+02	13:51:00+02	VST002297	USR0130	GYM002
2023-01-27	17:45:00+02	20:21:00+02	VST002298	USR0059	GYM003
2023-03-11	16:53:00+02	19:00:00+02	VST002299	USR0224	GYM006
2023-08-06	10:53:00+02	11:56:00+02	VST002300	USR0249	GYM006
2023-12-31	14:29:00+02	16:49:00+02	VST002301	USR0240	GYM001
2024-12-01	10:53:00+02	12:15:00+02	VST002302	USR0374	GYM005
2023-11-02	10:22:00+02	11:47:00+02	VST002303	USR0389	GYM005
2023-05-04	12:35:00+02	14:17:00+02	VST002304	USR0293	GYM004
2023-01-19	13:08:00+02	14:26:00+02	VST002305	USR0287	GYM003
2023-09-14	12:34:00+02	14:51:00+02	VST002306	USR0204	GYM005
2023-10-23	16:24:00+02	17:40:00+02	VST002307	USR0099	GYM004
2023-01-22	10:29:00+02	12:43:00+02	VST002308	USR0350	GYM001
2024-03-25	09:04:00+02	10:11:00+02	VST002309	USR0176	GYM003
2024-07-05	10:51:00+02	11:28:00+02	VST002310	USR0262	GYM003
2024-07-03	15:25:00+02	17:09:00+02	VST002311	USR0271	GYM006
2023-02-17	12:42:00+02	14:19:00+02	VST002312	USR0143	GYM002
2024-11-25	15:11:00+02	16:41:00+02	VST002313	USR0189	GYM006
2024-08-09	13:06:00+02	15:31:00+02	VST002314	USR0272	GYM001
2024-12-21	16:15:00+02	17:48:00+02	VST002315	USR0020	GYM006
2023-07-02	09:18:00+02	11:22:00+02	VST002316	USR0333	GYM003
2024-03-10	14:09:00+02	17:08:00+02	VST002317	USR0300	GYM006
2023-04-17	12:17:00+02	14:44:00+02	VST002318	USR0426	GYM004
2023-07-07	12:12:00+02	13:03:00+02	VST002319	USR0046	GYM006
2023-03-27	16:27:00+02	16:59:00+02	VST002320	USR0095	GYM005
2024-03-31	11:20:00+02	13:50:00+02	VST002321	USR0418	GYM001
2023-05-17	15:48:00+02	16:52:00+02	VST002322	USR0064	GYM001
2023-12-02	09:49:00+02	11:41:00+02	VST002323	USR0413	GYM003
2024-08-29	10:18:00+02	12:29:00+02	VST002324	USR0131	GYM006
2024-04-13	13:11:00+02	14:35:00+02	VST002325	USR0009	GYM003
2024-08-24	08:06:00+02	10:14:00+02	VST002326	USR0459	GYM003
2024-07-24	14:45:00+02	17:03:00+02	VST002327	USR0203	GYM004
2024-02-07	13:40:00+02	15:15:00+02	VST002328	USR0409	GYM002
2024-06-23	14:29:00+02	15:17:00+02	VST002329	USR0470	GYM003
2023-03-13	13:37:00+02	14:31:00+02	VST002330	USR0298	GYM002
2023-01-24	15:30:00+02	18:22:00+02	VST002331	USR0174	GYM002
2024-09-15	13:42:00+02	14:27:00+02	VST002332	USR0073	GYM001
2024-04-29	15:20:00+02	16:03:00+02	VST002333	USR0084	GYM005
2023-02-25	10:19:00+02	12:14:00+02	VST002334	USR0059	GYM005
2023-08-11	13:07:00+02	14:37:00+02	VST002335	USR0021	GYM006
2024-09-23	13:28:00+02	15:58:00+02	VST002336	USR0458	GYM004
2023-06-28	11:25:00+02	13:25:00+02	VST002337	USR0406	GYM004
2024-03-09	16:10:00+02	16:51:00+02	VST002338	USR0157	GYM005
2024-03-25	13:21:00+02	13:52:00+02	VST002339	USR0319	GYM006
2024-05-06	11:01:00+02	12:35:00+02	VST002340	USR0329	GYM005
2023-07-08	14:47:00+02	17:26:00+02	VST002341	USR0061	GYM006
2024-07-31	13:26:00+02	15:33:00+02	VST002342	USR0064	GYM006
2024-02-24	12:58:00+02	14:45:00+02	VST002343	USR0325	GYM006
2023-09-06	16:22:00+02	18:33:00+02	VST002344	USR0168	GYM006
2024-08-10	17:49:00+02	19:53:00+02	VST002345	USR0203	GYM001
2024-10-10	12:08:00+02	13:11:00+02	VST002346	USR0129	GYM001
2023-06-13	13:33:00+02	16:26:00+02	VST002347	USR0245	GYM005
2023-09-12	14:25:00+02	15:05:00+02	VST002348	USR0106	GYM006
2024-04-20	12:47:00+02	15:45:00+02	VST002349	USR0321	GYM003
2024-02-21	14:42:00+02	15:57:00+02	VST002350	USR0122	GYM006
2023-06-19	14:13:00+02	15:49:00+02	VST002351	USR0318	GYM003
2023-11-13	09:56:00+02	11:09:00+02	VST002352	USR0182	GYM001
2023-06-23	17:37:00+02	20:15:00+02	VST002353	USR0103	GYM006
2024-04-14	11:24:00+02	14:00:00+02	VST002354	USR0316	GYM002
2023-12-11	17:18:00+02	19:14:00+02	VST002355	USR0302	GYM005
2024-03-20	11:04:00+02	13:33:00+02	VST002356	USR0261	GYM006
2023-01-18	17:23:00+02	18:26:00+02	VST002357	USR0113	GYM004
2023-03-11	08:27:00+02	09:19:00+02	VST002358	USR0406	GYM003
2023-12-04	15:52:00+02	17:43:00+02	VST002359	USR0474	GYM006
2024-09-19	11:34:00+02	14:19:00+02	VST002360	USR0437	GYM002
2024-08-14	15:28:00+02	17:48:00+02	VST002361	USR0070	GYM003
2024-06-10	12:58:00+02	14:04:00+02	VST002362	USR0160	GYM002
2024-11-18	09:10:00+02	10:46:00+02	VST002363	USR0240	GYM005
2024-03-31	14:58:00+02	15:57:00+02	VST002364	USR0011	GYM005
2023-09-26	16:31:00+02	18:21:00+02	VST002365	USR0138	GYM005
2024-09-22	10:22:00+02	11:03:00+02	VST002366	USR0495	GYM001
2023-07-07	13:10:00+02	14:12:00+02	VST002367	USR0167	GYM002
2024-07-22	12:07:00+02	14:44:00+02	VST002368	USR0247	GYM006
2024-12-11	12:18:00+02	13:59:00+02	VST002369	USR0354	GYM004
2024-06-12	10:37:00+02	12:39:00+02	VST002370	USR0031	GYM004
2024-03-09	15:13:00+02	17:33:00+02	VST002371	USR0012	GYM005
2023-10-15	14:26:00+02	16:08:00+02	VST002372	USR0243	GYM004
2024-07-20	09:15:00+02	10:52:00+02	VST002373	USR0108	GYM003
2024-05-13	15:39:00+02	17:16:00+02	VST002374	USR0336	GYM002
2024-03-16	16:10:00+02	18:52:00+02	VST002375	USR0422	GYM002
2023-10-30	17:56:00+02	19:46:00+02	VST002376	USR0323	GYM002
2023-03-28	14:50:00+02	17:11:00+02	VST002377	USR0194	GYM003
2024-03-13	17:07:00+02	18:19:00+02	VST002378	USR0308	GYM006
2024-06-24	16:38:00+02	18:28:00+02	VST002379	USR0133	GYM001
2023-01-22	15:08:00+02	17:43:00+02	VST002380	USR0395	GYM003
2024-07-13	17:16:00+02	18:24:00+02	VST002381	USR0281	GYM002
2024-05-31	08:37:00+02	11:29:00+02	VST002382	USR0291	GYM002
2024-11-05	14:08:00+02	16:30:00+02	VST002383	USR0163	GYM002
2024-05-17	17:09:00+02	17:52:00+02	VST002384	USR0278	GYM006
2024-12-14	09:27:00+02	10:45:00+02	VST002385	USR0421	GYM004
2024-04-11	09:51:00+02	10:59:00+02	VST002386	USR0470	GYM001
2023-04-11	12:14:00+02	12:57:00+02	VST002387	USR0439	GYM003
2024-08-05	14:03:00+02	15:31:00+02	VST002388	USR0203	GYM002
2024-11-05	10:50:00+02	12:06:00+02	VST002389	USR0096	GYM005
2024-11-15	08:45:00+02	09:24:00+02	VST002390	USR0483	GYM001
2023-05-21	17:36:00+02	20:06:00+02	VST002391	USR0223	GYM005
2023-05-18	14:49:00+02	16:25:00+02	VST002392	USR0237	GYM001
2024-07-31	13:39:00+02	14:50:00+02	VST002393	USR0117	GYM002
2024-12-10	15:20:00+02	17:49:00+02	VST002394	USR0456	GYM001
2023-08-16	09:48:00+02	12:09:00+02	VST002395	USR0192	GYM001
2023-10-08	08:10:00+02	09:09:00+02	VST002396	USR0276	GYM002
2024-11-14	09:40:00+02	12:16:00+02	VST002397	USR0106	GYM006
2024-03-06	12:24:00+02	13:04:00+02	VST002398	USR0482	GYM005
2023-02-09	11:47:00+02	14:10:00+02	VST002399	USR0004	GYM006
2024-06-02	16:42:00+02	18:43:00+02	VST002400	USR0018	GYM005
2024-11-16	16:51:00+02	19:44:00+02	VST002401	USR0307	GYM004
2024-10-24	17:31:00+02	20:05:00+02	VST002402	USR0452	GYM005
2023-07-30	17:54:00+02	20:21:00+02	VST002403	USR0020	GYM005
2023-10-29	17:49:00+02	20:25:00+02	VST002404	USR0122	GYM001
2023-03-27	11:46:00+02	12:44:00+02	VST002405	USR0137	GYM004
2024-02-01	15:36:00+02	16:43:00+02	VST002406	USR0080	GYM002
2023-09-10	14:23:00+02	15:24:00+02	VST002407	USR0154	GYM002
2024-06-16	14:40:00+02	16:39:00+02	VST002408	USR0358	GYM003
2024-01-16	15:54:00+02	16:47:00+02	VST002409	USR0025	GYM004
2024-03-19	16:32:00+02	17:54:00+02	VST002410	USR0452	GYM001
2023-02-02	10:34:00+02	12:16:00+02	VST002411	USR0169	GYM003
2023-09-17	13:53:00+02	15:09:00+02	VST002412	USR0059	GYM003
2023-08-22	08:25:00+02	09:38:00+02	VST002413	USR0301	GYM002
2024-05-29	16:14:00+02	18:54:00+02	VST002414	USR0041	GYM005
2023-11-04	09:47:00+02	11:26:00+02	VST002415	USR0038	GYM001
2023-03-11	13:02:00+02	15:56:00+02	VST002416	USR0117	GYM004
2024-03-29	15:05:00+02	18:04:00+02	VST002417	USR0275	GYM003
2024-03-14	09:27:00+02	10:51:00+02	VST002418	USR0270	GYM001
2023-12-30	09:58:00+02	12:57:00+02	VST002419	USR0127	GYM002
2024-04-25	10:25:00+02	10:56:00+02	VST002420	USR0405	GYM003
2023-05-24	13:56:00+02	16:40:00+02	VST002421	USR0399	GYM003
2023-01-24	13:19:00+02	16:15:00+02	VST002422	USR0003	GYM006
2024-02-29	13:51:00+02	15:07:00+02	VST002423	USR0293	GYM002
2023-06-24	15:46:00+02	18:02:00+02	VST002424	USR0373	GYM006
2023-11-21	11:31:00+02	12:20:00+02	VST002425	USR0498	GYM002
2024-11-01	16:53:00+02	18:26:00+02	VST002426	USR0430	GYM002
2023-12-14	16:14:00+02	18:51:00+02	VST002427	USR0016	GYM006
2023-01-18	13:56:00+02	14:50:00+02	VST002428	USR0398	GYM001
2023-02-13	16:07:00+02	18:01:00+02	VST002429	USR0265	GYM001
2023-06-04	09:39:00+02	10:15:00+02	VST002430	USR0239	GYM001
2024-01-12	15:28:00+02	17:10:00+02	VST002431	USR0263	GYM005
2024-02-06	15:43:00+02	16:44:00+02	VST002432	USR0398	GYM003
2023-08-13	13:26:00+02	15:36:00+02	VST002433	USR0134	GYM001
2023-08-05	09:08:00+02	11:13:00+02	VST002434	USR0213	GYM005
2024-07-21	13:07:00+02	14:04:00+02	VST002435	USR0015	GYM003
2023-01-31	08:45:00+02	10:37:00+02	VST002436	USR0436	GYM001
2023-02-28	09:57:00+02	11:06:00+02	VST002437	USR0328	GYM002
2023-12-19	08:23:00+02	09:00:00+02	VST002438	USR0418	GYM004
2024-03-20	13:51:00+02	14:41:00+02	VST002439	USR0360	GYM001
2023-08-23	09:51:00+02	12:18:00+02	VST002440	USR0129	GYM004
2023-04-17	10:48:00+02	13:20:00+02	VST002441	USR0352	GYM001
2023-07-10	12:09:00+02	14:35:00+02	VST002442	USR0122	GYM002
2024-06-13	16:48:00+02	18:26:00+02	VST002443	USR0241	GYM004
2024-11-09	10:58:00+02	11:29:00+02	VST002444	USR0115	GYM005
2024-08-05	17:25:00+02	19:19:00+02	VST002445	USR0197	GYM002
2024-07-19	10:43:00+02	11:24:00+02	VST002446	USR0222	GYM004
2023-09-02	13:38:00+02	16:03:00+02	VST002447	USR0214	GYM004
2023-03-17	17:33:00+02	19:26:00+02	VST002448	USR0404	GYM006
2024-06-30	15:16:00+02	18:11:00+02	VST002449	USR0080	GYM006
2023-09-24	15:53:00+02	16:56:00+02	VST002450	USR0263	GYM002
2023-11-13	11:57:00+02	13:21:00+02	VST002451	USR0135	GYM002
2023-05-01	14:54:00+02	15:36:00+02	VST002452	USR0306	GYM002
2023-01-25	11:08:00+02	12:50:00+02	VST002453	USR0242	GYM003
2024-03-07	11:10:00+02	13:02:00+02	VST002454	USR0386	GYM005
2023-06-09	15:22:00+02	16:06:00+02	VST002455	USR0303	GYM001
2024-08-18	14:45:00+02	15:33:00+02	VST002456	USR0270	GYM006
2023-04-24	08:29:00+02	11:19:00+02	VST002457	USR0287	GYM004
2024-05-16	11:22:00+02	13:29:00+02	VST002458	USR0050	GYM006
2023-06-15	15:40:00+02	16:33:00+02	VST002459	USR0189	GYM001
2024-12-03	15:19:00+02	17:31:00+02	VST002460	USR0297	GYM002
2023-06-24	14:38:00+02	16:13:00+02	VST002461	USR0014	GYM006
2023-01-01	08:04:00+02	09:19:00+02	VST002462	USR0389	GYM005
2023-03-27	11:39:00+02	13:10:00+02	VST002463	USR0459	GYM005
2024-07-27	11:30:00+02	13:42:00+02	VST002464	USR0232	GYM003
2023-11-16	12:45:00+02	13:37:00+02	VST002465	USR0261	GYM006
2024-02-05	09:04:00+02	09:39:00+02	VST002466	USR0192	GYM002
2024-01-17	17:51:00+02	19:14:00+02	VST002467	USR0413	GYM004
2024-12-18	09:44:00+02	10:55:00+02	VST002468	USR0203	GYM003
2024-09-08	17:09:00+02	19:18:00+02	VST002469	USR0261	GYM002
2023-11-14	11:11:00+02	13:24:00+02	VST002470	USR0113	GYM003
2023-09-07	14:14:00+02	15:56:00+02	VST002471	USR0374	GYM006
2024-06-08	13:33:00+02	14:42:00+02	VST002472	USR0352	GYM001
2024-11-05	11:21:00+02	12:21:00+02	VST002473	USR0036	GYM006
2024-07-08	15:48:00+02	17:34:00+02	VST002474	USR0079	GYM002
2024-09-14	09:56:00+02	12:31:00+02	VST002475	USR0275	GYM004
2024-12-17	12:28:00+02	14:48:00+02	VST002476	USR0448	GYM004
2023-09-13	16:21:00+02	18:10:00+02	VST002477	USR0278	GYM002
2023-11-03	17:00:00+02	18:03:00+02	VST002478	USR0162	GYM003
2023-05-24	13:20:00+02	15:21:00+02	VST002479	USR0312	GYM005
2024-10-19	14:37:00+02	15:31:00+02	VST002480	USR0017	GYM002
2024-01-26	14:41:00+02	16:45:00+02	VST002481	USR0204	GYM006
2024-11-06	09:56:00+02	12:37:00+02	VST002482	USR0473	GYM004
2023-06-18	13:56:00+02	15:17:00+02	VST002483	USR0440	GYM001
2023-10-25	14:00:00+02	16:35:00+02	VST002484	USR0017	GYM004
2023-08-21	15:48:00+02	18:12:00+02	VST002485	USR0202	GYM005
2023-09-28	10:56:00+02	13:05:00+02	VST002486	USR0476	GYM004
2023-03-01	13:04:00+02	15:35:00+02	VST002487	USR0210	GYM005
2023-10-23	09:26:00+02	11:04:00+02	VST002488	USR0499	GYM002
2024-04-11	10:17:00+02	13:11:00+02	VST002489	USR0402	GYM004
2023-08-23	13:20:00+02	15:38:00+02	VST002490	USR0429	GYM003
2024-11-07	10:00:00+02	10:53:00+02	VST002491	USR0480	GYM006
2024-12-06	12:04:00+02	14:22:00+02	VST002492	USR0078	GYM003
2023-08-22	13:12:00+02	15:16:00+02	VST002493	USR0056	GYM006
2024-01-03	09:59:00+02	11:16:00+02	VST002494	USR0080	GYM004
2024-11-25	11:07:00+02	13:28:00+02	VST002495	USR0306	GYM004
2023-08-20	14:22:00+02	16:41:00+02	VST002496	USR0058	GYM006
2024-05-05	10:24:00+02	11:17:00+02	VST002497	USR0018	GYM001
2024-09-10	16:43:00+02	17:23:00+02	VST002498	USR0208	GYM004
2024-05-17	14:37:00+02	17:18:00+02	VST002499	USR0465	GYM001
2024-08-14	15:08:00+02	17:05:00+02	VST002500	USR0135	GYM001
2024-01-16	10:21:00+02	12:49:00+02	VST002501	USR0332	GYM006
2024-11-26	17:48:00+02	19:15:00+02	VST002502	USR0482	GYM001
2024-03-03	14:32:00+02	15:41:00+02	VST002503	USR0010	GYM001
2024-11-27	15:13:00+02	17:49:00+02	VST002504	USR0069	GYM002
2024-10-07	11:10:00+02	13:54:00+02	VST002505	USR0341	GYM003
2023-12-30	16:18:00+02	19:02:00+02	VST002506	USR0387	GYM001
2023-07-21	17:10:00+02	18:01:00+02	VST002507	USR0083	GYM003
2023-05-26	10:57:00+02	12:41:00+02	VST002508	USR0109	GYM001
2024-09-30	17:28:00+02	19:57:00+02	VST002509	USR0044	GYM003
2024-04-01	10:50:00+02	13:11:00+02	VST002510	USR0483	GYM004
2023-05-15	16:21:00+02	17:11:00+02	VST002511	USR0454	GYM004
2024-09-17	12:55:00+02	15:27:00+02	VST002512	USR0398	GYM003
2023-09-21	10:23:00+02	12:09:00+02	VST002513	USR0132	GYM001
2023-03-05	11:11:00+02	12:19:00+02	VST002514	USR0493	GYM002
2024-05-05	13:22:00+02	14:24:00+02	VST002515	USR0499	GYM003
2024-10-08	15:41:00+02	17:27:00+02	VST002516	USR0018	GYM005
2023-02-10	08:54:00+02	10:27:00+02	VST002517	USR0093	GYM002
2023-10-23	14:07:00+02	16:50:00+02	VST002518	USR0483	GYM005
2023-01-03	08:09:00+02	10:28:00+02	VST002519	USR0436	GYM003
2024-12-06	16:16:00+02	18:01:00+02	VST002520	USR0294	GYM001
2023-04-20	10:19:00+02	13:14:00+02	VST002521	USR0464	GYM005
2023-08-09	11:19:00+02	12:01:00+02	VST002522	USR0148	GYM003
2024-01-05	14:33:00+02	17:24:00+02	VST002523	USR0472	GYM002
2024-01-03	17:35:00+02	18:24:00+02	VST002524	USR0483	GYM001
2024-03-11	16:37:00+02	17:18:00+02	VST002525	USR0172	GYM005
2023-01-04	16:26:00+02	19:07:00+02	VST002526	USR0051	GYM003
2023-09-01	14:58:00+02	15:55:00+02	VST002527	USR0019	GYM001
2023-06-15	16:23:00+02	19:03:00+02	VST002528	USR0120	GYM001
2023-01-26	15:05:00+02	17:23:00+02	VST002529	USR0324	GYM004
2024-01-30	15:34:00+02	17:49:00+02	VST002530	USR0225	GYM001
2024-04-18	16:20:00+02	17:14:00+02	VST002531	USR0066	GYM003
2023-01-17	10:51:00+02	13:19:00+02	VST002532	USR0141	GYM002
2024-12-28	09:24:00+02	12:19:00+02	VST002533	USR0446	GYM006
2023-04-02	17:38:00+02	19:12:00+02	VST002534	USR0189	GYM004
2024-04-27	08:31:00+02	10:31:00+02	VST002535	USR0493	GYM003
2024-06-26	11:45:00+02	13:20:00+02	VST002536	USR0158	GYM003
2023-07-24	12:59:00+02	15:58:00+02	VST002537	USR0098	GYM003
2024-05-16	08:33:00+02	09:23:00+02	VST002538	USR0158	GYM005
2024-02-04	12:41:00+02	15:19:00+02	VST002539	USR0435	GYM005
2023-07-26	11:50:00+02	12:24:00+02	VST002540	USR0246	GYM002
2024-09-10	17:10:00+02	18:09:00+02	VST002541	USR0344	GYM003
2023-05-26	12:55:00+02	15:23:00+02	VST002542	USR0432	GYM005
2023-04-11	10:52:00+02	12:07:00+02	VST002543	USR0236	GYM005
2023-08-29	15:48:00+02	17:04:00+02	VST002544	USR0033	GYM005
2023-06-12	17:39:00+02	19:49:00+02	VST002545	USR0361	GYM002
2023-06-22	16:27:00+02	17:08:00+02	VST002546	USR0241	GYM002
2024-05-16	17:22:00+02	18:13:00+02	VST002547	USR0330	GYM003
2024-06-30	16:43:00+02	18:59:00+02	VST002548	USR0338	GYM004
2023-10-11	09:55:00+02	11:41:00+02	VST002549	USR0275	GYM003
2023-12-25	17:46:00+02	19:36:00+02	VST002550	USR0071	GYM005
2024-01-16	09:56:00+02	12:56:00+02	VST002551	USR0313	GYM006
2024-06-16	12:34:00+02	15:00:00+02	VST002552	USR0403	GYM005
2023-06-12	17:16:00+02	19:41:00+02	VST002553	USR0216	GYM001
2024-08-31	14:15:00+02	15:52:00+02	VST002554	USR0079	GYM006
2023-11-03	17:15:00+02	19:12:00+02	VST002555	USR0169	GYM006
2023-12-05	08:42:00+02	09:59:00+02	VST002556	USR0298	GYM003
2023-02-24	15:31:00+02	16:55:00+02	VST002557	USR0471	GYM005
2023-11-29	17:19:00+02	18:36:00+02	VST002558	USR0180	GYM005
2023-05-07	11:43:00+02	12:33:00+02	VST002559	USR0116	GYM004
2024-12-05	15:15:00+02	16:51:00+02	VST002560	USR0260	GYM001
2023-08-31	09:44:00+02	10:41:00+02	VST002561	USR0486	GYM003
2024-08-22	12:13:00+02	14:34:00+02	VST002562	USR0260	GYM002
2024-02-13	13:04:00+02	15:50:00+02	VST002563	USR0005	GYM003
2024-05-17	08:33:00+02	09:07:00+02	VST002564	USR0297	GYM006
2024-12-27	15:40:00+02	16:11:00+02	VST002565	USR0108	GYM003
2024-08-26	12:29:00+02	14:40:00+02	VST002566	USR0343	GYM004
2023-10-30	13:56:00+02	14:55:00+02	VST002567	USR0360	GYM003
2024-04-08	09:29:00+02	10:02:00+02	VST002568	USR0117	GYM004
2023-08-23	15:29:00+02	16:42:00+02	VST002569	USR0357	GYM006
2024-11-26	10:00:00+02	12:32:00+02	VST002570	USR0445	GYM004
2023-02-07	12:02:00+02	14:29:00+02	VST002571	USR0331	GYM005
2023-05-19	11:34:00+02	13:47:00+02	VST002572	USR0439	GYM002
2023-07-14	13:59:00+02	16:33:00+02	VST002573	USR0331	GYM006
2024-06-10	15:18:00+02	17:05:00+02	VST002574	USR0013	GYM004
2024-10-08	10:49:00+02	12:51:00+02	VST002575	USR0142	GYM001
2023-01-01	10:22:00+02	12:33:00+02	VST002576	USR0188	GYM006
2024-07-14	11:31:00+02	13:18:00+02	VST002577	USR0456	GYM001
2023-04-06	11:31:00+02	12:23:00+02	VST002578	USR0281	GYM002
2024-12-13	09:00:00+02	10:02:00+02	VST002579	USR0466	GYM004
2024-02-17	17:43:00+02	18:47:00+02	VST002580	USR0115	GYM006
2024-06-21	13:59:00+02	14:32:00+02	VST002581	USR0428	GYM006
2024-03-04	17:05:00+02	18:23:00+02	VST002582	USR0236	GYM002
2023-08-23	12:47:00+02	13:45:00+02	VST002583	USR0338	GYM005
2023-12-15	17:11:00+02	17:45:00+02	VST002584	USR0010	GYM001
2024-04-25	10:52:00+02	12:10:00+02	VST002585	USR0199	GYM006
2024-01-31	13:31:00+02	14:07:00+02	VST002586	USR0252	GYM003
2023-12-17	12:59:00+02	14:22:00+02	VST002587	USR0050	GYM001
2024-02-20	12:56:00+02	15:29:00+02	VST002588	USR0428	GYM004
2023-02-20	17:46:00+02	18:53:00+02	VST002589	USR0142	GYM002
2023-03-22	12:33:00+02	14:04:00+02	VST002590	USR0271	GYM001
2023-02-05	16:46:00+02	19:07:00+02	VST002591	USR0016	GYM003
2023-03-08	09:37:00+02	12:24:00+02	VST002592	USR0002	GYM003
2024-10-02	10:18:00+02	11:36:00+02	VST002593	USR0158	GYM002
2024-10-28	15:01:00+02	15:53:00+02	VST002594	USR0030	GYM002
2024-09-14	09:00:00+02	10:47:00+02	VST002595	USR0082	GYM001
2024-11-10	12:43:00+02	15:11:00+02	VST002596	USR0031	GYM004
2024-04-25	10:09:00+02	11:16:00+02	VST002597	USR0236	GYM005
2024-04-12	10:15:00+02	12:46:00+02	VST002598	USR0496	GYM003
2023-05-22	12:15:00+02	14:33:00+02	VST002599	USR0333	GYM002
2023-12-22	10:29:00+02	11:04:00+02	VST002600	USR0148	GYM005
2024-12-09	13:29:00+02	14:28:00+02	VST002601	USR0177	GYM005
2024-04-15	12:13:00+02	13:25:00+02	VST002602	USR0370	GYM005
2024-09-12	14:42:00+02	15:51:00+02	VST002603	USR0035	GYM004
2024-08-13	16:21:00+02	18:44:00+02	VST002604	USR0023	GYM002
2024-11-03	10:25:00+02	12:59:00+02	VST002605	USR0106	GYM003
2024-03-14	17:51:00+02	20:21:00+02	VST002606	USR0097	GYM002
2024-06-14	12:35:00+02	13:10:00+02	VST002607	USR0230	GYM001
2023-05-07	15:04:00+02	17:29:00+02	VST002608	USR0227	GYM003
2023-07-24	14:24:00+02	17:23:00+02	VST002609	USR0371	GYM002
2023-01-29	15:42:00+02	17:14:00+02	VST002610	USR0100	GYM003
2024-03-20	09:17:00+02	10:38:00+02	VST002611	USR0445	GYM001
2024-12-19	09:35:00+02	11:20:00+02	VST002612	USR0468	GYM006
2024-04-08	14:52:00+02	17:47:00+02	VST002613	USR0055	GYM003
2023-10-07	16:47:00+02	18:57:00+02	VST002614	USR0195	GYM006
2023-05-31	12:44:00+02	13:27:00+02	VST002615	USR0008	GYM005
2023-08-28	14:17:00+02	16:12:00+02	VST002616	USR0424	GYM004
2023-09-23	15:45:00+02	16:17:00+02	VST002617	USR0315	GYM001
2024-11-24	16:19:00+02	17:15:00+02	VST002618	USR0128	GYM003
2023-04-15	13:35:00+02	15:55:00+02	VST002619	USR0032	GYM001
2024-03-08	17:55:00+02	20:11:00+02	VST002620	USR0093	GYM005
2024-05-11	08:02:00+02	10:38:00+02	VST002621	USR0007	GYM006
2024-03-15	09:35:00+02	12:33:00+02	VST002622	USR0258	GYM004
2024-11-15	15:49:00+02	18:40:00+02	VST002623	USR0341	GYM001
2023-06-07	14:06:00+02	15:50:00+02	VST002624	USR0390	GYM006
2023-06-21	09:04:00+02	09:43:00+02	VST002625	USR0220	GYM005
2024-05-08	17:07:00+02	19:41:00+02	VST002626	USR0240	GYM005
2023-11-07	14:47:00+02	16:59:00+02	VST002627	USR0106	GYM005
2024-02-07	11:43:00+02	14:17:00+02	VST002628	USR0036	GYM006
2024-10-30	15:19:00+02	18:00:00+02	VST002629	USR0416	GYM003
2024-11-06	11:36:00+02	14:10:00+02	VST002630	USR0045	GYM002
2024-10-20	16:26:00+02	17:55:00+02	VST002631	USR0298	GYM001
2024-10-27	12:34:00+02	13:19:00+02	VST002632	USR0309	GYM002
2024-04-07	13:30:00+02	16:15:00+02	VST002633	USR0366	GYM005
2024-01-02	12:50:00+02	13:24:00+02	VST002634	USR0009	GYM002
2024-07-03	13:45:00+02	16:03:00+02	VST002635	USR0459	GYM006
2024-10-04	17:20:00+02	20:17:00+02	VST002636	USR0087	GYM005
2023-09-12	17:51:00+02	19:41:00+02	VST002637	USR0370	GYM005
2023-07-27	10:13:00+02	13:04:00+02	VST002638	USR0331	GYM004
2024-03-25	17:39:00+02	18:25:00+02	VST002639	USR0177	GYM004
2023-04-05	16:16:00+02	17:54:00+02	VST002640	USR0130	GYM006
2024-04-22	13:51:00+02	16:07:00+02	VST002641	USR0195	GYM006
2024-11-13	08:49:00+02	11:20:00+02	VST002642	USR0011	GYM002
2023-07-09	08:47:00+02	09:46:00+02	VST002643	USR0306	GYM001
2024-12-11	09:41:00+02	12:17:00+02	VST002644	USR0419	GYM002
2024-04-28	15:50:00+02	17:48:00+02	VST002645	USR0122	GYM006
2024-06-19	08:16:00+02	10:40:00+02	VST002646	USR0399	GYM001
2024-02-27	10:07:00+02	12:28:00+02	VST002647	USR0235	GYM002
2024-10-01	10:41:00+02	11:16:00+02	VST002648	USR0331	GYM003
2024-08-27	15:31:00+02	16:42:00+02	VST002649	USR0031	GYM003
2023-05-13	15:47:00+02	17:30:00+02	VST002650	USR0348	GYM001
2023-02-24	08:00:00+02	09:19:00+02	VST002651	USR0446	GYM004
2024-05-24	15:18:00+02	17:48:00+02	VST002652	USR0412	GYM001
2024-10-31	11:27:00+02	13:25:00+02	VST002653	USR0224	GYM002
2024-06-24	10:15:00+02	12:37:00+02	VST002654	USR0153	GYM005
2024-02-14	13:09:00+02	14:38:00+02	VST002655	USR0212	GYM003
2023-07-30	10:42:00+02	13:21:00+02	VST002656	USR0092	GYM005
2024-10-27	12:40:00+02	14:06:00+02	VST002657	USR0409	GYM003
2023-10-20	09:35:00+02	12:35:00+02	VST002658	USR0331	GYM002
2023-04-25	14:09:00+02	16:05:00+02	VST002659	USR0467	GYM003
2024-10-31	12:16:00+02	14:45:00+02	VST002660	USR0348	GYM001
2023-09-16	09:24:00+02	10:27:00+02	VST002661	USR0129	GYM005
2023-05-02	14:20:00+02	16:05:00+02	VST002662	USR0443	GYM006
2023-10-26	10:49:00+02	12:58:00+02	VST002663	USR0197	GYM005
2024-01-16	08:53:00+02	11:09:00+02	VST002664	USR0458	GYM002
2024-07-14	14:45:00+02	16:47:00+02	VST002665	USR0042	GYM006
2024-05-15	13:12:00+02	15:42:00+02	VST002666	USR0366	GYM005
2023-10-24	11:59:00+02	13:10:00+02	VST002667	USR0418	GYM002
2023-12-28	15:19:00+02	16:42:00+02	VST002668	USR0228	GYM004
2024-08-11	09:33:00+02	11:15:00+02	VST002669	USR0194	GYM001
2024-04-07	09:37:00+02	10:29:00+02	VST002670	USR0018	GYM003
2024-03-13	08:01:00+02	10:34:00+02	VST002671	USR0333	GYM003
2023-05-07	11:38:00+02	12:41:00+02	VST002672	USR0243	GYM003
2023-07-16	16:08:00+02	17:22:00+02	VST002673	USR0389	GYM004
2023-08-09	09:19:00+02	10:40:00+02	VST002674	USR0276	GYM001
2023-04-01	10:15:00+02	11:25:00+02	VST002675	USR0450	GYM005
2024-02-15	11:51:00+02	14:26:00+02	VST002676	USR0127	GYM005
2023-01-08	16:51:00+02	17:46:00+02	VST002677	USR0075	GYM001
2024-06-27	15:35:00+02	17:51:00+02	VST002678	USR0062	GYM006
2024-04-12	08:09:00+02	10:45:00+02	VST002679	USR0478	GYM001
2023-11-16	08:08:00+02	09:55:00+02	VST002680	USR0480	GYM003
2024-01-29	13:51:00+02	15:21:00+02	VST002681	USR0288	GYM005
2023-09-26	10:03:00+02	11:26:00+02	VST002682	USR0186	GYM001
2023-07-10	15:12:00+02	18:04:00+02	VST002683	USR0178	GYM005
2024-11-05	10:15:00+02	10:57:00+02	VST002684	USR0166	GYM001
2023-03-02	16:09:00+02	16:43:00+02	VST002685	USR0183	GYM002
2024-03-13	09:12:00+02	11:13:00+02	VST002686	USR0028	GYM003
2023-09-21	11:54:00+02	13:30:00+02	VST002687	USR0330	GYM001
2023-04-05	14:32:00+02	16:33:00+02	VST002688	USR0470	GYM004
2024-07-06	09:31:00+02	10:41:00+02	VST002689	USR0247	GYM001
2024-04-14	09:44:00+02	10:58:00+02	VST002690	USR0337	GYM002
2024-10-22	09:45:00+02	12:23:00+02	VST002691	USR0022	GYM004
2024-12-16	13:20:00+02	13:58:00+02	VST002692	USR0427	GYM004
2024-05-28	14:16:00+02	15:02:00+02	VST002693	USR0467	GYM001
2024-11-20	13:06:00+02	15:02:00+02	VST002694	USR0465	GYM002
2023-07-13	10:20:00+02	12:40:00+02	VST002695	USR0472	GYM004
2024-04-26	14:31:00+02	15:30:00+02	VST002696	USR0420	GYM003
2023-12-02	10:16:00+02	11:44:00+02	VST002697	USR0096	GYM006
2024-03-10	10:26:00+02	11:26:00+02	VST002698	USR0122	GYM003
2023-07-15	09:10:00+02	12:03:00+02	VST002699	USR0250	GYM005
2023-09-06	17:03:00+02	18:30:00+02	VST002700	USR0494	GYM005
2024-05-12	17:36:00+02	20:10:00+02	VST002701	USR0379	GYM002
2023-07-31	08:08:00+02	09:44:00+02	VST002702	USR0308	GYM004
2024-10-26	10:48:00+02	12:45:00+02	VST002703	USR0420	GYM003
2024-10-31	15:30:00+02	17:30:00+02	VST002704	USR0412	GYM003
2024-04-10	13:59:00+02	14:40:00+02	VST002705	USR0334	GYM006
2024-10-12	11:38:00+02	14:30:00+02	VST002706	USR0442	GYM002
2023-08-09	10:35:00+02	12:13:00+02	VST002707	USR0420	GYM004
2023-09-30	15:01:00+02	16:09:00+02	VST002708	USR0326	GYM002
2023-06-03	15:33:00+02	18:14:00+02	VST002709	USR0137	GYM001
2023-09-06	11:42:00+02	12:38:00+02	VST002710	USR0277	GYM003
2023-10-06	09:28:00+02	10:10:00+02	VST002711	USR0320	GYM002
2024-03-15	09:42:00+02	12:04:00+02	VST002712	USR0332	GYM002
2023-10-03	10:23:00+02	12:50:00+02	VST002713	USR0061	GYM006
2024-05-28	10:06:00+02	11:04:00+02	VST002714	USR0250	GYM001
2023-03-29	14:33:00+02	15:30:00+02	VST002715	USR0478	GYM005
2024-10-03	13:59:00+02	14:55:00+02	VST002716	USR0095	GYM003
2024-05-19	15:19:00+02	18:12:00+02	VST002717	USR0296	GYM006
2024-08-12	13:22:00+02	14:02:00+02	VST002718	USR0184	GYM002
2023-08-29	10:23:00+02	13:02:00+02	VST002719	USR0260	GYM003
2024-10-14	12:13:00+02	13:09:00+02	VST002720	USR0287	GYM005
2024-11-05	12:43:00+02	13:55:00+02	VST002721	USR0155	GYM002
2023-08-24	09:26:00+02	10:26:00+02	VST002722	USR0186	GYM001
2023-05-08	12:14:00+02	13:36:00+02	VST002723	USR0409	GYM003
2024-05-17	17:26:00+02	19:28:00+02	VST002724	USR0069	GYM006
2023-07-19	12:51:00+02	14:01:00+02	VST002725	USR0326	GYM001
2024-06-26	08:27:00+02	10:11:00+02	VST002726	USR0261	GYM005
2024-05-16	13:08:00+02	15:31:00+02	VST002727	USR0115	GYM005
2024-10-11	11:30:00+02	14:09:00+02	VST002728	USR0347	GYM003
2024-05-06	16:50:00+02	19:27:00+02	VST002729	USR0008	GYM005
2023-01-21	16:41:00+02	17:36:00+02	VST002730	USR0265	GYM004
2023-08-22	11:13:00+02	12:22:00+02	VST002731	USR0271	GYM006
2024-12-14	14:41:00+02	16:44:00+02	VST002732	USR0484	GYM003
2024-10-04	13:02:00+02	14:57:00+02	VST002733	USR0249	GYM004
2024-02-20	08:55:00+02	10:00:00+02	VST002734	USR0105	GYM005
2023-05-28	12:05:00+02	13:06:00+02	VST002735	USR0263	GYM003
2023-01-29	16:26:00+02	17:47:00+02	VST002736	USR0224	GYM004
2023-12-27	14:35:00+02	16:57:00+02	VST002737	USR0328	GYM005
2023-11-04	09:55:00+02	12:11:00+02	VST002738	USR0495	GYM002
2023-06-11	12:06:00+02	12:37:00+02	VST002739	USR0371	GYM002
2023-03-02	16:31:00+02	18:03:00+02	VST002740	USR0271	GYM001
2023-05-05	09:12:00+02	11:43:00+02	VST002741	USR0165	GYM002
2024-03-31	17:00:00+02	18:57:00+02	VST002742	USR0083	GYM004
2023-03-12	08:12:00+02	09:55:00+02	VST002743	USR0295	GYM006
2024-04-10	14:09:00+02	16:48:00+02	VST002744	USR0134	GYM002
2023-08-31	13:24:00+02	14:37:00+02	VST002745	USR0211	GYM003
2024-05-04	10:15:00+02	11:06:00+02	VST002746	USR0313	GYM003
2023-08-09	14:36:00+02	16:14:00+02	VST002747	USR0092	GYM003
2024-04-17	17:42:00+02	19:47:00+02	VST002748	USR0337	GYM002
2024-06-16	15:10:00+02	17:26:00+02	VST002749	USR0490	GYM002
2024-05-08	14:14:00+02	16:16:00+02	VST002750	USR0403	GYM001
2023-03-23	17:19:00+02	18:51:00+02	VST002751	USR0127	GYM006
2024-06-05	10:56:00+02	12:04:00+02	VST002752	USR0191	GYM006
2023-01-12	16:02:00+02	18:47:00+02	VST002753	USR0159	GYM005
2023-09-20	09:14:00+02	11:31:00+02	VST002754	USR0331	GYM001
2024-10-18	08:17:00+02	09:45:00+02	VST002755	USR0335	GYM004
2024-03-24	09:09:00+02	10:14:00+02	VST002756	USR0010	GYM003
2023-07-11	08:14:00+02	10:33:00+02	VST002757	USR0107	GYM002
2023-04-24	12:28:00+02	14:43:00+02	VST002758	USR0087	GYM005
2023-01-26	11:40:00+02	13:54:00+02	VST002759	USR0067	GYM005
2024-05-13	08:40:00+02	11:07:00+02	VST002760	USR0062	GYM002
2024-05-22	09:01:00+02	11:43:00+02	VST002761	USR0387	GYM001
2024-06-28	14:47:00+02	16:49:00+02	VST002762	USR0146	GYM005
2023-03-03	16:38:00+02	17:15:00+02	VST002763	USR0153	GYM006
2023-08-17	12:53:00+02	15:16:00+02	VST002764	USR0107	GYM001
2024-08-29	16:33:00+02	17:40:00+02	VST002765	USR0148	GYM002
2023-02-04	15:05:00+02	15:37:00+02	VST002766	USR0186	GYM001
2024-12-05	15:13:00+02	17:55:00+02	VST002767	USR0349	GYM006
2024-03-31	14:51:00+02	15:38:00+02	VST002768	USR0342	GYM003
2024-08-10	09:24:00+02	10:15:00+02	VST002769	USR0178	GYM002
2024-05-16	17:09:00+02	19:05:00+02	VST002770	USR0377	GYM006
2024-08-17	17:10:00+02	19:00:00+02	VST002771	USR0335	GYM002
2023-01-25	10:36:00+02	12:48:00+02	VST002772	USR0487	GYM006
2024-07-22	12:44:00+02	13:56:00+02	VST002773	USR0266	GYM006
2023-02-01	09:25:00+02	11:46:00+02	VST002774	USR0149	GYM005
2023-01-12	13:17:00+02	14:02:00+02	VST002775	USR0247	GYM005
2023-11-15	09:20:00+02	11:30:00+02	VST002776	USR0254	GYM005
2024-08-26	16:43:00+02	17:22:00+02	VST002777	USR0500	GYM003
2023-01-01	11:28:00+02	12:36:00+02	VST002778	USR0029	GYM003
2024-03-10	10:39:00+02	13:36:00+02	VST002779	USR0352	GYM006
2023-05-16	17:09:00+02	17:53:00+02	VST002780	USR0266	GYM004
2023-07-15	13:34:00+02	16:17:00+02	VST002781	USR0013	GYM002
2023-05-13	14:40:00+02	16:25:00+02	VST002782	USR0047	GYM005
2023-03-27	18:00:00+02	20:17:00+02	VST002783	USR0151	GYM002
2024-04-20	09:07:00+02	11:19:00+02	VST002784	USR0050	GYM006
2023-11-20	13:17:00+02	16:08:00+02	VST002785	USR0215	GYM001
2023-06-29	15:27:00+02	17:14:00+02	VST002786	USR0479	GYM006
2024-05-30	12:04:00+02	13:54:00+02	VST002787	USR0132	GYM003
2024-09-29	08:59:00+02	10:57:00+02	VST002788	USR0372	GYM004
2023-06-24	12:10:00+02	12:42:00+02	VST002789	USR0113	GYM001
2023-01-21	09:28:00+02	11:09:00+02	VST002790	USR0252	GYM002
2023-04-15	15:24:00+02	18:09:00+02	VST002791	USR0451	GYM003
2024-07-31	09:58:00+02	11:05:00+02	VST002792	USR0341	GYM005
2024-03-18	15:44:00+02	17:57:00+02	VST002793	USR0053	GYM001
2023-02-18	08:56:00+02	11:20:00+02	VST002794	USR0130	GYM003
2024-06-11	13:16:00+02	14:38:00+02	VST002795	USR0324	GYM002
2023-05-25	10:59:00+02	13:48:00+02	VST002796	USR0193	GYM006
2023-12-06	10:02:00+02	12:25:00+02	VST002797	USR0079	GYM002
2023-12-20	08:12:00+02	10:10:00+02	VST002798	USR0057	GYM001
2023-03-16	10:20:00+02	12:33:00+02	VST002799	USR0097	GYM001
2024-07-31	08:11:00+02	09:31:00+02	VST002800	USR0198	GYM006
2024-09-28	10:47:00+02	12:34:00+02	VST002801	USR0135	GYM001
2023-11-15	16:28:00+02	17:19:00+02	VST002802	USR0147	GYM004
2023-03-28	13:55:00+02	14:34:00+02	VST002803	USR0172	GYM005
2024-07-06	16:55:00+02	19:42:00+02	VST002804	USR0063	GYM003
2024-11-28	16:49:00+02	18:44:00+02	VST002805	USR0065	GYM006
2023-02-11	12:25:00+02	14:34:00+02	VST002806	USR0295	GYM002
2023-04-03	10:50:00+02	11:52:00+02	VST002807	USR0211	GYM002
2024-11-27	14:20:00+02	17:03:00+02	VST002808	USR0109	GYM005
2024-12-27	10:09:00+02	12:57:00+02	VST002809	USR0282	GYM001
2024-05-21	12:35:00+02	14:17:00+02	VST002810	USR0172	GYM001
2024-06-12	10:00:00+02	11:24:00+02	VST002811	USR0012	GYM002
2023-09-22	08:30:00+02	09:23:00+02	VST002812	USR0406	GYM005
2024-09-17	13:43:00+02	16:23:00+02	VST002813	USR0333	GYM002
2023-10-19	15:19:00+02	18:10:00+02	VST002814	USR0220	GYM001
2024-04-08	12:38:00+02	14:27:00+02	VST002815	USR0398	GYM006
2024-07-13	16:56:00+02	19:39:00+02	VST002816	USR0342	GYM003
2023-04-07	09:05:00+02	11:02:00+02	VST002817	USR0286	GYM001
2023-04-05	12:29:00+02	13:39:00+02	VST002818	USR0172	GYM006
2023-11-22	17:50:00+02	18:25:00+02	VST002819	USR0468	GYM003
2023-03-15	09:18:00+02	09:55:00+02	VST002820	USR0236	GYM004
2023-12-02	16:28:00+02	19:16:00+02	VST002821	USR0475	GYM005
2023-03-09	15:46:00+02	17:22:00+02	VST002822	USR0166	GYM006
2023-03-18	16:43:00+02	18:14:00+02	VST002823	USR0187	GYM004
2023-07-27	14:08:00+02	15:55:00+02	VST002824	USR0170	GYM001
2023-08-09	08:56:00+02	11:14:00+02	VST002825	USR0052	GYM005
2023-09-19	16:31:00+02	19:10:00+02	VST002826	USR0319	GYM006
2024-02-14	17:40:00+02	18:38:00+02	VST002827	USR0189	GYM001
2023-11-27	10:50:00+02	11:35:00+02	VST002828	USR0120	GYM005
2023-12-10	14:16:00+02	16:21:00+02	VST002829	USR0105	GYM005
2023-03-15	10:41:00+02	12:17:00+02	VST002830	USR0162	GYM001
2024-09-28	12:21:00+02	15:00:00+02	VST002831	USR0295	GYM001
2024-11-30	09:45:00+02	11:45:00+02	VST002832	USR0041	GYM006
2023-09-11	17:47:00+02	18:48:00+02	VST002833	USR0377	GYM005
2023-11-28	09:58:00+02	10:40:00+02	VST002834	USR0364	GYM006
2024-02-02	11:53:00+02	12:54:00+02	VST002835	USR0165	GYM005
2023-12-11	16:41:00+02	19:05:00+02	VST002836	USR0321	GYM006
2024-08-06	08:02:00+02	09:48:00+02	VST002837	USR0374	GYM001
2024-10-29	08:45:00+02	11:41:00+02	VST002838	USR0335	GYM001
2024-03-30	08:12:00+02	08:43:00+02	VST002839	USR0160	GYM002
2023-04-25	12:10:00+02	14:36:00+02	VST002840	USR0264	GYM006
2023-11-09	08:47:00+02	10:43:00+02	VST002841	USR0353	GYM002
2023-08-16	16:03:00+02	17:33:00+02	VST002842	USR0018	GYM002
2023-09-02	14:12:00+02	17:10:00+02	VST002843	USR0173	GYM004
2024-06-09	14:32:00+02	17:26:00+02	VST002844	USR0477	GYM005
2024-06-11	10:33:00+02	13:19:00+02	VST002845	USR0352	GYM003
2024-03-02	11:03:00+02	12:32:00+02	VST002846	USR0033	GYM004
2023-02-11	08:36:00+02	10:35:00+02	VST002847	USR0261	GYM005
2024-04-09	17:26:00+02	19:12:00+02	VST002848	USR0210	GYM003
2024-09-13	15:09:00+02	16:51:00+02	VST002849	USR0496	GYM002
2023-10-05	11:49:00+02	14:45:00+02	VST002850	USR0383	GYM003
2023-01-19	13:29:00+02	14:34:00+02	VST002851	USR0330	GYM001
2023-03-07	12:14:00+02	14:20:00+02	VST002852	USR0382	GYM001
2023-06-16	15:06:00+02	17:49:00+02	VST002853	USR0164	GYM006
2024-08-07	13:27:00+02	15:00:00+02	VST002854	USR0481	GYM005
2024-02-07	12:37:00+02	13:33:00+02	VST002855	USR0407	GYM004
2024-02-13	09:19:00+02	11:12:00+02	VST002856	USR0424	GYM002
2023-04-22	17:45:00+02	20:27:00+02	VST002857	USR0005	GYM005
2023-10-01	14:21:00+02	17:20:00+02	VST002858	USR0034	GYM002
2024-02-11	10:02:00+02	11:21:00+02	VST002859	USR0280	GYM001
2024-01-08	16:34:00+02	18:36:00+02	VST002860	USR0145	GYM004
2024-08-19	08:53:00+02	11:19:00+02	VST002861	USR0351	GYM004
2024-10-12	11:03:00+02	11:58:00+02	VST002862	USR0071	GYM001
2023-02-08	11:48:00+02	12:55:00+02	VST002863	USR0465	GYM003
2023-04-15	16:48:00+02	19:06:00+02	VST002864	USR0348	GYM004
2023-11-20	08:47:00+02	11:02:00+02	VST002865	USR0230	GYM003
2024-02-18	14:50:00+02	15:40:00+02	VST002866	USR0125	GYM002
2024-03-04	09:10:00+02	10:03:00+02	VST002867	USR0278	GYM004
2024-09-26	15:56:00+02	16:41:00+02	VST002868	USR0271	GYM006
2024-12-30	12:49:00+02	15:07:00+02	VST002869	USR0357	GYM001
2023-03-02	13:18:00+02	14:21:00+02	VST002870	USR0015	GYM003
2024-09-03	13:35:00+02	16:06:00+02	VST002871	USR0242	GYM006
2023-11-03	09:28:00+02	10:52:00+02	VST002872	USR0498	GYM002
2023-12-20	17:26:00+02	19:50:00+02	VST002873	USR0153	GYM002
2024-01-28	15:47:00+02	16:36:00+02	VST002874	USR0053	GYM004
2023-07-23	08:08:00+02	10:12:00+02	VST002875	USR0149	GYM004
2023-09-15	14:17:00+02	17:01:00+02	VST002876	USR0358	GYM006
2024-04-30	11:25:00+02	13:38:00+02	VST002877	USR0450	GYM005
2024-05-31	12:58:00+02	15:58:00+02	VST002878	USR0219	GYM005
2024-03-21	17:37:00+02	20:30:00+02	VST002879	USR0113	GYM004
2024-12-09	13:11:00+02	15:53:00+02	VST002880	USR0288	GYM005
2023-06-29	12:08:00+02	14:19:00+02	VST002881	USR0277	GYM001
2023-12-08	15:55:00+02	17:32:00+02	VST002882	USR0452	GYM006
2023-05-13	14:17:00+02	17:16:00+02	VST002883	USR0428	GYM001
2024-03-18	16:25:00+02	19:02:00+02	VST002884	USR0083	GYM005
2023-09-10	11:20:00+02	13:38:00+02	VST002885	USR0450	GYM004
2023-09-22	17:19:00+02	19:41:00+02	VST002886	USR0218	GYM001
2023-04-03	12:11:00+02	14:46:00+02	VST002887	USR0226	GYM002
2024-10-23	10:34:00+02	12:50:00+02	VST002888	USR0270	GYM004
2024-02-15	08:06:00+02	09:17:00+02	VST002889	USR0015	GYM006
2023-05-18	14:59:00+02	16:05:00+02	VST002890	USR0404	GYM003
2023-07-27	08:24:00+02	11:03:00+02	VST002891	USR0290	GYM003
2024-09-28	11:58:00+02	13:00:00+02	VST002892	USR0420	GYM004
2024-07-26	17:14:00+02	19:48:00+02	VST002893	USR0339	GYM005
2023-11-03	13:54:00+02	16:21:00+02	VST002894	USR0265	GYM001
2023-09-23	08:09:00+02	09:12:00+02	VST002895	USR0199	GYM001
2024-10-07	13:43:00+02	16:24:00+02	VST002896	USR0158	GYM004
2023-11-14	08:01:00+02	10:46:00+02	VST002897	USR0333	GYM002
2023-04-23	14:25:00+02	15:25:00+02	VST002898	USR0475	GYM006
2024-01-13	13:14:00+02	14:38:00+02	VST002899	USR0447	GYM005
2024-03-29	09:46:00+02	12:12:00+02	VST002900	USR0492	GYM002
2023-07-10	11:30:00+02	14:01:00+02	VST002901	USR0419	GYM004
2024-03-15	17:02:00+02	17:40:00+02	VST002902	USR0397	GYM004
2023-07-06	12:03:00+02	13:13:00+02	VST002903	USR0207	GYM002
2024-01-02	15:09:00+02	18:02:00+02	VST002904	USR0174	GYM003
2023-03-30	16:23:00+02	18:27:00+02	VST002905	USR0184	GYM004
2023-07-06	09:01:00+02	10:01:00+02	VST002906	USR0265	GYM006
2023-05-12	10:25:00+02	12:39:00+02	VST002907	USR0493	GYM005
2024-09-26	12:46:00+02	13:44:00+02	VST002908	USR0471	GYM002
2024-07-13	09:35:00+02	10:35:00+02	VST002909	USR0246	GYM003
2024-01-11	08:44:00+02	10:48:00+02	VST002910	USR0036	GYM002
2024-11-21	11:57:00+02	14:53:00+02	VST002911	USR0373	GYM003
2024-11-22	16:52:00+02	18:36:00+02	VST002912	USR0488	GYM003
2023-04-09	15:02:00+02	15:42:00+02	VST002913	USR0259	GYM006
2023-02-03	14:21:00+02	17:04:00+02	VST002914	USR0482	GYM005
2024-08-04	15:49:00+02	16:58:00+02	VST002915	USR0019	GYM004
2023-06-20	09:26:00+02	10:26:00+02	VST002916	USR0412	GYM003
2024-01-01	17:54:00+02	19:59:00+02	VST002917	USR0023	GYM004
2023-02-28	09:37:00+02	11:25:00+02	VST002918	USR0104	GYM005
2023-06-30	16:37:00+02	18:42:00+02	VST002919	USR0241	GYM004
2023-01-19	10:16:00+02	12:03:00+02	VST002920	USR0493	GYM006
2023-08-14	14:43:00+02	16:28:00+02	VST002921	USR0391	GYM006
2024-04-17	09:16:00+02	11:50:00+02	VST002922	USR0361	GYM001
2023-04-05	17:41:00+02	18:18:00+02	VST002923	USR0204	GYM006
2023-10-24	09:03:00+02	10:09:00+02	VST002924	USR0253	GYM003
2024-08-15	15:25:00+02	16:31:00+02	VST002925	USR0142	GYM005
2023-06-24	10:13:00+02	13:13:00+02	VST002926	USR0302	GYM006
2023-08-10	12:02:00+02	14:19:00+02	VST002927	USR0143	GYM002
2024-09-06	12:58:00+02	13:40:00+02	VST002928	USR0451	GYM005
2023-02-23	12:27:00+02	14:15:00+02	VST002929	USR0271	GYM003
2024-11-25	13:22:00+02	15:04:00+02	VST002930	USR0307	GYM005
2024-02-07	14:42:00+02	16:07:00+02	VST002931	USR0472	GYM006
2023-11-14	13:34:00+02	14:50:00+02	VST002932	USR0500	GYM002
2023-12-15	13:25:00+02	16:00:00+02	VST002933	USR0110	GYM001
2024-03-18	15:43:00+02	16:13:00+02	VST002934	USR0008	GYM003
2024-08-02	12:38:00+02	13:39:00+02	VST002935	USR0069	GYM003
2024-06-23	11:59:00+02	14:49:00+02	VST002936	USR0190	GYM005
2023-10-09	09:16:00+02	11:15:00+02	VST002937	USR0179	GYM004
2023-12-26	11:27:00+02	12:14:00+02	VST002938	USR0063	GYM004
2024-09-22	10:19:00+02	11:00:00+02	VST002939	USR0068	GYM002
2024-10-07	17:58:00+02	20:14:00+02	VST002940	USR0206	GYM001
2024-10-02	09:51:00+02	12:24:00+02	VST002941	USR0400	GYM001
2023-01-08	10:39:00+02	13:35:00+02	VST002942	USR0468	GYM005
2024-07-16	09:48:00+02	11:37:00+02	VST002943	USR0408	GYM005
2024-05-05	10:48:00+02	13:42:00+02	VST002944	USR0006	GYM004
2023-12-07	15:40:00+02	18:05:00+02	VST002945	USR0119	GYM006
2024-04-16	15:57:00+02	17:53:00+02	VST002946	USR0313	GYM001
2024-11-17	13:21:00+02	15:27:00+02	VST002947	USR0031	GYM006
2024-11-25	14:56:00+02	17:27:00+02	VST002948	USR0006	GYM001
2024-12-04	10:03:00+02	11:06:00+02	VST002949	USR0483	GYM006
2023-09-06	17:08:00+02	18:13:00+02	VST002950	USR0207	GYM006
2023-08-23	14:06:00+02	16:45:00+02	VST002951	USR0157	GYM001
2023-03-24	11:32:00+02	13:59:00+02	VST002952	USR0067	GYM002
2023-04-03	15:42:00+02	18:07:00+02	VST002953	USR0459	GYM002
2024-01-29	13:15:00+02	15:39:00+02	VST002954	USR0387	GYM005
2023-09-25	15:54:00+02	17:02:00+02	VST002955	USR0412	GYM006
2024-02-21	12:31:00+02	14:24:00+02	VST002956	USR0330	GYM006
2024-09-23	10:02:00+02	10:54:00+02	VST002957	USR0370	GYM006
2024-08-05	09:32:00+02	11:46:00+02	VST002958	USR0353	GYM006
2024-06-12	10:41:00+02	12:50:00+02	VST002959	USR0432	GYM006
2023-09-10	13:11:00+02	14:40:00+02	VST002960	USR0336	GYM004
2023-05-02	08:41:00+02	10:52:00+02	VST002961	USR0379	GYM003
2023-01-10	11:40:00+02	13:36:00+02	VST002962	USR0394	GYM006
2023-11-12	13:35:00+02	16:23:00+02	VST002963	USR0289	GYM004
2023-09-30	10:31:00+02	11:12:00+02	VST002964	USR0484	GYM002
2023-11-02	09:33:00+02	11:56:00+02	VST002965	USR0451	GYM006
2023-07-29	12:14:00+02	13:55:00+02	VST002966	USR0453	GYM002
2024-12-30	14:04:00+02	14:56:00+02	VST002967	USR0140	GYM005
2024-04-08	14:45:00+02	15:57:00+02	VST002968	USR0441	GYM003
2024-12-12	16:45:00+02	17:21:00+02	VST002969	USR0300	GYM001
2024-12-28	08:50:00+02	11:46:00+02	VST002970	USR0013	GYM003
2024-12-17	13:06:00+02	14:55:00+02	VST002971	USR0152	GYM006
2024-02-20	12:26:00+02	15:19:00+02	VST002972	USR0428	GYM006
2023-08-04	10:58:00+02	11:59:00+02	VST002973	USR0313	GYM003
2023-03-21	08:31:00+02	11:24:00+02	VST002974	USR0352	GYM003
2024-04-24	14:54:00+02	15:45:00+02	VST002975	USR0400	GYM005
2024-06-30	15:43:00+02	17:02:00+02	VST002976	USR0480	GYM002
2023-01-18	17:29:00+02	20:17:00+02	VST002977	USR0109	GYM001
2023-06-14	17:23:00+02	20:20:00+02	VST002978	USR0485	GYM003
2024-06-08	12:15:00+02	12:58:00+02	VST002979	USR0376	GYM001
2023-07-21	09:36:00+02	12:31:00+02	VST002980	USR0356	GYM003
2023-12-12	15:53:00+02	18:36:00+02	VST002981	USR0149	GYM002
2024-01-01	09:44:00+02	11:02:00+02	VST002982	USR0367	GYM001
2024-03-23	10:23:00+02	12:54:00+02	VST002983	USR0204	GYM004
2024-05-27	10:04:00+02	12:42:00+02	VST002984	USR0307	GYM002
2023-11-15	08:12:00+02	08:46:00+02	VST002985	USR0021	GYM001
2023-08-05	09:03:00+02	10:03:00+02	VST002986	USR0060	GYM003
2023-02-03	11:47:00+02	14:33:00+02	VST002987	USR0435	GYM003
2023-09-23	10:13:00+02	11:29:00+02	VST002988	USR0021	GYM002
2024-10-01	11:22:00+02	11:56:00+02	VST002989	USR0363	GYM002
2024-12-24	14:50:00+02	16:30:00+02	VST002990	USR0382	GYM003
2023-03-21	14:21:00+02	15:43:00+02	VST002991	USR0245	GYM001
2024-11-07	09:26:00+02	10:58:00+02	VST002992	USR0390	GYM004
2024-02-17	17:56:00+02	20:54:00+02	VST002993	USR0073	GYM005
2023-09-09	18:00:00+02	20:23:00+02	VST002994	USR0449	GYM002
2023-01-12	12:25:00+02	13:16:00+02	VST002995	USR0076	GYM003
2024-02-05	09:16:00+02	12:02:00+02	VST002996	USR0186	GYM001
2024-12-24	08:22:00+02	10:14:00+02	VST002997	USR0078	GYM002
2023-10-09	09:06:00+02	11:18:00+02	VST002998	USR0390	GYM001
2023-04-22	11:22:00+02	14:22:00+02	VST002999	USR0065	GYM002
2024-12-23	15:34:00+02	16:15:00+02	VST003000	USR0342	GYM003
2024-01-13	10:11:00+02	12:46:00+02	VST003001	USR0290	GYM001
2023-09-25	09:34:00+02	10:09:00+02	VST003002	USR0056	GYM003
2023-10-25	13:39:00+02	15:36:00+02	VST003003	USR0331	GYM001
2023-11-13	10:05:00+02	12:26:00+02	VST003004	USR0259	GYM002
2024-07-23	08:43:00+02	09:59:00+02	VST003005	USR0426	GYM005
2024-05-23	15:52:00+02	18:08:00+02	VST003006	USR0190	GYM005
2024-06-29	08:51:00+02	09:27:00+02	VST003007	USR0006	GYM004
2023-12-31	10:52:00+02	13:37:00+02	VST003008	USR0006	GYM004
2024-06-30	17:47:00+02	19:38:00+02	VST003009	USR0191	GYM006
2023-09-28	15:23:00+02	17:30:00+02	VST003010	USR0148	GYM003
2024-04-18	14:44:00+02	16:19:00+02	VST003011	USR0405	GYM001
2024-06-20	16:28:00+02	17:21:00+02	VST003012	USR0258	GYM004
2023-08-22	08:30:00+02	09:29:00+02	VST003013	USR0218	GYM002
2023-02-28	14:31:00+02	15:26:00+02	VST003014	USR0479	GYM005
2023-09-08	15:16:00+02	18:04:00+02	VST003015	USR0090	GYM001
2023-03-27	10:56:00+02	12:09:00+02	VST003016	USR0312	GYM006
2024-01-25	14:02:00+02	15:45:00+02	VST003017	USR0352	GYM005
2023-06-29	11:39:00+02	12:45:00+02	VST003018	USR0010	GYM001
2024-12-19	11:11:00+02	12:27:00+02	VST003019	USR0087	GYM004
2023-05-29	12:41:00+02	14:16:00+02	VST003020	USR0250	GYM004
2024-08-05	12:46:00+02	13:38:00+02	VST003021	USR0326	GYM003
2023-05-01	15:36:00+02	16:45:00+02	VST003022	USR0151	GYM006
2024-08-27	10:32:00+02	12:20:00+02	VST003023	USR0476	GYM001
2023-09-13	08:35:00+02	10:49:00+02	VST003024	USR0113	GYM006
2023-11-05	12:11:00+02	13:24:00+02	VST003025	USR0030	GYM002
2023-02-28	13:02:00+02	13:47:00+02	VST003026	USR0128	GYM006
2023-03-10	16:30:00+02	18:23:00+02	VST003027	USR0078	GYM004
2024-03-21	15:01:00+02	16:17:00+02	VST003028	USR0421	GYM003
2024-01-23	17:23:00+02	17:59:00+02	VST003029	USR0055	GYM004
2023-03-27	16:10:00+02	16:54:00+02	VST003030	USR0480	GYM005
2023-08-15	09:02:00+02	10:48:00+02	VST003031	USR0305	GYM004
2024-08-15	09:29:00+02	11:38:00+02	VST003032	USR0034	GYM001
2024-09-17	12:46:00+02	13:41:00+02	VST003033	USR0105	GYM003
2023-07-03	14:32:00+02	16:23:00+02	VST003034	USR0172	GYM001
2023-11-18	10:20:00+02	11:26:00+02	VST003035	USR0499	GYM002
2023-11-14	15:09:00+02	17:24:00+02	VST003036	USR0022	GYM002
2024-07-19	11:24:00+02	13:16:00+02	VST003037	USR0287	GYM004
2024-02-03	16:58:00+02	18:34:00+02	VST003038	USR0391	GYM003
2024-12-09	12:15:00+02	14:21:00+02	VST003039	USR0105	GYM006
2023-10-20	17:16:00+02	18:16:00+02	VST003040	USR0149	GYM003
2023-10-20	08:19:00+02	09:02:00+02	VST003041	USR0272	GYM003
2024-04-29	14:31:00+02	15:52:00+02	VST003042	USR0276	GYM003
2024-03-22	14:07:00+02	15:38:00+02	VST003043	USR0299	GYM004
2024-11-22	16:11:00+02	19:11:00+02	VST003044	USR0172	GYM001
2024-02-16	17:17:00+02	18:47:00+02	VST003045	USR0047	GYM004
2024-05-22	16:16:00+02	18:52:00+02	VST003046	USR0114	GYM006
2023-09-01	13:52:00+02	16:32:00+02	VST003047	USR0275	GYM001
2024-02-24	17:39:00+02	20:18:00+02	VST003048	USR0304	GYM006
2023-06-03	16:34:00+02	18:42:00+02	VST003049	USR0480	GYM005
2024-02-28	13:29:00+02	14:28:00+02	VST003050	USR0207	GYM005
2023-09-30	14:37:00+02	16:15:00+02	VST003051	USR0453	GYM001
2024-10-08	12:36:00+02	13:21:00+02	VST003052	USR0395	GYM004
2024-06-03	11:04:00+02	12:55:00+02	VST003053	USR0463	GYM006
2023-05-08	08:26:00+02	10:54:00+02	VST003054	USR0413	GYM006
2024-01-08	13:26:00+02	16:17:00+02	VST003055	USR0242	GYM002
2024-07-21	11:44:00+02	13:58:00+02	VST003056	USR0301	GYM006
2024-09-29	08:30:00+02	09:16:00+02	VST003057	USR0196	GYM004
2023-06-08	12:47:00+02	15:20:00+02	VST003058	USR0497	GYM002
2024-07-24	08:59:00+02	09:36:00+02	VST003059	USR0164	GYM004
2024-07-23	16:03:00+02	18:17:00+02	VST003060	USR0176	GYM003
2024-10-13	17:02:00+02	18:31:00+02	VST003061	USR0343	GYM006
2023-06-25	14:06:00+02	14:40:00+02	VST003062	USR0271	GYM003
2024-09-11	17:58:00+02	19:36:00+02	VST003063	USR0110	GYM005
2023-07-30	11:58:00+02	14:49:00+02	VST003064	USR0172	GYM005
2024-03-22	10:43:00+02	13:43:00+02	VST003065	USR0451	GYM001
2024-08-08	09:42:00+02	10:37:00+02	VST003066	USR0352	GYM006
2023-06-16	12:13:00+02	13:46:00+02	VST003067	USR0202	GYM002
2024-04-04	12:06:00+02	14:58:00+02	VST003068	USR0168	GYM003
2023-12-23	12:32:00+02	13:34:00+02	VST003069	USR0102	GYM004
2023-10-31	17:06:00+02	18:53:00+02	VST003070	USR0086	GYM006
2023-08-21	08:57:00+02	11:52:00+02	VST003071	USR0142	GYM001
2023-11-23	11:44:00+02	13:58:00+02	VST003072	USR0447	GYM004
2023-07-01	17:49:00+02	20:13:00+02	VST003073	USR0337	GYM003
2024-09-25	14:37:00+02	15:28:00+02	VST003074	USR0213	GYM006
2023-11-30	14:03:00+02	16:41:00+02	VST003075	USR0051	GYM003
2024-12-15	10:57:00+02	12:19:00+02	VST003076	USR0112	GYM006
2023-01-29	11:00:00+02	12:06:00+02	VST003077	USR0463	GYM006
2024-12-14	12:02:00+02	14:07:00+02	VST003078	USR0442	GYM003
2023-04-03	13:25:00+02	16:13:00+02	VST003079	USR0271	GYM003
2024-11-18	14:07:00+02	15:20:00+02	VST003080	USR0065	GYM004
2023-11-26	08:28:00+02	10:00:00+02	VST003081	USR0344	GYM001
2024-12-23	14:00:00+02	16:47:00+02	VST003082	USR0183	GYM003
2023-07-03	17:41:00+02	19:59:00+02	VST003083	USR0332	GYM005
2023-04-05	17:37:00+02	20:29:00+02	VST003084	USR0010	GYM001
2024-10-10	10:25:00+02	12:50:00+02	VST003085	USR0494	GYM005
2023-12-19	17:36:00+02	18:16:00+02	VST003086	USR0234	GYM004
2023-09-22	11:12:00+02	11:42:00+02	VST003087	USR0298	GYM003
2024-10-08	16:24:00+02	18:52:00+02	VST003088	USR0244	GYM001
2024-10-17	17:15:00+02	18:59:00+02	VST003089	USR0351	GYM003
2023-01-19	13:16:00+02	14:28:00+02	VST003090	USR0267	GYM006
2024-10-07	10:59:00+02	11:29:00+02	VST003091	USR0118	GYM003
2024-09-17	16:22:00+02	17:07:00+02	VST003092	USR0144	GYM001
2024-05-13	08:38:00+02	11:11:00+02	VST003093	USR0381	GYM003
2023-05-19	09:32:00+02	11:11:00+02	VST003094	USR0201	GYM003
2024-09-28	08:57:00+02	10:31:00+02	VST003095	USR0239	GYM002
2024-12-16	11:58:00+02	14:05:00+02	VST003096	USR0334	GYM002
2024-07-26	11:44:00+02	13:43:00+02	VST003097	USR0403	GYM001
2024-06-08	08:20:00+02	09:44:00+02	VST003098	USR0415	GYM001
2023-09-12	16:59:00+02	19:58:00+02	VST003099	USR0457	GYM006
2023-03-26	16:09:00+02	18:49:00+02	VST003100	USR0484	GYM006
2024-04-02	08:00:00+02	09:42:00+02	VST003101	USR0437	GYM003
2024-06-15	13:39:00+02	14:20:00+02	VST003102	USR0487	GYM005
2024-07-15	11:26:00+02	12:37:00+02	VST003103	USR0246	GYM001
2024-11-06	10:13:00+02	12:59:00+02	VST003104	USR0346	GYM003
2023-04-02	13:48:00+02	16:42:00+02	VST003105	USR0008	GYM005
2024-08-22	11:01:00+02	11:48:00+02	VST003106	USR0152	GYM002
2023-03-10	13:31:00+02	15:17:00+02	VST003107	USR0392	GYM006
2023-02-06	09:00:00+02	09:52:00+02	VST003108	USR0211	GYM001
2023-05-20	08:22:00+02	10:33:00+02	VST003109	USR0367	GYM003
2024-11-10	10:31:00+02	11:32:00+02	VST003110	USR0432	GYM002
2024-07-19	18:00:00+02	19:05:00+02	VST003111	USR0158	GYM004
2023-06-27	10:25:00+02	13:17:00+02	VST003112	USR0058	GYM002
2024-09-09	09:53:00+02	11:34:00+02	VST003113	USR0086	GYM003
2023-05-17	16:58:00+02	19:18:00+02	VST003114	USR0055	GYM006
2023-07-09	14:13:00+02	15:36:00+02	VST003115	USR0201	GYM005
2024-10-01	09:14:00+02	11:53:00+02	VST003116	USR0122	GYM004
2023-12-08	14:22:00+02	16:13:00+02	VST003117	USR0446	GYM004
2024-07-12	14:45:00+02	16:42:00+02	VST003118	USR0108	GYM006
2023-01-05	18:00:00+02	19:36:00+02	VST003119	USR0304	GYM004
2023-09-14	09:43:00+02	12:08:00+02	VST003120	USR0132	GYM001
2024-10-23	13:44:00+02	15:23:00+02	VST003121	USR0421	GYM003
2023-08-31	13:09:00+02	14:41:00+02	VST003122	USR0392	GYM004
2024-12-20	13:30:00+02	15:22:00+02	VST003123	USR0385	GYM002
2024-02-19	10:19:00+02	12:16:00+02	VST003124	USR0476	GYM005
2024-09-18	10:41:00+02	12:04:00+02	VST003125	USR0198	GYM003
2024-12-07	15:27:00+02	17:54:00+02	VST003126	USR0047	GYM006
2023-12-09	16:18:00+02	18:12:00+02	VST003127	USR0228	GYM002
2024-11-12	13:24:00+02	13:58:00+02	VST003128	USR0245	GYM001
2024-01-14	10:58:00+02	12:02:00+02	VST003129	USR0203	GYM004
2024-08-16	17:35:00+02	18:05:00+02	VST003130	USR0261	GYM002
2024-10-27	14:05:00+02	16:36:00+02	VST003131	USR0178	GYM003
2024-10-14	11:48:00+02	12:19:00+02	VST003132	USR0024	GYM002
2023-05-26	10:59:00+02	11:31:00+02	VST003133	USR0175	GYM001
2023-11-19	14:27:00+02	15:41:00+02	VST003134	USR0274	GYM005
2023-05-02	13:14:00+02	15:29:00+02	VST003135	USR0340	GYM004
2023-09-09	13:01:00+02	15:53:00+02	VST003136	USR0412	GYM003
2023-11-07	10:10:00+02	12:45:00+02	VST003137	USR0461	GYM004
2024-08-23	11:01:00+02	13:11:00+02	VST003138	USR0261	GYM004
2024-04-19	08:01:00+02	10:48:00+02	VST003139	USR0286	GYM006
2024-07-23	17:46:00+02	18:36:00+02	VST003140	USR0001	GYM004
2024-05-06	14:40:00+02	15:29:00+02	VST003141	USR0086	GYM002
2024-07-28	17:41:00+02	20:28:00+02	VST003142	USR0338	GYM002
2023-12-13	08:33:00+02	09:10:00+02	VST003143	USR0430	GYM005
2024-05-01	11:06:00+02	13:29:00+02	VST003144	USR0069	GYM001
2024-04-17	13:25:00+02	14:26:00+02	VST003145	USR0031	GYM003
2024-01-17	11:46:00+02	13:46:00+02	VST003146	USR0198	GYM002
2023-10-07	17:39:00+02	19:45:00+02	VST003147	USR0091	GYM004
2023-03-13	09:46:00+02	11:47:00+02	VST003148	USR0440	GYM001
2024-06-04	16:28:00+02	18:37:00+02	VST003149	USR0473	GYM003
2024-01-01	10:24:00+02	11:39:00+02	VST003150	USR0349	GYM003
2023-04-04	13:39:00+02	14:11:00+02	VST003151	USR0383	GYM003
2024-01-08	09:19:00+02	10:20:00+02	VST003152	USR0412	GYM003
2023-12-05	12:03:00+02	14:31:00+02	VST003153	USR0016	GYM005
2024-03-12	13:55:00+02	15:59:00+02	VST003154	USR0310	GYM003
2023-12-02	13:27:00+02	14:46:00+02	VST003155	USR0437	GYM001
2024-10-25	10:51:00+02	13:14:00+02	VST003156	USR0396	GYM002
2024-05-06	09:30:00+02	10:02:00+02	VST003157	USR0276	GYM001
2023-02-09	13:43:00+02	15:09:00+02	VST003158	USR0338	GYM004
2023-12-25	15:37:00+02	16:12:00+02	VST003159	USR0162	GYM006
2024-07-27	08:11:00+02	09:52:00+02	VST003160	USR0437	GYM005
2023-09-11	12:31:00+02	14:32:00+02	VST003161	USR0192	GYM005
2024-08-03	11:34:00+02	12:53:00+02	VST003162	USR0151	GYM004
2024-02-02	12:15:00+02	13:08:00+02	VST003163	USR0365	GYM001
2023-06-19	09:09:00+02	10:56:00+02	VST003164	USR0411	GYM001
2024-11-20	13:58:00+02	15:24:00+02	VST003165	USR0113	GYM004
2024-12-01	12:22:00+02	13:51:00+02	VST003166	USR0273	GYM006
2024-05-25	09:50:00+02	12:26:00+02	VST003167	USR0176	GYM003
2023-09-17	08:01:00+02	10:03:00+02	VST003168	USR0149	GYM003
2024-08-06	08:49:00+02	09:28:00+02	VST003169	USR0178	GYM002
2024-04-03	14:35:00+02	16:16:00+02	VST003170	USR0424	GYM001
2024-06-12	15:28:00+02	18:04:00+02	VST003171	USR0382	GYM001
2023-12-07	15:09:00+02	16:32:00+02	VST003172	USR0223	GYM004
2023-02-26	10:50:00+02	11:21:00+02	VST003173	USR0259	GYM004
2023-08-06	15:03:00+02	16:23:00+02	VST003174	USR0273	GYM003
2024-09-10	16:24:00+02	18:35:00+02	VST003175	USR0189	GYM001
2024-11-15	14:27:00+02	15:25:00+02	VST003176	USR0306	GYM001
2024-12-31	13:59:00+02	15:40:00+02	VST003177	USR0378	GYM005
2024-04-08	17:19:00+02	20:14:00+02	VST003178	USR0090	GYM002
2023-09-04	14:24:00+02	17:02:00+02	VST003179	USR0343	GYM002
2024-12-30	09:43:00+02	12:19:00+02	VST003180	USR0262	GYM003
2024-01-08	16:10:00+02	17:23:00+02	VST003181	USR0156	GYM006
2024-02-21	17:51:00+02	20:42:00+02	VST003182	USR0200	GYM001
2023-01-31	11:50:00+02	13:09:00+02	VST003183	USR0055	GYM005
2024-01-03	10:46:00+02	13:40:00+02	VST003184	USR0254	GYM001
2024-07-12	15:42:00+02	18:36:00+02	VST003185	USR0442	GYM004
2024-10-07	09:15:00+02	10:29:00+02	VST003186	USR0173	GYM003
2023-04-18	08:34:00+02	09:20:00+02	VST003187	USR0200	GYM006
2024-08-06	13:01:00+02	16:01:00+02	VST003188	USR0403	GYM002
2024-02-22	08:20:00+02	09:22:00+02	VST003189	USR0102	GYM001
2024-09-11	13:26:00+02	14:12:00+02	VST003190	USR0285	GYM006
2024-02-02	12:27:00+02	13:29:00+02	VST003191	USR0151	GYM003
2023-09-29	09:47:00+02	11:23:00+02	VST003192	USR0111	GYM002
2024-11-13	09:15:00+02	12:10:00+02	VST003193	USR0416	GYM001
2023-04-26	13:50:00+02	15:18:00+02	VST003194	USR0266	GYM005
2024-08-08	10:54:00+02	13:37:00+02	VST003195	USR0091	GYM003
2023-09-13	14:24:00+02	16:04:00+02	VST003196	USR0177	GYM001
2023-03-22	10:44:00+02	12:03:00+02	VST003197	USR0449	GYM002
2023-05-08	09:16:00+02	09:51:00+02	VST003198	USR0231	GYM002
2023-08-23	17:20:00+02	20:06:00+02	VST003199	USR0029	GYM005
2024-07-06	09:35:00+02	11:09:00+02	VST003200	USR0443	GYM003
2023-06-30	13:46:00+02	16:39:00+02	VST003201	USR0301	GYM003
2023-06-06	16:14:00+02	18:40:00+02	VST003202	USR0195	GYM006
2024-03-29	08:31:00+02	09:01:00+02	VST003203	USR0307	GYM001
2024-07-24	15:21:00+02	17:40:00+02	VST003204	USR0239	GYM006
2024-12-04	10:48:00+02	11:31:00+02	VST003205	USR0357	GYM002
2023-01-24	15:24:00+02	17:16:00+02	VST003206	USR0479	GYM002
2024-04-17	10:40:00+02	13:00:00+02	VST003207	USR0384	GYM005
2024-02-04	08:54:00+02	11:08:00+02	VST003208	USR0267	GYM005
2024-08-14	09:43:00+02	11:23:00+02	VST003209	USR0214	GYM003
2023-05-14	13:39:00+02	14:40:00+02	VST003210	USR0082	GYM006
2024-02-25	11:30:00+02	14:12:00+02	VST003211	USR0128	GYM002
2023-08-01	11:14:00+02	13:43:00+02	VST003212	USR0483	GYM001
2024-04-26	14:59:00+02	17:35:00+02	VST003213	USR0262	GYM004
2023-12-14	17:27:00+02	19:29:00+02	VST003214	USR0067	GYM001
2023-06-15	17:13:00+02	19:55:00+02	VST003215	USR0062	GYM005
2023-12-14	12:31:00+02	13:12:00+02	VST003216	USR0133	GYM001
2024-02-02	12:48:00+02	14:15:00+02	VST003217	USR0137	GYM002
2024-08-05	13:04:00+02	13:46:00+02	VST003218	USR0028	GYM006
2024-12-26	12:03:00+02	13:44:00+02	VST003219	USR0211	GYM003
2024-03-10	09:38:00+02	11:55:00+02	VST003220	USR0476	GYM006
2024-07-30	08:50:00+02	11:36:00+02	VST003221	USR0475	GYM004
2023-08-09	14:42:00+02	17:06:00+02	VST003222	USR0205	GYM003
2023-11-04	17:45:00+02	19:35:00+02	VST003223	USR0253	GYM004
2024-11-27	17:22:00+02	17:53:00+02	VST003224	USR0038	GYM004
2024-12-19	16:22:00+02	18:32:00+02	VST003225	USR0043	GYM002
2024-04-10	10:37:00+02	11:56:00+02	VST003226	USR0117	GYM002
2023-04-09	08:55:00+02	10:50:00+02	VST003227	USR0405	GYM005
2023-08-30	14:09:00+02	14:59:00+02	VST003228	USR0475	GYM005
2023-06-07	08:03:00+02	10:59:00+02	VST003229	USR0190	GYM004
2024-09-01	15:17:00+02	15:53:00+02	VST003230	USR0046	GYM006
2024-07-07	09:29:00+02	10:56:00+02	VST003231	USR0454	GYM005
2024-10-12	13:01:00+02	15:19:00+02	VST003232	USR0166	GYM002
2023-08-15	16:11:00+02	17:00:00+02	VST003233	USR0305	GYM005
2024-02-27	11:24:00+02	12:57:00+02	VST003234	USR0203	GYM004
2023-03-13	09:39:00+02	10:59:00+02	VST003235	USR0495	GYM003
2023-08-31	08:26:00+02	09:38:00+02	VST003236	USR0233	GYM006
2024-06-13	11:31:00+02	13:25:00+02	VST003237	USR0245	GYM006
2024-08-11	10:54:00+02	12:43:00+02	VST003238	USR0209	GYM001
2023-02-14	12:58:00+02	13:44:00+02	VST003239	USR0248	GYM005
2024-04-16	09:23:00+02	10:17:00+02	VST003240	USR0295	GYM006
2024-01-06	16:04:00+02	16:41:00+02	VST003241	USR0327	GYM002
2024-10-13	09:58:00+02	12:30:00+02	VST003242	USR0383	GYM003
2024-11-19	13:15:00+02	15:35:00+02	VST003243	USR0158	GYM002
2023-04-02	14:47:00+02	15:23:00+02	VST003244	USR0405	GYM005
2023-01-22	16:02:00+02	17:57:00+02	VST003245	USR0001	GYM004
2023-06-21	16:20:00+02	17:54:00+02	VST003246	USR0217	GYM001
2024-08-26	12:31:00+02	14:04:00+02	VST003247	USR0416	GYM001
2023-07-11	09:33:00+02	10:30:00+02	VST003248	USR0249	GYM003
2023-03-18	17:17:00+02	19:48:00+02	VST003249	USR0392	GYM006
2023-10-08	14:36:00+02	16:07:00+02	VST003250	USR0069	GYM006
2023-12-30	11:09:00+02	13:06:00+02	VST003251	USR0030	GYM006
2023-06-28	14:19:00+02	15:02:00+02	VST003252	USR0115	GYM001
2023-08-26	14:30:00+02	16:25:00+02	VST003253	USR0008	GYM004
2023-05-15	14:18:00+02	17:01:00+02	VST003254	USR0369	GYM006
2023-10-07	11:11:00+02	12:41:00+02	VST003255	USR0275	GYM002
2023-01-19	15:36:00+02	16:24:00+02	VST003256	USR0492	GYM006
2024-08-17	08:45:00+02	11:07:00+02	VST003257	USR0315	GYM004
2024-01-06	12:29:00+02	13:23:00+02	VST003258	USR0439	GYM003
2023-04-22	15:30:00+02	17:54:00+02	VST003259	USR0414	GYM003
2024-11-06	15:56:00+02	18:54:00+02	VST003260	USR0335	GYM001
2024-11-10	12:29:00+02	13:30:00+02	VST003261	USR0036	GYM004
2023-08-09	11:51:00+02	12:42:00+02	VST003262	USR0311	GYM002
2023-10-31	12:35:00+02	13:20:00+02	VST003263	USR0044	GYM004
2024-12-03	17:37:00+02	18:15:00+02	VST003264	USR0155	GYM002
2023-11-21	09:03:00+02	11:09:00+02	VST003265	USR0077	GYM002
2024-03-12	10:34:00+02	12:24:00+02	VST003266	USR0078	GYM004
2024-03-13	09:39:00+02	10:25:00+02	VST003267	USR0101	GYM005
2023-06-19	09:27:00+02	10:29:00+02	VST003268	USR0438	GYM004
2024-01-10	13:52:00+02	14:37:00+02	VST003269	USR0432	GYM002
2024-07-10	17:14:00+02	19:37:00+02	VST003270	USR0030	GYM006
2024-01-16	15:03:00+02	15:47:00+02	VST003271	USR0039	GYM003
2023-01-14	11:52:00+02	13:39:00+02	VST003272	USR0239	GYM003
2024-10-30	17:26:00+02	19:46:00+02	VST003273	USR0013	GYM001
2024-05-14	09:02:00+02	09:48:00+02	VST003274	USR0122	GYM003
2024-10-07	14:36:00+02	15:32:00+02	VST003275	USR0144	GYM005
2024-01-26	16:55:00+02	17:39:00+02	VST003276	USR0172	GYM002
2024-07-02	15:08:00+02	18:01:00+02	VST003277	USR0455	GYM004
2024-07-18	17:08:00+02	17:51:00+02	VST003278	USR0368	GYM004
2024-06-13	16:06:00+02	17:51:00+02	VST003279	USR0247	GYM005
2024-05-06	17:46:00+02	19:53:00+02	VST003280	USR0247	GYM003
2024-07-03	12:01:00+02	14:13:00+02	VST003281	USR0411	GYM002
2024-11-29	16:07:00+02	17:01:00+02	VST003282	USR0045	GYM003
2024-01-20	13:06:00+02	15:21:00+02	VST003283	USR0253	GYM001
2023-07-15	09:20:00+02	10:49:00+02	VST003284	USR0375	GYM003
2023-10-27	14:44:00+02	15:16:00+02	VST003285	USR0291	GYM001
2024-06-30	08:35:00+02	11:01:00+02	VST003286	USR0207	GYM004
2024-12-27	16:34:00+02	18:42:00+02	VST003287	USR0412	GYM002
2024-12-31	17:44:00+02	20:12:00+02	VST003288	USR0483	GYM006
2024-08-24	16:49:00+02	19:08:00+02	VST003289	USR0007	GYM001
2023-11-04	17:45:00+02	18:40:00+02	VST003290	USR0446	GYM003
2023-09-09	10:30:00+02	12:26:00+02	VST003291	USR0242	GYM003
2023-01-08	10:03:00+02	10:39:00+02	VST003292	USR0110	GYM004
2023-07-27	15:39:00+02	18:05:00+02	VST003293	USR0114	GYM005
2023-05-11	10:57:00+02	13:39:00+02	VST003294	USR0307	GYM006
2024-12-09	10:51:00+02	12:45:00+02	VST003295	USR0302	GYM005
2024-10-15	11:36:00+02	14:36:00+02	VST003296	USR0276	GYM003
2024-08-30	11:17:00+02	12:36:00+02	VST003297	USR0096	GYM005
2023-01-26	10:09:00+02	11:06:00+02	VST003298	USR0294	GYM006
2024-09-14	08:43:00+02	09:39:00+02	VST003299	USR0189	GYM006
2024-03-29	15:13:00+02	15:46:00+02	VST003300	USR0360	GYM002
2024-09-26	09:20:00+02	10:07:00+02	VST003301	USR0288	GYM005
2023-07-05	15:25:00+02	16:44:00+02	VST003302	USR0154	GYM002
2024-04-28	11:26:00+02	14:22:00+02	VST003303	USR0058	GYM003
2024-11-10	10:31:00+02	11:33:00+02	VST003304	USR0423	GYM003
2023-02-20	12:24:00+02	15:04:00+02	VST003305	USR0404	GYM003
2023-01-05	13:27:00+02	15:02:00+02	VST003306	USR0338	GYM004
2024-08-11	09:08:00+02	11:08:00+02	VST003307	USR0050	GYM005
2023-06-09	09:29:00+02	11:46:00+02	VST003308	USR0207	GYM001
2023-07-27	14:37:00+02	17:10:00+02	VST003309	USR0052	GYM006
2023-09-14	17:29:00+02	19:52:00+02	VST003310	USR0342	GYM001
2023-07-24	14:46:00+02	16:03:00+02	VST003311	USR0371	GYM003
2023-01-11	17:25:00+02	18:57:00+02	VST003312	USR0150	GYM005
2023-01-08	13:33:00+02	14:38:00+02	VST003313	USR0053	GYM002
2024-02-13	12:42:00+02	13:23:00+02	VST003314	USR0213	GYM001
2023-02-01	16:52:00+02	17:37:00+02	VST003315	USR0066	GYM003
2024-06-23	15:49:00+02	16:51:00+02	VST003316	USR0232	GYM001
2024-12-18	08:12:00+02	10:01:00+02	VST003317	USR0373	GYM001
2024-01-22	16:55:00+02	19:54:00+02	VST003318	USR0299	GYM006
2023-08-16	15:09:00+02	17:30:00+02	VST003319	USR0338	GYM001
2024-10-01	09:55:00+02	12:36:00+02	VST003320	USR0151	GYM003
2024-04-19	15:04:00+02	17:05:00+02	VST003321	USR0205	GYM006
2024-12-24	10:33:00+02	12:22:00+02	VST003322	USR0320	GYM003
2023-07-26	10:31:00+02	13:30:00+02	VST003323	USR0255	GYM004
2023-11-14	17:40:00+02	20:28:00+02	VST003324	USR0489	GYM004
2024-07-10	17:56:00+02	19:03:00+02	VST003325	USR0137	GYM004
2024-09-08	09:42:00+02	10:49:00+02	VST003326	USR0369	GYM001
2023-12-14	09:48:00+02	12:18:00+02	VST003327	USR0135	GYM005
2023-08-22	17:36:00+02	19:25:00+02	VST003328	USR0425	GYM003
2024-12-01	09:43:00+02	11:40:00+02	VST003329	USR0054	GYM004
2023-02-13	12:52:00+02	14:36:00+02	VST003330	USR0065	GYM005
2023-05-22	17:08:00+02	19:12:00+02	VST003331	USR0002	GYM004
2024-10-09	13:52:00+02	14:24:00+02	VST003332	USR0132	GYM004
2023-06-25	15:00:00+02	17:42:00+02	VST003333	USR0334	GYM005
2024-10-15	12:30:00+02	15:30:00+02	VST003334	USR0032	GYM004
2024-03-24	14:32:00+02	15:39:00+02	VST003335	USR0356	GYM001
2024-08-14	16:17:00+02	17:01:00+02	VST003336	USR0386	GYM001
2023-03-23	17:45:00+02	19:15:00+02	VST003337	USR0360	GYM006
2023-05-15	16:04:00+02	18:43:00+02	VST003338	USR0498	GYM001
2024-12-19	08:38:00+02	11:31:00+02	VST003339	USR0243	GYM002
2023-06-26	10:56:00+02	11:39:00+02	VST003340	USR0192	GYM006
2024-01-18	12:42:00+02	15:00:00+02	VST003341	USR0142	GYM004
2023-08-31	14:52:00+02	16:50:00+02	VST003342	USR0148	GYM002
2024-07-20	10:27:00+02	11:47:00+02	VST003343	USR0089	GYM003
2023-05-21	14:51:00+02	16:12:00+02	VST003344	USR0490	GYM005
2024-04-01	08:39:00+02	10:00:00+02	VST003345	USR0049	GYM003
2024-03-15	14:45:00+02	15:32:00+02	VST003346	USR0136	GYM002
2023-02-25	13:39:00+02	15:36:00+02	VST003347	USR0476	GYM001
2024-06-10	12:03:00+02	13:21:00+02	VST003348	USR0191	GYM004
2024-11-27	08:50:00+02	11:21:00+02	VST003349	USR0430	GYM006
2024-02-23	16:06:00+02	18:35:00+02	VST003350	USR0149	GYM004
2023-03-29	12:35:00+02	14:29:00+02	VST003351	USR0087	GYM001
2024-08-31	14:21:00+02	17:19:00+02	VST003352	USR0416	GYM004
2024-10-17	08:20:00+02	11:14:00+02	VST003353	USR0008	GYM005
2023-01-08	13:45:00+02	15:40:00+02	VST003354	USR0223	GYM005
2024-04-21	13:10:00+02	14:56:00+02	VST003355	USR0357	GYM005
2023-08-03	13:18:00+02	15:35:00+02	VST003356	USR0016	GYM003
2024-11-15	12:47:00+02	14:41:00+02	VST003357	USR0296	GYM001
2024-07-05	16:23:00+02	17:34:00+02	VST003358	USR0106	GYM005
2024-05-11	09:40:00+02	10:36:00+02	VST003359	USR0283	GYM002
2024-11-24	11:53:00+02	14:19:00+02	VST003360	USR0104	GYM005
2024-05-17	10:17:00+02	10:57:00+02	VST003361	USR0361	GYM006
2024-11-29	13:07:00+02	15:43:00+02	VST003362	USR0146	GYM003
2023-09-02	15:33:00+02	16:59:00+02	VST003363	USR0035	GYM002
2024-04-22	13:28:00+02	13:58:00+02	VST003364	USR0113	GYM001
2023-11-05	12:35:00+02	14:02:00+02	VST003365	USR0308	GYM001
2023-08-19	15:06:00+02	16:34:00+02	VST003366	USR0399	GYM006
2024-01-18	09:31:00+02	12:00:00+02	VST003367	USR0447	GYM005
2023-06-04	11:12:00+02	12:36:00+02	VST003368	USR0053	GYM002
2023-06-24	15:32:00+02	17:03:00+02	VST003369	USR0347	GYM006
2023-04-25	11:36:00+02	14:09:00+02	VST003370	USR0081	GYM002
2024-01-25	14:56:00+02	16:50:00+02	VST003371	USR0104	GYM005
2023-11-07	16:16:00+02	18:22:00+02	VST003372	USR0322	GYM005
2023-10-27	16:48:00+02	18:10:00+02	VST003373	USR0369	GYM004
2023-01-18	14:22:00+02	16:34:00+02	VST003374	USR0242	GYM004
2023-01-12	08:57:00+02	10:14:00+02	VST003375	USR0031	GYM005
2024-02-08	16:47:00+02	17:18:00+02	VST003376	USR0317	GYM003
2024-12-04	10:42:00+02	12:44:00+02	VST003377	USR0192	GYM006
2023-08-20	09:07:00+02	09:39:00+02	VST003378	USR0357	GYM004
2024-08-27	13:18:00+02	14:06:00+02	VST003379	USR0361	GYM005
2024-12-30	16:38:00+02	18:39:00+02	VST003380	USR0233	GYM002
2023-10-05	14:53:00+02	15:30:00+02	VST003381	USR0098	GYM006
2023-12-19	10:18:00+02	13:10:00+02	VST003382	USR0034	GYM004
2023-10-30	16:56:00+02	17:55:00+02	VST003383	USR0243	GYM003
2024-06-24	17:42:00+02	18:48:00+02	VST003384	USR0439	GYM006
2024-04-14	08:29:00+02	10:13:00+02	VST003385	USR0059	GYM006
2023-03-18	10:57:00+02	13:19:00+02	VST003386	USR0259	GYM001
2024-06-04	11:17:00+02	12:36:00+02	VST003387	USR0017	GYM002
2023-01-24	11:25:00+02	14:24:00+02	VST003388	USR0078	GYM003
2023-01-15	08:59:00+02	11:01:00+02	VST003389	USR0206	GYM003
2024-11-06	12:15:00+02	12:56:00+02	VST003390	USR0302	GYM003
2024-06-08	08:33:00+02	09:10:00+02	VST003391	USR0166	GYM002
2023-12-13	15:47:00+02	17:07:00+02	VST003392	USR0291	GYM003
2023-06-21	08:51:00+02	10:11:00+02	VST003393	USR0385	GYM001
2023-11-23	14:09:00+02	15:51:00+02	VST003394	USR0112	GYM004
2024-12-12	11:23:00+02	12:37:00+02	VST003395	USR0413	GYM002
2024-04-29	12:40:00+02	14:06:00+02	VST003396	USR0388	GYM003
2024-05-03	14:17:00+02	15:54:00+02	VST003397	USR0317	GYM005
2024-04-06	15:55:00+02	17:09:00+02	VST003398	USR0353	GYM004
2024-01-13	16:37:00+02	18:33:00+02	VST003399	USR0145	GYM006
2024-08-10	14:46:00+02	17:37:00+02	VST003400	USR0156	GYM002
2023-06-13	10:06:00+02	11:38:00+02	VST003401	USR0178	GYM005
2024-01-07	08:31:00+02	09:46:00+02	VST003402	USR0346	GYM006
2024-07-26	12:07:00+02	13:27:00+02	VST003403	USR0136	GYM005
2024-02-28	14:21:00+02	14:56:00+02	VST003404	USR0418	GYM003
2024-04-21	16:20:00+02	17:35:00+02	VST003405	USR0315	GYM002
2024-01-17	15:36:00+02	17:13:00+02	VST003406	USR0018	GYM003
2023-06-04	11:01:00+02	11:56:00+02	VST003407	USR0351	GYM006
2023-09-14	16:05:00+02	16:40:00+02	VST003408	USR0443	GYM001
2024-11-04	18:00:00+02	19:05:00+02	VST003409	USR0155	GYM005
2023-03-09	17:24:00+02	19:31:00+02	VST003410	USR0272	GYM001
2023-12-10	13:58:00+02	14:56:00+02	VST003411	USR0266	GYM006
2023-10-04	13:52:00+02	15:48:00+02	VST003412	USR0360	GYM003
2024-11-03	10:47:00+02	12:10:00+02	VST003413	USR0332	GYM004
2024-01-26	12:24:00+02	14:12:00+02	VST003414	USR0406	GYM005
2024-03-24	09:32:00+02	11:58:00+02	VST003415	USR0016	GYM004
2023-09-16	12:51:00+02	14:22:00+02	VST003416	USR0012	GYM002
2023-11-03	08:28:00+02	10:32:00+02	VST003417	USR0075	GYM005
2023-04-05	14:35:00+02	16:40:00+02	VST003418	USR0212	GYM001
2024-04-08	08:50:00+02	10:03:00+02	VST003419	USR0179	GYM004
2023-09-03	10:46:00+02	13:30:00+02	VST003420	USR0129	GYM006
2024-09-26	17:45:00+02	20:06:00+02	VST003421	USR0283	GYM002
2023-07-06	11:39:00+02	12:25:00+02	VST003422	USR0195	GYM005
2024-01-08	11:46:00+02	12:46:00+02	VST003423	USR0268	GYM006
2024-07-25	11:50:00+02	12:56:00+02	VST003424	USR0030	GYM002
2024-02-10	11:31:00+02	12:34:00+02	VST003425	USR0009	GYM001
2024-02-12	12:35:00+02	13:53:00+02	VST003426	USR0309	GYM006
2023-05-05	14:59:00+02	16:18:00+02	VST003427	USR0445	GYM005
2023-12-03	16:45:00+02	19:31:00+02	VST003428	USR0310	GYM002
2023-12-07	08:20:00+02	10:26:00+02	VST003429	USR0165	GYM003
2024-07-16	08:09:00+02	10:14:00+02	VST003430	USR0193	GYM005
2023-06-27	16:05:00+02	17:56:00+02	VST003431	USR0426	GYM005
2024-10-12	10:15:00+02	12:34:00+02	VST003432	USR0305	GYM005
2023-06-19	10:57:00+02	12:29:00+02	VST003433	USR0260	GYM005
2023-02-08	08:08:00+02	08:49:00+02	VST003434	USR0192	GYM003
2023-03-10	11:49:00+02	14:49:00+02	VST003435	USR0079	GYM006
2023-08-24	12:18:00+02	13:36:00+02	VST003436	USR0179	GYM006
2024-07-13	13:12:00+02	15:59:00+02	VST003437	USR0091	GYM006
2024-01-16	12:41:00+02	14:26:00+02	VST003438	USR0456	GYM001
2023-02-26	15:13:00+02	16:21:00+02	VST003439	USR0444	GYM003
2023-10-04	14:25:00+02	16:18:00+02	VST003440	USR0215	GYM003
2023-04-09	13:57:00+02	15:30:00+02	VST003441	USR0079	GYM002
2024-06-10	15:50:00+02	16:33:00+02	VST003442	USR0475	GYM004
2023-11-21	12:18:00+02	13:59:00+02	VST003443	USR0415	GYM006
2024-04-05	11:43:00+02	12:45:00+02	VST003444	USR0103	GYM004
2023-06-28	15:57:00+02	18:37:00+02	VST003445	USR0111	GYM002
2024-07-27	13:09:00+02	16:08:00+02	VST003446	USR0456	GYM003
2023-04-29	16:53:00+02	19:28:00+02	VST003447	USR0478	GYM002
2024-04-13	14:46:00+02	16:09:00+02	VST003448	USR0314	GYM005
2024-07-02	17:58:00+02	18:48:00+02	VST003449	USR0247	GYM002
2024-10-07	09:44:00+02	12:14:00+02	VST003450	USR0234	GYM002
2024-03-30	08:07:00+02	08:53:00+02	VST003451	USR0082	GYM005
2023-01-26	16:43:00+02	17:55:00+02	VST003452	USR0132	GYM004
2024-05-04	14:23:00+02	17:03:00+02	VST003453	USR0495	GYM005
2023-01-08	17:34:00+02	19:43:00+02	VST003454	USR0235	GYM001
2024-05-30	12:49:00+02	15:29:00+02	VST003455	USR0278	GYM002
2024-06-16	13:05:00+02	15:10:00+02	VST003456	USR0387	GYM002
2023-05-29	09:50:00+02	12:27:00+02	VST003457	USR0335	GYM004
2024-05-02	16:13:00+02	18:55:00+02	VST003458	USR0099	GYM003
2023-01-25	09:05:00+02	11:33:00+02	VST003459	USR0431	GYM005
2024-10-16	13:44:00+02	14:59:00+02	VST003460	USR0038	GYM003
2024-07-08	12:43:00+02	14:35:00+02	VST003461	USR0161	GYM001
2024-02-29	13:32:00+02	15:37:00+02	VST003462	USR0462	GYM005
2023-10-20	12:43:00+02	15:27:00+02	VST003463	USR0432	GYM001
2023-07-04	12:27:00+02	15:00:00+02	VST003464	USR0449	GYM001
2024-07-07	13:05:00+02	15:41:00+02	VST003465	USR0117	GYM001
2024-03-06	11:12:00+02	13:43:00+02	VST003466	USR0241	GYM006
2024-08-26	10:33:00+02	12:11:00+02	VST003467	USR0026	GYM005
2023-11-13	16:49:00+02	19:47:00+02	VST003468	USR0136	GYM005
2024-02-02	12:06:00+02	14:18:00+02	VST003469	USR0050	GYM006
2023-11-20	08:58:00+02	11:57:00+02	VST003470	USR0464	GYM004
2024-07-18	14:53:00+02	15:32:00+02	VST003471	USR0294	GYM006
2024-08-18	13:27:00+02	14:50:00+02	VST003472	USR0394	GYM002
2024-06-29	10:23:00+02	11:49:00+02	VST003473	USR0298	GYM003
2023-03-17	08:26:00+02	09:47:00+02	VST003474	USR0293	GYM003
2024-12-09	16:29:00+02	18:54:00+02	VST003475	USR0154	GYM001
2024-04-30	13:02:00+02	14:32:00+02	VST003476	USR0220	GYM005
2023-03-29	12:25:00+02	14:36:00+02	VST003477	USR0140	GYM005
2023-08-20	15:08:00+02	16:33:00+02	VST003478	USR0468	GYM001
2023-01-07	14:54:00+02	16:42:00+02	VST003479	USR0049	GYM002
2024-07-03	14:37:00+02	16:55:00+02	VST003480	USR0142	GYM003
2023-02-21	08:36:00+02	10:42:00+02	VST003481	USR0046	GYM006
2024-10-16	17:57:00+02	20:53:00+02	VST003482	USR0163	GYM004
2024-01-31	17:45:00+02	18:55:00+02	VST003483	USR0285	GYM002
2023-08-09	11:14:00+02	13:19:00+02	VST003484	USR0268	GYM005
2024-03-03	13:51:00+02	15:26:00+02	VST003485	USR0116	GYM001
2023-05-23	11:47:00+02	14:37:00+02	VST003486	USR0082	GYM003
2023-12-29	17:07:00+02	17:58:00+02	VST003487	USR0044	GYM001
2024-01-17	16:07:00+02	17:11:00+02	VST003488	USR0194	GYM005
2024-07-14	14:07:00+02	14:58:00+02	VST003489	USR0258	GYM001
2023-10-04	16:39:00+02	18:24:00+02	VST003490	USR0443	GYM006
2023-09-28	13:07:00+02	15:30:00+02	VST003491	USR0273	GYM003
2023-01-14	10:54:00+02	13:36:00+02	VST003492	USR0394	GYM001
2023-10-25	17:31:00+02	19:31:00+02	VST003493	USR0274	GYM003
2024-04-08	11:05:00+02	12:33:00+02	VST003494	USR0278	GYM001
2024-06-10	13:00:00+02	15:59:00+02	VST003495	USR0083	GYM001
2023-08-22	09:39:00+02	10:19:00+02	VST003496	USR0058	GYM003
2024-07-28	16:02:00+02	18:31:00+02	VST003497	USR0053	GYM006
2024-12-08	10:11:00+02	12:52:00+02	VST003498	USR0001	GYM001
2023-01-27	12:24:00+02	14:20:00+02	VST003499	USR0216	GYM006
2024-04-15	17:32:00+02	19:51:00+02	VST003500	USR0317	GYM002
2023-04-03	11:07:00+02	13:32:00+02	VST003501	USR0228	GYM004
2024-09-08	13:43:00+02	16:12:00+02	VST003502	USR0473	GYM002
2023-11-05	09:31:00+02	11:51:00+02	VST003503	USR0484	GYM004
2023-02-21	11:47:00+02	14:01:00+02	VST003504	USR0254	GYM002
2023-11-15	14:03:00+02	16:07:00+02	VST003505	USR0159	GYM004
2023-06-30	11:48:00+02	14:25:00+02	VST003506	USR0287	GYM001
2024-07-22	13:14:00+02	15:05:00+02	VST003507	USR0066	GYM003
2023-04-30	15:10:00+02	16:49:00+02	VST003508	USR0403	GYM003
2023-02-12	13:39:00+02	15:46:00+02	VST003509	USR0309	GYM005
2024-10-08	14:20:00+02	14:56:00+02	VST003510	USR0460	GYM004
2023-09-17	12:26:00+02	13:41:00+02	VST003511	USR0458	GYM005
2023-07-16	17:59:00+02	20:22:00+02	VST003512	USR0095	GYM006
2024-10-06	13:01:00+02	14:30:00+02	VST003513	USR0493	GYM006
2023-09-12	15:54:00+02	17:31:00+02	VST003514	USR0253	GYM005
2023-12-02	10:00:00+02	10:49:00+02	VST003515	USR0150	GYM004
2024-07-06	16:01:00+02	18:02:00+02	VST003516	USR0023	GYM003
2024-05-16	08:54:00+02	09:45:00+02	VST003517	USR0244	GYM004
2023-09-12	17:57:00+02	19:42:00+02	VST003518	USR0215	GYM006
2024-05-28	17:54:00+02	20:32:00+02	VST003519	USR0399	GYM001
2024-12-07	09:12:00+02	11:53:00+02	VST003520	USR0410	GYM005
2023-08-30	16:03:00+02	18:52:00+02	VST003521	USR0131	GYM005
2023-05-29	11:19:00+02	12:09:00+02	VST003522	USR0343	GYM006
2024-12-10	16:32:00+02	18:12:00+02	VST003523	USR0148	GYM004
2023-10-26	10:02:00+02	11:30:00+02	VST003524	USR0381	GYM005
2024-09-11	14:30:00+02	15:25:00+02	VST003525	USR0109	GYM003
2024-03-28	17:02:00+02	18:02:00+02	VST003526	USR0040	GYM005
2024-01-28	13:05:00+02	13:53:00+02	VST003527	USR0121	GYM004
2023-07-31	15:03:00+02	17:05:00+02	VST003528	USR0295	GYM006
2024-10-29	08:55:00+02	09:34:00+02	VST003529	USR0120	GYM003
2024-06-21	10:34:00+02	13:23:00+02	VST003530	USR0456	GYM003
2024-08-16	10:20:00+02	11:41:00+02	VST003531	USR0018	GYM005
2024-08-17	11:25:00+02	13:20:00+02	VST003532	USR0169	GYM004
2023-05-11	13:50:00+02	15:10:00+02	VST003533	USR0198	GYM005
2023-11-25	14:59:00+02	16:53:00+02	VST003534	USR0411	GYM001
2024-09-03	17:43:00+02	19:17:00+02	VST003535	USR0484	GYM006
2023-09-13	15:48:00+02	17:35:00+02	VST003536	USR0143	GYM001
2024-04-23	10:26:00+02	12:06:00+02	VST003537	USR0037	GYM003
2024-07-14	13:23:00+02	14:41:00+02	VST003538	USR0186	GYM005
2023-03-04	11:04:00+02	12:09:00+02	VST003539	USR0261	GYM001
2023-11-07	09:22:00+02	12:11:00+02	VST003540	USR0231	GYM002
2024-02-11	16:19:00+02	17:55:00+02	VST003541	USR0254	GYM001
2023-04-15	13:40:00+02	14:12:00+02	VST003542	USR0329	GYM005
2024-09-08	11:01:00+02	12:47:00+02	VST003543	USR0391	GYM005
2023-01-15	13:20:00+02	15:02:00+02	VST003544	USR0297	GYM006
2024-11-17	08:59:00+02	10:57:00+02	VST003545	USR0468	GYM001
2023-09-16	08:04:00+02	10:17:00+02	VST003546	USR0010	GYM005
2024-12-23	15:42:00+02	17:55:00+02	VST003547	USR0446	GYM005
2024-02-16	12:40:00+02	15:38:00+02	VST003548	USR0410	GYM006
2023-09-16	11:34:00+02	12:07:00+02	VST003549	USR0324	GYM006
2024-09-05	10:52:00+02	13:22:00+02	VST003550	USR0230	GYM006
2023-09-17	17:50:00+02	20:31:00+02	VST003551	USR0024	GYM006
2024-11-01	10:42:00+02	11:50:00+02	VST003552	USR0078	GYM002
2023-02-14	16:21:00+02	18:32:00+02	VST003553	USR0425	GYM003
2023-11-27	09:30:00+02	10:58:00+02	VST003554	USR0193	GYM005
2023-06-14	10:12:00+02	11:40:00+02	VST003555	USR0401	GYM004
2023-07-12	15:24:00+02	16:47:00+02	VST003556	USR0109	GYM006
2024-06-04	15:19:00+02	17:50:00+02	VST003557	USR0280	GYM003
2024-02-05	14:53:00+02	16:22:00+02	VST003558	USR0411	GYM006
2024-01-09	15:19:00+02	18:01:00+02	VST003559	USR0263	GYM003
2023-03-06	16:08:00+02	19:08:00+02	VST003560	USR0329	GYM004
2024-01-22	14:32:00+02	17:23:00+02	VST003561	USR0363	GYM001
2024-05-09	08:04:00+02	10:33:00+02	VST003562	USR0355	GYM002
2024-11-23	08:38:00+02	11:06:00+02	VST003563	USR0378	GYM005
2024-02-19	17:06:00+02	19:03:00+02	VST003564	USR0268	GYM001
2023-01-30	11:24:00+02	12:15:00+02	VST003565	USR0341	GYM004
2023-09-23	14:22:00+02	16:12:00+02	VST003566	USR0259	GYM002
2023-11-24	08:14:00+02	09:32:00+02	VST003567	USR0335	GYM002
2024-05-06	13:29:00+02	15:48:00+02	VST003568	USR0085	GYM002
2023-08-05	17:03:00+02	19:19:00+02	VST003569	USR0010	GYM004
2023-11-16	11:15:00+02	12:38:00+02	VST003570	USR0289	GYM006
2024-02-03	08:18:00+02	10:40:00+02	VST003571	USR0302	GYM006
2023-04-15	08:04:00+02	10:29:00+02	VST003572	USR0059	GYM006
2024-11-26	12:14:00+02	15:06:00+02	VST003573	USR0308	GYM001
2023-11-26	11:51:00+02	12:28:00+02	VST003574	USR0262	GYM005
2024-10-21	13:52:00+02	15:57:00+02	VST003575	USR0386	GYM002
2024-09-08	13:19:00+02	14:24:00+02	VST003576	USR0285	GYM002
2023-02-16	10:12:00+02	13:09:00+02	VST003577	USR0119	GYM001
2024-08-21	09:45:00+02	10:47:00+02	VST003578	USR0168	GYM006
2024-10-02	14:32:00+02	16:20:00+02	VST003579	USR0353	GYM002
2023-11-10	16:35:00+02	17:07:00+02	VST003580	USR0189	GYM002
2023-05-27	13:13:00+02	15:50:00+02	VST003581	USR0452	GYM004
2024-04-06	10:51:00+02	12:51:00+02	VST003582	USR0251	GYM003
2024-08-06	09:06:00+02	11:02:00+02	VST003583	USR0324	GYM001
2024-04-30	08:46:00+02	10:13:00+02	VST003584	USR0413	GYM001
2024-10-13	13:05:00+02	15:22:00+02	VST003585	USR0229	GYM006
2024-02-14	12:57:00+02	15:15:00+02	VST003586	USR0190	GYM001
2023-01-27	15:46:00+02	17:59:00+02	VST003587	USR0316	GYM006
2023-01-29	16:52:00+02	19:39:00+02	VST003588	USR0124	GYM004
2023-09-28	16:56:00+02	18:42:00+02	VST003589	USR0084	GYM004
2024-11-16	13:45:00+02	15:38:00+02	VST003590	USR0297	GYM005
2024-05-15	15:24:00+02	18:24:00+02	VST003591	USR0215	GYM006
2023-09-10	10:17:00+02	10:52:00+02	VST003592	USR0237	GYM004
2024-01-20	13:50:00+02	16:45:00+02	VST003593	USR0466	GYM006
2023-03-01	16:21:00+02	16:59:00+02	VST003594	USR0113	GYM001
2023-04-17	14:07:00+02	15:12:00+02	VST003595	USR0217	GYM005
2023-08-08	11:12:00+02	12:21:00+02	VST003596	USR0321	GYM003
2024-03-16	10:48:00+02	12:42:00+02	VST003597	USR0246	GYM002
2024-10-19	14:53:00+02	17:48:00+02	VST003598	USR0448	GYM002
2024-07-17	08:19:00+02	11:15:00+02	VST003599	USR0335	GYM005
2024-07-25	11:53:00+02	14:03:00+02	VST003600	USR0319	GYM006
2024-06-29	11:49:00+02	13:56:00+02	VST003601	USR0482	GYM006
2023-04-06	10:14:00+02	11:36:00+02	VST003602	USR0432	GYM006
2023-03-30	11:36:00+02	13:46:00+02	VST003603	USR0404	GYM003
2023-08-19	08:22:00+02	09:08:00+02	VST003604	USR0374	GYM002
2023-10-02	16:36:00+02	19:22:00+02	VST003605	USR0037	GYM005
2023-09-03	10:53:00+02	13:01:00+02	VST003606	USR0064	GYM006
2023-04-21	10:06:00+02	11:24:00+02	VST003607	USR0219	GYM004
2023-08-22	14:15:00+02	16:46:00+02	VST003608	USR0342	GYM001
2023-10-05	08:38:00+02	09:35:00+02	VST003609	USR0499	GYM003
2024-04-21	14:24:00+02	16:18:00+02	VST003610	USR0389	GYM006
2024-02-21	12:21:00+02	15:16:00+02	VST003611	USR0034	GYM002
2024-11-08	17:07:00+02	19:32:00+02	VST003612	USR0039	GYM001
2023-05-08	08:49:00+02	10:36:00+02	VST003613	USR0067	GYM005
2023-08-25	08:49:00+02	09:42:00+02	VST003614	USR0209	GYM006
2024-09-10	09:50:00+02	11:03:00+02	VST003615	USR0318	GYM002
2023-05-08	08:20:00+02	09:16:00+02	VST003616	USR0344	GYM001
2024-12-07	08:49:00+02	11:40:00+02	VST003617	USR0152	GYM004
2024-01-29	09:58:00+02	11:13:00+02	VST003618	USR0387	GYM003
2024-04-19	15:06:00+02	15:44:00+02	VST003619	USR0365	GYM005
2024-10-16	15:34:00+02	18:09:00+02	VST003620	USR0199	GYM002
2024-01-30	14:29:00+02	15:05:00+02	VST003621	USR0089	GYM004
2023-04-21	10:06:00+02	11:23:00+02	VST003622	USR0248	GYM003
2023-03-31	17:20:00+02	18:40:00+02	VST003623	USR0323	GYM003
2023-10-07	12:18:00+02	13:05:00+02	VST003624	USR0079	GYM004
2023-11-29	16:05:00+02	18:13:00+02	VST003625	USR0477	GYM002
2023-08-12	10:36:00+02	12:18:00+02	VST003626	USR0434	GYM003
2023-04-11	11:30:00+02	12:52:00+02	VST003627	USR0285	GYM005
2023-05-12	08:09:00+02	09:38:00+02	VST003628	USR0330	GYM001
2023-01-13	13:08:00+02	14:52:00+02	VST003629	USR0032	GYM005
2024-04-01	15:10:00+02	17:54:00+02	VST003630	USR0087	GYM006
2024-03-16	09:43:00+02	10:30:00+02	VST003631	USR0039	GYM003
2023-04-08	16:52:00+02	19:18:00+02	VST003632	USR0393	GYM001
2023-04-30	12:36:00+02	13:20:00+02	VST003633	USR0101	GYM004
2023-10-20	10:20:00+02	12:24:00+02	VST003634	USR0244	GYM001
2024-12-11	15:08:00+02	17:50:00+02	VST003635	USR0232	GYM001
2023-01-01	09:47:00+02	10:19:00+02	VST003636	USR0398	GYM001
2024-07-25	16:43:00+02	17:56:00+02	VST003637	USR0068	GYM003
2023-09-07	10:00:00+02	11:53:00+02	VST003638	USR0192	GYM006
2024-10-13	12:49:00+02	15:04:00+02	VST003639	USR0404	GYM006
2023-05-29	09:56:00+02	12:06:00+02	VST003640	USR0028	GYM002
2024-01-30	09:48:00+02	10:58:00+02	VST003641	USR0270	GYM006
2023-02-13	16:29:00+02	17:27:00+02	VST003642	USR0428	GYM003
2024-11-28	11:23:00+02	12:26:00+02	VST003643	USR0226	GYM002
2024-09-11	11:24:00+02	14:11:00+02	VST003644	USR0077	GYM004
2023-02-13	12:29:00+02	14:46:00+02	VST003645	USR0223	GYM004
2023-03-19	16:55:00+02	19:27:00+02	VST003646	USR0481	GYM004
2023-08-14	11:26:00+02	12:13:00+02	VST003647	USR0372	GYM004
2023-06-11	14:06:00+02	16:15:00+02	VST003648	USR0167	GYM004
2023-09-10	14:59:00+02	16:21:00+02	VST003649	USR0284	GYM005
2023-05-12	13:02:00+02	14:05:00+02	VST003650	USR0192	GYM003
2024-03-23	10:44:00+02	12:06:00+02	VST003651	USR0089	GYM002
2024-04-18	08:40:00+02	10:29:00+02	VST003652	USR0032	GYM004
2024-10-17	17:21:00+02	19:41:00+02	VST003653	USR0137	GYM005
2023-04-19	16:28:00+02	18:59:00+02	VST003654	USR0156	GYM006
2024-12-06	11:32:00+02	12:42:00+02	VST003655	USR0250	GYM005
2023-02-04	16:12:00+02	19:09:00+02	VST003656	USR0095	GYM005
2024-04-11	13:38:00+02	15:27:00+02	VST003657	USR0017	GYM003
2023-10-02	12:00:00+02	15:00:00+02	VST003658	USR0117	GYM004
2023-07-06	08:02:00+02	09:23:00+02	VST003659	USR0471	GYM005
2023-08-31	08:13:00+02	10:51:00+02	VST003660	USR0333	GYM005
2023-09-21	09:31:00+02	11:58:00+02	VST003661	USR0311	GYM004
2024-06-05	09:53:00+02	11:33:00+02	VST003662	USR0010	GYM003
2024-11-08	17:47:00+02	19:08:00+02	VST003663	USR0080	GYM005
2024-06-24	16:25:00+02	16:56:00+02	VST003664	USR0134	GYM002
2023-03-28	10:32:00+02	11:38:00+02	VST003665	USR0432	GYM001
2024-06-18	09:32:00+02	11:56:00+02	VST003666	USR0203	GYM006
2023-07-29	16:43:00+02	17:29:00+02	VST003667	USR0116	GYM001
2023-02-15	09:16:00+02	11:28:00+02	VST003668	USR0451	GYM001
2024-04-11	09:43:00+02	11:16:00+02	VST003669	USR0220	GYM003
2024-06-23	12:22:00+02	15:06:00+02	VST003670	USR0253	GYM005
2023-01-26	11:56:00+02	13:50:00+02	VST003671	USR0169	GYM001
2023-09-23	15:47:00+02	18:42:00+02	VST003672	USR0335	GYM001
2023-06-24	13:03:00+02	15:38:00+02	VST003673	USR0316	GYM006
2024-05-30	12:30:00+02	14:57:00+02	VST003674	USR0205	GYM004
2023-11-07	15:55:00+02	18:23:00+02	VST003675	USR0298	GYM005
2023-11-18	08:51:00+02	11:48:00+02	VST003676	USR0372	GYM005
2024-08-01	09:42:00+02	10:22:00+02	VST003677	USR0248	GYM006
2023-05-15	10:58:00+02	11:51:00+02	VST003678	USR0365	GYM004
2023-02-24	08:40:00+02	10:23:00+02	VST003679	USR0465	GYM005
2024-06-26	12:57:00+02	15:23:00+02	VST003680	USR0071	GYM002
2024-08-08	14:08:00+02	16:06:00+02	VST003681	USR0156	GYM006
2024-06-14	13:20:00+02	15:06:00+02	VST003682	USR0102	GYM003
2023-06-05	15:16:00+02	17:26:00+02	VST003683	USR0013	GYM004
2024-10-29	09:58:00+02	11:12:00+02	VST003684	USR0465	GYM006
2023-05-27	09:37:00+02	11:53:00+02	VST003685	USR0271	GYM001
2024-04-29	08:46:00+02	10:19:00+02	VST003686	USR0292	GYM005
2024-08-21	08:09:00+02	09:24:00+02	VST003687	USR0220	GYM002
2023-01-20	10:21:00+02	12:41:00+02	VST003688	USR0015	GYM002
2023-09-26	10:54:00+02	13:21:00+02	VST003689	USR0238	GYM003
2023-11-29	13:36:00+02	15:44:00+02	VST003690	USR0117	GYM006
2024-07-08	14:06:00+02	15:22:00+02	VST003691	USR0331	GYM002
2024-02-05	15:28:00+02	18:23:00+02	VST003692	USR0056	GYM006
2023-11-02	12:34:00+02	13:28:00+02	VST003693	USR0351	GYM005
2023-01-28	09:35:00+02	11:45:00+02	VST003694	USR0132	GYM005
2024-04-11	14:21:00+02	15:02:00+02	VST003695	USR0483	GYM002
2023-09-17	13:50:00+02	15:21:00+02	VST003696	USR0226	GYM005
2024-06-17	11:07:00+02	12:17:00+02	VST003697	USR0308	GYM006
2023-04-11	09:56:00+02	11:36:00+02	VST003698	USR0475	GYM005
2024-07-04	14:50:00+02	17:37:00+02	VST003699	USR0394	GYM001
2023-12-19	14:49:00+02	16:33:00+02	VST003700	USR0222	GYM006
2023-10-27	15:47:00+02	16:34:00+02	VST003701	USR0173	GYM004
2024-11-12	12:38:00+02	14:03:00+02	VST003702	USR0340	GYM005
2023-10-23	14:34:00+02	17:10:00+02	VST003703	USR0285	GYM005
2023-12-19	16:09:00+02	18:24:00+02	VST003704	USR0309	GYM006
2023-05-10	15:11:00+02	18:02:00+02	VST003705	USR0157	GYM003
2023-06-05	10:50:00+02	11:51:00+02	VST003706	USR0151	GYM004
2023-03-15	09:55:00+02	11:59:00+02	VST003707	USR0185	GYM004
2023-12-08	10:15:00+02	11:04:00+02	VST003708	USR0178	GYM004
2024-04-09	09:00:00+02	09:56:00+02	VST003709	USR0021	GYM002
2023-03-31	10:43:00+02	13:22:00+02	VST003710	USR0112	GYM001
2024-08-01	09:46:00+02	11:39:00+02	VST003711	USR0171	GYM001
2024-03-30	15:06:00+02	17:20:00+02	VST003712	USR0138	GYM003
2024-12-12	16:14:00+02	18:39:00+02	VST003713	USR0233	GYM004
2023-11-28	17:42:00+02	18:54:00+02	VST003714	USR0332	GYM004
2023-12-14	15:28:00+02	17:02:00+02	VST003715	USR0030	GYM005
2023-08-21	11:05:00+02	12:28:00+02	VST003716	USR0381	GYM006
2024-08-20	14:28:00+02	17:07:00+02	VST003717	USR0307	GYM002
2023-04-12	14:07:00+02	14:48:00+02	VST003718	USR0161	GYM002
2024-04-25	08:29:00+02	10:57:00+02	VST003719	USR0402	GYM003
2023-08-02	10:13:00+02	10:49:00+02	VST003720	USR0078	GYM001
2023-04-18	16:14:00+02	17:02:00+02	VST003721	USR0278	GYM004
2023-06-14	16:19:00+02	18:47:00+02	VST003722	USR0320	GYM006
2024-08-25	09:55:00+02	12:02:00+02	VST003723	USR0021	GYM003
2024-12-04	15:01:00+02	16:58:00+02	VST003724	USR0385	GYM002
2023-12-01	15:31:00+02	17:43:00+02	VST003725	USR0497	GYM002
2023-03-27	08:47:00+02	10:06:00+02	VST003726	USR0363	GYM002
2024-02-28	09:04:00+02	11:15:00+02	VST003727	USR0372	GYM004
2024-09-04	12:27:00+02	13:06:00+02	VST003728	USR0380	GYM004
2023-12-30	13:21:00+02	13:53:00+02	VST003729	USR0143	GYM004
2023-03-01	08:12:00+02	09:46:00+02	VST003730	USR0036	GYM005
2024-04-26	16:57:00+02	17:56:00+02	VST003731	USR0303	GYM001
2023-09-07	17:50:00+02	18:54:00+02	VST003732	USR0438	GYM002
2024-07-13	17:38:00+02	19:31:00+02	VST003733	USR0214	GYM002
2023-04-27	11:49:00+02	14:17:00+02	VST003734	USR0032	GYM005
2024-06-28	13:46:00+02	16:20:00+02	VST003735	USR0186	GYM002
2023-02-13	16:51:00+02	19:19:00+02	VST003736	USR0174	GYM002
2024-05-23	16:55:00+02	17:42:00+02	VST003737	USR0054	GYM004
2023-06-14	09:37:00+02	10:28:00+02	VST003738	USR0161	GYM004
2024-01-03	15:23:00+02	18:13:00+02	VST003739	USR0250	GYM001
2023-10-19	12:14:00+02	13:46:00+02	VST003740	USR0489	GYM002
2023-10-13	16:13:00+02	18:35:00+02	VST003741	USR0251	GYM003
2023-07-23	13:54:00+02	14:59:00+02	VST003742	USR0423	GYM002
2024-11-14	14:34:00+02	17:04:00+02	VST003743	USR0279	GYM002
2024-06-07	10:32:00+02	12:13:00+02	VST003744	USR0171	GYM001
2023-05-01	17:31:00+02	18:42:00+02	VST003745	USR0183	GYM003
2024-10-25	08:55:00+02	10:08:00+02	VST003746	USR0002	GYM002
2024-10-25	08:11:00+02	08:45:00+02	VST003747	USR0194	GYM006
2023-07-07	10:40:00+02	11:35:00+02	VST003748	USR0166	GYM006
2023-01-13	16:37:00+02	17:52:00+02	VST003749	USR0247	GYM003
2024-08-25	16:00:00+02	17:45:00+02	VST003750	USR0499	GYM006
2023-07-19	16:27:00+02	17:28:00+02	VST003751	USR0413	GYM004
2024-08-08	10:49:00+02	13:35:00+02	VST003752	USR0244	GYM004
2024-03-31	09:16:00+02	11:26:00+02	VST003753	USR0110	GYM003
2024-03-23	16:23:00+02	17:36:00+02	VST003754	USR0380	GYM002
2023-03-12	13:28:00+02	14:17:00+02	VST003755	USR0323	GYM003
2024-08-12	12:06:00+02	12:38:00+02	VST003756	USR0487	GYM006
2023-05-10	13:38:00+02	15:17:00+02	VST003757	USR0071	GYM003
2023-02-12	12:44:00+02	13:53:00+02	VST003758	USR0164	GYM006
2024-06-03	08:51:00+02	11:13:00+02	VST003759	USR0285	GYM004
2023-01-13	16:39:00+02	18:40:00+02	VST003760	USR0375	GYM003
2024-12-25	11:48:00+02	13:03:00+02	VST003761	USR0421	GYM005
2024-09-14	17:23:00+02	18:48:00+02	VST003762	USR0113	GYM006
2024-06-18	14:27:00+02	15:05:00+02	VST003763	USR0228	GYM005
2023-10-29	14:52:00+02	17:38:00+02	VST003764	USR0471	GYM004
2024-06-10	12:00:00+02	13:25:00+02	VST003765	USR0301	GYM002
2024-10-03	09:20:00+02	11:43:00+02	VST003766	USR0016	GYM006
2024-07-26	15:50:00+02	16:32:00+02	VST003767	USR0496	GYM002
2023-04-25	15:34:00+02	18:17:00+02	VST003768	USR0031	GYM004
2024-04-04	17:46:00+02	18:42:00+02	VST003769	USR0162	GYM002
2024-05-19	15:38:00+02	17:47:00+02	VST003770	USR0306	GYM006
2023-11-04	09:30:00+02	11:18:00+02	VST003771	USR0193	GYM001
2023-11-21	16:30:00+02	18:53:00+02	VST003772	USR0210	GYM006
2024-08-01	15:37:00+02	16:20:00+02	VST003773	USR0378	GYM006
2023-06-24	13:23:00+02	13:54:00+02	VST003774	USR0446	GYM005
2024-05-28	10:01:00+02	10:43:00+02	VST003775	USR0232	GYM001
2023-06-21	16:29:00+02	18:35:00+02	VST003776	USR0427	GYM001
2024-05-16	08:18:00+02	09:39:00+02	VST003777	USR0184	GYM001
2023-11-30	09:45:00+02	11:18:00+02	VST003778	USR0015	GYM006
2023-10-11	14:53:00+02	16:58:00+02	VST003779	USR0432	GYM004
2024-04-19	15:02:00+02	16:33:00+02	VST003780	USR0305	GYM001
2023-02-23	08:36:00+02	09:57:00+02	VST003781	USR0209	GYM003
2024-04-02	17:30:00+02	18:23:00+02	VST003782	USR0172	GYM002
2024-08-01	17:22:00+02	17:56:00+02	VST003783	USR0266	GYM004
2024-02-24	08:00:00+02	10:17:00+02	VST003784	USR0020	GYM003
2024-09-05	09:33:00+02	10:10:00+02	VST003785	USR0070	GYM006
2024-09-23	13:11:00+02	13:44:00+02	VST003786	USR0008	GYM006
2024-12-03	16:40:00+02	18:36:00+02	VST003787	USR0429	GYM003
2024-02-13	17:35:00+02	18:54:00+02	VST003788	USR0034	GYM005
2023-10-31	11:31:00+02	12:17:00+02	VST003789	USR0224	GYM005
2024-07-12	15:47:00+02	17:13:00+02	VST003790	USR0179	GYM003
2023-08-10	13:49:00+02	14:43:00+02	VST003791	USR0246	GYM005
2024-06-16	14:12:00+02	15:24:00+02	VST003792	USR0490	GYM002
2023-06-07	08:55:00+02	10:07:00+02	VST003793	USR0260	GYM002
2023-12-14	11:48:00+02	12:29:00+02	VST003794	USR0108	GYM006
2023-06-08	15:45:00+02	18:01:00+02	VST003795	USR0242	GYM005
2023-08-23	13:39:00+02	16:20:00+02	VST003796	USR0423	GYM001
2024-10-23	17:33:00+02	18:30:00+02	VST003797	USR0468	GYM003
2024-02-09	16:04:00+02	17:57:00+02	VST003798	USR0024	GYM002
2023-09-14	14:12:00+02	16:04:00+02	VST003799	USR0216	GYM005
2024-11-07	15:43:00+02	18:36:00+02	VST003800	USR0055	GYM005
2024-08-11	09:56:00+02	11:14:00+02	VST003801	USR0026	GYM002
2024-08-19	09:39:00+02	11:02:00+02	VST003802	USR0281	GYM002
2024-07-11	11:47:00+02	14:35:00+02	VST003803	USR0292	GYM001
2023-02-16	08:02:00+02	10:13:00+02	VST003804	USR0327	GYM005
2023-08-01	13:49:00+02	16:08:00+02	VST003805	USR0458	GYM005
2024-04-23	14:03:00+02	15:03:00+02	VST003806	USR0186	GYM004
2024-05-01	12:58:00+02	14:27:00+02	VST003807	USR0495	GYM006
2024-07-24	17:20:00+02	18:44:00+02	VST003808	USR0012	GYM001
2024-07-19	16:54:00+02	17:51:00+02	VST003809	USR0129	GYM002
2023-12-08	14:22:00+02	16:23:00+02	VST003810	USR0372	GYM002
2024-06-07	09:48:00+02	11:40:00+02	VST003811	USR0434	GYM003
2024-12-04	08:46:00+02	10:00:00+02	VST003812	USR0409	GYM006
2024-05-17	10:48:00+02	11:21:00+02	VST003813	USR0208	GYM002
2023-01-06	16:24:00+02	18:36:00+02	VST003814	USR0133	GYM005
2023-05-24	10:23:00+02	12:13:00+02	VST003815	USR0339	GYM002
2023-09-18	14:59:00+02	15:32:00+02	VST003816	USR0196	GYM005
2024-08-07	09:49:00+02	11:58:00+02	VST003817	USR0262	GYM005
2024-11-16	12:20:00+02	13:44:00+02	VST003818	USR0282	GYM001
2023-08-20	11:20:00+02	13:47:00+02	VST003819	USR0369	GYM002
2023-09-27	11:12:00+02	12:38:00+02	VST003820	USR0103	GYM001
2024-03-22	10:03:00+02	10:49:00+02	VST003821	USR0120	GYM006
2023-08-10	14:42:00+02	16:23:00+02	VST003822	USR0183	GYM005
2023-02-21	11:40:00+02	13:44:00+02	VST003823	USR0423	GYM006
2023-04-26	15:48:00+02	16:29:00+02	VST003824	USR0009	GYM002
2024-06-21	11:15:00+02	12:02:00+02	VST003825	USR0045	GYM006
2024-07-18	13:46:00+02	15:11:00+02	VST003826	USR0244	GYM006
2024-06-24	09:50:00+02	12:05:00+02	VST003827	USR0270	GYM002
2023-01-19	15:04:00+02	16:51:00+02	VST003828	USR0112	GYM001
2024-01-27	08:47:00+02	11:24:00+02	VST003829	USR0055	GYM001
2024-09-20	10:06:00+02	11:02:00+02	VST003830	USR0393	GYM005
2024-09-09	15:41:00+02	18:28:00+02	VST003831	USR0015	GYM005
2024-02-23	15:48:00+02	18:43:00+02	VST003832	USR0037	GYM002
2023-11-05	16:36:00+02	17:49:00+02	VST003833	USR0178	GYM002
2023-07-05	10:17:00+02	11:51:00+02	VST003834	USR0127	GYM004
2023-09-18	16:30:00+02	17:24:00+02	VST003835	USR0117	GYM004
2024-06-11	08:04:00+02	09:57:00+02	VST003836	USR0340	GYM003
2023-09-30	17:03:00+02	19:12:00+02	VST003837	USR0072	GYM005
2023-06-09	08:49:00+02	09:53:00+02	VST003838	USR0352	GYM006
2023-08-12	17:26:00+02	19:21:00+02	VST003839	USR0111	GYM003
2023-09-13	15:23:00+02	16:37:00+02	VST003840	USR0149	GYM003
2023-06-29	17:59:00+02	19:50:00+02	VST003841	USR0185	GYM001
2023-01-20	16:14:00+02	18:47:00+02	VST003842	USR0105	GYM006
2024-09-15	16:40:00+02	17:27:00+02	VST003843	USR0147	GYM001
2024-09-23	11:01:00+02	12:56:00+02	VST003844	USR0221	GYM004
2024-12-06	17:52:00+02	18:26:00+02	VST003845	USR0314	GYM003
2024-04-12	10:57:00+02	13:56:00+02	VST003846	USR0351	GYM004
2024-09-14	10:11:00+02	12:35:00+02	VST003847	USR0374	GYM006
2023-07-29	09:46:00+02	11:53:00+02	VST003848	USR0006	GYM006
2024-05-27	14:36:00+02	17:16:00+02	VST003849	USR0260	GYM005
2023-02-27	13:29:00+02	14:58:00+02	VST003850	USR0299	GYM002
2023-04-03	16:36:00+02	19:14:00+02	VST003851	USR0349	GYM001
2023-08-09	14:33:00+02	17:33:00+02	VST003852	USR0042	GYM005
2024-12-23	15:08:00+02	15:41:00+02	VST003853	USR0259	GYM005
2023-08-20	12:14:00+02	13:43:00+02	VST003854	USR0385	GYM001
2023-12-30	12:40:00+02	13:15:00+02	VST003855	USR0492	GYM001
2024-09-06	14:47:00+02	15:48:00+02	VST003856	USR0439	GYM006
2024-07-15	13:51:00+02	15:40:00+02	VST003857	USR0271	GYM006
2024-01-09	13:01:00+02	14:31:00+02	VST003858	USR0047	GYM003
2024-09-13	15:43:00+02	18:02:00+02	VST003859	USR0085	GYM004
2024-03-31	10:16:00+02	11:48:00+02	VST003860	USR0174	GYM006
2023-03-29	10:21:00+02	11:11:00+02	VST003861	USR0058	GYM005
2023-01-20	15:02:00+02	15:47:00+02	VST003862	USR0479	GYM003
2023-01-14	16:44:00+02	17:49:00+02	VST003863	USR0199	GYM003
2023-05-13	13:06:00+02	15:11:00+02	VST003864	USR0209	GYM005
2023-02-03	17:20:00+02	19:57:00+02	VST003865	USR0248	GYM006
2023-07-27	13:21:00+02	15:06:00+02	VST003866	USR0211	GYM005
2023-07-18	17:26:00+02	18:47:00+02	VST003867	USR0039	GYM002
2024-08-14	11:42:00+02	12:50:00+02	VST003868	USR0252	GYM006
2024-08-05	11:25:00+02	13:31:00+02	VST003869	USR0131	GYM004
2023-06-04	11:34:00+02	12:56:00+02	VST003870	USR0414	GYM005
2024-08-12	12:57:00+02	13:36:00+02	VST003871	USR0291	GYM006
2023-03-19	13:53:00+02	15:23:00+02	VST003872	USR0250	GYM001
2023-06-21	10:15:00+02	12:38:00+02	VST003873	USR0441	GYM002
2023-10-16	11:02:00+02	12:56:00+02	VST003874	USR0413	GYM004
2024-06-28	16:35:00+02	17:39:00+02	VST003875	USR0434	GYM006
2024-02-24	17:15:00+02	18:56:00+02	VST003876	USR0446	GYM001
2023-01-07	13:30:00+02	15:21:00+02	VST003877	USR0052	GYM006
2023-06-09	09:58:00+02	10:38:00+02	VST003878	USR0374	GYM001
2023-08-28	14:00:00+02	16:43:00+02	VST003879	USR0014	GYM004
2024-02-27	17:35:00+02	19:51:00+02	VST003880	USR0419	GYM002
2024-06-19	16:11:00+02	17:54:00+02	VST003881	USR0156	GYM001
2024-12-26	17:56:00+02	18:32:00+02	VST003882	USR0442	GYM003
2023-03-11	17:44:00+02	19:12:00+02	VST003883	USR0030	GYM004
2023-08-04	15:07:00+02	17:01:00+02	VST003884	USR0090	GYM004
2023-04-14	17:06:00+02	19:03:00+02	VST003885	USR0391	GYM005
2024-12-27	12:52:00+02	14:24:00+02	VST003886	USR0167	GYM002
2023-02-23	15:12:00+02	16:34:00+02	VST003887	USR0351	GYM003
2023-11-26	08:13:00+02	11:01:00+02	VST003888	USR0069	GYM003
2023-07-22	16:55:00+02	17:38:00+02	VST003889	USR0163	GYM005
2023-10-15	09:49:00+02	11:22:00+02	VST003890	USR0242	GYM001
2023-02-14	08:25:00+02	09:51:00+02	VST003891	USR0495	GYM001
2023-07-17	14:30:00+02	16:37:00+02	VST003892	USR0383	GYM003
2023-08-04	10:28:00+02	13:11:00+02	VST003893	USR0052	GYM002
2024-04-25	08:54:00+02	10:46:00+02	VST003894	USR0142	GYM001
2023-11-05	08:57:00+02	10:13:00+02	VST003895	USR0063	GYM004
2024-03-10	11:24:00+02	13:47:00+02	VST003896	USR0292	GYM006
2023-11-28	12:33:00+02	13:04:00+02	VST003897	USR0091	GYM005
2024-11-26	10:44:00+02	11:30:00+02	VST003898	USR0152	GYM002
2023-01-27	12:53:00+02	15:28:00+02	VST003899	USR0424	GYM001
2023-06-15	12:16:00+02	13:03:00+02	VST003900	USR0157	GYM006
2023-11-14	10:29:00+02	11:48:00+02	VST003901	USR0309	GYM003
2023-10-01	09:03:00+02	09:46:00+02	VST003902	USR0365	GYM005
2024-01-18	13:02:00+02	14:08:00+02	VST003903	USR0150	GYM001
2023-12-31	11:28:00+02	12:50:00+02	VST003904	USR0328	GYM003
2023-04-13	17:14:00+02	18:16:00+02	VST003905	USR0271	GYM001
2024-05-17	08:33:00+02	09:26:00+02	VST003906	USR0369	GYM005
2024-01-08	14:07:00+02	15:21:00+02	VST003907	USR0069	GYM004
2024-09-07	15:43:00+02	18:33:00+02	VST003908	USR0116	GYM004
2023-09-02	09:44:00+02	11:06:00+02	VST003909	USR0192	GYM006
2023-06-18	17:35:00+02	19:05:00+02	VST003910	USR0004	GYM003
2024-09-19	11:49:00+02	14:28:00+02	VST003911	USR0075	GYM004
2024-10-14	17:34:00+02	18:24:00+02	VST003912	USR0402	GYM005
2024-02-22	14:38:00+02	16:57:00+02	VST003913	USR0298	GYM003
2023-12-22	12:03:00+02	14:32:00+02	VST003914	USR0241	GYM001
2024-04-22	16:43:00+02	18:32:00+02	VST003915	USR0030	GYM002
2023-05-05	12:54:00+02	14:06:00+02	VST003916	USR0143	GYM001
2024-06-20	08:48:00+02	10:08:00+02	VST003917	USR0326	GYM005
2024-12-06	14:30:00+02	16:02:00+02	VST003918	USR0183	GYM006
2024-09-03	14:36:00+02	16:54:00+02	VST003919	USR0437	GYM003
2024-02-06	15:06:00+02	16:21:00+02	VST003920	USR0016	GYM001
2024-05-31	13:20:00+02	14:53:00+02	VST003921	USR0111	GYM003
2024-06-14	17:25:00+02	19:12:00+02	VST003922	USR0360	GYM004
2024-11-12	08:55:00+02	10:38:00+02	VST003923	USR0201	GYM002
2023-09-11	08:13:00+02	11:10:00+02	VST003924	USR0107	GYM005
2023-05-01	12:17:00+02	14:41:00+02	VST003925	USR0379	GYM001
2023-02-01	11:27:00+02	12:48:00+02	VST003926	USR0162	GYM002
2024-10-22	15:33:00+02	17:12:00+02	VST003927	USR0283	GYM005
2023-02-06	11:50:00+02	14:23:00+02	VST003928	USR0269	GYM005
2024-11-19	14:16:00+02	15:06:00+02	VST003929	USR0484	GYM006
2023-12-08	17:19:00+02	19:21:00+02	VST003930	USR0155	GYM004
2023-01-13	11:21:00+02	13:32:00+02	VST003931	USR0073	GYM006
2023-07-02	11:18:00+02	13:24:00+02	VST003932	USR0197	GYM006
2024-10-18	13:01:00+02	14:13:00+02	VST003933	USR0243	GYM003
2023-09-22	15:39:00+02	18:09:00+02	VST003934	USR0086	GYM003
2023-03-29	11:01:00+02	13:23:00+02	VST003935	USR0287	GYM002
2024-04-06	09:16:00+02	11:34:00+02	VST003936	USR0259	GYM004
2023-02-15	11:11:00+02	13:50:00+02	VST003937	USR0286	GYM005
2024-01-27	10:57:00+02	13:17:00+02	VST003938	USR0149	GYM004
2023-04-29	16:46:00+02	17:55:00+02	VST003939	USR0355	GYM004
2024-06-14	10:02:00+02	12:35:00+02	VST003940	USR0390	GYM002
2024-03-22	14:26:00+02	15:01:00+02	VST003941	USR0476	GYM003
2024-08-28	08:41:00+02	10:48:00+02	VST003942	USR0416	GYM004
2023-02-15	15:18:00+02	17:37:00+02	VST003943	USR0426	GYM004
2024-05-22	12:45:00+02	13:36:00+02	VST003944	USR0485	GYM004
2024-07-11	17:29:00+02	19:15:00+02	VST003945	USR0190	GYM001
2024-06-09	12:30:00+02	15:17:00+02	VST003946	USR0217	GYM004
2024-08-19	10:13:00+02	11:22:00+02	VST003947	USR0416	GYM004
2023-01-03	10:44:00+02	13:35:00+02	VST003948	USR0355	GYM005
2023-01-28	17:58:00+02	19:12:00+02	VST003949	USR0086	GYM006
2024-01-16	12:21:00+02	13:56:00+02	VST003950	USR0216	GYM001
2023-06-06	08:05:00+02	10:12:00+02	VST003951	USR0423	GYM004
2024-05-25	13:38:00+02	16:06:00+02	VST003952	USR0320	GYM006
2023-11-29	15:57:00+02	17:45:00+02	VST003953	USR0118	GYM004
2024-11-17	10:38:00+02	13:04:00+02	VST003954	USR0414	GYM002
2023-04-24	08:40:00+02	10:22:00+02	VST003955	USR0447	GYM002
2024-01-24	10:37:00+02	12:43:00+02	VST003956	USR0370	GYM006
2024-05-01	13:30:00+02	16:23:00+02	VST003957	USR0480	GYM001
2023-09-07	08:52:00+02	11:25:00+02	VST003958	USR0415	GYM005
2024-07-24	13:08:00+02	13:56:00+02	VST003959	USR0087	GYM001
2024-12-15	16:22:00+02	18:17:00+02	VST003960	USR0040	GYM001
2023-11-11	17:46:00+02	18:50:00+02	VST003961	USR0161	GYM002
2023-08-27	17:23:00+02	19:53:00+02	VST003962	USR0191	GYM002
2023-08-22	14:06:00+02	15:26:00+02	VST003963	USR0025	GYM005
2023-10-30	09:14:00+02	10:23:00+02	VST003964	USR0420	GYM004
2024-08-29	13:25:00+02	14:43:00+02	VST003965	USR0152	GYM005
2024-10-14	16:58:00+02	17:29:00+02	VST003966	USR0095	GYM004
2023-11-30	11:45:00+02	12:18:00+02	VST003967	USR0442	GYM006
2023-04-23	11:08:00+02	13:46:00+02	VST003968	USR0423	GYM006
2024-09-12	16:53:00+02	18:58:00+02	VST003969	USR0046	GYM003
2023-12-28	09:09:00+02	11:44:00+02	VST003970	USR0461	GYM002
2023-04-07	16:37:00+02	18:50:00+02	VST003971	USR0138	GYM003
2023-01-16	10:43:00+02	12:59:00+02	VST003972	USR0471	GYM003
2024-07-09	15:05:00+02	17:16:00+02	VST003973	USR0466	GYM002
2024-01-11	17:16:00+02	19:21:00+02	VST003974	USR0288	GYM003
2024-01-25	17:09:00+02	19:17:00+02	VST003975	USR0353	GYM001
2024-09-11	14:53:00+02	17:28:00+02	VST003976	USR0164	GYM004
2023-08-05	09:34:00+02	11:22:00+02	VST003977	USR0412	GYM005
2024-02-03	13:57:00+02	16:57:00+02	VST003978	USR0400	GYM002
2023-09-17	11:46:00+02	12:34:00+02	VST003979	USR0016	GYM001
2023-11-16	11:38:00+02	13:52:00+02	VST003980	USR0018	GYM006
2023-07-15	13:39:00+02	14:18:00+02	VST003981	USR0136	GYM005
2024-04-22	13:39:00+02	14:40:00+02	VST003982	USR0490	GYM005
2024-02-22	14:09:00+02	16:17:00+02	VST003983	USR0464	GYM005
2024-04-19	13:00:00+02	15:54:00+02	VST003984	USR0247	GYM003
2024-08-29	11:43:00+02	12:54:00+02	VST003985	USR0248	GYM003
2024-07-21	17:03:00+02	18:22:00+02	VST003986	USR0331	GYM003
2024-06-27	16:06:00+02	18:27:00+02	VST003987	USR0198	GYM003
2023-08-19	17:34:00+02	19:09:00+02	VST003988	USR0001	GYM001
2024-06-04	08:09:00+02	10:08:00+02	VST003989	USR0190	GYM003
2024-12-03	09:57:00+02	12:37:00+02	VST003990	USR0381	GYM002
2023-07-19	13:54:00+02	16:29:00+02	VST003991	USR0460	GYM005
2024-11-03	15:36:00+02	17:40:00+02	VST003992	USR0294	GYM001
2024-08-21	12:06:00+02	12:50:00+02	VST003993	USR0476	GYM006
2023-01-21	12:09:00+02	14:17:00+02	VST003994	USR0045	GYM003
2023-11-07	08:40:00+02	10:58:00+02	VST003995	USR0442	GYM006
2024-08-10	13:28:00+02	15:01:00+02	VST003996	USR0337	GYM005
2024-10-14	14:30:00+02	16:02:00+02	VST003997	USR0385	GYM001
2024-09-29	09:56:00+02	12:28:00+02	VST003998	USR0032	GYM005
2024-08-18	14:35:00+02	15:13:00+02	VST003999	USR0392	GYM006
2024-03-09	12:22:00+02	14:24:00+02	VST004000	USR0118	GYM001
2024-01-06	17:13:00+02	17:50:00+02	VST004001	USR0296	GYM004
2024-07-13	12:49:00+02	13:56:00+02	VST004002	USR0184	GYM001
2023-03-19	08:25:00+02	10:01:00+02	VST004003	USR0191	GYM003
2024-06-25	16:49:00+02	19:15:00+02	VST004004	USR0235	GYM006
2023-10-12	14:23:00+02	15:30:00+02	VST004005	USR0238	GYM005
2024-10-09	16:46:00+02	18:21:00+02	VST004006	USR0216	GYM005
2023-05-20	16:40:00+02	18:13:00+02	VST004007	USR0074	GYM005
2024-07-06	15:36:00+02	18:34:00+02	VST004008	USR0111	GYM002
2023-10-09	16:18:00+02	17:29:00+02	VST004009	USR0103	GYM002
2024-07-15	08:44:00+02	09:17:00+02	VST004010	USR0359	GYM003
2023-09-15	13:03:00+02	14:02:00+02	VST004011	USR0074	GYM004
2023-12-26	11:17:00+02	12:10:00+02	VST004012	USR0420	GYM002
2024-03-15	13:28:00+02	15:36:00+02	VST004013	USR0473	GYM001
2023-09-27	16:46:00+02	18:57:00+02	VST004014	USR0252	GYM006
2023-05-14	09:24:00+02	12:24:00+02	VST004015	USR0114	GYM003
2024-10-01	09:38:00+02	10:28:00+02	VST004016	USR0379	GYM004
2023-04-14	10:51:00+02	13:33:00+02	VST004017	USR0313	GYM001
2023-04-05	17:10:00+02	18:28:00+02	VST004018	USR0330	GYM005
2024-12-29	17:06:00+02	19:24:00+02	VST004019	USR0339	GYM002
2024-07-26	08:07:00+02	09:19:00+02	VST004020	USR0238	GYM001
2024-04-24	09:07:00+02	11:26:00+02	VST004021	USR0173	GYM004
2023-08-29	11:35:00+02	13:09:00+02	VST004022	USR0079	GYM003
2023-01-13	11:38:00+02	13:25:00+02	VST004023	USR0464	GYM001
2023-05-27	15:14:00+02	17:52:00+02	VST004024	USR0386	GYM003
2024-08-23	09:46:00+02	12:32:00+02	VST004025	USR0093	GYM005
2023-04-05	11:30:00+02	13:37:00+02	VST004026	USR0452	GYM004
2023-10-20	17:10:00+02	20:10:00+02	VST004027	USR0050	GYM004
2023-01-25	15:25:00+02	17:13:00+02	VST004028	USR0285	GYM002
2023-09-29	09:13:00+02	11:28:00+02	VST004029	USR0223	GYM006
2024-05-19	10:37:00+02	11:29:00+02	VST004030	USR0081	GYM004
2023-06-15	08:24:00+02	09:21:00+02	VST004031	USR0266	GYM001
2023-03-28	15:50:00+02	18:46:00+02	VST004032	USR0155	GYM001
2024-10-15	13:39:00+02	15:37:00+02	VST004033	USR0373	GYM001
2024-10-07	08:38:00+02	09:44:00+02	VST004034	USR0233	GYM005
2024-09-29	09:29:00+02	11:07:00+02	VST004035	USR0399	GYM004
2024-05-05	09:15:00+02	10:38:00+02	VST004036	USR0316	GYM004
2023-05-21	08:55:00+02	11:06:00+02	VST004037	USR0236	GYM001
2023-04-13	11:02:00+02	12:50:00+02	VST004038	USR0159	GYM002
2023-08-14	12:17:00+02	12:48:00+02	VST004039	USR0405	GYM002
2024-07-28	17:31:00+02	18:44:00+02	VST004040	USR0316	GYM004
2023-10-21	09:12:00+02	11:47:00+02	VST004041	USR0251	GYM004
2023-11-02	17:48:00+02	18:18:00+02	VST004042	USR0314	GYM003
2023-09-11	11:53:00+02	12:47:00+02	VST004043	USR0425	GYM004
2023-06-29	12:24:00+02	13:11:00+02	VST004044	USR0430	GYM001
2023-02-09	14:57:00+02	17:13:00+02	VST004045	USR0301	GYM006
2024-12-01	14:37:00+02	17:21:00+02	VST004046	USR0380	GYM005
2024-06-03	15:41:00+02	17:57:00+02	VST004047	USR0282	GYM004
2024-09-07	14:54:00+02	16:37:00+02	VST004048	USR0102	GYM004
2024-06-29	15:23:00+02	17:43:00+02	VST004049	USR0051	GYM001
2023-08-24	13:23:00+02	14:36:00+02	VST004050	USR0420	GYM003
2024-04-07	08:17:00+02	09:32:00+02	VST004051	USR0052	GYM006
2023-08-16	14:38:00+02	16:43:00+02	VST004052	USR0209	GYM004
2024-11-30	10:01:00+02	11:18:00+02	VST004053	USR0307	GYM002
2024-04-27	17:07:00+02	18:11:00+02	VST004054	USR0131	GYM002
2024-03-05	08:06:00+02	09:26:00+02	VST004055	USR0270	GYM002
2023-01-22	09:04:00+02	11:38:00+02	VST004056	USR0433	GYM005
2023-12-09	17:59:00+02	19:15:00+02	VST004057	USR0205	GYM005
2023-02-09	08:46:00+02	11:24:00+02	VST004058	USR0489	GYM006
2023-06-22	09:14:00+02	10:12:00+02	VST004059	USR0219	GYM004
2024-03-14	14:06:00+02	16:31:00+02	VST004060	USR0257	GYM004
2023-06-28	16:34:00+02	19:29:00+02	VST004061	USR0185	GYM004
2024-08-20	09:48:00+02	11:12:00+02	VST004062	USR0145	GYM005
2023-05-13	12:56:00+02	14:13:00+02	VST004063	USR0496	GYM006
2023-12-17	13:08:00+02	14:29:00+02	VST004064	USR0178	GYM004
2024-06-08	09:28:00+02	10:13:00+02	VST004065	USR0482	GYM001
2024-06-23	12:48:00+02	14:04:00+02	VST004066	USR0014	GYM003
2024-05-20	15:28:00+02	16:47:00+02	VST004067	USR0246	GYM002
2023-03-25	14:30:00+02	16:06:00+02	VST004068	USR0187	GYM002
2024-04-08	14:44:00+02	16:58:00+02	VST004069	USR0337	GYM001
2023-12-09	08:31:00+02	10:53:00+02	VST004070	USR0259	GYM004
2023-10-07	16:05:00+02	17:02:00+02	VST004071	USR0354	GYM006
2023-09-20	10:40:00+02	11:52:00+02	VST004072	USR0040	GYM006
2023-06-15	17:06:00+02	17:56:00+02	VST004073	USR0089	GYM005
2023-10-20	11:45:00+02	13:30:00+02	VST004074	USR0125	GYM004
2024-05-23	10:19:00+02	11:10:00+02	VST004075	USR0450	GYM006
2024-08-02	14:40:00+02	16:46:00+02	VST004076	USR0418	GYM004
2023-08-14	17:18:00+02	18:19:00+02	VST004077	USR0474	GYM002
2023-06-19	13:02:00+02	14:42:00+02	VST004078	USR0351	GYM002
2024-08-20	10:27:00+02	11:13:00+02	VST004079	USR0009	GYM005
2024-10-06	13:05:00+02	15:02:00+02	VST004080	USR0350	GYM002
2024-03-23	14:22:00+02	14:59:00+02	VST004081	USR0084	GYM004
2024-11-20	08:11:00+02	11:10:00+02	VST004082	USR0021	GYM001
2024-05-16	17:26:00+02	18:56:00+02	VST004083	USR0477	GYM005
2024-06-10	17:28:00+02	20:00:00+02	VST004084	USR0281	GYM001
2024-01-14	10:24:00+02	12:58:00+02	VST004085	USR0358	GYM004
2023-07-20	10:06:00+02	11:01:00+02	VST004086	USR0378	GYM005
2024-09-10	08:42:00+02	09:14:00+02	VST004087	USR0172	GYM001
2023-09-07	08:05:00+02	08:50:00+02	VST004088	USR0025	GYM005
2024-02-13	17:46:00+02	19:24:00+02	VST004089	USR0393	GYM004
2024-08-23	14:43:00+02	15:14:00+02	VST004090	USR0103	GYM006
2023-05-05	17:10:00+02	20:09:00+02	VST004091	USR0190	GYM005
2023-04-23	17:20:00+02	18:00:00+02	VST004092	USR0236	GYM006
2023-05-17	09:27:00+02	10:21:00+02	VST004093	USR0410	GYM004
2024-05-10	13:12:00+02	14:36:00+02	VST004094	USR0313	GYM005
2024-11-08	11:35:00+02	14:18:00+02	VST004095	USR0037	GYM005
2023-05-30	13:52:00+02	14:23:00+02	VST004096	USR0272	GYM006
2023-12-09	11:36:00+02	13:42:00+02	VST004097	USR0293	GYM002
2024-08-02	15:02:00+02	17:45:00+02	VST004098	USR0332	GYM006
2023-11-17	16:44:00+02	18:22:00+02	VST004099	USR0152	GYM006
2024-06-15	10:25:00+02	12:59:00+02	VST004100	USR0282	GYM006
2023-10-16	10:44:00+02	13:15:00+02	VST004101	USR0020	GYM004
2024-05-03	11:08:00+02	13:04:00+02	VST004102	USR0137	GYM003
2024-05-06	11:46:00+02	14:05:00+02	VST004103	USR0471	GYM006
2024-09-03	12:18:00+02	14:14:00+02	VST004104	USR0359	GYM005
2023-09-09	11:18:00+02	13:22:00+02	VST004105	USR0029	GYM001
2023-03-18	09:57:00+02	11:54:00+02	VST004106	USR0031	GYM002
2024-10-08	11:05:00+02	12:55:00+02	VST004107	USR0019	GYM006
2024-01-27	17:40:00+02	19:11:00+02	VST004108	USR0148	GYM006
2024-02-16	08:55:00+02	10:57:00+02	VST004109	USR0471	GYM002
2023-06-22	17:22:00+02	19:34:00+02	VST004110	USR0491	GYM006
2023-07-20	15:52:00+02	17:58:00+02	VST004111	USR0283	GYM005
2023-08-05	17:22:00+02	18:06:00+02	VST004112	USR0350	GYM003
2024-01-11	09:14:00+02	11:15:00+02	VST004113	USR0341	GYM006
2024-12-20	12:57:00+02	14:51:00+02	VST004114	USR0300	GYM002
2024-08-08	09:08:00+02	10:03:00+02	VST004115	USR0163	GYM006
2023-01-11	12:16:00+02	12:46:00+02	VST004116	USR0113	GYM004
2023-01-12	09:40:00+02	12:06:00+02	VST004117	USR0455	GYM005
2024-08-12	11:22:00+02	13:34:00+02	VST004118	USR0150	GYM005
2024-03-10	17:54:00+02	18:59:00+02	VST004119	USR0330	GYM003
2024-11-14	16:18:00+02	16:54:00+02	VST004120	USR0255	GYM004
2024-08-30	13:38:00+02	14:39:00+02	VST004121	USR0087	GYM004
2024-01-08	14:05:00+02	16:50:00+02	VST004122	USR0399	GYM003
2023-09-30	10:11:00+02	11:52:00+02	VST004123	USR0350	GYM001
2024-11-21	12:00:00+02	13:33:00+02	VST004124	USR0098	GYM006
2024-07-29	09:42:00+02	11:46:00+02	VST004125	USR0397	GYM004
2024-05-23	12:51:00+02	15:16:00+02	VST004126	USR0132	GYM001
2023-05-12	09:11:00+02	11:42:00+02	VST004127	USR0466	GYM001
2023-11-15	11:18:00+02	13:59:00+02	VST004128	USR0312	GYM005
2024-09-12	13:25:00+02	15:40:00+02	VST004129	USR0407	GYM006
2023-06-17	16:17:00+02	17:35:00+02	VST004130	USR0097	GYM005
2024-02-01	15:41:00+02	16:11:00+02	VST004131	USR0098	GYM002
2023-06-29	13:36:00+02	15:28:00+02	VST004132	USR0290	GYM005
2023-02-27	13:13:00+02	13:47:00+02	VST004133	USR0356	GYM004
2024-04-24	17:58:00+02	20:00:00+02	VST004134	USR0227	GYM004
2024-08-13	10:36:00+02	11:17:00+02	VST004135	USR0145	GYM006
2024-04-04	17:39:00+02	19:32:00+02	VST004136	USR0156	GYM001
2023-03-02	17:40:00+02	20:03:00+02	VST004137	USR0270	GYM004
2024-01-04	14:13:00+02	15:42:00+02	VST004138	USR0162	GYM005
2023-05-01	13:23:00+02	15:57:00+02	VST004139	USR0112	GYM005
2024-12-19	15:18:00+02	17:30:00+02	VST004140	USR0331	GYM006
2024-06-29	10:52:00+02	11:42:00+02	VST004141	USR0185	GYM005
2024-08-04	08:04:00+02	10:03:00+02	VST004142	USR0205	GYM003
2023-01-17	13:20:00+02	15:39:00+02	VST004143	USR0097	GYM006
2024-05-10	12:12:00+02	14:43:00+02	VST004144	USR0377	GYM006
2024-05-11	11:46:00+02	12:41:00+02	VST004145	USR0055	GYM004
2024-05-19	15:26:00+02	17:34:00+02	VST004146	USR0450	GYM006
2024-06-15	12:43:00+02	14:28:00+02	VST004147	USR0482	GYM002
2023-11-11	14:08:00+02	15:27:00+02	VST004148	USR0117	GYM004
2023-03-10	10:17:00+02	11:23:00+02	VST004149	USR0093	GYM004
2024-12-27	13:39:00+02	16:22:00+02	VST004150	USR0293	GYM003
2023-06-10	16:11:00+02	19:07:00+02	VST004151	USR0452	GYM004
2024-09-05	15:53:00+02	18:32:00+02	VST004152	USR0204	GYM001
2024-12-18	15:36:00+02	16:14:00+02	VST004153	USR0282	GYM005
2023-05-25	14:07:00+02	15:09:00+02	VST004154	USR0189	GYM005
2024-07-22	13:12:00+02	15:49:00+02	VST004155	USR0476	GYM006
2024-08-17	16:18:00+02	17:10:00+02	VST004156	USR0323	GYM003
2024-01-20	17:24:00+02	19:11:00+02	VST004157	USR0084	GYM005
2023-09-26	09:51:00+02	12:41:00+02	VST004158	USR0458	GYM001
2024-03-29	10:59:00+02	13:28:00+02	VST004159	USR0180	GYM003
2024-11-29	09:23:00+02	10:36:00+02	VST004160	USR0274	GYM002
2024-06-01	12:47:00+02	15:11:00+02	VST004161	USR0181	GYM005
2023-12-16	10:23:00+02	11:22:00+02	VST004162	USR0447	GYM004
2023-04-20	17:11:00+02	19:44:00+02	VST004163	USR0181	GYM001
2024-04-27	11:21:00+02	14:09:00+02	VST004164	USR0283	GYM001
2024-02-11	12:29:00+02	14:00:00+02	VST004165	USR0287	GYM005
2024-10-11	09:18:00+02	10:50:00+02	VST004166	USR0475	GYM006
2023-02-20	09:17:00+02	10:41:00+02	VST004167	USR0106	GYM002
2024-02-07	08:19:00+02	09:32:00+02	VST004168	USR0129	GYM004
2024-07-16	16:39:00+02	17:31:00+02	VST004169	USR0262	GYM002
2024-04-20	08:31:00+02	09:28:00+02	VST004170	USR0011	GYM002
2023-03-28	17:55:00+02	20:16:00+02	VST004171	USR0162	GYM005
2023-03-09	17:52:00+02	18:29:00+02	VST004172	USR0487	GYM004
2024-08-18	14:54:00+02	16:05:00+02	VST004173	USR0468	GYM005
2023-02-11	11:37:00+02	13:30:00+02	VST004174	USR0447	GYM005
2024-12-31	08:37:00+02	10:45:00+02	VST004175	USR0181	GYM006
2023-02-26	17:24:00+02	19:05:00+02	VST004176	USR0213	GYM001
2023-07-15	12:26:00+02	13:52:00+02	VST004177	USR0469	GYM006
2024-11-08	17:16:00+02	18:51:00+02	VST004178	USR0274	GYM006
2023-03-03	17:12:00+02	19:43:00+02	VST004179	USR0021	GYM005
2023-09-20	16:03:00+02	17:04:00+02	VST004180	USR0275	GYM006
2023-04-22	10:32:00+02	11:36:00+02	VST004181	USR0260	GYM006
2024-12-11	14:14:00+02	17:00:00+02	VST004182	USR0333	GYM003
2023-06-27	14:41:00+02	17:16:00+02	VST004183	USR0466	GYM004
2023-01-26	11:48:00+02	12:41:00+02	VST004184	USR0116	GYM001
2024-02-14	12:57:00+02	14:52:00+02	VST004185	USR0413	GYM004
2024-06-14	10:17:00+02	11:44:00+02	VST004186	USR0025	GYM001
2023-11-13	15:55:00+02	18:52:00+02	VST004187	USR0440	GYM003
2024-06-15	16:33:00+02	17:19:00+02	VST004188	USR0333	GYM005
2023-04-16	16:42:00+02	18:39:00+02	VST004189	USR0254	GYM001
2024-04-08	09:32:00+02	11:38:00+02	VST004190	USR0447	GYM001
2023-09-03	14:46:00+02	16:53:00+02	VST004191	USR0411	GYM001
2023-03-22	14:12:00+02	17:05:00+02	VST004192	USR0444	GYM003
2024-10-23	16:34:00+02	18:55:00+02	VST004193	USR0211	GYM004
2024-01-31	08:10:00+02	09:39:00+02	VST004194	USR0305	GYM003
2024-06-05	12:04:00+02	13:31:00+02	VST004195	USR0321	GYM001
2023-09-21	10:49:00+02	12:25:00+02	VST004196	USR0422	GYM006
2024-10-22	16:46:00+02	17:45:00+02	VST004197	USR0339	GYM001
2023-10-01	10:23:00+02	12:07:00+02	VST004198	USR0436	GYM006
2024-12-06	15:36:00+02	16:28:00+02	VST004199	USR0257	GYM005
2023-06-21	10:43:00+02	11:41:00+02	VST004200	USR0168	GYM003
2023-09-22	11:03:00+02	11:55:00+02	VST004201	USR0337	GYM006
2023-01-26	17:39:00+02	19:36:00+02	VST004202	USR0021	GYM003
2024-04-13	17:39:00+02	18:57:00+02	VST004203	USR0086	GYM002
2024-04-20	10:29:00+02	11:28:00+02	VST004204	USR0015	GYM004
2023-12-22	16:15:00+02	19:11:00+02	VST004205	USR0050	GYM002
2023-01-26	14:07:00+02	16:11:00+02	VST004206	USR0487	GYM006
2023-02-03	08:41:00+02	09:43:00+02	VST004207	USR0304	GYM002
2023-09-21	11:44:00+02	13:34:00+02	VST004208	USR0487	GYM004
2023-05-18	16:19:00+02	18:26:00+02	VST004209	USR0416	GYM006
2024-11-25	11:57:00+02	14:54:00+02	VST004210	USR0305	GYM005
2024-07-19	09:04:00+02	09:34:00+02	VST004211	USR0196	GYM005
2024-04-06	12:30:00+02	14:19:00+02	VST004212	USR0364	GYM004
2023-06-17	14:18:00+02	15:03:00+02	VST004213	USR0301	GYM004
2024-09-22	11:59:00+02	14:46:00+02	VST004214	USR0288	GYM006
2024-10-16	08:43:00+02	10:01:00+02	VST004215	USR0388	GYM003
2023-03-22	11:31:00+02	13:40:00+02	VST004216	USR0245	GYM006
2024-02-11	16:50:00+02	19:08:00+02	VST004217	USR0449	GYM003
2024-07-27	14:09:00+02	16:00:00+02	VST004218	USR0353	GYM003
2023-02-15	14:37:00+02	16:40:00+02	VST004219	USR0455	GYM003
2024-08-21	16:00:00+02	17:02:00+02	VST004220	USR0201	GYM006
2024-09-02	15:45:00+02	18:28:00+02	VST004221	USR0193	GYM001
2023-02-22	08:47:00+02	10:13:00+02	VST004222	USR0336	GYM001
2024-12-04	08:40:00+02	09:37:00+02	VST004223	USR0146	GYM005
2024-04-20	13:31:00+02	15:42:00+02	VST004224	USR0310	GYM001
2024-08-14	09:45:00+02	10:17:00+02	VST004225	USR0127	GYM001
2023-01-16	16:53:00+02	19:40:00+02	VST004226	USR0175	GYM003
2023-12-26	12:40:00+02	15:07:00+02	VST004227	USR0134	GYM003
2024-05-01	12:29:00+02	14:19:00+02	VST004228	USR0066	GYM004
2024-12-06	17:52:00+02	18:59:00+02	VST004229	USR0393	GYM003
2024-05-16	17:17:00+02	19:02:00+02	VST004230	USR0452	GYM006
2023-05-21	17:43:00+02	19:09:00+02	VST004231	USR0365	GYM004
2024-09-11	10:58:00+02	13:35:00+02	VST004232	USR0279	GYM004
2024-03-22	14:25:00+02	16:51:00+02	VST004233	USR0246	GYM001
2023-10-17	14:27:00+02	15:34:00+02	VST004234	USR0363	GYM003
2023-07-28	14:14:00+02	15:56:00+02	VST004235	USR0237	GYM001
2024-04-19	09:19:00+02	10:26:00+02	VST004236	USR0171	GYM003
2024-02-17	16:49:00+02	17:27:00+02	VST004237	USR0051	GYM001
2024-11-07	12:17:00+02	14:08:00+02	VST004238	USR0328	GYM001
2024-03-02	14:25:00+02	16:14:00+02	VST004239	USR0359	GYM001
2024-01-06	11:48:00+02	14:26:00+02	VST004240	USR0153	GYM006
2024-10-25	16:48:00+02	17:49:00+02	VST004241	USR0080	GYM005
2023-10-17	14:55:00+02	16:35:00+02	VST004242	USR0419	GYM001
2024-03-07	14:01:00+02	16:57:00+02	VST004243	USR0145	GYM002
2023-09-25	13:53:00+02	16:25:00+02	VST004244	USR0274	GYM002
2023-05-31	16:18:00+02	17:43:00+02	VST004245	USR0155	GYM002
2024-12-19	16:13:00+02	18:49:00+02	VST004246	USR0399	GYM006
2023-09-12	08:06:00+02	09:50:00+02	VST004247	USR0337	GYM004
2023-12-19	16:33:00+02	18:39:00+02	VST004248	USR0363	GYM001
2024-01-12	10:22:00+02	11:07:00+02	VST004249	USR0325	GYM002
2024-10-14	15:30:00+02	17:25:00+02	VST004250	USR0336	GYM006
2023-12-24	10:49:00+02	11:58:00+02	VST004251	USR0143	GYM004
2024-08-30	11:55:00+02	13:18:00+02	VST004252	USR0298	GYM002
2024-01-05	09:18:00+02	10:45:00+02	VST004253	USR0494	GYM003
2023-08-15	16:46:00+02	17:29:00+02	VST004254	USR0034	GYM005
2024-12-05	12:47:00+02	14:02:00+02	VST004255	USR0304	GYM001
2023-10-30	11:36:00+02	14:10:00+02	VST004256	USR0467	GYM005
2024-01-24	10:33:00+02	12:43:00+02	VST004257	USR0392	GYM005
2024-01-12	11:11:00+02	12:57:00+02	VST004258	USR0239	GYM003
2023-04-28	10:41:00+02	11:51:00+02	VST004259	USR0138	GYM003
2023-01-05	14:10:00+02	14:45:00+02	VST004260	USR0254	GYM003
2024-03-19	10:01:00+02	12:51:00+02	VST004261	USR0005	GYM004
2023-12-18	11:55:00+02	14:05:00+02	VST004262	USR0372	GYM002
2024-06-16	15:04:00+02	17:00:00+02	VST004263	USR0176	GYM001
2024-10-25	13:38:00+02	15:56:00+02	VST004264	USR0373	GYM003
2024-10-01	09:56:00+02	12:27:00+02	VST004265	USR0410	GYM006
2023-05-04	16:13:00+02	18:12:00+02	VST004266	USR0214	GYM001
2024-10-19	16:10:00+02	18:20:00+02	VST004267	USR0364	GYM001
2023-10-04	16:10:00+02	18:20:00+02	VST004268	USR0023	GYM001
2024-01-29	11:35:00+02	12:23:00+02	VST004269	USR0318	GYM003
2024-10-25	10:45:00+02	13:30:00+02	VST004270	USR0013	GYM003
2023-12-26	15:00:00+02	16:42:00+02	VST004271	USR0393	GYM002
2024-09-14	08:22:00+02	10:04:00+02	VST004272	USR0241	GYM003
2024-04-13	12:09:00+02	13:28:00+02	VST004273	USR0276	GYM003
2024-09-19	08:44:00+02	11:34:00+02	VST004274	USR0092	GYM001
2024-11-30	10:10:00+02	12:20:00+02	VST004275	USR0108	GYM002
2023-02-26	17:47:00+02	18:41:00+02	VST004276	USR0441	GYM005
2023-09-08	10:44:00+02	11:47:00+02	VST004277	USR0229	GYM003
2023-05-30	10:17:00+02	12:09:00+02	VST004278	USR0152	GYM006
2024-03-27	16:44:00+02	19:42:00+02	VST004279	USR0108	GYM003
2023-06-11	08:40:00+02	09:23:00+02	VST004280	USR0289	GYM005
2023-04-30	17:46:00+02	19:33:00+02	VST004281	USR0404	GYM001
2024-08-04	10:30:00+02	12:57:00+02	VST004282	USR0444	GYM002
2023-12-17	08:57:00+02	10:08:00+02	VST004283	USR0176	GYM001
2023-04-09	10:50:00+02	13:47:00+02	VST004284	USR0320	GYM004
2023-06-16	12:24:00+02	13:29:00+02	VST004285	USR0286	GYM003
2024-10-24	11:04:00+02	13:27:00+02	VST004286	USR0364	GYM006
2024-05-28	16:49:00+02	19:22:00+02	VST004287	USR0329	GYM004
2024-10-25	14:55:00+02	16:39:00+02	VST004288	USR0365	GYM003
2024-02-05	17:37:00+02	18:44:00+02	VST004289	USR0241	GYM004
2023-12-31	08:19:00+02	09:42:00+02	VST004290	USR0145	GYM005
2024-07-30	12:50:00+02	14:15:00+02	VST004291	USR0356	GYM003
2023-11-22	09:27:00+02	10:47:00+02	VST004292	USR0014	GYM006
2024-08-03	11:41:00+02	12:13:00+02	VST004293	USR0275	GYM003
2024-09-24	15:39:00+02	17:41:00+02	VST004294	USR0071	GYM004
2024-09-12	16:02:00+02	18:59:00+02	VST004295	USR0315	GYM002
2023-09-04	16:13:00+02	17:09:00+02	VST004296	USR0195	GYM004
2024-03-09	10:54:00+02	12:01:00+02	VST004297	USR0353	GYM003
2023-04-03	11:44:00+02	13:50:00+02	VST004298	USR0300	GYM003
2023-09-25	15:00:00+02	17:19:00+02	VST004299	USR0416	GYM002
2024-09-06	10:26:00+02	11:39:00+02	VST004300	USR0367	GYM001
2024-09-15	17:56:00+02	18:40:00+02	VST004301	USR0011	GYM002
2023-11-17	11:06:00+02	12:00:00+02	VST004302	USR0106	GYM001
2023-03-03	16:43:00+02	18:44:00+02	VST004303	USR0258	GYM006
2023-10-27	12:30:00+02	15:01:00+02	VST004304	USR0474	GYM003
2024-02-07	10:51:00+02	12:06:00+02	VST004305	USR0381	GYM005
2024-10-09	13:50:00+02	14:33:00+02	VST004306	USR0196	GYM005
2024-07-20	15:44:00+02	16:44:00+02	VST004307	USR0145	GYM004
2024-09-11	09:10:00+02	11:51:00+02	VST004308	USR0465	GYM002
2023-10-30	11:55:00+02	13:51:00+02	VST004309	USR0220	GYM002
2023-09-10	14:27:00+02	16:48:00+02	VST004310	USR0350	GYM005
2024-04-22	14:34:00+02	15:42:00+02	VST004311	USR0424	GYM001
2024-01-04	10:15:00+02	12:28:00+02	VST004312	USR0471	GYM002
2024-11-09	09:51:00+02	11:23:00+02	VST004313	USR0174	GYM001
2023-06-09	08:16:00+02	08:54:00+02	VST004314	USR0216	GYM001
2023-06-15	11:27:00+02	12:27:00+02	VST004315	USR0093	GYM001
2023-07-24	16:55:00+02	18:26:00+02	VST004316	USR0260	GYM001
2023-09-24	16:36:00+02	18:47:00+02	VST004317	USR0422	GYM004
2023-05-18	15:09:00+02	17:44:00+02	VST004318	USR0063	GYM004
2024-01-03	10:33:00+02	12:20:00+02	VST004319	USR0029	GYM005
2024-03-18	09:38:00+02	10:52:00+02	VST004320	USR0275	GYM004
2024-07-20	11:01:00+02	13:07:00+02	VST004321	USR0347	GYM006
2024-12-21	16:07:00+02	16:59:00+02	VST004322	USR0285	GYM002
2023-01-17	08:39:00+02	11:07:00+02	VST004323	USR0484	GYM006
2023-03-09	17:04:00+02	19:11:00+02	VST004324	USR0419	GYM004
2023-05-13	16:35:00+02	18:15:00+02	VST004325	USR0372	GYM002
2024-11-30	10:00:00+02	12:23:00+02	VST004326	USR0070	GYM002
2024-03-05	09:35:00+02	11:39:00+02	VST004327	USR0379	GYM001
2023-11-04	16:13:00+02	16:45:00+02	VST004328	USR0279	GYM005
2024-10-11	10:13:00+02	11:13:00+02	VST004329	USR0231	GYM001
2023-06-23	17:12:00+02	18:11:00+02	VST004330	USR0302	GYM001
2024-02-16	08:01:00+02	08:52:00+02	VST004331	USR0255	GYM006
2023-04-07	15:21:00+02	16:22:00+02	VST004332	USR0172	GYM004
2024-11-13	16:54:00+02	19:29:00+02	VST004333	USR0432	GYM006
2023-06-03	15:10:00+02	17:50:00+02	VST004334	USR0180	GYM004
2024-11-25	14:19:00+02	15:46:00+02	VST004335	USR0264	GYM006
2023-08-30	08:44:00+02	09:19:00+02	VST004336	USR0183	GYM002
2023-10-31	17:02:00+02	20:02:00+02	VST004337	USR0322	GYM004
2023-10-12	15:19:00+02	18:15:00+02	VST004338	USR0205	GYM004
2023-01-27	11:54:00+02	14:50:00+02	VST004339	USR0424	GYM006
2024-02-06	16:13:00+02	18:45:00+02	VST004340	USR0249	GYM003
2023-12-26	14:30:00+02	16:10:00+02	VST004341	USR0213	GYM002
2023-03-01	13:58:00+02	14:52:00+02	VST004342	USR0159	GYM002
2023-07-21	17:49:00+02	19:05:00+02	VST004343	USR0500	GYM003
2024-08-03	09:40:00+02	11:48:00+02	VST004344	USR0432	GYM006
2024-01-05	15:15:00+02	17:48:00+02	VST004345	USR0100	GYM006
2024-06-16	10:17:00+02	12:38:00+02	VST004346	USR0317	GYM002
2023-06-01	12:20:00+02	14:06:00+02	VST004347	USR0112	GYM006
2023-04-12	16:08:00+02	19:04:00+02	VST004348	USR0308	GYM005
2024-08-29	11:58:00+02	13:00:00+02	VST004349	USR0166	GYM005
2024-03-21	09:25:00+02	10:20:00+02	VST004350	USR0475	GYM003
2023-08-17	12:50:00+02	14:43:00+02	VST004351	USR0036	GYM004
2023-05-05	17:16:00+02	18:02:00+02	VST004352	USR0112	GYM005
2023-08-24	14:58:00+02	17:45:00+02	VST004353	USR0087	GYM006
2023-06-11	12:23:00+02	13:40:00+02	VST004354	USR0183	GYM003
2024-07-07	11:13:00+02	13:26:00+02	VST004355	USR0085	GYM005
2023-12-19	08:05:00+02	08:40:00+02	VST004356	USR0269	GYM001
2023-03-09	08:07:00+02	10:17:00+02	VST004357	USR0165	GYM003
2023-06-22	17:51:00+02	20:43:00+02	VST004358	USR0303	GYM002
2024-09-28	16:55:00+02	19:42:00+02	VST004359	USR0090	GYM005
2024-11-12	10:00:00+02	12:45:00+02	VST004360	USR0488	GYM002
2024-07-12	16:52:00+02	19:27:00+02	VST004361	USR0455	GYM003
2023-09-18	08:07:00+02	08:53:00+02	VST004362	USR0238	GYM005
2023-08-05	14:24:00+02	17:06:00+02	VST004363	USR0487	GYM002
2023-05-04	11:30:00+02	14:29:00+02	VST004364	USR0022	GYM004
2023-06-11	13:23:00+02	16:10:00+02	VST004365	USR0167	GYM004
2023-07-20	14:58:00+02	15:59:00+02	VST004366	USR0215	GYM001
2024-03-29	14:10:00+02	15:33:00+02	VST004367	USR0058	GYM006
2024-02-06	09:49:00+02	10:49:00+02	VST004368	USR0030	GYM003
2024-04-06	10:38:00+02	11:54:00+02	VST004369	USR0402	GYM006
2023-10-02	15:16:00+02	16:32:00+02	VST004370	USR0106	GYM006
2023-07-25	17:59:00+02	18:30:00+02	VST004371	USR0402	GYM002
2023-02-09	12:19:00+02	15:11:00+02	VST004372	USR0494	GYM001
2023-09-30	12:27:00+02	14:51:00+02	VST004373	USR0330	GYM003
2024-11-30	17:08:00+02	18:58:00+02	VST004374	USR0167	GYM004
2023-04-03	15:13:00+02	16:14:00+02	VST004375	USR0350	GYM006
2023-02-11	17:38:00+02	18:18:00+02	VST004376	USR0154	GYM002
2024-04-09	14:14:00+02	15:16:00+02	VST004377	USR0327	GYM006
2024-01-14	12:42:00+02	15:39:00+02	VST004378	USR0007	GYM005
2023-04-17	14:46:00+02	16:08:00+02	VST004379	USR0197	GYM004
2023-11-24	11:28:00+02	12:39:00+02	VST004380	USR0321	GYM006
2023-03-06	15:03:00+02	15:55:00+02	VST004381	USR0046	GYM005
2023-12-31	17:25:00+02	20:18:00+02	VST004382	USR0018	GYM005
2024-04-28	17:30:00+02	19:05:00+02	VST004383	USR0397	GYM002
2024-10-08	16:14:00+02	16:52:00+02	VST004384	USR0153	GYM002
2023-01-24	11:03:00+02	11:54:00+02	VST004385	USR0488	GYM005
2024-06-23	14:19:00+02	15:20:00+02	VST004386	USR0264	GYM001
2023-03-03	17:32:00+02	20:11:00+02	VST004387	USR0074	GYM006
2024-05-05	17:28:00+02	19:14:00+02	VST004388	USR0416	GYM005
2023-09-30	16:15:00+02	18:18:00+02	VST004389	USR0145	GYM005
2023-08-17	12:19:00+02	15:08:00+02	VST004390	USR0102	GYM002
2023-01-20	13:14:00+02	14:27:00+02	VST004391	USR0335	GYM006
2023-01-03	17:51:00+02	20:09:00+02	VST004392	USR0335	GYM003
2024-02-25	13:52:00+02	14:22:00+02	VST004393	USR0121	GYM004
2024-12-30	14:47:00+02	16:20:00+02	VST004394	USR0176	GYM002
2023-11-03	10:21:00+02	12:07:00+02	VST004395	USR0063	GYM006
2024-03-07	10:01:00+02	10:42:00+02	VST004396	USR0296	GYM006
2023-05-16	11:55:00+02	14:37:00+02	VST004397	USR0499	GYM001
2024-05-29	15:37:00+02	17:22:00+02	VST004398	USR0084	GYM004
2023-07-12	10:45:00+02	13:31:00+02	VST004399	USR0015	GYM002
2024-08-07	09:42:00+02	12:05:00+02	VST004400	USR0355	GYM002
2024-02-19	11:39:00+02	12:44:00+02	VST004401	USR0134	GYM003
2023-04-28	16:40:00+02	19:37:00+02	VST004402	USR0478	GYM001
2024-10-27	14:50:00+02	17:25:00+02	VST004403	USR0121	GYM001
2023-07-28	13:46:00+02	15:36:00+02	VST004404	USR0319	GYM006
2023-02-03	17:23:00+02	20:06:00+02	VST004405	USR0392	GYM006
2024-10-10	08:53:00+02	10:53:00+02	VST004406	USR0479	GYM002
2023-11-14	10:44:00+02	13:31:00+02	VST004407	USR0128	GYM003
2023-04-30	14:38:00+02	17:18:00+02	VST004408	USR0368	GYM002
2024-09-18	08:05:00+02	09:28:00+02	VST004409	USR0367	GYM005
2024-06-08	09:33:00+02	10:28:00+02	VST004410	USR0288	GYM006
2024-08-03	10:28:00+02	11:09:00+02	VST004411	USR0301	GYM005
2023-03-30	16:02:00+02	17:32:00+02	VST004412	USR0378	GYM003
2024-05-26	15:25:00+02	16:04:00+02	VST004413	USR0180	GYM002
2023-02-16	09:30:00+02	10:48:00+02	VST004414	USR0463	GYM006
2024-11-22	09:05:00+02	10:11:00+02	VST004415	USR0082	GYM003
2024-06-05	12:29:00+02	14:15:00+02	VST004416	USR0013	GYM002
2023-10-11	11:47:00+02	13:12:00+02	VST004417	USR0024	GYM002
2024-01-12	14:19:00+02	15:23:00+02	VST004418	USR0168	GYM005
2024-09-29	09:21:00+02	12:12:00+02	VST004419	USR0270	GYM004
2023-05-14	08:38:00+02	10:03:00+02	VST004420	USR0476	GYM001
2024-10-28	14:33:00+02	16:34:00+02	VST004421	USR0459	GYM006
2023-09-05	14:50:00+02	16:31:00+02	VST004422	USR0070	GYM001
2024-10-13	16:53:00+02	17:55:00+02	VST004423	USR0318	GYM003
2023-11-14	12:53:00+02	15:11:00+02	VST004424	USR0376	GYM001
2024-03-11	08:58:00+02	09:47:00+02	VST004425	USR0089	GYM005
2023-06-25	10:59:00+02	13:49:00+02	VST004426	USR0189	GYM004
2024-11-16	16:26:00+02	18:01:00+02	VST004427	USR0257	GYM006
2024-08-08	15:29:00+02	17:05:00+02	VST004428	USR0217	GYM002
2023-12-17	08:10:00+02	10:17:00+02	VST004429	USR0450	GYM002
2023-05-23	11:26:00+02	12:37:00+02	VST004430	USR0382	GYM005
2024-02-02	16:50:00+02	19:02:00+02	VST004431	USR0032	GYM006
2024-09-15	12:52:00+02	15:18:00+02	VST004432	USR0141	GYM001
2024-12-18	11:19:00+02	12:10:00+02	VST004433	USR0161	GYM002
2024-10-04	08:34:00+02	10:09:00+02	VST004434	USR0032	GYM001
2024-01-04	16:42:00+02	19:00:00+02	VST004435	USR0312	GYM005
2024-05-15	16:48:00+02	17:54:00+02	VST004436	USR0152	GYM002
2024-09-13	11:57:00+02	14:44:00+02	VST004437	USR0347	GYM003
2024-01-05	10:53:00+02	12:15:00+02	VST004438	USR0260	GYM004
2024-08-01	08:36:00+02	09:24:00+02	VST004439	USR0216	GYM001
2024-01-17	14:08:00+02	15:46:00+02	VST004440	USR0279	GYM006
2023-03-27	12:04:00+02	13:23:00+02	VST004441	USR0285	GYM001
2024-04-04	08:00:00+02	10:05:00+02	VST004442	USR0098	GYM001
2023-11-21	10:41:00+02	13:35:00+02	VST004443	USR0405	GYM001
2024-06-05	09:28:00+02	12:08:00+02	VST004444	USR0030	GYM005
2024-05-03	12:42:00+02	13:53:00+02	VST004445	USR0090	GYM005
2024-02-01	14:49:00+02	17:06:00+02	VST004446	USR0148	GYM006
2023-12-21	14:01:00+02	15:10:00+02	VST004447	USR0144	GYM005
2023-10-15	14:44:00+02	16:34:00+02	VST004448	USR0067	GYM006
2024-04-03	14:55:00+02	17:16:00+02	VST004449	USR0433	GYM006
2024-09-15	18:00:00+02	20:07:00+02	VST004450	USR0357	GYM005
2024-06-19	11:25:00+02	12:01:00+02	VST004451	USR0058	GYM002
2023-10-18	16:50:00+02	18:23:00+02	VST004452	USR0488	GYM005
2023-06-17	08:15:00+02	09:04:00+02	VST004453	USR0428	GYM002
2024-09-12	09:10:00+02	10:49:00+02	VST004454	USR0281	GYM003
2024-03-03	09:32:00+02	10:33:00+02	VST004455	USR0279	GYM005
2024-12-02	17:22:00+02	20:08:00+02	VST004456	USR0236	GYM003
2024-05-04	12:51:00+02	13:49:00+02	VST004457	USR0443	GYM005
2023-12-21	17:32:00+02	20:22:00+02	VST004458	USR0385	GYM003
2023-07-15	17:56:00+02	20:10:00+02	VST004459	USR0353	GYM004
2024-06-28	13:56:00+02	14:42:00+02	VST004460	USR0399	GYM003
2024-12-17	13:55:00+02	15:49:00+02	VST004461	USR0128	GYM002
2024-11-24	12:43:00+02	13:35:00+02	VST004462	USR0337	GYM001
2024-10-20	11:51:00+02	13:53:00+02	VST004463	USR0482	GYM006
2023-01-11	11:19:00+02	13:14:00+02	VST004464	USR0209	GYM003
2024-08-04	15:45:00+02	17:24:00+02	VST004465	USR0436	GYM001
2023-09-13	14:53:00+02	16:00:00+02	VST004466	USR0186	GYM004
2024-01-31	17:48:00+02	19:15:00+02	VST004467	USR0169	GYM004
2024-12-31	08:04:00+02	09:44:00+02	VST004468	USR0172	GYM002
2024-02-13	12:27:00+02	12:59:00+02	VST004469	USR0260	GYM002
2023-12-28	10:59:00+02	11:54:00+02	VST004470	USR0205	GYM003
2023-09-16	14:56:00+02	17:02:00+02	VST004471	USR0452	GYM005
2023-01-03	16:38:00+02	18:04:00+02	VST004472	USR0135	GYM004
2023-03-25	09:49:00+02	11:55:00+02	VST004473	USR0046	GYM001
2023-06-05	17:32:00+02	18:28:00+02	VST004474	USR0009	GYM005
2024-10-24	09:14:00+02	10:15:00+02	VST004475	USR0471	GYM004
2023-06-25	16:35:00+02	17:49:00+02	VST004476	USR0161	GYM003
2024-12-07	13:01:00+02	15:45:00+02	VST004477	USR0289	GYM004
2024-04-16	13:48:00+02	15:36:00+02	VST004478	USR0340	GYM002
2024-09-10	09:59:00+02	12:59:00+02	VST004479	USR0388	GYM001
2024-02-28	16:45:00+02	19:20:00+02	VST004480	USR0321	GYM001
2023-05-14	12:23:00+02	13:17:00+02	VST004481	USR0106	GYM002
2024-01-15	17:10:00+02	19:55:00+02	VST004482	USR0290	GYM005
2024-10-28	17:48:00+02	19:47:00+02	VST004483	USR0475	GYM002
2023-10-04	12:16:00+02	15:12:00+02	VST004484	USR0341	GYM001
2023-08-24	15:33:00+02	17:15:00+02	VST004485	USR0088	GYM003
2023-01-13	14:26:00+02	17:17:00+02	VST004486	USR0463	GYM005
2023-12-08	17:36:00+02	19:15:00+02	VST004487	USR0483	GYM006
2023-02-04	16:15:00+02	17:10:00+02	VST004488	USR0192	GYM004
2024-07-12	12:09:00+02	12:51:00+02	VST004489	USR0153	GYM006
2023-08-02	13:47:00+02	15:00:00+02	VST004490	USR0311	GYM003
2024-02-16	15:49:00+02	17:40:00+02	VST004491	USR0137	GYM006
2024-02-09	15:51:00+02	18:00:00+02	VST004492	USR0273	GYM005
2024-05-08	18:00:00+02	19:16:00+02	VST004493	USR0149	GYM001
2024-10-19	08:28:00+02	10:26:00+02	VST004494	USR0188	GYM001
2023-06-08	16:13:00+02	18:59:00+02	VST004495	USR0141	GYM003
2024-09-28	09:59:00+02	12:50:00+02	VST004496	USR0131	GYM006
2023-04-20	12:24:00+02	14:37:00+02	VST004497	USR0452	GYM005
2024-07-02	09:09:00+02	11:41:00+02	VST004498	USR0004	GYM004
2024-06-09	14:31:00+02	15:33:00+02	VST004499	USR0491	GYM006
2023-12-13	11:45:00+02	13:21:00+02	VST004500	USR0476	GYM006
2024-09-27	11:55:00+02	12:27:00+02	VST004501	USR0263	GYM004
2023-10-06	13:23:00+02	16:04:00+02	VST004502	USR0026	GYM002
2024-04-23	15:02:00+02	16:11:00+02	VST004503	USR0459	GYM003
2023-04-21	14:01:00+02	15:03:00+02	VST004504	USR0024	GYM005
2024-09-27	16:48:00+02	17:54:00+02	VST004505	USR0491	GYM003
2024-03-06	17:08:00+02	19:14:00+02	VST004506	USR0266	GYM004
2024-06-25	08:09:00+02	11:04:00+02	VST004507	USR0229	GYM005
2023-04-25	12:29:00+02	14:07:00+02	VST004508	USR0269	GYM001
2023-03-31	12:14:00+02	12:57:00+02	VST004509	USR0125	GYM001
2023-07-31	12:54:00+02	14:58:00+02	VST004510	USR0172	GYM005
2024-07-03	09:35:00+02	11:08:00+02	VST004511	USR0234	GYM003
2024-08-17	14:48:00+02	17:05:00+02	VST004512	USR0295	GYM003
2024-06-22	13:50:00+02	16:17:00+02	VST004513	USR0403	GYM001
2024-12-29	09:17:00+02	10:33:00+02	VST004514	USR0435	GYM001
2023-12-26	17:27:00+02	19:49:00+02	VST004515	USR0275	GYM004
2024-04-30	11:02:00+02	13:02:00+02	VST004516	USR0076	GYM005
2024-01-07	16:07:00+02	18:36:00+02	VST004517	USR0308	GYM003
2023-08-03	13:21:00+02	15:59:00+02	VST004518	USR0214	GYM004
2023-01-15	14:02:00+02	15:45:00+02	VST004519	USR0431	GYM003
2023-09-16	11:43:00+02	13:23:00+02	VST004520	USR0485	GYM001
2024-04-07	17:47:00+02	20:06:00+02	VST004521	USR0376	GYM005
2023-04-30	12:35:00+02	15:18:00+02	VST004522	USR0158	GYM002
2023-05-08	11:07:00+02	12:35:00+02	VST004523	USR0302	GYM005
2024-12-23	11:14:00+02	13:02:00+02	VST004524	USR0204	GYM006
2024-06-06	16:30:00+02	17:22:00+02	VST004525	USR0477	GYM002
2024-11-18	11:24:00+02	13:12:00+02	VST004526	USR0149	GYM004
2024-10-06	12:00:00+02	14:14:00+02	VST004527	USR0075	GYM002
2023-11-21	12:07:00+02	13:57:00+02	VST004528	USR0380	GYM002
2023-11-16	12:31:00+02	13:24:00+02	VST004529	USR0229	GYM004
2024-05-20	11:31:00+02	12:21:00+02	VST004530	USR0304	GYM005
2024-06-09	11:54:00+02	12:43:00+02	VST004531	USR0062	GYM004
2023-02-19	11:27:00+02	12:58:00+02	VST004532	USR0058	GYM006
2024-08-06	12:15:00+02	13:08:00+02	VST004533	USR0274	GYM001
2023-03-10	14:04:00+02	15:16:00+02	VST004534	USR0108	GYM001
2024-01-26	10:39:00+02	13:36:00+02	VST004535	USR0187	GYM002
2024-01-18	09:49:00+02	10:33:00+02	VST004536	USR0475	GYM004
2023-01-16	10:02:00+02	10:53:00+02	VST004537	USR0229	GYM004
2024-03-14	09:20:00+02	11:03:00+02	VST004538	USR0048	GYM004
2024-07-21	16:24:00+02	19:15:00+02	VST004539	USR0319	GYM006
2024-09-08	08:06:00+02	10:42:00+02	VST004540	USR0268	GYM006
2023-05-12	17:14:00+02	17:46:00+02	VST004541	USR0215	GYM005
2024-07-13	08:43:00+02	11:01:00+02	VST004542	USR0290	GYM003
2023-09-05	16:13:00+02	18:53:00+02	VST004543	USR0254	GYM003
2023-09-30	14:20:00+02	15:24:00+02	VST004544	USR0445	GYM003
2024-09-14	13:22:00+02	15:54:00+02	VST004545	USR0358	GYM005
2023-12-15	16:24:00+02	19:01:00+02	VST004546	USR0087	GYM004
2024-04-28	17:48:00+02	20:29:00+02	VST004547	USR0181	GYM003
2024-07-03	12:41:00+02	15:27:00+02	VST004548	USR0025	GYM004
2023-12-23	16:22:00+02	17:23:00+02	VST004549	USR0446	GYM002
2023-11-14	11:07:00+02	13:20:00+02	VST004550	USR0388	GYM003
2024-09-24	16:43:00+02	17:16:00+02	VST004551	USR0222	GYM002
2023-02-17	12:46:00+02	14:04:00+02	VST004552	USR0478	GYM005
2023-01-10	14:47:00+02	15:18:00+02	VST004553	USR0397	GYM001
2023-08-21	11:47:00+02	14:05:00+02	VST004554	USR0426	GYM006
2023-02-05	17:50:00+02	20:36:00+02	VST004555	USR0049	GYM005
2024-02-17	10:11:00+02	12:09:00+02	VST004556	USR0334	GYM005
2024-04-06	08:55:00+02	10:27:00+02	VST004557	USR0440	GYM005
2023-01-04	16:58:00+02	19:43:00+02	VST004558	USR0175	GYM003
2023-02-13	15:13:00+02	15:53:00+02	VST004559	USR0392	GYM002
2024-07-21	16:09:00+02	18:33:00+02	VST004560	USR0311	GYM006
2024-07-07	17:13:00+02	18:26:00+02	VST004561	USR0472	GYM003
2023-09-12	08:33:00+02	11:17:00+02	VST004562	USR0274	GYM001
2023-04-24	16:34:00+02	18:01:00+02	VST004563	USR0035	GYM006
2024-02-01	13:55:00+02	15:09:00+02	VST004564	USR0217	GYM005
2023-06-23	14:43:00+02	15:32:00+02	VST004565	USR0209	GYM004
2023-09-12	10:58:00+02	13:01:00+02	VST004566	USR0160	GYM001
2024-04-10	15:48:00+02	16:52:00+02	VST004567	USR0408	GYM002
2023-10-04	10:03:00+02	12:44:00+02	VST004568	USR0007	GYM001
2024-04-08	16:50:00+02	18:50:00+02	VST004569	USR0269	GYM003
2024-05-16	15:51:00+02	16:34:00+02	VST004570	USR0126	GYM004
2024-03-16	13:23:00+02	15:41:00+02	VST004571	USR0475	GYM003
2023-03-10	08:08:00+02	10:44:00+02	VST004572	USR0368	GYM006
2024-05-23	08:12:00+02	10:19:00+02	VST004573	USR0325	GYM005
2023-11-22	11:35:00+02	12:48:00+02	VST004574	USR0356	GYM005
2023-03-08	14:28:00+02	16:33:00+02	VST004575	USR0090	GYM001
2023-10-31	17:54:00+02	18:52:00+02	VST004576	USR0042	GYM005
2024-04-28	09:43:00+02	11:39:00+02	VST004577	USR0365	GYM005
2024-07-01	13:33:00+02	15:06:00+02	VST004578	USR0159	GYM006
2024-02-21	14:10:00+02	16:58:00+02	VST004579	USR0202	GYM002
2023-06-08	12:25:00+02	13:25:00+02	VST004580	USR0366	GYM002
2023-05-29	11:11:00+02	12:55:00+02	VST004581	USR0282	GYM003
2023-01-27	17:21:00+02	19:07:00+02	VST004582	USR0470	GYM003
2024-08-06	12:29:00+02	15:02:00+02	VST004583	USR0332	GYM002
2023-09-05	12:02:00+02	13:47:00+02	VST004584	USR0288	GYM001
2023-04-11	12:35:00+02	14:12:00+02	VST004585	USR0091	GYM002
2024-12-02	16:02:00+02	17:26:00+02	VST004586	USR0481	GYM003
2023-04-06	13:51:00+02	14:21:00+02	VST004587	USR0125	GYM004
2024-01-19	14:14:00+02	17:09:00+02	VST004588	USR0126	GYM005
2023-10-09	11:08:00+02	13:18:00+02	VST004589	USR0052	GYM006
2023-11-18	16:30:00+02	17:55:00+02	VST004590	USR0404	GYM004
2024-01-31	15:14:00+02	17:02:00+02	VST004591	USR0103	GYM004
2023-10-05	11:35:00+02	14:16:00+02	VST004592	USR0361	GYM005
2024-06-12	15:09:00+02	15:48:00+02	VST004593	USR0424	GYM002
2023-09-20	14:21:00+02	16:49:00+02	VST004594	USR0187	GYM001
2024-09-10	14:13:00+02	16:47:00+02	VST004595	USR0205	GYM004
2024-08-02	14:50:00+02	15:34:00+02	VST004596	USR0014	GYM001
2024-10-01	12:46:00+02	14:47:00+02	VST004597	USR0428	GYM006
2023-10-20	15:41:00+02	16:12:00+02	VST004598	USR0104	GYM006
2023-10-21	11:04:00+02	13:31:00+02	VST004599	USR0117	GYM006
2024-08-30	17:45:00+02	19:39:00+02	VST004600	USR0470	GYM003
2024-01-30	10:14:00+02	12:00:00+02	VST004601	USR0466	GYM004
2024-05-27	17:49:00+02	19:49:00+02	VST004602	USR0304	GYM006
2023-06-29	11:54:00+02	12:51:00+02	VST004603	USR0093	GYM003
2024-11-23	09:42:00+02	10:13:00+02	VST004604	USR0427	GYM006
2023-08-23	12:36:00+02	14:35:00+02	VST004605	USR0144	GYM002
2023-12-03	12:01:00+02	13:18:00+02	VST004606	USR0110	GYM004
2023-01-08	17:28:00+02	19:40:00+02	VST004607	USR0163	GYM003
2024-03-18	15:22:00+02	17:22:00+02	VST004608	USR0053	GYM006
2024-06-22	14:30:00+02	15:02:00+02	VST004609	USR0418	GYM003
2024-10-19	11:20:00+02	12:15:00+02	VST004610	USR0003	GYM006
2023-04-01	10:29:00+02	12:49:00+02	VST004611	USR0068	GYM002
2023-09-29	10:33:00+02	13:08:00+02	VST004612	USR0246	GYM001
2023-01-05	16:04:00+02	17:24:00+02	VST004613	USR0389	GYM006
2024-08-16	08:09:00+02	09:00:00+02	VST004614	USR0138	GYM001
2023-08-07	11:00:00+02	13:45:00+02	VST004615	USR0308	GYM004
2023-04-28	15:11:00+02	17:52:00+02	VST004616	USR0413	GYM002
2024-08-15	16:31:00+02	17:40:00+02	VST004617	USR0352	GYM004
2024-08-04	10:17:00+02	12:32:00+02	VST004618	USR0287	GYM001
2023-04-25	16:49:00+02	17:50:00+02	VST004619	USR0066	GYM002
2023-09-20	17:06:00+02	19:40:00+02	VST004620	USR0460	GYM005
2023-11-02	13:23:00+02	13:54:00+02	VST004621	USR0347	GYM002
2024-10-15	16:18:00+02	17:27:00+02	VST004622	USR0325	GYM002
2024-02-26	13:07:00+02	14:41:00+02	VST004623	USR0421	GYM005
2023-07-26	12:16:00+02	13:43:00+02	VST004624	USR0155	GYM003
2024-09-14	17:35:00+02	20:05:00+02	VST004625	USR0087	GYM003
2023-10-30	17:41:00+02	19:52:00+02	VST004626	USR0033	GYM003
2023-04-22	08:48:00+02	10:53:00+02	VST004627	USR0068	GYM001
2024-02-21	14:47:00+02	16:33:00+02	VST004628	USR0187	GYM002
2024-07-08	09:41:00+02	11:44:00+02	VST004629	USR0192	GYM006
2023-10-12	10:47:00+02	13:06:00+02	VST004630	USR0213	GYM005
2024-10-01	09:01:00+02	10:17:00+02	VST004631	USR0088	GYM006
2023-07-04	11:40:00+02	14:27:00+02	VST004632	USR0428	GYM001
2023-08-09	12:20:00+02	13:58:00+02	VST004633	USR0351	GYM005
2024-03-19	16:07:00+02	17:04:00+02	VST004634	USR0108	GYM006
2023-04-27	09:38:00+02	12:00:00+02	VST004635	USR0240	GYM001
2023-03-11	15:40:00+02	18:02:00+02	VST004636	USR0216	GYM001
2023-03-11	13:42:00+02	14:53:00+02	VST004637	USR0177	GYM001
2024-09-13	12:26:00+02	13:31:00+02	VST004638	USR0053	GYM005
2024-03-02	14:09:00+02	16:09:00+02	VST004639	USR0330	GYM006
2024-10-05	14:08:00+02	16:29:00+02	VST004640	USR0049	GYM006
2024-07-21	17:33:00+02	18:04:00+02	VST004641	USR0369	GYM004
2024-03-18	17:30:00+02	19:31:00+02	VST004642	USR0114	GYM001
2024-08-23	12:23:00+02	13:43:00+02	VST004643	USR0450	GYM003
2023-05-17	13:52:00+02	14:50:00+02	VST004644	USR0095	GYM002
2024-05-18	08:20:00+02	09:38:00+02	VST004645	USR0447	GYM004
2023-05-11	15:01:00+02	16:43:00+02	VST004646	USR0025	GYM004
2023-08-06	10:04:00+02	10:44:00+02	VST004647	USR0132	GYM005
2024-11-18	13:59:00+02	15:03:00+02	VST004648	USR0179	GYM004
2023-06-20	11:23:00+02	13:34:00+02	VST004649	USR0395	GYM006
2024-04-19	17:50:00+02	20:07:00+02	VST004650	USR0145	GYM005
2024-09-03	17:49:00+02	19:43:00+02	VST004651	USR0364	GYM005
2023-05-09	17:11:00+02	17:49:00+02	VST004652	USR0450	GYM003
2023-02-26	10:58:00+02	12:09:00+02	VST004653	USR0198	GYM001
2023-06-30	12:51:00+02	14:11:00+02	VST004654	USR0457	GYM004
2023-09-03	14:03:00+02	16:35:00+02	VST004655	USR0325	GYM001
2023-05-24	13:32:00+02	15:10:00+02	VST004656	USR0084	GYM001
2023-02-20	16:42:00+02	17:42:00+02	VST004657	USR0157	GYM001
2024-01-03	16:19:00+02	18:36:00+02	VST004658	USR0085	GYM005
2024-04-03	15:37:00+02	18:12:00+02	VST004659	USR0457	GYM001
2023-08-06	09:20:00+02	12:10:00+02	VST004660	USR0476	GYM004
2024-09-07	14:30:00+02	17:06:00+02	VST004661	USR0253	GYM005
2024-07-20	12:53:00+02	13:55:00+02	VST004662	USR0375	GYM004
2023-09-14	15:54:00+02	17:47:00+02	VST004663	USR0072	GYM005
2023-06-05	10:28:00+02	12:40:00+02	VST004664	USR0223	GYM002
2024-07-18	10:51:00+02	13:29:00+02	VST004665	USR0276	GYM002
2024-03-17	13:45:00+02	15:54:00+02	VST004666	USR0283	GYM002
2024-11-29	15:11:00+02	16:14:00+02	VST004667	USR0264	GYM002
2024-10-23	17:45:00+02	18:43:00+02	VST004668	USR0246	GYM005
2024-12-23	14:54:00+02	15:51:00+02	VST004669	USR0341	GYM001
2023-01-25	09:13:00+02	09:48:00+02	VST004670	USR0061	GYM003
2024-10-25	09:21:00+02	10:23:00+02	VST004671	USR0412	GYM006
2024-06-19	10:45:00+02	11:54:00+02	VST004672	USR0471	GYM003
2023-03-01	13:51:00+02	15:49:00+02	VST004673	USR0454	GYM002
2024-04-11	11:53:00+02	14:31:00+02	VST004674	USR0259	GYM001
2024-03-09	13:21:00+02	13:54:00+02	VST004675	USR0453	GYM004
2023-03-07	13:24:00+02	14:54:00+02	VST004676	USR0457	GYM001
2024-07-18	12:58:00+02	13:41:00+02	VST004677	USR0007	GYM004
2023-04-16	12:33:00+02	14:30:00+02	VST004678	USR0188	GYM003
2023-04-06	14:44:00+02	17:03:00+02	VST004679	USR0004	GYM001
2024-11-18	12:37:00+02	13:09:00+02	VST004680	USR0231	GYM001
2024-07-04	15:35:00+02	17:56:00+02	VST004681	USR0133	GYM006
2023-06-17	14:11:00+02	16:43:00+02	VST004682	USR0395	GYM003
2023-02-11	16:53:00+02	18:37:00+02	VST004683	USR0125	GYM001
2023-04-14	15:41:00+02	17:23:00+02	VST004684	USR0015	GYM004
2023-07-23	15:03:00+02	17:37:00+02	VST004685	USR0448	GYM001
2024-06-03	10:51:00+02	11:42:00+02	VST004686	USR0482	GYM004
2023-10-09	11:08:00+02	13:27:00+02	VST004687	USR0013	GYM002
2023-02-12	08:23:00+02	09:56:00+02	VST004688	USR0118	GYM001
2023-04-20	10:08:00+02	11:17:00+02	VST004689	USR0240	GYM004
2023-07-29	12:00:00+02	14:40:00+02	VST004690	USR0263	GYM003
2023-02-18	12:17:00+02	13:34:00+02	VST004691	USR0360	GYM002
2023-04-25	09:21:00+02	10:54:00+02	VST004692	USR0006	GYM001
2023-06-04	11:35:00+02	13:16:00+02	VST004693	USR0440	GYM006
2024-10-10	10:50:00+02	11:49:00+02	VST004694	USR0320	GYM004
2024-05-17	14:46:00+02	16:23:00+02	VST004695	USR0231	GYM006
2024-11-09	09:45:00+02	11:18:00+02	VST004696	USR0434	GYM001
2024-12-11	09:37:00+02	11:56:00+02	VST004697	USR0030	GYM004
2023-03-12	09:05:00+02	10:25:00+02	VST004698	USR0022	GYM001
2024-06-02	16:04:00+02	18:35:00+02	VST004699	USR0409	GYM002
2024-12-12	17:21:00+02	18:17:00+02	VST004700	USR0156	GYM002
2023-12-02	08:55:00+02	11:33:00+02	VST004701	USR0118	GYM001
2023-03-08	08:26:00+02	09:42:00+02	VST004702	USR0340	GYM001
2024-05-07	14:46:00+02	16:04:00+02	VST004703	USR0423	GYM005
2024-10-11	16:56:00+02	18:04:00+02	VST004704	USR0451	GYM001
2023-08-01	09:25:00+02	10:53:00+02	VST004705	USR0389	GYM001
2023-06-30	09:46:00+02	10:46:00+02	VST004706	USR0193	GYM006
2024-09-04	12:28:00+02	13:31:00+02	VST004707	USR0399	GYM006
2024-08-21	10:39:00+02	12:51:00+02	VST004708	USR0346	GYM002
2024-11-27	09:26:00+02	10:05:00+02	VST004709	USR0195	GYM006
2024-08-25	14:39:00+02	16:19:00+02	VST004710	USR0168	GYM001
2023-09-05	13:16:00+02	14:35:00+02	VST004711	USR0377	GYM003
2023-08-02	11:54:00+02	13:01:00+02	VST004712	USR0489	GYM001
2023-12-25	12:13:00+02	14:32:00+02	VST004713	USR0239	GYM005
2023-09-06	12:50:00+02	13:24:00+02	VST004714	USR0362	GYM004
2024-09-29	15:33:00+02	16:54:00+02	VST004715	USR0482	GYM002
2024-05-30	10:09:00+02	11:02:00+02	VST004716	USR0244	GYM006
2023-03-29	10:14:00+02	10:57:00+02	VST004717	USR0069	GYM003
2024-10-24	16:59:00+02	19:06:00+02	VST004718	USR0095	GYM004
2023-06-25	10:54:00+02	13:08:00+02	VST004719	USR0499	GYM003
2024-12-23	08:29:00+02	11:13:00+02	VST004720	USR0077	GYM002
2024-03-01	08:35:00+02	10:23:00+02	VST004721	USR0171	GYM006
2024-08-25	14:05:00+02	15:34:00+02	VST004722	USR0001	GYM005
2024-12-03	13:33:00+02	14:59:00+02	VST004723	USR0406	GYM002
2023-03-22	16:07:00+02	18:03:00+02	VST004724	USR0062	GYM003
2023-05-18	15:58:00+02	18:17:00+02	VST004725	USR0207	GYM003
2024-03-08	17:13:00+02	19:45:00+02	VST004726	USR0154	GYM002
2024-04-14	12:38:00+02	13:23:00+02	VST004727	USR0274	GYM001
2023-12-16	17:21:00+02	20:01:00+02	VST004728	USR0048	GYM002
2023-05-06	15:35:00+02	17:54:00+02	VST004729	USR0137	GYM006
2023-11-05	10:18:00+02	11:01:00+02	VST004730	USR0001	GYM006
2023-08-18	17:12:00+02	18:59:00+02	VST004731	USR0235	GYM005
2024-04-04	11:01:00+02	11:59:00+02	VST004732	USR0393	GYM002
2023-12-11	15:47:00+02	17:25:00+02	VST004733	USR0256	GYM004
2023-11-06	17:37:00+02	19:40:00+02	VST004734	USR0407	GYM006
2023-01-20	15:25:00+02	17:06:00+02	VST004735	USR0107	GYM006
2024-07-14	16:56:00+02	18:55:00+02	VST004736	USR0173	GYM006
2024-10-08	17:06:00+02	19:23:00+02	VST004737	USR0130	GYM001
2024-06-24	13:17:00+02	14:50:00+02	VST004738	USR0398	GYM004
2024-07-13	13:55:00+02	15:46:00+02	VST004739	USR0294	GYM002
2024-04-21	16:13:00+02	16:55:00+02	VST004740	USR0040	GYM001
2023-09-26	17:12:00+02	18:28:00+02	VST004741	USR0447	GYM006
2023-01-03	11:52:00+02	12:32:00+02	VST004742	USR0338	GYM004
2023-01-16	09:31:00+02	10:01:00+02	VST004743	USR0016	GYM004
2024-08-28	15:32:00+02	16:15:00+02	VST004744	USR0127	GYM001
2023-12-24	13:15:00+02	15:07:00+02	VST004745	USR0373	GYM006
2024-10-07	14:14:00+02	15:38:00+02	VST004746	USR0349	GYM001
2023-05-13	15:02:00+02	16:45:00+02	VST004747	USR0492	GYM003
2023-11-08	12:26:00+02	14:56:00+02	VST004748	USR0203	GYM006
2024-04-26	10:39:00+02	12:20:00+02	VST004749	USR0134	GYM001
2024-06-27	13:10:00+02	14:05:00+02	VST004750	USR0259	GYM002
2023-11-01	08:10:00+02	10:30:00+02	VST004751	USR0014	GYM006
2023-09-26	08:00:00+02	09:17:00+02	VST004752	USR0066	GYM005
2024-02-18	16:55:00+02	18:29:00+02	VST004753	USR0480	GYM006
2023-01-25	10:19:00+02	12:54:00+02	VST004754	USR0351	GYM003
2023-11-12	13:52:00+02	15:55:00+02	VST004755	USR0459	GYM001
2024-07-24	12:53:00+02	14:48:00+02	VST004756	USR0342	GYM005
2024-12-25	16:00:00+02	17:47:00+02	VST004757	USR0195	GYM003
2024-10-29	17:07:00+02	18:05:00+02	VST004758	USR0114	GYM002
2023-10-03	08:08:00+02	09:02:00+02	VST004759	USR0159	GYM006
2024-01-24	16:23:00+02	16:56:00+02	VST004760	USR0161	GYM005
2024-12-22	16:08:00+02	18:59:00+02	VST004761	USR0254	GYM001
2024-03-19	13:06:00+02	14:09:00+02	VST004762	USR0472	GYM001
2024-03-02	08:09:00+02	10:03:00+02	VST004763	USR0385	GYM002
2023-02-26	15:20:00+02	17:22:00+02	VST004764	USR0428	GYM003
2024-11-27	12:59:00+02	15:01:00+02	VST004765	USR0015	GYM005
2024-07-19	11:56:00+02	14:56:00+02	VST004766	USR0037	GYM002
2024-12-21	08:07:00+02	10:52:00+02	VST004767	USR0155	GYM003
2024-01-03	17:21:00+02	19:26:00+02	VST004768	USR0486	GYM004
2023-12-08	14:22:00+02	15:52:00+02	VST004769	USR0432	GYM004
2023-10-31	11:13:00+02	12:53:00+02	VST004770	USR0027	GYM003
2024-01-09	15:01:00+02	16:24:00+02	VST004771	USR0492	GYM001
2023-04-22	17:34:00+02	20:33:00+02	VST004772	USR0012	GYM001
2023-01-06	15:27:00+02	17:35:00+02	VST004773	USR0067	GYM004
2024-12-03	14:44:00+02	15:36:00+02	VST004774	USR0030	GYM001
2023-10-06	12:15:00+02	13:12:00+02	VST004775	USR0096	GYM001
2024-01-17	10:47:00+02	11:50:00+02	VST004776	USR0215	GYM003
2023-01-13	14:39:00+02	15:39:00+02	VST004777	USR0194	GYM006
2023-10-30	14:27:00+02	15:07:00+02	VST004778	USR0135	GYM003
2024-07-09	11:45:00+02	14:45:00+02	VST004779	USR0290	GYM001
2024-09-08	12:29:00+02	13:47:00+02	VST004780	USR0032	GYM003
2023-06-09	09:21:00+02	10:40:00+02	VST004781	USR0373	GYM005
2023-06-03	15:12:00+02	17:36:00+02	VST004782	USR0039	GYM004
2023-06-30	12:05:00+02	13:00:00+02	VST004783	USR0352	GYM006
2024-06-09	16:49:00+02	17:38:00+02	VST004784	USR0427	GYM005
2023-06-29	12:38:00+02	15:27:00+02	VST004785	USR0427	GYM005
2024-01-12	12:51:00+02	14:48:00+02	VST004786	USR0206	GYM001
2023-06-17	17:04:00+02	18:51:00+02	VST004787	USR0387	GYM001
2023-08-02	12:35:00+02	15:06:00+02	VST004788	USR0430	GYM005
2023-05-30	15:02:00+02	16:23:00+02	VST004789	USR0416	GYM005
2023-01-16	11:12:00+02	13:58:00+02	VST004790	USR0043	GYM002
2023-04-01	09:10:00+02	10:19:00+02	VST004791	USR0484	GYM002
2023-04-30	11:06:00+02	11:47:00+02	VST004792	USR0337	GYM004
2023-09-10	10:19:00+02	11:21:00+02	VST004793	USR0496	GYM005
2023-03-01	12:56:00+02	14:15:00+02	VST004794	USR0259	GYM003
2023-09-23	09:53:00+02	12:10:00+02	VST004795	USR0249	GYM006
2024-02-13	15:46:00+02	18:36:00+02	VST004796	USR0074	GYM002
2023-01-31	15:43:00+02	17:17:00+02	VST004797	USR0373	GYM001
2023-01-21	12:38:00+02	15:31:00+02	VST004798	USR0319	GYM005
2024-12-31	16:23:00+02	18:21:00+02	VST004799	USR0367	GYM003
2024-08-15	11:12:00+02	13:15:00+02	VST004800	USR0296	GYM006
2023-10-16	13:28:00+02	15:52:00+02	VST004801	USR0274	GYM003
2024-06-26	08:19:00+02	09:19:00+02	VST004802	USR0323	GYM003
2024-05-12	10:35:00+02	12:56:00+02	VST004803	USR0359	GYM001
2024-04-18	08:50:00+02	09:37:00+02	VST004804	USR0190	GYM002
2024-02-09	17:07:00+02	19:40:00+02	VST004805	USR0138	GYM003
2024-07-01	08:22:00+02	10:39:00+02	VST004806	USR0436	GYM006
2023-05-12	11:10:00+02	13:54:00+02	VST004807	USR0457	GYM002
2023-11-20	09:44:00+02	12:22:00+02	VST004808	USR0302	GYM004
2023-05-12	12:48:00+02	13:23:00+02	VST004809	USR0311	GYM001
2024-06-04	12:35:00+02	13:47:00+02	VST004810	USR0430	GYM002
2023-01-30	10:08:00+02	11:48:00+02	VST004811	USR0331	GYM002
2024-09-18	15:28:00+02	16:31:00+02	VST004812	USR0444	GYM003
2023-10-28	08:08:00+02	09:52:00+02	VST004813	USR0353	GYM006
2023-01-04	11:58:00+02	12:39:00+02	VST004814	USR0484	GYM003
2023-11-21	09:32:00+02	12:26:00+02	VST004815	USR0282	GYM006
2024-05-23	10:34:00+02	11:19:00+02	VST004816	USR0411	GYM001
2023-08-25	08:15:00+02	09:33:00+02	VST004817	USR0166	GYM002
2024-06-18	16:25:00+02	18:36:00+02	VST004818	USR0278	GYM005
2023-01-16	11:42:00+02	14:18:00+02	VST004819	USR0026	GYM006
2024-06-17	13:50:00+02	16:36:00+02	VST004820	USR0470	GYM006
2024-08-06	15:10:00+02	17:51:00+02	VST004821	USR0453	GYM003
2024-03-21	13:19:00+02	14:08:00+02	VST004822	USR0419	GYM003
2024-05-17	16:30:00+02	17:42:00+02	VST004823	USR0450	GYM004
2023-08-18	14:20:00+02	16:42:00+02	VST004824	USR0483	GYM006
2023-04-17	15:54:00+02	18:34:00+02	VST004825	USR0073	GYM001
2024-12-20	08:32:00+02	10:40:00+02	VST004826	USR0115	GYM002
2024-01-24	13:38:00+02	16:31:00+02	VST004827	USR0051	GYM002
2024-12-20	09:22:00+02	11:31:00+02	VST004828	USR0369	GYM002
2023-09-20	10:29:00+02	12:41:00+02	VST004829	USR0402	GYM006
2024-07-16	08:57:00+02	10:36:00+02	VST004830	USR0171	GYM003
2023-03-06	12:32:00+02	13:54:00+02	VST004831	USR0268	GYM001
2023-09-22	14:41:00+02	15:58:00+02	VST004832	USR0003	GYM002
2023-12-04	09:13:00+02	09:43:00+02	VST004833	USR0210	GYM006
2023-10-28	17:16:00+02	18:26:00+02	VST004834	USR0376	GYM005
2024-01-13	16:01:00+02	18:57:00+02	VST004835	USR0486	GYM004
2023-06-24	11:05:00+02	12:30:00+02	VST004836	USR0391	GYM004
2023-06-01	11:16:00+02	11:48:00+02	VST004837	USR0481	GYM002
2024-04-20	12:16:00+02	14:57:00+02	VST004838	USR0390	GYM003
2023-09-23	14:30:00+02	16:56:00+02	VST004839	USR0338	GYM004
2023-11-25	08:12:00+02	10:50:00+02	VST004840	USR0301	GYM004
2023-06-12	10:04:00+02	12:48:00+02	VST004841	USR0383	GYM004
2024-03-13	12:14:00+02	13:50:00+02	VST004842	USR0342	GYM004
2023-12-09	14:34:00+02	16:21:00+02	VST004843	USR0115	GYM002
2024-01-02	15:33:00+02	16:59:00+02	VST004844	USR0167	GYM006
2024-04-09	12:13:00+02	13:58:00+02	VST004845	USR0435	GYM001
2023-07-18	08:34:00+02	10:12:00+02	VST004846	USR0265	GYM001
2024-05-14	11:23:00+02	14:14:00+02	VST004847	USR0227	GYM003
2023-01-16	15:51:00+02	16:51:00+02	VST004848	USR0151	GYM006
2023-10-23	09:36:00+02	10:49:00+02	VST004849	USR0268	GYM005
2024-05-25	16:53:00+02	18:20:00+02	VST004850	USR0116	GYM001
2023-08-27	11:33:00+02	12:14:00+02	VST004851	USR0088	GYM005
2024-08-03	16:04:00+02	18:50:00+02	VST004852	USR0318	GYM001
2023-10-28	14:38:00+02	16:08:00+02	VST004853	USR0242	GYM001
2023-01-06	13:19:00+02	15:03:00+02	VST004854	USR0360	GYM003
2023-08-08	13:30:00+02	14:10:00+02	VST004855	USR0329	GYM004
2024-03-28	10:42:00+02	11:49:00+02	VST004856	USR0333	GYM003
2024-03-08	08:43:00+02	10:24:00+02	VST004857	USR0040	GYM001
2024-01-21	17:22:00+02	18:26:00+02	VST004858	USR0182	GYM006
2024-09-10	16:53:00+02	18:32:00+02	VST004859	USR0490	GYM004
2023-10-22	10:05:00+02	10:48:00+02	VST004860	USR0209	GYM006
2023-04-28	12:19:00+02	13:52:00+02	VST004861	USR0391	GYM006
2024-02-09	16:12:00+02	17:35:00+02	VST004862	USR0273	GYM006
2024-11-10	13:05:00+02	15:51:00+02	VST004863	USR0119	GYM004
2024-08-16	11:23:00+02	12:22:00+02	VST004864	USR0382	GYM006
2024-07-19	14:09:00+02	14:39:00+02	VST004865	USR0434	GYM004
2023-01-12	08:53:00+02	10:51:00+02	VST004866	USR0024	GYM005
2023-07-28	11:43:00+02	13:47:00+02	VST004867	USR0258	GYM001
2023-06-14	09:55:00+02	11:48:00+02	VST004868	USR0483	GYM002
2023-10-21	12:01:00+02	12:52:00+02	VST004869	USR0092	GYM006
2024-06-02	15:24:00+02	18:14:00+02	VST004870	USR0467	GYM003
2023-03-19	13:32:00+02	15:09:00+02	VST004871	USR0161	GYM005
2024-03-09	08:15:00+02	09:19:00+02	VST004872	USR0149	GYM003
2024-07-30	10:51:00+02	13:05:00+02	VST004873	USR0117	GYM002
2024-09-05	12:42:00+02	14:27:00+02	VST004874	USR0458	GYM004
2024-11-13	17:58:00+02	19:51:00+02	VST004875	USR0053	GYM002
2023-03-18	10:02:00+02	10:46:00+02	VST004876	USR0302	GYM003
2023-02-17	14:45:00+02	15:17:00+02	VST004877	USR0045	GYM002
2023-03-23	12:08:00+02	14:09:00+02	VST004878	USR0265	GYM001
2024-12-21	08:09:00+02	09:35:00+02	VST004879	USR0486	GYM002
2023-07-28	08:43:00+02	10:24:00+02	VST004880	USR0262	GYM006
2024-03-20	17:55:00+02	19:10:00+02	VST004881	USR0307	GYM001
2024-08-18	16:06:00+02	17:41:00+02	VST004882	USR0234	GYM006
2024-06-05	10:38:00+02	11:12:00+02	VST004883	USR0375	GYM002
2023-01-29	14:20:00+02	17:07:00+02	VST004884	USR0035	GYM001
2023-10-31	09:31:00+02	12:30:00+02	VST004885	USR0338	GYM001
2024-04-09	12:14:00+02	13:11:00+02	VST004886	USR0437	GYM002
2024-05-16	10:41:00+02	12:48:00+02	VST004887	USR0403	GYM005
2024-03-21	16:31:00+02	18:06:00+02	VST004888	USR0197	GYM004
2024-09-19	09:33:00+02	12:24:00+02	VST004889	USR0025	GYM004
2024-05-04	13:46:00+02	15:08:00+02	VST004890	USR0395	GYM004
2024-03-03	09:01:00+02	11:24:00+02	VST004891	USR0202	GYM001
2024-07-12	09:01:00+02	10:27:00+02	VST004892	USR0273	GYM004
2023-12-25	14:04:00+02	15:57:00+02	VST004893	USR0036	GYM001
2023-04-01	10:37:00+02	12:15:00+02	VST004894	USR0474	GYM005
2023-02-22	17:09:00+02	18:31:00+02	VST004895	USR0223	GYM002
2024-12-30	09:49:00+02	12:47:00+02	VST004896	USR0352	GYM002
2024-08-11	10:08:00+02	12:19:00+02	VST004897	USR0277	GYM001
2023-07-23	16:19:00+02	17:28:00+02	VST004898	USR0018	GYM001
2024-07-09	11:58:00+02	14:22:00+02	VST004899	USR0188	GYM005
2023-06-05	13:24:00+02	14:53:00+02	VST004900	USR0402	GYM004
2023-01-02	17:31:00+02	19:52:00+02	VST004901	USR0257	GYM005
2023-12-23	13:55:00+02	15:59:00+02	VST004902	USR0142	GYM002
2024-07-22	15:29:00+02	16:36:00+02	VST004903	USR0136	GYM002
2023-02-27	11:17:00+02	13:49:00+02	VST004904	USR0450	GYM006
2023-09-11	08:21:00+02	09:14:00+02	VST004905	USR0307	GYM004
2023-06-29	14:26:00+02	17:02:00+02	VST004906	USR0079	GYM002
2024-05-07	14:06:00+02	15:22:00+02	VST004907	USR0444	GYM006
2024-10-30	10:17:00+02	12:44:00+02	VST004908	USR0418	GYM001
2023-02-04	12:16:00+02	13:33:00+02	VST004909	USR0292	GYM002
2023-03-16	08:40:00+02	09:55:00+02	VST004910	USR0062	GYM003
2023-10-16	16:16:00+02	17:34:00+02	VST004911	USR0129	GYM004
2024-01-06	15:28:00+02	18:23:00+02	VST004912	USR0499	GYM006
2024-08-09	17:32:00+02	20:07:00+02	VST004913	USR0341	GYM004
2023-11-25	13:01:00+02	14:17:00+02	VST004914	USR0298	GYM004
2024-08-12	17:15:00+02	18:57:00+02	VST004915	USR0257	GYM003
2023-10-31	16:21:00+02	16:56:00+02	VST004916	USR0480	GYM005
2024-08-01	11:14:00+02	13:03:00+02	VST004917	USR0212	GYM001
2023-08-09	17:40:00+02	18:51:00+02	VST004918	USR0054	GYM004
2023-06-13	11:11:00+02	12:26:00+02	VST004919	USR0175	GYM002
2024-04-24	17:16:00+02	19:26:00+02	VST004920	USR0100	GYM001
2024-03-30	13:56:00+02	15:14:00+02	VST004921	USR0039	GYM002
2024-01-10	13:31:00+02	14:18:00+02	VST004922	USR0414	GYM001
2023-08-08	15:59:00+02	17:05:00+02	VST004923	USR0263	GYM001
2024-11-14	12:41:00+02	13:29:00+02	VST004924	USR0150	GYM006
2023-09-11	17:27:00+02	19:46:00+02	VST004925	USR0121	GYM002
2024-12-22	10:44:00+02	12:16:00+02	VST004926	USR0178	GYM002
2023-07-07	09:10:00+02	11:36:00+02	VST004927	USR0301	GYM001
2023-07-10	17:03:00+02	19:16:00+02	VST004928	USR0330	GYM004
2024-01-24	10:38:00+02	11:33:00+02	VST004929	USR0120	GYM002
2023-08-03	15:40:00+02	18:24:00+02	VST004930	USR0072	GYM003
2024-01-10	13:02:00+02	14:07:00+02	VST004931	USR0219	GYM003
2023-03-27	12:29:00+02	13:02:00+02	VST004932	USR0394	GYM001
2024-04-18	17:14:00+02	18:09:00+02	VST004933	USR0398	GYM005
2024-09-09	14:15:00+02	16:21:00+02	VST004934	USR0302	GYM001
2024-06-14	15:44:00+02	17:52:00+02	VST004935	USR0123	GYM001
2023-02-16	08:00:00+02	08:35:00+02	VST004936	USR0244	GYM004
2023-03-06	16:38:00+02	17:36:00+02	VST004937	USR0374	GYM004
2024-04-19	14:28:00+02	15:01:00+02	VST004938	USR0075	GYM006
2023-05-26	11:09:00+02	11:50:00+02	VST004939	USR0006	GYM005
2024-01-17	08:19:00+02	09:22:00+02	VST004940	USR0021	GYM005
2023-03-07	14:12:00+02	15:45:00+02	VST004941	USR0190	GYM005
2024-05-31	12:04:00+02	12:55:00+02	VST004942	USR0225	GYM005
2023-04-03	13:28:00+02	15:06:00+02	VST004943	USR0403	GYM005
2024-03-01	09:04:00+02	10:10:00+02	VST004944	USR0103	GYM001
2024-04-12	17:11:00+02	17:44:00+02	VST004945	USR0344	GYM001
2023-04-04	14:36:00+02	15:08:00+02	VST004946	USR0466	GYM006
2024-09-09	11:14:00+02	12:11:00+02	VST004947	USR0099	GYM003
2023-05-13	16:56:00+02	19:44:00+02	VST004948	USR0500	GYM003
2024-03-09	16:29:00+02	18:25:00+02	VST004949	USR0318	GYM006
2023-12-07	17:24:00+02	18:15:00+02	VST004950	USR0363	GYM006
2023-11-10	10:37:00+02	11:58:00+02	VST004951	USR0485	GYM002
2024-08-13	12:49:00+02	13:54:00+02	VST004952	USR0083	GYM001
2023-07-31	13:30:00+02	16:02:00+02	VST004953	USR0181	GYM005
2024-06-03	14:59:00+02	17:53:00+02	VST004954	USR0152	GYM002
2023-06-08	13:29:00+02	15:52:00+02	VST004955	USR0056	GYM004
2023-09-25	09:53:00+02	11:04:00+02	VST004956	USR0190	GYM001
2024-10-22	09:38:00+02	11:26:00+02	VST004957	USR0418	GYM006
2024-08-25	16:55:00+02	18:49:00+02	VST004958	USR0022	GYM003
2024-04-18	09:08:00+02	11:40:00+02	VST004959	USR0068	GYM001
2024-02-14	08:44:00+02	09:53:00+02	VST004960	USR0185	GYM006
2024-04-18	10:12:00+02	11:44:00+02	VST004961	USR0010	GYM001
2023-12-22	11:02:00+02	11:46:00+02	VST004962	USR0066	GYM001
2024-11-10	08:32:00+02	11:21:00+02	VST004963	USR0264	GYM001
2023-07-12	11:26:00+02	13:04:00+02	VST004964	USR0225	GYM004
2024-11-29	09:49:00+02	12:38:00+02	VST004965	USR0123	GYM003
2023-09-28	16:17:00+02	17:18:00+02	VST004966	USR0038	GYM001
2023-04-24	11:16:00+02	11:51:00+02	VST004967	USR0491	GYM006
2024-06-06	09:41:00+02	10:22:00+02	VST004968	USR0123	GYM004
2023-02-24	08:32:00+02	09:28:00+02	VST004969	USR0318	GYM002
2023-03-06	17:44:00+02	20:33:00+02	VST004970	USR0156	GYM001
2024-11-14	14:37:00+02	16:22:00+02	VST004971	USR0394	GYM004
2023-09-29	16:21:00+02	17:17:00+02	VST004972	USR0301	GYM005
2024-05-16	16:58:00+02	19:38:00+02	VST004973	USR0321	GYM002
2024-10-23	12:22:00+02	14:38:00+02	VST004974	USR0482	GYM003
2023-12-28	08:50:00+02	09:56:00+02	VST004975	USR0067	GYM001
2023-05-26	14:15:00+02	14:45:00+02	VST004976	USR0393	GYM001
2023-07-28	11:46:00+02	13:13:00+02	VST004977	USR0133	GYM004
2023-10-13	09:12:00+02	09:48:00+02	VST004978	USR0362	GYM003
2023-01-10	08:13:00+02	09:41:00+02	VST004979	USR0394	GYM005
2023-07-05	11:33:00+02	13:52:00+02	VST004980	USR0140	GYM002
2024-07-27	16:23:00+02	18:31:00+02	VST004981	USR0082	GYM006
2024-08-19	09:21:00+02	10:28:00+02	VST004982	USR0058	GYM003
2024-04-08	15:59:00+02	17:59:00+02	VST004983	USR0149	GYM001
2023-05-14	09:02:00+02	10:45:00+02	VST004984	USR0405	GYM004
2023-06-20	14:09:00+02	15:36:00+02	VST004985	USR0449	GYM005
2023-08-01	17:31:00+02	19:39:00+02	VST004986	USR0131	GYM004
2024-06-13	15:05:00+02	16:03:00+02	VST004987	USR0069	GYM002
2024-05-16	14:17:00+02	16:52:00+02	VST004988	USR0345	GYM003
2024-07-25	08:59:00+02	10:12:00+02	VST004989	USR0250	GYM004
2024-08-22	12:32:00+02	13:30:00+02	VST004990	USR0320	GYM006
2023-01-27	17:01:00+02	18:28:00+02	VST004991	USR0177	GYM006
2023-03-09	08:41:00+02	09:37:00+02	VST004992	USR0072	GYM004
2024-02-12	09:12:00+02	10:54:00+02	VST004993	USR0017	GYM001
2024-07-05	13:11:00+02	15:12:00+02	VST004994	USR0329	GYM004
2023-04-19	09:19:00+02	10:08:00+02	VST004995	USR0160	GYM005
2023-03-15	11:41:00+02	13:36:00+02	VST004996	USR0070	GYM003
2024-07-31	16:51:00+02	17:51:00+02	VST004997	USR0113	GYM002
2024-11-10	09:39:00+02	11:41:00+02	VST004998	USR0232	GYM006
2023-09-19	09:43:00+02	10:34:00+02	VST004999	USR0021	GYM004
2024-01-03	11:56:00+02	12:37:00+02	VST005000	USR0135	GYM005
\.


--
-- TOC entry 4798 (class 2606 OID 16506)
-- Name: business_values_labels Business_values_labels_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.business_values_labels
    ADD CONSTRAINT "Business_values_labels_pkey" PRIMARY KEY (table_name, column_name, label_value);


--
-- TOC entry 4796 (class 2606 OID 16499)
-- Name: definition_business_colonnes Definition_business_colonnes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.definition_business_colonnes
    ADD CONSTRAINT "Definition_business_colonnes_pkey" PRIMARY KEY (table_name, column_name);


--
-- TOC entry 4779 (class 2606 OID 16424)
-- Name: dim_clmbr_prfl DimClmbrPrfl_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_clmbr_prfl
    ADD CONSTRAINT "DimClmbrPrfl_pkey" PRIMARY KEY (user_id);


--
-- TOC entry 4782 (class 2606 OID 16426)
-- Name: dim_gym DimGym_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_gym
    ADD CONSTRAINT "DimGym_pkey" PRIMARY KEY (gym_id);


--
-- TOC entry 4785 (class 2606 OID 16428)
-- Name: dim_mbs DimMbs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_mbs
    ADD CONSTRAINT "DimMbs_pkey" PRIMARY KEY (mem_type_cd);


--
-- TOC entry 4787 (class 2606 OID 16430)
-- Name: dim_rt_catlg DimRtCatlg_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_rt_catlg
    ADD CONSTRAINT "DimRtCatlg_pkey" PRIMARY KEY (rt_id);


--
-- TOC entry 4789 (class 2606 OID 16432)
-- Name: dim_time DimTime_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_time
    ADD CONSTRAINT "DimTime_pkey" PRIMARY KEY (date);


--
-- TOC entry 4791 (class 2606 OID 16438)
-- Name: fact_rt_clmb_log FactRtClmbLog_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_rt_clmb_log
    ADD CONSTRAINT "FactRtClmbLog_pkey" PRIMARY KEY (log_id);


--
-- TOC entry 4774 (class 2606 OID 16442)
-- Name: fact_visit_trx FactVisitTrx_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_visit_trx
    ADD CONSTRAINT "FactVisitTrx_pkey" PRIMARY KEY (visit_id);


--
-- TOC entry 4792 (class 1259 OID 16474)
-- Name: fki_Clmb_FKey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_Clmb_FKey" ON public.fact_rt_clmb_log USING btree (user_id);


--
-- TOC entry 4783 (class 1259 OID 16492)
-- Name: fki_GymRt_FKey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_GymRt_FKey" ON public.dim_gym USING btree (gym_id);


--
-- TOC entry 4775 (class 1259 OID 16462)
-- Name: fki_Gym_FKey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_Gym_FKey" ON public.fact_visit_trx USING btree (gym_id);


--
-- TOC entry 4780 (class 1259 OID 16486)
-- Name: fki_Mbs_FKey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_Mbs_FKey" ON public.dim_clmbr_prfl USING btree (mem_type_cd);


--
-- TOC entry 4793 (class 1259 OID 16480)
-- Name: fki_Rt_FKey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_Rt_FKey" ON public.fact_rt_clmb_log USING btree (rt_id);


--
-- TOC entry 4776 (class 1259 OID 16456)
-- Name: fki_Time_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_Time_fkey" ON public.fact_visit_trx USING btree (visit_date);


--
-- TOC entry 4777 (class 1259 OID 16450)
-- Name: fki_User_Visit_FKey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_User_Visit_FKey" ON public.fact_visit_trx USING btree (user_id);


--
-- TOC entry 4794 (class 1259 OID 16468)
-- Name: fki_Visit_Rt_FKey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_Visit_Rt_FKey" ON public.fact_rt_clmb_log USING btree (visit_id);


--
-- TOC entry 4804 (class 2606 OID 16469)
-- Name: fact_rt_clmb_log Clmb_FKey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_rt_clmb_log
    ADD CONSTRAINT "Clmb_FKey" FOREIGN KEY (user_id) REFERENCES public.dim_clmbr_prfl(user_id) NOT VALID;


--
-- TOC entry 4803 (class 2606 OID 16487)
-- Name: dim_gym GymRt_FKey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_gym
    ADD CONSTRAINT "GymRt_FKey" FOREIGN KEY (gym_id) REFERENCES public.dim_gym(gym_id) NOT VALID;


--
-- TOC entry 4799 (class 2606 OID 16457)
-- Name: fact_visit_trx Gym_FKey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_visit_trx
    ADD CONSTRAINT "Gym_FKey" FOREIGN KEY (gym_id) REFERENCES public.dim_gym(gym_id) NOT VALID;


--
-- TOC entry 4802 (class 2606 OID 16507)
-- Name: dim_clmbr_prfl Mbs_FKey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_clmbr_prfl
    ADD CONSTRAINT "Mbs_FKey" FOREIGN KEY (mem_type_cd) REFERENCES public.dim_mbs(mem_type_cd) NOT VALID;


--
-- TOC entry 4805 (class 2606 OID 16475)
-- Name: fact_rt_clmb_log Rt_FKey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_rt_clmb_log
    ADD CONSTRAINT "Rt_FKey" FOREIGN KEY (rt_id) REFERENCES public.dim_rt_catlg(rt_id) NOT VALID;


--
-- TOC entry 4800 (class 2606 OID 16451)
-- Name: fact_visit_trx Time_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_visit_trx
    ADD CONSTRAINT "Time_fkey" FOREIGN KEY (visit_date) REFERENCES public.dim_time(date) NOT VALID;


--
-- TOC entry 4801 (class 2606 OID 16445)
-- Name: fact_visit_trx User_Visit_FKey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_visit_trx
    ADD CONSTRAINT "User_Visit_FKey" FOREIGN KEY (user_id) REFERENCES public.dim_clmbr_prfl(user_id) NOT VALID;


--
-- TOC entry 4806 (class 2606 OID 16463)
-- Name: fact_rt_clmb_log Visit_Rt_FKey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_rt_clmb_log
    ADD CONSTRAINT "Visit_Rt_FKey" FOREIGN KEY (visit_id) REFERENCES public.fact_visit_trx(visit_id) NOT VALID;


-- Completed on 2025-06-04 08:44:09

--
-- PostgreSQL database dump complete
--

