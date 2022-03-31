function [loc, ai ]= getArrInfo(hID,AntenneCorrigee)
% Get the most accurate array location for the moment
% [loc arr]= getArrInfo(hID)
% Where loc is the geopositon of the arr and arr is a structure containing
% many informations like the order, hydro. position,
%[loc offSet arrOri]= getArrLoc(hID)  -> old Syntaxe obsolet.

switch lower(hID)
    case 'aav'
        hydrofile='Data loc\AAVv5_c0=1480 3_boats.mat';
        ai.loc = [49.0907 -64.5372];
        ai.offSet = -23;
        ai.arrOri = 'clock';
        ai.azimutMax = [-90, 90];
        
    case 'mlb'
%         hydrofile='Data loc\MLBv5_c0=1480 4_boats.mat';
%         hydrofile='Data loc\MLB_220330_NS_c0=1480_5_boats.mat';
        hydrofile='Data loc\MLB_220331_NS_20km_c0=1480_5_boats';
        ai.loc = [48.6039 -64.1863];
        ai.offSet = -78;
        ai.arrOri = 'clock';
        ai.azimutMax = [0, 180];
    case 'prc'
%         hydrofile='Data loc\PRCv5_c0=1480 4_boats.mat';
%         hydrofile='Data loc\PRC_220330_NS_c0=1480_6_boats';
        hydrofile='Data loc\PRC_220331_NS_20km_c0=1480_6_boats';
        ai.loc= [48.5311 -64.1983];
        ai.offSet = 135;
        ai.arrOri = 'clock';
        ai.azimutMax = [0, 180];
    case 'cld'
        hydrofile='Data loc\CLDv5_c0=1480 3_boats.mat';
        ai.loc = [49.1933  -64.8315];
        ai.offSet = 97;
        ai.arrOri = 'counter';        ai.azimutMax = [-60, 120];
    otherwise
        error(['Can''t location. AV = Anse-a-Valleau, CD = Cloridorme, MB = Malbay, PC = Perce.' ])
end
load(hydrofile,'X','Y','c0');
ai.xh=X;
ai.yh=Y;
ai.hydrofile=hydrofile;

if ~AntenneCorrigee
    
    Nc = 20;
    R = 10;
    theta = 0: 2*pi/(Nc) : 2*pi-2*pi/(Nc);
    if strcmp(ai.arrOri,'clock')
        xc = R*sin(theta +  ai.offSet * pi /180);
        yc = R*cos(theta +   ai.offSet* pi /180);
    elseif strcmp(ai.arrOri,'counter')
        xc = R*cos(theta +   ai.offSet* pi /180);
        yc = R*sin(theta +   ai.offSet* pi /180);
    end
    ai.xh=xc;
    ai.yh=yc;
    ai.hydrofile='circular';
end
% First outarg: Will change eventually with updated code.
loc = ai.loc;

% Center arr to center after new position have been input.
x0 = mean(ai.xh);
y0 = mean(ai.yh);
ai.xh = ai.xh - x0;
ai.yh = ai.yh - y0;

% Sound Speed
ai.c = c0;

end
