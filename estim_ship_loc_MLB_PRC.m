clear 
AntenneCorrigee=0;
bateau='SAMUELRISLEY';
switch bateau
    case 'SAMUELRISLEY'
        if AntenneCorrigee
            dataMLB='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\MLB_3107_22_23h_f=[20_1800]_220331_144958';
            dataPRC='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\PRC_3107_22_23h_f=[20_1800]_220331_144930';
        else
            dataMLB='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\MLB_3107_22_23h_f=[20_1800]_220331_145351_circ';
            dataPRC='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\PRC_3107_22_23h_f=[20_1800]_220331_145419_circ';
        end
        ship_AIS_PRC='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\SAMUELRISLEY_PRC_3107_22_24h.mat';
        ship_AIS_MLB='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\SAMUELRISLEY_MLB_3107_22_24h.mat';
        t0= datenum(2021,7,31,22,25,0);
        tend= datenum(2021,7,31,23,5,0);
    case 'JJ'
        if AntenneCorrigee
            dataMLB='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\MLB_1608_7_8h_211124_111435';
            dataPRC='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\PRC_1608_7_8h_211124_111419';
        else
            dataMLB='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\MLB_1608_7_8h_211118_102424_circ';
            dataPRC='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\PRC_1608_7_8h_211118_101340_circ';
        end
        ship_AIS_PRC='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316006850_PRC_1608_7_9h.mat';
        ship_AIS_MLB='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316006850_MLB_1608_7_9h.mat';
        
    case 'Nacc'
        if ~AntenneCorrigee
            dataMLB='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\MLB_508_6_7h_211118_090133_circ';
            dataPRC='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\PRC_508_6_7h_211117_164951_circ';
        else           dataMLB='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\MLB_508_6_7h_211124_105135';
            dataPRC='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\PRC_508_6_7h_211124_105157';
        end
        ship_AIS_PRC='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316034372_PRC_508_6_9h.mat';
        ship_AIS_MLB='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316034372_MLB_508_6_9h.mat';
        
    case 'TB'
        
        if AntenneCorrigee
            dataMLB='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\MLB_1408_22_24h_211118_122744';
            dataPRC='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\PRC_1408_22_24h_211118_122758';
        else
            dataMLB='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\MLB_1408_22_24h_211118_131928_circ';
            dataPRC='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\PRC_1408_22_24h_211118_131943_circ';
        end
        ship_AIS_PRC='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316023339_PRC_1408_22_24h.mat';
        ship_AIS_MLB='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316023339_MLB_1408_22_24h.mat';
        
    case 'Coriolis'
                
        if AntenneCorrigee
            dataMLB='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\MLB_108_5_8h_211130_092912';
            dataPRC='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\PRC_108_5_8h_211130_093015';
        else
            dataPRC='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\PRC_108_5_8h_211130_102916_circ';
            dataMLB='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\MLB_108_5_8h_211130_102943_circ';
        end
        ship_AIS_PRC='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\CORIOLIS_PRC_108_5_8h.mat';
        ship_AIS_MLB='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\CORIOLIS_MLB_108_5_8h.mat';
        
    case 'ALICUDI'
                
        if AntenneCorrigee
            dataMLB='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\MLB_1708_7_8h_f=[50_300]_220316_101902.mat';
            dataPRC='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\PRC_1708_7_8h_f=[50_300]_220315_113426.mat';
        else
            dataPRC='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\PRC_1708_7_8h_f=[50_1800]_220202_152838_circ.mat';
            dataMLB='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\MLB_1708_7_8h_f=[50_1800]_220202_153158_circ.mat';
        end
        ship_AIS_PRC='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\NACCALICUDI_PRC_1708_7_9h.mat';
        ship_AIS_MLB='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\NACCALICUDI_MLB_1708_7_9h.mat';      
       
end

load(dataMLB)
ptimeMLB=ptime;
angleMLB=angleM;

load(dataPRC)
ptimePRC=ptime;
anglePRC=angleM;

[ptime,id_mlb,id_prc]=intersect(ptimeMLB,ptimePRC);
anglePRC=anglePRC(id_prc);
angleMLB=angleMLB(id_mlb);
% mois=8;
% jour=16;
% hstart=heure;
% minstart=minute;
% secstart=0;
% tstart=datetime(2021,mois,jour,hstart,minstart,secstart);

load(ship_AIS_PRC);
[anglePRC_ais, distPRC_ais] = getRealAngle(arrID , vec_lat_ship, vec_long_ship);

load(ship_AIS_MLB);
[angleMLB_ais, distMLB_ais] = getRealAngle(arrID , vec_lat_ship, vec_long_ship);

loc_MLB = [48.6039 -64.1863]; % 0,0 en coord cart
loc_PRC= [48.5311 -64.1983]; % 
loc_AAV = [49.0907 -64.5372];
loc_CLD = [49.1933  -64.8315];

