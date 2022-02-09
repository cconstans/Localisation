
switch baleine
    case 'MLB_0408_9h_1'
        arrID='MLB';
        file_wav='C:\Users\CHARLOTTE\Documents\Bring\Perce vocalises\MLB_LF_20210804T090000_1591_0.wav';
        minute=2;
        second=47.5;
        ptime=datetime(2021,08,04,9,minute,second); 
    case 'MLB_0408_12h_1'
        arrID='MLB';
        file_wav='F:\Bring_Dep_2\MLB_wav\MLB_LF_20210804T122000_1631_0.wav';
        minute=4;
        second=19;
        ptime=datetime(2021,08,04,12,20+minute,second); 
    case 'MLB_0408_12h_2'
        arrID='MLB';
        file_wav='F:\Bring_Dep_2\MLB_wav\MLB_LF_20210804T122000_1631_0.wav';
        minute=4;
        second=17;
        ptime=datetime(2021,08,04,12,20+minute,second); 
    case 'PRC_0408_12h_1'
        arrID='PRC';
        file_wav='F:\Bring_Dep_2\PRC_wav\PRC_LF_20210804T122000_1713_0.wav';
        minute=4;
        second=23.5;
        ptime=datetime(2021,08,04,12,20+minute,second); 
    case 'PRC_0408_12h_2'
        arrID='PRC';
        file_wav='F:\Bring_Dep_2\PRC_wav\PRC_LF_20210804T122000_1713_0.wav';
        minute=4;
        second=28;
        ptime=datetime(2021,08,04,12,20+minute,second); 
    case 'PRC_0408_9h_1'
        arrID='PRC';
        file_wav='C:\Users\CHARLOTTE\Documents\Bring\Perce vocalises\PRC_LF_20210804T090000_1672_0.wav';
%  fmin = 50;
%         fmax = 250;
        minute=3;
        second=0.5;
        ptime=datetime(2021,08,04,9,minute,second);
    case 'PRC_0408_9h_2'
        arrID='PRC';
        file_wav='C:\Users\CHARLOTTE\Documents\Bring\Perce vocalises\PRC_LF_20210804T090000_1672_0.wav';

        minute=3;
        second=8;
        ptime=datetime(2021,08,04,9,minute,second); 
    case 'CLD_1607_6h'
        arrID='CLD';
        file_wav='D:\Bring_Dep_1_Wav\CLD\LF\CLD_2591LF_20210716T061500_0748_0.wav';

        minute=4;
        second=3.5;
        ptime=datetime(2021,07,16,6,15+minute,second);
        duree=1;
    case 'AAV_1407_22h'
        arrID='AAV';
        file_wav='D:\Bring_Dep_1_Wav\AAV\LF\AAV_2591LF_20210714T221500_0943_0.wav';
        minute=1;
        second=26;
        ptime=datetime(2021,07,14,22,15+minute,second);
%         duree=1;
        fmin = 100;
        fmax = 250;
        %         duree=1;
    case 'blue_CLD_1507_9h'
        arrID='CLD';
        file_wav='D:\Bring_Dep_1_Wav\CLD\LF\CLD_2591LF_20210715T095000_0503_0.wav';
        minute=0;
        second=17;
        ptime=datetime(2021,07,15,9,50+minute,second);
        fmin = 25;
        fmax = 100;
        duree=4;
    case 'blue_AAV_1507_9h'
        arrID='AAV';
        file_wav='D:\Bring_Dep_1_Wav\AAV\LF\AAV_2591LF_20210715T095000_1082_0.wav';
        minute=0;
        second=15;
        ptime=datetime(2021,07,15,9,50+minute,second);
        fmin = 25;
        fmax = 100;
        duree=4;
    case 'blue_AAV_1507_9h_2'
        arrID='AAV';
        file_wav='D:\Bring_Dep_1_Wav\AAV\LF\AAV_2591LF_20210715T095000_1082_0.wav';
        minute=4;
        second=37;
        ptime=datetime(2021,07,15,9,50+minute,second);
        fmin = 25;
        fmax = 100;
        duree=4;
    case 'blue_AAV_1307_23h'
        arrID='AAV';
        file_wav='D:\Bring_Dep_1_Wav\AAV\LF\AAV_2591LF_20210713T234500_0673_0.wav';
        minute=2;
        second=31;
        ptime=datetime(2021,07,13,23,45+minute,second);
        fmin = 25;
        fmax = 100;
        duree=4;
    case 'blue_CLD_1307_23h'
        arrID='CLD';
        file_wav='D:\Bring_Dep_1_Wav\CLD\LF\CLD_2591LF_20210713T234500_0094_0.wav';
        minute=2;
        second=35;
        ptime=datetime(2021,07,13,23,45+minute,second);
        fmin = 50;
        fmax = 100;
        duree=3;
    case 'rorq_AAV_1407_4h'
        arrID='AAV';
        file_wav='D:\Bring_Dep_1_Wav\AAV\LF\AAV_2591LF_20210714T043000_0730_0.wav';
        minute=3;
        second=24;
        ptime=datetime(2021,07,14,4,30+minute,second);
        fmin = 40;
        fmax = 150;
        duree=1;
    case 'rorq_CLD_1407_4h'
        arrID='CLD';
        file_wav='D:\Bring_Dep_1_Wav\CLD\LF\CLD_2591LF_20210714T043000_0151_0.wav';
        minute=3;
        second=29.5;
        ptime=datetime(2021,07,14,4,30+minute,second);
        fmin = 40;
        fmax = 150;
        duree=1;
end
