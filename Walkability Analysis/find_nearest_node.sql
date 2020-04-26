create or replace function find_nearst_node(ppName varchar(254)) returns int as
$$
declare
    name varchar(254) = ppName;

begin
    return (
		select
	node.id
from
    PP_2018General pp,
	network_nodes node
where pp.pollingpla = name and
node.geom && st_expand(pp.geom, 1500) order by ST_Distance(pp.geom, node.geom) asc limit 1
		);
end
$$ language plpgsql;
	
