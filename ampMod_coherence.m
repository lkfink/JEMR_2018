% concatenated script to do coherence analyses for amp env vs model
% 20180821 - Lauren Fink (lkfink@ucdavis)
% Janata Lab, UC Davis, Center for Mind & Brain 

params = attmap_eyes_globals;
fpath = params.paths.matpath;
LOAD_DATA = 1;

% Variables below must be loaded to run coherence analysis
if LOAD_DATA
    % Load pupil data table
    fstub = 'pupdata.mat';
    sprintf('Loading %s', fstub)
    load(fullfile(fpath, fstub))
    fprintf('Finished loading: %s', fstub)
    
    fstub = 'LoopTable2.mat';
    sprintf('Loading %s', fstub)
    load(fullfile(fpath, fstub))
    fprintf('Finished loading: %s', fstub)
    
    % Load model data
    fstub = 'MPP_pup.mat'; % the mat is called rp
    sprintf('Loading %s', fstub)
    load(fullfile(fpath, fstub))
    fprintf('Finished loading: %s', fstub)
    
    % Load amp env stuff
    fstub = 'stim_ampEnv.mat'; 
    sprintf('Loading %s', fstub)
    load(fullfile(fpath, fstub))
    fprintf('Finished loading: %s', fstub)
end

%% Load PRF for convolution with model output
Fs = 100;
motor = 0;
PRF = genPRF(Fs, motor);


%% Create new table that is pupil and model data we want
nloops = 160; % number of pupil loops we want to take for each stim
% NOTE: number of loops not equal for each stim. This is safe number to
% take.
subs =  unique(loopTable2.subject_id);
pup_mod_cohere_2 = table;
nr = 1;
for isub = 1:length(subs)
    currsub = subs(isub);
    submask = strcmp(currsub, loopTable2.subject_id);
    
    for istim = 1:length(params.stimnames2)
        currstim = params.stimnames2{istim};
        stimmask = strcmp(currstim, loopTable2.stimulus_id);
        
        compmask = submask & stimmask;
        
        % Get appropriate loop start and end indices
        start_loop_num = 3;
        end_loop_num = nloops+start_loop_num;
        
        loop_start_ind = find(loopTable2.loop_num(compmask) == start_loop_num);
        loop_start_time = loopTable2.loop_start(loop_start_ind);
        
        loop_end_ind = find(loopTable2.loop_num(compmask) == end_loop_num);
        loop_end_time = loopTable2.loop_start(loop_end_ind);
        
        % Now mask pupdata
        stimmask_pup = strcmp(currstim, pupdata.stimulus_id);
        submask_pup = strcmp(currsub, pupdata.subject_id);
        compmask_pup = stimmask_pup & submask_pup;
        
        % Get pupil data for this sub
        % check that data for this sub was discarded due to
        % too much interpolation
        if isempty(pupdata.pupNorm(compmask_pup))
            continue
        else
            thissub_pup = pupdata.pupNorm{compmask_pup};
        end
        
        % Downsample pupil to 100 Hz for comparison with model predictions
        desiredFs = 100;
        originalFs = params.eyetracker.Fs;
        [p,q] = rat(desiredFs / originalFs);
        thissub_pup_downsampled = resample(thissub_pup,p,q);
        
        % Mask model data for this stim
        stimmask_mod = strcmp(currstim, rp.stim);
        mod_pred = rp.meanSig_peakTseries{stimmask_mod};
        
        % Extend model data for nloops
        mod_pred_ext = repmat(mod_pred, 1, nloops+1);
        mod_pred_ext = conv(mod_pred_ext, PRF, 'same');
        % Make all pup and model data the same length
        % TODO: CHECK: is this ok? or will it interfere with coherence
        % estimate? mscohere requires vectors to be same length...
        % NOTE: Have tested a few different lengths here and it does not
        % seem to change the ultimate cpsd. 35500 is safe number of samps
        % to take for all sub / stim / combos
        thissub_pup_downsampled = thissub_pup_downsampled(1:35500);
        mod_pred_ext = mod_pred_ext(1:35500);
        
        
        % Add necessary data to table
        pup_mod_cohere_2.subject(nr,1) = currsub;
        pup_mod_cohere_2.stim{nr,1} = currstim;
        pup_mod_cohere_2.pup{nr,1} = thissub_pup_downsampled;
        pup_mod_cohere_2.model{nr,1} = mod_pred_ext;
        
        nr = nr+1;
        
    end % stim
