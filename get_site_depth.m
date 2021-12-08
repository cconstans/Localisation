origin='AAV';
file_netcdf = 'C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Environnement\gebco_2021_n49.44671630859375_s47.84820556640625_w-65.8135986328125_e-63.34716796875.nc';
ncid = netcdf.open(file_netcdf);
lat_bathy = netcdf.getVar(ncid,0) ;
long_bathy = netcdf.getVar(ncid,1) ;
elevation = netcdf.getVar(ncid,2) ;

[loc, ~, ~]= getArrLoc(lower(origin));

centre_lat=loc(1); centre_long=loc(2);

[LONG,LAT]=meshgrid(long_bathy,lat_bathy);

depth=interp2(LONG,LAT,double(elevation'),centre_long,centre_lat);
disp([origin ' depth=' num2str(-depth) 'm']);

figure, imagesc(long_bathy,lat_bathy,elevation')
hold on, plot(centre_long,centre_lat,'wx')
text(centre_long,centre_lat+0.01,origin,'Color','w')
xlabel('Latitude'), ylabel('Longitude')
caxis([-150 0])
daspect([1 1 1])
colorbar
colormap jet
title('Altitude (m)')