function dateT = getFileTime(fileName,varargin)
% Get the time associated with a wav file
% time = getFileTime(fileName,'formatin','yyyymmddThhMMss')
% Default value
cellNumber = 3;
formatIn = 'yyyymmddThhMMss';
spacer = '_';

%% Varagin
while ~isempty(varargin)
    switch lower(varargin{1})
        case 'cellnumber'
            cellNumber = varargin{2};
        case 'formatin'
            formatin = varargin{2};
        case 'spacer'
            spacer = varargin{2};
        otherwise
            error(['Can''t understand property: ' varargin{1}])
    end
    varargin(1:2)=[];
end

% This function return time and date associated with a file
splitName = strsplit(fileName, '_');
dateString = splitName{cellNumber};

dateN = datenum(dateString,formatIn);
dateT = datetime(dateN,'ConvertFrom', 'datenum');
end