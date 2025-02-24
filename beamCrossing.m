[loc] = beamCrossing(pos1,pos2,a1,a2,varargin)
% This script make a triangularization of two beam to find back to position
%[loc] = beamCrossing(pos1,pos2,a1,a2,varargin)
%https://www.mathworks.com/help/map/ref/polyxpoly.html

% need to add incertainty
% Last moif @ kevDuquette  3 nov 2021
showFig = [];
%% Varagin
while ~isempty(varargin)
    switch lower(varargin{1})
        case 'cellnumber'
            cellNumber = varargin{2};
            
        otherwise
            error(['Can''t understand property: ' varargin{1}])
    end
    varargin(1:2)=[];
end


%% Find angle curve

[lon1m,lat1m, phi1] = m_fdist(pos1(2),pos1(1), a1, 40 *1000);
[lon2m,lat2m, phi2] = m_fdist(pos2(2),pos2(1), a2, 40 *1000);

lon1m = lon1m - 360;
lon2m = lon2m -360;


lon1 = linspace(pos1(2),lon1m,1000);
lon2 = linspace(pos2(2),lon2m,1000);
lat1 = linspace(pos1(1),lat1m,1000);
lat2 = linspace(pos2(1),lat2m,1000);

[loni,lati] = polyxpoly(lon1,lat1,lon2,lat2);

loc = [lati, loni];
%% Figure
if any(showFig ==1)
    
    % Read bathymetry
    load ~/Documents/MATLAB/Oceanographie/m_map/mmap_ex/GSL_bathy_500m.mat;
    load ~/Documents/MATLAB/Oceanographie/m_map/mmap_ex/gebco_colormap.dat;
    
    close all
    % Zone de la carte
    winSize = 0.3;
    %winSize = 0.15;
    lon_min = -max(abs([pos1(:,2) pos2(:,2)])) - winSize;
    lon_max = -min(abs([pos1(:,2) pos2(:,2)])) + winSize ;
    lat_min =  min([pos1(:,1) pos2(:,1)]) -  winSize/2;
    lat_max =  max([pos1(:,1) pos2(:,1)]) + winSize/2;
    
    lon_min = -64.3;
    lon_max = -64;
    % Les isobathes � contourer
    isobath = [0:20:200];
    
    % Dimensions de la figure sur papier (en cm)
    paperwidth  = 12;
    paperheight = 12;
    
    
    figure(1)
    clf
    set(groot, 'defaultAxesTickLabelInterpreter','tex');
    m_proj('mercator', 'long',[lon_min lon_max],'lat',[lat_min lat_max]);
    m_grid('box','fancy','fontsize',8,'linestyle','none','fontname','times');
    %m_grid('box','fancy','fontsize',8,'linestyle','none','fontname','times','xticklabel',{'49�W'});
    
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
    set (gca,'TicklabelInterpreter','tex')
    
    m_gshhs_l('patch',[.7 .7 .7]); % coastlines
    
    
    % Hydrophone location
    hc1 = m_plot(pos1(2),pos1(1),'ro','MarkerFaceColor','r','MarkerSize',7);
    hc2 = m_plot(pos2(2),pos2(1),'ro','MarkerFaceColor','r','MarkerSize',7);
    
    % Plot line crossing
    l1 = m_plot(lon1,lat1,'-.k');
    l2 = m_plot(lon2,lat2,'-.k');
    
    % Plot the retrieve point
    pp = m_plot(loni,lati,'ko','MarkerFaceColor','r','MarkerSize',7);
    
    
    % Legend
    %leg = m_legend([hc1,pp], 'Array1','Retreive signal')
    %leg.Position = [49,-64,10,4]
    %leg.Position = [49,5,25,3]
    
    print('-dpng', '-r300',[folderOut 'beamCrossing' outName '.png']);
end