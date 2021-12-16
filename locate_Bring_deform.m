% This script run beamforming over some ping emission to find back the array.
%
% It use a folderIn location and an array of time to read
% Time to process might be specifiy by ptime = [datetime(xxx),datetime(xxx)]
% or by a get function [ploc, ptime ]  = getPingLoc('aav');
%
% The figure to plot can be specify by the argument showFig = [1 3 4..]
% Figure code and description are located in showFigBring.m
%


% -------------- Fixed variables --------------------

% Loading file information
[fileList wavID] = getWavName(ptime, folderIn,typeHL);
wavInfo = audioinfo([folderIn fileList{1}]);
nbF = length(fileList);

% Array information
% [arrLoc, offset, arrOri] = getArrLoc(arrID);

% Spectro parameters
% Spectro windows
LFFT_spectro = 2048;
LFFT_FV = Ns;
REC = 0.9;
w_pond = kaiser(LFFT_spectro ,0.1102*(180-8.7)); w_pond = w_pond*sqrt(LFFT_spectro/sum(w_pond.^2));
fact_zp =4;

% Length of wav in second to load
duraNs = Ns / 10000;


% Pcolor plot
Lmin = 30;
Lmax = 70;

SH =-194;
G = 40;
D = 1;

% Set hydropohone location and oriemntation
% switch arrID
%     case 'AAV'
%         hydrofile='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Data loc/AAV_filtOpt=0_211104_131035.mat';
%     case 'MLB'
%         hydrofile='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Data loc/MLB_filtOpt=0_211104_131415.mat';
%     case 'PRC'
%         hydrofile='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Data loc/PRC_filtOpt=0_211104_131656.mat';
%     case 'CLD'
%         hydrofile='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Data loc/CLD_filtOpt=0_211109_101636.mat';
% end

% switch arrID
%     case 'AAV'
%         hydrofile='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Data loc/AAVv3_filtOpt=0_c0=1480.mat';
%     case 'MLB'
%        hydrofile='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Data loc/MLBv3_filtOpt=0_c0=1480.mat';
%     case 'PRC'
%         hydrofile='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Data loc/PRCv3_filtOpt=0_c0=1480.mat';
%     case 'CLD'
%         hydrofile='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Data loc/CLDv3_filtOpt=0_c0=1480.mat';
% end
switch arrID
    case 'AAV'
        hydrofile='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Data loc\AAVv4_c0=1480 3_boats.mat';
    case 'MLB'
%         hydrofile='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Data loc\MLBv4_c0=1480.mat';
        hydrofile='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Data loc\MLBv4_c0=1480 4_boats.mat';
    case 'PRC'
%         hydrofile='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Data loc\PRCv4_c0=1480.mat';
        hydrofile='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Data loc\PRCv4_c0=1480 4_boats.mat';
    case 'CLD'
        hydrofile='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Data loc\CLDv4_c0=1480 3_boats.mat';
end
load(hydrofile,'X','Y','c0');

xc=X;
yc=Y;

%% File loop

matEnergie = nan(nbF,360);
angleA = nan(nbF,nbPk);
angleM = nan(nbF,1);
%%
fft_name=['C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\FFTs\' bateau '_' arrID '.mat'];

for iFile =1:length(fileList)
    tic
    
    disp(['Executing beamforming for file ' num2str(iFile) '/' num2str(length(fileList))])
    
    % Reading wav
    [MAT_s,fe, tstart, dura] = readBring([folderIn fileList{iFile}], ptime(iFile),'duration',duraNs,'buffer',buffer,'power2',true);

    file_wav = fileList{iFile};     % file name alone
    
    % ------------------ BEAMFORMING -----------------------
    MAT_s_vs_t_h = 10^(-SH/20)*10^(-G/20)*D*MAT_s;
    Nsample = size(MAT_s_vs_t_h,1);
    Nc =size(MAT_s_vs_t_h,2);
    Duree = (Nsample-1)*1/fe;
    t = (0:1:Nsample-1)*1/fe;
    
    % visualisation spectrogramme channel 1
    [vec_temps, vec_freq, MAT_t_f_STFT_complexe, MAT_t_f_STFT_dB] = COMP_STFT_snapshot(MAT_s_vs_t_h(:,1),0, fe, LFFT_spectro, REC, w_pond, fact_zp);
    
    % formation des FFT des channels
    MAT_ffts_vs_f_h_INT = nan(size(MAT_s_vs_t_h));
    for u = 1 : Nc
        MAT_ffts_vs_f_h_INT(:,u)=fft(MAT_s_vs_t_h(:,u));
    end
    vec_f = (0:1:LFFT_FV-1)*fe/LFFT_FV;
    
    indi_f = find( (vec_f >= fmin_int)&(vec_f <= fmax_int));
    MAT_ffts_vs_f_h_INT_INT = MAT_ffts_vs_f_h_INT(indi_f,:);
    vec_f_INT = vec_f(indi_f);

    % on raisonne en azimut vs le barycentre du réseau
    x0 = mean(xc);
    y0 = mean(yc);
    xc_rel = xc - x0;
    yc_rel = yc -y0;
    NN = 360;
    vec_azimut = linspace(0,2*pi-2*pi/NN,NN);
    
    % formation des pondérations frequence, azimut
    % cette matrice de pondération pourrait etre calculee en avance et chargé&e
    MAT_POND_vs_azim_h_freq = zeros(length(vec_azimut),length(xc_rel),length(vec_f_INT));
    Ncapt = length(xc_rel);
    for u = 1 : length(vec_azimut)
        for v = 1 : length(xc_rel)
            d_marche =-xc_rel(v)*sin(vec_azimut(u))+-yc_rel(v)*(cos(vec_azimut(u)));
            MAT_POND_vs_azim_h_freq(u,v,:) = 1/Ncapt*exp(-sqrt(-1)*2*pi*vec_f_INT*d_marche/c0);
        end
    end
    
    
    % Goniométrie -------------------> Figure 2,3
    Energie = [];
    df = vec_f_INT(2) -vec_f_INT(1);
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
    if Energie_NORM(1)>Energie_NORM(pkloc(1)) && Energie_NORM(1)>Energie_NORM(end)
        pkloc=[1 pkloc(1:3)];
    elseif Energie_NORM(end)>Energie_NORM(pkloc(1)) && Energie_NORM(end)>Energie_NORM(1)
        pkloc=[0 pkloc(1:3)];
    end
    % Find the direction of source
    angleA(iFile, 1:length(pkloc) )  = pkloc;  % Angle of arrival with side lobe
    angleM(iFile)  = pkloc(1);  % Max angle of arrival
    
    
    % Keep the energie value in a matrix
    matEnergie(iFile, :) = Energie;
    
    % Printing figure
    show_fig_ship;
    toc
end % end loop on file

% Show global figure
% showGlobalFig;

% Saving data
if saveData
    save([folderOut '.mat'],'hydrofile','bateau','c0','laps','angleA','angleM','ptime','matEnergie', 'jour','mois','heure','minute','duree','arrID','fmin_int','fmax_int','AntenneCorrigee')
end
