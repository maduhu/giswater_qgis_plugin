/*
This file is part of Giswater 2.0
The program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
This version of Giswater is provided by Giswater Association
*/

-- ----------------------------
-- Sequences
-- --------------------------

CREATE SEQUENCE "SCHEMA_NAME"."version_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE "SCHEMA_NAME"."cat_node_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE "SCHEMA_NAME"."cat_arc_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


CREATE SEQUENCE "SCHEMA_NAME"."node_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE "SCHEMA_NAME"."arc_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE "SCHEMA_NAME"."connec_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE "SCHEMA_NAME"."vnode_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE "SCHEMA_NAME"."link_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


CREATE SEQUENCE "SCHEMA_NAME"."element_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


CREATE SEQUENCE "SCHEMA_NAME"."element_x_node_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE "SCHEMA_NAME"."element_x_connec_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




-- ----------------------------
-- Table: system structure 
-- ----------------------------

CREATE TABLE "SCHEMA_NAME"."version" (
"id" int4 DEFAULT nextval('"SCHEMA_NAME".version_seq'::regclass) NOT NULL,
"giswater" varchar(16)  ,
"wsoftware" varchar(16)  ,
"postgres" varchar(512)  ,
"postgis" varchar(512)  ,
"date" timestamp(6) DEFAULT now(),
CONSTRAINT version_pkey PRIMARY KEY (id)
);
 
CREATE TABLE "SCHEMA_NAME"."arc_type" (
"id" varchar(18)   NOT NULL,
"type" varchar(18)   NOT NULL,
"epa_default" varchar(18)   NOT NULL,
"man_table" varchar(18)   NOT NULL,
"epa_table" varchar(18)   NOT NULL,
"event_table" varchar(18)   NOT NULL,
CONSTRAINT arc_type_pkey PRIMARY KEY (id)
);

CREATE TABLE "SCHEMA_NAME"."node_type" (
"id" varchar(18)   NOT NULL,
"type" varchar(18)   NOT NULL,
"epa_default" varchar(18)   NOT NULL,
"man_table" varchar(18)   NOT NULL,
"epa_table" varchar(18)   NOT NULL,
"event_table" varchar(18)   NOT NULL,
CONSTRAINT node_type_pkey PRIMARY KEY (id)
);

CREATE TABLE "SCHEMA_NAME"."element_type" (
"id" varchar(18)   NOT NULL,
"event_table" varchar(18)   NOT NULL,
CONSTRAINT element_type_pkey PRIMARY KEY (id)
);


CREATE TABLE "SCHEMA_NAME"."config" (
"id" varchar(18)   NOT NULL,
"node_proximity" double precision,
"arc_searchnodes" double precision,
"node2arc" double precision,
"connec_proximity" double precision,
"arc_toporepair" double precision,
"nodeinsert_arcendpoint" boolean,
"nodeinsert_catalog_vdefault" varchar (30),
"orphannode_delete" boolean,
"vnode_update_tolerance" double precision,
"nodetype_change_enabled" boolean,
CONSTRAINT "config_pkey" PRIMARY KEY ("id")
);



-- ----------------------------
-- Table: Catalogs
-- ----------------------------


CREATE TABLE "SCHEMA_NAME"."cat_mat_arc" (
"id" varchar(30)  ,
"descript" varchar(512)  ,
"roughness" numeric(12,4),
"link" varchar(512)  ,
"url" varchar(512)  ,
"picture" varchar(512)  ,
CONSTRAINT cat_mat_arc_pkey PRIMARY KEY (id)
);

CREATE TABLE "SCHEMA_NAME"."cat_mat_node" (
"id" varchar(30)  ,
"descript" varchar(512)  ,
"roughness" numeric(12,4),
"link" varchar(512)  ,
"url" varchar(512)  ,
"picture" varchar(512)  ,
CONSTRAINT cat_mat_node_pkey PRIMARY KEY (id)
);

