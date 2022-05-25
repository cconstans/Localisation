%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calcul des positions des hydrophones PRC et MLB en fonction des donn�es AIS de
% bateaux d'opportunit�s selectionn�s sur un axe Nord-Sud, compar�es aux
% signaux enregistr�s sur leur p�riode de passage.

% Charlotte Constans 05/22
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
addpath(genpath('C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation'));
%% Param�tres

site='PRC';
video=0;
typeHL='LF';
c0=1480;
Z0=40.7; % depth
MinDist=400; % minimum distance for plane wave approx
MaxDist=20e3; % maximum distance for clear signal
folderIn = ['G:\Bring_Dep_2\' site '_wav\'];
%%
switch site
    case 'PRC'
        ship_AIS_file={  'C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316034372_PRC_508_6_9h.mat',...
            'C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\NACCALICUDI_PRC_708_2_5h.mat',...
            'C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\SANDRAMARY_PRC_408_23_25h.mat',...
            'C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\STRAITHUNTER_PRC_3007_22_25h.mat',...
            'C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\NACCQUEBEC_PRC_3007_8_10h.mat',...
            'C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\NACCALICUDI_PRC_1708_7_9h.mat' };
        
        timelim=[ datenum(2021,08,5,7,0,0)*24*3600,datenum(2021,08,5,7,40,0)*24*3600;...
            datenum(2021,08,7,2,35,0)*24*3600,datenum(2021,08,7,4,0,0)*24*3600;...
            datenum(2021,08,5,0,15,0)*24*3600,datenum(2021,08,5,0,50,0)*24*3600;...
            datenum(2021,7,30,23,0,0)*24*3600,datenum(2021,7,30,23,50,0)*24*3600;...
            datenum(2021,7,30,9,0,0)*24*3600,datenum(2021,7,30,9,35,0)*24*3600;...
            datenum(2021,08,17,7,25,0)*24*3600,datenum(2021,08,17,8,10,0)*24*3600;];
        
    case 'MLB'
        
        ship_AIS_file={  'C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316034372_MLB_508_6_9h.mat',...
            'C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\NACCALICUDI_MLB_708_2_5h.mat',...
            'C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\SANDRAMARY_MLB_408_23_25h.mat',...
            'C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\STRAITHUNTER_MLB_3007_22_25h.mat',...
            'C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\NACCALICUDI_MLB_1708_7_9h.mat' };
        
        timelim=[ datenum(2021,08,5,7,0,0)*24*3600,datenum(2021,08,5,8,0,0)*24*3600;...
            datenum(2021,08,7,2,20,0)*24*3600,datenum(2021,08,7,3,20,0)*24*3600;...
            datenum(2021,08,5,0,10,0)*24*3600,datenum(2021,08,5,0,45,0)*24*3600;...
            datenum(2021,7,30,23,05,0)*24*3600,datenum(2021,7,31,0,0,0)*24*3600;...
            datenum(2021,08,17,7,25,0)*24*3600,datenum(2021,08,17,8,10,0)*24*3600;];
end

Nboats=length(ship_AIS_file);
filename=['C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\Data loc\'  site '_' datestr(now, 'yymmdd') '_NS_20km_c0=' num2str(c0) '_' num2str(Nboats) '_boats' ];


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
    
end

% figure,
% for n=1:Nboats
%     plot(angle_boats{n});
%     hold on, plot(dist_boats{n});
%     hold on
% end
% legend('angle1 (�)','distance1 (m)','angle2 (�)','distance2 (m)','angle3 (�)','distance3 (m)','angle4 (�)','distance4 (m)')
% xlabel('#mesure')
% line([0 length(angle_boats{n})],[MinDist MinDist],'Color','k')
% text(length(angle_boats{n})/2,MinDist+20,'Minimum distance')
% title(site)

angle=[];
time=[];
dist=[];
    
for n=1:Nboats
    angle=[angle,angle_boats{n}'];
    time=[time;time_boats{n}'];
    dist=[dist,dist_boats{n}'];
end

R0=mean(dist);

[fileList, wavID] = getWavName(time, folderIn);
duraNs=5;
buffer = 2.5;             % Time in second to add before the ptime

Nhydro=20;
Nangles=length(angle);

%% Calculate lags between Hi and H1

lag=zeros(Nangles,Nhydro);    

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
    %             figure, plot(lags,r); title('fonction de corr�lation')
    %             figure, plot(MAT_s(:,ii)); hold on, plot(MAT_s(:,1));legend('S1',['S' num2str(ii)])
    
    %         figure, plot(sigi); hold on, plot(sig1)
end

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
% figure,
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
    
    SineFunction=fittype(@(A,B,C,distance,theta) -A*sind(theta)-B*cosd(theta)-C./distance,'dependent',{'toto'},'problem','distance',...
        'coefficients',{'A','B','C'},'independent',{'theta'});
    [myfit, goodness, output] = fit(angleii',toto,SineFunction ,'problem', distii','StartPoint',[0,0,0],'robust','Bisquare','Lower',[-Inf -Inf -Zlim*Z0/(c0)],'Upper',[Inf Inf Zlim*Z0/(c0)] );

%     fitCoeffs = num2cell(coeffvalues(myfit));
%      plot(sort(angleii),-fitCoeffs{1}*sind(sort(angleii))-fitCoeffs{2}*cosd(sort(angleii))-fitCoeffs{3}./distii)
% hold on, plot(angleii,toto,'x')
    
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
title([site ' NS c_0=' num2str(c0) 'm/s D_x=' num2str(Dx,3) 'm D_y=' num2str(Dy,3) 'm'])
%
save(filename,'X','Y','Z','lag','-append');
%%
X0=mean(X); Y0=mean(Y);Z1=mean(Z);
perim_th=2*pi*9.8;
perimetre=sum(sqrt((X-circshift(X,1,2)).^2+(Y-circshift(Y,1,2)).^2+(Z-circshift(Z,1,2)).^2));
figure, 
subplot(121),plot3([X X(1)]-X0,[Y Y(1)]-Y0,[Z Z(1)]-Z1)
hold on, plot3(0,0,0,'rx')
daspect([1 1 1])
title({[site ' c_0=' num2str(c0) 'm/s'];[ 'D_x=' num2str(Dx,3) 'm D_y=' num2str(Dy,3) 'm \delta_z=' num2str(Dz,3) 'm']})
xlabel('x (m)'), 
ylabel('y (m)'), 
zlabel('z (m)'), 
R=sqrt((X-X0).^2+(Y-Y0).^2+(Z-Z1).^2);
subplot(122), plot(R); ylim([0 max(R)+1])
title({[' P�rim�tre:' num2str(perimetre,2) 'm']; [' P�rim�tre th�orique:' num2str(perim_th,2) 'm']})
ylabel('Rayon (m)')
xlabel('Hydrophone #')


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

title({[' P�rim�tre:' num2str(perimetre,2) 'm']; [' P�rim�tre th�orique:' num2str(perim_th,2) 'm']})
xlabel('x (m)'), 
ylabel('y (m)'), 
zlabel('z (m)'), 
saveas(gcf,[filename '.fig']);saveas(gcf,[filename '.png']);
