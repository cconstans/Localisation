function [angle, dist] = getRealAngle(arrID , lat, lon)
% This return the real azimut of a known location
% [angle, dist] = getRealAngle(arrID , lat, lon)
% [angle, dist] = getRealAngle(arrLoc , lat, lon)

if ischar(arrID )
    
arrLoc = getArrInfo(arrID);

[dist,angle,~] = m_idist(arrLoc(2),arrLoc(1),lon,lat);

else
    
arrLoc = arrID;    
[dist,angle,~] = m_idist(arrLoc(2),arrLoc(1),lon,lat);

end

% Realign data into column
angle = arrIncol(angle);
dist = arrIncol(dist);

end
