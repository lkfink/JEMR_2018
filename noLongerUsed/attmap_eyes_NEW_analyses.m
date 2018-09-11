% Lauren Fink, Janata Lab, UC Davis
% Create new table combining pupil data and loop info
% Last edited: 20180123

% Load globals and necessary data
params = attmap_eyes_globals;
fpath = params.paths.matpath;

fstub = 'loopTable.mat';
load(fullfile(fpath, fstub))
fstub = 'pupdata.mat';
load(fullfile(fpath, fstub))

fstub = 'loopTable2.mat';
load(fullfile(fpath, fstub))

%% Create new deviant-focused table
% Want to create new version of looptable that also includes pup data
% Doing this so that everything is in one place and so that I can look at
% whether pre-dev baseline pup predicts both RT and max dilation of pup and
% hit or missed

loopTable2 = loopTable;
dl = length(loopTable2.loop_num);
% loopTable2.baselinePup = NaN{dl,1};
loopTable2.baselinePupMean200 = NaN(dl,1);
%loopTable2.baselinePupMean2000 = NaN(dl,1);
% loopTable2.trialPup = NaN{dl,1};
loopTable2.trialPupMean = NaN(dl,1);
loopTable2.trialPupMax = NaN(dl,1);
loopTable2.trialPupSlope = NaN(dl,1);

% Only add data to the table on dev trails -- this data set not good for
% loop analyses

% Find dev trials
devtrials = find(~isnan(loopTable2.probe_idx));
for idevtrial = 1:length(devtrials)
    currdev = devtrials(idevtrial);

    if loopTable2.maxObs_num(currdev) == 20
        continue
        % Because the last trial will not have enough time after the
        % deviant to observe the full pupil dilation response and will skew
        % results
        % TODO: consider taking it any way but NaNing out through end
        % samps.. though this would interfere with later analyses
    else
    end

    % Isolate pupdata of interest
    % Need to get proper sub, stim, then index pupil data
    currsub = loopTable2.subject_id(currdev);
    submask = strcmp(pupdata.subject_id, currsub);
    currstim = loopTable2.stimulus_id(currdev);
    stimmask = strcmp(pupdata.stimulus_id, currstim);
    currdata = pupdata.pupNorm(submask & stimmask);
    currdata = cell2mat(currdata);

    % Now only take chunk of data we're interested in and save
    probeIdx = loopTable.probe_idx(currdev);
    %baseline2000 = 1000; % samples (--> ms)
    baseline200 = 100; %200ms pre dev
    samps2take = 1500;

    % Save pupil data to loop table
    %loopTable2.baselinePup2000{currdev} = currdata(probeIdx-baseline2000:probeIdx-1);
    %loopTable2.baselinePupMean2000(currdev) = mean(currdata(probeIdx-baseline2000:probeIdx-1));
    basemean = mean(currdata(probeIdx-baseline200:probeIdx-1));
    loopTable2.baselinePupMean200(currdev) = basemean;

    % TODO -- consider baselining from dev onset?
    trialPup = currdata(probeIdx:probeIdx+samps2take);
    basecorrected = trialPup-basemean;
    loopTable2.trialPup{currdev} = basecorrected;

    loopTable2.trialPupMean(currdev) = mean(basecorrected);
    loopTable2.trialPupMax(currdev) = max(basecorrected);
    loopTable2.trialPupSlope(currdev) = getPupSlope(basecorrected);



end %devtrials

% -----------------------------------------------------------------------------%
%% Add no dev pup data to loopTable2

% Only take second of no dev trials for average
% (So there is no contamination from dev trial as pup resp is very slow)
bNoDev = reshape(strcmpi('no_deviant', loopTable.probe_id), [], 1);
diffVec = [1; diff(bNoDev)];
noDev2ndMask = (diffVec == 0) & (bNoDev == 1);

