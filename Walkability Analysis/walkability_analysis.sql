-- Create walkability table
drop table if exists walk_time_analysis_results;
create table walk_time_analysis (
	WARD_FIPS varchar(16),
	PP_2016 varchar(225),
	walk_time_2016 double precision,
	PP_2020 varchar(255),
	walk_time_2020 double precision,
	primary key (WARD_FIPS)
);

-- Create tables holding nearest node for each polling place.
-- One for 2018 and one for 2020.
drop table if exists polling_place_nodes_2018
create or replace view polling_place_nodes_2018 as (
	select 
	    pollingpla, 
	    find_nearst_node(pollingpla) as node
	from pp_2018general
);

drop table if exists polling_place_nodes_2020
create or replace view polling_place_nodes_2020 as (
	select 
	    pollingpla, 
	    find_nearst_node(pollingpla) as node
	from pp_2020spring
);