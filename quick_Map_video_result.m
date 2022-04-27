function quick_Map_video_result(lat_ais,lon_ais,lat,lon, loc_site1,loc_site2,time,ptime,start_time_result,videoName)
% This function quicly plot positions
% quickMap(lat,lon,'type')
% typre of map: online / geoshow / mmap
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
lon_min = min([ lon(abs(lon)<Inf)' lon_ais loc_site1(2) loc_site2(2)])-winSize;
lon_max = max([ lon(abs(lon)<Inf)' lon_ais loc_site1(2) loc_site2(2)])+winSize;
lat_min =  min([ lat(abs(lat)<Inf)' lat_ais loc_site1(1) loc_site2(1)])-winSize;
lat_max =  max([ lat(abs(lat)<Inf)' lat_ais loc_site1(1) loc_site2(1)])+winSize;

% Les isobathes à contourer
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

 writerObj = VideoWriter([ videoName '.mp4'],'MPEG-4');
writerObj.FrameRate = 10 ;
writerObj.Quality = 100;
open(writerObj)

for i=1:length(lon)
    
    [~,id_t]=min(abs(datenum(ptime(i))*24*3600-time));
    if datenum(ptime(i))>start_time_result
        hr=   m_plot(lon(i),lat(i),'o','MarkerEdgeColor','r',...
            'MarkerFaceColor','r','MarkerSize',4) ;
    end
    hold on
    
    hr=   m_plot(lon_ais(id_t),lat_ais(id_t),'o','MarkerEdgeColor','k',...
        'MarkerFaceColor','k','MarkerSize',4) ;
    title(datestr(time(id_t)/24/3600))
    
    h = gcf;
    F = getframe(h);
    writeVideo(writerObj,F)
end
close(writerObj);

%print('-dpng', '-r300','figures/WBR_map_honguedo_transNCirc.png');
disp('Done!')
end
