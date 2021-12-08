clear 
AntenneCorrigee=0;
bateau='ALICUDI';
switch bateau
    case 'JJ'
        % Jean-Joseph
        if AntenneCorrigee
            %     dataMLB='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\MLB_1608_7_8h_211117_141916';
            %     dataPRC='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\PRC_1608_7_8h_211117_123140';
            %     dataMLB='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\MLB_1608_7_8h_211122_122329';
            %     dataPRC='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\PRC_1608_7_8h_211122_122344';
            dataMLB='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\MLB_1608_7_8h_211124_111435';
            dataPRC='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\PRC_1608_7_8h_211124_111419';
            
        else
            dataMLB='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\MLB_1608_7_8h_211118_102424_circ';
            dataPRC='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\PRC_1608_7_8h_211118_101340_circ';
        end
        ship_AIS_PRC='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316006850_PRC_1608_7_9h.mat';
        ship_AIS_MLB='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316006850_MLB_1608_7_9h.mat';
        
    case 'Nacc'
%         NACC QUEBEC Cargo
        if ~AntenneCorrigee
            dataMLB='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\MLB_508_6_7h_211118_090133_circ';
            dataPRC='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\PRC_508_6_7h_211117_164951_circ';
        else
            %     dataMLB='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\MLB_508_6_7h_211117_162726';
            
            %     dataPRC='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\PRC_508_6_7h_211117_162712';
            %             dataMLB='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\MLB_508_6_7h_211122_123930';
            %             dataPRC='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\PRC_508_6_7h_211122_123413';
            dataMLB='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\MLB_508_6_7h_211124_105135';
            dataPRC='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\PRC_508_6_7h_211124_105157';
        end
        ship_AIS_PRC='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316034372_PRC_508_6_9h.mat';
        ship_AIS_MLB='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316034372_MLB_508_6_9h.mat';
        
    case 'TB'
        % % Thunder Bay
        
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
            dataMLB='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\MLB_1708_7_8h_211207_090432';
            dataPRC='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\PRC_1708_7_8h_211207_090447';
        else
            dataPRC='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\PRC_1708_7_8h_211206_174155_circ';
            dataMLB='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\MLB_1708_7_8h_211206_174300_circ';
        end
        ship_AIS_PRC='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\NACCALICUDI_PRC_1708_7_8h.mat';
        ship_AIS_MLB='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\NACCALICUDI_MLB_1708_7_8h.mat';      
       
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


%%
% dist_estime_PRC=dist2PRC*1e3;
% dist_estime_MLB=dist2MLB*1e3;
% vec_temps_estime=ptime;
% anglePRC_estime=anglePRC;
% angleMLB_estime=angleMLB;
% vec_temps_ais=vec_temps_ship;
% save('Data_cedric.mat','vec_temps_estime','vec_temps_ais','anglePRC_ais','angleMLB_ais','anglePRC_estime','angleMLB_estime',...
%     'distPRC_ais','distMLB_ais','dist_estime_MLB','dist_estime_PRC');