for isub = 1:length(unique(loopTable2.subject_id))
    currsub = loopTable2.subject_id{isub};
    submask = strcmp(pupdata.subject_id, currsub);
    submask_data = strcmp(loopTable2.subject_id, currsub);

    for istim = 1:length(unique(loopTable2.stimulus_id(submask)))
        currstim = loopTable2.stimulus_id(istim);
        stimmask = strcmp(pupdata.stimulus_id, currstim);
        stimmask_data = strcmp(loopTable2.subject_id, currsub);

        compmask_pup = submask & stimmask;
        compmask_data = submask_data & stimmask_data & noDev2ndMask;
        rows = find(compmask_data == 1);

        for irow = 1:length(rows)
            currrow = rows(irow);
            % get pupdata and add to table
            currdata = pupdata.pupNorm(compmask_pup);
            currdata = cell2mat(currdata);
            % TODO CHECK -- why 500 ? because pup response to any previous
            % dev should be done by then?
            % Changed all this 20180129. Old version still commented
            start = loopTable2.loop_start(currrow);% - 500; % should always be enough samps to do this
            endInd = loopTable2.loop_start(currrow+1);
            currdata = currdata(start:endInd);
            % TODO CHECK maybe should keep as long as possible and nanmean
            % later?
            loopTable2.noDevPup{currrow,1} = currdata; %(1:1600); % 5 keep it all the same length

        end % row
    end % stim
end % sub

% -----------------------------------------------------------------------------%
%% Clean RT and pup data
% added 20180129

% Plot RT data
hist(loopTable2.RT)

% Find outlying data
badidxs = isoutlier(loopTable2.RT);
hist(loopTable2.RT(~badidxs))

% Remove trials with outliers from subsequent analysis
loopTable2(badidxs,:) = [];


% Do the same for baseline pup mean
pre = length(loopTable2.baselinePupMean200);
badidxs = isoutlier(loopTable2.baselinePupMean200);
loopTable2(badidxs,:) = [];
fprintf('%04f percent of trials were removed from data', sum(badidxs)/pre)
% -----------------------------------------------------------------------------%

%% Append model reson out from peak Tseries

% Load table of model predictions
fstub = 'resonVals';
fname = fullfile(fpath,[fstub '.mat']);
load(fname)
   

% Pre-allocate new column
dl = length(loopTable2.loop_num);
loopTable2.resonOut = NaN(dl,1);

stims = unique(loopTable2.stimulus_id);
for istim = 1:length(stims)
    currstim = stims(istim);
    stimmask = strcmp(currstim, loopTable2.stimulus_id);
    probeids = unique(loopTable2.probe_id(stimmask));
    
    for iprobeid = 1:length(probeids)
        currprobeid = probeids(iprobeid);
        if strcmp(currprobeid, 'no_deviant')
            continue
        end
        probemask = strcmp(loopTable2.probe_id, currprobeid);
        
        compmask = stimmask & probemask;
        
        stim_reson = strcat(currstim, '.wav');
        stimmask_reson = strcmp(stim_reson, resonVals.stim);

        ind = find(strcmp(params.stim_probe_convert, currprobeid));
        probetime = params.stim_probe_convert{ind,2};
        probetime = cell2mat(probetime);
        
        probe_reson_mask = logical(resonVals.probe_time == probetime);
        comp_reson_mask = stimmask_reson & probe_reson_mask;
        
        resonVal = resonVals.modelVal(comp_reson_mask);
        
        loopTable2.resonOut(compmask) = resonVal;
        
    end % probe
end %stim
        
        





%% Save table
fpath = params.paths.matpath;
fstub = 'loopTable2';
outfname = fullfile(fpath,[fstub '.mat']);
fprintf('Saving mat file: %s\n', outfname)
save(outfname,'loopTable2')
fprintf('Matfile saved')

