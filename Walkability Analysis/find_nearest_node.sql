/* find_nearst_node(ppName)
Finds the node closest to the input polling place name by measuring the distance
to each node within a 1500' buffer of the input polling place and returning the 
node id with the lowest distance value. */
create or replace function find_nearst_node(name varchar(254)) returns int as
$$

begin
	raise notice 'Finding nearest node for polling place %', name;
	if exists (select * from pp_2018General where pollingpla = name)
	then
		--Search in 2018 PP
		return (
			select
				node.id
			from
				PP_2018General pp,
				network_nodes node
			where pp.pollingpla = name and
				node.geom && st_expand(pp.geom, 1500) order by ST_Distance(pp.geom, node.geom) asc limit 1
				);
	else
		--Search in 2020PP
		return (
			select
				node.id
			from
				PP_2020Spring pp,
				network_nodes node
			where pp.pollingpla = name and
				node.geom && st_expand(pp.geom, 1500) order by ST_Distance(pp.geom, node.geom) asc limit 1
				);
	end if;
end
$$ language plpgsql;
	
