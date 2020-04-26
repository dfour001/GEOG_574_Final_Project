-- Create walkability table
drop table if exists walk_time_analysis;
create table walk_time_analysis (
	WARD_FIPS varchar(16),
	PP_2016 varchar(225),
	walk_time_2016 float,
	PP_2020 varchar(255),
	walk_time_2020 float,
	primary key (WARD_FIPS)
);

-- Create view holding nearest node for each polling place
create or replace view polling_place_node as (
	select st_closest
);