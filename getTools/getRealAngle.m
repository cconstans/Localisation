function [angle, dist] = getRealAngle(arrID , lat, lon)
% This return the real azimut of a known location
% [angle, dist] = getRealAngle(arrID , lat, lon)
% [angle, dist] = getRealAngle(arrLoc , lat, lon)

if ischar(arrID )
    
    switch lower(arrID)
        case 'aav'
            arrLoc = [49.0907 -64.5372];
        case 'mlb'
            arrLoc = [48.6039 -64.1863];
        case 'prc'
            arrLoc= [48.5311 -64.1983];
        case 'cld'
            arrLoc = [49.1933  -64.8315];
    end
    
    [dist,angle,~] = m_idist(arrLoc(2),arrLoc(1),lon,lat);
    
else
    
    arrLoc = arrID;
    [dist,angle,~] = m_idist(arrLoc(2),arrLoc(1),lon,lat);
    
end

% Realign data into column
angle = arrIncol(angle);
dist = arrIncol(dist);

end
