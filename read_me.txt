%%%%%%%%%%%%
Calcul positions hydrophones
%%%%%%%%%%%%

calc_hydro_positions: Calcul des positions des hydrophones en fonction des temps d'arrivée de 2
signaux dont les positions [Ri, theta_i] sont connues, données virtuelles.

calc_hydro_reel_v5: Calcul des positions des hydrophones (AAV, CLD, MLB ou PRC) en fonction
des données AIS de bateaux d'opportunités selectionnés pour leur fort
signal, comparées aux signaux enregistrés sur leur période de passage.

calc_hydro_reel_v6: idem, avec prise en compte de la distance dans le fir des lags et 
possibilité de changer l'hydrophone de référence pour calculer les lags.

calc_hydro_reel_NS: Calcul des positions des hydrophones PRC et MLB en fonction des données AIS de
bateaux d'opportunités selectionnés sur un axe Nord-Sud, comparées aux
signaux enregistrés sur leur période de passage.

getWavName: liste les fichiers wav d'un dossier et les infos arrLoc, type (LF/HF), ID et date.

readBring: retourne l'audio, freq d'échantillonage, infos d'un fichier wav. 

%%%%%%%%%%%%
Beamforming
%%%%%%%%%%%%

locate_ship:  Estimation de l'azimuth d'un bateau à partir des enregistrements des hydrophones sur
une plage de temps définie et comparaison avec les données AIS.
Appelle le script de beamforming mainBring

locate_ship_remove_hydros: idem, sans considérer certains hydrophones à définir. Appelle mainBring_remove_hydros.

mainBring: exécute le beamforming.
mainBring_remove_hydros:  idem, sans considérer certains hydrophones à définir.
showBring: affiche les figures pendant le beamforming

get_ship_info: donne les infos de passage d'un bateau (temps, données AIS etc).

locate_whale:  Estimation de l'azimuth d'un cétacé à partir des enregistrements des hydrophones sur
une plage de temps choisie.
Le beamforming est inclus dans ce script.

%%%%%%%%%%%%
Localisation
%%%%%%%%%%%%

estim_ship_loc_MLB_PRC: A partir des résultats de beamforming des 2 sites PRC et MLB pour un même
bateau, donnant chacun une direction par rapport au site, calcul de la position du bateau.

estim_ship_loc_AAV_CLD: A partir des résultats de beamforming des 2 sites AAV et CLD pour un même
bateau, donnant chacun une direction par rapport au site, calcul de la position du bateau.

estim_whale_loc:  A partir des résultats de beamforming sur 2 sites AAV et CLD pour un même
signal reçu de cétacé, donnant chacun une direction par rapport au site, calcul de la position de l'animal.


%%%%%%%%%%%%
Figures & vidéos
%%%%%%%%%%%%

video_AIS: Création d'un film du passage d'un bateau à partir des données AIS. 
Appelle la fonction quick_Map_video et nécessite le package m_map.

video_AIS_estim: Création d'un film du passage d'un bateau à partir des données AIS et de
la localisation estimée par beamforming. 
Appelle la fonction quick_Map_video_result et nécessite le package m_map.

Dossier figures article loc array: fonctions et figures pour l'article.
