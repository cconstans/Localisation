%% Quelques paramètres
% Zone de la carte
lon_min = -71;
lon_max = -68.5;
lat_min =  46.75;
lat_max =  48.5;

% Les isobathes à contourer
isobath = [0:25:450];

% Dimensions de la figure sur papier (en cm) 
paperwidth  = 12;
paperheight = 12;


%% Lecture de donnees de bathymetrie
load GSL_bathy_500m.mat;

% Reduction des donnees par un facteur 'skip' pour alleger la figure
skip = 3;
LON = LON(1:skip:end,1:skip:end);
LAT = LAT(1:skip:end,1:skip:end);
Z   = Z(1:skip:end,1:skip:end);


%% Figure
figure(1)
clf

m_proj('mercator', 'long',[lon_min lon_max],'lat',[lat_min lat_max]);
m_grid('box','fancy','fontsize',8,'linestyle','none','fontname','times');

% Un beau colormap pour la bathymetrie qui vient de GEBCO
load gebco_colormap.dat;
colormap(gebco_colormap);

hold on
m_contourf(LON,LAT,Z,isobath,'linestyle','none'); 

c = colorbar('location','north');
set(c,'Position',[0.33 0.75 0.4 0.02],'FontSize', 8, 'FontName','times','xAxisLocation','top');
m_text(-63,51,'Depth (m)','FontSize', 8, 'FontName','times','HorizontalAlignment','center');

xlabel('Longitude', 'FontSize', 10, 'FontName','times')
ylabel('Latitude', 'FontSize', 10, 'FontName','times')

m_gshhs_l('patch',[.7 .7 .7]); % coastlines

set(gcf,'PaperUnits','centimeters');
set(gcf,'PaperSize',[paperwidth paperheight]);
set(gcf,'PaperPosition',[0 0 paperwidth paperheight]);
print('-dpng', '-r600','GSL_map.png');     
