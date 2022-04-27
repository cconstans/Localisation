clear

% Add all function located in the three to path
addpath(genpath('C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\'));

% Need to run data or just open it a .mat
openData = false;
% Path information : folderIn = wav folder / folderOut = figure output folder
typeHL = 'LF';
AntenneCorrigee=1;
DataSave=1;
bateau='ALICUDI';
arrID='PRC';
% hydros2remove=2:2:20;
C=nchoosek(1:20,10);
k=randi(length(C));
hydros2remove=C(k,:);

% Spectro parameter
% fmin = 50;
% fmax = 1800;
fmin = 50;
fmax = 300;

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
% showFig = [ ]       % Figure number to print
printFig = false;    % Saving figure to a folder
nbPk = 4 ;          % Nomber of side lobe to keep

% Reading parameters
imDur = 2;%2^15 %+ (0.4 * 10000);              % Total number of sample
buffer = 0.5;             % Time in second to add before the ptime

folderOut=['C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\' arrID '_' num2str(jour) '0' num2str(mois) ...
    '_' num2str(heure) '_' num2str(round(heure+duree/3600)) 'h_f=[' num2str(fmin) '_' num2str(fmax) ']_rmv_H',...
    num2str(hydros2remove,'%02.0f') '_'  datestr(now,'yymmdd_HHMMSS')];
if ~AntenneCorrigee
    folderOut=[folderOut,'_circ'];
end

%% Spectrogram parameter
% spectrogram image parameters
spgm.im.freqlims = [fmin fmax];       % [Hz] frequency scale boundary limits
spgm.im.clims = [30 80];           % [dB] C limite pcolor
spgm.im.dur = imDur;%'all';         % [s or 'all'] figure duration
%spgm.im.ovlp = 50;                 % [%] image window overlap
spgm.im.figvision = true ;          % [true false] visiblity of figure before saveas jpf file
%spgm.im.movm = 100;                % Movmean parameter for the first panel
%spgm.im.FontS = 14;                % Image font Size
% spectrogram window parameters
spgm.win.dur = 2048/10000;          % [s] spectrogram window length duration
spgm.win.ovlp = 90;                 % [%] spectrogram window overlap
spgm.win.type = 'kaiser';
spgm.win.opad = 2;                  % [s] spectrogram zero padding
spgm.im.fmin = spgm.im.freqlims(1);spgm.im.fmax = spgm.im.freqlims(2);

%% BEAMFORMING
saveData=0;
mainBring_remove_hydros;

%%
c0=arr.c;
hydrofile=arr.hydrofile;
if DataSave
    save([folderOut '.mat'],'folderOut','hydrofile','bateau','c0','laps','angleA','angleM','ptime','matEnergie', ...
        'jour','mois','heure','minute','duree','arrID','fmin','fmax','AntenneCorrigee','hydros2remove')
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
% pcolor(ptime, 1:360, 10*log10(matEnergie'))
shading flat
cb = colorbar('location','eastoutside');
ylabel(cb, 'Energy (dB)');
colormap jet
hold on
hm = plot(ptime,angleM,'o','color','k','markersize',3,'markerfacecolor','k');hold on
hm2 = plot(vec_temps_ship(idx_deb:idx_fin)/(24*3600),angle(idx_deb:idx_fin),'k','LineWidth',2);

if AntenneCorrigee
    title({[ bateau ' ' num2str(jour) '/' num2str(mois) ' ' arrID ' f=[' num2str(fmin) '-' num2str(fmax) '] Hz'];...
        ['Hydros '  num2str(hydros2remove,'%02.0f') ' removed']});
else
    title([ bateau ' ' num2str(jour) '/' num2str(mois) ' ' arrID, ' f=[' num2str(fmin) '-' num2str(fmax) '] Hz non corrig�e ' ])
end