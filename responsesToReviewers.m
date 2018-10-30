% Responses to Reviewer A
params = attmap_eyes_globals;

%% Re: High-pass filter distortions

% The reviewer's code:
t=(0:1499)'/500;
h=t.^10.1.*exp(-10.1*t/0.512);
[b,a]=butter(3,0.05/250,'high');
fh=filter(b,a,h);
figure()
plot(t,[h fh])
legend('PRF', 'filtered')
title('Reviewer code')

% This is misleading because it implies we only filtered our PRF epochs. We
% filtered over the 7 minute run. Here is an illustration of our
% preprocessing.
params = attmap_eyes_globals;
fpath = params.paths.matpath;
load(fullfile(fpath, 'pupdata.mat'))

%% Plot pupil pre-processing transformations
plotlim = length(ds{1,1}.RIGHT_PUPIL_SIZE(trialmask));
fs = 500;
secs = plotlim/fs;
x = 1:(fs*secs);
xaxis = x/fs/60;
fontsize = 14;

figure()
subplot(4,1,1)
trialmask = ds{1,1}.TRIAL_INDEX == 1;
plot(xaxis, ds{1,1}.RIGHT_PUPIL_SIZE(trialmask), 'k') % NOTE need to load ds (from pre-proc script)
ylim([0 4000])
xlabel('Time (min)')
ylabel('Pupil size (a.u.)')
title('Raw pupil trace')
set(gca, 'FontSize', fontsize)

subplot(4,1,2)
plot(xaxis, pupdata.pupInterp{1}, 'k')
ylim([0 4000])
xlabel('Time (min)')
ylabel('Pupil size (a.u.)')
title('Blinks and saccades removed and interpolated')
set(gca, 'FontSize', fontsize)

subplot(4,1,3)
plot(xaxis, pupdata.hfPup{1}, 'k')
ylim([-1000 1000])
xlabel('Time (min)')
ylabel('Pupil size (a.u.)')
title('High-pass filtered at .05 Hz, 3rd order Butterworth')
set(gca, 'FontSize', fontsize)

subplot(4,1,4)
plot(xaxis, pupdata.pupNorm{1}, 'k')
ylim([-10 10])
xlabel('Time (min)')
ylabel('Pupil size (z-score)')
title('Z-scored')
suptitle('Pre-processing transformations for one subject, one run')
set(gca, 'FontSize', fontsize)

%% Re: Report mean min / max, std age of subs
load(fullfile(params.paths.matpath, 'attmap_v1p2_analysis_eyes.mat'));
submeta = table;
submeta.sub = an{1,4}.results.data{1};
submeta.age = an{1,4}.results.data{2};
submeta.gender = an{1,4}.results.data{3};

%% Report number of observations per condition per sub, stim, dev
load(fullfile(params.paths.matpath, 'loopTable2.mat'))
subs = unique(loopTable2.subject_id);
avg_hm_trials = table;
nr = 1;
for isub = 1:length(unique(subs))
    submask = strcmp(loopTable2.subject_id, subs{isub});
    thissubstims = unique(loopTable2.stimulus_id(submask));
    for istim = 1:length(thissubstims)
        stimmask = strcmp(loopTable2.stimulus_id, thissubstims{istim});
        compmask = submask & stimmask;
        devs = unique(loopTable2.probe_id(compmask));
        ndmask = strcmp(devs, 'no_deviant');
        if sum(strcmp(devs, 'dev_hi_2086;loop')) == 1
            badmask = strcmp(devs, 'dev_hi_2086;loop'); % remove this as unique dev id
            devs = devs(~ndmask & ~badmask);
        else
            devs = devs(~ndmask);
        end
        
        
        % Loop through all devs for this stim
        for idev = 1:length(devs)
            currdev = devs(idev);
            if strcmp(currdev, 'dev_hi_2086')
                devmask1 = strcmp(loopTable2.probe_id, currdev);
                devmask2 = strcmp(loopTable2.probe_id, 'dev_hi_2086;loop'); % combine this probe id with standard probe id
                devmask = devmask1 + devmask2;
            else
                devmask = strcmp(loopTable2.probe_id, currdev);
            end
            completemask = compmask & devmask;
            
            avg_hm_trials.sub{nr,1} = subs{isub};
            avg_hm_trials.stim{nr,1} = thissubstims{istim};
            avg_hm_trials.dev{nr,1} = currdev{:};
            avg_hm_trials.hit(nr,1) = sum(loopTable2.hit(completemask));
            avg_hm_trials.miss(nr,1) = numel(loopTable2.hit(completemask)) - sum(loopTable2.hit(completemask));
            nr = nr+1;
        end
        
    end
