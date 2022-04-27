% Using all angles to compute matrix
% add opportunity boats
%% Spectro
% config='case_BB_WENZ_RSB_-20dB';
clear
addpath(genpath('C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation'));

site='CLD';
video=0;

typeHL='LF';
c0=1480;

switch site
    case 'AAV'
        folderIn = ['G:/Bring_Dep_1_Wav/' site '/' typeHL '/']; % Local Mac folder
        startID=83; % take points from startID
        thetaexcluded=[];
        Z0=39.1;
        ship_AIS_file={'C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\NACCQUEBEC_AAV_1807_10_13h.mat',...
            'C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\QAMUTIK_AAV_1907_2_4h',...
            'C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\HELENAG_AAV_2107_13_17h',...
            'C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\HLSINES_AAV_2107_19_22h',...
            'C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\STARAYESHA_AAV_2207_22_25h',...
            'C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316003726_AAV_1907_10_12h'};
        timelim=[datenum(2021,07,18,11,45,0)*24*3600,datenum(2021,07,18,12,45,0)*24*3600;...
           datenum(2021,07,19,2,20,0)*24*3600,datenum(2021,07,19,3,15,0)*24*3600 ;...
           datenum(2021,07,21,15,0,0)*24*3600,datenum(2021,07,21,16,0,0)*24*3600 ;...
           datenum(2021,07,21,20,20,0)*24*3600,datenum(2021,07,21,21,50,0)*24*3600 ;...
           datenum(2021,07,22,22,16,0)*24*3600,datenum(2021,07,23,0,35,0)*24*3600 ;...
            datenum(2021,07,19,10,25,0)*24*3600,datenum(2021,07,19,10,50,0)*24*3600];

    case 'CLD'
        folderIn = ['G:/Bring_Dep_1_Wav/' site '/' typeHL '/'];
        startID=1;
        thetaexcluded=[];
        Z0=43.6;
       ship_AIS_file={'C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\NACCQUEBEC_CLD_1807_10_12h.mat',...
            'C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\QAMUTIK_CLD_1907_0_3h',...
            'C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\MARJORIEK_CLD_1907_10_13h',...
            'C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\HELENAG_CLD_2107_13_15h',...
            'C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\HLSINES_CLD_2107_18_20h',...
            'C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\MAERSKPATRAS_CLD_2307_23_26h',...
            'C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\STARBORNEO_CLD_2407_12_15h'};
%             'C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\KSLSANFRANCISCO_CLD_1407_3_7h.mat'};
        timelim=[datenum(2021,07,18,10,20,0)*24*3600,datenum(2021,07,18,11,20,0)*24*3600;...
            datenum(2021,07,19,1,17,0)*24*3600,datenum(2021,07,19,2,07,0)*24*3600 ;...
            datenum(2021,07,19,11,30,0)*24*3600,datenum(2021,07,19,12,40,0)*24*3600;...
            datenum(2021,07,21,14,0,0)*24*3600,datenum(2021,07,21,15,0,0)*24*3600;...
            datenum(2021,07,21,19,20,0)*24*3600,datenum(2021,07,21,20,30,0)*24*3600;...
            datenum(2021,07,23,23,30,0)*24*3600,datenum(2021,07,24,1,50,0)*24*3600;...
            datenum(2021,07,24,12,50,0)*24*3600,datenum(2021,07,24,15,0,0)*24*3600];