%% get no dev avg for future use
% % TODO likely delete all of this
% % no dev data
% noDevTable = table;
% nr = 1;
%
% stims = unique(loopTable2.stimulus_id);
% for istim = 1:length(stims)
%     currstim = stims(istim);
%     stimmask = strcmp(currstim, loopTable2.stimulus_id);
%
%     % get time for each probe within loop and avg dev surrounding
%     %maxobsnum = logical(loopTable2.maxObs_num);
%     %compmask = stimmask & maxobsnum;
%     %probes = unique(loopTable.maxProbeTime(compmask));
%     % ^ NOTE: need to use the maxobsnum to catch 0 probe time. Could
%     % alternatively add column to loopTable2 about whether probe presented.
%
%     % Why is compmask not working properly?
%     probes = unique(loopTable2.probe_id(stimmask));
%
%     for iprobe = 1:numel(probes)
%         currprobe = probes{iprobe};
%         if strcmp(currprobe, 'no_deviant')
%             continue
%         else
%         end
%         probemask = strcmp(loopTable2.probe_id, currprobe);
%         compmask = stimmask & probemask;
%         currstart = (currprobe/2); % + 501;% % to correct for zero indexing and to get in samps and correct for extra time we took before loop start
%
%
%         nodevdata = loopTable2.noDevPup(compmask);
%         nodevdata = cell2mat(nodevdata);
%
%         nodevmean = mean(nodevdata);
%         MEANnodev = mean(nodevmean);
%         SEMnodev = std(nodevdata) / sqrt(length(nodevdata(:,1))); %sqrt(length(unique(loopTable2.subject_id)));
%         SEM_mean = mean(SEMnodev);
%
%
%         % probedata = nodevmean(currstart:end);
%
%         % zero pad this out to 4000 for later plotting
%         % probedata(4000) = 0;
%
%         noDevTable.stimulus_id(nr,1) = currstim;
%         noDevTable.probe(nr,1) = currprobe;
%         noDevTable.nodev_pup{nr,1} = nodevmean;
%         noDevTable.mean(nr,1) = MEANnodev;
%         noDevTable.sem{nr,1} = SEMnodev;
%         noDevTable.semMean(nr,1) = SEM_mean;
%
%         nr = nr+1;
%     end
%
% end % stim


% -----------------------------------------------------------------------------%
%% Anlyses
% TODO - fix this! way too long. much easier way I'm sure. 
fprintf('\n\n\nBaseline Pupil correlations:')
% Baseline pupil and max evoked pup size
basePupMask = ~isnan(loopTable2.baselinePupMean200);
trialPupMask = ~isnan(loopTable2.trialPupMax);
figure();
subplot(1,2,1);
[r, p] = corr(loopTable2.baselinePupMean200(basePupMask), loopTable2.trialPupMax(trialPupMask), 'tail', 'left');
fprintf('The correlation between baseline pupil size and max evoked pupil size is: %04f\n. p = %04f\n. N = %d', r, p, sum(~isnan(loopTable2.trialPupMax(trialPupMask))));
scatter(loopTable2.baselinePupMean200(basePupMask), loopTable2.trialPupMax(trialPupMask), 'k');
xlabel('Mean baseline pupil size (arb. units)');
ylabel('Max evoked pupil size (arb. units)');
title('Correlation between baseline and max evoked pupil size');

% % Baseline pupil and mean evoked pup size
subplot(1,2,2);
[r, p] = corr(loopTable2.baselinePupMean200(basePupMask), loopTable2.trialPupMean(trialPupMask), 'tail', 'left');
fprintf('The correlation between baseline pupil size and mean evoked pupil size is: %04f\n. p = %04f\n. N = %d', r, p, sum(~isnan(loopTable2.trialPupMax(trialPupMask))));
scatter(loopTable2.baselinePupMean200(basePupMask), loopTable2.trialPupMean(trialPupMask), 'k');
xlabel('Mean baseline pupil size (arb. units)');
ylabel('Mean evoked pupil size (arb. units)');
title('Correlation between baseline pupil size and mean evoked pupil size');

% % Baseline pupil and pup velocity
figure;
[r, p] = corr(loopTable2.baselinePupMean200(basePupMask), loopTable2.trialPupSlope(basePupMask), 'tail', 'right');
fprintf('The correlation between baseline pupil size and mean evoked pupil size is: %04f\n. p = %04f\n. N = %d', r, p, sum(~isnan(loopTable2.trialPupMax(trialPupMask))));
scatter(loopTable2.baselinePupMean200(basePupMask), loopTable2.trialPupSlope(basePupMask), 'k');
xlabel('Mean baseline pupil size (arb. units)');
ylabel('Pupil Slope (arb. units)');
title('Correlation between baseline pupil size and mean evoked pupil size');


[r, p] = corr(loopTable2.baselinePupMean200(basePupMask), loopTable2.resonOut(basePupMask))%, 'tail', 'left');
[r, p] = corr(loopTable2.baselinePupMean200(basePupMask), loopTable2.curr_dB_lev(basePupMask))%, 'tail', 'left');

