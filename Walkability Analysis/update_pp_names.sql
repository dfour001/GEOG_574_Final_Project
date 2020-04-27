update wards set ppname18 = replace(ppname18, '.', '');
update wards set ppname20 = replace(ppname20, '.', '');
update wards set ppname18 = replace(ppname18, ' ', '_');
update wards set ppname20 = replace(ppname20, ' ', '_');
update wards set ppname18 = replace(ppname18, '-', '_');
update wards set ppname20 = replace(ppname20, '-', '_');
update wards set ppname18 = replace(ppname18, '''', '_');
update wards set ppname20 = replace(ppname20, '''', '_');

update pp_2018general set pollingpla = replace(pollingpla, '.', '');
update pp_2020spring set pollingpla = replace(pollingpla, '.', '');
update pp_2018general set pollingpla = replace(pollingpla, ' ', '_');
update pp_2020spring set pollingpla = replace(pollingpla, ' ', '_');
update pp_2018general set pollingpla = replace(pollingpla, '-', '_');
update pp_2020spring set pollingpla = replace(pollingpla, '-', '_');
update pp_2018general set pollingpla = replace(pollingpla, '''', '_');
update pp_2020spring set pollingpla = replace(pollingpla, '''', '_');