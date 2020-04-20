create or replace function create_view(name text) returns void as $$
declare
	vName text := name;
	createV text;
begin
	execute 'drop view if exists ' || vName;
	execute 'create or replace view ' || vName || ' as (select testA.id, testA.numint, testB.numtext from testA join testB on testA.id = testB.id)';
	return;
end;
$$ language plpgsql;

drop table if exists testA, testB cascade;

create table testA (
	id int,
	numInt int
);

create table testB (
	id int,
	numText text
);

insert into testA values
	(1, 2), (3,4), (5,6);
	
insert into testB values
	(1, 'two'), (3,'four'), (5,'HA HA HA');
	
select create_view('test_view');
select * from test_view;