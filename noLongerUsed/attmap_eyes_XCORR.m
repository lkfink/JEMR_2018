% Script to calculate cross correlation between pupil time series and model
% output

% 29 June 2016 - LF + PJ

% Make sure necessary data is loaded 
loadData = 1;
if loadData
    %load IOIpup and attmap_v1p2_stim_rp_analysis.mat
    load('IOIpup.mat');
    load('an.mat');
    % /Volumes/CorpusData1/attmap/attmap_v1p2/matfiles
    %load('/Volumes/CorpusData1/attmap/attmap_v1p2/matfiles/attmap_v1p2_stim_rp_analysis.mat');
else
end

% Get model time series of interest, in proper orientation
model_output = an{1,3}.results.data{1,2};
for j = 1:length(model_output)
    model_output{j} = model_output{j}';
end

% Get stim labels of model output in proper format (need to remove .wav
% extension)
model_labels = an{1,3}.results.data{1,1};
for j = 1:length(model_labels)
    model_labels{j} = model_labels{j}(1:end-4); % remove .wav extensions as it is incongruent with labelling in IOIpup
end


% Initialize variables
devMask = cellfun(@isempty, IOIpup.noDevMean);
subids = unique(IOIpup.subject_id(~devMask));
nsubs = numel(unique(subids));
outvar = table;
nr = 0;
[b,a] = butter(8,0.16,'low'); %40/250
%freqz(b,a) %if want to image filter

% for isub
for isub = 1:nsubs
    currsub = subids(isub);
    submask = strcmpi(IOIpup.subject_id, currsub); % create sub mask
    stimids = unique(IOIpup.stimulus_id(submask)); % get stim names for this sub (some subs might not have completed all
    % runs)
    nstims = numel(unique(stimids));

    % for istim
    for istim = 1:nstims
        nr = nr+1;
        currstim = stimids(istim);
        stimmask = strcmpi(IOIpup.stimulus_id, currstim); %create stim mask to index IOIpup
        model_stimmask = strcmpi(model_labels, currstim);
        
        % Create mask to subset sub, stim, no dev data
        compmask = submask & stimmask & ~devMask;
        
        % Get both signals of interest in proper format
        pupData = IOIpup.noDevMean{compmask}; %isolate pupil data of interest
        pupData = pupData(1000:end); % because 1000 preloop samps when created - ADDED THIS 10/09/16
        % might want to cut off on end since created with 2000 samples
        % after loop onset (4 secs). cut it in half but find exact number?

        % pupData = resample(pupData,1,5); % resample pupil data - this
        % does not get signal near length that I need
        pupData = filtfilt(b,a,pupData); %lowpass filter
        pupData = downsample(pupData,5); %downsample to 100Hz to match Fs of model output
        
        modelData = model_output{model_stimmask}; %isolate model data of interest
        M = numel(modelData);
        pupData = pupData(1:M); % make sure pup signal = length of model output
        
        % Output basic data
        outvar.subject_id(nr,1) = currsub;
        outvar.stimulus_id(nr,1) = currstim;
            
        % Calculate and output xcorr of pupil response to Stim A with Model output for Stim A,
        % etc.  This is the diagonal of the matrix of possible pupil/stimulus
        % waveform combinations.
        %[outvar.xcorr(:,istim), outvar.lags(:,istim)] = xcorr(pupData, modelData);
        [xc, lags] = xcorr(pupData, modelData, 'coeff');  % pupil lagging will be at positive lags
        
        
        outvar.xcorr{nr,1} = xc;
        outvar.lags{nr,1} = lags;
        
        % Find the bin number (and time, tau) of the best lag. Only do this for the side of the xcorr result that corresponds to pupil lagging model
        % Want to only take positive lags (we know pupil should be delayed
        % relative to stimulus). Since xcorr returns 2*M-1 rows, 0 lag is at row M
        useLagIndices = find(lags >= 0); 
        %useLagIndices = 1:length(lags); 10/09/16 why was this here?!
        
        [~,I] = max(xc(useLagIndices));

        outvar.lagSamps(nr,1) = useLagIndices(I)-find(lags == 0); %lag in samples
        

    end % end for istim



end % end for isub

outvar.lagTime = outvar.lagSamps/100; %divide by Fs



% Look at distribution of all lags for all subjects and stimuli, or look at
% distribution of subject-mean lags across subjects. Based on this
% distribution, you can now choose a single lag (or small range of lags
% that you would then average over) to use when calculating your null
% distribution 
figure()
nbins = 50;
subplot(1,2,1)
hist(outvar.lagTime,nbins); % all lags for all subs and stims
xlabel('Time (in sec)')
ylabel('Number of Runs')
title('All lags across subs and stims')
subplot(1,2,2)
hist(mean(outvar.lagTime),nbins); % mean lags for all subs and stims
xlabel('Time (in sec)')
ylabel('Number of Subjects')
title('Mean lags for all subs and stims')

stimids = unique(outvar.stimulus_id); % mean lag by stim
figure()
for i = 1:numel(stimids)
    currstim = stimids(i);
    stimmask = strcmpi(outvar.stimulus_id, currstim);
    subplot(1,numel(stimids),i)
    hist(outvar.lagTime(stimmask));
    xlabel('Time (in sec)')
    ylabel('Number of Subjects')
    title(currstim, 'interpreter', 'none')
end % mean lag by stim plot
suptitle('Subject lags for each stim')


% ----------------------------------------------------------------------- %
% Determine most appropriate lag to use
% Now get the mean or median lag for the subject
%outvar.meanLag(nr,1) = mean(outvar.timeDiff(strcmpi(outvar.subject_id, currsub)));
%outvar.medianLag(nr,1) = median(outvar.timeDiff(strcmpi(outvar.subject_id, currsub)));

% bestLag = mean(outvar.meanLag); 

% for isub
for jsub = 1:nsubs
    currsub = subids(jsub);
    submask = strcmpi(IOIpup.subject_id, currsub);
    stimids = unique(IOIpup.stimulus_id(submask));

    % for istim (pupil response, i.e. rows in our matrix)
    for jstim = 1:numel(stimids)
        currstim = stimids(jstim);
        stimmask = strcmpi(IOIpup.stimulus_id, currstim);
        compmask = ~devMask & submask & stimmask;
        
        model_stimmask = strcmpi(model_labels, currstim);
        
        
        
        % for jstim (model output, i.e. columns)
        
        
        % Calculate correlation at the specific lag
        %[icorr, ilag] = xcorr(pupData, modelData, bestLag);
        % 
        % when istim == jstim, this is what you've already calculated above, i.e.
        % part of the veridical distribution.
        % when istim ~= jstim, this is a label-shuffled value for the null
        % distribution
        
        % end for jstim
        
    end % end for istim

% You now have your null distribution for this subject

end % end for isub

% You now have your overall null distribution. You can generate a plot of
% your null distribution and your veridical distribution

% histscale = [-1:0.05:1]
% nullHist = hist(nullcorrs, histscale)
% veridHist = hist(veridcorrs, histscale)

% bar(histscale, [nullHist, veridHist])

% Prior to calculating a parametric statistic, e.g. ANOVA or ttest, you
% have to convert the correlation values into z values using the Fisher
% r-to-z transform
% x = fisher_r2z(data);

% You can now run an ANOVA to see whether your null and veridical
% distributions differ.

% Create linear model
% LM = FITLM(data..)

% Run ANOVA
% TBL = anova(LM);
% ANOVAsummary = anova(LM, 'summary');