% TODO - fix how getting N here -- length doesn't work when using masks
figure();
scatter(loopTable2.curr_dB_lev(trialPupMask), loopTable2.trialPupMax(trialPupMask));
[r, p] = corr(loopTable2.curr_dB_lev(trialPupMask), loopTable2.trialPupMax(trialPupMask), 'tail', 'right');
fprintf('The correlation between dB level and max evoked pupil size is: %04f\n. p = %04f\n. N = %d', r, p, length(loopTable2.trialPupMax(trialPupMask)));


% RT-related
fprintf('\n\n\nRT correlations:');
% Baseline pupil mean and RT
figure();
hitmask = logical(loopTable2.hit);
compmask = hitmask & ~isnan(loopTable2.baselinePupMean200);
% TODO -- why does this corr return nan? %%%%%%%%%%%
% Left off here 20180124
scatter(loopTable2.baselinePupMean200(compmask), loopTable2.RT(compmask));
r = corr(loopTable2.baselinePupMean200(compmask), loopTable2.RT(compmask));
fprintf('The correlation between baseline pupil size and reaction time is: %04f\n, p = %04f\n. N = %d', r, p, length(loopTable2.RT(compmask)));

% dB level and RT
figure();
scatter(loopTable2.curr_dB_lev(compmask), loopTable2.RT(compmask));
r = corr(loopTable2.curr_dB_lev(compmask), loopTable2.RT(compmask));
fprintf('The correlation between dB level and reaction time is: %04f\n', r)

figure();
scatter(loopTable2.trialPupMax(compmask), loopTable2.RT(compmask));
[r, p] = corr(loopTable2.trialPupMax(compmask), loopTable2.RT(compmask), 'tail', 'right');
fprintf('The correlation between max evoked pupil size and reaction is: %04f\n', r);

figure();
scatter(loopTable2.trialPupMean(compmask), loopTable2.RT(compmask));
[r, p] = corr(loopTable2.trialPupMean(compmask), loopTable2.RT(compmask), 'tail', 'right');
fprintf('The correlation between mean evoked pupil size and reaction is: %04f\n', r);

figure();
scatter(loopTable2.trialPupSlope(compmask), loopTable2.RT(compmask));
[r, p] = corr(loopTable2.trialPupSlope(compmask), loopTable2.RT(compmask), 'tail', 'right');
fprintf('The correlation between pupil slope and reaction is: %04f\n', r);

% dB and pupil
% Relationship between pup and dB level
% sorted by hit / missed to control for attentional effects
hitmask = logical(loopTable2.hit);
nanmask = isnan(loopTable2.trialPupMax);
compmask = hitmask & ~nanmask;
subplot(121);
scatter(loopTable2.curr_dB_lev(~nanmask), loopTable2.trialPupMax(~nanmask));
[r,p] = corr(loopTable2.curr_dB_lev(~nanmask), loopTable2.trialPupMax(~nanmask));
[r,p] = corr(loopTable2.curr_dB_lev(~nanmask), loopTable2.trialPupMean(~nanmask));
% ylim([-2 6]);
% xlabel('dB Level');
% ylabel('Max pupil size');
% title('Hit Trials');
% hold on;
% subplot(122);
% scatter(loopTable2.curr_dB_lev(~hitmask), loopTable2.trialPupMax(~hitmask));
% ylim([-2 6]);
% xlabel('dB Level');
% ylabel('Max pupil size');
% title('Miss Trials');
% suptitle('Relationship between max evoked pupil size and dB contrast across all trials');

% look at individual dev just to see..
% hitmask = logical(loopTable2.hit);
% devmask = logical(loopTable2.maxProbeTime == 973);
% compmask = hitmask & devmask;
% 
% subplot(121);
% scatter(loopTable2.curr_dB_lev(compmask), loopTable2.trialPupMax(compmask));
% ylim([-2 6]);
% xlabel('dB Level');
% ylabel('Max pupil size');
% title('Hit Trials');
% hold on;
% subplot(122);
% scatter(loopTable2.curr_dB_lev(~hitmask & devmask), loopTable2.trialPupMax(~hitmask & devmask));
% ylim([-2 6]);
% xlabel('dB Level');
% ylabel('Max pupil size');
% title('Miss Trials');
% suptitle('Relationship between max evoked pupil size and dB contrast for one example deviant');


