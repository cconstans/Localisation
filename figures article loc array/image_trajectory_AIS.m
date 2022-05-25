addpath(genpath('C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation'));

bateau='SAMUELRISLEY';
switch bateau
    case 'MSCANGELA'
        ship_AIS_file=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\MSCANGELA_AAV_2007_2_5h.mat'];
        site='AAV';
    case 'SAMUELRISLEY'
        ship_AIS_file='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\SAMUELRISLEY_PRC_3107_22_24h.mat';
        site='PRC';
        
    case 'ALICUDI'
        ship_AIS_file=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\NACCALICUDI_MLB_1708_7_9h.mat'];
        site='MLB';

    case 'OCEANEXCONNAIGRA'
        site='AAV';

         ship_AIS_file=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\OCEANEXCONNAIGRA_AAV_1807_18_21h.mat'];
        load(ship_AIS_file);
        heure=20;
        minute=0;
        duree=3600*1.5;
end
% ship_AIS_file='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316004433_MLB_508_22_24h.mat';
% ship_AIS_file='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316023339_MLB_1408_22_24h.mat';
% ship_AIS_file='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\OCEANEXCONNAIGRA_CLD_1807_18_21h.mat';
% ship_AIS_file=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\OCEANEXCONNAIGRA_CLD_1807_19_21h.mat'];

load(ship_AIS_file);

loc_PRC= [48.5311 -64.1983];
loc_AAV= [49.0907 -64.5372];
loc_MLB = [48.6039 -64.1863];
loc_CLD = [49.1933  -64.8315];

switch site
    case 'AAV'
        loc_site1=loc_AAV;
        loc_site2=loc_CLD;
        loc_name1='AAV';
        loc_name2='CLD';
        
        lon_min= -64.9484;
        lon_max=-64.2046;
        lat_min=48.8977;
        lat_max = 49.3595;
    case 'CLD'
       
        loc_site1=loc_AAV;
        loc_site2=loc_CLD;
        loc_name1='AAV';
        loc_name2='CLD';
        
        lon_min= -65.1976;
        lon_max=-64.4372;
        lat_min= 48.9606;
        lat_max = 49.4528;
    case 'MLB'
       
        loc_site1=loc_MLB;
        loc_site2=loc_PRC;
        loc_name1='MLB';
        loc_name2='PRC';
                
        lon_min=   -64.341645;
        lon_max=-63.9918;
        lat_min=  48.451205;
        lat_max =  48.649663;
    case 'PRC'
        
        loc_site1=loc_MLB;
        loc_site2=loc_PRC;
        loc_name1='MLB';
        loc_name2='PRC';
        
        lon_min=   -64.341645;
        lon_max=-63.9918;
        lat_min=  48.451205;
        lat_max =  48.649663;
end


% Read bathymetry
load m_map/mmap_ex/GSL_bathy_500m.mat;
load m_map/mmap_ex/gebco_colormap.dat;

winSize = 0.1;
% Zone de la carte
isobath = [0:10:450];

paperwidth  = 24;
paperheight = 24;
colors={'r','k','w','b'};
figure,

% lon_min = min([ vec_long_ship loc_site1(2) loc_site2(2)])-winSize;
% lon_max = max([ vec_long_ship loc_site1(2) loc_site2(2)])+winSize;
% lat_min =  min([ vec_lat_ship loc_site1(1) loc_site2(1)])-winSize;
% lat_max =  max([ vec_lat_ship loc_site1(1) loc_site2(1)])+winSize;

clf
set(gcf,'Position',[100 100 800 800])
m_proj('albers equal-area', 'long',[lon_min lon_max],'lat',[lat_min lat_max]);
m_grid('box','fancy','fontsize',8,'linestyle','none','fontname','times');

% Un beau colormap pour la bathymetrie qui vient de GEBCO
colormap(gebco_colormap);

hold on
m_contourf(LON,LAT,Z,isobath,'linestyle','none');
% Information graphique
c = colorbar('location','eastoutside');
cpos = c.Position;
set(c, 'FontSize', 8, 'FontName','times')
ylabel(c,'Depth(m)')
xlabel('Longitude', 'FontSize', 10, 'FontName','times')
ylabel('Latitude', 'FontSize', 10, 'FontName','times')
set (gca,'TicklabelInterpreter','None')

m_gshhs_f('patch',[.7 .7 .7]); % coastlines

% ------------ Plot points ----------------
m_plot(loc_site1(2),loc_site1(1),'o','MarkerEdgeColor','k',...
    'MarkerFaceColor','r','MarkerSize',8) ;
m_text(loc_site1(2)+0.01,loc_site1(1)+0.01,loc_name1)
m_plot(loc_site2(2),loc_site2(1),'o','MarkerEdgeColor','k',...
    'MarkerFaceColor','r','MarkerSize',8) ;
m_text(loc_site2(2)+0.01,loc_site2(1)+0.01,loc_name2)

    for i=1:length(vec_long_ship)
        hr=   m_plot(vec_long_ship(i),vec_lat_ship(i),'o','MarkerEdgeColor','k',...
            'MarkerFaceColor','k','MarkerSize',4) ;
        hold on
%         title(datestr(vec_temps_ship(i)/24/3600))
%         pause;
    end
% title(bateau)
m_ruler([0.15  0.3750],0.1)
saveas(gcf,['trajectory ' bateau '_' site '2.fig'])
%