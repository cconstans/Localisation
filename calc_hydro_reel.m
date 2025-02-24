% Using all angles to compute matrix

%% Spectro
% config='case_BB_WENZ_RSB_-20dB';
addpath(genpath('C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation_reseau'));

site='CLD';
filterOption=0;
video=0;
method=1; %0: supress angles when 1 hydro is overlagged. 1: suppress only overlags.

Fmin=500;
Fmax=2000;
typeHL='LF';


switch site
    case 'AAV'
        folderIn = ['D:/Bring_Dep_1_Wav/' site '/' typeHL '/']; % Local Mac folder
        startID=83; % take points from startID
        thetaexcluded=[];
    case 'CLD'
        folderIn = ['D:/Bring_Dep_1_Wav/' site '/' typeHL '/'];
        startID=1;
        thetaexcluded=[];
    case 'MLB'
        folderIn = ['F:\Bring_Dep_2\' site '_wav\'];
        startID=1001;
        thetaexcluded=[];
        
    case 'PRC'
        folderIn = ['F:\Bring_Dep_2\' site '_wav\'];
%         startID=33;
        thetaexcluded=[];

end
BoatInfo=['C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation_reseau\boatTrack\' site 'CircleTrack.mat'];
load(BoatInfo);
if strcmp(site,'CLD')
     time=time-days(1)-hours(8);
end
MinDist=400; % minimum distance for plane wave approx

figure, plot(angle)
hold on, plot(dist); legend('angle (�)','distance (m)')
xlabel('#mesure')
line([0 length(angle)],[MinDist MinDist],'Color','k')
text(length(angle)/2,MinDist+20,'Minimum distance')
title(site)

if startID
    angle(1:startID-1)=[];
    time(1:startID-1)=[];
    dist(1:startID-1)=[];
end

time(dist<MinDist)=[];
angle(dist<MinDist)=[];
dist(dist<MinDist)=[];

figure, plot(angle)
hold on, plot(dist); legend('angle (�)','distance (m)')
xlabel('#mesure')
line([0 length(angle)],[MinDist MinDist],'Color','k')
text(length(angle)/2,MinDist+20,'Minimum distance')
title([site ': donn�es exploit�es'])
% if ~isempty(thetaexcluded)
%     
%     idxrange= ~(angle<thetaexcluded(2) & angle>thetaexcluded(1));
%     angle=angle(idxrange);
%     time=time(idxrange);


[fileList, wavID] = getWavName(time, folderIn,typeHL);
duraNs=5;
% Ns = 2^14;              % Total number of sample
buffer = 2.5;             % Time in second to add before the ptime

Nhydro=20;
% theta=0:10:350;
Nangles=length(angle);
c0=1500;

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
    
    if filterOption
        sig1=filter(lpFilt,MAT_s(:,1));
%         sig_interp1=interp1(1:Npoints,MAT_s(:,1),1:0.5:Npoints);
    end
    
    for ii=1:Nhydro
        if filterOption
            sigi=filter(lpFilt,MAT_s(:,ii));
            [r,lags] =xcorr(sigi,sig1);
        else
%             sig_interp=interp1(1:Npoints,MAT_s(:,ii),1:0.5:Npoints);
            [r,lags] =xcorr(MAT_s(:,ii),MAT_s(:,1));
%             [r,lags] =xcorr(sig_interp,sig_interp1);
        end
        lag(iFile,ii)=lags(r==max(r))/fe;
    end
%     figure, plot(lags,r); title('fonction de corr�lation')
%     figure, plot(MAT_s(:,ii)); hold on, plot(MAT_s(:,1));legend('S1',['S' num2str(ii)])
%     figure, plot(sigi); hold on, plot(sig1)
end
clear MAT_s
filename=['Data loc\' site '_filtOpt=' num2str(filterOption) '_' datestr(now,'yymmdd_HHMMSS')];
save(filename);
%%

Dmax=22;
lagmax=Dmax/c0; % correspond � un diam�tre max de 22m


switch method
    case 1
        falselags=abs(lag)>lagmax;
              
        lag_clean=lag;
        lag_clean(falselags)=NaN;
        
        L=zeros(Nangles,1);
        for it=1:Nangles
            L(it)=mean(lag_clean(it,~isnan(lag_clean(it,:))));
        end
                        
        x=zeros(1,Nhydro);
        y=zeros(1,Nhydro);
        
        for ii=1:Nhydro
            Ci=(L-lag_clean(:,ii))*c0;
            Mi=[sind(angle(~isnan(Ci)))' cosd(angle(~isnan(Ci)))'];
            Ci(isnan(Ci))=[];
            
            Xi=Mi\Ci;
            x(ii)=Xi(1);
            y(ii)=Xi(2);
        end
    case 0
        
        falselags=abs(lag)>lagmax;
        
        clean_idx=sum(falselags,2)==0;
        angle_clean=angle(clean_idx);
        
        lag_clean=lag(clean_idx,:);
        L=mean(lag_clean,2);
        
        M=[sind(angle_clean)' cosd(angle_clean)'];
                
        x=zeros(1,Nhydro);
        y=zeros(1,Nhydro);
        
        for ii=1:Nhydro
            Ci=(L-lag_clean(:,ii))*c0;
            Ci(isnan(Ci))=[];
            
            Xi=M\Ci;
            x(ii)=Xi(1);
            y(ii)=Xi(2);
        end
        
end
x1=x(1);
y1=y(1);
% theta1=atand(y1/x1);
%
% load([folder,'META_DONNEES_SIMU_AZIM_SHIP_0'],'xc','yc');

% err=mean(sqrt((xc-x).^2+(yc-y).^2)./(xc.^2+yc.^2));

figure,
% xlim([-20 20 ]), ylim([-20 20 ]),
daspect([1 1 1])
for ii=1:Nhydro
    hold on;
%     p1=plot(xc(ii),yc(ii),'kx');
    p2=plot(x(ii),y(ii),'rx');
    text(x(ii)+0.2,y(ii),num2str(ii))
end

xlabel('x (m)'), ylabel('y (m)')
if filterOption
    switch method
        case 0
            title([ site ' filter ' num2str(Fmin) '-' num2str(Fmax) 'Hz Dmax=' num2str(Dmax) 'm, method0 ' num2str(sum(clean_idx)) ' angles valides'])
        case 1
            title([ site ' filter ' num2str(Fmin) '-' num2str(Fmax) 'Hz Dmax=' num2str(Dmax) 'm, method1 ' num2str(sum(falselags(:))) ' overlags'])
    end
            
else
    switch method
        case 0
            title([ site ' Dmax=' num2str(Dmax) 'm, method0 ' num2str(sum(clean_idx)) ' angles valides'])
        case 1
            title([ site ' Dmax=' num2str(Dmax) 'm, method1 ' num2str(sum(falselags(:))) ' overlags'])
    end
end
% legend('point th�orique','point estim�')

%%
theta1=0;
X=zeros(1,Nhydro);
Y=zeros(1,Nhydro);
if video
    writerObj = VideoWriter(['Data loc\' site '.avi']);
    writerObj.FrameRate = 2;
    open(writerObj);
end

figure,
for ii=1:20
    hold off
%     plot(angle,lag(:,ii),'x');ylim([-lagmax lagmax]*2)
%     hold on, plot(angle,lag_clean(:,ii),'x');
    
toto=lag_clean(:,ii);
angleii=angle(~isnan(toto));
toto=toto(~isnan(toto));

% SineFunction=fittype('-A*sind(theta-theta1)-B*cosd(theta-theta1)+C','problem','theta1','dependent',{'toto'},'independent',{'theta'},'coefficients',{'A','B','C'});
% [myfit, goodness, output] = fit(angleii',toto,SineFunction ,'problem', theta1,'StartPoint',[0,0,0],'robust','on' );
% plot(myfit,angleii,toto); title(['A=' num2str(myfit.A,3) ' B=' num2str(myfit.B,3) ' C=' num2str(myfit.C,3)]) 

SineFunction=fittype('-A*sind(theta-theta1)-B*cosd(theta-theta1)','problem','theta1','dependent',{'toto'},'independent',{'theta'},'coefficients',{'A','B'});
[myfit, goodness, output] = fit(angleii',toto,SineFunction ,'problem', theta1,'StartPoint',[0,0],'robust','on' );
plot(myfit,angleii,toto); title([site ' H ' num2str(ii) ': lag=' num2str(c0*myfit.A,3) 'sin(\theta) + ' num2str(c0*myfit.B,3) 'cos(\theta)']) 
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

figure,
daspect([1 1 1])
for ii=1:Nhydro
    hold on;
    p2=plot(X(ii),Y(ii),'rx');
    text(X(ii)+0.2,Y(ii),num2str(ii))
end
title(site)
%%
save(filename,'X','Y','lag_clean','-append');
