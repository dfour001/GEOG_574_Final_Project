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
			 id::integer AS id, 
			 Source::integer AS source, 
			 Target::integer AS target,                                    
			 Traveltime::double precision AS cost 
			   FROM network''::text, ' || vnode || '::bigint, 
			100000::double precision, false, false)
			di(seq, id1, id2, cost)
		JOIN network_nodes pt ON di.id1 = pt.id';
		return;
end;
$$ language plpgsql;