CREATE TABLE "SCHEMA_NAME"."cat_arc" (
"id" varchar (30) DEFAULT nextval('"SCHEMA_NAME".cat_arc_seq'::regclass) NOT NULL,
"arctype_id" varchar(16)  ,
"matcat_id" varchar(30)  ,
"pnom" varchar(16)  ,
"dnom" varchar(16)  ,
"dint" numeric(12,5),
"dext" numeric(12,5),
"descript" varchar(512)  ,
"link" varchar(512)  ,
"url" varchar(512)  ,
"picture" varchar(512)  ,
"svg" varchar(50)  ,
CONSTRAINT cat_arc_pkey PRIMARY KEY (id)
);


CREATE TABLE "SCHEMA_NAME"."cat_node" (
"id" varchar (30) DEFAULT nextval('"SCHEMA_NAME".cat_node_seq'::regclass) NOT NULL,
"nodetype_id" varchar(16)  ,
"matcat_id" varchar(30)  ,
"pnom" varchar(16)  ,
"dnom" varchar(16)  ,
"dint" numeric(12,5),
"geometry" varchar(30)  ,
"descript" varchar(512)  ,
"link" varchar(512)  ,
"url" varchar(512)  ,
"picture" varchar(512)  ,
"svg" varchar(50)  ,
CONSTRAINT cat_node_pkey PRIMARY KEY (id)
);


CREATE TABLE "SCHEMA_NAME"."cat_mat_element" (
"id" varchar(30)  ,
"descript" varchar(512)  ,
"link" varchar(512)  ,
"url" varchar(512)  ,
"picture" varchar(512)  ,
CONSTRAINT cat_mat_element_pkey PRIMARY KEY (id)
);


CREATE TABLE "SCHEMA_NAME"."cat_element" (
"id" varchar(30)   NOT NULL,
"elementtype_id" varchar(30)  ,
"matcat_id" varchar(30)  ,
"geometry" varchar(30)  ,
"descript" varchar(512)  ,
"link" varchar(512)  ,
"url" varchar(512)  ,
"picture" varchar(512)  ,
"svg" varchar(50)  ,
CONSTRAINT cat_element_pkey PRIMARY KEY (id)
);


CREATE TABLE "SCHEMA_NAME"."cat_connec" (
"id" varchar(30)   NOT NULL,
"type" varchar(16)  ,
"matcat_id" varchar(16)  ,
"pnom" varchar(16)  ,
"dnom" varchar(16)  ,
"geometry" varchar(30)  ,
"descript" varchar(512)  ,
"link" varchar(512)  ,
"url" varchar(512)  ,
"picture" varchar(512)  ,
"svg" varchar(50)  ,
CONSTRAINT cat_connec_pkey PRIMARY KEY (id)
);


CREATE TABLE "SCHEMA_NAME"."cat_soil" (
"id" varchar(30)   NOT NULL,
"descript" varchar(512)  ,
"link" varchar(512)  ,
"url" varchar(512)  ,
"picture" varchar(512)  ,
CONSTRAINT cat_soil_pkey PRIMARY KEY (id)
);


CREATE TABLE "SCHEMA_NAME"."cat_builder" (
"id" varchar(30)   NOT NULL,
"descript" varchar(512)  ,
"link" varchar(512)  ,
"url" varchar(512)  ,
"picture" varchar(512)  ,
CONSTRAINT cat_builder_pkey PRIMARY KEY (id)
);


CREATE TABLE "SCHEMA_NAME"."cat_work" (
"id" varchar(30)   NOT NULL,
"descript" varchar(512)  ,
"link" varchar(512)  ,
"picture" varchar(512)  ,
CONSTRAINT cat_work_pkey PRIMARY KEY (id)
);


CREATE TABLE "SCHEMA_NAME"."cat_owner" (
"id" varchar(30)   NOT NULL,
"descript" varchar(512)  ,
"link" varchar(512)  ,
"picture" varchar(512)  ,
CONSTRAINT cat_owner_pkey PRIMARY KEY (id)
);



-----------
-- Table: value domain (type)
-----------


CREATE TABLE "SCHEMA_NAME"."man_type_category" (
"id" varchar(20)   NOT NULL,
"observ" varchar(50)  ,
CONSTRAINT man_type_category_pkey PRIMARY KEY (id)
);


