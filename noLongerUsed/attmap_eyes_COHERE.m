% Calculate the coherence between model output and each no dev pupil trial, for
% each stim

% 30 June 2016 - LF + PJ
loadData = 0;

% Make sure necessary data is loaded 
if loadData
    %load IOIpup and attmap_v1p2_stim_rp_analysis.mat
    load('noDevTBL.mat');
    load('an.mat');
    % /Volumes/CorpusData1/attmap/attmap_v1p2/matfiles
    %load('/Volumes/CorpusData1/attmap/attmap_v1p2/matfiles/attmap_v1p2_stim_rp_analysis.mat');
else
end

% Get model time series of interest
model_output = an{1,3}.results.data{1,2};

% Get stim labels of model output in proper format (need to remove .wav
% extension)
model_labels = an{1,3}.results.data{1,1};
for j = 1:length(model_labels)
    model_labels{j} = model_labels{j}(1:end-4); % remove .wav extensions as it is incongruent with labelling in IOIpup
end

% Initialize variables
subids = unique(noDevTBL.subject_id);
nsubs = numel(subids);
cleanedNoDevTBL = table;
cleanedModelData = table;
outCohere = table;
nr = 0;
cr = 0;
[b,a] = butter(8,0.16,'low'); %40/250 %freqz(b,a) %if want to image filter


% For isub
for isub = 1:nsubs
    currsub = subids(isub);
    submask = strcmpi(currsub, noDevTBL.subject_id);
    
    stimids = unique(noDevTBL.stimulus_id(submask));
    nstims = numel(stimids);

    % For istim
    for istim = 1:nstims
        cr = cr+1;
        currstim = stimids(istim);
        stimmask = strcmpi(currstim, noDevTBL.stimulus_id);
        model_stimmask = strcmpi(currstim, model_labels);
        modelData = model_output{model_stimmask}';
        
        % Get noDev all noDev trials for each sub in workable format
        ntrials = length(noDevTBL.noDevData(stimmask & submask));
        filtTrialData = zeros(ntrials,1);
        for itrial = 1:ntrials
            nr = nr+1;
            trialData = noDevTBL.noDevData{itrial};
            
            % Filter, downsample, make length of model_stim output
            trialData = filtfilt(b,a,trialData);
            trialData = downsample(trialData,5);
            trialData = trialData(1:length(modelData))'; %In the future, it 
            % may be worth considering whether to take keep more time on the end and 
            % delete from beginning (because pupil is likely delayed
            % compared to stim.. however this introduces additional
            % assumptions)
            
            % Zero-pad to 256 + save
            outTdata = zeros(256,1);
            outTdata(1:length(trialData)) = trialData;
            
            cleanedNoDevTBL.subject_id(nr,1) = currsub;
            cleanedNoDevTBL.stimulus_id(nr,1) = currstim;
            cleanedNoDevTBL.trialdata{nr,1} = outTdata;
            

        
        end % fixing each trial's data (we are still on same stim)
        
        % zero pad and save model data
        outMdata = zeros(256,1);
        outMdata(1:length(modelData)) = modelData;
        
        cleanedModelData.stimulus_id(cr,1) = currstim;
        cleanedModelData.modelData{cr,1} = outMdata;
        
        % String together pupil data  and model data 
        outsubmask = strcmpi(currsub,cleanedNoDevTBL.subject_id);
        outstimmask = strcmpi(currstim,cleanedNoDevTBL.stimulus_id);
        pupDataString = vertcat(cell2mat(cleanedNoDevTBL.trialdata(outsubmask & outstimmask)));
        %plot(pupDataString) % is it ok that zero padding introduces
        %weirdnesses?
        
        modelDataString = repmat(outMdata,ntrials);
        modelDataString = modelDataString(:,1); %only keep what needed 
        %figure()
        %plot(modelDataString)
        %hold on
        %plot(pupDataString);
        
        
        % Calculate and save coherence and pwelch against model
        fprintf('Calculating coherence for %s, %s . . . \n', subids{isub}, stimids{istim})
        outCohere.subject_id(cr,1) = currsub;
        outCohere.stimulus_id(cr,1) = currstim;
        %pwelch(data,window,noverlap,nfft, (must be smaller than window)   %could chage spectrum type from 'psd' to
        %'power' %can also specify 'ConfidenceLevel', P %can also specify
        %freqrange and one-sided, two-side, centered
        % [pxx, F] = pwelch.. return freq info
        ourWindow = ones(256,1);
        Fs = 100;
        nfft = 256;
        noverlap = 0;
        
        % Calculate the frequency spectrum
        outCohere.pwelchPup{cr,1} = pwelch(pupDataString, ourWindow, noverlap,nfft, Fs); 
        
        % Coherence
        outCohere.mscohere{cr,1} = mscohere(pupDataString, modelDataString, ourWindow, noverlap, nfft, Fs);

    end % End istim
    
end % End isub


% Inspect outCohere data
figure() %mscohere
for istim = 1:nstims
    currstim = stimids(istim);
    stimmask = strcmpi(currstim, outCohere.stimulus_id);
    subplot(2,2,istim)
    plot(cellfun(@mean,outCohere.mscohere(stimmask)))
    xlabel('Frequency (Hz)')
    ylabel('Magnitude-Squared Coherence')
    title(currstim)
end %stim


figure() %pwelch
for istim = 1:nstims
    currstim = stimids(istim);
    stimmask = strcmpi(currstim, outCohere.stimulus_id);
    subplot(2,2,istim)
    plot(cellfun(@mean,outCohere.pwelchPup(stimmask)))
    xlabel('Frequency (Hz)')
    ylabel('Power/Frequency (dB/Hz)')
    title(currstim)
end %stim


% ----------------------------------------------------------------------- %

% Calculate coherence for shuffled pupil data, except the the stimulus
% being compared to model

% For isub

% For istim

% Shuffle saved padded data for all except istim

% Calculate and save coherence and pwelch against model

% End istim

% End isub

