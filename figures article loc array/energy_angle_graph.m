bateau='MSCANGELA';

switch bateau
    case 'ALICUDI'
        site1='MLB';
        site2='PRC';
        data1_circ='MLB_1708_7_8h_f=[50_1800]_220202_153158_circ.mat';
        data1='MLB_1708_7_8h_f=[50_1800]_220202_153226.mat';
        data2_circ='PRC_1708_7_8h_f=[50_1800]_220202_152838_circ.mat';
        data2='PRC_1708_7_8h_f=[50_1800]_220202_152828.mat';
    case 'MSCANGELA'
        site1='AAV';
        site2='CLD';
        data1_circ='AAV_2007_2_5h_f=[20_1800]_220203_120544_circ.mat';
        data1='AAV_2007_2_5h_f=[20_1800]_220406_171418.mat';
        data2_circ='CLD_2007_2_5h_f=[20_1800]_220203_120554_circ.mat';
        data2='CLD_2007_2_5h_f=[20_1800]_220406_171429.mat';
        
end

[ship_AIS_file,mois,jour,heure, minute, duree,distance_ship,loc_site,mmsi_ship,vec_lat_ship,...
    vec_long_ship,vec_temps_ship,x_ship_km,y_ship_km,folderIn]=get_ship_info(bateau,site1);

[angle1, dist1] = getRealAngle(site1 , vec_lat_ship, vec_long_ship);
[angle2, dist2] = getRealAngle(site2 , vec_lat_ship, vec_long_ship);


load(['C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\' data1]);
matEnergie1=matEnergie;
angleM1=angleM;

load(['C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\' data1_circ]);
matEnergie1_circ=matEnergie;
angleM1_circ=angleM;

load(['C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\' data2]);
matEnergie2=matEnergie;
angleM2=angleM;

load(['C:\Users\CHARLOTTE\Documents\MATLAB\Bring\Localisation\results\' data2_circ]);
matEnergie2_circ=matEnergie;
angleM2_circ=angleM;
Cmax=round(10*log10(max([matEnergie1(:); matEnergie1_circ(:);matEnergie2(:); matEnergie2_circ(:)])));
crange=[Cmax-25 Cmax ];

if ~exist('idx_deb','var')
    idx_deb=1;
end
if ~exist('idx_fin','var')
    idx_fin=length(angle1);
end
figure
subplot(221)
pcolor(arrIncol(datenum(ptime)), 1:360, 10*log10(matEnergie1_circ'))
shading flat
cb = colorbar('location','eastoutside');
ylabel(cb, 'Energy (dB)');
colormap jet
hold on
plot(ptime,angleM1_circ,'o','color','k','markersize',3,'markerfacecolor','k');hold on
plot(vec_temps_ship(idx_deb:idx_fin)/(24*3600),angle1(idx_deb:idx_fin),'k','LineWidth',2);
title([ site1 ' circular array'])
caxis(crange)

subplot(222)
pcolor(arrIncol(datenum(ptime)), 1:360, 10*log10(matEnergie1'))
shading flat
cb = colorbar('location','eastoutside');
ylabel(cb, 'Energy (dB)');
colormap jet
hold on
 plot(ptime,angleM1,'o','color','k','markersize',3,'markerfacecolor','k');hold on
plot(vec_temps_ship(idx_deb:idx_fin)/(24*3600),angle1(idx_deb:idx_fin),'k','LineWidth',2);
title([ site1 ' corrected array'])
caxis(crange)

subplot(223)
pcolor(arrIncol(datenum(ptime)), 1:360, 10*log10(matEnergie2_circ'))
shading flat
cb = colorbar('location','eastoutside');
ylabel(cb, 'Energy (dB)');
colormap jet
hold on
 plot(ptime,angleM2_circ,'o','color','k','markersize',3,'markerfacecolor','k');hold on
 plot(vec_temps_ship(idx_deb:idx_fin)/(24*3600),angle2(idx_deb:idx_fin),'k','LineWidth',2);
title([ site2 ' circular array'])
caxis(crange)


subplot(224)
pcolor(arrIncol(datenum(ptime)), 1:360, 10*log10(matEnergie2'))
shading flat
cb = colorbar('location','eastoutside');
ylabel(cb, 'Energy (dB)');
colormap jet
hold on
plot(ptime,angleM2,'o','color','k','markersize',3,'markerfacecolor','k');hold on
plot(vec_temps_ship(idx_deb:idx_fin)/(24*3600),angle2(idx_deb:idx_fin),'k','LineWidth',2);
title([ site2 ' corrected array'])
caxis(crange)

saveas(gcf,['figures/energy_angles_' site1 '_' site2 '_' bateau '.fig'])