% Reson Val - related
fprintf('\n\n\n Reson Output Correlations:');
trialPupMask = ~isnan(loopTable2.trialPupMax);
figure();
subplot(3,1,1);
[r, p] = corr(loopTable2.resonOut(trialPupMask), loopTable2.trialPupMax(trialPupMask), 'tail', 'right');
fprintf('The correlation between reson out val and max evoked pupil size is: %04f\n. p = %04f\n. N = %d', r, p, sum(~isnan(loopTable2.trialPupMax(trialPupMask))));
scatter(loopTable2.resonOut(trialPupMask), loopTable2.trialPupMax(trialPupMask), 'k');
xlabel('Mean Resonator Output (arb. units)');
ylabel('Max evoked pupil size (arb. units)');
title('Correlation between resonator output and max evoked pupil size');

subplot(3,1,2);
[r, p] = corr(loopTable2.resonOut(trialPupMask), loopTable2.trialPupMean(trialPupMask), 'tail', 'right');
fprintf('The correlation between reson out val and mean evoked pupil size is: %04f\n. p = %04f\n. N = %d', r, p, sum(~isnan(loopTable2.trialPupMax(trialPupMask))));
scatter(loopTable2.resonOut(trialPupMask), loopTable2.trialPupMean(trialPupMask), 'k');
xlabel('Mean Resonator Output (arb. units)');
ylabel('Mean evoked pupil size (arb. units)');
title('Correlation between resonator output and mean evoked pupil size');

subplot(3,1,3);
[r, p] = corr(loopTable2.resonOut(hitmask), loopTable2.RT(hitmask), 'tail', 'left');
fprintf('The correlation between reson out val and RT is: %04f\n. p = %04f\n. N = %d', r, p, sum(~isnan(loopTable2.trialPupMax(trialPupMask))));
scatter(loopTable2.resonOut(hitmask), loopTable2.RT(hitmask), 'k');
xlabel('Mean Resonator Output (arb. units)');
ylabel('Reaction Time(msecs)');
title('Correlation between resonator output and reaction time');

[r, p] = corr(loopTable2.resonOut(trialPupMask), loopTable2.trialPupSlope(trialPupMask), 'tail', 'left');

[r, p] = corr(loopTable2.curr_dB_lev(trialPupMask), loopTable2.trialPupSlope(trialPupMask), 'tail', 'left');
figure();
scatter(loopTable2.curr_dB_lev(trialPupMask), loopTable2.trialPupSlope(trialPupMask));

[r, p] = corr(loopTable2.curr_dB_lev(trialPupMask), loopTable2.resonOut(trialPupMask), 'tail', 'right');


% correlations between pupil measures
[r, p] = corr(loopTable2.trialPupMax(trialPupMask), loopTable2.trialPupSlope(trialPupMask))%, 'tail', 'left');
[r, p] = corr(loopTable2.trialPupMean(trialPupMask), loopTable2.trialPupSlope(trialPupMask))%, 'tail', 'left');
[r, p] = corr(loopTable2.trialPupMean(trialPupMask), loopTable2.trialPupMax(trialPupMask))%, 'tail', 'left');
% -----------------------------------------------------------------------------%

%% Logistic regressions to predict whether hit or miss

% Organize variables
devoccured_mask = ~isnan(loopTable2.probe_idx);

% Predictors
predictors = [
    loopTable2.baselinePupMean200(devoccured_mask), ...
    loopTable2.trialPupMean(devoccured_mask), ... 
    loopTable2.trialPupMax(devoccured_mask), ...
    loopTable2.trialPupSlope(devoccured_mask), ...
    loopTable2.resonOut(devoccured_mask), ...
    loopTable2.curr_dB_lev(devoccured_mask)
    ];

% Binary outcome of trial
outcome = loopTable2.hit(devoccured_mask);
outcome = outcome+1; % because matlab wants postive integers, not 0 or 1 (now 1 or 2)

% Compute logistic regression
[B,dev,stats] = mnrfit(predictors, outcome);

% Compute additional statistics
[yhat,dlow,dhi] = mnrval(B,predictors,stats);