end % sub


%% Calculate true and null cpsd between Pupil and Model for each sub/stim pair

subs = unique(pup_mod_cohere_2.subject);
nr = 1;
null2 = table;


for isub = 1:length(subs)
    currsub = subs(isub);
    submask = strcmp(pup_mod_cohere_2.subject, currsub);
    
    thissub_stims = pup_mod_cohere_2.stim(submask);
    thissub_mods = pup_mod_cohere_2.model(submask);
    
    null2.pup{isub,1} = 0;
    null2.mod{isub,1} = 0;
    null2.pm{isub,1} = 0;
    
    for istim = 1:length(thissub_stims)
        currstim = thissub_stims(istim);
        stimmask = strcmp(pup_mod_cohere_2.stim, currstim);
        
        compmask_pup = submask & stimmask;
        currpup = pup_mod_cohere_2.pup{compmask_pup};
        
        for imod = 1:length(thissub_mods)
            currmod = thissub_mods{imod};
            
            % Calculate cpsd between this pup/stim and all others
            WINDOW = ceil(length(currpup)/nloops * 2);
            NOVERLAP = ceil(WINDOW/4*3);
            NFFT = WINDOW;
            Fs = 100;
            
            fprintf('Subject %d, Stimulus %d, Model %d\n', isub, istim, imod)
            [Ppm,Fpm] = cpsd(currpup,currmod,WINDOW,NOVERLAP,NFFT,Fs);
            [Ppp,Fpp] = cpsd(currpup,currpup,WINDOW,NOVERLAP,NFFT,Fs);
            [Pmm,Fmm] = cpsd(currmod,currmod,WINDOW,NOVERLAP,NFFT,Fs);
            
            % Save to table
            if istim == imod % true case
                pup_mod_cohere_2.true_cpsd_Ppm{nr,1} = Ppm;
                pup_mod_cohere_2.true_Ppp{nr,1} = Ppp;
                pup_mod_cohere_2.true_Pmm{nr,1} = Pmm;
                pup_mod_cohere_2.true_cohere{nr,1} = (abs(Ppm).^2)./(Ppp.*Pmm);
            else % all other cases
                pup_mod_cohere_2.null_cpsd_Ppm{nr,imod} = Ppm;
                pup_mod_cohere_2.null_Ppp{nr,imod} = Ppp;
                pup_mod_cohere_2.null_Pmm{nr,imod} = Pmm;
                
                null2.sub(isub,1) = currsub;
                null2.pup{isub,1} = null2.pup{isub,1} + Ppp;
                null2.mod{isub,1} = null2.mod{isub,1} + Pmm;
                null2.pm{isub,1} = null2.pm{isub,1} + Ppm;
                null2.F{isub,1} = Fpm;
            end
            
            pup_mod_cohere_2.F{nr,1} = Fpm;
            
        end % mod
        
        nr = nr+1;
        
    end % stim
    null2.cohere{isub,1} = (abs(null2.pm{isub,1}).^2)./(null2.pup{isub,1}.*null2.mod{isub,1});
    
end % sub

%% Save table
fpath = params.paths.matpath;
outfname = fullfile(fpath,'pup_mod_cohere_2');
fprintf('\nSaving mat file: %s\n', outfname)
save(outfname,'pup_mod_cohere_2', '-v7.3');
fprintf('%s saved', outfname)

outfname = fullfile(fpath,'null_cpsds_2');
fprintf('\nSaving mat file: %s\n', outfname)
save(outfname,'null2', '-v7.3');
fprintf('%s saved', outfname)


%% Calculate true and null cpsd between pupil and amp env for each sub/stim pair
subs = unique(pup_mod_cohere_2.subject);
nr = 1;
null_env = table;
pup_env_cohere = table;

