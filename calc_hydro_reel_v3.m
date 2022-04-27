% Using all angles to compute matrix
% add Z component
%% Spectro
% config='case_BB_WENZ_RSB_-20dB';
clear
addpath(genpath('C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation'));

site='PRC';
filterOption=0;
video=0;
% method=1; %0: supress angles when 1 hydro is overlagged. 1: suppress only overlags.

Fmin=500;
Fmax=2000;
typeHL='LF';
c0=1480;
filename=['C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Data loc\' site 'v3_filtOpt=' num2str(filterOption) '_c0=' num2str(c0)]

switch site
    case 'AAV'
        folderIn = ['D:/Bring_Dep_1_Wav/' site '/' typeHL '/']; % Local Mac folder
        startID=83; % take points from startID
        thetaexcluded=[];
        Z0=39.1;
    case 'CLD'
        folderIn = ['D:/Bring_Dep_1_Wav/' site '/' typeHL '/'];
        startID=1;
        thetaexcluded=[];
        Z0=43.6;
    case 'MLB'
        folderIn = ['F:\Bring_Dep_2\' site '_wav\'];
        startID=1001;
        thetaexcluded=[];
        Z0=37.1;
    case 'PRC'
        folderIn = ['F:\Bring_Dep_2\' site '_wav\'];
        startID=1;
        thetaexcluded=[];
        Z0=40.7;
end
BoatInfo=['C:\Users\CHARLOTTE\Documents\MATLAB\Bring\boatTrack\' site 'CircleTrack.mat'];
load(BoatInfo);
MinDist=400; % minimum distance for plane wave approx
% 
% figure, plot(angle)
% hold on, plot(dist); legend('angle (°)','distance (m)')
% xlabel('#mesure')
% line([0 length(angle)],[MinDist MinDist],'Color','k')
% text(length(angle)/2,MinDist+20,'Minimum distance')
% title(site)

if startID
    angle(1:startID-1)=[];
    time(1:startID-1)=[];
    dist(1:startID-1)=[];
end

time(dist<MinDist)=[];
angle(dist<MinDist)=[];
dist(dist<MinDist)=[];

figure, plot(angle)
hold on, plot(dist); legend('angle (°)','distance (m)')
xlabel('#mesure')
line([0 length(angle)],[MinDist MinDist],'Color','k')
text(length(angle)/2,MinDist+20,'Minimum distance')
title([site ': données exploitées'])
% if ~isempty(thetaexcluded)
%     
%     idxrange= ~(angle<thetaexcluded(2) & angle>thetaexcluded(1));
%     angle=angle(idxrange);
%     time=time(idxrange);
R0=mean(dist);

[fileList, wavID] = getWavName(time, folderIn,typeHL);
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
if filterOption
    lpFilt = designfilt('bandpassiir', 'FilterOrder',20,...
        'HalfPowerFrequency1', Fmin, ...
        'HalfPowerFrequency2',Fmax, 'SampleRate',fe);
%      fvtool(lpFilt);
end
%%
for iFile=1:Nangles
    file_wav=fileList(iFile);
    [MAT_s,fe, tstart, dura] = readBring([folderIn fileList{iFile}], time(iFile),'duration',duraNs,'buffer',buffer,'power2',true);
    Npoints=length(MAT_s(:,1));
    
    for ii=1:Nhydro
        if filterOption
            sigi=filter(lpFilt,MAT_s(:,ii));
            if ii>1
                sigi1=filter(lpFilt,MAT_s(:,ii-1));
                [r,lags] =xcorr(sigi,sig1);
                lag(iFile,ii)=lags(r==max(r))/fe+lag(iFile,ii-1);
%                 lag(iFile,ii)=lags(r==max(r))/fe;
            else
                sig1=filter(lpFilt,MAT_s(:,Nhydro));
                [r,lags] =xcorr(sigi,sig1);
                lag(iFile,ii)=lags(r==max(r))/fe;
            end
        else
            if ii>1
                [r,lags] =xcorr(MAT_s(:,ii),MAT_s(:,ii-1));
                lag(iFile,ii)=lags(r==max(r))/fe;
                lag(iFile,ii)=lags(r==max(r))/fe+lag(iFile,ii-1);
            else
%                 [r,lags] =xcorr(MAT_s(:,ii),MAT_s(:,Nhydro));
%                 lag(iFile,ii)=lags(r==max(r))/fe;
                lag(iFile,ii)=0;
            end
        end
%         figure, plot(lags,r); title('fonction de corrélation')
%         figure, plot(MAT_s(:,ii)); hold on, plot(MAT_s(:,1));legend('S1',['S' num2str(ii)])
        
    end
%     figure, plot(sigi); hold on, plot(sig1)
end

%%
clear MAT_s lags r
save(filename);
%%

Dmax=22;
lagmax=Dmax/c0; % correspond à un diamètre max de 22m


falselags=abs(lag)>lagmax;

lag_clean=lag;
lag_clean(falselags)=NaN;

L=zeros(Nangles,1);
for it=1:Nangles
    L(it)=mean(lag_clean(it,~isnan(lag_clean(it,:))));
end

% x=zeros(1,Nhydro);
% y=zeros(1,Nhydro);

% for ii=1:Nhydro
%     Ci=(L-lag_clean(:,ii))*c0;
%     Mi=[sind(angle(~isnan(Ci)))' cosd(angle(~isnan(Ci)))'];
%     Ci(isnan(Ci))=[];
%     
%     Xi=Mi\Ci;
%     x(ii)=Xi(1);
%     y(ii)=Xi(2);
% end
        
% x1=x(1);
% y1=y(1);

%%
X=zeros(1,Nhydro);
Y=zeros(1,Nhydro);
Z=zeros(1,Nhydro);
if video
    writerObj = VideoWriter(['Data loc\' site '.avi']);
    writerObj.FrameRate = 2;
    open(writerObj);
end
Zlim=3; % Z=Z1+/- Zlim



figure,
%%
for ii=1:20
    hold off
%     plot(angle,lag(:,ii),'x');ylim([-lagmax lagmax]*2)
%     hold on, plot(angle,lag_clean(:,ii),'x');
    
% function toto=lagg(angle,distance,A,B,C,Z0)
% toto=-A*sind(angle)-B*cosd(angle)-Z0./distance;
% 
% end
toto=lag_clean(:,ii);
angleii=angle(~isnan(toto));
toto=toto(~isnan(toto));
distii=dist(~isnan(toto));

SineFunction=fittype(@(A,B,C,distance,theta) -A*sind(theta)-B*cosd(theta)-C./distance,'dependent',{'toto'},'problem','distance',...
    'coefficients',{'A','B','C'},'independent',{'theta'});
[myfit, goodness, output] = fit(angleii',toto,SineFunction ,'problem', distii','StartPoint',[0,0,0],'robust','on','Lower',[-Inf -Inf -Zlim*Z0/(c0)],'Upper',[Inf Inf Zlim*Z0/(c0)] );
Z(ii)=-myfit.C*c0/Z0;

% SineFunction=fittype('-A*sind(theta)-B*cosd(theta)-C','dependent',{'toto'},'independent',{'theta'},'coefficients',{'A','B','C'});
% [myfit, goodness, output] = fit(angleii',toto,SineFunction ,'StartPoint',[0,0,0],'robust','on','Lower',[-Inf -Inf -Zlim/(c0*R0/Z0)],'Upper',[Inf Inf Zlim/(c0*R0/Z0)] );
% % plot(myfit,angleii,toto); title(['A=' num2str(myfit.A,3) ' B=' num2str(myfit.B,3) ' C=' num2str(myfit.C,3)]) 
% Z(ii)=-myfit.C*c0/Z0*R0;


if video
    frame=getframe(gcf) ;
    writeVideo(writerObj, frame);
end
X(ii)=myfit.A*c0;
Y(ii)=myfit.B*c0;
% diff=toto'-(myfit.A*cosd(angleii)+myfit.B*sind(angleii)+myfit.C);
% figure, 
% plot(angleii,diff,'x');
% outlier =isoutlier(toto'-(myfit.A*cosd(angleii)+myfit.B*sind(angleii)+myfit.C));

% pause;

end
if video close(writerObj);end
close;
%%
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
title([site ' v3 c_0=' num2str(c0) 'm/s D_x=' num2str(Dx,3) 'm D_y=' num2str(Dy,3) 'm'])
%
save(filename,'X','Y','Z','lag_clean','-append');
%
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
title({[' Périmètre:' num2str(perimetre,2) 'm']; [' Périmètre théorique:' num2str(perim_th,2) 'm']})
ylabel('Rayon (m)')
xlabel('Hydrophone #')
%%
saveas(gcf,[filename '.fig']);saveas(gcf,[filename '.png']);