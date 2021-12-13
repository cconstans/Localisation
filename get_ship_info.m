function [ship_AIS_file,mois,jour,heure, minute, duree,distance_ship,loc_site,mmsi_ship,vec_lat_ship,...
    vec_long_ship,vec_temps_ship,x_ship_km,y_ship_km,folderIn]=get_ship_info(bateau,arrID)

switch bateau
    case 'OCEANEXCONNAIGRA'
        ship_AIS_file=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\OCEANEXCONNAIGRA_' arrID '_1807_18_21h.mat'];
        load(ship_AIS_file);
        heure=19;
        minute=30;
        duree=3600*2;
    case 'TENACITYVENTURE'
        ship_AIS_file=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\TENACITYVENTURE_' arrID '_1507_20_22h.mat'];
        load(ship_AIS_file);
        
    case 'HELGABULKER'
        ship_AIS_file=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\HELGABULKER_' arrID '_1407_17_20h.mat'];
        load(ship_AIS_file);
        
    case 'BLUEALEXANDRA'
        ship_AIS_file=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\BLUEALEXANDRA_' arrID '_2107_11_14h.mat'];
        load(ship_AIS_file);
       
    case 'JJ'
        ship_AIS_file=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316006850_' arrID '_1608_7_9h.mat'];
        load(ship_AIS_file);
        heure=7;
        minute=55;
        duree=3600*1;
    case 'JC'
        ship_AIS_file=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\JOHN CABOT' arrID '1208_6_8h.mat'];
        load(ship_AIS_file);
        
    case 'ALICUDI'
        ship_AIS_file=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\NACCALICUDI_' arrID '_1708_7_8h.mat'];
        load(ship_AIS_file);
        
    case 'Nacc'
        ship_AIS_file=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316034372' arrID '508_6_9h.mat'];
        load(ship_AIS_file);
        
        heure=6;
        minute=55;
        duree=3600*1;
    case 'Nacc68'
        ship_AIS_file=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\NACC_' arrID '_608_2_4h.mat'];
        load(ship_AIS_file);
    case 'TB'
        ship_AIS_file=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316023339' arrID '1408_22_24h.mat'];
        load(ship_AIS_file);
        heure=22;
        minute=0;
        duree=3600*2;
    case 'Coriolis'
        ship_AIS_file=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\CORIOLIS' arrID '108_5_8h.mat'];
        load(ship_AIS_file);    
    case 'NACCQUEBEC2107'
        ship_AIS_file=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\NACCQUEBEC' arrID '2107_5_7h.mat'];
        load(ship_AIS_file);    
    case 'GAIADESGAGNES'
        ship_AIS_file=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\GAIADESGAGNES' arrID '2407_12_15h.mat'];
        load(ship_AIS_file);       
    case 'KSLSANFRANCISCO'
        ship_AIS_file=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\KSLSANFRANCISCO' arrID '1407_3_7h.mat'];
        load(ship_AIS_file);      
    case 'MIEDWIE'
        ship_AIS_file=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\MIEDWIE' arrID '1607_6_9h.mat'];
        load(ship_AIS_file);      
end

switch arrID
    case 'AAV'
        folderIn = ['D:/Bring_Dep_1_Wav/' arrID '/' 'LF' '/']; % Local Mac folder
    case 'CLD'
        folderIn = ['D:/Bring_Dep_1_Wav/' arrID '/' 'LF' '/'];
    case 'MLB'
        folderIn = ['F:\Bring_Dep_2\' arrID '_wav\'];
    case 'PRC'
        folderIn = ['F:\Bring_Dep_2\' arrID '_wav\'];
end
end