for isub = 1:length(subs)
    currsub = subs(isub);
    submask = strcmp(pup_mod_cohere_2.subject, currsub);
    
    thissub_stims = pup_mod_cohere_2.stim(submask);
    for istim = 1:length(thissub_stims)
        currstim = thissub_stims(istim);
        currstim = strcat(currstim, '.wav');
        stimmask = strcmp(currstim, ampEnv.stim);
        thissub_envs{istim, 1} = ampEnv.conv_env{stimmask};
    end
    
    null_env.pup{isub,1} = 0;
    null_env.env{isub,1} = 0;
    null_env.pe{isub,1} = 0;
    
    for istim = 1:length(thissub_stims)
        currstim = thissub_stims(istim);
        stimmask = strcmp(pup_mod_cohere_2.stim, currstim);
        
        compmask_pup = submask & stimmask;
        currpup = pup_mod_cohere_2.pup{compmask_pup};
        
        for ienv = 1:length(thissub_envs)
            currenv = thissub_envs{ienv};
            
            % Calculate cpsd between this pup/stim and all others
            WINDOW = ceil(length(currpup)/160 * 2); % 160 loops
            NOVERLAP = ceil(WINDOW/4*3);
            NFFT = WINDOW;
            Fs = 100;
            
            fprintf('Subject %d, Stimulus %d, Env %d\n', isub, istim, ienv)
            [Ppe,Fpm] = cpsd(currpup,currenv,WINDOW,NOVERLAP,NFFT,Fs);
            [Ppp,Fpp] = cpsd(currpup,currpup,WINDOW,NOVERLAP,NFFT,Fs);
            [Pee,Fmm] = cpsd(currenv,currenv,WINDOW,NOVERLAP,NFFT,Fs);
            
            % Save to table
            pup_env_cohere.subject(nr,1) = currsub;
            pup_env_cohere.stim(nr,1) = currstim;
            pup_env_cohere.pup{nr,1} = currpup;
            pup_env_cohere.env{nr,1} = currenv;
            
            if istim == ienv % true case
                pup_env_cohere.true_cpsd_Ppe{nr,1} = Ppe;
                pup_env_cohere.true_Ppp{nr,1} = Ppp;
                pup_env_cohere.true_Pee{nr,1} = Pee;
                pup_env_cohere.true_cohere{nr,1} = (abs(Ppe).^2)./(Ppp.*Pee);
            else % all other cases
                pup_env_cohere.null_cpsd_Ppe{nr,ienv} = Ppe;
                pup_env_cohere.null_Ppp{nr,ienv} = Ppp;
                pup_env_cohere.null_Pee{nr,ienv} = Pee;
                
                null_env.sub(isub,1) = currsub;
                null_env.pup{isub,1} = null_env.pup{isub,1} + Ppp;
                null_env.env{isub,1} = null_env.env{isub,1} + Pee;
                null_env.pe{isub,1} = null_env.pe{isub,1} + Ppe;
                null_env.F{isub,1} = Fpm;
            end
            
            pup_env_cohere.F{nr,1} = Fpm;
            
        end % mod
        
        nr = nr+1;
        
    end % stim
    null_env.cohere{isub,1} = (abs(null_env.pe{isub,1}).^2)./(null_env.pup{isub,1}.*null_env.env{isub,1});
    
end % sub



% Save table
fpath = params.paths.matpath;
outfname = fullfile(fpath,'pup_env_cohere');
fprintf('\nSaving mat file: %s\n', outfname)
save(outfname,'pup_env_cohere', '-v7.3');
fprintf('%s saved', outfname)

outfname = fullfile(fpath,'null_cpsds_env');
fprintf('\nSaving mat file: %s\n', outfname)
save(outfname,'null_env', '-v7.3');
fprintf('%s saved', outfname)






















%% Get peak freqs for each amp env and model prediction
% TODO - check which peak freqs to choose? 

