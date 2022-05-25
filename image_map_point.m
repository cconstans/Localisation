function image_map_point(x_whale,y_whale, loc_site1,loc_site2)
% This function quicly plot positions
% quickMap(lat,lon,'type')
% typre of map: online / geoshow / mmap
R_T_km = 6378140/1000;% rayon de la terre en km

delta_lat=y_whale/R_T_km*180/pi;
delta_long=x_whale/R_T_km*180/pi/cosd(loc_site1(1));
lat=loc_site1(1)+delta_lat;
lon=loc_site1(2)+delta_long;

disp('Printing map....')
try
    % Read bathymetry
    load Documents/MATLAB/Oceanographie/m_map/mmap_ex/GSL_bathy_500m.mat;
    load Documents/MATLAB/Oceanographie/m_map/mmap_ex/gebco_colormap.dat;
catch
    try
        % Read bathymetry
        load GSL_bathy_500m.mat;
        load gebco_colormap.dat;
    catch
        error('Cant not load bathy file.')
    end
end


% Default parameter
winSize = 0.1;

% Zone de la carte
% lon_min = min([lon lon_ais loc_site1(2) loc_site2(2)])-winSize;
% lon_max = max([lon lon_ais loc_site1(2) loc_site2(2)])+winSize;
% lat_min =  min([lat lat_ais loc_site1(1) loc_site2(1)])-winSize;
% lat_max =  max([lat lat_ais loc_site1(1) loc_site2(1)])+winSize;
lon_min = min([ lon loc_site1(2) loc_site2(2)])-winSize;
lon_max = max([ lon loc_site1(2) loc_site2(2)])+winSize;
lat_min =  min([ lat loc_site1(1) loc_site2(1)])-winSize;
lat_max =  max([ lat loc_site1(1) loc_site2(1)])+winSize;

% Les isobathes � contourer
isobath = [0:10:450];

% Dimensions de la figure sur papier (en cm)
paperwidth  = 24;
paperheight = 24;

figure(1)
clf
set(gcf,'Position',[100 100 800 800])
m_proj('mercator', 'long',[lon_min lon_max],'lat',[lat_min lat_max]);
m_grid('box','fancy','fontsize',8,'linestyle','none','fontname','times');

% Un beau colormap pour la bathymetrie qui vient de GEBCO
colormap(gebco_colormap);

hold on
m_contourf(LON,LAT,Z,isobath,'linestyle','none');
% Information graphique
c = colorbar('location','eastoutside');
%set(c,'Position',[0.2 0.2 0.4 0.02],'FontSize', 8, 'FontName','times','xAxisLocation','top');
cpos = c.Position;
set(c, 'FontSize', 8, 'FontName','times')
ylabel(c,'Depth(m)')
%m_text(-69.7,46.9,'Depth (m)','FontSize', 8, 'FontName','times','HorizontalAlignment','center');
xlabel('Longitude', 'FontSize', 10, 'FontName','times')
ylabel('Latitude', 'FontSize', 10, 'FontName','times')
set (gca,'TicklabelInterpreter','None')

m_gshhs_f('patch',[.7 .7 .7]); % coastlines

% Printing location

% ------------ Plot points ----------------
m_plot(loc_site1(2),loc_site1(1),'o','MarkerEdgeColor','k',...
    'MarkerFaceColor','r','MarkerSize',8) ;
m_plot(loc_site2(2),loc_site2(1),'o','MarkerEdgeColor','k',...
    'MarkerFaceColor','r','MarkerSize',8) ;



hr=   m_plot(lon,lat,'o','MarkerEdgeColor','k',...
    'MarkerFaceColor','k','MarkerSize',4) ;



disp('Done!')
end