CREATE TABLE "SCHEMA_NAME"."man_type_fluid" (
"id" varchar(20)   NOT NULL,
"observ" varchar(50)  ,
CONSTRAINT man_type_fluid_pkey PRIMARY KEY (id)
);


CREATE TABLE "SCHEMA_NAME"."man_type_location" (
"id" varchar(20)   NOT NULL,
"observ" varchar(50)  ,
CONSTRAINT man_type_location_pkey PRIMARY KEY (id)
);


CREATE TABLE "SCHEMA_NAME"."connec_type" (
"id" varchar(20)   NOT NULL,
"observ" varchar(50)  ,
CONSTRAINT connec_type_pkey PRIMARY KEY (id)
);





-- ----------------------------
-- Table: GIS features
-- ----------------------------

CREATE TABLE "SCHEMA_NAME"."sector" (
"sector_id" varchar(30)   NOT NULL,
"descript" varchar(100)  ,
"the_geom" public.geometry (MULTIPOLYGON, SRID_VALUE),
CONSTRAINT sector_pkey PRIMARY KEY (sector_id)
);

CREATE TABLE "SCHEMA_NAME"."node" (
"node_id" varchar(16)   NOT NULL,
"elevation" numeric(12,4),
"depth" numeric(12,4),
"node_type" varchar(30),
"nodecat_id" varchar(30),
"epa_type" varchar(16)  ,
"sector_id" varchar(30)  ,
"state" character varying(16),
"annotation" character varying(254),
"observ" character varying(254),
"comment" character varying(254),
"dma_id" varchar(30)  ,
													-- to INP model
"soilcat_id" varchar(16)  ,
"category_type" varchar(18)  ,
"fluid_type" varchar(18)  ,
"location_type" varchar(18)  ,
"workcat_id" varchar(255)  ,
"buildercat_id" varchar(30)  ,
"builtdate" timestamp (6) without time zone,
"ownercat_id" varchar(30)  ,
													-- to MAN model
"adress_01" varchar(50)  ,
"adress_02" varchar(50)  ,
"adress_03" varchar(50)  ,
"descript" varchar(254)  ,

"rotation" numeric (6,3),
"link" character varying(512),
"verified" varchar(16)  ,
"the_geom" public.geometry (POINT, SRID_VALUE),
CONSTRAINT node_pkey PRIMARY KEY (node_id)
);


CREATE TABLE "SCHEMA_NAME"."arc" (
"arc_id" varchar(16)   NOT NULL,
"node_1" varchar(16)  ,
"node_2" varchar(16)  ,
"arccat_id" varchar(30) ,
"epa_type" varchar(16)  ,
"sector_id" varchar(30)  ,
"state" character varying(16),
"annotation" character varying(254),
"observ" character varying(254),
"comment" character varying(254),
"custom_length" numeric (12,2),
"dma_id" varchar(30)  ,
													-- to INP model
"soilcat_id" varchar(16)  ,
"category_type" varchar(18)  ,
"fluid_type" varchar(18)  ,
"location_type" varchar(18)  ,
"workcat_id" varchar(255)  ,
"buildercat_id" varchar(30)  ,
"builtdate" timestamp (6) without time zone,
"ownercat_id" varchar(30)  ,
													-- to MAN model
"adress_01" varchar(50)  ,
"adress_02" varchar(50)  ,
"adress_03" varchar(50)  ,
"descript" varchar(254)  ,

"rotation" numeric (6,3),
"link" character varying(512),
"verified" varchar(16)  ,
"the_geom" public.geometry (LINESTRING, SRID_VALUE),
CONSTRAINT arc_pkey PRIMARY KEY (arc_id)
);


CREATE TABLE "SCHEMA_NAME"."dma" (
"dma_id" varchar(30)   NOT NULL,
"sector_id" varchar(30)  ,
"descript" varchar(255)  ,
"observ" character varying(512),
"the_geom" public.geometry (MULTIPOLYGON, SRID_VALUE),
CONSTRAINT dma_pkey PRIMARY KEY (dma_id)
);




