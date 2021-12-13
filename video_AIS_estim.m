addpath(genpath('C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation'));
    
% ship_AIS_file='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316004433_MLB_508_22_24h.mat';
% ship_AIS_file='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316023339_MLB_1408_22_24h.mat';
ship_AIS_file='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\OCEANEXCONNAIGRA_CLD_1807_19_21h.mat';
% ship_AIS_file=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\BLUEALEXANDRA_CLD_2107_11_14h.mat'];
% ship_AIS_file=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\NACCALICUDI_MLB_1708_7_8h.mat'];

% result_file='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\estim_loc_ALICUDI';
result_file='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\estim_loc_OCEANEXCONNAIGRA_circ';
videoName = result_file ;

load(ship_AIS_file);
load(result_file);

% loc_PRC= [48.5311 -64.1983];
loc_AAV= [49.0907 -64.5372];
% start_time_result=datenum(2021,08,17,7,0,0);
start_time_result=datenum(ptime(1));
quick_Map_video_result(vec_lat_ship, vec_long_ship,lat_ship', long_ship',loc_site,loc_AAV,vec_temps_ship,ptime,start_time_result,videoName);

% [anglePRC, distPRC] = getRealAngle(arrID , vec_lat_ship, vec_long_ship);
% 
% load(ship_AIS_PRC);
% [angleMLB, distMLB] = getRealAngle(arrID , vec_lat_ship, vec_long_ship);

% writerObj = VideoWriter([ videoName '.mp4'],'MPEG-4');
% writerObj.FrameRate = 20 ;
% writerObj.Quality = 100;
% open(writerObj)
%     
% figure,
% plot(loc_site(2),loc_site(1),'or'); 
% text(loc_site(2),loc_site(1)+0.01,arrID,'Color','r');
% hold on,plot(loc_PRC(2),loc_PRC(1),'or'); 
% text(loc_PRC(2),loc_PRC(1)+0.01,'PRC','Color','r');
% xlim([min([vec_long_ship loc_PRC(2) loc_site(2)])-0.01 max([vec_long_ship loc_PRC(2) loc_site(2)])+0.01]), 
% ylim([min([vec_lat_ship loc_PRC(1) loc_site(1)])-0.01 max([vec_lat_ship loc_PRC(1) loc_site(1)])+0.01])
% for ii=1:length(vec_temps_ship)
%     hold on, plot(vec_long_ship(ii), vec_lat_ship(ii),'kx');
%     title(datestr(vec_temps_ship(ii)/24/3600))
%     pause(0.1)
% %         h = gcf;
% %         F = getframe(h);
% %         writeVideo(writerObj,F)
% end
% %     close(writerObj)
% 
% 
% %%
