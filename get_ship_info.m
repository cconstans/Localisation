function [ship_AIS_file,mois,jour,heure, minute, duree,distance_ship,loc_site,mmsi_ship,vec_lat_ship,...
    vec_long_ship,vec_temps_ship,x_ship_km,y_ship_km,folderIn]=get_ship_info(bateau,arrID)

switch bateau
    case 'OCEANECHOII'
        ship_AIS_file=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\OCEANECHOII_' arrID '_1307_21_24h'];
        load(ship_AIS_file);
    case 'LAKEONTARIO'
        ship_AIS_file=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\LAKEONTARIO_' arrID '_1507_9_11h'];
        load(ship_AIS_file);
 
    case 'MSCANGELA'
        ship_AIS_file=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\MSCANGELA_' arrID '_2007_2_5h'];
        load(ship_AIS_file);
     
    case 'OCEANEXCONNAIGRA'
        ship_AIS_file=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\OCEANEXCONNAIGRA_' arrID '_1807_18_21h.mat'];
        load(ship_AIS_file);
        heure=20;
        minute=0;
        duree=3600*1.5;
    case 'NACCQUEBEC'
        switch arrID
            case 'CLD'
                ship_AIS_file='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\NACCQUEBEC_CLD_1807_10_12h.mat';
                load(ship_AIS_file);
                heure=10;
                minute=20;
                duree=3600*1;
            case 'AAV'
                ship_AIS_file='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\NACCQUEBEC_AAV_1807_10_13h.mat';
                load(ship_AIS_file);
                heure=11;
                minute=45;
                duree=3600*1;
        end
    case 'QAMUTIK'
        switch arrID
            case 'CLD'
                ship_AIS_file='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\QAMUTIK_CLD_1907_0_3h.mat';
                load(ship_AIS_file);
                heure=1;
                minute=15;
                duree=3600*1;
            case 'AAV'
                ship_AIS_file='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\QAMUTIK_AAV_1907_2_4h.mat';
                load(ship_AIS_file);
                heure=2;
                minute=15;
                duree=3600*1;
        end
    case 'BEVERLYMI'
        
        switch arrID
            case 'CLD'
                ship_AIS_file='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\BEVERLYMI_CLD_2307_6_8h.mat';
                load(ship_AIS_file);
                heure=7;
                minute=15;
                duree=60*25;
            case 'AAV'
                ship_AIS_file='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316003726_AAV_1907_10_12h.mat';
                load(ship_AIS_file);
                heure=5;
                minute=55;
                duree=60*25;
        end
    case '316003726'
        switch arrID
            case 'CLD'
                ship_AIS_file='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316003726_CLD_1907_8_10h.mat';
                load(ship_AIS_file);
                heure=8;
                minute=45;
                duree=60*45;
            case 'AAV'
                ship_AIS_file='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316003726_AAV_1907_10_12h.mat';
                load(ship_AIS_file);
                heure=10;
                minute=25;
                duree=60*15;
        end
    case 'CORIOLIS_PERPH'
        ship_AIS_file=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\CORIOLISII_' arrID '_1407_0_3h.mat'];
        load(ship_AIS_file);
    case 'CORIOLIS_PERPP'
        ship_AIS_file=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\CORIOLISII_' arrID '_3007_13_18h.mat'];
        load(ship_AIS_file);
        duree=3600*4;
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
        ship_AIS_file=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\JOHN CABOT_' arrID '_1208_6_8h.mat'];
        load(ship_AIS_file);
        
    case 'ALICUDI'
        ship_AIS_file=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\NACCALICUDI_' arrID '_1708_7_9h.mat'];
        load(ship_AIS_file);
        %         heure=7;
        %         minute=25;
        %         duree=50*60;
        
        heure=7;
        minute=0;
        duree=1.5*3600;
    case 'Nacc'
        ship_AIS_file=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316034372_' arrID '_508_6_9h.mat'];
        load(ship_AIS_file);
        
        heure=6;
        minute=55;
        duree=3600*1;
    case 'Nacc68'
        ship_AIS_file=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\NACC_' arrID '_608_2_4h.mat'];
        load(ship_AIS_file);
    case 'TB'
        ship_AIS_file=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316023339_' arrID '_1408_22_24h.mat'];
        load(ship_AIS_file);
        heure=22;
        minute=0;
        duree=3600*2;
    case 'Coriolis'
        ship_AIS_file=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\CORIOLIS_' arrID '_108_5_8h.mat'];
        load(ship_AIS_file);  
          heure=5;
        minute=45;
        duree=3600*2+24*60;
    case 'NACCQUEBEC2107'
        ship_AIS_file=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\NACCQUEBEC_' arrID '_2107_5_7h.mat'];
        load(ship_AIS_file);    
    case 'GAIADESGAGNES'
        ship_AIS_file=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\GAIADESGAGNES_' arrID '_2407_12_15h.mat'];
        load(ship_AIS_file);       
    case 'KSLSANFRANCISCO'
        ship_AIS_file=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\KSLSANFRANCISCO_' arrID '_1407_3_7h.mat'];
        load(ship_AIS_file);      
    case 'MIEDWIE'
        ship_AIS_file=['C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\MIEDWIE' arrID '1607_6_9h.mat'];
        load(ship_AIS_file);
    case '316006850'
        switch arrID
            case 'PRC'
                ship_AIS_file='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316006850_PRC_1608_7_9h.mat';
                load(ship_AIS_file);
                heure=8;
                minute=5;
                duree=40*60;
            case 'MLB'
                ship_AIS_file='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316006850_MLB_1608_7_9h.mat';
                load(ship_AIS_file);
                heure=8;
                minute=5;
                duree=25*60;
        end
    case 'QUEBEC_508' %NACC QUEBEC
        switch arrID
            case 'PRC'
                ship_AIS_file='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316034372_PRC_508_6_9h.mat';
                load(ship_AIS_file);
