create or replace function generate_walking_analysis_view(node int) returns void as
$$
declare
	vnode int := node;
	
begin
	execute 'CREATE OR REPLACE VIEW v_'|| node ||' AS 
		SELECT di.seq, 
			   di.id1, 
			   di.id2, 
			   di.cost, 
			   pt.id, 
			   pt.geom 
		FROM pgr_drivingdistance(''SELECT
			 id AS id, 
			 Sourcer AS source, 
			 Target AS target,                                    
			 Traveltime AS cost 
			   FROM network'', ' || vnode || ', 
			100000, false, false)
			di(seq, id1, id2, cost)
		JOIN network_nodes pt ON di.id1 = pt.id';
		return;
end;
$$ language plpgsql;