x_MLB=0; y_MLB=0;
R_T_km = 6378140/1000;% rayon de la terre en km

x_PRC = R_T_km*(cosd(loc_MLB(1))*(loc_PRC(2)-loc_MLB(2))*pi/180);
y_PRC = R_T_km*(loc_PRC(1)-loc_MLB(1))*pi/180;

% diff=ptimePRC(1)-ptimeMLB(1)
% 
% figure,  plot(ptime,angleMLB);
% ylim([0 360]), 
% hold on, plot(ptime,anglePRC);
% datetick('x')
% title('Angle')
% legend('MLB','PRC')

det=tand(anglePRC)-tand(angleMLB);
y_ship=1./det.*(-x_PRC+tand(anglePRC)*y_PRC);
x_ship=y_ship.*tand(angleMLB);

dist2MLB=sqrt(x_ship.^2+y_ship.^2);
dist2PRC=sqrt((x_ship-x_PRC).^2+(y_ship-y_PRC).^2);
% 
% figure,
% plot(ptime,dist2MLB);
% hold on, plot(ptime,dist2PRC);
% title('Distance')
% legend('MLB','PRC')
% 
figure,plot(vec_temps_ship/(24*3600),distPRC_ais/1e3,'k')
hold on, plot(ptime,dist2PRC,'k.');
hold on, plot(vec_temps_ship/(24*3600),distMLB_ais/1e3,'r')
hold on, plot(ptime,dist2MLB,'r.');
legend('PRC AIS','PRC Bring','MLB AIS', 'MLB Bring')
datetick('x')
if AntenneCorrigee
    title([ 'Distance (km) antenne corrigée'])
else
    title([ 'Distance (km) antenne non corrigée'])
end
%% Distance to AIS point
x_ais_select=interp1(vec_temps_ship/(24*3600),x_ship_km,datenum(ptime));
y_ais_select=interp1(vec_temps_ship/(24*3600),y_ship_km,datenum(ptime));
delta=sqrt((x_ais_select-x_ship).^2+(y_ais_select-y_ship).^2);
figure, plot(ptime,delta,'kx'); 
delta(delta==Inf)=[];

t_select=find(datenum(ptime)>datenum(t0) & datenum(ptime)<datenum(tend));

delta_select=delta(t_select);
rmse=sqrt(mean(delta_select(~isnan(delta_select)).^2));
mean_error=mean(delta_select(~isnan(delta_select)));
hold on, plot([t0 tend],[rmse rmse],'r-')
text(datenum(ptime(round(end/2))), rmse*1.2,['RMSE=' num2str(rmse,3) 'km'],'Color','r')
hold on, plot([t0 tend],[mean_error mean_error],'b-')
text(datenum(ptime(round(end/2))), mean_error*1.2,['Mean error=' num2str(mean_error,3) 'km'],'Color','b')
if AntenneCorrigee
    title({'Error Bring / AIS position (km)', 'Corrected Array'})
else
    title({'Error Bring / AIS position (km)', 'Non Corrected Array'})
end
ylim([00 12])
%%

figure, 
plot(vec_temps_ship/(24*3600),anglePRC_ais,'k'),datetick('x')
hold on, plot(ptime,anglePRC,'k.');
hold on,  plot(vec_temps_ship/(24*3600),angleMLB_ais,'r')
hold on, plot(ptime,angleMLB,'r.');
legend('PRC AIS','PRC Bring','MLB AIS', 'MLB Bring')
ylim([0 360]),
if AntenneCorrigee
    title([ 'Azimuth antenne corrigée'])
else
    title([ 'Azimuth antenne non corrigée'])
end


folderOut=['C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\estim_loc_' bateau ];
if ~AntenneCorrigee
    folderOut=[folderOut,'_circ'];
end

delta_lat=y_ship/R_T_km*180/pi;
delta_long=x_ship/R_T_km*180/pi/cosd(loc_MLB(1));
lat_ship=loc_MLB(1)+delta_lat;
long_ship=loc_MLB(2)+delta_long;
save(folderOut,'vec_temps_ship','x_ship','y_ship','lat_ship','long_ship','anglePRC','angleMLB','dist2PRC','dist2MLB','distPRC_ais','distMLB_ais','anglePRC_ais','angleMLB_ais','ptime');
%%
% dist_estime_PRC=dist2PRC*1e3;
% dist_estime_MLB=dist2MLB*1e3;
% vec_temps_estime=ptime;
% anglePRC_estime=anglePRC;
% angleMLB_estime=angleMLB;
% vec_temps_ais=vec_temps_ship;
% save('Data_cedric.mat','vec_temps_estime','vec_temps_ais','anglePRC_ais','angleMLB_ais','anglePRC_estime','angleMLB_estime',...
%     'distPRC_ais','distMLB_ais','dist_estime_MLB','dist_estime_PRC');