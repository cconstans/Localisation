clear

% Add all function located in the three to path
addpath(genpath('C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\'));

% Need to run data or just open it a .mat
openData = false;
% Path information : folderIn = wav folder / folderOut = figure output folder
typeHL = 'LF';
AntenneCorrigee=1;
saveData=1;
bateau='TB';

switch bateau
    case 'JJ'
        ship_AIS_file='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316006850_PRC_1608_7_9h.mat';
        load(ship_AIS_file);
        
        heure=7;
        minute=55;
        duree=3600*1;
    case 'Nacc'
        ship_AIS_file='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316034372_MLB_508_6_9h.mat';
        load(ship_AIS_file);
        
        heure=6;
        minute=55;
        duree=3600*1;
    case 'TB'
        ship_AIS_file='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316023339_MLB_1408_22_24h.mat';
        load(ship_AIS_file);
        
        heure=22;
        minute=0;
        duree=3600*2;
end
% arrID = 'MLB';
% ship_AIS_file=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX/ 'nom_sauvegarde];



% arrID=site;
switch arrID
    case 'AAV'
        folderIn = ['D:/Bring_Dep_1_Wav/' arrID '/' typeHL '/']; % Local Mac folder
    case 'CLD'
        folderIn = ['D:/Bring_Dep_1_Wav/' arrID '/' typeHL '/'];
    case 'MLB'
        folderIn = ['F:\Bring_Dep_2\' arrID '_wav\'];
    case 'PRC'
        folderIn = ['F:\Bring_Dep_2\' arrID '_wav\'];

end
folderOut=['C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\' arrID '_' num2str(jour) '0' num2str(mois) '_' num2str(heure) '_' num2str(round(heure+duree/3600)) 'h_' datestr(now,'yymmdd_HHMMSS')];
if ~AntenneCorrigee
    folderOut=[folderOut,'_circ'];
end
  Ns = 2^16;              % Total number of sample
laps=120;
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
fmax_int = 1800;


% If wanted to open alredy run script
if openData == true
    disp('Opening already run data')
    p = getRunData(pingFolder);
else
    if AntenneCorrigee
        locateBring_deform;
    else
        locateBRing; % The main loop calculation are locate in this script
    end
end
%%
% load(ship_AIS_file);

[angle, dist] = getRealAngle(arrID , vec_lat_ship, vec_long_ship);

figure, 
plot(vec_temps_ship/(24*3600),angle),datetick('x')
hold on,  plot(ptime,angleM,'rx');
ylim([0 360]), 
if AntenneCorrigee
    title([ arrID, ' azimuth ' num2str(mmsi_ship)])
else
    title([ arrID, ' non corrigée azimuth ' num2str(mmsi_ship)])
end
    legend('AIS','Bring')
    
% subplot(122), 
% figure,plot(vec_temps_ship/(24*3600),dist/1e3)
% datetick('x'),title([ arrID, ' distance (km)'])



%     videoName = [ship_AIS_file(1:end-4)  ];