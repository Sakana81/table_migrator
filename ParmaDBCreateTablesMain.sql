CREATE EXTENSION IF NOT EXISTS postgis;

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE SCHEMA IF NOT EXISTS forest;

CREATE SCHEMA IF NOT EXISTS calculation;

CREATE SCHEMA IF NOT EXISTS catalog;

CREATE SCHEMA IF NOT EXISTS layout;

CREATE TABLE IF NOT EXISTS calculation.Log_Hoz_Sek
(
 "id"            uuid,
 nom_por      integer,
 hoz_sek      integer,
 kat_zasch    text NULL COLLATE pg_catalog."default",
 poroda_prb   text NULL COLLATE pg_catalog."default",
 prois       text NULL COLLATE pg_catalog."default",
 tlu_t       text NULL COLLATE pg_catalog."default",
 tiplesa_t   text NULL COLLATE pg_catalog."default",
 bonitet     text NULL COLLATE pg_catalog."default",
 relief      text NULL COLLATE pg_catalog."default",
 voz_rubki    integer,
 lesohoz_zona text NULL COLLATE pg_catalog."default",
 CONSTRAINT Log_Hoz_Sek_pk_id PRIMARY KEY ( "id" )
);

CREATE TABLE IF NOT EXISTS calculation.Log_Voz_Rub
(
 "id"            uuid,
 voz_rubki_kod integer,
 voz_rubki    integer,
 voz_kls_prod  integer,
 voz_grp_min1  integer,
 voz_grp_min2  integer,
 voz_grp_min3  integer,
 voz_grp_min4  integer,
 voz_grp_min5  integer,
 voz_grp_min6  integer,
 voz_grp_min7  integer,
 CONSTRAINT Log_Voz_Rub_pk_id PRIMARY KEY ( "id" )
);

CREATE TABLE IF NOT EXISTS calculation.Log_Bonitet
(
 "id"              uuid,
 bonitet_nom_tab integer,
 vozrast       integer,
 vysota98      numeric(5,2) NULL,
 vysota99      numeric(5,2) NULL,
 vysota100     numeric(5,2) NULL,
 vysota200     numeric(5,2) NULL,
 vysota300     numeric(5,2) NULL,
 vysota400     numeric(5,2) NULL,
 vysota500     numeric(5,2) NULL,
 vysota501     numeric(5,2) NULL,
 vysota502     numeric(5,2) NULL,
 CONSTRAINT Log_Bonitet_pk_id PRIMARY KEY ( "id" )
);

CREATE TABLE IF NOT EXISTS calculation.Log_Zapas_Ga
(
 "id"            uuid,
 zapas_nom_tab integer,
 vysota      integer,
 zapas_ga     integer,
 CONSTRAINT Log_Zapas_Ga_pk_id PRIMARY KEY ( "id" )
);

CREATE TABLE IF NOT EXISTS catalog.zone
(
 "id"   uuid,
 name character varying(80),
 code integer,
 hidden  boolean NOT NULL DEFAULT false,
 CONSTRAINT zone_id_pk PRIMARY KEY ( "id" )
);

CREATE TABLE IF NOT EXISTS catalog.plot_type
(
 "id"         uuid,
 name       character varying(100),
 code       integer,
 short_title character varying(40),
 hidden  boolean NOT NULL DEFAULT false,
 CONSTRAINT plot_type_id_pk PRIMARY KEY ( "id" )
);

CREATE TABLE IF NOT EXISTS catalog.incorporation_form
(
 "id"   uuid,
 name character varying(100),
 code integer,
 short_title  character varying(40),
 hidden  boolean NOT NULL DEFAULT false,
 CONSTRAINT incorporation_form_id_pk PRIMARY KEY ( "id" )
);

CREATE TABLE IF NOT EXISTS catalog.organization
(
 "id"                    uuid,
 name                  character varying(100),
 code                  integer,
 director              character varying(100),
 phone                 character varying(50),
 fax                   character varying(50),
 address               character varying(100),
 email                 character varying(100),
 postaladdress         character varying(100),
 incorporation_form_id uuid,
 hidden  boolean NOT NULL DEFAULT false,
 CONSTRAINT organization_id_pk PRIMARY KEY ( "id" ),
 CONSTRAINT FK_35 FOREIGN KEY ( incorporation_form_id ) REFERENCES catalog.incorporation_form ( "id" )
);

CREATE TABLE IF NOT EXISTS catalog.forest_use_kind
(
 "id"   uuid,
 name character varying(150),
 code integer,
 hidden  boolean NOT NULL DEFAULT false,
 CONSTRAINT forest_use_kind_id_pk PRIMARY KEY ( "id" )
);

CREATE TABLE IF NOT EXISTS catalog.forest_tax_district
(
 "id"   uuid,
 name character varying(80),
 code integer,
 hidden  boolean NOT NULL DEFAULT false,
 CONSTRAINT forest_tax_district_id_pk PRIMARY KEY ( "id" )
);

CREATE TABLE IF NOT EXISTS catalog.cut_form
(
 "id"   uuid,
 name character varying(100),
 code integer,
 hidden  boolean NOT NULL DEFAULT false,
 CONSTRAINT cut_form_id_pk PRIMARY KEY ( "id" )
);

CREATE TABLE IF NOT EXISTS catalog.plot_cut_type
(
 "id"   uuid NOT NULL,
 name character varying(200) NOT NULL,
 code integer NOT NULL,
 hidden  boolean NOT NULL DEFAULT false,
 CONSTRAINT plot_cut_type_id_pk PRIMARY KEY ( "id" )
);

CREATE TABLE IF NOT EXISTS catalog.unsatisfactory_operation_cause
(
 "id"   uuid,
 name character varying(50),
 code integer,
 hidden  boolean NOT NULL DEFAULT false,
 CONSTRAINT unsatisfactory_operation_cause_id_pk PRIMARY KEY ( "id" )
);

