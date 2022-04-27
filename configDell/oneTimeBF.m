%% WAV to fig spectrogram
%
% DESCRIPTION:
% Load audio file, make create a beamforming and convert fig in jpg file
% Use IML-PAM-Toolbox\wav_tools\wav_spectrogram_image.m to make this script developed by Florian A and Clement J
%
%
% UPDATES:
% 2021-11-20        Kevin.duquette@dfo-mpo.gc.ca (KD)

clc
clear all
close all
tic
%% Set parameters
% Location parameter
arrID = 'MLB';
%outName = 'aavLiveBoat_onlyTrackTime_Ns14_f150-200hz';
folderIn = [getDirectory(arrID) arrID '/']; % Local Mac folder
folderOut = [getDirectory('fout') 'compSpectro\'];
outName = '';
%folderIn = ['E:\Bring_Dep_1\' arrID '\'];
%folderOut = ['C:\Users\duquettek\Documents\BRing\results\' arrID '\spectro\']; %spectrogram'];
if ~isfolder(folderOut); disp(['Creating output folder: ' folderOut]); mkdir(folderOut); end

% Time specification
duration = 10;
time2Load = datetime(2021,08,04,00,52,51);
%time2Load = datetime(2021,08,04,00,50,00):minutes(5):datetime(2021,08,04,00,50,00);

% Number of direction
nbV =10;

% Azimut to look
aziCible=138;

% spectrogram image parameters
spgm.im.freqlims = [100 200];       % [Hz] frequency scale boundary limits
spgm.im.clims = [30 70];           % [dB] C limite pcolor
spgm.im.dur = duration;%'all';                % [s or 'all'] figure duration
spgm.im.ovlp = 50;                   % [%] image window overlap
spgm.im.figvision = true ;           % [true false] visiblity of figure before saveas jpf file
spgm.im.movm = 100;                  % Movmean parameter for the first panel
spgm.im.FontS = 14;                  % Image font Size
% spectrogram window parameters
spgm.win.dur = 2048/10000;          % [s] spectrogram window length duration
spgm.win.ovlp = 70;                 % [%] spectrogram window overlap
spgm.win.type = 'kaiser';
spgm.win.opad = 2;                  % [s] spectrogram zero padding


% Figure parameter
sp.height=20; sp.width=40; sp.nbx=2; sp.nby=nbV/sp.nbx;
sp.ledge=3; sp.redge=3.5; sp.tedge=2; sp.bedge=2;
sp.spacex=0.3; sp.spacey=0.3;
%sp.fracy = [0.1 0.3 0.3 0.3];
sp.pos=subplot2(sp);

% Other parameter
pwConv.SH =-194;
pwConv.G = 40;
pwConv.D = 1;

% Automated parameter and variables
% List file in the folderIn
file = getWavName(time2Load,folderIn);

% Get array information
[aPos arr]  = getArrInfo(arrID);

% Create azimut vector
azimutV = arr.azimutMax(1):(arr.azimutMax(2)-arr.azimutMax(1))/nbV:arr.azimutMax(2);%(0:nbV-1) * (360 / nbV);
%azimutV = aziCible;%arr.azimutMax(1):20:arr.azimutMax(2);

% Other variables needed
spgm.im.fmin = spgm.im.freqlims(1);
spgm.im.fmax = spgm.im.freqlims(2);

%% process

% Loop on file
ifile = 1;
disp([datestr(datetime('now')) ' | Load file ' file{ifile}]);

% Indice and time related
%ind2Read  = (j-1)*spgm.im.dur * spgm.fs+1 : j*spgm.im.dur * spgm.fs;
%timeWin = ind2Read / spgm.fs;

% Load informatyion
acinfo = audioinfo([folderIn file{ifile}]);

% Load audio
[wav.s,wav.fs,timeWin, audioInfo] = readBring([folderIn file{ifile}], time2Load,'duration',duration,'buffer',duration/2,'power2',true);
%[wav.s,wav.fs,timeWin] = audioread([folderIn file{ifile}],[ind2Read(1) ind2Read(end)]);
wav.ns = size(wav.s,1);
wav.ch = size(wav.s,2);
% Power conversion
wav.sdb = 10^(-pwConv.SH/20)*10^(-pwConv.G/20)*pwConv.D* wav.s;
spgm.fs = wav.fs;
spgm.im.ns = size(wav.s,1);

% Set parameter for beamformign
% define spectrogram window
spgm.win.ns = fix(spgm.win.dur*spgm.fs);
if strcmp(spgm.win.type , 'hanning')
    spgm.win.val = hanning(win.ns);
elseif strcmp(spgm.win.type , 'kaiser')
    spgm.win.wpond = kaiser(spgm.win.ns ,0.1102*(180-8.7));
    spgm.win.val = spgm.win.wpond*sqrt(spgm.win.ns/sum(spgm.win.wpond.^2)); %w_pond
end
spgm.win.novlp = fix(spgm.win.ovlp/100*spgm.win.ns);
spgm.win.nfft = max(256,2^nextpow2(spgm.win.ns*10));

% Beamforming
[Pdb, timeV, freqV, reconWav] = beamForming(arrID, wav.sdb , azimutV, spgm,'specmethod','spectro');
%spec.fmin = 100; spec.fmax=200; spec.Ns=spgm.im.ns; spec.Fs = spgm.fs;
%spec.winSz = spgm.win.ns; spec.rec = 0.9; spec.wpond =spgm.win.val; spec.zp =spgm.win.opad;
%[reconFFT, timeV, freqV ] = reconstruct(matPondahf, wav.s , azimutV, spec); ok=2

% Show Figure
showBF;


