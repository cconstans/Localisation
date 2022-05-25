%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Création d'un film du passage d'un bateau à partir des données AIS et de
% la localisation estimée par beamforming. Appelle la fonction
% quick_Map_video et nécessite le package m_map.

% Charlotte Constans 05/22
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


addpath(genpath('C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation'));
    
% ship_AIS_file='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316004433_MLB_508_22_24h.mat';
% ship_AIS_file='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316023339_MLB_1408_22_24h.mat';
% ship_AIS_file='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\LAKEONTARIO_CLD_1507_9_11h.mat';
% ship_AIS_file=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\BLUEALEXANDRA_CLD_2107_11_14h.mat'];
% ship_AIS_file='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\SAMUELRISLEY_PRC_3107_22_24h.mat';
ship_AIS_file=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\MSCANGELA_CLD_2007_2_5h.mat'];

result_file='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\estim_loc_MSCANGELA';
videoName = result_file ;

load(ship_AIS_file);
load(result_file);

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

start_time_result=datenum(ptime(1));
quick_Map_video_result(vec_lat_ship, vec_long_ship,lat_ship', long_ship',loc_site,loc2,vec_temps_ship,ptime,start_time_result,videoName);
