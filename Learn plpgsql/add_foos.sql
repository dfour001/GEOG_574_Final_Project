create or replace function add_foos() returns void as
$$
declare
	row foo%rowtype;
	foosum int;
begin	
	for row in
		select * from foo
	loop
		foosum := row.fooid + row.foosubid;
		insert into foo_sum values (row.fooname, foosum);
		raise notice 'fooname: %', row.fooname;
		raise notice 'foosum: %', foosum;
	end loop;
end;
$$ language plpgsql;

drop table if exists foo_sum;
create table foo_sum (
		fooname text,
		foosum int
	);
	
select add_foos();