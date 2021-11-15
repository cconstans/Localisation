% Defautl config for using the beamforming for BRING
% Mainly you need to specified the:
% 
% arrID = AAV / CLD / MLB / PR 
% outName = name of the output folder and figures
% folderIn = where you wav are
% folderOut = where you want to figure and data to be saved
% ptime = time to locate -> can aslo be used with getPingLoc if ping...
% information are store in the function with and ID related to the data
%
% If openData == False the code will run the locateBring script and saved
% result. If openData = False, the code will load the data matching the
% outName folder in the [folderOut outName] or pingPath that you specified.
% This save calcul time when working many time on the same dataset.
% 
% Other parameter can be set in this script.
%
% Data in you folder should be  
%
% Last update 14/10/21 by @kevDuquette

clear all
% close all

% Add all function located in the three to path
addpath(genpath('C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation_reseau\'));

% Need to run data or just open it a .mat
openData = false;
AntenneCorrigee=0;
% Path information : folderIn = wav folder / folderOut = figure output folder
arrID = 'CLD';
typeHL = 'LF';

outName = 'defaultConfig';

[ptime, ploc]  = getPingInfo(arrID); % Load ping information

switch arrID
    case 'AAV'
        folderIn = ['D:/Bring_Dep_1_Wav/' arrID '/' typeHL '/']; % Local Mac folder
        startID=83; % take points from startID
        thetaexcluded=[];
         ptime = ptime + seconds(7);          % Add an offset to be center the 5 upcalls
        Ns = 2^16;              % Total number of sample
    case 'CLD'
        folderIn = ['D:/Bring_Dep_1_Wav/' arrID '/' typeHL '/'];
        startID=1;
        thetaexcluded=[];
         ptime = ptime + seconds(7);          % Add an offset to be center the 5 upcalls
        Ns = 2^16;              % Total number of sample
    case 'MLB'
        folderIn = ['F:\Bring_Dep_2\' arrID '_wav\'];
        startID=1001;
        thetaexcluded=[];
                Ns = 2^14;              % Total number of sample
    case 'PRC'
        folderIn = ['F:\Bring_Dep_2\' arrID '_wav\'];
        startID=33;
        thetaexcluded=[];
        Ns = 2^14;              % Total number of sample

end
BoatInfo=['C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation_reseau\boatTrack\' arrID 'CircleTrack.mat'];
load(BoatInfo);

if ~isempty(thetaexcluded)
    
    idxrange= ~(angle<thetaexcluded(2) & angle>thetaexcluded(1));
    angle=angle(idxrange);
    time=time(idxrange);
elseif startID
    angle(1:startID-1)=[];
    time(1:startID-1)=[];
end

if strcmp(arrID,'CLD')
     time=time-days(1)-hours(8);
end
ptime=time;

folderOut = ['C:/Users/CHARLOTTE/Documents/MATLAB/Bring/Localisation_reseau/results/' arrID '/' outName '/'];
%pingFolder = ['/Users/Administrator/Documents/MPO/BRing/Data/results/' arrID '/prcCircle_Ns14_f150-200hz/'];
%folderIn = ['Z:\DATA\missions\2021-07-27_IML_2021-016_BRings\wav\' arrID '/'];

% Loading files and time
% Time must be in datetime format. The file to load will be automatically find

% Figure parameters
showFig = []       % Figure number to print
saveData = false;   % Save result to .mat
printFig = false;    % Saving figure to a folder
nbPk = 4 ;          % Nomber of side lobe to keep

% Reading parameters
buffer = 0.4;             % Time in second to add before the ptime

% Spectro parameter
% Frequence min and max
fmin_int = 150;
fmax_int = 200;

% Get the real angle and distance from center
arrLoc = getArrLoc(arrID);
angleR = getRealAngle(arrID, ploc(:,1),ploc(:,2));

% If wanted to open alredy run script
if openData == true
    disp('Opening already run data')
    p = getRunData(pingFolder);
    %unpackStruct(p);  % Unpack structure to get same workspace as locateBring
else
    if AntenneCorrigee
        locateBring_deform;
    else
        locateBring; % The main loop calculation are locate in this script
    end
    % Add some figure script located in ../plotScript
    
%     showAOACircle; 
    

end
showAOACircle;

%%
% err=mean(abs(angleM-angle)/360);
% err=mean(min(abs(angleM-angleR'),abs(abs(angleM-angleR')-360))/360);
% figure
% h1=plot(angleM,'or');
% hold on
% % hTh = plot(x,0:36:360-36,'k-');
% h2 = plot(angleR,'xb');
% legend([h1,h2],{'Angle calculé','Angle théorique'})
% if AntenneCorrigee
%     
%     title([arrID ' forme corrigée err=' num2str(err*100,3) '%'] )
% else
%     title([arrID ' forme circulaire err=' num2str(err*100,3) '%'] )
% end
%%

err=mean(min(abs(angleM-angle),abs(abs(angleM-angle)-360))/360);
figure
h1=plot(angleM,'or');
hold on
% hTh = plot(x,0:36:360-36,'k-');
h2 = plot(angle,'xb');
legend([h1,h2],{'Angle calculé','Angle théorique'})
if AntenneCorrigee
    
    title([arrID ' forme corrigée err=' num2str(err*100,3) '%'] )
else
    title([arrID ' forme circulaire err=' num2str(err*100,3) '%'] )
end


figure, 
plot(angle,angle,'k')
hold on, plot(angle,angleM,'rx')
xlabel('Angle théorique (°)')
ylabel('Angle calculé (°)')
if AntenneCorrigee
    title([arrID ' forme corrigée err=' num2str(err*100,3) '%'] )
else
    title([arrID ' forme circulaire err=' num2str(err*100,3) '%'] )
end


figure, 
plot(angleM-angle,'kx')
hold on,
plot([1 length(angle)],[0 0])
ylabel('Angle calculé - angle théorique (°)')
ylim([-20 20 ])

% if AntenneCorrigee
%     title([arrID ' forme corrigée err=' num2str(err*100,3) '%'] )
% else
%     title([arrID ' forme circulaire err=' num2str(err*100,3) '%'] )
% end
% showAOACircle
% Plot some side lobe
% for ii=2:2
%    hSl = plot(x,angleA(:,ii),'o') 
% end
%% Add some more specified line or figures related to you run
% Enjoy!

% showAOACircle