CREATE TABLE "SCHEMA_NAME"."connec" (
"connec_id" varchar (16) DEFAULT nextval('"SCHEMA_NAME".connec_seq'::regclass) NOT NULL,
"elevation" numeric(12,4),
"depth" numeric(12,4),
"connecat_id" varchar(30),
"sector_id" varchar(30),
"code" varchar(30),
"n_hydrometer" int4,
"demand" numeric(12,8),
"state" character varying(16),
"annotation" character varying(254),
"observ" character varying(254),
"comment" character varying(254),
"rotation" numeric (6,3),
"dma_id" varchar(30),
"soilcat_id" varchar(16),
"category_type" varchar(18)  ,
"fluid_type" varchar(18)  ,
"location_type" varchar(18)  ,
"workcat_id" varchar(255)  ,
"buildercat_id" varchar(30)  ,
"builtdate" varchar(12)  ,
"ownercat_id" varchar(30)  ,
"adress_01" varchar(50)  ,
"adress_02" varchar(50)  ,
"adress_03" varchar(50)  ,
"streetaxis_id" varchar (16)  ,
"postnumber" varchar (16)  ,
"descript" varchar(254)  ,
"link" character varying(512),
"verified" varchar(16)  ,
"the_geom" public.geometry (POINT, SRID_VALUE),
CONSTRAINT connec_pkey PRIMARY KEY (connec_id)
);


CREATE TABLE "SCHEMA_NAME"."vnode" (
"vnode_id" varchar(16) DEFAULT nextval('"SCHEMA_NAME".vnode_seq'::regclass) NOT NULL,
"arc_id" varchar(16),
"userdefined_pos" bool,
"vnode_type" varchar(30),
"sector_id" varchar(30),
"state" varchar(16),
"annotation" varchar(254),
"the_geom" public.geometry (POINT, SRID_VALUE),
CONSTRAINT "vnode_pkey" PRIMARY KEY ("vnode_id")
);



CREATE TABLE "SCHEMA_NAME"."link" (
link_id varchar (16) DEFAULT nextval('"SCHEMA_NAME".link_seq'::regclass) NOT NULL,
the_geom public.geometry (LINESTRING, SRID_VALUE),
connec_id varchar(16)  ,
vnode_id varchar(16)  ,
custom_length numeric (12,3),
CONSTRAINT link_pkey PRIMARY KEY (link_id)
);




-- -----------------------------------
-- Table: Add info of GIS feature 
-- -----------------------------------

CREATE TABLE "SCHEMA_NAME"."man_junction" (
"node_id" varchar(16)   NOT NULL,
"add_info" varchar(255)  ,
CONSTRAINT man_junction_pkey PRIMARY KEY (node_id)
);


CREATE TABLE "SCHEMA_NAME"."man_tank" (
"node_id" varchar(16)   NOT NULL,
"vmax" numeric (12,4),
"area" numeric (12,4),
"add_info" varchar(255)  ,
CONSTRAINT man_tank_pkey PRIMARY KEY (node_id)
);


CREATE TABLE "SCHEMA_NAME"."man_hydrant" (
"node_id" varchar(16)   NOT NULL,
"add_info" varchar(255)  ,
CONSTRAINT man_hydrant_pkey PRIMARY KEY (node_id)
);


CREATE TABLE "SCHEMA_NAME"."man_valve" (
"node_id" varchar(16)   NOT NULL,
"type" varchar(30)  ,
"opened" boolean DEFAULT false,
"acessibility" boolean DEFAULT false,
"broken" boolean DEFAULT false,
"add_info" varchar(255)  ,
CONSTRAINT man_valve_pkey PRIMARY KEY (node_id)
);


CREATE TABLE "SCHEMA_NAME"."man_pump" (
"node_id" varchar(16)   NOT NULL,
"add_info" varchar(255)  ,
CONSTRAINT man_pump_pkey PRIMARY KEY (node_id)
);


