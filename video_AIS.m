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
