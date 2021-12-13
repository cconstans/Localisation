clear

% Add all function located in the three to path
addpath(genpath('C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\'));

% Need to run data or just open it a .mat
openData = false;
% Path information : folderIn = wav folder / folderOut = figure output folder
typeHL = 'LF';
AntenneCorrigee=1;
saveData=1;
bateau='TENACITYVENTURE';
arrID='CLD';


[ship_AIS_file,mois,jour,heure, minute, duree,distance_ship,loc_site,mmsi_ship,vec_lat_ship,...
    vec_long_ship,vec_temps_ship,x_ship_km,y_ship_km,folderIn]=get_ship_info(bateau,arrID);

  Ns = 2^16;              % Total number of sample
laps=60;
Ntime=duree/laps;
clear ptime
ptime(1)=datetime(2021,mois,jour,heure,minute,0);

for it=2:Ntime
ptime(it)=datetime(ptime(it-1)+seconds(laps));
end

% Figure parameters
showFig = [ ]       % Figure number to print
printFig = false;    % Saving figure to a folder
nbPk = 4 ;          % Nomber of side lobe to keep

% Reading parameters
buffer = 0.4;             % Time in second to add before the ptime

% Spectro parameter
% Frequence min and max
fmin_int = 50;
fmax_int = 1500;

folderOut=['C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\' arrID '_' num2str(jour) '0' num2str(mois) '_' num2str(heure) '_' num2str(round(heure+duree/3600)) 'h_f=[' num2str(fmin_int) '_' num2str(fmax_int) ']_' datestr(now,'yymmdd_HHMMSS')];
if ~AntenneCorrigee
    folderOut=[folderOut,'_circ'];
end

if openData == true
    disp('Opening already run data')
    p = getRunData(pingFolder);
else
    if AntenneCorrigee
        locate_Bring_deform;
    else
        locateBRing; % The main loop calculation are locate in this script
    end
end
%%
% load(ship_AIS_file);

[ship_AIS_file,mois,jour,heure, minute, duree,distance_ship,loc_site,mmsi_ship,vec_lat_ship,...
    vec_long_ship,vec_temps_ship,x_ship_km,y_ship_km,folderIn]=get_ship_info(bateau,arrID);

[angle, dist] = getRealAngle(arrID , vec_lat_ship, vec_long_ship);
idx_deb=find(vec_temps_ship/(24*3600)>=datenum(ptime(1)),1); 
idx_fin=find(vec_temps_ship/(24*3600)>datenum(ptime(end)),1);
if isempty(idx_fin) idx_fin=length(vec_temps_ship); end

figure
pcolor(arrIncol(datenum(ptime)), 1:360, 10*log10(matEnergie'))
shading flat
cb = colorbar('location','eastoutside');
ylabel(cb, 'Energy (dB)');
colormap jet
hold on
hm = plot(ptime,angleM,'o','color','k','markersize',3,'markerfacecolor','k');hold on
hm2 = plot(vec_temps_ship(idx_deb:idx_fin)/(24*3600),angle(idx_deb:idx_fin),'k','LineWidth',2);
% datetick('x');

% hold on,  plot(ptime,angleM,'rx');
% ylim([0 360]), 
if AntenneCorrigee
    title([ bateau ' ' arrID ' f=[' num2str(fmin_int) '-' num2str(fmax_int) '] Hz'])
else
    title([ bateau ' ' arrID, ' f=[' num2str(fmin_int) '-' num2str(fmax_int) '] Hz non corrig�e ' ])
end
%     legend('Energy','AIS','Bring')
    
% subplot(122), 
% figure,plot(vec_temps_ship/(24*3600),dist/1e3)
% datetick('x'),title([ arrID, ' distance (km)'])



%     videoName = [ship_AIS_file(1:end-4)  ];