%% figure réseau

hydrofileAAV='Localisation\Data loc\AAVv5_c0=1480 3_boats.mat';
hydrofileMLB='Localisation\Data loc\MLB_220331_NS_20km_c0=1480_5_boats.mat';
hydrofilePRC='Localisation\Data loc\PRC_220331_NS_20km_c0=1480_6_boats.mat';
hydrofileCLD='Localisation\Data loc\CLDv5_c0=1480 3_boats.mat';

load(hydrofileAAV,'X','Y','c0');
Xaav=X; Yaav=Y;
load(hydrofileMLB,'X','Y','c0');
Xmlb=X; Ymlb=Y;
load(hydrofilePRC,'X','Y','c0');
Xprc=X; Yprc=Y;
load(hydrofileCLD,'X','Y','c0');
Xcld=X; Ycld=Y;
clear X Y
%%
figure, 
subplot(221),
for ii=1:20
    hold on;
    p2=plot(Xaav(ii)-mean(Xaav),Yaav(ii)-mean(Yaav),'kx','MarkerSize',6,'LineWidth',1.5);
    text(Xaav(ii)-mean(Xaav)+0.3,Yaav(ii)-mean(Yaav)+0.3,num2str(ii),'Color','r')
end
daspect([1 1 1])
title('Anse-à-Valleau')
xlabel('x (m)'), ylabel('y (m)'), xlim([-12 12]), ylim([-12 12])
daspect([1 1 1])

subplot(222),
for ii=1:20
    hold on;
    p2=plot(Xmlb(ii)-mean(Xmlb),Ymlb(ii)-mean(Ymlb),'kx','MarkerSize',6,'LineWidth',1.5);
    text(Xmlb(ii)-mean(Xmlb)+0.3,Ymlb(ii)-mean(Ymlb)+0.3,num2str(ii),'Color','r')
end
daspect([1 1 1])
title('Malbay')
xlabel('x (m)'), ylabel('y (m)'), xlim([-12 12]), ylim([-12 12])
daspect([1 1 1])

subplot(223),
for ii=1:20
    hold on;
    p2=plot(Xprc(ii)-mean(Xprc),Yprc(ii)-mean(Yprc),'kx','MarkerSize',6,'LineWidth',1.5);
    text(Xprc(ii)-mean(Xprc)+0.3,Yprc(ii)-mean(Yprc)+0.3,num2str(ii),'Color','r')
end
daspect([1 1 1])
title('Percée')
xlabel('x (m)'), ylabel('y (m)'), xlim([-12 12]), ylim([-12 12])
daspect([1 1 1])

subplot(224),
for ii=1:20
    hold on;
    p2=plot(Xcld(ii)-mean(Xcld),Ycld(ii)-mean(Ycld),'kx','MarkerSize',6,'LineWidth',1.5);
    text(Xcld(ii)-mean(Xcld)+0.3,Ycld(ii)-mean(Ycld)+0.3,num2str(ii),'Color','r')
end
daspect([1 1 1])
title('Cloridorme')
xlabel('x (m)'), ylabel('y (m)'), xlim([-12 12]), ylim([-12 12])
daspect([1 1 1])