/* find_nearst_node(ppName)
Finds the node closest to the input polling place name by measuring the distance
to each node within a 1500' buffer of the input polling place and returning the 
node id with the lowest distance value. */
create or replace function find_nearst_node(ppName varchar(254)) returns int as
$$
declare
    name varchar(254) = ppName;
begin
	raise notice 'Finding nearest node for polling place %', ppName;
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
	
