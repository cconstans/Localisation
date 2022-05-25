%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Estimation de l'azimuth d'un bateau � partir des enregistrements des hydrophones sur
% une plage de temps d�finie et comparaison avec les donn�es AIS.
% Appelle le script de beamforming mainBring

% Charlotte Constans 05/22
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
addpath(genpath('C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\'));

%% Param�tres
typeHL = 'LF';
AntenneCorrigee=1; % Beamforming avec l'antenne corrig�es (positions des hydros calcul�es) ou circulaire.
DataSave=1;
bateau='MSCANGELA'; % Nom du bateau que l'on essaye de localise, rep�r� sur les donn�es AIS.
arrID='CLD'; % Site consid�r�e

% Spectro parameter
fmin = 20;
fmax = 1800;
% fmin = 50;
% fmax = 300;
Ns = 2^16;              % Total number of sample
laps=120;

% spectrogram image parameters
spgm.im.freqlims = [fmin fmax];       % [Hz] frequency scale boundary limits
spgm.im.clims = [30 80];           % [dB] C limite pcolor
spgm.im.dur = 2;%'all';         % [s or 'all'] figure duration
spgm.im.figvision = true ;          % [true false] visiblity of figure before saveas jpf file
% spectrogram window parameters
spgm.win.dur = 2048/10000;          % [s] spectrogram window length duration
spgm.win.ovlp = 90;                 % [%] spectrogram window overlap
spgm.win.type = 'kaiser';
spgm.win.opad = 2;                  % [s] spectrogram zero padding
spgm.im.fmin = spgm.im.freqlims(1);spgm.im.fmax = spgm.im.freqlims(2);

% Figure parameters
showFig = [ ];       % Figure number to print
printFig = false;    % Saving figure to a folder
nbPk = 4 ;          % Nomber of side lobe to keep

%%
[ship_AIS_file,mois,jour,heure, minute, duree,distance_ship,loc_site,mmsi_ship,vec_lat_ship,...
    vec_long_ship,vec_temps_ship,x_ship_km,y_ship_km,folderIn]=get_ship_info(bateau,arrID);

Ntime=duree/laps;
clear ptime
ptime(1)=datetime(2021,mois,jour,heure,minute,0);

for it=2:Ntime
    ptime(it)=datetime(ptime(it-1)+seconds(laps));
end

folderOut=['C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\' arrID '_' num2str(jour) '0' num2str(mois) '_' num2str(heure) '_' num2str(round(heure+duree/3600)) 'h_f=[' num2str(fmin) '_' num2str(fmax) ']_' datestr(now,'yymmdd_HHMMSS')];
if ~AntenneCorrigee
    folderOut=[folderOut,'_circ'];
end

%% BEAMFORMING
mainBring;

%%
c0=arr.c;
hydrofile=arr.hydrofile;
if DataSave
    save([folderOut '.mat'],'folderOut','hydrofile','bateau','c0','laps','angleA','angleM','ptime','matEnergie', 'jour','mois','heure','minute','duree','arrID','fmin','fmax','AntenneCorrigee')
end
%%

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

if AntenneCorrigee
    title([ bateau ' ' num2str(jour) '/' num2str(mois) ' ' arrID ' f=[' num2str(fmin) '-' num2str(fmax) '] Hz'])
else
    title([ bateau ' ' num2str(jour) '/' num2str(mois) ' ' arrID, ' f=[' num2str(fmin) '-' num2str(fmax) '] Hz non corrig�e ' ])
end
saveas(gcf,[folderOut '.fig']);