% Print header containing variable names.
fprintf('\n\nLogistic Regression Results:\n\n')
stat_vars = fieldnames(stats);
header = '';
for istat = 1:length(stat_vars)
    header = strcat(header, sprintf('\t %s', stat_vars{istat}));
end
sprintf(header)

% print results from each field of stats struct
% for ivar = 1:length(stat_vars)-3
%     %currvar = stat_vars(ivar);
%     disp(stats.(stat_vars{ivar}))
%     sprintf('\t')
% end
%% Plot pupil data by sub/dev hit/miss - one plot for every sub

% Subjects
subs = unique(loopTable2.subject_id);

for isub=1:length(subs)
    currsub = subs(isub);
    submask = strcmp(loopTable2.subject_id, currsub);

    figure()
    pi = 1;
    % Stimuli
    stims = unique(loopTable2.stimulus_id(submask));
    for istim = 1:length(stims)
        currstim = stims(istim);
        stimmask = strcmp(loopTable2.stimulus_id, currstim);

        % Deviants (probe ids)
        devs = unique(loopTable2.probe_id(submask & stimmask));
        ndmask = strcmp(devs, 'no_deviant');
        badmask = strcmp(devs, 'dev_hi_2086;loop'); % remove this as unique dev id
        devs = devs(~ndmask & ~badmask);

        cols = length(devs);
        rows = length(stims);

        for idev = 1:length(devs)
            currdev = devs(idev);
            if strcmp(currdev, 'dev_hi_2086')
                devmask1 = strcmp(loopTable2.probe_id, currdev);
                devmask2 = strcmp(loopTable2.probe_id, 'dev_hi_2086;loop'); % combine this probe id with standard probe id
                devmask = devmask1 + devmask2;
            else
                devmask = strcmp(loopTable2.probe_id, currdev);
            end

            % Hit / Missed
            hitmask = logical(loopTable2.hit);
            missmask = devmask & ~hitmask;

            % figure out if want to take baseline.
            % If yes, create new column in loop table and use that below in
            % plotting

            % Get data
            hitdata = loopTable2.trialPup(submask & stimmask & devmask & hitmask);
            missdata = loopTable2.trialPup(submask & stimmask & devmask & missmask);


            % Save the number of hits/miss for each dev each sub
            % Add to new table
            % TODO

            % Plot pupil
            subplot(rows,cols,pi)

            for ih = 1:length(hitdata)
                plot(hitdata{ih}, 'g');
                hold on
                xlim([0,2000]);
                ylim([-4,6]);
            end
            hold on
            for im = 1:length(missdata)
                plot(missdata{im}, 'r')
                hold on
                xlim([0,2000]);
                ylim([-4,6]);
            end
            xlabel('Time (samples). Dev onset at t=0.')
            ylabel('Norm Pup Size')
            title(currdev, 'Interpreter', 'None')


            pi = pi+1;

        end % dev

    end %stim

    %Save figure to file and close
    suptitle(currsub)
%     figureHandle = gcf;
%     fstub = currsub;
%     fpath = params.paths.fig_path;
%     fname = fullfile(fpath,fstub);
%     saveas(figureHandle, fname, '.jpg');
    %print(fname, '-djpeg')
    %close all
end % sub


% What I notice in these plots:
% - sheer number of misses for any given dev might be interestedin metric.
% --- some seem to have barely any while others have a ton of misses
% PJs data = terrible
% jnk1 data is super sloppy
% jm slop
% spikes in 03mea and 01lhs
% perhaps should go back and clean using 20 unit adjacent criteria

% plot histogram of number of hits/misses per dev. y = num subs


%% Plot pupil data by dev hit/miss - avg of previous plot

