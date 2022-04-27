clear

% Add all function located in the three to path
addpath(genpath('C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\'));

% Need to run data or just open it a .mat
openData = false;
% Path information : folderIn = wav folder / folderOut = figure output folder
typeHL = 'LF';
AntenneCorrigee=1;
DataSave=1;
% baleine='MLB_0408_9h_1';
% baleine='MLB_0408_12h_1';
% baleine='MLB_0408_12h_2';
% baleine='PRC_0408_12h_1';
% baleine='PRC_0408_12h_2';
baleine='PRC_0408_9h_1';
% baleine='PRC_0408_9h_2';
% baleine='CLD_1607_6h';
% baleine='AAV_1407_22h';
% baleine='blue_CLD_1507_9h';
% baleine='blue_CLD_1507_9h_2';
% baleine='blue_AAV_1507_9h';
% baleine='blue_AAV_1507_9h_2';
% baleine='blue_AAV_1307_23h';
% baleine='blue_CLD_1307_23h';
% baleine='rorq_AAV_1407_4h';
% baleine='rorq_CLD_1407_4h';
duree = 2;              % Total number of sample

fmin = 100;
fmax = 200;

get_whale_info;
% Spectro parameter
                
Ns = 2^16; 

% Figure parameters
showFig = [1  3  5  ];       % Figure number to print
% showFig = [ ]       % Figure number to print
printFig = false;    % Saving figure to a folder
nbPk = 4 ;          % Nomber of side lobe to keep

% Reading parameters
buffer = 0.5;             % Time in second to add before the ptime

folderOut=['C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\whales\'  baleine '_' datestr(now,'yymmdd_HHMMSS')];
if ~AntenneCorrigee
    folderOut=[folderOut,'_circ'];
end

%% Spectrogram parameter
% spectrogram image parameters
spgm.im.freqlims = [fmin fmax];       % [Hz] frequency scale boundary limits
spgm.im.clims = [30 80];           % [dB] C limite pcolor
spgm.im.dur = duree;%'all';         % [s or 'all'] figure duration
spgm.im.figvision = true ;          % [true false] visiblity of figure before saveas jpf file

% spectrogram window parameters
spgm.win.dur = 2048/10000;          % [s] spectrogram window length duration
spgm.win.ovlp = 90;                 % [%] spectrogram window overlap
% spgm.win.dur = 2048/10000/2;          % [s] spectrogram window length duration
% spgm.win.ovlp = 90/2;                 % [%] spectrogram window overlap
spgm.win.type = 'kaiser';
spgm.win.opad = 2;                  % [s] spectrogram zero padding
spgm.im.fmin = spgm.im.freqlims(1);spgm.im.fmax = spgm.im.freqlims(2);

%% BEAMFORMING
saveData=1;
[arrLoc, arr] = getArrInfo(arrID,AntenneCorrigee);

nbAzimut = 360*2;      % Number of azimut for calcul
azimut360 = linspace(0,360-360/nbAzimut,nbAzimut);
convPW.SH =-194;      % Parameter for power convertion
convPW.G = 40;
convPW.D = 1;


%% Beamforming

disp('Executing beamforming ')
close all

% Reading wav and extract values
[wav.s,wav.fs, time_s, audioInfo] = readBring(file_wav, ptime,'duration',spgm.im.dur,'buffer',buffer);
%file_wav = fileList{ifile};     % file name alone
spgm.fs = wav.fs; spgm.ns =  audioInfo.Ns; spgm.im.ns= spgm.ns; spgm.im.dur = audioInfo.dura;
spgm = getSpgmWin(spgm);        % Get spectograme windows parameter


% ------------------ BEAMFORMIGN -----------------------
wav.db =10^(-convPW.SH/20)*10^(-convPW.G/20)*convPW.D*wav.s;

% Get ponderation matrice
matPondahf = makePond(arrID,azimut360,spgm.im.ns,spgm.fs,AntenneCorrigee,'fmin',spgm.im.fmin,'fmax',spgm.im.fmax);

% Make the beamforming for all direction
%   [Pbf, timebf, freqbf, wavBF] = beamForming(arrID, wav.db , azimut360, spgm,'specmethod','spectro');


%  -------------- Goniométrie ---------------------

% Set frequence value
freqAll = (0:1:spgm.ns-1)*spgm.fs/spgm.ns;
indF = find( (freqAll >= spgm.im.fmin) & (freqAll <= spgm.im.fmax));
freq = freqAll(indF);
df = freq(2)-freq(1);

% Create matFFT of each chanel with only freq needed
matFFT2 = nan(size(wav.db));
for ii = 1:size(wav.db,2)
    matFFT2(:,ii) = fft(wav.db(:,ii));
end
matFFT = matFFT2(indF,:); clear matFFT2;

% Initiate Energie
Energie = nan(1,length(azimut360));

% Loop for energy over direction
for u = 1 : length(azimut360)
    matpondhf =squeeze(matPondahf(u,:,:));
    Energie(u) = 0;
    for v = 1 : length(freq)
        vecPond = (matpondhf(:,v)');
        vecFFT  = matFFT(v,:);
        %Energie(u) = Energie(u)+ (abs(sum(vec_pond.*vec_sfft)))^2;
        Energie(u) = Energie(u)+ 1/(spgm.ns*spgm.fs)*(abs(sum(vecPond.*vecFFT)))^2*df;
    end
end
    
% Other form of Energie unity
Energie_NORM = Energie/max(Energie);

% Find peak of energy
[pk, pkloc] = findpeaks(Energie_NORM,'SortStr','descend','NPeaks', 4 );%'MinPeakHeight',0.3);

% Find the direction of source
if length(pkloc) < nbPk; pkloc= [pkloc nan(1,nbPk - numel(pkloc)  )] ;end

pkloc(isnan(pkloc))=[];
angleA  = azimut360(pkloc);  % Angle of arrival with side lobe
angleM  = angleA(1);  % Max angle of arrival

% Keep the energie value in a matrix
% Printing figure
showBring;

%%
c0=arr.c;
hydrofile=arr.hydrofile;
if DataSave
    save([folderOut '.mat'],'folderOut','hydrofile','baleine','wav','c0','angleA','angleM','ptime','spgm','Energie','minute','duree','arrID','fmin','fmax','AntenneCorrigee')
end
% %%
% 
% % [ship_AIS_file,mois,jour,heure, minute, duree,distance_ship,loc_site,mmsi_ship,vec_lat_ship,...
% %     vec_long_ship,vec_temps_ship,x_ship_km,y_ship_km,folderIn]=get_ship_info(bateau,arrID);
% 
% [angle, dist] = getRealAngle(arrID , vec_lat_ship, vec_long_ship);
% idx_deb=find(vec_temps_ship/(24*3600)>=datenum(ptime(1)),1); 
% idx_fin=find(vec_temps_ship/(24*3600)>datenum(ptime(end)),1);
% if isempty(idx_fin) idx_fin=length(vec_temps_ship); end
% 
% figure
% pcolor(arrIncol(datenum(ptime)), 1:360, 10*log10(matEnergie'))
% shading flat
% cb = colorbar('location','eastoutside');
% ylabel(cb, 'Energy (dB)');
% colormap jet
% hold on
% hm = plot(ptime,angleM,'o','color','k','markersize',3,'markerfacecolor','k');hold on
% hm2 = plot(vec_temps_ship(idx_deb:idx_fin)/(24*3600),angle(idx_deb:idx_fin),'k','LineWidth',2);
% 
% if AntenneCorrigee
%     title([ bateau ' ' arrID ' f=[' num2str(fmin) '-' num2str(fmax) '] Hz'])
% else
%     title([ bateau ' ' arrID, ' f=[' num2str(fmin) '-' num2str(fmax) '] Hz non corrigée ' ])
% end