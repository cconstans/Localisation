function [fileName wavID] = getWavName(dateIn, folder,typeHL)
%This load your wave file by specifying the folder, date and time
%fileName = getWavName(datetime(2021,07,15,14,37,00),mypath)
%
%dateIn

%Loading folder and files informations
dirInfo = dir(folder);
dirInfo([dirInfo.isdir]) = [];
fileList = {dirInfo.name};


% keep only the wav file
i2erase = [];
for i=1:numel(fileList)
    %         splitName = strsplit(fileList{i}, '_');
    %
    %         if strcmp(fileList{i}(end-2:end),'wav') == 0
    %             i2erase = [i2erase i];
    %         elseif ~strcmp(splitName{2} , typeHL) && ~strcmp(splitName{2} ,['2591' typeHL])
    %             i2erase = [i2erase i];
    %         end
    if isempty(strfind(fileList{i},'wav'))
        i2erase = [i2erase i];
    elseif isempty(strfind(fileList{i},typeHL))
        i2erase = [i2erase i];
    end
end

% Erase non-wav file
fileList(i2erase)  = [];

% numer of file
nbF = length(fileList);

%Getting time from name
for i=1:nbF
    splitName = strsplit(fileList{i}, '_');
    dateString = splitName{3};
    formatIn = 'yyyymmddThhMMss';
    dateN = datenum(dateString,formatIn);
    dateT(i,1) = datetime(dateN,'ConvertFrom', 'datenum');
    id{i} = splitName{4};
end

%Find the file
if ~exist('dateT')
    error('Couln''t find any wav file corresponding.')
end

for i=1:length(dateIn)
    
    % Check if need to load another file
    bolTime =  dateT >= dateIn(i);
    
    if any(bolTime) == 1
        iFile(i) = find(bolTime, 1, 'first') - 1;
    elseif dateT(end) + minutes(4.99) >  dateIn(i)
        iFile(i) = length(dateT);
    else
        error('Couldnt load the file!')
    end
    
    % Check is file actually exist
    %disp('Check function here in getWavName')
    if iFile(i) == 0
        error('Error in bringRead.m. Request time is not in the folder.')
    end
end

%iFile = unique(iFile);
%output name
fileName = fileList(iFile)';
wavID = id(iFile);
end



