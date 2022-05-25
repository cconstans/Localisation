%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A partir des résultats de beamforming sur 2 sites AAV et CLD pour un même
% signal reçu de cétacé, donnant chacun une direction par rapport au site, calcul de la position de l'animal.

% Charlotte Constans 05/22
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear 
AntenneCorrigee=1;
% baleine='0408_9h_1';
% baleine='blue_1507_9h';
baleine='blue_1507_9h';
switch baleine
    case '0408_9h_1'
        site='MLB_PRC';
        if AntenneCorrigee
            data1='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\whales\MLB_0408_9h_1_220208_164707';
            data2='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\whales\PRC_0408_9h_1_220208_164833';
        else
            data1='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\whales\MLB_0408_9h_1_220208_164731_circ';
            data2='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\whales\PRC_0408_9h_1_220208_164754_circ';
            
        end
    case '0408_12h_1'
        site='MLB_PRC';
        
        if AntenneCorrigee
            data1='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\whales\MLB_0408_12h_1_220127_093310';
            data2='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\whales\PRC_0408_12h_1_220127_094322';
            
        else
            data1='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\whales\MLB_0408_12h_1_220127_093505_circ';
            data2='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\whales\PRC_0408_12h_1_220127_094316_circ';
        end
    case 'blue_1507_9h'
        site='AAV_CLD';
        if AntenneCorrigee
            data1='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\whales\blue_AAV_1507_9h_220126_125147';
            data2='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\whales\blue_CLD_1507_9h_220126_124810';
        else
            data1='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\whales\blue_AAV_1507_9h_220126_165919_circ';
            data2='C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\whales\blue_CLD_1507_9h_220126_124731_circ';
        end
        
end

load(data1,'-regexp','^(?!baleine$)\w')
ptime1=ptime;
angle1=angleM;

load(data2,'-regexp','^(?!baleine$)\w')
ptime2=ptime;
angle2=angleM;

switch site
    case 'MLB_PRC'
        loc1 = [48.6039 -64.1863]; % 0,0 en coord cart
        loc2= [48.5311 -64.1983]; %
    case 'AAV_CLD'
        loc1 = [49.0907 -64.5372];
        loc2 = [49.1933  -64.8315];
end

x1=0; y1=0;
R_T_km = 6378140/1000;% rayon de la terre en km

x2 = R_T_km*(cosd(loc1(1))*(loc2(2)-loc1(2))*pi/180);
y2 = R_T_km*(loc2(1)-loc1(1))*pi/180;

if angle1==90 || angle1==260
    y_whale=y1;
    x_whale=x2+(y_whale-y2)*tand(angle2);
elseif angle2==90 || angle2==260
    y_whale=y2;
    x_whale=y_whale/tand(angle1);
else
    det=tand(angle2)-tand(angle1);
    y_whale=1./det.*(-x2+tand(angle2)*y2);
    x_whale=y_whale.*tand(angle1);
end
delta_lat=y_whale/R_T_km*180/pi;
delta_long=x_whale/R_T_km*180/pi/cosd(loc1(1));
lat=loc1(1)+delta_lat;
lon=loc1(2)+delta_long;

dist2site1=sqrt(x_whale.^2+y_whale.^2);
dist2site2=sqrt((x_whale-x2).^2+(y_whale-y2).^2);

figure, plot(x1,y1,'rx');
text(x1,y1,'AAV')
hold on, plot(x2,y2,'rx');
text(x2,y2,'CLD')
plot(x_whale,y_whale,'bx');
daspect([1 1 1])

% switch site
%     case 'MLB_PRC'
%         openfig('C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\m_map\mmap_ex\fond_MLB_PRC.fig');
%     case 'AAV_CLD'
%         openfig('C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\m_map\mmap_ex\fond_AAV_CLD.fig');
% end
% 
% hold on, 
% hr=   m_plot(lon,lat,'o','MarkerEdgeColor','k',...
%     'MarkerFaceColor','k','MarkerSize',4) ;

% image_map_point(x_whale,y_whale, loc1,loc2);
saveas(gcf,[data1 '.fig'])

delta=dist2site1-dist2site2; % différence marche en km
deltaT_calc=delta/c0*1000; % différence de marche temporelle théorique (s)
deltaT_obs=seconds(ptime1-ptime2);
delta_obs=deltaT_obs*c0/1000;
%% tracé parabole en fct diff de marche
Np=500;
  D=sqrt( (y2-y1)^2 + (x2-x1)^2); % ouverture de l'antenne
        X0 = (x2+x1)/2; Y0 = (y2+y1)/2; % centre de l'antenne
        alpha = atan2(y2-y1,x2-x1); % inclinaisson de l'antenne
        d=delta_obs;
        % matrices de rotation ALLER (repere global vers repere antenne) et RETOUR (repere antenne vers repere global
        M = [ cos(alpha) -sin(alpha)
            sin(alpha) cos(alpha)];
        
        M1 = [ cos(alpha) sin(alpha)
            -sin(alpha) cos(alpha)];
        
        % Equation parabolique
        if d>=0
            x=linspace(d/2,2*D,Np);
        else
            x=linspace(-2*D,d/2,Np);
        end
        ypos=sqrt(x.^2*(D^2/d^2-1)-D^2/4+d^2/4);
        x(0.25*(abs(imag(ypos))).^2>eps)=[];
        ypos(0.25*(abs(imag(ypos))).^2>eps)=[];
        yneg=-ypos;
        if d>=0
            X=[flip(x) x]; Y= real([flip(ypos) yneg]);
        else
            X=[x flip(x)]; Y= real([ypos flip(yneg)]);
        end
        dist21=sqrt((X-D/2).^2+Y.^2);
        dist22=sqrt((X+D/2).^2+Y.^2);
%         X(dist21>portee*1.1 | dist22>portee*1.1)=[];
%         Y(dist21>portee*1.1 | dist22>portee*1.1)=[];
        
%         figure,
%         plot([-D/2,D/2],[0 0],'ro');
%         hold on;
%         plot(X, Y,'x');
%         daspect([1 1 1])
        % rotation et translation de l'hyperbole du repere local vers le repere
        % global
        
        V0 = [X0; Y0];
        for kk = 1 : length(X)
            v = [X(kk);Y(kk)];
            V = V0+M*v;
            X1(kk)=V(1); Y1(kk)=V(2);
        end
        if length(X)<2*Np
            X1(length(X)+1:2*Np)=nan;
            Y1(length(X)+1:2*Np)=nan;
        end
        figure
        hold on;
        plot([x1 x2],[y1 y2],'ko','MarkerFaceColor','k');
        hold on;
%         plot(squeeze(X1(couple,:)), squeeze(Y1(couple,:)),'x');
        plot(squeeze(X1( 1 : length(X))), squeeze(Y1( 1 : length(X))));
        daspect([1 1 1])
        pause(0.5);