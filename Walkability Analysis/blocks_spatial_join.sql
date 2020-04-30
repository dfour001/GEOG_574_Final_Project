
-- Add ward_fips field to blocks
alter table blocks
add column ward_fips varchar(16);

-- Update ward_fips values from wards layer
update blocks
set ward_fips = (select w.ward_fips 
				from wards w
				where st_intersects(st_centroid(blocks.geom), w.geom));