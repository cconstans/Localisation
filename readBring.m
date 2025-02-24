function [Y,Fs,tstart,dura,test] = readBring(fileName, time,  varargin)
% [Y,Fs,tstart,dura] = bringRead(fileName, time,  10, 'duration', 10, 'buffer',1)


% Default parameter
dura =15;
buffer = 1;
power2 = true;



%% Varagin
while ~isempty(varargin)
    switch lower(varargin{1})
        case 'duration'
            dura = varargin{2};
        case 'buffer'
            buffer = varargin{2};
        case 'power2'
            power2 =varargin{2};
        otherwise
            error(['Can''t understand property: ' varargin{1}])
    end
    varargin(1:2)=[];
end
%%

% Read the file
ainfo = audioinfo(fileName);
Fs = ainfo.SampleRate;
%[Y,Fs] = audioread(fileName);

% Check the power2 restriction
if power2 == true
   if floor(sqrt((dura) *Fs))
      Nssq =  floor(sqrt((dura) *Fs)) +1;
   else
       Nssq = floor(sqrt((dura) *Fs));
   end
   Ns =  Nssq^2;
   dura = Ns / Fs;
else
    Ns = floor(dura * Fs);
end

% Get the begiining of the file
[filepath,name] = fileparts(fileName);
ftime = getFileTime(name);

% Start and end time
start = time - ftime;
tstart = ftime + start;
istart = max(1,floor((seconds(start) - buffer) * Fs)) ;
iend = istart + Ns -1;


if istart > 0 && iend < ainfo.TotalSamples
    [Y,Fs] = audioread(fileName,[istart iend]);
    %Y = Y(istart:iend,:);
elseif istart < 0
   % Loading the first file
   [fileName2 wavID] = getWavName(time - seconds(dura), fileparts(fileName),filepath(end-1:end)); 
   [Y1,Fs1] = audioread([filepath '/' char(fileName2)],[ainfo.TotalSamples + istart ainfo.TotalSamples]);
    
   [Y2,Fs2] = audioread(fileName,[1 iend]);
    
   Y = [Y1; Y2];
    
else  % Need to open next audio file
    
    % Find how many sample are over
    overSample = iend - ainfo.TotalSamples;
    
    % Loading the first file
    [Y1,Fs1] = audioread(fileName,[istart ainfo.TotalSamples]);
    
    [fileList wavID] = getWavName(time + seconds(dura), fileparts(fileName),filepath(end-1:end));
    [Y2,Fs2] = audioread(fileName,[1 overSample]);
    
    Y = [Y1; Y2];
    
end


end