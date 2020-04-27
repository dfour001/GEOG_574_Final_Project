
-- Create tables holding nearest node for each polling place.
-- One for 2018 and one for 2020.
drop table if exists polling_place_nearest_nodes_2018;
create table polling_place_nearest_nodes_2018 as (
	select 
	    pollingpla, 
	    find_nearst_node(pollingpla) as node
	from pp_2018general
);


drop table if exists polling_place_nearest_nodes_2020;
create table polling_place_nearest_nodes_2020 as (
	select 
	    pollingpla, 
	    find_nearst_node(pollingpla) as node
	from pp_2020spring
);


-- Create views representing the walkability analysis for each polling place
-- 2018:
select generate_walking_analysis_view(node, pollingpla) from polling_place_nearest_nodes_2018;

-- 2020:
select generate_walking_analysis_view(node, pollingpla) from polling_place_nearest_nodes_2020;

-- Create walkability results table
drop table if exists walk_time_analysis_results;
create table walk_time_analysis_results as (
	select
		WARD_FIPS,
		ppname18,
		avg_travel_time(WARD_FIPS, ppname18) as walk_time_2018,
		ppname20,
		avg_travel_time(WARD_FIPS, ppname20) as walk_time_2020
	from
		wards
	);