mod_env_peaks = table;
stims = params.stimnames2;
maxFreq = 2;
minFreq = 0;
nPeaks = 10;
MPD = 100; % TODO CHECK not sure what this should be
nr = 1;
for istim = 1:length(stims)
    currstim = stims{istim};
    mod_env_peaks.stim{nr,1} = currstim;
    
    % Peaks from model
    stimmask_rp = strcmp(currstim, rp.stim);
    freqmask = rp.peakFreqs{stimmask_rp} < maxFreq;
    mod_env_peaks.mod_peakFreqs{nr,1} = rp.peakFreqs{stimmask_rp}(freqmask);
    
    % Peaks from model conv w prf
    stimmask_pm = strcmp(currstim, pup_mod_cohere_2.stim);
    mod_data = pup_mod_cohere_2.model(stimmask_pm); % take first instance (all are same)
    mod_data = mod_data{1};
    [~, mod_env_peaks.mod_power_conv{nr,1}, mod_env_peaks.mod_fVals_conv{nr,1}] = getFFT(mod_data, 100, 0);
    freqmask = mod_env_peaks.mod_fVals_conv{nr,1} < maxFreq;
    freqmask2 = mod_env_peaks.mod_fVals_conv{nr,1} > minFreq;
    compfreqmask = freqmask & freqmask2;
    [peaks, locs] = findpeaks(mod_env_peaks.mod_power_conv{nr,1}(freqmask), 'MinPeakDistance', MPD, 'NPeaks', nPeaks, 'Sortstr', 'Descend');
    mod_env_peaks.mod_peakFreqs_conv{nr,1} = mod_env_peaks.mod_fVals_conv{nr,1}(locs);
    
    
    % peaks from amp env conv
    currstim = strcat(currstim, '.wav');
    stimmask_env = strcmp(currstim, ampEnv.stim);
    env_data = ampEnv.conv_env{stimmask_env};
    [~, mod_env_peaks.env_power_conv{nr,1}, mod_env_peaks.env_fVals_conv{nr,1}] = getFFT(env_data, 100, 0);
    freqmask = mod_env_peaks.env_fVals_conv{nr,1} < maxFreq;
    freqmask2 = mod_env_peaks.env_fVals_conv{nr,1} > minFreq;
    compfreqmask = freqmask & freqmask2;
    [peaks, locs] = findpeaks(mod_env_peaks.env_power_conv{nr,1}(compfreqmask), 'MinPeakDistance', MPD, 'NPeaks', nPeaks, 'Sortstr', 'Descend');
    mod_env_peaks.env_peakFreqs_conv{nr,1} = mod_env_peaks.env_fVals_conv{nr,1}(locs);
    
    
    % Do same for unconvolved env
    env_data = ampEnv.ampEnv_downsampled_u{stimmask_env};
    [~, mod_env_peaks.env_power{nr,1}, mod_env_peaks.env_fVals{nr,1}] = getFFT(env_data, 100, 0);
    freqmask = mod_env_peaks.env_fVals{nr,1} < maxFreq;
    freqmask2 = mod_env_peaks.env_fVals{nr,1} > minFreq;
    compfreqmask = freqmask & freqmask2;
    [peaks, locs] = findpeaks(mod_env_peaks.env_power{nr,1}(compfreqmask), 'MinPeakDistance', MPD, 'NPeaks', nPeaks, 'Sortstr', 'Descend');
    mod_env_peaks.env_peakFreqs{nr,1} = mod_env_peaks.env_fVals{nr,1}(locs);
    
    
    
    
    nr = nr+1;
end % stim



outfname = fullfile(fpath,'mod_env_peaks');
fprintf('\nSaving mat file: %s\n', outfname)
save(outfname,'mod_env_peaks', '-v7.3');
fprintf('%s saved', outfname)





%% Get coherence at peak freqs for env
subs = unique(pup_env_cohere.subject);
badsub = 'brian2'; % can't use this data because not enough to calculate null
badind = strcmp(badsub, subs);
subs(badind) = [];
cmp_tn = table;
maxfreq = 2; % do not look at peak freqs over 2Hz because physiologically irrelevant
nr = 1;
peak_conv = 1;

