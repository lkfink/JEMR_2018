% alternative modeling approaches for Revision 1
% - 20180822 - Lauren Fink (lkfink@ucdavis)
% Janata Lab, UC Davis, Center for Mind & Brain 

params = attmap_eyes_globals;

%% Get amplitude envelope values corresponding to dev time points
fpath = params.paths.matpath;
fname = fullfile(fpath,'stim_ampEnv');
load(fname);

% Convert probe times to 100Hz samples
Fs = 100;
for istim = 1:length(params.stim_probetimes)
    params.stim_probetimes{istim, 3} = ceil(params.stim_probetimes{istim, 2} * (Fs/1000) + 1); % to correct zero indexing
    currstim = params.stim_probetimes{istim, 1};
    stimmask = strcmp(currstim, ampEnv.stim);
    ampEnv.probetime{stimmask} = params.stim_probetimes{istim, 2};
    ampEnv.probeVal{stimmask} = ampEnv.ampEnv_downsampled_u{stimmask}(params.stim_probetimes{istim, 3});
end % stim

% Append new probe vals to output table used for mixed effects models
fpath = params.paths.tablepath;
fname = fullfile(fpath, 'attmap_v1p2_eyetrack_thresh_data.csv');
data = ensemble_csv2datastruct(fname);
dt = ensemble_datastruct2table(data);
dt(:,[12:end]) = []; % remove unecessary cols
stims = unique(dt.stim_name);
for istim = 1:length(stims)
    currstim = stims{istim};
    stimmask_dt = strcmp(dt.stim_name, currstim);
    stimmask_env = strcmp(ampEnv.stim, currstim);
    probes = unique(dt.probe_time(stimmask_dt));
    for iprobe = 1:length(probes)
        currprobe = probes(iprobe);
        probemask_dt = dt.probe_time == currprobe;
        probemask_env = ampEnv.probetime{stimmask_env} == currprobe;
        
        compmask_dt = stimmask_dt & probemask_dt;
        dt.envVal(compmask_dt, 1) = ampEnv.probeVal{stimmask_env}(probemask_env);
        
    end % probe
    
end % stim

% Look at correspondence between reson out and amp env val
% Only do this once (not for all instances)
stims = unique(dt.stim_name);
corrtbl = table;
nr = 1;
for istim = 1:length(stims)
    currstim = stims(istim);
    stimmask = strcmp(currstim, dt.stim_name);
    probes = unique(dt.probe_time(stimmask));
    
    for iprobe = 1:length(probes)
        currprobe = probes(iprobe);
        probemask = dt.probe_time == currprobe;
        
        compmask = probemask & stimmask;
        
        corrtbl.stim{nr,1} = currstim;
        corrtbl.probe(nr, 1) = currprobe;
        env = dt.envVal(compmask);
        corrtbl.env(nr, 1) = env(1);
        peak = dt.reson_out(compmask);
        corrtbl.peakRes(nr,1) = peak(1);
        
        nr = nr+1;
    end
end
[r,p] = corr(corrtbl.peakRes, corrtbl.env, 'tail', 'right'); % corr = .9
% figure()
% scatter(dt.reson_out, dt.envVal, 'k', 'filled')
% xlabel('Reson Output')
% ylabel('Amp Env Val')



%% Get full model output, rather than peak filters

% Load in all rp data
model = load(params.paths.rp_analysis);
model = model.an;
stimnames = model{1, 3}.results.data{1,1};

%avg ro across bands 
ro = model{1,1}.results.data{9};
rt = table;
for i = 1:length(ro)
    rp = load(ro{i});
    d = rp.rp.data{9}; % full resonator out
    ro_summed = sum(d,2);
    ro_very_summed=sum(squeeze(ro_summed));
%     figure
%     plot(ro_very_summed)
    rt.stim{i, 1} = stimnames{i};
    rt.full_resonOut{i, 1} = ro_very_summed;
end



