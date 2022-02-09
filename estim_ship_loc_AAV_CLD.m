clear
addpath(genpath('C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation'));
AntenneCorrigee=1;
bateau='MSCANGELA';
switch bateau
%     case 'BLUEALEXANDRA'
%         if AntenneCorrigee
%             dataAAV='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\AAV_2107_11_14h_f=[50_1500]_211208_164421';
%             dataCLD='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\CLD_2107_11_14h_f=[50_1500]_211208_164443';
%         else
%             dataCLD='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\CLD_2107_11_14h_f=[50_1500]_211210_114729_circ';
%             dataAAV='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\AAV_2107_11_14h_f=[50_1500]_211210_114716_circ';
%         end
%         ship_AIS_CLD=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\BLUEALEXANDRA_CLD_2107_11_14h.mat'];
%         ship_AIS_AAV=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\BLUEALEXANDRA_AAV_2107_11_14h.mat'];
%         
    case 'LAKEONTARIO'
        if AntenneCorrigee
            dataAAV='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\AAV_1507_9_11h_f=[20_1800]_220203_124807';
            dataCLD='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\CLD_1507_9_11h_f=[20_1800]_220203_124835';
        else
            dataCLD='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\CLD_1507_9_11h_f=[20_1800]_220203_124845_circ';
            dataAAV='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\AAV_1507_9_11h_f=[20_1800]_220203_124921_circ';
        end
        ship_AIS_CLD=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\LAKEONTARIO_CLD_1507_9_11h.mat'];
        ship_AIS_AAV=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\LAKEONTARIO_AAV_1507_9_11h.mat'];
%        %       
    case 'MSCANGELA'
        if AntenneCorrigee
            dataAAV='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\AAV_2007_2_5h_f=[20_1800]_220203_120509';
            dataCLD='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\CLD_2007_2_5h_f=[20_1800]_220203_120459';
        else
            dataCLD='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\CLD_2007_2_5h_f=[20_1800]_220203_120554_circ';
            dataAAV='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\AAV_2007_2_5h_f=[20_1800]_220203_120544_circ';
        end
        ship_AIS_CLD=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\MSCANGELA_CLD_2007_2_5h.mat'];
        ship_AIS_AAV=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\MSCANGELA_AAV_2007_2_5h.mat'];

        duree=3600*2.25;
%        %         
    case 'OCEANEXCONNAIGRA'
        if AntenneCorrigee
            dataAAV='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\AAV_1807_20_22h_f=[20_400]_211217_151153';
            dataCLD='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\CLD_1807_20_22h_f=[20_400]_211217_151231';
        else
            dataCLD='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\CLD_1807_20_22h_f=[20_400]_211217_151309_circ';
            dataAAV='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\AAV_1807_20_22h_f=[20_400]_211217_151333_circ';
        end
        ship_AIS_CLD=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\OCEANEXCONNAIGRA_CLD_1807_19_21h.mat'];
        ship_AIS_AAV=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\OCEANEXCONNAIGRA_AAV_1807_19_21h.mat'];
%         
    case 'NACCQUEBEC2107'
        if AntenneCorrigee
            dataAAV='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\AAV_2107_5_7h_f=[50_1500]_211215_122600';
            dataCLD='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\CLD_2107_5_7h_f=[50_1500]_211215_122547';
        else
            dataCLD='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\CLD_2107_5_7h_211207_124722_circ';
            dataAAV='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\AAV_2107_5_7h_211207_124709_circ';
        end
        ship_AIS_CLD='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\NACCQUEBEC_CLD_2107_5_7h.mat';
        ship_AIS_AAV='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\NACCQUEBEC_AAV_2107_5_7h.mat';
    case 'CORIOLIS_PERPH'
        if AntenneCorrigee
            dataAAV='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\AAV_1407_0_3h_f=[50_1800]_220203_104013';
            dataCLD='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\CLD_1407_0_3h_f=[50_1800]_220203_095348';
%         else
%             dataCLD='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\CLD_2107_5_7h_211207_124722_circ';
%             dataAAV='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\AAV_2107_5_7h_211207_124709_circ';
        end
        ship_AIS_CLD='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\CORIOLISII_CLD_1407_0_3h.mat';
        ship_AIS_AAV='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\CORIOLISII_AAV_1407_0_3h.mat';
end

