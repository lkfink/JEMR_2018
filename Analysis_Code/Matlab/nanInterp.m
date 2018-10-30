% Lauren Fink (lkfink@ucdavis.edu)
% Janata Lab, UC Davis Center for Mind & Brain
% 20170719

% LF -20180122 - revised for general purposes

% Function to interpolate over null pupil data
% creates sliding window of nsamps around any missing data to remove
% edge artifiacts

% Input: 
% - Data to be interpolated
% - Number of samples for window of removal on both sides of missing data 
%    --- often some time on both sides of blink should be removed. (try 
%        20-100ms -- be sure to set this in terms of your sampling rate)
%    --- visual inspection of the data is often the best way to figure out 
%        how many samples you need here, as different eye-trackers correct
%        for blink events differently. 
% - Max deviation between adjacent samples (e.g. 2 std devs away from mean)

% Output: 
% - Interpolated data
% - Percentage of data interpolated 

function [interpolatedData, percentInterpolated] = nanInterp(data, nsamps, maxDev)

badIdxs = logical(isnan(data)); % find all places in data that go to zero (blink)

% Find all places in data where > maxDev unit deviation between samples
for isamp = 1:length(data)-1
    if data(isamp+1) >= data(isamp)+maxDev
        % flag this sample
        badIdx = isamp+1;
        badIdxs(badIdx) = 1;
    end
end % samps

% Set all instances of bad data to NaN
data(badIdxs) = NaN;

% Find all NaN indices in data and pad them with more NaNs according to 
% the number of samples specified by user
NaN_idxs = find(isnan(data));
for iNaN = 1:length(NaN_idxs)
    currNaN = NaN_idxs(iNaN);
    run_endIdx = length(data);
    
    % Create sliding window of NaNs to deal with artifactual data
    % on both sides of current NaN
    cleanStart = currNaN-nsamps; 
    cleanEnd = currNaN+nsamps;
    if cleanStart <= 0 % outside of range
        continue % to next NaN idx
    elseif cleanEnd >= run_endIdx-nsamps
        break
    else
        data(cleanStart:cleanEnd) = NaN;
    end
    
end %NaNidxs

% Keep track of how much data will be interpolated 
percentInterpolated = (sum(isnan(data))/length(data))*100;

% Interpolate over NaNs
timeVector = 1:length(data);
goodmask = ~isnan(data);
interpolatedData = interp1(timeVector(goodmask),data(goodmask),timeVector);

% Check for NaNs at end of data
if any(isnan(interpolatedData))
    if isnan(interpolatedData(end)) %NaNs at end
        interpolatedData(isnan(interpolatedData)) = 0;
        % ^ zeroing this out as NaNs cannot be used in future analyses and
        % data must remain the same length. 
        fprintf('fixed NaNs at end of run')
    elseif isnan(interpolatedData(1)) % NaN at beginning
        interpolatedData(isnan(interpolatedData)) = 0;
    else
        error('NaN in interpolated data!')
    end
    
end


end % function
