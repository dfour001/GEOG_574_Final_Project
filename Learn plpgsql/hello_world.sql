create or replace function hello_world() returns int as
$body$
declare
	number int := 10;
begin
	raise notice 'The number values is %', number;
	return number;
end;
$body$ language plpgsql;

select hello_world as hi from hello_world();