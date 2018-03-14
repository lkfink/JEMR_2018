%% Plot avg pupil data across subs for each stim/ dev
% generates one 5x4 figure with subplots for each dev
% hit, miss, and no dev pupil traces, time-locked to deviant onset

% Lauren Fink
% Janata Lab
% UC Davis Center for Mind & Brain
% Last edited: 20180215

params = attmap_eyes_globals;
LOAD_DATA = 1;
SAVE2MAT = 0;

% Specify which version of the no deviant data you would like to plot
PLOT_ALL_ND = 0; % every trial marked as no deviant
PLOT_2nd_ND = 0; % only the second no deviant trial of two in a row
PLOT_LONG_ND = 1; % a series of data starting with the first no deviant loop, extending through loops with deviants


if LOAD_DATA
    % Load required data tables
    fpath = params.paths.matpath;

    fstub = 'pupdata.mat';
    load(fullfile(fpath, fstub))

    fstub = 'loopTable2.mat';
    load(fullfile(fpath, fstub))
end

%-------------------------------------------------------------------------%
                % Organize no deviant data
%-------------------------------------------------------------------------%
nr = 1;
ndt = table;
nodevmask = strcmp('no_deviant', loopTable2.probe_id);

diffVec = [1; diff(nodevmask)];
nodevmask2 = (diffVec == 0) & (nodevmask == 1);

diffVec2 = [1; diff(nodevmask2)];
after2ndmask = (diffVec2 == -1);

% NOTE: Creating masks for all trials that are 'no_deviant', as well as
% trials that are the 2nd of 2 'no_deviant' trials. This is because pupil
% response to deviant is still coming down in first no deviant trial. Will
% decide later which is more appropriate for plotting. Keep both for now. 

for istim = 1:length(params.stimnames2)
    currstim = params.stimnames2{istim};
    stimmask = strcmp(loopTable2.stimulus_id, currstim);
    
    compmask = stimmask & nodevmask;
    compmask2 = stimmask & nodevmask2;
    compmask3 = stimmask & after2ndmask;
    
    % Take all no deviant trials
    nodevdata = shortenCell2Mat(loopTable2.loopPup(compmask));
    nnd = length(nodevdata(:,1));
    nodevdata_mean = mean(nodevdata);
    SEMnodev = std(nodevdata) / sqrt(nnd);
    
    % Take only the 2nd of two no deviant trials
    nodevdata2 = shortenCell2Mat(loopTable2.loopPup(compmask2));
    nnd = length(nodevdata2(:,1));
    nodevdata2_mean = mean(nodevdata2);
    SEMnodev2 = std(nodevdata2) / sqrt(nnd);
    
    % Take extra loops after 1st of no dev trials 
    inds = find(compmask3 == 1);
    nodevdata_long = cell(length(inds), 1);
    for iind = 1:length(inds)-1
        currind = inds(iind);
        startind = loopTable2.loop_start(currind-2);
        endind = loopTable2.loop_start(currind+3);
        
        currsub = loopTable2.subject_id{currind};
        submask = strcmp(pupdata.subject_id, currsub);
        stimmask = strcmp(pupdata.stimulus_id, currstim);
        pup_compmask = stimmask & submask;
        currpupdata = pupdata.pupNorm{pup_compmask};

        if endind > length(currpupdata)
            continue
        end
        
        baselinesamps = 100; %200 ms baseline
        baselinemean = mean(currpupdata(startind-baselinesamps:startind-1));
        currpupdata = currpupdata(startind:endind);
        nodevdata_long{iind, 1} = currpupdata - baselinemean;
         
        
    end
    nodevdata_long = shortenCell2Mat(nodevdata_long);
    nodevdata_long_mean = mean(nodevdata_long);
    nodevdata_long_sem = std(nodevdata_long) / sqrt(length(nodevdata_long));
    
    
    % Save variables of interest to table
    ndt.stim{nr,1} = currstim;
    ndt.mean{nr,1} = nodevdata_mean;
    ndt.sem{nr,1} = SEMnodev2;
    ndt.mean2{nr,1} = nodevdata2_mean;
    ndt.sem2{nr,1} = SEMnodev2;
    ndt.mean_long{nr,1} = nodevdata_long_mean;
    ndt.sem_long{nr,1} = nodevdata_long_sem;
    nr = nr+1;
end %stim





%-------------------------------------------------------------------------%
                % Loop through all pupil data and plot
%-------------------------------------------------------------------------%

% Initialize figure and subplot counter
figure()
pi = 1;

% Initialize table and row counter for use in future plot
nr = 1;
nd_probes = table;