figure()
pi = 1;
% Stimuli
stims = unique(loopTable2.stimulus_id);
for istim = 1:length(stims)
    currstim = stims(istim);
    stimmask = strcmp(loopTable2.stimulus_id, currstim);

    % Deviants (probe ids)
    devs = unique(loopTable2.probe_id(stimmask));
    ndmask = strcmp(devs, 'no_deviant');
    badmask = strcmp(devs, 'dev_hi_2086;loop'); % remove this as unique dev id
    devs = devs(~ndmask & ~badmask);

    % Grab no dev data for later
    % NOTE that we will later need to plot it centered around probe time
    % This is average to whole loop
    nodevdata = loopTable2.noDevPup(stimmask);

    % get shortest length of nodev data and make all data that size
    %for irow = 1:length(nodevdata)
    sizes = cellfun(@size, nodevdata, 'UniformOutput', 0);
    sizes = cell2mat(sizes);
    lengths = unique(sizes);
    mask = find(lengths > 1);
    lengths = lengths(mask);
    minlen = min(lengths);
    for irow = 1:length(nodevdata)
        if isempty(nodevdata{irow})
            continue
        else
            nodevdata{irow} = nodevdata{irow}(1:minlen);
        end
    end

    nodevdata = cell2mat(nodevdata);

    nodevmean = mean(nodevdata);
    MEANnodev = mean(nodevmean);
    SEMnodev = std(nodevdata) / sqrt(length(nodevdata(:,1))); %sqrt(length(unique(loopTable2.subject_id)));
    SEM_mean = mean(SEMnodev);

    cols = length(devs);
    rows = length(stims);

    for idev = 1:length(devs)
        currdev = devs(idev);
        if strcmp(currdev, 'dev_hi_2086')
            devmask1 = strcmp(loopTable2.probe_id, currdev);
            devmask2 = strcmp(loopTable2.probe_id, 'dev_hi_2086;loop'); % combine this probe id with standard probe id
            devmask = devmask1 + devmask2;
        else
            devmask = strcmp(loopTable2.probe_id, currdev);
        end

        % Hit / Missed
        hitmask = logical(loopTable2.hit);
        missmask = devmask & ~hitmask;

        % Get data
        hitdata = loopTable2.trialPup(stimmask & devmask & hitmask);
        missdata = loopTable2.trialPup(stimmask & devmask & missmask);
        hitdata = cell2mat(hitdata);
        missdata = cell2mat(missdata);
        nsubsMiss = length(missdata(:,1));
        nsubsHit = length(hitdata(:,1));

        missMean = mean(missdata);
        missSEM = std(missdata)/sqrt(nsubsMiss);
        missUpper = missMean + missSEM;
        missLower = missMean - missSEM;

        hitMean = mean(hitdata);
        hitSEM = std(hitdata)/sqrt(nsubsHit);
        hitUpper = hitMean + hitSEM;
        hitLower = hitMean - hitSEM;

        % NOTE: the approach commented below does not work because no dev
        % data cannot just be wrapped around itself.
%         % Index no dev data accordingly
%         ind = find(strcmp(params.stim_probe_convert, currdev));
%         probetime = params.stim_probe_convert{ind,2};
%         probetime = cell2mat(probetime);
%         probetime = probetime / 2; % to get in samples
%         probetime = probetime + 1; % to correct for 0 indexing
%
%
%         nodevstart = nodevmean(probetime:end);
%
%         %nodevstart(end+1:length(missMean)) = NaN;
%         %concat_nd = nodevstart;
%         len_nd = length(nodevstart);
%         if len_nd < length(missMean)
%             samps2take = length(missMean) - len_nd;
%             if samps2take > len_nd
%                 samps2take = minlen;
%             else
%                 addtodata = nodevmean(1:samps2take);
%                 concat_nd = horzcat(nodevstart, addtodata);
%             end
%         elseif len_nd > length(missMean)
%             % do something TODO
%         else
%         end

        % Scale time (for x axis)
        fs = 500;
        secs = length(hitMean)/fs;
        x = 1:(fs*secs);
        xaxis = x/fs*1000;

        % use no dev mean as chance value
        chanceVec = 1:numel(hitMean);
        for ic = 1:length(chanceVec)
            chanceVec(ic) = MEANnodev;
        end


        % Plot pupil
        subplot(rows,cols,pi)
        plot(xaxis, hitMean, 'g')
        hold on
        hHit = jbfill(xaxis,hitUpper,hitLower, 'g','g',1,.5);
        hold on
        plot(xaxis, missMean, 'r')
        hMiss = jbfill(xaxis,missUpper,missLower,'r','r',1,.5);
        hold on
        plot(xaxis, chanceVec, ':k', 'LineWidth', 2)
        hold on
        plot(xaxis, chanceVec+SEM_mean, ':k')
        hold on
        plot(xaxis, chanceVec-SEM_mean, ':k')
        %hChance = jbfill(xaxis,chanceVec+SEM_mean,chanceVec-SEM_mean,'k','k',1,.5);
        %hnodev = jbfill(xaxis,ndUpper,ndLower, 'k', 'k', 1, .5);

        xlim([0,3000]);
        ylim([-.6, 1.2]);

        xlabel('Time (msecs)')
        ylabel('Norm. Pup Size (arb. units)')
        title(currdev, 'Interpreter', 'None')

        % Need to add standard error to these and need to get no dev
        % traces..


        pi = pi+1;

    end % dev

