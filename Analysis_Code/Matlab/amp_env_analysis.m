% get amplitude envelope of all stimuli used in attmap JEMR paper
% 20180716 - Lauren Fink (lkfink@ucdavis)
% Janata Lab, UC Davis, Center for Mind & Brain 

params = attmap_eyes_globals;
COMPUTE_ENV = 1;
LOAD_ENV_DATA = 0;
LOAD_PUP_DATA = 0;
CALC_CPSD = 0;
CALC_COH_STATS = 0;
ENV_V_MOD = 0;
CORR_ANALYSES = 0;
%% -----------------------------------------------------------------------%
if COMPUTE_ENV
    ampEnv = table;
    stimdir = dir(fullfile(params.paths.stim_path,'*.wav'));
    nfiles = length(stimdir);
    nr = 1;
    
    for ifile = 1:nfiles
        
        % load in audio file
        fname = fullfile(stimdir(ifile).folder, stimdir(ifile).name);
        fprintf('\nReading audio file: %s\n', fname)
        [y,fs] = audioread(fname);
        
        % repmat audio for 160 loops (what used in coherence analysis)
        repaud = repmat(y', 1, 160);
        repaud = repaud';
        
        % get amplitude envelope
        fprintf('\nExtracting envelope for audio file: %s\n', fname)
        N = fs*.05; % 50ms - 20 hz. Filter length should be function of lowest freq want to capture. 0.05 - 1 period of stim
        [YUPPER,YLOWER] = envelope(repaud, N, 'rms');
        
        % lowpass filter envelope at 10Hz or 20Hz 
        fprintf('\nLow pass filtering envelope for file: %s\n', fname)
        [b,a] = butter(3, 50/(fs/2), 'low');
        filtaud = filtfilt(b,a,YUPPER(:,1));
        
        % downsample amplitude envelope
        fprintf('\nDownsampling envelope for file: %s\n', fname)
        [p,q] = rat(100 / fs); % desired fs/ original fs
        yu = resample(filtaud, p, q);
        
        
        % Save all vars to table
        fprintf('\nSaving all data for file: %s\n', fname)
        ampEnv.stim{nr,1} = stimdir(ifile).name;
        ampEnv.audio{nr,1} = y;
        ampEnv.Fs(nr,1) = fs;
        ampEnv.repaud{nr, 1} = repaud;
        ampEnv.ampEnv_full_u{nr, 1} = YUPPER;
        ampEnv.ampEnv_filt{nr,1} = filtaud;
        ampEnv.ampEnv_downsampled_u{nr, 1} = yu;
        
        nr = nr+1;
    end
    
    % Load PRF for convolution with model output
    Fs = 100;
    motor = 0;
    PRF = genPRF(Fs, motor);
    
    % Convolve each stim with PRF
    for istim = 1:length(ampEnv.stim)
        env = ampEnv.ampEnv_downsampled_u{istim}(1:35500); %size of pupil data 
        ampEnv.conv_env{istim} = conv(env, PRF, 'same');
    end
    
    % Save table to .mat file
    fpath = params.paths.matpath;
    outfname = fullfile(fpath,'stim_ampEnv');
    fprintf('\nSaving mat file: %s\n', outfname)
    save(outfname,'ampEnv', '-v7.3');
    fprintf('%s saved', outfname)
    

end

%% -----------------------------------------------------------------------%
if LOAD_ENV_DATA
    fpath = params.paths.matpath;
    fname = fullfile(fpath,'stim_ampEnv.mat');
    load(fname);
end

%-------------------------------------------------------------------------%
% Now compute coherence between pup and amp envs (instead of BTB model)
% Also might be nice to make some plots
% What to do about upper vs lower? I don't think it is exactly symmetric..

% TODO rerun coherence analysis with new concolved pup prediction

if LOAD_PUP_DATA
    % Load pup_mod_cohere to get pupil appropriate pupil data
    fpath = params.paths.matpath;
    fname = fullfile(fpath,'pup_mod_cohere_2.mat');
    load(fname);
end


%% Calculate true and null cpsd for each sub/stim pair
if CALC_CPSD

    
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
    
end



%%
% TODO get peaks in amp env
if CALC_COH_STATS
     %fname = fullfile(params.paths.matpath, 'MPP_pup.mat');
     %load(fname)
    
    % Loop through all data and take coherence estimate at each each model-predicted peak freq.
    subs = unique(pup_env_cohere.subject);
    badsub = 'brian2'; % can't use this data because not enough to calculate null
    badind = strcmp(badsub, subs);
    subs(badind) = [];
    cmp_tn = table;
    maxfreq = 2; % do not look at peak freqs over 2Hz because physiologically irrelevant
    nr = 1;
    
    for isub = 1:numel(subs)
        currsub = subs(isub);
        submask_t = strcmp(pup_env_cohere.subject, currsub);
        submask_n = strcmp(null_env.sub, currsub);
        
        for istim = 1:length(params.stimnames2)
            currstim = params.stimnames2{istim};
            stimmask_t = strcmp(pup_env_cohere.stim, currstim);
            compmask_t = submask_t & stimmask_t;
            stimmask_rp = strcmp(rp.stim, currstim);
            stimmask_mep = strcmp(currstim, mod_env_peaks.stim); % TODO make sure this is loaded
            
            % Get peak freqs for this stim
            % TODO change
%             peaks = rp.peakFreqs{stimmask_rp};
%             peaks = peaks(peaks < maxfreq);
            peaks = mod_env_peaks.env_peakFreqs{stimmask_mep};
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
    
end

%%
if ENV_V_MOD
    % Also compare true coh for end and true coh for mod
    env = load(fullfile(params.paths.matpath, 'avg_tn_env.mat'));
    env = env.avg_tn;
    mod = load(fullfile(params.paths.matpath, 'avg_tn_mod_conv.mat'));
    mod = mod.avg_tn;
    
    [h,p,ci,stats] = ttest(env.true, mod.true);
    modmean = mean(mod.true);
    modstd = std(mod.true);
    envmean = mean(env.true);
    envstd = std(env.true);
    
end

% Pup and amp envs and model predictions all save in their respective
% cohere tables. Should not need to run these costly analyses again..

%TODO: look at corr

%%
if CORR_ANALYSES
    
    % Get corr between pup and model, pup and env
    % Also predict what song some one listening to based on highest corr. 
    ds = pup_mod_cohere(:, 1:4);
    stimuli = unique(ds.stim);
    for istim = 1:length(stimuli)
        currstim = stimuli(istim);
        stimmask_ds = strcmp(ds.stim, currstim);
        stimmask_envs = strcmp(ampEnv.stim, strcat(currstim, '.wav'));
        curr_env = ampEnv.conv_env{stimmask_envs};
        ds_inds = find(stimmask_ds == 1);
        for iind = 1:length(ds_inds)
            currind = ds_inds(iind);
            ds.env{currind, 1} = curr_env';
        end
    end
    
    % conv model with PRF
    for irow = 1:length(ds.subject)
        ds.model{irow} = conv(ds.model{irow}, PRF, 'same');
    end
    
    for irow = 1:length(ds.subject)
        ds.corr_mp(irow) = corr(ds.pup{irow}', ds.model{irow}');
        ds.corr_ep(irow) = corr(ds.pup{irow}', ds.env{irow}');
    end
    
    
    % Plot hist of corr coefs
    figure()
    subplot(2,1,1)
    hist(ds.corr_mp)
    title('Corrs between pup and model')
    subplot(2,1,2)
    hist(ds.corr_ep)
    title('Corrs between pup and env')
    
    % Plot example of the time series
    % For single sub
    row = 1;
    len = 5000;
    
    figure()
    stimuli = params.stimnames2;
    for istim = 1:length(stimuli)
        currstim = stimuli{istim};
        stimmask = strcmp(ds.stim, currstim);
        inds = find(stimmask == 1);
        ind = inds(1);
        subplot(5,1,istim)
        
        yyaxis left
        plot(ds.model{ind}(1:len))
        ylabel('Model')
        yyaxis right
        plot(ds.env{ind}(1:len))
        %title('Model + Env')
        ylabel('Envelope')
        title(params.plot_stimnames{istim, 2})
    end
    
    % Plot avg pup across subs for each stim and each model/env
    meanSeries = table;
    for istim = 1:length(stimuli)
       currstim = stimuli(istim);
       stimmask = strcmp(ds.stim, currstim);
       
       meanSeries.stim(istim, 1) = currstim;
       meanSeries.pup{istim, 1} = mean(cell2mat(ds.pup(stimmask)));
       model = ds.model(stimmask);
       meanSeries.model{istim, 1} = model{1};
       env = ds.env(stimmask);
       meanSeries.env{istim, 1} = env{1};
    end
    
    
%     figure()
%     subplot(5,2,1)
%     yyaxis left
%     plot(meanSeries.pup{1}(1:len))
%     yyaxis right
%     plot(meanSeries.model{1}(1:len))
%     legend('Pupil', 'Model')
%     
%     subplot(5,2,2)
%     yyaxis left
%     plot(meanSeries.pup{1}(1:len))
%     yyaxis right
%     plot(meanSeries.env{1}(1:len))
%     legend('Pupil', 'Env')
    
    
    
    
    % should now prob take one avg corr per sub
    subs = unique(ds.subject);
    meanCorrs = table;
    for isub = 1:length(subs)
        currsub = subs{isub};
        submask = strcmp(ds.subject, currsub);
        meanCorrs.sub{isub, 1} = currsub;
        meanCorrs.mp(isub,1) = mean(ds.corr_mp(submask));
        meanCorrs.ep(isub,1) = mean(ds.corr_ep(submask));
    end
    
    
    
    [h,p,ci,stats] = ttest(meanCorrs.mp, meanCorrs.ep);
    % no sig diff between model and env corrs
    
    
end



%% 
% TODO
% avg ro across bands 
% ro = check.rp.data{9};
% ro_summed = sum(ro,2);
% ro_very_summed=sum(squeeze(ro_summed));
% figure
% plot(ro_very_summed)
