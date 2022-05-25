%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Création d'un film du passage d'un bateau à partir des données AIS. Appelle la fonction quick_Map_video et nécessite le package m_map.

% Charlotte Constans 05/22
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

addpath(genpath('C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation'));
    
% ship_AIS_file='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316004433_MLB_508_22_24h.mat';
% ship_AIS_file='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316023339_MLB_1408_22_24h.mat';
% ship_AIS_file='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\OCEANEXCONNAIGRA_CLD_1807_18_21h.mat';
% ship_AIS_file=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\OCEANEXCONNAIGRA_CLD_1807_19_21h.mat'];
% ship_AIS_file=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316034372_PRC_508_6_9h.mat'];
% ship_AIS_file=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316023339_PRC_1408_22_24h.mat'];
% ship_AIS_file=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\CORIOLIS_PRC_108_5_8h.mat'];
% ship_AIS_file=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316006850_PRC_1608_7_9h.mat'];
% ship_AIS_file=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\NACCALICUDI_PRC_1708_7_9h.mat'];
ship_AIS_file='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\SAMUELRISLEY_PRC_3107_22_24h.mat';

videoName = [ship_AIS_file(1:end-4)  ]

load(ship_AIS_file);

loc_MLB = [48.6039 -64.1863]; % 0,0 en coord cart
loc_PRC= [48.5311 -64.1983]; % 
loc_AAV = [49.0907 -64.5372];
loc_CLD = [49.1933  -64.8315];

switch arrID
    case 'AAV'
        loc2=loc_CLD;
    case 'CLD'
        loc2=loc_AAV;
    case 'MLB'
        loc2=loc_PRC;
    case 'PRC'
        loc2=loc_MLB;
end
quick_Map_video(vec_lat_ship, vec_long_ship,loc_site,loc2,vec_temps_ship,videoName);
