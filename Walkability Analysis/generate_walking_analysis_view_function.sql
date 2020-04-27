/* generate_walking_analysis_view()
Creates a view that shows the travel time analysis from the
input node id value.  The view will be used both to calculate
the average walk time in each ward and create isochrone maps.*/
create or replace function generate_walking_analysis_view(node int, ward_fips varchar(16)) returns void as
$$

begin
	execute 'CREATE OR REPLACE VIEW v_'|| replace(ward_fips, ' ', '_') ||' AS 
		SELECT di.seq, 
			   di.id1, 
			   di.id2, 
			   di.cost, 
			   pt.id, 
			   pt.geom 
		FROM pgr_drivingdistance(''SELECT
			 id AS id, 
			 Source AS source, 
			 Target AS target,                                    
			 Traveltime AS cost 
			   FROM network'', ' || node || ', 
			100000, false, false)
			di(seq, id1, id2, cost)
		JOIN network_nodes pt ON di.id1 = pt.id';
		return;
end;
$$ language plpgsql;