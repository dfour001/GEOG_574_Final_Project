/*avg_travel_time()
Returns the average walking time to the polling place
given the ward fips and polling place name. */
create or replace function avg_travel_time(ward_fips varchar(16), ppName varchar(254)) returns double precision as $$

declare
    vName varchar := 'v_' || replace(ppName, ' ', '_');
	avg double precision;
begin
    raise notice '====';
	raise notice 'Looking for %', vName;
	raise notice 'Created from %', ppName;
	if exists (SELECT *
                   FROM information_schema.views
                   WHERE table_schema = 'public'
                         AND table_name = lower(vName))
	then
		execute '
			select
				avg(n.cost)
			from 
				' || vName || ' n,
				wards w
			where w.ward_fips = ''' || ward_fips || ''' and
			st_intersects(n.geom, w.geom)' into avg;

		return avg;
	else
		return -1;
	end if;
end;
$$ language plpgsql;