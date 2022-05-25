addpath(genpath('C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation'));

loc_PRC= [48.5311 -64.1983];
loc_AAV= [49.0907 -64.5372];
loc_MLB = [48.6039 -64.1863];
loc_CLD = [49.1933  -64.8315];
typeHL='LF';

site='AAV';
switch site
    case 'AAV'
        folderIn = ['D:/Bring_Dep_1_Wav/' site '/' typeHL '/']; % Local Mac folder
        startID=83; % take points from startID
        thetaexcluded=[];
        Z0=39.1;
         ship_AIS_file={'C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\NACCQUEBEC_AAV_1807_10_13h.mat',...
            'C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\QAMUTIK_AAV_1907_2_4h',...
            'C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\HELENAG_AAV_2107_13_17h',...
            'C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\HLSINES_AAV_2107_19_22h',...
            'C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\STARAYESHA_AAV_2207_22_25h',...
            'C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316003726_AAV_1907_10_12h'};
        timelim=[datenum(2021,07,18,11,45,0)*24*3600,datenum(2021,07,18,12,45,0)*24*3600;...
           datenum(2021,07,19,2,20,0)*24*3600,datenum(2021,07,19,3,15,0)*24*3600 ;...
           datenum(2021,07,21,15,0,0)*24*3600,datenum(2021,07,21,16,0,0)*24*3600 ;...
           datenum(2021,07,21,20,20,0)*24*3600,datenum(2021,07,21,21,50,0)*24*3600 ;...
           datenum(2021,07,22,22,16,0)*24*3600,datenum(2021,07,23,0,35,0)*24*3600 ;...
            datenum(2021,07,19,10,25,0)*24*3600,datenum(2021,07,19,10,50,0)*24*3600];
        
        loc_site1=loc_AAV;
        loc_site2=loc_CLD;
        loc_name1='AAV';
        loc_name2='CLD';
        
        lon_min= -64.9484;
        lon_max=-64.1;
        lat_min=49;
        lat_max = 49.385;
    case 'CLD'
        folderIn = ['D:/Bring_Dep_1_Wav/' site '/' typeHL '/'];
        startID=1;
        thetaexcluded=[];
        Z0=43.6;
        ship_AIS_file={'C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\NACCQUEBEC_CLD_1807_10_12h.mat',...
            'C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\QAMUTIK_CLD_1907_0_3h',...
            'C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316003726_CLD_1907_8_10h'};
        timelim=[datenum(2021,07,18,10,20,0)*24*3600,datenum(2021,07,18,11,20,0)*24*3600;...
            datenum(2021,07,19,1,17,0)*24*3600,datenum(2021,07,19,2,07,0)*24*3600 ;...
            datenum(2021,07,19,9,12,0)*24*3600,datenum(2021,07,19,9,35,0)*24*3600];
        
        loc_site1=loc_AAV;
        loc_site2=loc_CLD;
        loc_name1='AAV';
        loc_name2='CLD';
        
        lon_min= -65.1976;
        lon_max=-64.4372;
        lat_min= 48.9606;
        lat_max = 49.4528;
    case 'MLB'
        folderIn = ['H:\Bring_Dep_2\' site '_wav\'];
        startID=1001;
        thetaexcluded=[];
        Z0=37.1;
      ship_AIS_file={  'C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316034372_MLB_508_6_9h.mat',...
            'C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\NACCALICUDI_MLB_708_2_5h.mat',...
            'C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\SANDRAMARY_MLB_408_23_25h.mat',...
            'C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\STRAITHUNTER_MLB_3007_22_25h.mat',...
            'C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\NACCALICUDI_MLB_1708_7_9h.mat' };
        
        timelim=[ datenum(2021,08,5,7,0,0)*24*3600,datenum(2021,08,5,8,0,0)*24*3600;...
            datenum(2021,08,7,2,20,0)*24*3600,datenum(2021,08,7,3,20,0)*24*3600;...
            datenum(2021,08,5,0,10,0)*24*3600,datenum(2021,08,5,0,45,0)*24*3600;...
            datenum(2021,7,30,23,05,0)*24*3600,datenum(2021,7,31,0,0,0)*24*3600;...
            datenum(2021,08,17,7,25,0)*24*3600,datenum(2021,08,17,8,10,0)*24*3600;];
        
        loc_site1=loc_MLB;
        loc_site2=loc_PRC;
        loc_name1='MLB';
        loc_name2='PRC';
                
        lon_min=   -64.341645;
        lon_max=-63.9918;
        lat_min=  48.451205;
        lat_max =  48.649663;
    case 'PRC'
        folderIn = ['H:\Bring_Dep_2\' site '_wav\'];
        startID=1;
        thetaexcluded=[];
        Z0=40.7;
         ship_AIS_file={'C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316006850_PRC_1608_7_9h.mat',...
            'C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316034372_PRC_508_6_9h.mat',...
            'C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316023339_PRC_1408_22_24h',...
            'C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\CORIOLIS_PRC_108_5_8h'};
        timelim=[datenum(2021,08,16,8,5,0)*24*3600,datenum(2021,08,16,8,45,0)*24*3600;...
            datenum(2021,08,5,7,0,0)*24*3600,datenum(2021,08,5,7,50,0)*24*3600;...
            datenum(2021,08,14,22,04,0)*24*3600,datenum(2021,08,14,23,45,0)*24*3600;...
            datenum(2021,08,1,5,45,0)*24*3600,datenum(2021,08,1,8,9,0)*24*3600];
        
        loc_site1=loc_MLB;
        loc_site2=loc_PRC;
        loc_name1='MLB';
        loc_name2='PRC';
        
        lon_min=   -64.341645;
        lon_max=-63.95;
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
colors={[0.6350 0.0780 0.1840],'b','k',[0.8500 0.3250 0.0980],[0.9290 0.6940 0.1250],[0.4660 0.6740 0.1880]};
figure,

% lon_min = min([ vec_long_ship loc_site1(2) loc_site2(2)])-winSize;
% lon_max = max([ vec_long_ship loc_site1(2) loc_site2(2)])+winSize;
% lat_min =  min([ vec_lat_ship loc_site1(1) loc_site2(1)])-winSize;
% lat_max =  max([ vec_lat_ship loc_site1(1) loc_site2(1)])+winSize;

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

MinDist=400; % minimum distance for plane wave approx
MaxDist=35e3; % maximum distance for clear signal

for n=1:length(ship_AIS_file)
    load(ship_AIS_file{n});
    
     [anglen, distn] = getRealAngle(arrID , vec_lat_ship, vec_long_ship);
    distn(vec_temps_ship<timelim(n,1) | vec_temps_ship>timelim(n,2))=[];
    vec_lat_ship(vec_temps_ship<timelim(n,1) | vec_temps_ship>timelim(n,2))=[];
    vec_long_ship(vec_temps_ship<timelim(n,1) | vec_temps_ship>timelim(n,2))=[];
    
%     timen=datetime(vec_temps_ship/(24*3600),'ConvertFrom','datenum');
%     timen(vec_temps_ship<timelim(n,1) | vec_temps_ship>timelim(n,2))=[];
    
%     timen(distn<MinDist | distn>MaxDist)=[];
    vec_lat_ship(distn<MinDist | distn>MaxDist)=[];
    vec_long_ship(distn<MinDist | distn>MaxDist)=[];
    
    
    for i=1:length(vec_long_ship)
        hr=   m_plot(vec_long_ship(i),vec_lat_ship(i),'o','MarkerEdgeColor',colors{n},...
            'MarkerFaceColor',colors{n},'MarkerSize',4) ;
        hold on
    end
end
saveas(gcf,['trajectories filtered ' site '.fig'])
%
% figure,
%
% load(ship_AIS_file2);
%
%
% lon_min = min([ vec_long_ship loc_site1(2) loc_site2(2)])-winSize;
% lon_max = max([ vec_long_ship loc_site1(2) loc_site2(2)])+winSize;
% lat_min =  min([ vec_lat_ship loc_site1(1) loc_site2(1)])-winSize;
% lat_max =  max([ vec_lat_ship loc_site1(1) loc_site2(1)])+winSize;
%
% clf
% set(gcf,'Position',[100 100 800 800])
% m_proj('mercator', 'long',[lon_min lon_max],'lat',[lat_min lat_max]);
% m_grid('box','fancy','fontsize',8,'linestyle','none','fontname','times');
%
% % Un beau colormap pour la bathymetrie qui vient de GEBCO
% colormap(gebco_colormap);
%
% hold on
% m_contourf(LON,LAT,Z,isobath,'linestyle','none');
% % Information graphique
% c = colorbar('location','eastoutside');
% cpos = c.Position;
% set(c, 'FontSize', 8, 'FontName','times')
% ylabel(c,'Depth(m)')
% xlabel('Longitude', 'FontSize', 10, 'FontName','times')
% ylabel('Latitude', 'FontSize', 10, 'FontName','times')
% set (gca,'TicklabelInterpreter','None')
%
% m_gshhs_f('patch',[.7 .7 .7]); % coastlines
%
% % ------------ Plot points ----------------
%  m_plot(loc_site1(2),loc_site1(1),'o','MarkerEdgeColor','k',...
%      'MarkerFaceColor','r','MarkerSize',8) ;
%  m_text(loc_site1(2)+0.005,loc_site1(1)+0.005,'MLB')
%  m_plot(loc_site2(2),loc_site2(1),'o','MarkerEdgeColor','k',...
%      'MarkerFaceColor','r','MarkerSize',8) ;
%   m_text(loc_site2(2)+0.005,loc_site2(1)+0.005,'PRC')
%
% for i=1:length(vec_long_ship)
%         hr=   m_plot(vec_long_ship(i),vec_lat_ship(i),'o','MarkerEdgeColor','k',...
%             'MarkerFaceColor','k','MarkerSize',4) ;
%     hold on
% end