CREATE TABLE IF NOT EXISTS catalog.high_conservation_value_forests
(
 "id"        uuid,
 name      character varying(120),
 code      integer,

 "hierarchy" uuid,
 hidden  boolean NOT NULL DEFAULT false,
 CONSTRAINT high_conservation_value_forests_id_pk PRIMARY KEY ( "id" )
);
COMMENT ON TABLE catalog.high_conservation_value_forests IS 'Леса высокой природной ценности';
CREATE TABLE IF NOT EXISTS catalog.relief
(
 "id"   uuid,
 name character varying(60),
 code integer,

 hidden  boolean NOT NULL DEFAULT false,

 CONSTRAINT relief_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.forest_inventory_org
(
 "id"   uuid,
 name character varying(250),
 code integer,

 hidden  boolean NOT NULL DEFAULT false,

 CONSTRAINT forest_inventory_org_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.taxator
(
 "id"   uuid,
 name character varying(250),
 hidden  boolean NOT NULL DEFAULT false,
 


 CONSTRAINT taxator_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.fire_hazard_class
(
 "id"   uuid,
 name character varying(100),
 code integer,
 hidden  boolean NOT NULL DEFAULT false,

 
 CONSTRAINT fire_hazard_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.forest_group
(
 "id"   uuid,
 name character varying(100),

 code integer,
 hidden  boolean NOT NULL DEFAULT false,
 CONSTRAINT forest_group_id_pk PRIMARY KEY ( "id" )

);
CREATE TABLE IF NOT EXISTS catalog.protection_category
(
 "id"              uuid,
 name            character varying(255),
 code            integer,
 forest_group_id uuid,
 hidden  boolean NOT NULL DEFAULT false,
 CONSTRAINT protection_category_id_pk PRIMARY KEY ( "id" ),
 CONSTRAINT FK_37 FOREIGN KEY ( forest_group_id ) REFERENCES catalog.forest_group ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.slope_exposure
(
 "id"   uuid,
 name character varying(100),
 code integer,
 hidden  boolean NOT NULL DEFAULT false,


 CONSTRAINT slope_exposure_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.municipal_area
(
 "id"   uuid,
 name character varying(100),
 code integer,

 area integer,
 hidden  boolean NOT NULL DEFAULT false,
 CONSTRAINT municipal_area_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.slope_erosion_type
(
 "id"   uuid,
 name character varying(100),
 code integer,
 hidden  boolean NOT NULL DEFAULT false,

 CONSTRAINT slope_erosion_type_id_pk PRIMARY KEY ( "id" )
);

CREATE TABLE IF NOT EXISTS catalog.economic_category
(
 "id"   uuid,
 name character varying(250),
 code integer,
 hidden  boolean NOT NULL DEFAULT false,

 CONSTRAINT economic_category_id_pk PRIMARY KEY ( "id" )
);

CREATE TABLE IF NOT EXISTS catalog.forest_type
(
 "id"          uuid,
 description character varying(90),
 code        integer,
 name        character varying(5),
 hidden  boolean NOT NULL DEFAULT false,

 CONSTRAINT forest_type_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.forest_growth_conditions_type
(
 "id"          uuid,
 name        character varying(2),
 code        integer,
 hidden  boolean NOT NULL DEFAULT false,

 description character varying(90),
 CONSTRAINT forest_growth_conditions_type_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.slope_erosion_degree
(
 "id"   uuid,
 name character varying(100),
 code integer,
 hidden  boolean NOT NULL DEFAULT false,


 CONSTRAINT slope_erosion_degree_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.economic_section
(
 "id"   uuid,
 name character varying(50),
 code integer,
 hidden  boolean NOT NULL DEFAULT false,


 CONSTRAINT economic_section_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.cut_type
(
 "id"          uuid,
 name        character varying(100),
 code        integer,
 hidden  boolean NOT NULL DEFAULT false,

 short_title character varying(2),
 CONSTRAINT cut_type_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.highly_protected_forest_area
(
 "id"   uuid,
 name character varying(250),


 code integer,
 hidden  boolean NOT NULL DEFAULT false,
 CONSTRAINT highly_protected_forest_area_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.functional_zone
(
 "id"   uuid,
 name character varying(50),
 code integer,
 hidden  boolean NOT NULL DEFAULT false,


 CONSTRAINT functional_zone_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.age_group
(
 "id"   uuid,
 name character varying(100),


 code integer,
 hidden  boolean NOT NULL DEFAULT false,
 CONSTRAINT age_group_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.raw_material_category
(
 "id"   uuid,
 name character varying(100),
 code integer,
 hidden  boolean NOT NULL DEFAULT false,


 CONSTRAINT raw_material_category_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.accessibility
(
 "id"   uuid,
 code integer,
 name character varying(100),
 hidden  boolean NOT NULL DEFAULT false,


 CONSTRAINT accessibility_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.analysis_results
(
 "id"   uuid,
 name character varying(200),
 code integer,
 hidden  boolean NOT NULL DEFAULT false,


 CONSTRAINT analysis_results_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.estimate_operation
(
 "id"   uuid,
 name character varying(100),
 code integer,
 hidden  boolean NOT NULL DEFAULT false,


 CONSTRAINT estimate_operation_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.work_type
(
 "id"   uuid,


 name character varying(100),
 code integer,
 hidden  boolean NOT NULL DEFAULT false,
 CONSTRAINT work_type_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.death_or_unsatisfactory_condition_cause
(
 "id"   uuid,
 name character varying(50),


 code integer,
 hidden  boolean NOT NULL DEFAULT false,
 CONSTRAINT death_or_unsatisfactory_condition_cause_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.creating_forest_plantations_method
(
 "id"   uuid,
 name character varying(30),
 code integer,
 hidden  boolean NOT NULL DEFAULT false,


 CONSTRAINT creating_forest_plantations_method_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.estimate_condition_forest_plantation
(
 "id"   uuid,


 name character varying(30),
 code integer,
 hidden  boolean NOT NULL DEFAULT false,
 CONSTRAINT estimate_condition_forest_plantation_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.tapping_condition
(
 "id"   uuid,
 name character varying(250),


 code integer,
 hidden  boolean NOT NULL DEFAULT false,
 CONSTRAINT tapping_condition_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.tech_violetion
(
 "id"   uuid,
 name character varying(250),
 code integer,
 hidden  boolean NOT NULL DEFAULT false,


 CONSTRAINT tech_violetion_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.chemical_stimulant
(
 "id"   uuid,
 name character varying(100),


 code integer,
 hidden  boolean NOT NULL DEFAULT false,
 CONSTRAINT chemical_stimulant_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.garden_category
(
 "id"   uuid,
 name character varying(100),


 code integer,
 hidden  boolean NOT NULL DEFAULT false,
 CONSTRAINT garden_category_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.wood_layer_type
(
 "id"   uuid,
 name character varying(250),
 code integer,
 hidden  boolean NOT NULL DEFAULT false,


 CONSTRAINT wood_layer_type_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.origin
(
 "id"   uuid,
 name character varying(150),
 code integer,
 hidden  boolean NOT NULL DEFAULT false,


 CONSTRAINT origin_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.undergrowth_density
(
 "id"   uuid,
 name character varying(150),
 code integer,
 hidden  boolean NOT NULL DEFAULT false,


 CONSTRAINT undergrowth_density_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.undergrowth_reliability
(
 "id" uuid,
 name character varying(150),
 code integer,
 hidden  boolean NOT NULL DEFAULT false,


 CONSTRAINT evaluation_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.damage_pattern
(
 "id"   uuid,
 name  character varying(100),
 code  integer,
 hidden  boolean NOT NULL DEFAULT false,


 CONSTRAINT damage_pattern_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.injurious_organism_species
(
 "id"   uuid,
 name character varying(100),
 code integer,
 hidden  boolean NOT NULL DEFAULT false,


 CONSTRAINT injurious_organism_species_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.damage_degree
(
 "id"   uuid,
 name character varying(100),


 code integer,
 hidden  boolean NOT NULL DEFAULT false,
 CONSTRAINT damage_degree_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.condition
(
 "id"   uuid,
 name character varying(100),
 code integer,
 hidden  boolean NOT NULL DEFAULT false,


 CONSTRAINT condition_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.copyright_holder
(
 "id"   uuid,
 name character varying(100),
 code integer,
 hidden  boolean NOT NULL DEFAULT false,


 CONSTRAINT copyright_holder_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.forest_area_degree
(
 "id"   uuid,
 name character varying(100),


 code integer,
 hidden  boolean NOT NULL DEFAULT false,
 CONSTRAINT forest_area_degree_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.pasture_type
(
 "id"   uuid,
 name character varying(100),
 code integer,
 hidden  boolean NOT NULL DEFAULT false,


 CONSTRAINT pasture_type_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.category
(
 "id"   uuid,
 name character varying(50),


 code integer,
 hidden  boolean NOT NULL DEFAULT false,
 CONSTRAINT category_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.herbal_plants
(
 "id"   uuid,
 name character varying(100),
 code integer,
 hidden  boolean NOT NULL DEFAULT false,


 CONSTRAINT herbal_plants_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.land_category
(
 "id"   uuid,
 name character varying(250),
 code integer,
 hidden  boolean NOT NULL DEFAULT false,


 CONSTRAINT land_category_id_pk PRIMARY KEY ( "id" )
);

CREATE TABLE IF NOT EXISTS catalog.loss_category
(
 "id"   uuid,
 name character varying(100),


 code integer,
 hidden  boolean NOT NULL DEFAULT false,
 CONSTRAINT loss_category_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.place_abandoned_wood
(
 "id"   uuid,
 name character varying(100),


 code integer,
 hidden  boolean NOT NULL DEFAULT false,
 CONSTRAINT place_abandoned_wood_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.soil_type
(
 "id"   uuid,
 name character varying(100),
 code integer,
 hidden  boolean NOT NULL DEFAULT false,


 CONSTRAINT soil_type_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.mechancal_composition
(
 "id"   uuid,
 name character varying(100),
 code integer,
 hidden  boolean NOT NULL DEFAULT false,


 CONSTRAINT mechancal_composition_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.swarding_degree
(
 "id"   uuid,

 name character varying(100),
 code integer,
 hidden  boolean NOT NULL DEFAULT false,

 CONSTRAINT swarding_degree_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.moisture
(
 "id"   uuid,
 name character varying(100),


 code integer,
 hidden  boolean NOT NULL DEFAULT false,
 CONSTRAINT moisture_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.soil_power
(
 "id"   uuid,
 name character varying(100),


 code integer,
 hidden  boolean NOT NULL DEFAULT false,
 CONSTRAINT soil_power_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.plantation_purpuse
(
 "id"   uuid,
 name character varying(100),


 code integer,
 hidden  boolean NOT NULL DEFAULT false,
 CONSTRAINT plantation_purpuse_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.landscape_type
(
 "id"   uuid,
 name character varying(100),
 code integer,
 hidden  boolean NOT NULL DEFAULT false,


 CONSTRAINT landscape_type_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.aesthetic_evaluation
(
 "id"   uuid,
 code integer,
 hidden  boolean NOT NULL DEFAULT false,


 name character varying(100),
 CONSTRAINT aesthetic_evaluation_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.digression_stage
(
 "id"   uuid,
 name character varying(100),


 code integer,
 hidden  boolean NOT NULL DEFAULT false,
 CONSTRAINT digression_stage_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.stability_evaluation
(
 "id"   uuid,
 name character varying(100),
 code integer,
 hidden  boolean NOT NULL DEFAULT false,


 CONSTRAINT stability_evaluation_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.sanitary_evaluation
(
 "id"   uuid,
 name character varying(100),


 code integer,
 hidden  boolean NOT NULL DEFAULT false,
 CONSTRAINT sanitary_evaluation_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.small_architect_forms
(
 "id"   uuid,
 name character varying(100),
 code integer,
 hidden  boolean NOT NULL DEFAULT false,


 CONSTRAINT small_architect_forms_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.viewable_evaluation
(
 "id"   uuid,
 name character varying(100),


 code integer,
 hidden  boolean NOT NULL DEFAULT false,
 CONSTRAINT viewable_evaluation_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.passability_evaluation
(
 "id"   uuid,
 name character varying(100),
 code integer,
 hidden  boolean NOT NULL DEFAULT false,


 CONSTRAINT passability_evaluation_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.harvest_availability
(
 "id"   uuid,
 name character varying(200),
 code integer,
 hidden  boolean NOT NULL DEFAULT false,


 CONSTRAINT harvest_availability_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.transport_type
(
 "id"   uuid,
 name character varying(100),
 code integer,
 hidden  boolean NOT NULL DEFAULT false,


 CONSTRAINT transport_type_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.swamp_type
(
 "id"   uuid,
 name character varying(100),


 code integer,
 hidden  boolean NOT NULL DEFAULT false,
 CONSTRAINT swamp_type_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.non_wood_species
(
 "id"   uuid,
 name character varying(100),


 code integer,
 hidden  boolean NOT NULL DEFAULT false,
 CONSTRAINT non_wood_species_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.breeding_evaluation
(
 "id"   uuid,
 name character varying(100),
 code integer,
 hidden  boolean NOT NULL DEFAULT false,
	
 CONSTRAINT breeding_evaluation_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.stand_features
(
 "id"   uuid,
 name character varying(100),


 code integer,
 hidden  boolean NOT NULL DEFAULT false,
 CONSTRAINT stand_features_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.road_purpose
(
 "id"   uuid,
 name character varying(100),


 code integer,
 hidden  boolean NOT NULL DEFAULT false,
 CONSTRAINT road_purpose_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.surface_type
(
 "id"   uuid,
 name character varying(30),


 code integer,
 hidden  boolean NOT NULL DEFAULT false,
 CONSTRAINT surface_type_id_pk PRIMARY KEY ( "id" )
);
CREATE TABLE IF NOT EXISTS catalog.seasonality
(
 "id"   uuid,
 name character varying(30),

 
 code integer,
 hidden  boolean NOT NULL DEFAULT false,
 CONSTRAINT seasonality_id_pk PRIMARY KEY ( "id" )
);

CREATE TABLE IF NOT EXISTS catalog.planned_operation
(
 "id"           uuid,
 name         character varying(100),
 code         integer,
 short_title  character varying(10),
 "percent"      integer,
 work_type_id uuid,
 hidden  boolean NOT NULL DEFAULT false,
 CONSTRAINT planned_operation_id_pk PRIMARY KEY ( "id" ),
 CONSTRAINT FK_41 FOREIGN KEY ( work_type_id ) REFERENCES catalog.work_type ( "id" )
);

CREATE TABLE IF NOT EXISTS catalog.tree_species
(
 "id"           uuid,
 name         character varying(100),
 type         character varying(16),
 code         integer,
 short_title  character varying(40),
 gulfcode     integer,
 bonitet_norm integer,
 stock_nom    integer,
 visible      boolean,
 "order"      integer,
 hidden  boolean NOT NULL DEFAULT false,
 CONSTRAINT tree_species_id_pk PRIMARY KEY ( "id" )
);


CREATE TABLE IF NOT EXISTS catalog.soil_coltivation_method
(
 "id"           uuid,
 name         character varying(100),
 code         integer,
 short_title  character varying(10),
 "percent"      integer,
 work_type_id uuid,
 hidden  boolean NOT NULL DEFAULT false,
 CONSTRAINT soil_coltivation_method_id_pk PRIMARY KEY ( "id" ),
 CONSTRAINT FK_34 FOREIGN KEY ( work_type_id ) REFERENCES catalog.work_type ( "id" )
);

CREATE TABLE IF NOT EXISTS catalog.forest_inventory_method
(
 "id"   uuid NOT NULL,
 name character varying(100) NOT NULL,
 code integer NULL,
 hidden  boolean NOT NULL DEFAULT false,
 CONSTRAINT forest_inventory_method_id_pk PRIMARY KEY ( "id" )
);

CREATE TABLE IF NOT EXISTS catalog.forest_site_type
(
 "id"                               uuid,
 bondabillity                     character varying(40),
 forest_type_id                   uuid,
 forest_growth_conditions_type_id uuid,
 hidden  boolean NOT NULL DEFAULT false,
 CONSTRAINT forest_site_type_id_pk PRIMARY KEY ( "id" ),
 CONSTRAINT FK_7 FOREIGN KEY ( forest_type_id ) REFERENCES catalog.forest_type ( "id" ),
 CONSTRAINT FK_38 FOREIGN KEY ( forest_growth_conditions_type_id ) REFERENCES catalog.forest_growth_conditions_type ( "id" )
);

CREATE TABLE IF NOT EXISTS catalog.drinage_sys_type
(
 "id"   uuid,
 name character varying(100),
 code integer,
 hidden  boolean NOT NULL DEFAULT false,
 CONSTRAINT drinage_sys_type_id_pk PRIMARY KEY ( "id" )
);

CREATE TABLE IF NOT EXISTS forest.department
(
 "id"    uuid,
 name  character varying(100),
 shape geometry NULL,
 CONSTRAINT department_id_pk PRIMARY KEY ( "id" )
);

CREATE TABLE IF NOT EXISTS forest.district
(
 "id"            uuid,
 name          character varying(100),
 shape         geometry NULL,
 department_id uuid,
 CONSTRAINT district_id_pk PRIMARY KEY ( "id" ),
 CONSTRAINT FK_1 FOREIGN KEY ( department_id ) REFERENCES forest.department ( "id" ) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS forest.compartment
(
 "id"                        uuid,
 number                      integer,
 district_id              uuid,
 rent_possibility          boolean,
 shape                     geometry NULL,
 area                      integer,
 centroid_shape            geometry,
 updating_year                       integer,
 taxes_rank                  integer,
 high_conservation_value_forests_id              uuid,
 fire_hazard_class_id uuid,
 relief_id                 uuid,
 forest_inventory_org_id   uuid,
 taxator_id              uuid,
 CONSTRAINT compartment_id_pk PRIMARY KEY ( "id" ),
 CONSTRAINT FK_2 FOREIGN KEY ( district_id ) REFERENCES forest.district ( "id" ) ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT FK_20 FOREIGN KEY ( high_conservation_value_forests_id ) REFERENCES catalog.high_conservation_value_forests ( "id" ),
 CONSTRAINT FK_21 FOREIGN KEY ( fire_hazard_class_id ) REFERENCES catalog.fire_hazard_class ( "id" ),
 CONSTRAINT FK_22 FOREIGN KEY ( relief_id ) REFERENCES catalog.relief ( "id" ),
 CONSTRAINT FK_23 FOREIGN KEY ( forest_inventory_org_id ) REFERENCES catalog.forest_inventory_org ( "id" ),
 CONSTRAINT FK_24 FOREIGN KEY ( taxator_id ) REFERENCES catalog.taxator ( "id" )
);



CREATE TABLE IF NOT EXISTS forest.stand
(
 "id"                             uuid,
 area                		  numeric(28,1),
 area_geom           		  geometry,
 area_fixed          	          boolean,
 stock               		  integer,
 clutter_stock_ha                 integer,
 commodity_clutter_stock          integer,
 dead_wood_stock                  integer,
 age_class                        integer,
 feeling_age_code                 integer,
 actualization_year               date,
 forest_inventory_method_id       uuid,
 highly_protected_forest_area_id  uuid,
 slope_angle                      integer,
 height_above_sea_level           integer,
 compartment_id                   uuid,
 protection_category_id           uuid,
 land_category_id                 uuid,
 forest_type_id                   uuid,
 "number"                           integer,
 composition                          character varying(100),
 growing_stock                      integer,
 timber_vpha                         integer,
 note                             character varying(255),
 relative_density                     numeric(28,1),
 harvest_cutting_years                     integer,
 total_stumps_number               integer,
 total_stumps_pine_number                integer,
 average_stump_diameter                   integer,
 feeling_age                         integer,
 deadfallen_wood                  integer,
 centroid_shape                   geometry,
 act                              integer,
 economic_category_id             uuid,
 economic_section_id              uuid,
 forest_growth_conditions_type_id uuid,
 age_group_id                     uuid,
 fire_hazard_class_id             uuid,
 municipal_area_id                uuid,
 slope_exposure_id                uuid,
 slope_erosion_type_id                  uuid,
 slope_erosion_degree_id          uuid,
 forest_group_id                  uuid,
 bonitet_class                    character varying(50),
 functional_zone_id               uuid,
 cut_type_id                  uuid,
 dominant_species_id              uuid,
 target_species_id                uuid,
 CONSTRAINT stand_id_pk PRIMARY KEY ( "id" ),
 CONSTRAINT FK_3 FOREIGN KEY ( compartment_id ) REFERENCES forest.compartment ( "id" ) ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT FK_13 FOREIGN KEY ( municipal_area_id ) REFERENCES catalog.municipal_area ( "id" ),
 CONSTRAINT FK_14 FOREIGN KEY ( slope_exposure_id ) REFERENCES catalog.slope_exposure ( "id" ),
 CONSTRAINT FK_15 FOREIGN KEY ( slope_erosion_type_id ) REFERENCES catalog.slope_erosion_type ( "id" ),
 CONSTRAINT FK_16 FOREIGN KEY ( slope_erosion_degree_id ) REFERENCES catalog.slope_erosion_degree ( "id" ),
 CONSTRAINT FK_17 FOREIGN KEY ( forest_group_id ) REFERENCES catalog.forest_group ( "id" ),
 CONSTRAINT FK_18 FOREIGN KEY ( functional_zone_id ) REFERENCES catalog.functional_zone ( "id" ),
 CONSTRAINT FK_19 FOREIGN KEY ( cut_type_id ) REFERENCES catalog.cut_type ( "id" ),
 CONSTRAINT FK_36 FOREIGN KEY ( highly_protected_forest_area_id ) REFERENCES catalog.highly_protected_forest_area ( "id" ),
 CONSTRAINT FK_39 FOREIGN KEY ( dominant_species_id ) REFERENCES catalog.tree_species ( "id" ),
 CONSTRAINT FK_40 FOREIGN KEY ( target_species_id ) REFERENCES catalog.tree_species ( "id" ),
 CONSTRAINT FK_4 FOREIGN KEY ( protection_category_id ) REFERENCES catalog.protection_category ( "id" ),
 CONSTRAINT FK_5 FOREIGN KEY ( land_category_id ) REFERENCES catalog.land_category ( "id" ),
 CONSTRAINT FK_6 FOREIGN KEY ( forest_type_id ) REFERENCES catalog.forest_type ( "id" ),
 CONSTRAINT FK_8 FOREIGN KEY ( economic_category_id ) REFERENCES catalog.economic_category ( "id" ),
 CONSTRAINT FK_9 FOREIGN KEY ( economic_section_id ) REFERENCES catalog.economic_section ( "id" ),
 CONSTRAINT FK_10 FOREIGN KEY ( forest_growth_conditions_type_id ) REFERENCES catalog.forest_growth_conditions_type ( "id" ),
 CONSTRAINT FK_11 FOREIGN KEY ( age_group_id ) REFERENCES catalog.age_group ( "id" ),
 CONSTRAINT FK_12 FOREIGN KEY ( fire_hazard_class_id ) REFERENCES catalog.fire_hazard_class ( "id" ),
 CONSTRAINT FK_138 FOREIGN KEY ( forest_inventory_method_id ) REFERENCES catalog.forest_inventory_method ( "id" )
);

CREATE TABLE IF NOT EXISTS forest.undergrowth
(
 "id"                     uuid,
 undergrowth_density_id uuid,
 tree_species_1_id         uuid NULL,
 tree_species_2_id         uuid NULL,
 tree_species_3_id         uuid NULL,
 stand_id               uuid,
 CONSTRAINT undergrowth_pk_id PRIMARY KEY ( "id" ),
 CONSTRAINT FK_131 FOREIGN KEY ( undergrowth_density_id ) REFERENCES catalog.undergrowth_density ( "id" ),
 CONSTRAINT FK_132 FOREIGN KEY ( tree_species_1_id ) REFERENCES catalog.tree_species ( "id" ),
 CONSTRAINT FK_133 FOREIGN KEY ( tree_species_2_id ) REFERENCES catalog.tree_species ( "id" ),
 CONSTRAINT FK_134 FOREIGN KEY ( tree_species_3_id ) REFERENCES catalog.tree_species ( "id" ),
 CONSTRAINT FK_136_1 FOREIGN KEY ( stand_id ) REFERENCES forest.stand ( "id" ) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS forest.second_growth
(
 "id"                         uuid,
 "count"                      numeric(3,1),
 age                        integer,
 height                     numeric(3,1),
 undergrowth_reliability_id uuid,
 stand_id                   uuid,
 CONSTRAINT second_growth_id_pk PRIMARY KEY ( "id" ),
 CONSTRAINT FK_137 FOREIGN KEY ( undergrowth_reliability_id ) REFERENCES catalog.undergrowth_reliability ( "id" ),
 CONSTRAINT FK_137_1 FOREIGN KEY ( stand_id ) REFERENCES forest.stand ( "id" ) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS forest.second_growth_species
(
 "id"               uuid,
 coefficient      integer,
 tree_species_id  uuid,
 second_growth_id uuid NOT NULL,
 CONSTRAINT second_growth_species_pk_id PRIMARY KEY ( "id" ),
 CONSTRAINT FK_135 FOREIGN KEY ( tree_species_id ) REFERENCES catalog.tree_species ( "id" ),
 CONSTRAINT FK_136 FOREIGN KEY ( second_growth_id ) REFERENCES forest.second_growth ( "id" ) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS forest.wood_layer
(
 "id"                 uuid,
 layer_composition            character varying(50),
 age                integer,
 height              numeric(23,1),
 diameter           integer,
 density       numeric(4,1),
 growing_stock          integer,
 survival_ability_percentage   integer,
 NomSoed            integer,
 wood_layer_type_id uuid,
 origin_id          uuid,
 stand_id           uuid,
 age_group_id       uuid,
 CONSTRAINT wood_layer_id_pk PRIMARY KEY ( "id" ),
 CONSTRAINT FK_25 FOREIGN KEY ( wood_layer_type_id ) REFERENCES catalog.wood_layer_type ( "id" ),
 CONSTRAINT FK_26 FOREIGN KEY ( origin_id ) REFERENCES catalog.origin ( "id" ),
 CONSTRAINT FK_29 FOREIGN KEY ( stand_id ) REFERENCES forest.stand ( "id" ) ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT FK_30 FOREIGN KEY ( age_group_id ) REFERENCES catalog.age_group ( "id" )
);

CREATE TABLE IF NOT EXISTS forest.wood_layer_species
(
 "id"              uuid,
 coefficient     integer,
 age             integer,
 height          integer,
 diameter        integer,
 commer_class    integer,
 grade           integer,
 origin_id       uuid,
 tree_species_id uuid,
 wood_layer_id uuid NOT NULL,
 CONSTRAINT wood_layer_species_id_pk PRIMARY KEY ( "id" ),
 CONSTRAINT FK_31 FOREIGN KEY ( origin_id ) REFERENCES catalog.origin ( "id" ),
 CONSTRAINT FK_32 FOREIGN KEY ( tree_species_id ) REFERENCES catalog.tree_species ( "id" ),
 CONSTRAINT FK_33 FOREIGN KEY ( wood_layer_id ) REFERENCES forest.wood_layer ( "id" ) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS forest.stand_measures
(
 "id"                   uuid,
 "order"              integer,
 "percent"              integer,
 info                 character varying(150),
 mer_rtk              integer,
 stand_id             uuid,
 planned_operation_id uuid,
 CONSTRAINT stand_measures_id_pk PRIMARY KEY ( "id" ),
 CONSTRAINT FK_129_2 FOREIGN KEY ( stand_id ) REFERENCES forest.stand ( "id" ) ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT FK_130_1 FOREIGN KEY ( planned_operation_id ) REFERENCES catalog.planned_operation ( "id" )
);

CREATE TABLE IF NOT EXISTS layout.made_economic_mes
(
 "id"                                         uuid,
 year                                       integer,
 stock                                      integer,
 area                                       numeric(12,1),
 tree_species_id                            uuid,
 analysis_results_id                        uuid,
 estimate_operation_id                 uuid,
 death_or_unsatisfactory_condition_cause_id uuid,
 stand_id                                   uuid,
 planned_operation_id                       uuid,
 CONSTRAINT made_economic_mes_id_pk PRIMARY KEY ( "id" ),
 CONSTRAINT FK_65 FOREIGN KEY ( tree_species_id ) REFERENCES catalog.tree_species ( "id" ),
 CONSTRAINT FK_66 FOREIGN KEY ( analysis_results_id ) REFERENCES catalog.analysis_results ( "id" ),
 CONSTRAINT FK_67 FOREIGN KEY ( estimate_operation_id ) REFERENCES catalog.estimate_operation ( "id" ),
 CONSTRAINT FK_68 FOREIGN KEY ( death_or_unsatisfactory_condition_cause_id ) REFERENCES catalog.death_or_unsatisfactory_condition_cause ( "id" ),
 CONSTRAINT FK_69 FOREIGN KEY ( stand_id ) REFERENCES forest.stand ( "id" ),
 CONSTRAINT FK_128 FOREIGN KEY ( planned_operation_id ) REFERENCES catalog.planned_operation ( "id" )
);
CREATE TABLE IF NOT EXISTS layout.non_wood_raw
(
 "id"                       uuid,
 age                      integer,
 hight                    integer,
 unit_messure             character varying(10),
 productivity             numeric(12,1),
 tree_species_id          uuid,
 raw_material_category_id uuid,
 accesibility_id          uuid,
 stand_id                 uuid,
 CONSTRAINT non_wood_raw_id_pk PRIMARY KEY ( "id" ),
 CONSTRAINT FK_70 FOREIGN KEY ( tree_species_id ) REFERENCES catalog.tree_species ( "id" ),
 CONSTRAINT FK_71 FOREIGN KEY ( raw_material_category_id ) REFERENCES catalog.raw_material_category ( "id" ),
 CONSTRAINT FK_72 FOREIGN KEY ( accesibility_id ) REFERENCES catalog.accessibility ( "id" ),
 CONSTRAINT FK_73 FOREIGN KEY ( stand_id ) REFERENCES forest.stand ( "id" )
);


CREATE TABLE IF NOT EXISTS layout.stand_features_maket
(
 "id"                uuid,
 "NomSoed"         integer,
 stand_features_id uuid,
 stand_id          uuid,
 CONSTRAINT stand_features_id_pk PRIMARY KEY ( "id" ),
 CONSTRAINT FK_107 FOREIGN KEY ( stand_features_id ) REFERENCES catalog.stand_features ( "id" ),
 CONSTRAINT FK_108 FOREIGN KEY ( stand_id ) REFERENCES forest.stand ( "id" )
);

CREATE TABLE IF NOT EXISTS layout.forest_plantation
(
 "id"                                         uuid,
 year                                       integer,
 dist_between_rows                          numeric(12,1),
 dist_in_row                                numeric(12,1),
 amount                                     numeric(12,1),
 "NomSoed"                                  integer,
 soil_coltivation_method_id                 uuid,
 creating_forest_plantations_method_id      uuid,
 death_or_unsatisfactory_condition_cause_id uuid,
 stand_id                                   uuid,
 estimate_condition_forest_plantation_id    uuid,
 CONSTRAINT forest_plantation_id_pk PRIMARY KEY ( "id" ),
 CONSTRAINT FK_42 FOREIGN KEY ( soil_coltivation_method_id ) REFERENCES catalog.soil_coltivation_method ( "id" ),
 CONSTRAINT FK_43 FOREIGN KEY ( creating_forest_plantations_method_id ) REFERENCES catalog.creating_forest_plantations_method ( "id" ),
 CONSTRAINT FK_45 FOREIGN KEY ( death_or_unsatisfactory_condition_cause_id ) REFERENCES catalog.death_or_unsatisfactory_condition_cause ( "id" ),
 CONSTRAINT FK_46 FOREIGN KEY ( stand_id ) REFERENCES forest.stand ( "id" ),
 CONSTRAINT FK_128_1 FOREIGN KEY ( estimate_condition_forest_plantation_id ) REFERENCES catalog.estimate_condition_forest_plantation ( "id" )
);

CREATE TABLE IF NOT EXISTS layout.tapping
(
 "id"                                         uuid,
 year_start                                 integer,
 year_stop_plan                             integer,
 year_stop_fact                             integer,
 number_tech_schem                          integer,
 death_or_unsatisfactory_condition_cause_id uuid,
 tech_violetion_id                          uuid,
 chemical_stimulant_id                      uuid,
 stand_id                                   uuid,
 tapping_condition_id                       uuid,
 CONSTRAINT tapping_id_pk PRIMARY KEY ( "id" ),
 CONSTRAINT FK_74 FOREIGN KEY ( death_or_unsatisfactory_condition_cause_id ) REFERENCES catalog.death_or_unsatisfactory_condition_cause ( "id" ),
 CONSTRAINT FK_76 FOREIGN KEY ( tech_violetion_id ) REFERENCES catalog.tech_violetion ( "id" ),
 CONSTRAINT FK_77 FOREIGN KEY ( chemical_stimulant_id ) REFERENCES catalog.chemical_stimulant ( "id" ),
 CONSTRAINT FK_78 FOREIGN KEY ( stand_id ) REFERENCES forest.stand ( "id" ),
 CONSTRAINT FK_130 FOREIGN KEY ( tapping_condition_id ) REFERENCES catalog.tapping_condition ( "id" )
);

CREATE TABLE IF NOT EXISTS layout.garden
(
 "id"                 uuid,
 year               integer,
 dist_between_rows  numeric(12,1),
 dist_in_row        numeric(12,1),
 amount_total       numeric(12,1),
 amount_fruit       numeric(12,1),
 productivity       numeric(12,1),
 garden_category_id uuid,
 tree_species_id    uuid,
 stand_id           uuid,
 CONSTRAINT garden_id_pk PRIMARY KEY ( "id" ),
 CONSTRAINT FK_93 FOREIGN KEY ( garden_category_id ) REFERENCES catalog.garden_category ( "id" ),
 CONSTRAINT FK_94 FOREIGN KEY ( tree_species_id ) REFERENCES catalog.tree_species ( "id" ),
 CONSTRAINT FK_95 FOREIGN KEY ( stand_id ) REFERENCES forest.stand ( "id" )
);



CREATE TABLE IF NOT EXISTS layout.plantations_damage
(
 "id"                             uuid,
 year                           integer,
 "NomSoed"                      integer,
 damage_pattern_id              uuid,
 tree_species_id                uuid,
 injurious_organism_species1_id uuid,
 injurious_organism_species2_id uuid,
 damage_degree1_id              uuid,
 damage_degree2_id              uuid,
 stand_id                       uuid,
 CONSTRAINT plantations_damage_id_pk PRIMARY KEY ( "id" ),
 CONSTRAINT FK_47 FOREIGN KEY ( damage_pattern_id ) REFERENCES catalog.damage_pattern ( "id" ),
 CONSTRAINT FK_48 FOREIGN KEY ( tree_species_id ) REFERENCES catalog.tree_species ( "id" ),
 CONSTRAINT FK_49 FOREIGN KEY ( injurious_organism_species1_id ) REFERENCES catalog.injurious_organism_species ( "id" ),
 CONSTRAINT FK_50 FOREIGN KEY ( injurious_organism_species2_id ) REFERENCES catalog.injurious_organism_species ( "id" ),
 CONSTRAINT FK_51 FOREIGN KEY ( damage_degree1_id ) REFERENCES catalog.damage_degree ( "id" ),
 CONSTRAINT FK_52 FOREIGN KEY ( damage_degree2_id ) REFERENCES catalog.damage_degree ( "id" ),
 CONSTRAINT FK_53 FOREIGN KEY ( stand_id ) REFERENCES forest.stand ( "id" )
);

CREATE TABLE IF NOT EXISTS layout.farmland
(
 "id"                    uuid,
 "percent"               integer,
 productivity          numeric(12,1),
 "NomSoed"             integer,
 copyright_holder_id   uuid,
 forest_area_degree_id uuid,
 pasture_type_id       uuid,
 condition_id          uuid,
 tree_species_id       uuid,
 stand_id              uuid,
 CONSTRAINT farmland_id_pk PRIMARY KEY ( "id" ),
 CONSTRAINT FK_79 FOREIGN KEY ( copyright_holder_id ) REFERENCES catalog.copyright_holder ( "id" ),
 CONSTRAINT FK_80 FOREIGN KEY ( forest_area_degree_id ) REFERENCES catalog.forest_area_degree ( "id" ),
 CONSTRAINT FK_81 FOREIGN KEY ( pasture_type_id ) REFERENCES catalog.pasture_type ( "id" ),
 CONSTRAINT FK_82 FOREIGN KEY ( condition_id ) REFERENCES catalog."condition" ( "id" ),
 CONSTRAINT FK_83 FOREIGN KEY ( tree_species_id ) REFERENCES catalog.tree_species ( "id" ),
 CONSTRAINT FK_84 FOREIGN KEY ( stand_id ) REFERENCES forest.stand ( "id" )
);

CREATE TABLE IF NOT EXISTS layout.herbal_plants_maket
(
 "id"                 uuid,
 cover_percent_1    integer,
 cover_percent_2    integer,
 cover_percent_3    integer,
 category_id        uuid,
 herbal_plants_1_id uuid,
 herbal_plants_2_id uuid,
 herbal_plants_3_id uuid,
 stand_id           uuid,
 CONSTRAINT herbal_plants_id_pk PRIMARY KEY ( "id" ),
 CONSTRAINT FK_54 FOREIGN KEY ( category_id ) REFERENCES catalog.category ( "id" ),
 CONSTRAINT FK_55 FOREIGN KEY ( herbal_plants_1_id ) REFERENCES catalog.herbal_plants ( "id" ),
 CONSTRAINT FK_56 FOREIGN KEY ( herbal_plants_2_id ) REFERENCES catalog.herbal_plants ( "id" ),
 CONSTRAINT FK_57 FOREIGN KEY ( herbal_plants_3_id ) REFERENCES catalog.herbal_plants ( "id" ),
 CONSTRAINT FK_58 FOREIGN KEY ( stand_id ) REFERENCES forest.stand ( "id" )
);

CREATE TABLE IF NOT EXISTS layout.hydroland
(
 "id"                     uuid,
 year                   integer,
 dist_to_desiccant      numeric(12,1),
 dist_between_desiccant numeric(12,1),
 bonability             character varying(2),
 drinage_sys_type_id    uuid,
 land_category_id       uuid,
 tree_species_id        uuid,
 stand_id               uuid,
 CONSTRAINT hydroland_id_pk PRIMARY KEY ( "id" ),
 CONSTRAINT FK_115 FOREIGN KEY ( drinage_sys_type_id ) REFERENCES catalog.drinage_sys_type ( "id" ),
 CONSTRAINT FK_116 FOREIGN KEY ( land_category_id ) REFERENCES catalog.land_category ( "id" ),
 CONSTRAINT FK_117 FOREIGN KEY ( tree_species_id ) REFERENCES catalog.tree_species ( "id" ),
 CONSTRAINT FK_118 FOREIGN KEY ( stand_id ) REFERENCES forest.stand ( "id" )
);

CREATE TABLE IF NOT EXISTS layout.previous_forest_regulation
(
 "id"                   uuid,
 "number"             integer,
 area                 numeric(12,1),
 coeff                integer,
 density              numeric(12,1),
 land_category_id     uuid,
 dominant_species_id  uuid,
 target_species_id    uuid,
 planned_operation_id uuid,
 stand_id             uuid,
 CONSTRAINT previous_forest_regulation_id_pk PRIMARY KEY ( "id" ),
 CONSTRAINT FK_121 FOREIGN KEY ( land_category_id ) REFERENCES catalog.land_category ( "id" ),
 CONSTRAINT FK_122 FOREIGN KEY ( dominant_species_id ) REFERENCES catalog.tree_species ( "id" ),
 CONSTRAINT FK_123 FOREIGN KEY ( target_species_id ) REFERENCES catalog.tree_species ( "id" ),
 CONSTRAINT FK_124 FOREIGN KEY ( planned_operation_id ) REFERENCES catalog.planned_operation ( "id" ),
 CONSTRAINT FK_125 FOREIGN KEY ( stand_id ) REFERENCES forest.stand ( "id" )
);

CREATE TABLE IF NOT EXISTS layout.wood_loss
(
 "id"                      uuid,
 growing_stock             integer,
 stock_liquid            integer,
 stock_business          integer,
 area                    integer,
 loss_category_id        uuid,
 place_abandoned_wood_id uuid,
 tree_species_id         uuid,
 stand_id                uuid,
 CONSTRAINT wood_loss_id_pk PRIMARY KEY ( "id" ),
 CONSTRAINT FK_85 FOREIGN KEY ( loss_category_id ) REFERENCES catalog.loss_category ( "id" ),
 CONSTRAINT FK_86 FOREIGN KEY ( place_abandoned_wood_id ) REFERENCES catalog.place_abandoned_wood ( "id" ),
 CONSTRAINT FK_87 FOREIGN KEY ( tree_species_id ) REFERENCES catalog.tree_species ( "id" ),
 CONSTRAINT FK_88 FOREIGN KEY ( stand_id ) REFERENCES forest.stand ( "id" )
);

CREATE TABLE IF NOT EXISTS layout.plantation
(
 "id"                    uuid,
 year                  integer,
 dist_between_rows     numeric(12,1),
 dist_in_row           numeric(12,1),
 amount                numeric(12,1),
 plantation_purpuse_id uuid,
 stand_id              uuid,
 CONSTRAINT plantation_id_pk PRIMARY KEY ( "id" ),
 CONSTRAINT FK_105 FOREIGN KEY ( plantation_purpuse_id ) REFERENCES catalog.plantation_purpuse ( "id" ),
 CONSTRAINT FK_106 FOREIGN KEY ( stand_id ) REFERENCES forest.stand ( "id" )
);

CREATE TABLE IF NOT EXISTS layout.recreation_evaluation
(
 "id"                        uuid,
 landscape_type_id         uuid,
 aesthetic_evaluation_id   uuid,
 sanitary_evaluation_id    uuid,
 stability_evaluation_id   uuid,
 passability_evaluation_id uuid,
 viewable_evaluation_id    uuid,
 digression_stage_id       uuid,
 small_architect_forms_id  uuid,
 stand_id                  uuid,
 CONSTRAINT recreation_evaluation_id_pk PRIMARY KEY ( "id" ),
 CONSTRAINT FK_96 FOREIGN KEY ( landscape_type_id ) REFERENCES catalog.landscape_type ( "id" ),
 CONSTRAINT FK_97 FOREIGN KEY ( aesthetic_evaluation_id ) REFERENCES catalog.aesthetic_evaluation ( "id" ),
 CONSTRAINT FK_98 FOREIGN KEY ( sanitary_evaluation_id ) REFERENCES catalog.sanitary_evaluation ( "id" ),
 CONSTRAINT FK_99 FOREIGN KEY ( stability_evaluation_id ) REFERENCES catalog.stability_evaluation ( "id" ),
 CONSTRAINT FK_100 FOREIGN KEY ( passability_evaluation_id ) REFERENCES catalog.passability_evaluation ( "id" ),
 CONSTRAINT FK_101 FOREIGN KEY ( viewable_evaluation_id ) REFERENCES catalog.viewable_evaluation ( "id" ),
 CONSTRAINT FK_102 FOREIGN KEY ( digression_stage_id ) REFERENCES catalog.digression_stage ( "id" ),
 CONSTRAINT FK_103 FOREIGN KEY ( small_architect_forms_id ) REFERENCES catalog.small_architect_forms ( "id" ),
 CONSTRAINT FK_104 FOREIGN KEY ( stand_id ) REFERENCES forest.stand ( "id" )
);

CREATE TABLE IF NOT EXISTS layout.availability_eco_impact
(
 "id"                      uuid,
 dist_to_road            numeric(12,1),
 transport_type_id       uuid,
 harvest_availability_id uuid,
 stand_id                uuid,
 CONSTRAINT availability_eco_impact_id_pk PRIMARY KEY ( "id" ),
 CONSTRAINT FK_119 FOREIGN KEY ( harvest_availability_id ) REFERENCES catalog.harvest_availability ( "id" ),
 CONSTRAINT FK_129 FOREIGN KEY ( transport_type_id ) REFERENCES catalog.transport_type ( "id" ),
 CONSTRAINT FK_129_1 FOREIGN KEY ( stand_id ) REFERENCES forest.stand ( "id" )
);

CREATE TABLE IF NOT EXISTS layout.swamp
(
 "id"                  uuid,
 peat_layer_power    numeric(12,1),
 "percent"             integer,
 "NomSoed"           integer,
 swamp_type_id       uuid,
 non_wood_species_id uuid,
 tree_species_id     uuid,
 stand_id            uuid,
 CONSTRAINT swamp_id_pk PRIMARY KEY ( "id" ),
 CONSTRAINT FK_89 FOREIGN KEY ( swamp_type_id ) REFERENCES catalog.swamp_type ( "id" ),
 CONSTRAINT FK_90 FOREIGN KEY ( non_wood_species_id ) REFERENCES catalog.non_wood_species ( "id" ),
 CONSTRAINT FK_91 FOREIGN KEY ( tree_species_id ) REFERENCES catalog.tree_species ( "id" ),
 CONSTRAINT FK_92 FOREIGN KEY ( stand_id ) REFERENCES forest.stand ( "id" )
);

CREATE TABLE IF NOT EXISTS layout.breeding_evaluation_maket
(
 "id"                     uuid,
 stand_id               uuid,
 breeding_evaluation_id uuid,
 CONSTRAINT breeding_evaluation_id_pk PRIMARY KEY ( "id" ),
 CONSTRAINT FK_126 FOREIGN KEY ( stand_id ) REFERENCES forest.stand ( "id" ),
 CONSTRAINT FK_127 FOREIGN KEY ( breeding_evaluation_id ) REFERENCES catalog.breeding_evaluation ( "id" )
);

CREATE TABLE IF NOT EXISTS layout.linar_objects
(
 "id"                      uuid,
 width                   numeric(12,1),
 "length"                  numeric(12,1),
 width_road_way          numeric(12,1),
 length_economic_measure numeric(12,1),
 "NomSoed"               integer,
 road_purpose_id         uuid,
 surface_type            uuid,
 seasonality_id          uuid,
 stand_id                uuid,
 stand_features_id       uuid,
 CONSTRAINT linar_objects_id_pk PRIMARY KEY ( "id" ),
 CONSTRAINT FK_60 FOREIGN KEY ( road_purpose_id ) REFERENCES catalog.road_purpose ( "id" ),
 CONSTRAINT FK_61 FOREIGN KEY ( surface_type ) REFERENCES catalog.surface_type ( "id" ),
 CONSTRAINT FK_62 FOREIGN KEY ( seasonality_id ) REFERENCES catalog.seasonality ( "id" ),
 CONSTRAINT FK_64 FOREIGN KEY ( stand_id ) REFERENCES forest.stand ( "id" ),
 CONSTRAINT FK_128_2 FOREIGN KEY ( stand_features_id ) REFERENCES catalog.stand_features ( "id" )
);

-- FUNCTION: forest.copy_stand_attr(uuid, uuid)

-- DROP FUNCTION IF EXISTS forest.copy_stand_attr(uuid, uuid);

CREATE OR REPLACE FUNCTION forest.copy_stand_attr(
  stand_new_pk uuid,
  stand_old_pk uuid)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
 
 DECLARE
 t_11_old_uuid uuid;
 t_12_old_uuid uuid;
 t_13_old_uuid uuid;
 t_17_old_uuid uuid;
 t_19_old_uuid uuid;
 t_23_old_uuid uuid[];
 economicmes_uuid uuid;
 floor_uuid_old uuid[];
 floor_uuid_new uuid[];
  breed_uuid uuid[];
  myuuid uuid;
  mynumber integer;
  myshape geometry;
  myarea geometry;
 i integer;
 n integer;
 name ALIAS FOR $1;
BEGIN
  --RAISE 'вызов функции %,%', mynumber,myuuid;

   select array(select id from wood_layer where stand_id=stand_old_pk) INTO floor_uuid_old;   
   n:=array_length(floor_uuid_old,1);
   i:=1;
     while i<=n loop      
     floor_uuid_new[i]=uuid_generate_v4();
     i:=i+1;
    end loop;
   
INSERT INTO forest.wood_layer(id, layer_composition, wood_layer_type_id, age, height, diametr, density, 
       growing_stock, origin_id, survival_ability_percentage, stand_id, 
       age_group_id, nomsoed) 
       select floor_uuid_new[row_number() over(partition by 0)], layer_composition, wood_layer_type_id, age, height, diametr, density, 
       growing_stock, origin_id, 
       survival_ability_percentage, stand_new_pk, 
       age_group_id, nomsoed 
       from wood_layer where stand= stand_old_pk;

n:=array_length(floor_uuid_old,1);
   i:=1;
while i<=n loop       
       INSERT INTO forest.wood_layer_species(id, coefficient, age, height, diameter, commer_class, 
       origin_id, tree_species_id, wood_layer_id, grade)
       SELECT uuid_generate_v4(), coefficient, age, height, diameter, commer_class, 
       wood_layer_species.origin_id, tree_species_id, floor_uuid_new[i], grade
       FROM forest.wood_layer_species
       where wood_layer_species.wood_layer_id = floor_uuid_old[i];
       i:=i+1;
end loop;    
select into economicmes_uuid id from stand_measures where stand=stand_old_pk;
economicmes_uuid=uuid_generate_v4();
INSERT INTO forest.stand_measures(id, stand_id, "order", percent, info)
            SELECT uuid_generate_v4(), stand_new_pk, '0'::bit, "order", percent, info FROM forest.stand_measures
             where isolated= stand_old_pk;
perform(insert_additional_makets(stand_old_pk,stand_new_pk));
END;
$BODY$;

ALTER FUNCTION forest.copy_stand_attr(uuid, uuid)
    OWNER TO postgres;