%             datenum(2021,07,14,3,50,0)*24*3600,datenum(2021,07,14,7,0,0)*24*3600];
    case 'MLB'
        folderIn = ['F:\Bring_Dep_2\' site '_wav\'];
        startID=1001;
        thetaexcluded=[];
        Z0=37.1;
        ship_AIS_file={'C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316006850_MLB_1608_7_9h.mat',...
            'C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316034372_MLB_508_6_9h.mat',...
            'C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316023339_MLB_1408_22_24h',...
            'C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\CORIOLIS_MLB_108_5_8h'};
        
        timelim=[datenum(2021,08,16,8,5,0)*24*3600,datenum(2021,08,16,8,30,0)*24*3600;...
            datenum(2021,08,5,7,0,0)*24*3600,datenum(2021,08,5,7,50,0)*24*3600;...
            datenum(2021,08,14,22,04,0)*24*3600,datenum(2021,08,14,23,45,0)*24*3600;...
            datenum(2021,08,1,5,45,0)*24*3600,datenum(2021,08,1,8,9,0)*24*3600];
    case 'PRC'
        folderIn = ['F:\Bring_Dep_2\' site '_wav\'];
        startID=1;
        thetaexcluded=[];
        Z0=40.7;
        ship_AIS_file={'C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316006850_PRC_1608_7_9h.mat',...
            'C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316034372_PRC_508_6_9h.mat',...
            'C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316023339_PRC_1408_22_24h',...
            'C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\CORIOLIS_PRC_108_5_8h'};
        timelim=[datenum(2021,08,16,8,5,0)*24*3600,datenum(2021,08,16,8,45,0)*24*3600;...
            datenum(2021,08,5,7,0,0)*24*3600,datenum(2021,08,5,7,50,0)*24*3600;...
            datenum(2021,08,14,22,04,0)*24*3600,datenum(2021,08,14,23,45,0)*24*3600;...
            datenum(2021,08,1,5,45,0)*24*3600,datenum(2021,08,1,8,9,0)*24*3600];
%         ship_AIS_file={'C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316034372_PRC_508_6_9h.mat'};
%         timelim=[datenum(2021,08,5,7,0,0)*24*3600,datenum(2021,08,5,7,40,0)*24*3600;];
end

Nboats=length(ship_AIS_file);
filename=['C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\Data loc\'  site '_' datestr(now, 'yymmdd') '_v5_c0=' num2str(c0) ' ' num2str(Nboats) '_boats' ];

% BoatInfo=['C:\Users\CHARLOTTE\Documents\MATLAB\Bring\boatTrack\' site 'CircleTrack.mat'];

% load(BoatInfo);
MinDist=400; % minimum distance for plane wave approx
MaxDist=60e3; % maximum distance for clear signal

% if startID
%     angle(1:startID-1)=[];
%     time(1:startID-1)=[];
%     dist(1:startID-1)=[];
% end
size_per_boat=zeros(1,Nboats);
for n=1:Nboats
    load(ship_AIS_file{n})
    [anglen, distn] = getRealAngle(arrID , vec_lat_ship, vec_long_ship);
    distn(vec_temps_ship<timelim(n,1) | vec_temps_ship>timelim(n,2))=[];
    anglen(vec_temps_ship<timelim(n,1) | vec_temps_ship>timelim(n,2))=[];
    timen=datetime(vec_temps_ship/(24*3600),'ConvertFrom','datenum');

    timen(vec_temps_ship<timelim(n,1) | vec_temps_ship>timelim(n,2))=[];
    
    timen(distn<MinDist | distn>MaxDist)=[];
    anglen(distn<MinDist | distn>MaxDist)=[];
    distn(distn<MinDist | distn>MaxDist)=[];
    
    angle_boats{n}=anglen;
    dist_boats{n}=distn;
    time_boats{n}=timen;
    size_per_boat(n)=length(anglen);
    size(anglen)
%     figure, plot(anglen); 
    max(distn)
    min(distn)
    anglen(end)
    anglen(1)-360
end

 idx_boats=cumsum([1 size_per_boat(1:end-1)]);
figure,
for n=1:Nboats
%     plot(angle_boats{n});
    hold on, plot(dist_boats{n});
end
% legend('angle1 (°)','distance1 (m)','angle2 (°)','distance2 (m)','angle3 (°)','distance3 (m)','angle4 (°)','distance4 (m)')
xlabel('#mesure')
line([0 length(dist_boats{n})],[MinDist MinDist],'Color','k')
text(length(dist_boats{n})/2,MinDist+20,'Minimum distance')
title(site)

angle=[];
time=[];
dist=[];
    
for n=1:Nboats
    angle=[angle,angle_boats{n}'];
    time=[time;time_boats{n}'];
    dist=[dist,dist_boats{n}'];
end

% figure, plot(angle)
% hold on, plot(dist); legend('angle (°)','distance (m)')
% xlabel('#mesure')
% line([0 length(angle)],[MinDist MinDist],'Color','k')
% text(length(angle)/2,MinDist+20,'Minimum distance')
% title([site ': données exploitées'])
% if ~isempty(thetaexcluded)
%     
%     idxrange= ~(angle<thetaexcluded(2) & angle>thetaexcluded(1));
%     angle=angle(idxrange);
%     time=time(idxrange);
R0=mean(dist);

[fileList, wavID] = getWavName(time, folderIn);
duraNs=5;
% Ns = 2^14;              % Total number of sample
buffer = 2.5;             % Time in second to add before the ptime

Nhydro=20;
% theta=0:10:350;
Nangles=length(angle);

%% Calculate lag from channel 1
lag=zeros(Nangles,Nhydro);
%     
fe=10000;
%%
figure,
lag_max_h2h=3.5/c0;
for iFile=1:Nangles
    disp([num2str(iFile) '/' num2str(Nangles)])
    file_wav=fileList(iFile);
    [MAT_s,fe, tstart, dura] = readBring([folderIn fileList{iFile}], time(iFile),'duration',duraNs,'buffer',buffer,'power2',true);
    Npoints=length(MAT_s(:,1));
    
    for ii=1:Nhydro
        
        if ii>1
            if ~isnan(lag(iFile,ii-1))
                [r,lags] =xcorr(MAT_s(:,ii),MAT_s(:,ii-1));
                lagh2h=lags(r==max(r))/fe;
                if abs(lagh2h)<lag_max_h2h
                    lag(iFile,ii)=lagh2h+lag(iFile,ii-1);
                else lag(iFile,ii)=nan;
                end
            else lag(iFile,ii)=nan;
            end
        else
            lag(iFile,ii)=0;
        end
    end
%     hold on, plot(angle(iFile),lag(iFile,2),'kx');drawnow; ylim([-lag_max_h2h;lag_max_h2h]); xlim([0 360 ]);
%             figure, plot(lags,r); title('fonction de corrélation')
%             figure, plot(MAT_s(:,ii)); hold on, plot(MAT_s(:,1));legend('S1',['S' num2str(ii)])
    
%         figure, plot(sigi); hold on, plot(sig1)
end

%%
% for iFile=910:1000
%         hold on, plot(angle(iFile),lag(iFile,2),'gd');drawnow; ylim([-lag_max_h2h;lag_max_h2h]); xlim([0 360 ]);
% end
%%
clear MAT_s lags r
save(filename);

%%
X=zeros(1,Nhydro);
Y=zeros(1,Nhydro);
Z=zeros(1,Nhydro);
if video
    writerObj = VideoWriter(['Data loc\' site '.avi']);
    writerObj.FrameRate = 2;
    open(writerObj);
end
Zlim=1; % Z=Z1+/- Zlim
figure,
%%
for ii=1:20
    %%
    hold off
    %     plot(angle,lag(:,ii),'x');ylim([-lagmax lagmax]*2)
    %     hold on, plot(angle,lag_clean(:,ii),'x');
    
    toto=lag(:,ii);
    angleii=angle(~isnan(toto));
    toto=toto(~isnan(toto));
    distii=dist(~isnan(toto));
    
%     SineFunction=fittype(@(A,B,C,distance,theta) -A*sind(theta)-B*cosd(theta)-C./distance,'dependent',{'toto'},'problem','distance',...
%         'coefficients',{'A','B','C'},'independent',{'theta'});
%     [myfit, goodness, output] = fit(angleii',toto,SineFunction ,'problem', distii','StartPoint',[0,0,0],'robust','Bisquare','Lower',[-Inf -Inf -Zlim*Z0/(c0)],'Upper',[Inf Inf Zlim*Z0/(c0)] );
% 
%     fitCoeffs = num2cell(coeffvalues(myfit));
%      plot(sort(angleii),-fitCoeffs{1}*sind(sort(angleii))-fitCoeffs{2}*cosd(sort(angleii))-fitCoeffs{3}./distii)
% hold on, plot(angleii,toto,'x')

    SineFunction=fittype('-A*sind(theta)-B*cosd(theta)-C','dependent',{'toto'},'independent',{'theta'},'coefficients',{'A','B','C'});
    [myfit, goodness, output] = fit(angleii',toto,SineFunction ,'StartPoint',[0,0,0],'robust','on','Lower',[-Inf -Inf -Zlim/(c0*R0/Z0)],'Upper',[Inf Inf Zlim/(c0*R0/Z0)] );
    plot(myfit,angleii,toto); title(['H' num2str(ii) ' A=' num2str(myfit.A,3) ' B=' num2str(myfit.B,3) ' C=' num2str(myfit.C,3)])
   
    
    if video
        frame=getframe(gcf) ;
        writeVideo(writerObj, frame);
    end
    X(ii)=myfit.A*c0;
    Y(ii)=myfit.B*c0;
    Z(ii)=-myfit.C*c0/Z0;

end
%%
if video close(writerObj);end
close;

figure,
daspect([1 1 1])
for ii=1:Nhydro
    hold on;
    p2=plot(X(ii),Y(ii),'rx');
    text(X(ii)+0.2,Y(ii),num2str(ii))
end

Dx=max(X)-min(X);
Dy=max(Y)-min(Y);
Dz=max(Z)-min(Z);
title([site ' v5 c_0=' num2str(c0) 'm/s D_x=' num2str(Dx,3) 'm D_y=' num2str(Dy,3) 'm'])
%
save(filename,'X','Y','Z','lag','-append');
%%
% X0=mean(X); Y0=mean(Y);Z1=mean(Z);
% perim_th=2*pi*9.8;
% perimetre=sum(sqrt((X-circshift(X,1,2)).^2+(Y-circshift(Y,1,2)).^2+(Z-circshift(Z,1,2)).^2));
% figure, 
% subplot(121),plot3([X X(1)]-X0,[Y Y(1)]-Y0,[Z Z(1)]-Z1)
% hold on, plot3(0,0,0,'rx')
% daspect([1 1 1])
% title({[site ' c_0=' num2str(c0) 'm/s'];[ 'D_x=' num2str(Dx,3) 'm D_y=' num2str(Dy,3) 'm \delta_z=' num2str(Dz,3) 'm']})
% xlabel('x (m)'), 
% ylabel('y (m)'), 
% zlabel('z (m)'), 
% R=sqrt((X-X0).^2+(Y-Y0).^2+(Z-Z1).^2);
% subplot(122), plot(R); ylim([0 max(R)+1])
% title({[' Périmètre:' num2str(perimetre,2) 'm']; [' Périmètre théorique:' num2str(perim_th,2) 'm']})
% ylabel('Rayon (m)')
% xlabel('Hydrophone #')


%%

X0=mean(X); Y0=mean(Y);Z1=mean(Z);

Dx=max(X)-min(X);
Dy=max(Y)-min(Y);
Dz=max(Z)-min(Z);
perim_th=2*pi*9.8;
perimetre=sum(sqrt((X-circshift(X,1,2)).^2+(Y-circshift(Y,1,2)).^2+(Z-circshift(Z,1,2)).^2));
disth2h=sqrt((X-circshift(X,1,2)).^2+(Y-circshift(Y,1,2)).^2+(Z-circshift(Z,1,2)).^2);
figure, 
subplot(121),

for ii=1:Nhydro
    hold on;
    p2=plot(X(ii)-X0,Y(ii)-Y0,'rx');
    text(X(ii)-X0+0.2,Y(ii)-Y0,num2str(ii))
end
daspect([1 1 1])
title({[site ' c_0=' num2str(c0) 'm/s'];[ 'D_x=' num2str(Dx,3) 'm D_y=' num2str(Dy,3) 'm \delta_z=' num2str(Dz,3) 'm']})
xlabel('x (m)'), 
ylabel('y (m)'), 
R=sqrt((X-X0).^2+(Y-Y0).^2+(Z-Z1).^2);
subplot(122),plot3([X X(1)]-X0,[Y Y(1)]-Y0,[Z Z(1)]-Z1)
daspect([1 1 1])
hold on, plot3(0,0,0,'rx')

title({[' Périmètre:' num2str(perimetre,2) 'm']; [' Périmètre théorique:' num2str(perim_th,2) 'm']})
xlabel('x (m)'), 
ylabel('y (m)'), 
zlabel('z (m)'), 
saveas(gcf,[filename '.fig']);saveas(gcf,[filename '.png']);