end %stim
suptitle('Avg. pupillary response to each deviant in each stimulus')



%% Plot avg hit / missed for all devs

% Create masks
hitmask = logical(loopTable2.hit);
missmask = devmask & ~hitmask;

% Get data
% Hits, Misses, and No dev
hitdata = loopTable2.trialPup(hitmask);
missdata = loopTable2.trialPup(missmask);
hitdata = cell2mat(hitdata);
missdata = cell2mat(missdata);
nsubsMiss = length(missdata(:,1));
nsubsHit = length(hitdata(:,1));

missMean = mean(missdata);
missSEM = std(missdata)/sqrt(nsubsMiss);
missUpper = missMean + missSEM;
missLower = missMean - missSEM;

hitMean = mean(hitdata);
hitSEM = std(hitdata)/sqrt(nsubsHit);
hitUpper = hitMean + hitSEM;
hitLower = hitMean - hitSEM;

nddata = loopTable2.noDevPup;
sizes = cellfun(@size, nddata, 'UniformOutput', 0);
sizes = cell2mat(sizes);
lengths = unique(sizes);
mask = find(lengths > 1);
lengths = lengths(mask);
minlen = min(lengths);
for irow = 1:length(nddata)
   if isempty(nddata{irow})
       continue
   else
       nddata{irow} = nddata{irow}(1:minlen);
   end
end

nddata = cell2mat(nddata);

nodevmean = mean(nddata);
MEANnodev = mean(nodevmean);
SEMnodev = std(nddata) / sqrt(length(nddata(:,1))); %sqrt(length(unique(loopTable2.subject_id)));
SEM_mean = mean(SEMnodev);


% Plot

% Scale time (for x axis)
fs = 500;
secs = length(hitMean)/fs;
x = 1:(fs*secs);
xaxis = x/fs*1000;

% Plot pupil
figure()
plot(xaxis, hitMean, 'g')
hold on
hHit = jbfill(xaxis,hitUpper,hitLower,'g','g',1,.5);
hold on
plot(xaxis, missMean, 'r')
hMiss = jbfill(xaxis,missUpper,missLower,'r','r',1,.5);
hold on
MEANnodev_plot = 1:numel(xaxis);
for ic = 1:length(MEANnodev_plot)
    MEANnodev_plot(ic) = MEANnodev;
end
plot(xaxis, MEANnodev_plot, ':k', 'LineWidth', 2)
hold on
plot(xaxis, MEANnodev_plot+SEM_mean, ':k', 'LineWidth', 2)
hold on
plot(xaxis, MEANnodev_plot-SEM_mean, ':k', 'LineWidth', 2)
hold on

ylim([-.4,1]);
xlim([0 3000]);

xlabel('Time (msecs)')
ylabel('Norm. Pup Size (arb. units)')
title('Avg. pupil trace for hit (green) vs. missed (red) deviants')
set(gca, 'fontsize', 20)


%% 20180130
% this script is done. think we have all plots we would want from individ
% trial data and dev related events. Except would like to have model vals
% in here for each probe time so can correlate that with pup mean, max, and 
% rt. TODO - DONE

% Will do that later because code to do that should be in MPP stuff. Will 
% Now move on to MPP stuff. 

% Eventually plan to make new clean scripts from Pup PIPELINE and this
% script where everything is just in looptable and figure plotting happens
% in separate scripts. Will deal with that later. Should be easy in Atom 
% to just rename everything in the project loopTable2 to loopTable. 
% But don't want to overwrite these scripts in case anything goes wrong. 
% Will start new project? % DONE - didn't rename but separated scripts