end

%%

nd = table;
nr = 1;
ndmask = strcmp(loopTable2.probe_id, 'no_deviant');
for isub = 1:length(unique(subs))
    submask = strcmp(loopTable2.subject_id, subs{isub});
    thissubstims = unique(loopTable2.stimulus_id(submask));
    for istim = 1:length(thissubstims)
        stimmask = strcmp(loopTable2.stimulus_id, thissubstims{istim});
        compmask = submask & stimmask & ndmask;
        nd.sub{nr,1} = subs{isub};
        nd.stim{nr,1} = thissubstims{istim};
        nd.nd(nr,1) = sum(nd_completemask);
        nr = nr+1;
    end
end

fprintf('\n\nMean number (and std) of hit observations per deviant: %02f (%02f)\n', mean(avg_hm_trials.hit), std(avg_hm_trials.hit))
fprintf('Mean number (and std) of miss observations per deviant: %02f (%02f)\n', mean(avg_hm_trials.miss), std(avg_hm_trials.miss))
fprintf('Mean number (and std) of nd observations per stimulus: %02f (%02f)\n', mean(nd.nd), std(nd.nd))

%% report mean for each dev
stims = params.stimnames2;
sa = table;
nr = 1;
orignames = params.plot_stimnames(:,1);
plotnames = params.plot_stimnames(:,2);
plotdevsstims = params.stim_probeIds(:,1);

for istim = 1:length(stims)
    currstim = stims{istim};
    stimmask = strcmp(avg_hm_trials.stim, currstim);
    
    stimmask_plotname = strcmp(orignames, currstim);
    plotname = params.plot_stimnames{stimmask_plotname, 2};
    plotdevmask = strcmp(plotdevsstims, strcat(currstim, '.wav'));
    
    devs = unique(avg_hm_trials.dev(stimmask));
    for idev = 1:length(devs)
        currdev = devs(idev);
        ind = find(strcmp(params.stim_probe_convert, currdev));
        probetime = params.stim_probe_convert{ind,2};
        devtimes(idev) = cell2mat(probetime);
    end
    [new, old_inds] = sort(devtimes);
    for iind = 1:length(old_inds)
        devlabs(iind) = devs(old_inds(iind));
    end
    
    
    for idev = 1:length(devlabs)
        currdev = devlabs{idev};
        devplotnum = find(strcmp(params.stim_probeIds{plotdevmask, 2}, currdev));
        devmask = strcmp(avg_hm_trials.dev, currdev);
        compmask = devmask & stimmask;
        sa.stim{nr,1} = plotname;
        sa.probe{nr, 1} = devplotnum;
        sa.avg_num_hit_trials(nr,1) = mean(avg_hm_trials.hit(compmask));
        sa.hit_std(nr,1) = std(avg_hm_trials.hit(compmask));
        sa.avg_num_miss_trials(nr,1) = mean(avg_hm_trials.miss(compmask));
        sa.miss_std(nr,1) = std(avg_hm_trials.miss(compmask));
        nr = nr+1;
    end
end

writetable(sa, fullfile(params.paths.tablepath, 'avg_obs_per_cond.csv'))

%% Re: model peaks used in coherence
% These are all of the peaks under three Hz plotted in Fig. 1 but also now
% we include a table in supplemental

%load(fullfile(params.paths.matpath, 'mod_env_peaks.mat'))
t = table;
stims = params.stimnames2;
nr = 1;
orignames = params.plot_stimnames(:,1);
plotnames = params.plot_stimnames(:,2);

for istim = 1:length(stims)
    currstim = stims{istim};
    stimmask = strcmp(mod_env_peaks.stim, currstim);
    
    stimmask_plotname = strcmp(orignames, currstim);
    plotname = params.plot_stimnames{stimmask_plotname, 2};
    
    t.stim{nr,1} = plotname;
    t.peaks{nr,1} = mod_env_peaks.mod_peakFreqs{stimmask};
    nr = nr+1;
end
writetable(t, fullfile(params.paths.tablepath, 'peaks_for_cohere.csv'))



