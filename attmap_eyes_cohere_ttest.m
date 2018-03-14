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
        stimmask_rp = strcmp(rp.stim, currstim);
        
        % Get peak freqs for this stim
        peaks = rp.peakFreqs{stimmask_rp};
        peaks = peaks(find(peaks <= maxfreq));
        for ipeak = 1:length(peaks)
            currpeak = peaks(ipeak);
            
            if sum(compmask_t) == 1
                % Grab coherence value at this freq
                freqmask = find(pup_mod_cohere.F{compmask_t} >= currpeak); % need to do >= and take first element because peak freq does not exactly match freq resolution of fft
                freqind = freqmask(1);
                cmp_tn.stimulus{nr,1} = currstim;
                cmp_tn.subject{nr,1} = currsub;
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

%% Calculate T statistic
[h,p,ci,stats] = ttest(cmp_tn.true, cmp_tn.null);
truemean = mean(cmp_tn.true);
truestd = std(cmp_tn.true);
nullmean = mean(cmp_tn.null);
nullstd = std(cmp_tn.null);
