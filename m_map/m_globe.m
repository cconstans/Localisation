% show the ice cover on a map
function m_glob(lon,lat, var)
%% Quelques paramètres
%I=find(lon>180); 
%lon(I)= lon(I)-360;

% Zone de la carte
lon_min = 0;
lon_max =  358;
lat_min =  -88;
lat_max =  88;


% Dimensions de la figure sur papier (en cm) 
paperwidth  = 18;
paperheight = 18;

%% La map

figure(1)
clf
%Type de projection
hold on
m_proj('miller', 'long',[lon_min lon_max],'lat',[lat_min lat_max]);
m_pcolor(lon,lat,var);
shading interp;
m_grid('box','fancy','fontsize',8,'linestyle','none','fontname','times');
c = colorbar('location','EastOutSide');
m_coast('patch',[.7 .7 .7]);
hold off

%label et setting
xlabel('Longitude', 'FontSize', 14, 'FontName','times')
ylabel('Latitude', 'FontSize', 14, 'FontName','times')
set(gca, 'fontsize', 14)
set(gcf,'PaperUnits','centimeters');
set(gcf,'PaperSize',[paperwidth paperheight]);
set(gcf,'PaperPosition',[0 0 paperwidth paperheight]);
end