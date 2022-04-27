% This script run beamforming over some ping emission to find back the array. 
% 
% It use a folderIn location and an array of time to read
% Time to process might be specifiy by ptime = [datetime(xxx),datetime(xxx)]
% or by a get function [ploc, ptime ]  = getPingLoc('aav');
%
% The figure to plot can be specify by the argument showFig = [1 3 4..]
% Figure code and description are located in showFigBring.m and
% showGlobalFig.m
%
% last update 7/10/2021 by @kevDuquette


% -------------- Fixed variables --------------------

% Spectrop parameter / tempo for running modif
fmin_int =100;
fmax_int = 200;
Ns  = spgm.im.dur * 10000;


% Loading file information
[fileList, wavID] = getWavName(ptime, folderIn,typeHL);
wavInfo = audioinfo([folderIn fileList{1}]);
nbF = length(fileList);

% Array information
[arrLoc, arr] = getArrInfo(arrID);

% Spectro parameters
% Modification of variables into a structure spec. If you get error related
% to those name plase do a ctrl+f and modify new name.
spec.winSz = 2048;  % LFFT_spectro
spec.rec = 0.9; % REC
spec.ovlp = 1-spec.rec;
spec.wpond = kaiser(spec.winSz ,0.1102*(180-8.7)); 
spec.wpond = spec.wpond*sqrt(spec.winSz/sum(spec.wpond.^2)); %w_pond
spec.zp =4; % fact_zp
spec.fmin = fmin_int;
spec.fmax = fmax_int;
spgm.im.fmin = fmin_int;
spgm.im.fmax = fmax_int;

 % Length of wav in second to load
duraNs = Ns / 10000;     

% Sound velocities
c = 1475;

% Pcolor plot
spec.Lmin = 30; % Lmin
spec.Lmax = 70; % Lmax

NB_voies_visees = 72;

spec.SH =-194;
spec.G = 40;
spec.D = 1;

duree_film = 60;

% Creating a circle vecteur
xc =  arr.xh;
yc = arr.yh;

%Nc = 20;
%R = 10;
%theta = 0: 2*pi/(Nc) : 2*pi-2*pi/(Nc);

%offset = - (90-67) * pi /180; 
% Set hydropohone location and oriemntation
%if strcmp(arrOri,'clock')
%    xc = R*sin(theta +  offset * pi /180);
%    yc = R*cos(theta +  offset* pi /180);
%elseif strcmp(arrOri,'counter')
%    xc = R*cos(theta +  offset* pi /180);
%    yc = R*sin(theta +  offset* pi /180);
%end


% Creating the output folder
% disp(['Creating output folder: ' folderOut]); mkdir(folderOut); 

%% File loop

% _Pre-Initialisation
matEnergie = nan(nbF,360);
angleA = nan(nbF,nbPk);
angleM = nan(nbF,1);

%%
for iFile =1:length(fileList)
    disp(['Executing beamforming for file ' num2str(iFile) '/' num2str(length(fileList))])
