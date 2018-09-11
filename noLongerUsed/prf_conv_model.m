% Function to perform convolution between pupillary response function (PRF)
% and impluse train, correlate that convolution with real pupil data,
% compared that correlation value to a bootstrapped correlation value if
% the impulse train had been shuffled 
% LF - 12-1-2016

% 12-7 - this is not right because impulses is continuous and needs to be
% discrete for shuffling - think it is now fixed
% 12-7 - need impulses and pupil data to be column (vertical) vector e.g.
% 1120,1; not 1,1120. 

function [prediction, r, bootstrap_corrs] = prf_conv_model(PRF,impulses,pupil_data)

% constants
iters = 200; % change to more after debugging

% first check that pupil data is column vector
if ~iscolumn(pupil_data)
    pupil_data = pupil_data';
else
end

% convolve PRF with impulse train
prediction = conv(impulses, PRF, 'same');

% make sure prediction is column vector before doing corr 
if ~iscolumn(prediction)
    prediction = prediction';
else
end

% make sure prediction and pupil data are same length..
% TODO

% compute correlation between predicted and real pupil time series 
r = corr(prediction, pupil_data); % might want this to be corrcoef

bootstrap_corrs = zeros(iters,1); % hold correlations here

% Shuffle impulse train
for iiter = 1:(iters)
    idxs = find(impulses ~= 0);
    % save these ^ values
    vals = impulses(idxs);
    newidxs = randperm(numel(idxs)); % shuffle idxs
    newVals = vals(newidxs); %get new values for each idx
    % resinsert at new vals at relevant idxs
    temp_impulses = impulses;
    temp_impulses(idxs) = newVals;
    
    temp_prediction = conv(temp_impulses, PRF, 'same');
    bootstrap_corrs(iiter,1) = corr(temp_prediction, pupil_data); %issue here because result of corr is huge and full of NaNs..
end %iters

end % function