% Get values corresponding to deviants
% Take from third loop through osc model so that everything has settled
for istim = 1:length(params.stim_probetimes)
    currstim = params.stim_probetimes{istim, 1};
    stimmask = strcmp(currstim, rt.stim);
    rt.probetime{stimmask} = params.stim_probetimes{istim, 2};
    stimlen = floor((length(rt.full_resonOut{stimmask}) / 4)); % 4 loops went through model
    rt.probeVal{stimmask} = rt.full_resonOut{stimmask}(params.stim_probetimes{istim, 3} + (stimlen*2));
end % stim

% Add to output LMM table
stims = unique(dt.stim_name);
for istim = 1:length(stims)
    currstim = stims{istim};
    stimmask_dt = strcmp(dt.stim_name, currstim);
    stimmask_mod = strcmp(rt.stim, currstim);
    probes = unique(dt.probe_time(stimmask_dt));
    for iprobe = 1:length(probes)
        currprobe = probes(iprobe);
        probemask_dt = dt.probe_time == currprobe;
        probemask_mod = rt.probetime{stimmask_mod} == currprobe;
        
        compmask_dt = stimmask_dt & probemask_dt;
        dt.fullResonVal(compmask_dt, 1) = rt.probeVal{stimmask_mod}(probemask_mod);
        
    end % probe
    
end % stim


% [r,p] = corr(dt.reson_out, dt.fullResonVal, 'tail', 'right'); %.83
% [r,p] = corr(dt.fullResonVal, dt.envVal, 'tail', 'right'); %.81


%% Write out updated table
fname = fullfile(fpath, 'attmap_v1p2_eyetrack_thresh_data_updated.csv');
writetable(dt, fname)


%% Update pupil data for lme on hit/miss

% Load loop table
fpath = params.paths.matpath;
fname = fullfile(fpath,'loopTable2');
load(fname)

% Append alt model values
stims = unique(loopTable2.stimulus_id);
for istim = 1:length(stims)
    currstim = stims{istim};
    stimmask_lt = strcmp(loopTable2.stimulus_id, currstim);
    stimmask_dt = strcmp(dt.stim_name, strcat(currstim, '.wav'));
    probeOccuredMask = logical(~isnan(loopTable2.probe_idx)); 
    
    stim_probes = unique(loopTable2.maxProbeTime(stimmask_lt & probeOccuredMask)); % to correct for probe time of 0
    for iprobe = 1:length(stim_probes)
        currprobe = stim_probes(iprobe);
        probemask_lt = loopTable2.maxProbeTime == currprobe;
        probemask_dt = dt.probe_time == currprobe;
        
        compmask_lt = stimmask_lt & probemask_lt & probeOccuredMask;
        compmask_dt = stimmask_dt & probemask_dt;
        
        ampEnvVal = dt.envVal(compmask_dt);
        loopTable2.ampEnvVal(compmask_lt, 1) = ampEnvVal(1);
        
        fullResVal = dt.fullResonVal(compmask_dt);
        loopTable2.fullResonVal(compmask_lt, 1) = fullResVal(1);
        
        % fix hit column to include NaN when no probe occured 
        loopTable2.hit(~probeOccuredMask) = NaN;
       
    end % probe
    
end % stim

% Remove uneccesary cols from looptable before writing
loopTable2(:,'trialPup') = [];
loopTable2(:,'loopPup') = [];

%%
% Write table for use in R
fname = fullfile(fpath, 'pupMEM_updated.csv');
writetable(loopTable2, fname)

%% Write table of just hit/miss trials


% fuck wtf why so many nans in here?
nanmask = isnan(loopTable2.trialPupMean);
compmask = nanmask & probeOccuredMask;
check = loopTable2(compmask, :);
% ahh right! obs 20 did not have enough time to take these metrics. all is
% ok.

lastObs = logical(loopTable2.maxObs_num == 20);
compmask = probeOccuredMask & ~lastObs;
hm = loopTable2(compmask, :);
hm(:,'hit_idx') = [];
fname = fullfile(fpath, 'pupMEM_hm.csv');
writetable(hm, fname)

find(any(isnan(hm)))
