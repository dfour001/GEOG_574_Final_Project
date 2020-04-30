select
	wta.ward_fips,
	wta.ppname18,
	wta.walk_time_2018,
	wta.ppname20,
	wta.walk_time_2020,
	w.persons18,
	w.white18,
	w.black18,
	w.hispanic18,
	w.asian18,
	w.amindian18,
	w.other18,
	b.housing10,
	b.pop10,
	b.hhinc18,
	w.geom
from
	walk_time_analysis_results wta,
	wards w,
	(select ward_fips,
	 		round(avg(housing10)) housing10,
			sum(pop10) pop10,
			round(avg(hhinc18)) hhinc18
	 from blocks
	 group by ward_fips) b
where w.ward_fips = wta.ward_fips and w.ward_fips = b.ward_fips;