for isub = 1:numel(subs)
    currsub = subs(isub);
    submask_t = strcmp(pup_env_cohere.subject, currsub);
    submask_n = strcmp(null_env.sub, currsub);
    
    for istim = 1:length(params.stimnames2)
        currstim = params.stimnames2{istim};
        stimmask_t = strcmp(pup_env_cohere.stim, currstim);
        compmask_t = submask_t & stimmask_t;
        
        stimmask_mep = strcmp(currstim, mod_env_peaks.stim); % CHeCK make sure this is loaded
        
        if peak_conv
            peaks = mod_env_peaks.env_peakFreqs_conv{stimmask_mep};
        else
            peaks = mod_env_peaks.env_peakFreqs{stimmask_mep};
        end
        
        for ipeak = 1:length(peaks)
            currpeak = peaks(ipeak);
            
            if sum(compmask_t) == 1
                % Grab coherence value at this freq
                freqmask = find(pup_env_cohere.F{compmask_t} >= currpeak); % need to do >= and take first element because peak freq does not exactly match freq resolution of fft % TODO CHECK it should now after new way of calculating model prediction
                freqind = freqmask(1);
                cmp_tn.stimulus{nr,1} = currstim;
                cmp_tn.subject(nr,1) = currsub;
                cmp_tn.peak(nr,1) = currpeak;
                cmp_tn.true(nr,1) = pup_env_cohere.true_cohere{compmask_t}(freqind);
                cmp_tn.null(nr,1) = null_env.cohere{submask_n}(freqind);
                
                nr = nr+1;
            else
                continue
            end
        end % peaks
        
    end %stim
end%sub

% Get one coherence val for each sub
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

% Save
outfname = fullfile(fpath,'avg_tn_env');
fprintf('\nSaving mat file: %s\n', outfname)
save(outfname,'avg_tn', '-v7.3');
fprintf('%s saved', outfname)

% TTEST
[h,p,ci,stats] = ttest(avg_tn.true, avg_tn.null);
truemean = mean(avg_tn.true);
truestd = std(avg_tn.true);
nullmean = mean(avg_tn.null);
nullstd = std(avg_tn.null);




%% Get coherence at peak freqs for model
subs = unique(pup_mod_cohere_2.subject);
badsub = 'brian2'; % can't use this data because not enough to calculate null
badind = strcmp(badsub, subs);
subs(badind) = [];
cmp_tn = table;
maxfreq = 2; % do not look at peak freqs over 2Hz because physiologically irrelevant
nr = 1;
peak_conv = 1;

for isub = 1:numel(subs)
    currsub = subs(isub);
    submask_t = strcmp(pup_mod_cohere_2.subject, currsub);
    submask_n = strcmp(null2.sub, currsub);
    
    for istim = 1:length(params.stimnames2)
        currstim = params.stimnames2{istim};
        stimmask_t = strcmp(pup_mod_cohere_2.stim, currstim);
        compmask_t = submask_t & stimmask_t;
        stimmask_peaks = strcmp(currstim, mod_env_peaks.stim);
        stimmask_rp = strcmp(rp.stim, currstim);
        
        % Get peak freqs for this stim
        if peak_conv
            peaks = mod_env_peaks.mod_peakFreqs_conv{stimmask};
        else
            peaks = mod_env_peaks.mod_peakFreqs{stimmask};
        end
        
        for ipeak = 1:length(peaks)
            currpeak = peaks(ipeak);
            
            if sum(compmask_t) == 1
                % Grab coherence value at this freq
                freqmask = find(pup_mod_cohere_2.F{compmask_t} >= currpeak); % need to do >= and take first element because peak freq does not exactly match freq resolution of fft % TODO CHECK it should now after new way of calculating model prediction
                freqind = freqmask(1);
                cmp_tn.stimulus{nr,1} = currstim;
                cmp_tn.subject(nr,1) = currsub;
                cmp_tn.peak(nr,1) = currpeak;
                cmp_tn.true(nr,1) = pup_mod_cohere_2.true_cohere{compmask_t}(freqind);
                cmp_tn.null(nr,1) = null2.cohere{submask_n}(freqind);
                
                nr = nr+1;
            else
                continue
            end
        end % peaks
        
    end %stim
end%sub

% Get average true and null for each sub
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


outfname = fullfile(fpath,'avg_tn_mod_conv');
fprintf('\nSaving mat file: %s\n', outfname)
save(outfname,'avg_tn', '-v7.3');
fprintf('%s saved', outfname)


% TTEST
[h,p,ci,stats] = ttest(avg_tn.true, avg_tn.null);
truemean = mean(avg_tn.true);
truestd = std(avg_tn.true);
nullmean = mean(avg_tn.null);
nullstd = std(avg_tn.null);


%% Env v Model
env = load(fullfile(params.paths.matpath, 'avg_tn_env.mat'));
env = env.avg_tn;
mod = load(fullfile(params.paths.matpath, 'avg_tn_mod_conv.mat'));
mod = mod.avg_tn;

