select
	pp.pollingpla as name,
	node.id as "node id",
	ST_Distance(pp.geom, node.geom) as distance
from
    PP_2018General pp,
	network_nodes node
where node.geom && st_expand(pp.geom, 500) order by distance asc limit 10;
	