%     close all
    
    
    % Reading wav
    [MAT_s,fe, time_s, audioInfo] = readBring([folderIn fileList{iFile}], ptime(iFile),'duration',duraNs,'buffer',buffer,'power2',true);
    file_wav = fileList{iFile};     % file name alone
    spec.Fs = fe; spec.Ns =  audioInfo.Ns;
    Ns = spec.Ns;
    spgm.im.ns = Ns;
    spgm.fs = fe;
    
    % Spectrogram window parameter
    spgm.win.ns = fix(spgm.win.dur*spgm.fs);
    if strcmp(spgm.win.type , 'hanning')
        spgm.win.val = hanning(win.ns);
    elseif strcmp(spgm.win.type , 'kaiser')
        spgm.win.wpond = kaiser(spgm.win.ns ,0.1102*(180-8.7));
        spgm.win.val = spgm.win.wpond*sqrt(spgm.win.ns/sum(spgm.win.wpond.^2)); %w_pond
    end
    spgm.win.novlp = fix(spgm.win.ovlp/100*spgm.win.ns);
    spgm.win.nfft = max(256,2^nextpow2(spgm.win.ns*10));

    % ------------------ BEAMFORMIGN -----------------------
    MAT_s_vs_t_h = 10^(-spec.SH/20)*10^(-spec.G/20)*spec.D*MAT_s;
    aa = size(MAT_s_vs_t_h);
    Nsample = aa(1,1);
    Nc =aa(1,2);
    Duree = (Nsample-1)*1/fe;
    time = (0:1:Nsample-1)*1/fe;
    t=time; % Need to be find and rename
    
    % visualisation spectrogramme channel 1
    [vec_temps, vec_freq, MAT_t_f_STFT_complexe, MAT_t_f_STFT_dB] = COMP_STFT_snapshot(MAT_s_vs_t_h(:,1),0, fe, spec.winSz, spec.rec, spec.wpond, spec.zp);
    
    
    % focalisation sur 1 snapshot particulier
    MAT_s_vs_t_h_INT = MAT_s_vs_t_h;
    
    % formation des FFT des channels
    MAT_ffts_vs_f_h_INT = nan(size(MAT_s_vs_t_h_INT));
    for u = 1 : Nc
        MAT_ffts_vs_f_h_INT(:,u)=fft(MAT_s_vs_t_h_INT(:,u));
    end
    vec_f = (0:1:spec.Ns-1)*fe/spec.Ns; % To check that line!
     
    indi_f = find( (vec_f >= fmin_int)&(vec_f <= fmax_int));
    MAT_ffts_vs_f_h_INT_INT = MAT_ffts_vs_f_h_INT(indi_f,:); 
    indiff = indi_f;
    vec_f_INT = vec_f(indi_f);
    
    NN = 360;
    vec_azimut = linspace(0,2*pi-2*pi/NN,NN);
    % on raisonne en azimut vs le barycentre du r�seau
    % Those lines have been modified by the new getArrInfo giving already
    % the position of the hydrophone.
    %x0 = mean(xc);
    %y0 = mean(yc);
    %xc_rel = xc - x0;
    %yc_rel = yc -y0;
    yc_rel = yc;
    xc_rel = xc;
    
    % formation des pond�rations frequence, azimut
    % cette matrice de pond�ration pourrait etre calculee en avance et charg�&e
    MAT_POND_vs_azim_h_freq = zeros(length(vec_azimut),length(xc_rel),length(vec_f_INT));
    Ncapt = length(xc_rel);
    for u = 1 : length(vec_azimut)
        for v = 1 : length(xc_rel)
            d_marche =-xc_rel(v)*sin(vec_azimut(u))+-yc_rel(v)*(cos(vec_azimut(u)));
            %MAT_POND_vs_azim_h_freq(u,v,:) = 1/Ncapt*exp(-sqrt(-1)*2*pi*vec_f_INT*d_marche/c);
            MAT_POND_vs_azim_h_freq(u,v,:) = 1/Ncapt*exp(-sqrt(-1)*2*pi*vec_f_INT*d_marche/c);
        end
    end
    

    % Goniom�trie -------------------> Figure 2,3
    % To be recode with less variables
    Energie = nan(1,length(vec_azimut));
    df = vec_f(2) -vec_f(1);
    for u = 1 : length(vec_azimut)
        MAT_POND_vs_h_freq =squeeze(MAT_POND_vs_azim_h_freq(u,:,:));
        Energie(u) = 0;
        for v = 1 : length(vec_f_INT)
            vec_pond = (MAT_POND_vs_h_freq(:,v)');
            vec_sfft  = MAT_ffts_vs_f_h_INT_INT(v,:);
            %Energie(u) = Energie(u)+ (abs(sum(vec_pond.*vec_sfft)))^2;
            Energie(u) = Energie(u)+ 1/(Ns*fe)*(abs(sum(vec_pond.*vec_sfft)))^2*df;
        end
    end
    
    % Other form of Energie unity
    Energie_NORM = Energie/max(Energie);
    Energie_dB = 10*log10(Energie);
    
    % Find peak of energy
    [pk pkloc] = findpeaks(Energie_NORM,'SortStr','descend','NPeaks', 4 );%'MinPeakHeight',0.3);
    
    % Find the direction of source

    if length(pkloc) < nbPk; pkloc= [pkloc nan(1,nbPk - numel(pkloc)  )] ;end
        
    angleA(iFile, : )  = pkloc;  % Angle of arrival with side lobe
    angleM(1,iFile)  = pkloc(1);  % Max angle of arrival

   
    % Keep the energie value in a matrix
    matEnergie(iFile, :) = Energie;
    
    % Printing figure

    save_showFig_211203;
end % end loop on file



% Show global figure
showGlobalFig;


% Saving data
if saveData
        save([folderOut '.mat'],'laps','angleA','angleM','ptime','matEnergie', 'jour','mois','heure','minute','duree','arrID','fmin_int','fmax_int','AntenneCorrigee')
end