% Loop through all stimuli and deviants
% Make sure they are sorted by stim label and probe time
stims = params.stimnames2;
for istim = 1:length(stims)
    currstim = stims(istim);
    stimmask = strcmp(loopTable2.stimulus_id, currstim);
    
    % Deviants (probe ids)
    devs = unique(loopTable2.probe_id(stimmask));
    ndmask = strcmp(devs, 'no_deviant');
    badmask = strcmp(devs, 'dev_hi_2086;loop'); % remove this as unique dev id
    devs = devs(~ndmask & ~badmask);
    
    % Sort dev data by time so plot looks nice
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
    
    % Loop through all devs for this stim
    for idev = 1:length(devlabs)
        currdev = devlabs(idev);
        if strcmp(currdev, 'dev_hi_2086')
            devmask1 = strcmp(loopTable2.probe_id, currdev);
            devmask2 = strcmp(loopTable2.probe_id, 'dev_hi_2086;loop'); % combine this probe id with standard probe id
            devmask = devmask1 + devmask2;
        else
            devmask = strcmp(loopTable2.probe_id, currdev);
        end
        
        
        %-----------------------------------------------------------------%
                               % Get Data %
        %-----------------------------------------------------------------%
        
        % Create masks
        devoccured_mask = ~isnan(loopTable2.probe_idx);
        hitmask = logical(loopTable2.hit);
        compmask_hit = stimmask & devmask & hitmask & devoccured_mask;
        compmask_miss = stimmask & devmask & ~hitmask & devoccured_mask;
        
        % Get data
        % Hits, Misses, and No dev
        hitdata = cell2mat(loopTable2.trialPup(compmask_hit));
        missdata = cell2mat(loopTable2.trialPup(compmask_miss));
        nMiss = length(missdata(:,1));
        nHit = length(hitdata(:,1));
        
        missMean = mean(missdata);
        missSEM = std(missdata)/sqrt(nMiss);
        missUpper = missMean + missSEM;
        missLower = missMean - missSEM;
        
        hitMean = mean(hitdata);
        hitSEM = std(hitdata)/sqrt(nHit);
        hitUpper = hitMean + hitSEM;
        hitLower = hitMean - hitSEM;

        % No dev data
        nd_stimmask = strcmp(ndt.stim, currstim);
        if PLOT_2nd_ND
            nodevmean = ndt.mean2{nd_stimmask};
            ndUpper = nodevmean + ndt.sem2{nd_stimmask};
            ndLower = nodevmean - ndt.sem2{nd_stimmask};
        elseif PLOT_LONG_ND
            nodevmean = ndt.mean_long{nd_stimmask};
            ndUpper = nodevmean + ndt.sem_long{nd_stimmask};
            ndLower = nodevmean - ndt.sem_long{nd_stimmask};
        elseif PLOT_ALL_ND
            nodevmean = ndt.mean{nd_stimmask};
            ndUpper = nodevmean + ndt.sem{nd_stimmask};
            ndLower = nodevmean - ndt.sem{nd_stimmask};
        else
        end

        % Trim no dev data to start at probe onset and
        % be same length as hit/miss data
        pt = new(idev)/2 +1; % to get in samples and account for 0 indexing of probe times
        pt = ceil(pt);
        plotlim = length(hitMean);
        nodevmean = nodevmean(pt:end);
        ndUpper = ndUpper(pt:end);
        ndLower = ndLower(pt:end);

        % NaN remaining timepoints if necessary
        nodevmean(end+1:plotlim) = NaN;
        ndUpper(end+1:plotlim) = NaN;
        ndLower(end+1:plotlim) = NaN;
        
        % Trim if necessary
        nodevmean = nodevmean(1:plotlim);
        ndUpper = ndUpper(1:plotlim);
        ndLower = ndLower(1:plotlim);
        
        % Save no deviant data to table for use in future plots
        nd_probes.stim(nr,1) = currstim;
        nd_probes.probe(nr,1) = currdev;
        nd_probes.ndmean{nr,1} = nodevmean;
        nd_probes.upperSEM{nr,1} = ndUpper;
        nd_probes.lowerSEM{nr,1} = ndLower;

        %-----------------------------------------------------------------%
                                   % Plot %
        %-----------------------------------------------------------------%
        cols = length(devs);
        rows = length(stims);
        
        % Scale time (for x axis)
        fs = 500;
        secs = plotlim/fs;
        x = 1:(fs*secs);
        xaxis = x/fs*1000;
        
        % Plot in color
        subplot(rows,cols,pi)
        plot(xaxis, hitMean, 'b')
        hold on
        hHit = jbfill(xaxis,hitUpper,hitLower,'b','b',1,.5);
        hold on
        plot(xaxis, missMean, 'r')
        hMiss = jbfill(xaxis,missUpper,missLower,'r','r',1,.5);
        hold on
        plot(xaxis, nodevmean, 'k', 'LineWidth', 2)
        hND = jbfill(xaxis,ndUpper,ndLower,'k','k',1,.5);
        hold on
        
        % Set figure properties
        ylim([-.5,1.2]);
        xlim([0 plotlim*2]);
        %xlabel('Time (msecs)')
        %ylabel('Norm. Pup Size (arb. units)')
        plotstim = params.plot_stimnames{istim,2};
        %titlestr = sprintf('Stim: %s, Probe: %s', plotstim, currdev{:});
        %title(titlestr, 'Interpreter', 'None')
        %legend([hHit, hMiss, hND], 'Detected Deviant', 'Undetected Deviant', 'No Deviant Occured')
        
        % Increment subplot counter
        pi = pi+1;
        nr = nr+1;
    end % dev
    
end %stim
%suptitle('Avg. pupillary response to each deviant in each stimulus')

% Save figure to file
fpath = params.paths.fig_path;
print(fullfile(fpath, 'hmnd_allDevs'), '-depsc')


%% Save nd probe table for future use
if SAVE2MAT
    fpath = params.paths.matpath;
    fstub = 'nd_probes';
    fname = fullfile(fpath,[fstub '.mat']);
    save(fname, 'nd_probes');
end

