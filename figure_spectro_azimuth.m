spectro='F:\TOOLBOX_BIOSOUND\pilotage_rejeu_spectro\ARCHIVE_SPECTRO\FIG_SPECTRO_PRC_1608_7-7207h.fig';
data='F:\TOOLBOX_BIOSOUND\pilotage_rejeu_spectro\ARCHIVE_SPECTRO\MAT_SPECTRO_PRC_1608_7-7207h.mat';
load(data);
uiopen(spectro,1)
fig=gcf;
hold on, plot(vec_temps_ship/(24*3600),angle,'w','LineWidth',3),datetick('x')
hold on,  plot(ptime,angleM,'LineWidth',3);
ylim([0 360])

site='PRC';

fmin_plot = 0;
fmax_plot = 2000;

SPL_min_to_plot = 30; % dB
SPL_max_to_plot = 80; % dB

figure,
indi_f = find( (VEC_freq>= fmin_plot) & (VEC_freq<=fmax_plot));
pcolor( (vec_centre_segment_spectro_LT)/(24*3600), VEC_freq(indi_f), MAT_spectro_dB(:,indi_f)');shading flat;
datetick('x','HH:MM','keepticks')
ylabel(' frequency (Hz)');
% title({[site ' spectre des niveaux sonores, dB ref 1 µPa^2/Hz'];[ 'date deb =' datestr(temps_debut/(24*3600)) '; date fin =' datestr(temps_fin/(24*3600))]})
set(gca,'FontSize',16)
caxis([ SPL_min_to_plot SPL_max_to_plot])
colorbar
colormap jet


%% video

videoName = [ship_AIS_file(1:end-4)  ];
%     videoName='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316006850_MLB_PRC_1608_7_9h';

%     writerObj = VideoWriter([ videoName '.mp4'],'MPEG-4');
%     writerObj.FrameRate = 20 ;
%     writerObj.Quality = 100;
%     open(writerObj)

figure,
plot(loc_site(2),loc_site(1),'or');
text(loc_site(2),loc_site(1)+0.01,arrID,'Color','r');
% hold on,plot(loc_PRC(2),loc_PRC(1),'or');
% text(loc_PRC(2),loc_PRC(1)+0.01,'PRC','Color','r');
xlim([min(vec_long_ship) max(vec_long_ship)]), ylim([min(vec_lat_ship) max(vec_lat_ship)])
for ii=1:length(vec_temps_ship)
    hold on, plot(vec_long_ship(ii), vec_lat_ship(ii),'kx');
    title(datestr(vec_temps_ship(ii)/24/3600))
    
    %         h = gcf;
    %         F = getframe(h);
    %         writeVideo(writerObj,F)
end
%     close(writerObj)

%% Angles
filePRC='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316034372_PRC_508_6_9h.mat';
load(filePRC);
[anglePRC, distPRC] = getRealAngle(arrID , vec_lat_ship, vec_long_ship);

fileMLB='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316034372_MLB_508_6_9h.mat';
load(fileMLB);
[angleMLB, distMLB] = getRealAngle(arrID , vec_lat_ship, vec_long_ship);


figure,
subplot(211),plot(vec_temps_ship/(24*3600),anglePRC),datetick('x')
hold on,  plot(vec_temps_ship/(24*3600),angleMLB)
legend('PRC','MLB')
ylim([0 360]), title([ 'Azimuth'])
subplot(212),
plot(vec_temps_ship/(24*3600),distPRC/1e3)
hold on, plot(vec_temps_ship/(24*3600),distMLB/1e3)
legend('PRC','MLB')
datetick('x'),title([ 'Distance (km)'])

%% Gonio
% data='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\MLB_1608_7_8h_211118_102424_circ';
% data='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\PRC_1608_7_8h_211118_101340_circ';
% data='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\PRC_508_6_7h_211117_164951_circ';
% data='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\PRC_1408_22_24h_211118_122758';
% data='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\PRC_1408_22_24h_211118_131943_circ';
% data='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\MLB_1408_22_24h_211118_122744';
data='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\MLB_1408_22_24h_211118_131928_circ';

% data='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\PRC_1608_7_8h_211117_123140';
% ship_AIS_file='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316006850_MLB_1608_7_9h.mat';

load(data)
% load(ship_AIS_file)

% fileMLB='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316034372_MLB_508_6_9h.mat';
% load(fileMLB);
% [angleMLB, distMLB] = getRealAngle(arrID , vec_lat_ship, vec_long_ship);
if AntenneCorrigee
    switch arrID
        case 'AAV'
            load('C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Data loc/AAV_filtOpt=0_211104_131035.mat','X','Y');
        case 'MLB'
            load('C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Data loc/MLB_filtOpt=0_211104_131415.mat','X','Y');
        case 'PRC'
            load('C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Data loc/PRC_filtOpt=0_211104_131656.mat','X','Y');
        case 'CLD'
            load('C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Data loc/CLD_filtOpt=0_211109_101636.mat','X','Y');
    end
    
else
    [arrLoc, offset, arrOri] = getArrLoc(arrID);

    Nc = 20;
    R = 10;
    theta = 0: 2*pi/(Nc) : 2*pi-2*pi/(Nc);
    X = R*sin(theta +  offset * pi /180);
    Y = R*cos(theta +  offset* pi /180);
end

x0=mean(X);y0=mean(Y);
xc_rel=X-x0;yc_rel=Y-y0;
%

videoName = [ data '_azimetre'  ];

writerObj = VideoWriter([ videoName '.mp4'],'MPEG-4');
writerObj.FrameRate = 7 ;
writerObj.Quality = 100;
open(writerObj)

figure(93)
R_source = 5000;
vec_azim = linspace(0,2*pi,1000);
x_cercle = R_source*sin(vec_azim);
y_cercle = R_source*cos(vec_azim);
NN = 360;
vec_azimut = linspace(0,2*pi-2*pi/NN,NN);
for ii=1:size(matEnergie,1)
    hold off
    plot(x0,y0,'k+')
    hold on
    plot(xc_rel,yc_rel,'r.','MarkerSize',12)
    plot(x_cercle,y_cercle,'k')
    
    xlabel(' x (m)')
    ylabel(' y (m)')
    grid on
    axis equal
    for u = 1 : length(xc_rel)
        a = atan2(xc_rel(u),yc_rel(u));
        xx = R_source*cos(a);
        yy = R_source*sin(a);
        
        plot(xx,yy,'r.');
        text(xx,yy,['h' num2str(u)])
    end
    Energie_NORM = matEnergie(ii,:)/max(matEnergie(ii,:));
    xxx = sin(vec_azimut).*Energie_NORM*R_source;
    yyy = cos(vec_azimut).*Energie_NORM*R_source;
    plot(xxx,yyy,'k','LineWidth',2)
    if AntenneCorrigee
        title({[arrID ' antenne corrigée'],[ datestr(ptime(ii),'HH:MM:SS')]})
    else
        title({[arrID ' antenne circulaire'],[ datestr(ptime(ii),'HH:MM:SS')]})
    end
    drawnow;
    %     pause(0.1);
    
    h = gcf;
    F = getframe(h);
    writeVideo(writerObj,F)
end
    close(writerObj)
%%
videoName = [ data '_azimetre_db'  ];

writerObj = VideoWriter([ videoName '.mp4'],'MPEG-4');
writerObj.FrameRate = 7 ;
writerObj.Quality = 100;
open(writerObj)

 figure(92)
 for ii=11:size(matEnergie,1)
     hold off
    Energie_db = 10*log10(matEnergie(ii,:)/max(matEnergie(:)));

    plot(vec_azimut*180/pi, Energie_db,'k','LineWidth',2);
%     hold on
    xlabel(' azimut (°)','interpret','tex')
    ylabel(' SPL dB re. 1µPa','interpreter','tex')
    grid on
    set(gca,'FontSize',16)
    ylim([10*log10(min(matEnergie(:))/max(matEnergie(:))) 0])
        drawnow;
        if AntenneCorrigee
        title({[arrID ' antenne corrigée'],[ datestr(ptime(ii),'HH:MM:SS')]})
    else
        title({[arrID ' antenne circulaire'],[ datestr(ptime(ii),'HH:MM:SS')]})
    end
     drawnow;
    h = gcf;
    F = getframe(h);
    writeVideo(writerObj,F)
end
    close(writerObj)
%%
% figure,
% plot(vec_temps_ship/(24*3600),angleMLB),datetick('x')
% hold on,  plot(ptime,angleM);
% ylim([0 360]), title([ arrID, ' azimuth'])
% ylabel('Azimuth (°)')
% legend('AIS', 'Bring')
%
% dataPRC='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\PRC_1608_7_8h_211117_123140';
% load(dataPRC)
%
% figure,
% plot(vec_temps_ship/(24*3600),anglePRC),datetick('x')
% hold on,  plot(ptime,angleM);
% ylim([0 360]), title([ arrID, ' azimuth'])
% ylabel('Azimuth (°)')
% legend('AIS', 'Bring')