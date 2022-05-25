%%%%%%%%%%%%
Calcul positions hydrophones
%%%%%%%%%%%%

calc_hydro_positions: Calcul des positions des hydrophones en fonction des temps d'arriv�e de 2
signaux dont les positions [Ri, theta_i] sont connues, donn�es virtuelles.

calc_hydro_reel_v5: Calcul des positions des hydrophones (AAV, CLD, MLB ou PRC) en fonction
des donn�es AIS de bateaux d'opportunit�s selectionn�s pour leur fort
signal, compar�es aux signaux enregistr�s sur leur p�riode de passage.

calc_hydro_reel_v6: idem, avec prise en compte de la distance dans le fir des lags et 
possibilit� de changer l'hydrophone de r�f�rence pour calculer les lags.

calc_hydro_reel_NS: Calcul des positions des hydrophones PRC et MLB en fonction des donn�es AIS de
bateaux d'opportunit�s selectionn�s sur un axe Nord-Sud, compar�es aux
signaux enregistr�s sur leur p�riode de passage.

getWavName: liste les fichiers wav d'un dossier et les infos arrLoc, type (LF/HF), ID et date.

readBring: retourne l'audio, freq d'�chantillonage, infos d'un fichier wav. 

%%%%%%%%%%%%
Beamforming
%%%%%%%%%%%%

locate_ship:  Estimation de l'azimuth d'un bateau � partir des enregistrements des hydrophones sur
une plage de temps d�finie et comparaison avec les donn�es AIS.
Appelle le script de beamforming mainBring

locate_ship_remove_hydros: idem, sans consid�rer certains hydrophones � d�finir. Appelle mainBring_remove_hydros.

mainBring: ex�cute le beamforming.
mainBring_remove_hydros:  idem, sans consid�rer certains hydrophones � d�finir.
showBring: affiche les figures pendant le beamforming

get_ship_info: donne les infos de passage d'un bateau (temps, donn�es AIS etc).

locate_whale:  Estimation de l'azimuth d'un c�tac� � partir des enregistrements des hydrophones sur
une plage de temps choisie.
Le beamforming est inclus dans ce script.

%%%%%%%%%%%%
Localisation
%%%%%%%%%%%%

estim_ship_loc_MLB_PRC: A partir des r�sultats de beamforming des 2 sites PRC et MLB pour un m�me
bateau, donnant chacun une direction par rapport au site, calcul de la position du bateau.

estim_ship_loc_AAV_CLD: A partir des r�sultats de beamforming des 2 sites AAV et CLD pour un m�me
bateau, donnant chacun une direction par rapport au site, calcul de la position du bateau.

estim_whale_loc:  A partir des r�sultats de beamforming sur 2 sites AAV et CLD pour un m�me
signal re�u de c�tac�, donnant chacun une direction par rapport au site, calcul de la position de l'animal.


%%%%%%%%%%%%
Figures & vid�os
%%%%%%%%%%%%

video_AIS: Cr�ation d'un film du passage d'un bateau � partir des donn�es AIS. 
Appelle la fonction quick_Map_video et n�cessite le package m_map.

video_AIS_estim: Cr�ation d'un film du passage d'un bateau � partir des donn�es AIS et de
la localisation estim�e par beamforming. 
Appelle la fonction quick_Map_video_result et n�cessite le package m_map.

Dossier figures article loc array: fonctions et figures pour l'article.