load(dataAAV)
ptimeAAV=ptime;
angleAAV=angleM;

load(dataCLD)
ptimeCLD=ptime;
angleCLD=angleM;
ptime_end=datetime(2021,mois,jour,heure,minute,duree);
[ptime,id_AAV,id_CLD]=intersect(ptimeAAV,ptimeCLD);
ptime(ptime>ptime_end)=[];
angleCLD=angleCLD(id_CLD);
angleAAV=angleAAV(id_AAV);
% mois=8;
% jour=16;
% hstart=heure;
% minstart=minute;
% secstart=0;
% tstart=datetime(2021,mois,jour,hstart,minstart,secstart);

load(ship_AIS_CLD);
[angleCLD_ais, distCLD_ais] = getRealAngle(arrID , vec_lat_ship, vec_long_ship);

load(ship_AIS_AAV);
[angleAAV_ais, distAAV_ais] = getRealAngle(arrID , vec_lat_ship, vec_long_ship);

loc_AAV = [49.0907 -64.5372];
loc_CLD = [49.1933  -64.8315];

x_AAV=0; y_AAV=0;
R_T_km = 6378140/1000;% rayon de la terre en km

x_CLD = R_T_km*(cosd(loc_AAV(1))*(loc_CLD(2)-loc_AAV(2))*pi/180);
y_CLD = R_T_km*(loc_CLD(1)-loc_AAV(1))*pi/180;

det=tand(angleCLD)-tand(angleAAV);
y_ship=1./det.*(-x_CLD+tand(angleCLD)*y_CLD);
x_ship=y_ship.*tand(angleAAV);

dist2AAV=sqrt(x_ship.^2+y_ship.^2);
dist2CLD=sqrt((x_ship-x_CLD).^2+(y_ship-y_CLD).^2);
%%
figure,plot(vec_temps_ship/(24*3600),distCLD_ais/1e3,'k')
hold on, plot(ptime,dist2CLD,'k.');
hold on, plot(vec_temps_ship/(24*3600),distAAV_ais/1e3,'r')
hold on, plot(ptime,dist2AAV,'r.');
legend('CLD AIS','CLD Bring','AAV AIS', 'AAV Bring')
datetick('x')
ylim([0 60])
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
delta(delta>300)=[];
% delta(delta==Inf)=[];
rmse=sqrt(mean(delta(~isnan(delta)).^2));
mean_error=mean(delta(~isnan(delta)));
hold on, plot([ptime(1) ptime(end)],[rmse rmse],'r-')
text(datenum(ptime(round(end/2))), rmse*1.2,['RMSE=' num2str(rmse,3) 'km'],'Color','r')
hold on, plot([ptime(1) ptime(end)],[mean_error mean_error],'b-')
text(datenum(ptime(round(end/2))), mean_error*1.2,['Mean error=' num2str(mean_error,3) 'km'],'Color','b')
if AntenneCorrigee
    title({'Error Bring / AIS position (km)', 'Antenne corrigée'})
else
    title({'Error Bring / AIS position (km)', 'Antenne non corrigée'})
end
ylim([0 250])
%%

figure,
plot(vec_temps_ship/(24*3600),angleCLD_ais,'k'),datetick('x')
hold on, plot(ptime,angleCLD,'k.');
hold on,  plot(vec_temps_ship/(24*3600),angleAAV_ais,'r')
hold on, plot(ptime,angleAAV,'r.');
legend('CLD AIS','CLD Bring','AAV AIS', 'AAV Bring')
ylim([0 360]),
if AntenneCorrigee
    title([ 'Azimuth antenne corrigée'])
else
    title([ 'Azimuth antenne non corrigée'])
end

%%
folderOut=['C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\estim_loc_' bateau ];
if ~AntenneCorrigee
    folderOut=[folderOut,'_circ'];
end

delta_lat=y_ship/R_T_km*180/pi;
delta_long=x_ship/R_T_km*180/pi/cosd(loc_AAV(1));
lat_ship=loc_AAV(1)+delta_lat;
long_ship=loc_AAV(2)+delta_long;
save(folderOut,'vec_temps_ship','x_ship','y_ship','lat_ship','long_ship','angleCLD','angleAAV','dist2CLD','dist2AAV','distCLD_ais','distAAV_ais','angleCLD_ais','angleAAV_ais','ptime');
