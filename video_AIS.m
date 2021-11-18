
    
% ship_AIS_MLB='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316004433_MLB_508_22_24h.mat';
% ship_AIS_file='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316023339_MLB_1408_22_24h.mat';

videoName = [ship_AIS_file(1:end-4)  ];

load(ship_AIS_file);

loc_PRC= [48.5311 -64.1983];

% [anglePRC, distPRC] = getRealAngle(arrID , vec_lat_ship, vec_long_ship);
% 
% load(ship_AIS_PRC);
% [angleMLB, distMLB] = getRealAngle(arrID , vec_lat_ship, vec_long_ship);

writerObj = VideoWriter([ videoName '.mp4'],'MPEG-4');
writerObj.FrameRate = 20 ;
writerObj.Quality = 100;
open(writerObj)
    
figure,
plot(loc_site(2),loc_site(1),'or'); 
text(loc_site(2),loc_site(1)+0.01,arrID,'Color','r');
hold on,plot(loc_PRC(2),loc_PRC(1),'or'); 
text(loc_PRC(2),loc_PRC(1)+0.01,'PRC','Color','r');
xlim([min([vec_long_ship loc_PRC(2) loc_site(2)])-0.01 max([vec_long_ship loc_PRC(2) loc_site(2)])+0.01]), 
ylim([min([vec_lat_ship loc_PRC(1) loc_site(1)])-0.01 max([vec_lat_ship loc_PRC(1) loc_site(1)])+0.01])
for ii=1:length(vec_temps_ship)
    hold on, plot(vec_long_ship(ii), vec_lat_ship(ii),'kx');
    title(datestr(vec_temps_ship(ii)/24/3600))
    
        h = gcf;
        F = getframe(h);
        writeVideo(writerObj,F)
end
    close(writerObj)
