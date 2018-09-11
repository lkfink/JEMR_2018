% Coherence T-Test
% LF started 20180308

params = attmap_eyes_globals;
LOAD_ANALYSIS = 0;

% Load analysis results
if LOAD_ANALYSIS
    fstub = 'pup_mod_cohere.mat';
    sprintf('Loading %s', fstub)
    load(fullfile(fpath, fstub))
    fprintf('Finished loading: %s', fstub)
    
    fstub = 'null_cpsds.mat';
    sprintf('Loading %s', fstub)
    load(fullfile(fpath, fstub))
    fprintf('Finished loading: %s', fstub)
    
    % Load model data
    fstub = 'MPP_pup.mat'; % the mat is called rp
    sprintf('Loading %s', fstub)
    load(fullfile(fpath, fstub))
    fprintf('Finished loading: %s', fstub)
end


%% Get peak freqs for each model prediction
% stims = mod_fft.stim;
% for istim = 1:length(stims)
%     currstim = stims{istim};
%     stimmask = strcmp(currstim, mod_fft.stim);
%     freqmask = mod_fft.fvals{stimmask} < 2;
%     mod_fft.peaks{stimmask} = findpeaks(mod_fft.power{stimmask}(freqmask));
% end % stim

%NOTES: stim labels vs. stimnames, number of peaks determined by plot with
%automatic aes (not the one that actually went into the paper) because when
%scaling all to same axes, lose sight of some peaks.
mod_fft.peaks{4} = [mod_fft.power{4}(3), mod_fft.power{4}(5), mod_fft.power{4}(7), mod_fft.power{4}(9)];
mod_fft.peaks{2} = [mod_fft.power{2}(3), mod_fft.power{2}(5), mod_fft.power{2}(7), mod_fft.power{2}(9)];
mod_fft.peaks{3} = [mod_fft.power{3}(3), mod_fft.power{3}(5)];
mod_fft.peaks{1} = [mod_fft.power{1}(3), mod_fft.power{1}(5), mod_fft.power{1}(7), mod_fft.power{1}(9)];
mod_fft.peaks{5} = [mod_fft.power{5}(3), mod_fft.power{5}(5), mod_fft.power{5}(7), mod_fft.power{5}(9)];    

%% Loop through all data and take coherence estimate at each each model-predicted peak freq. 
subs = unique(pup_mod_cohere.subject);
badsub = 'brian2'; % can't use this data because not enough to calculate null
badind = strcmp(badsub, subs);
subs(badind) = [];
cmp_tn = table;
maxfreq = 2; % do not look at peak freqs over 2Hz because physiologically irrelevant
nr = 1;

for isub = 1:numel(subs)
    currsub = subs(isub);
    submask_t = strcmp(pup_mod_cohere.subject, currsub);
    submask_n = strcmp(null.sub, currsub);
    
    for istim = 1:length(params.stimnames2)
        currstim = params.stimnames2{istim};
        stimmask_t = strcmp(pup_mod_cohere.stim, currstim);
        compmask_t = submask_t & stimmask_t;
        %stimmask_rp = strcmp(rp.stim, currstim);
        stimmask_mod = strcmp(currstim, mod_fft.stim);
        
        % Get peak freqs for this stim
        % TODO change
%         peaks = rp.peakFreqs{stimmask_rp};
%         peaks = peaks(find(peaks <= maxfreq));
        peaks = mod_fft.peaks{stimmask_mod};
        for ipeak = 1:length(peaks)
            currpeak = peaks(ipeak);
            
            if sum(compmask_t) == 1
                % Grab coherence value at this freq
                freqmask = find(pup_mod_cohere.F{compmask_t} >= currpeak); % need to do >= and take first element because peak freq does not exactly match freq resolution of fft % TODO CHECK it should now after new way of calculating model prediction
                freqind = freqmask(1);
                cmp_tn.stimulus{nr,1} = currstim;
                cmp_tn.subject(nr,1) = currsub;
                cmp_tn.peak(nr,1) = currpeak;
                cmp_tn.true(nr,1) = pup_mod_cohere.true_cohere{compmask_t}(freqind);
                cmp_tn.null(nr,1) = null.cohere{submask_n}(freqind);
                
                nr = nr+1;
            else
                continue
            end
        end % peaks
        
    end %stim
end%sub

%% Get average true and null for each sub
nr = 1;
avg_tn = table;
for isub = 1:length(subs)
    submask = strcmp(cmp_tn.subject, subs{isub});
    % get avergage true and null
    avg_tn.sub{nr,1} = subs{isub};
    avg_tn.true(nr,1) = mean(cmp_tn.true(submask));
    avg_tn.null(nr,1) = mean(cmp_tn.null(submask));
    nr = nr+1;
end % sub

%% Calculate T statistic
[h,p,ci,stats] = ttest(avg_tn.true, avg_tn.null);
truemean = mean(avg_tn.true);
truestd = std(avg_tn.true);
nullmean = mean(avg_tn.null);
nullstd = std(avg_tn.null);