%                 heure=6;
%                 minute=20;
%                 duree=2*3600;
                heure=6;
                minute=30;
                duree=2*3600;
            case 'MLB'
                ship_AIS_file='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316034372_MLB_508_6_9h.mat';
                load(ship_AIS_file);
                heure=7;
                minute=0;
                duree=50*60;
        end
    case 'QUEBEC_3007' %NACC QUEBEC
        switch arrID
            case 'PRC'
                ship_AIS_file='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\NACCQUEBEC_PRC_3007_8_10h.mat';
                load(ship_AIS_file);
                heure=8;
                minute=45;
                duree=3600;
            case 'MLB'
                ship_AIS_file='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\NACCQUEBEC_MLB_3007_8_10h.mat';
                load(ship_AIS_file);
                heure=8;
                minute=45;
                duree=3600;
        end
    case 'STRAITHUNTER' 
        switch arrID
            case 'PRC'
                ship_AIS_file='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\STRAITHUNTER_PRC_3007_22_25h.mat';
                load(ship_AIS_file);
                heure=22;
                minute=30;
                duree=3600*2;
            case 'MLB'
                ship_AIS_file='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\STRAITHUNTER_MLB_3007_22_25h.mat';
                load(ship_AIS_file);
                heure=22;
                minute=30;
                duree=3600*2;
        end
    case 'THUNDER_BAY' % THUNDER BAY 
        switch arrID
            case 'PRC'
                ship_AIS_file='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316023339_PRC_1408_22_24h.mat';
                load(ship_AIS_file);
                heure=22;
                minute=4;
                duree=3600+60*41;
            case 'MLB'
                ship_AIS_file='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\316023339_MLB_1408_22_24h.mat';
                load(ship_AIS_file);
                heure=22;
                minute=4;
                duree=3600+60*41;
        end
    case 'SAMUELRISLEY'  
        switch arrID
            case 'PRC'
                ship_AIS_file='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\SAMUELRISLEY_PRC_3107_22_24h.mat';
                load(ship_AIS_file);
                heure=22;
                minute=25;
                duree=60*55;
            case 'MLB'
                ship_AIS_file='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\SAMUELRISLEY_MLB_3107_22_24h.mat';
                load(ship_AIS_file);
               heure=22;
                minute=25;
                duree=60*55;
        end
    case 'GLORYRIVER'  
        switch arrID
            case 'PRC'
                ship_AIS_file='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\GLORYRIVER_PRC_308_6_9h.mat';
                load(ship_AIS_file);
                heure=8;
                minute=0;
                duree=3600;
            case 'MLB'
                ship_AIS_file='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\GLORYRIVER_MLB_308_6_9h.mat';
                load(ship_AIS_file);
                heure=8;
                minute=0;
                duree=3600;
        end
    case 'SANDRAMARY'  
        switch arrID
            case 'PRC'
                ship_AIS_file='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\SANDRAMARY_PRC_408_23_25h.mat';
                load(ship_AIS_file);
                heure=23;
                minute=30;
                duree=3600*1.5;
            case 'MLB'
                ship_AIS_file='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\SANDRAMARY_MLB_408_23_25h.mat';
                load(ship_AIS_file);
               heure=23;
                minute=30;
                duree=3600*1.5;
        end
    case 'ALICUDI_0708'  
        switch arrID
            case 'PRC'
                ship_AIS_file='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\NACCALICUDI_PRC_708_2_5h.mat';
                load(ship_AIS_file);
                heure=2;
                minute=0;
                duree=3600*3;
            case 'MLB'
                ship_AIS_file='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\NACCALICUDI_MLB_708_2_5h.mat';
                load(ship_AIS_file);
                heure=2;
                minute=0;
                duree=3600*3;
        end
    case 'JJ_0808'  
        switch arrID
            case 'PRC'
                ship_AIS_file='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\JEAN-JOSEPH_PRC_808_15_18h.mat';
                load(ship_AIS_file);
                heure=15;
                minute=0;
                duree=3600+10*60;
            case 'MLB'
                ship_AIS_file='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\JOSEPH_MLB_808_15_18h.mat';
                load(ship_AIS_file);
                heure=15;
                minute=0;
                duree=3600+10*60;
        end
    case 'JJ_1108'  
        switch arrID
            case 'PRC'
                ship_AIS_file='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\JEAN-JOSEPH_PRC_1108_3_5h.mat';
                load(ship_AIS_file);
                heure=3;
                minute=30;
                duree=1.5*3600;
            case 'MLB'
                ship_AIS_file='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\JEAN-JOSEPH_MLB_1108_3_5h.mat';
                load(ship_AIS_file);
                heure=3;
                minute=30;
                duree=1.5*3600;
        end
    case 'BRIGHTIMABARI'  
        switch arrID
            case 'PRC'
                ship_AIS_file='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\BRIGHTIMABARI_PRC_1008_4_7h.mat';
                load(ship_AIS_file);
                heure=4;
                minute=0;
                duree=3600*2.5;
            case 'MLB'
                ship_AIS_file='C:\Users\CHARLOTTE\Documents\MATLAB\AIS_TOOLBOX\SHIPS\BRIGHTIMABARI_MLB_1008_4_7h.mat';
                load(ship_AIS_file);
                heure=4;
                minute=0;
                duree=3600*2.5;
        end
end

switch arrID
    case 'AAV'
        folderIn = ['D:/Bring_Dep_1_Wav/' arrID '/' 'LF' '/']; % Local Mac folder
    case 'CLD'
        folderIn = ['D:/Bring_Dep_1_Wav/' arrID '/' 'LF' '/'];
    case 'MLB'
        folderIn = ['H:\Bring_Dep_2\' arrID '_wav\'];
    case 'PRC'
        folderIn = ['H:\Bring_Dep_2\' arrID '_wav\'];
end
end