CREATE TABLE "SCHEMA_NAME"."man_filter" (
"node_id" varchar(16)   NOT NULL,
"add_info" varchar(255)  ,
CONSTRAINT man_filter_pkey PRIMARY KEY (node_id)
);


CREATE TABLE "SCHEMA_NAME"."man_meter" (
"node_id" varchar(16)   NOT NULL,
"add_info" varchar(255)  ,
CONSTRAINT man_meter_pkey PRIMARY KEY (node_id)
);



CREATE TABLE "SCHEMA_NAME"."man_pipe" (
"arc_id" varchar(16)   NOT NULL,
"add_info" varchar(255)  ,
CONSTRAINT man_pipe_pkey PRIMARY KEY (arc_id)
);



-- ----------------------------------
-- Table: Element
-- ----------------------------------

CREATE TABLE "SCHEMA_NAME"."element" (
"element_id" varchar(16) DEFAULT nextval('"SCHEMA_NAME".element_seq'::regclass) NOT NULL,
"elementcat_id" varchar(30)  ,
"state" character varying(16) NOT NULL,
"annotation" character varying(254),
"observ" character varying(254),
"comment" character varying(254),
"location_type" varchar(18)  ,
"workcat_id" varchar(255)  ,
"buildercat_id" varchar(30)  ,
"builtdate" timestamp (6) without time zone,
"ownercat_id" varchar(30)  ,
"enddate" timestamp (6) without time zone,
"rotation" numeric (6,3),
"link" character varying(512),
"verified" varchar(16)   NOT NULL,
CONSTRAINT element_pkey PRIMARY KEY (element_id)
);


CREATE TABLE "SCHEMA_NAME"."element_x_node" (
"id" varchar(16) DEFAULT nextval('"SCHEMA_NAME".element_x_node_seq'::regclass) NOT NULL,
"element_id" varchar(16)  ,
"node_id" varchar(16)  ,
CONSTRAINT element_x_node_pkey PRIMARY KEY (id)
);


CREATE TABLE "SCHEMA_NAME"."element_x_connec" (
"id" varchar(16) DEFAULT nextval('"SCHEMA_NAME".element_x_connec_seq'::regclass) NOT NULL,
"element_id" varchar(16)  ,
"connec_id" varchar(16)  ,
CONSTRAINT element_x_connec_pkey PRIMARY KEY (id)
);


-- ----------------------------------
-- Table: value domain
-- ----------------------------------

CREATE TABLE "SCHEMA_NAME"."value_state" (
"id" varchar(16)   NOT NULL,
"observ" varchar(254)  ,
 CONSTRAINT value_state_pkey PRIMARY KEY (id)
);


CREATE TABLE "SCHEMA_NAME"."value_verified" (
"id" varchar(16)   NOT NULL,
"observ" varchar(254)  ,
 CONSTRAINT value_verified_pkey PRIMARY KEY (id)
);

CREATE TABLE "SCHEMA_NAME"."value_yesno" (
"id" varchar(16)   NOT NULL,
"observ" varchar(254)  ,
 CONSTRAINT value_yesno_pkey PRIMARY KEY (id)
);


-- ----------------------------------
-- Table: selector
-- ----------------------------------


CREATE TABLE "SCHEMA_NAME"."man_selector_valve" (
"id" varchar(16)   NOT NULL,
 CONSTRAINT man_selector_valve_pkey PRIMARY KEY (id)
);



----------------
-- SPATIAL INDEX
----------------

CREATE INDEX arc_index ON "SCHEMA_NAME".arc USING GIST (the_geom);
CREATE INDEX node_index ON "SCHEMA_NAME".node USING GIST (the_geom);
CREATE INDEX dma_index ON "SCHEMA_NAME".dma USING GIST (the_geom);
CREATE INDEX sector_index ON "SCHEMA_NAME".sector USING GIST (the_geom);
CREATE INDEX connec_index ON "SCHEMA_NAME".connec USING GIST (the_geom);
CREATE INDEX vnode_index ON "SCHEMA_NAME".vnode USING GIST (the_geom);
CREATE INDEX link_index ON "SCHEMA_NAME".link USING GIST (the_geom);

