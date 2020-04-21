/***************************
** Build Routable Network **
****************************
This sql will create a routable network to prepare
our data for the walkability analysis.  It assumes
that PostGIS and pgRouting extensions are already
installed and the road layer is called 'roads'.

The roads layer requires the following columns:
    * 'source' int
	* 'target' int
	
This is largley created by following Chris Kohler's
tutorial at:
https://anitagraser.com/2017/09/11/drive-time-isochrones-from-a-single-shapefile-using-qgis-postgis-and-pgrouting/amp/
****************************/

-- Delete node and network tables if they already exist
drop table if exists node, roads_vertices_pgr, network cascade;

-- Create topology
select pgr_createTopology('roads', 0.001, 'geom', 'id');

-- Create node table
CREATE TABLE node AS
   SELECT row_number() OVER (ORDER BY foo.p)::integer AS id,
          foo.p AS geom
   FROM (     
      SELECT DISTINCT roads.source AS p FROM roads
      UNION
      SELECT DISTINCT roads.target AS p FROM roads
   ) foo
   GROUP BY foo.p;
   
-- Create routable network
CREATE TABLE network AS
   SELECT a.*, b.id as start_id, c.id as end_id
   FROM roads AS a
      JOIN node AS b ON a.source = b.geom
      JOIN node AS c ON a.target = c.geom;

-- Create network nodes view
CREATE OR REPLACE VIEW network_nodes AS 
SELECT foo.id,
 st_centroid(st_collect(foo.pt)) AS geom 
FROM ( 
  SELECT network.source AS id,
         st_geometryn (st_multi(network.geom),1) AS pt 
  FROM network
  UNION 
  SELECT network.target AS id, 
         st_boundary(st_multi(network.geom)) AS pt 
  FROM network) foo 
GROUP BY foo.id;

-- Add travel time field to network
ALTER TABLE network ADD COLUMN traveltime double precision;

-- Calculate travel time based on an average walking speed of 3.1mph.
UPDATE network SET traveltime = (st_length(geom) / 16368) * 60;