[h,p,ci,stats] = ttest(mod.true, env.true);
modmean = mean(mod.true);
modstd = std(mod.true);
envmean = mean(env.true);
envstd = std(env.true);



%% Plots


fname = fullfile(params.paths.fig_path, 'exSub_pupMod_cohere_v_20180821_conv.eps');
%line(0:20, 0:20) % just to start off file until figure out something better
%print('-dpsc', fname)
fs = 100;
badsub = 'brian2'; % can't use this data because not enough to calculate null

% Plot true and null coherence for each sub/stim
% include original pupil, amp env, and model spectra as well
subs = unique(pup_mod_cohere_2.subject);
badind = strcmp(badsub, subs);
subs(badind) = [];


for isub = 1%:numel(subs)
    figure()
    currsub = 'jr'; %subs(isub);
    submask_t = strcmp(pup_mod_cohere_2.subject, currsub);
    %submask_n = strcmp(null2.sub, currsub);
    
    for istim = 1:length(params.stimnames2)
        currstim = params.stimnames2{istim};
        stimmask_t = strcmp(pup_mod_cohere_2.stim, currstim);
        compmask_t = submask_t & stimmask_t;
        stimmask_mod = strcmp(mod_env_peaks.stim, currstim);
        
        % Plot
        nstims = length(params.stimnames2);
        subplot(nstims, 1, istim)
        
        
        %model spectrum
        %yyaxis right
        %plot(mod_env_peaks.mod_fVals_conv{stimmask_mod}, mod_env_peaks.mod_power_conv{stimmask_mod}, 'r', 'Linewidth', 2)
        %ylim([0 .0007])
        y = .15;
        peaks = (mod_env_peaks.mod_peakFreqs_conv{stimmask_mod});
        for ipeak = 1:numel(peaks)
            h3 = plot([peaks(ipeak) peaks(ipeak)], [0 y], 'k', 'LineWidth', 1.5)
            hold on 
        end
        hold on 
        %plot(mod_env_peaks.env_fVals_conv{stimmask_mod}, mod_env_peaks.env_power_conv{stimmask_mod}, ':', 'Linewidth', 2)
        peaks = (mod_env_peaks.env_peakFreqs_conv{stimmask_mod});
        for ipeak = 1:numel(peaks)
            h4 = plot([peaks(ipeak) peaks(ipeak)], [0 y], ':r', 'LineWidth', 1.5)
            hold on 
        end
        %ylabel('Model + Amp Env PSD')
        hold on
        
        
                % true coherence
        if sum(compmask_t) == 1
            %yyaxis left
            h1 = plot(pup_mod_cohere_2.F{compmask_t}, pup_mod_cohere_2.true_cohere{compmask_t}, 'k', 'Linewidth', 2);
            hold on
            % null coherence
            %plot(pup_mod_cohere_2.F{compmask_t}, null.cohere_2{submask_n}, 'k', 'Linewidth', 2)
            
            % plot amp env true instead of null
            h2 = plot(pup_env_cohere.F{compmask_t}, pup_env_cohere.true_cohere{compmask_t}, ':r', 'Linewidth', 2)
            hold on
            
            plot_stim_ind = find(strcmp(params.plot_stimnames, cellstr(currstim)));
            plot_stim_lab = params.plot_stimnames{plot_stim_ind,2};
            title(plot_stim_lab)
            %title(currstim)
            xlim([0 2])
            ylim([0 .15])
            xlabel('Freq. (Hz)')
            ylabel('Coherence')
            
            % add legend to first subplot
            if istim == 1
                legend([h1 h2], {'True Coherence - Model', 'True Coherence - Amp Env'}, 'Location', 'NorthWest')
            end
            set(gca, 'fontsize', 12)
            set(gca, 'FontName', 'Helvetica')
            ax1 = gca;
            ax1.XColor = 'k';
            ax1.YColor = 'k';
            
            % print to file
        else
            continue
        end

        
    end %stim
    %suptitle(currsub)
    
   %print('-dpsc', '-fillpage', '-append', fname)
   %print('-dpsc', '-fillpage', fname)
   %close all
end %sub