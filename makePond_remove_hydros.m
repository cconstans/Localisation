function [matPondahf] = makePond_remove_hydros(arrID,azimut,Ns,Fs,AntenneCorrigee,hydros2remove,varargin)
%%
while ~isempty(varargin)
        switch lower(varargin{1})
            case 'fmin'
                fmin = varargin{2};
            case 'fmax'
                fmax = varargin{2};
            otherwise
                error(['Can''t understand property: ' varargin{1}])
        end
            varargin(1:2)=[];
end

%%

% Get array info
[aPos, arr]  = getArrInfo(arrID,AntenneCorrigee);
arr.xh(hydros2remove)=[];
arr.yh(hydros2remove)=[];

if ~AntenneCorrigee
    
    Nc = 20-length(hydros2remove);
    R = 10;
    theta = 0: 2*pi/(Nc) : 2*pi-2*pi/(Nc);
    if strcmp(arr.arrOri,'clock')
        xc = R*sin(theta +  arr.offSet * pi /180);
        yc = R*cos(theta +   arr.offSet* pi /180);
    elseif strcmp(arr.arrOri,'counter')
        xc = R*cos(theta +   arr.offSet* pi /180);
        yc = R*sin(theta +   arr.offSet* pi /180);
    end
    arr.xh=xc;
    arr.yh=yc;
end
% Get array needed
azimutR= pi* azimut/180;  % Vector azimut
freq = (0:1:Ns-1)*Fs/Ns;  % Vector frequence 

% Get freq lim
if ~exist('fmin')
    fmin = min(freq);
end 
if ~exist('fmax')
    fmax = max(freq);
end 

% Create an azimut vecteur  
indF = find( (freq >= fmin)&(freq <= fmax));
freqF = freq(indF);


% Matrice of ponderation
matPondahf = zeros(length(azimutR),length(arr.xh),length(freqF));
Ncapt = length(arr.xh);
for u = 1 : length(azimutR)
    for v = 1 : length(arr.xh)
        d_marche =-arr.xh(v)*sin(azimutR(u))+-arr.yh(v)*(cos(azimutR(u)));
        %MAT_POND_vs_azim_h_freq(u,v,:) = 1/Ncapt*exp(-sqrt(-1)*2*pi*vec_f_INT*d_marche/c);
        matPondahf(u,v,:) = 1/Ncapt*exp(-sqrt(-1)*2*pi*freqF*d_marche/arr.c);
    end
end

end % Function
