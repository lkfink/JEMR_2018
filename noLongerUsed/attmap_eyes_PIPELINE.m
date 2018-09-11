% Lauren Fink, Janata Lab, UC Davis
% Unified pre-processing script for attmap_eyetrack
% First created: 20160505
% Last edited: 20180123

% -----------------------------------------------------------------------------%
% Set constants and load experiment parameters
CONVERT_FROM_CSV = 0;
SAVE2MAT = 1;
LOAD_MATFILES = 1;
LOAD_PUPDATA = 1;
LOAD_LOOPTABLE = 1;

if CONVERT_FROM_CSV
    LOAD_MATFILES = 0;
end

% Load the globals file
params = attmap_eyes_globals;

% Load the subject info file
sinfo = attmap_eyes_subinfo;

% -----------------------------------------------------------------------------%
%% Convert from CSV
if CONVERT_FROM_CSV
    % List filenames we want to process
    dirlist = dir(fullfile(params.paths.data_path,'*.csv'));
    nfiles = length(dirlist);

    % Load in the data for each file
    ds = cell(nfiles,1);
    for ifile = 1:nfiles
        fname = fullfile(params.paths.data_path, dirlist(ifile).name);
        fprintf('Loading data from file %d/%d: %s\n', ifile, nfiles, fname);
        ds{ifile} = ensemble_csv2datastruct(fname);

        % convert to a table
        datatable = ensemble_datastruct2table(ds{ifile});

        % save to a .mat file if desired
        if SAVE2MAT
            [fpath,fstub] = fileparts(fname);
            outfname = fullfile(fpath,[fstub '.mat']);
            fprintf('Saving mat file: %s\n', outfname)
            save(outfname,'datatable')
            fprintf('Matfile saved')
        end

        % Write over the ds entry
        ds{ifile} = datatable;
    end
end % if CONVERT_FROM_CSV

% -----------------------------------------------------------------------------%
%% load in all .mat files
if LOAD_MATFILES
    dirlist = dir(fullfile(params.paths.data_path,'*.mat'));
    nfiles = length(dirlist);
    for ifile = 1:nfiles
        fname = fullfile(params.paths. data_path, dirlist(ifile).name);
        fprintf('Loading data from: %s\n', fname);
        tmp = load(sprintf('%s',fname));
        ds{ifile} = tmp.datatable;
        clear tmp
    end
end % if LOAD_MATFILES

% -----------------------------------------------------------------------------%
%% Preprocess pupil data

nsubs = length(ds);
ntrials = zeros(nsubs,1);

% Prepare our output datatable
pupdata = table;

% Loop through each subject's data
nr = 0;
for isub = 1:nsubs
    currSubjectData = ds{isub};
    subid = unique(currSubjectData.RECORDING_SESSION_LABEL);
    subid = subid{1};
    fprintf('Processing sub %d: %s\n',isub, subid);

    % Get subject specific information from info file
    currsubInfo = sinfo(strcmp({sinfo.id}, subid));
    if isempty(currsubInfo)
        error('Unable to locate subject information for: %s\n', subid)
    end

    % Figure out how many trials we have for this subject
    ntrials(isub) = numel(unique(currSubjectData.TRIAL_INDEX));

    % Flag moments in time when there was a blink or a saccade as being
    % invalid pupil data
    pupRaw = currSubjectData.RIGHT_PUPIL_SIZE;
    pupRaw(currSubjectData.RIGHT_IN_BLINK==1) = NaN;
    pupRaw(currSubjectData.RIGHT_IN_SACCADE==1) = NaN;

    % Figure out which rows belong to which trial
    [trialmaskMtx, trial_idxs] = make_mask_mtx(currSubjectData.TRIAL_INDEX);

    % Loop over each of the stimulus runs for this subject
    for itrial = 1:ntrials(isub)
        nr = nr+1;

        % Get  stimulus ID
        stimid = currsubInfo.stimulus_order{itrial};

        % Output basic info to table
        pupdata.subject_id{nr,1} = subid;
        pupdata.trial_id(nr,1) = itrial;
        pupdata.stimulus_id{nr,1} = stimid;

        % Deal only with current run data
        trialmask = trialmaskMtx(:,itrial);
        trialdata = currSubjectData(trialmask,:);
        rawdata = pupRaw(trialmask);

        % Interpolate missing data for this run
        % See nanInterp function for more details
        nsamps = 25; % remove 50ms on each side of blink
        maxDev = 20; % flag any sample that is greater than 20 arb units
        % away from previous sample
        fprintf('Performing pupil interpolation for trial: %d\n',itrial);
        [interp_data, perc_interp] = nanInterp(rawdata, nsamps, maxDev);

        % Save interpolated data to table
        pupdata.pupInterp{nr,1} = interp_data; %(:);
        pupdata.perc_interp(nr,1) = perc_interp;

        % High pass filter to remove any large drift in trial data
        [b,a] = butter(3,0.05/250,'high'); %20 seconds
        % freqz(b,a) %if want to image filter
        hfiltered = filtfilt(b,a,interp_data);
        pupdata.hfPup{nr,1} = hfiltered;

        % Normalize data
        pupMean = mean(hfiltered);
        pupStd = std(hfiltered);
        pupdata.pupMean(nr,1) = pupMean;
        pupdata.pupStd(nr,1) = pupStd;
        fprintf('Norming pupil for trial: %d\n',itrial);
        pupNorm = (hfiltered-pupMean)/pupStd;
        pupdata.pupNorm{nr,1} = pupNorm;

    end %itrial (stim run)

end %isub

% -----------------------------------------------------------------------------%
%% Quality Control

% Find data requiring greater than 30% interpolation
badData = table;
nr = 1;
badIdxs = find(pupdata.perc_interp > 30);
for bi = 1:length(badIdxs)
    curri = badIdxs(bi);
    fprintf('Subject %s, trial %d required too much interpolation and was discarded\n', pupdata.subject_id{curri,1},pupdata.trial_id(curri,1))
    badData.subject_id{nr,1} = pupdata.subject_id{curri,1};
    badData.trial(nr,1) = pupdata.trial_id(curri,1);
    nr = nr+1;
end

% Remove this chunk before making public ---------- TODO -----------------------
% Remove any other subjects with technical glitches
badData.subject_id{nr,1} = 'pj'; %adding this because I know from experiment log files that there was a technical recording error during trial 1.
badData.trial(nr,1) = 1;
badind = find(strcmp(pupdata.subject_id, 'pj') & pupdata.trial_id == 1);
pupdata(badind,:) = [];

% lhs and 10snk also fit in this category of technical error (but interp
% caught them).
% Remove this before making public ----------- TODO ----------------------------

% Remove bad data from pupdata table
gooddataMask = pupdata.perc_interp <= 29.9999; % removes anything requiring 30% interpolation or above - LF 20180123
predata = length(pupdata.trial_id);
pupdata = pupdata(gooddataMask,:);
postdata = length(pupdata.trial_id);
perc_data_removed = predata-postdata/predata;
fprintf('%d percent of data was removed during quality control', perc_data_removed);

% -----------------------------------------------------------------------------%
%% Save table containing pupil transformations for each run, each sub
fpath = params.paths.matpath;
fstub = 'pupdata';
fname = fullfile(fpath,[fstub '.mat']);
save(fname, 'pupdata');
fprintf('Matfile saved')

% -----------------------------------------------------------------------------%
%% Load pupdata
if LOAD_PUPDATA
    fpath = params.paths.matpath;
    fstub = 'pupdata';
    fname = fullfile(fpath,[fstub '.mat']);
    load(fname)
end

% -----------------------------------------------------------------------------%
%% Create loop table - a table containing information about every trial for
% each run, each subject (e.g. whether deviant presented, which one, etc.)

nsubs = length(ds);
ntrials = zeros(nsubs,1);

% Preallocate output datatable
loopTable = table;

% Loop through subjects
nr = 1;
for isub = 1:nsubs
    currSubjectData = ds{isub};
    subid = unique(currSubjectData.RECORDING_SESSION_LABEL);
    subid = subid{1};
    fprintf('Processing sub %d: %s\n',isub, subid);

    % Get subject specific information
    currsubInfo = sinfo(strcmp({sinfo.id}, subid));
    if isempty(currsubInfo)
        error('Unable to locate subject information for: %s\n', subid)
    end

    % Get subject specific MAX information
    currsubMaxFile = currsubInfo.max_output;
    if currsubMaxFile == 0
        fprintf('No Max data for: %s\n', subid)
        continue %go to next sub (- don't include this one)
    else % read data file
        currsubMaxData = ensemble_csv2datastruct(currsubMaxFile);
        fprintf('Loading Max file: %s\n', currsubMaxFile)

        % convert to a table
        currsubMaxData = ensemble_datastruct2table(currsubMaxData);
    end

    % Figure out how many trials we have for this subject
    ntrials(isub) = numel(unique(currSubjectData.TRIAL_INDEX));

    % Figure out which rows belong to which trial
    [trialmaskMtx, trial_idxs] = make_mask_mtx(currSubjectData.TRIAL_INDEX);

    % Loop over each of the stimulus trials for this subject
    for itrial = 1:ntrials(isub)

        % Get stimulus ID and mask data
        stimid = currsubInfo.stimulus_order{itrial};
        trialmask = trialmaskMtx(:,itrial);
        trialdata = currSubjectData(trialmask,:);
        trialmaxMask = currsubMaxData.run_num == itrial;
        maxtrialdata = currsubMaxData(trialmaxMask,:);

        % Now go through every loop and segregate into control, and deviant
        % trials. Remember, there are 4 probed locations for each stimulus.
        % Also need to know hit vs. missed
        hitMsgMask = ismember(trialdata.SAMPLE_MESSAGE, params.eyetracker.messages.hit);
        loopOnsetMask = ismember(trialdata.SAMPLE_MESSAGE, params.eyetracker.messages.loop_start); % Get a mask of loop onset indices
        loopIdxs = find(loopOnsetMask);
        nloops = length(loopIdxs);
        probe_mask = ismember(trialdata.SAMPLE_MESSAGE, params.eyetracker.messages.probe_id);
        probeIdxs = find(probe_mask);

        for iloop = 1:nloops

            % Output info to table
            loopTable.subject_id{nr,1} = subid;
            loopTable.trial_id(nr,1) = itrial;
            loopTable.stimulus_id{nr,1} = stimid;
            loopTable.loop_num(nr,1) = iloop;
            loopStart = loopIdxs(iloop);
            loopTable.loop_start(nr,1) = loopStart;

            if iloop == nloops
                loopEnd = size(trialdata,1);
            else
                loopEnd = loopIdxs(iloop+1)-1; %idx of next loop
            end

            % Create a loop mask
            loopmask = false(size(trialdata.SAMPLE_MESSAGE));
            loopmask(loopStart:loopEnd) = true;

            % Deal with issue of MAX saying hit, and eyetracker
            % not having hit idx - LF 20161024
            loopmask2 = false(size(trialdata.SAMPLE_MESSAGE));
            loopmask2(loopStart:loopEnd+500) = true; % fine to take this many sample because next trial is always nodev

            % Create probe mask
            probeIdx = find(loopmask & probe_mask);
            if isempty(probeIdx) % all zeros, no probe occurs (no dev trial)
                no_deviant = 'no_deviant';
                loopTable.probe_id{nr,1} = no_deviant;
                loopTable.probe_idx(nr,1) = NaN;
                loopTable.hit(nr,1) = 0;
                loopTable.hit_idx(nr,1) = NaN;

            else %between this loop and next, probe
                % make sure there was only one probe
                if length(probeIdx) > 1
                    probeIdx = probeIdx(1); %take first probe
                    warning('More than one probe presented on loop %d, sub %s', iloop, subid)
                end

                probeid = trialdata.SAMPLE_MESSAGE(probeIdx);
                loopTable.probe_id(nr,1) = probeid;
                loopTable.probe_idx(nr,1) = probeIdx;

                probetime = regexp(probeid,'\d{1,4}','match');
                probetime = str2double(probetime{:});
                maxprobemask = false(size(maxtrialdata.probe_time));
                pti = find(maxtrialdata.probe_time == probetime);
                maxprobemask(pti) = true;


                % Check whether it is a hit
                % Corrected loopmask here too - LF 20161024
                if iloop == nloops
                    hitIdx = find(loopmask & hitMsgMask);
                elseif iloop == nloops-1
                    hitIdx = find(loopmask & hitMsgMask); % because this gets stuck on last few loops..
                else
                    hitIdx = find(loopmask2 & hitMsgMask); %add time here to deal with new found delays... but what if that introduces new issues...
                end % checking if last loop

                if isempty(hitIdx) % no hit
                    loopTable.hit(nr,1) = 0;
                    loopTable.hit_idx(nr,1) = NaN;
                else %hit
                    loopTable.hit(nr,1) = 1;
                    loopTable.hit_idx(nr,1) = hitIdx;
                end

                % Append all Max data for this sub, this loop
                % - add 1 to iloop to account for loop discrepency
                %   (tracker never receives first loop message)
                if ismember(iloop+1, maxtrialdata.trial_num(maxprobemask))
                    rowIdx = find(maxtrialdata.trial_num == iloop+1);
                    loopTable.maxTrial_num(nr,1) = maxtrialdata.trial_num(rowIdx); %TODO FIX: this index is incorrect for max trial num.. but don't believe we end up using this later so why write it?
                    loopTable.maxObs_num(nr,1) = maxtrialdata.obs_num(rowIdx);
                    loopTable.maxMeanPDF(nr,1) = maxtrialdata.mean_pdf(rowIdx);
                    loopTable.maxConverged(nr,1) = maxtrialdata.converged(rowIdx);
                    loopTable.maxProbeTime(nr,1) = maxtrialdata.probe_time(rowIdx);
                    loopTable.maxProbeCond(nr,1) = maxtrialdata.probe_cond(rowIdx);
                    loopTable.maxSubResp(nr,1) = maxtrialdata.sub_resp(rowIdx);
                    loopTable.maxSubID(nr,1) = maxtrialdata.subject_id(rowIdx);

                elseif ismember(iloop+2, maxtrialdata.trial_num(maxprobemask))
                    rowIdx = find(maxtrialdata.trial_num == iloop+2);
                    loopTable.maxTrial_num(nr,1) = maxtrialdata.trial_num(rowIdx); % TODO FIX: same here 
                    loopTable.maxObs_num(nr,1) = maxtrialdata.obs_num(rowIdx);
                    loopTable.maxMeanPDF(nr,1) = maxtrialdata.mean_pdf(rowIdx);
                    loopTable.maxConverged(nr,1) = maxtrialdata.converged(rowIdx);
                    loopTable.maxProbeTime(nr,1) = maxtrialdata.probe_time(rowIdx);
                    loopTable.maxProbeCond(nr,1) = maxtrialdata.probe_cond(rowIdx);
                    loopTable.maxSubResp(nr,1) = maxtrialdata.sub_resp(rowIdx);
                    loopTable.maxSubID(nr,1) = maxtrialdata.subject_id(rowIdx);
                else
                end

            end %probe conditional branching (hit vs. miss)
            nr = nr+1;

        end %loop

    end %trial

end %sub


% -----------------------------------------------------------------------------%
%% Clean up loopTable

% -----------------------------------------------------------------------------%
% Get RT in proper units
loopTable.RT = loopTable.hit_idx - loopTable.probe_idx; % to get RT (in sample time)
loopTable.RT = loopTable.RT*1000/params.eyetracker.Fs; % to put RT into msecs

% -----------------------------------------------------------------------------%
% Remove bad data from loop table (based on previous interpolation analysis)
for icount = 1:length(badData.subject_id)
    subj = badData.subject_id{icount};
    trial = badData.trial(icount);
    submask = strcmp(subj,loopTable.subject_id);
    trialmask = loopTable.trial_id == trial;
    compmask = submask & trialmask;
    removeIdxs = find(compmask == 1);
    loopTable([removeIdxs],:) = []; %Tnew([18,20,21],:) = [];
end %going through badData table

% -----------------------------------------------------------------------------%
% Get maxMeanPDF converted to curr dB level
% -- so that we can look at correlation between dB contrast and pupil response

% TODO ---- delete before making public -----------------------------------
% Issue w MAX probe time in loop table -- not grabbed when probe time == 0
%- LF - fixed 11/21/16, need to use probe label string instead of
% probe time; Also fixed in creation of pupDbTbl

% Added this section of code to PIPELINE to re-save loopTable with currDb
% info. - LF - 11-29-16
% TODO ---- delete before making public -----------------------------------

% Initialize new column in loopTable
numObs = length(loopTable.maxObs_num);
loopTable.curr_dB_lev = zeros(numObs,1);

% Go through by subject and set curr dev = maxMeanPDF of prev dev (except
% for first instance)
subids = unique(loopTable.subject_id);
nsubs = length(subids);

for isub = 1:nsubs
    currsub = subids(isub);
    submask = strcmp(loopTable.subject_id, currsub);

    stimids = unique(loopTable.stimulus_id(submask)); %accounting for sub
    nstims = length(stimids);

    for istim = 1:length(stimids)
        currstim = stimids(istim);
        stimmask = strcmp(loopTable.stimulus_id, currstim);

        compmask = submask & stimmask;

        allprobeids = unique(loopTable.probe_id(compmask)); %accounting for sub and stim
        nodev = strcmp(allprobeids, 'no_deviant');
        probeids = allprobeids(~nodev);
        nprobes = length(probeids);

        % Get proper dB level for each trial
        for iprobe = 1:nprobes
            currprobe = probeids(iprobe);
            probemask = strcmp(currprobe, loopTable.probe_id);
            compmask = submask & stimmask & probemask;
            probeIdxs = find(compmask == 1);

            for ipIdx = 2:length(probeIdxs) % first should be ten
                prev = ipIdx-1;
                currProbeIdx = probeIdxs(ipIdx);
                prevProbeIdx = probeIdxs(prev);
                dBlev = loopTable.maxMeanPDF(prevProbeIdx);
                loopTable.curr_dB_lev(currProbeIdx) = dBlev;
            end %probeIdx

        end % iprobe
    end %stim
end %subs

% Replace first observation with 10s
% This is what initial dB level was set to
fix = find(loopTable.maxObs_num == 1);
for i = 1:length(fix)
    currIdx = fix(i);
    loopTable.curr_dB_lev(currIdx) = 10;
end

% -----------------------------------------------------------------------------%
%% Save loopTable

fpath = params.paths.matpath;
fstub = 'loopTable';
outfname = fullfile(fpath,[fstub '.mat']);
fprintf('Saving mat file: %s\n', outfname)
save(outfname,'loopTable')
fprintf('Matfile saved')

% -----------------------------------------------------------------------------%
%% Load loopTable
if LOAD_LOOPTABLE == 1
    fpath = params.paths.matpath;
    fstub = 'loopTable';
    fname = fullfile(fpath,[fstub '.mat']);
    load(fname)
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% stopped updating tables with newer preproced data after this

% TODO: delete everything below! before making public
% Not deleting at the moment in case anything is actually necessary but unlikely
% -----------------------------------------------------------------------------%
% -----------------------------------------------------------------------------%
% -----------------------------------------------------------------------------%
% -----------------------------------------------------------------------------%
% -----------------------------------------------------------------------------%
% -----------------------------------------------------------------------------%
% -----------------------------------------------------------------------------%
% -----------------------------------------------------------------------------%
% -----------------------------------------------------------------------------%




%% Parse pup data by sub
% This parses pup data by indices of interest from loopTable
% A more condensed version of loopTable is created, with pup data included by sub.

% If not working, make sure pj's data is removed
% submask = strcmp('pj',loopTable.subject_id);
% removeIdxs = find(submask ==1);
% loopTable([removeIdxs],:) = [];

IOIpup = table;
nr = 0;

subids = unique(loopTable.subject_id);
nsubs = length(subids);
for isub = 1:nsubs
    currsub = subids(isub);
    submask = strcmp(loopTable.subject_id, currsub);

    stimids = unique(loopTable.stimulus_id(submask)); %accounting for sub
    nstims = length(stimids);

    % only take second of no dev trials for average
    bNoDev = reshape(strcmpi('no_deviant', loopTable.probe_id), [], 1);
    diffVec = [1; diff(bNoDev)];
    noDev2ndMask = (diffVec == 0) & (bNoDev == 1);


    for istim = 1:nstims
        currstim = stimids(istim);
        if strcmp(currstim, 'prA_4_3i_1v_107bpm') %will figure out how to deal with issues in this stim later; ignore for now.
            continue
        else
        end
        stimmask = strcmp(loopTable.stimulus_id, currstim);
        devids = unique(loopTable.probe_id(submask & stimmask)); %accounting for sub and stim
        nprobes = length(devids);

        %mask pup data
        subdatamask = strcmp(currsub, pupdata.subject_id);
        stimdatamask = strcmp(currstim, pupdata.stimulus_id);
        compmask = subdatamask & stimdatamask;
        currdata = pupdata(compmask,:);
        currdata = cell2mat(currdata.pupNorm);

        if isempty(currdata) % in the event that this sub/stim combo got thrown out of pupdata due to too much interpolation
            continue
        else

            for iprobe = 1:nprobes
                nr = nr+1;
                currprobe = devids(iprobe);
                probemask = strcmp(loopTable.probe_id, currprobe); %%%%%%%%

                compIOImask = submask & stimmask & probemask;
                hitmask = logical(loopTable.maxSubResp);
                missmask = ~hitmask;
                convergedMask = logical(loopTable.maxConverged);

                IOIpup.subject_id(nr,1) = currsub;
                IOIpup.stimulus_id(nr,1) = currstim;
                IOIpup.dev_label(nr,1) = currprobe;


                %set sample extraction params
                preloopSamps = 1000;
                postloopSamps = 2200; % changed this from 2000 to aid in pupilDeconv analysis

                if strcmp(currprobe, 'no_deviant')
                    noDevIdxs = loopTable.loop_start(submask & stimmask & noDev2ndMask);
                    ntrials = length(noDevIdxs);
                    noDevData = zeros(ntrials, preloopSamps+postloopSamps+1);
                    for i = 2:ntrials %first instance is at very begininng of run (no time to entrain)
                        currIdx = noDevIdxs(i);
                        pre = currIdx - preloopSamps;
                        post = currIdx + postloopSamps;
                        noDevData(i,:) = currdata(pre:post);
                    end
                    noDevData(1,:) = [];
                    meanNoDev = mean(noDevData);
                    SEMnoDev = std(noDevData)/sqrt(ntrials-3); %because cutting off first and last loop

                    % save mean and SEM to table
                    IOIpup.noDevMean{nr,1} = meanNoDev;
                    IOIpup.noDevSEM{nr,1} = SEMnoDev;
                    IOIpup.meanPDF(nr,1) = 0;

                else %dev
                    % Save hit data
                    hitIdxs = loopTable.loop_start(compIOImask & hitmask); % Maybe should do this from prbe_idx, rather than loopstart - LF 11-30-16
                    ntrials = length(hitIdxs);
                    if ntrials == 0
                        IOIpup.hitMean{nr,1} = NaN;
                        IOIpup.hitSEM{nr,1} = NaN;
                    else
                        hitData = zeros(ntrials, preloopSamps+postloopSamps+1);
                        for i = 1:ntrials-1 %last trial might not have enough samps
                            currIdx = hitIdxs(i);
                            pre = currIdx - preloopSamps;
                            post = currIdx + postloopSamps;
                            hitData(i,:) = currdata(pre:post);
                        end
                        hitData(1,:) = [];
                        meanHit = mean(hitData);
                        SEMhit = std(hitData)/sqrt(ntrials-1);
                        IOIpup.hitMean{nr,1} = meanHit;
                        IOIpup.hitSEM{nr,1} = SEMhit;
                    end

                    %Save miss data
                    missIdxs = loopTable.loop_start(compIOImask & missmask);
                    ntrials = length(missIdxs);
                    if ntrials == 0
                        IOIpup.missMean{nr,1} = NaN;
                        IOIpup.missSEM{nr,1} = NaN;
                    else
                        missData = zeros(ntrials,preloopSamps+postloopSamps+1);
                        for i = 1:ntrials-1 %last trial might not have enough samps after
                            currIdx = missIdxs(i);
                            pre = currIdx - preloopSamps;
                            post = currIdx + postloopSamps;
                            missData(i,:) = currdata(pre:post);
                        end
                        missData(1,:) = [];
                        meanMiss = mean(missData);
                        SEMmiss = std(missData)/sqrt(ntrials-1);
                        IOIpup.missMean{nr,1} = meanMiss;
                        IOIpup.missSEM{nr,1} = SEMmiss;
                    end
                    meanPDF = loopTable.maxMeanPDF(compIOImask & convergedMask);
                    if isempty(meanPDF)
                        IOIpup.meanPDF(nr,1) = 0;
                    else
                        IOIpup.meanPDF(nr,1) = meanPDF;
                    end % checking that this sub had this stim/probe combo and therefore a meanPDF
                end
            end
        end
    end
end


fpath = params.paths.matpath;
fstub = 'IOIpup';
outfname = fullfile(fpath,[fstub '.mat']);
fprintf('Saving mat file: %s\n', outfname)
save(outfname,'IOIpup')







%% Create 2nd version of IOIpup - IOIpup2 - that averages probe trials around deviant onset, rather than loop start
% 11-30-16 - I know this is a stupid thing to do. But might want either one
% of these versions for separate types of analyses. The only thing that is
% different between this section and the one above is line 725 + 746

IOIpup2 = table;
nr = 0;

subids = unique(loopTable.subject_id);
nsubs = length(subids);
for isub = 1:nsubs
    currsub = subids(isub);
    submask = strcmp(loopTable.subject_id, currsub);

    stimids = unique(loopTable.stimulus_id(submask)); %accounting for sub
    nstims = length(stimids);

    % only take second of no dev trials for average
    bNoDev = reshape(strcmpi('no_deviant', loopTable.probe_id), [], 1);
    diffVec = [1; diff(bNoDev)];
    noDev2ndMask = (diffVec == 0) & (bNoDev == 1);


    for istim = 1:nstims
        currstim = stimids(istim);
        %         if strcmp(currstim, 'prA_4_3i_1v_107bpm') %will figure out how to deal with issues in this stim later; ignore for now.
        %             continue
        %         else
        %         end % checking this out 1-11-17
        stimmask = strcmp(loopTable.stimulus_id, currstim);
        devids = unique(loopTable.probe_id(submask & stimmask)); %accounting for sub and stim
        nprobes = length(devids);

        %mask pup data
        subdatamask = strcmp(currsub, pupdata.subject_id);
        stimdatamask = strcmp(currstim, pupdata.stimulus_id);
        compmask = subdatamask & stimdatamask;
        currdata = pupdata(compmask,:);
        currdata = cell2mat(currdata.pupNorm);

        if isempty(currdata) % in the event that this sub/stim combo got thrown out of pupdata due to too much interpolation
            continue
        else

            for iprobe = 1:nprobes
                nr = nr+1;
                currprobe = devids(iprobe);
                probemask = strcmp(loopTable.probe_id, currprobe); %%%%%%%%

                compIOImask = submask & stimmask & probemask;
                hitmask = logical(loopTable.maxSubResp);
                missmask = ~hitmask;
                convergedMask = logical(loopTable.maxConverged);

                IOIpup2.subject_id(nr,1) = currsub;
                IOIpup2.stimulus_id(nr,1) = currstim;
                IOIpup2.dev_label(nr,1) = currprobe;


                %set sample extraction params
                preloopSamps = 1000; % even though pre"loop"samps. also applies to pre"dev"samps
                postloopSamps = 2200; % changed this from 2000 to aid in pupilDeconv analysis

                if strcmp(currprobe, 'no_deviant')
                    noDevIdxs = loopTable.loop_start(submask & stimmask & noDev2ndMask);
                    ntrials = length(noDevIdxs);
                    noDevData = zeros(ntrials, preloopSamps+postloopSamps+1);
                    for i = 2:ntrials %first instance is at very begininng of run (no time to entrain)
                        currIdx = noDevIdxs(i);
                        pre = currIdx - preloopSamps;
                        post = currIdx + postloopSamps;
                        noDevData(i,:) = currdata(pre:post);
                    end
                    noDevData(1,:) = [];
                    meanNoDev = mean(noDevData);
                    SEMnoDev = std(noDevData)/sqrt(ntrials-3); %because cutting off first and last loop

                    % save mean and SEM to table
                    IOIpup2.noDevMean{nr,1} = meanNoDev;
                    IOIpup2.noDevSEM{nr,1} = SEMnoDev;
                    IOIpup2.meanPDF(nr,1) = 0;

                else %dev
                    % Save hit data
                    hitIdxs = loopTable.probe_idx(compIOImask & hitmask); % should do this from prbe_idx, rather than loopstart - LF 11-30-16
                    ntrials = length(hitIdxs);
                    if ntrials == 0
                        IOIpup2.hitMean{nr,1} = NaN;
                        IOIpup2.hitSEM{nr,1} = NaN;
                    else
                        hitData = zeros(ntrials, preloopSamps+postloopSamps+1);
                        for i = 1:ntrials-1 %last trial might not have enough samps
                            currIdx = hitIdxs(i);
                            pre = currIdx - preloopSamps;
                            post = currIdx + postloopSamps;
                            hitData(i,:) = currdata(pre:post);
                        end
                        hitData(1,:) = [];
                        meanHit = mean(hitData);
                        SEMhit = std(hitData)/sqrt(ntrials-1);
                        IOIpup2.hitMean{nr,1} = meanHit;
                        IOIpup2.hitSEM{nr,1} = SEMhit;
                    end

                    %Save miss data
                    missIdxs = loopTable.probe_idx(compIOImask & missmask);
                    ntrials = length(missIdxs);
                    if ntrials == 0
                        IOIpup2.missMean{nr,1} = NaN;
                        IOIpup2.missSEM{nr,1} = NaN;
                    else
                        missData = zeros(ntrials,preloopSamps+postloopSamps+1);
                        for i = 1:ntrials-1 %last trial might not have enough samps after
                            currIdx = missIdxs(i);
                            pre = currIdx - preloopSamps;
                            post = currIdx + postloopSamps;
                            missData(i,:) = currdata(pre:post);
                        end
                        missData(1,:) = [];
                        meanMiss = mean(missData);
                        SEMmiss = std(missData)/sqrt(ntrials-1);
                        IOIpup2.missMean{nr,1} = meanMiss;
                        IOIpup2.missSEM{nr,1} = SEMmiss;
                    end
                    meanPDF = loopTable.maxMeanPDF(compIOImask & convergedMask);
                    if isempty(meanPDF)
                        IOIpup2.meanPDF(nr,1) = 0;
                    else
                        IOIpup2.meanPDF(nr,1) = meanPDF;
                    end % checking that this sub had this stim/probe combo and therefore a meanPDF
                end
            end
        end
    end
end


% fpath = params.paths.matpath;
% fstub = 'IOIpup2';
% outfname = fullfile(fpath,[fstub '.mat']);
% fprintf('Saving mat file: %s\n', outfname)
% save(outfname,'IOIpup2')







%% Create new table with curr dB level for each probe trial
% Useful for computing correlations between mean/max pup, rt, dB level,
% etc.

% load pupdata.mat
% load loopTable.mat

% added to PIPELINE - 11-29-16 - LF

pupDbTbl = table;
nr = 0;

subids = unique(loopTable.subject_id);
nsubs = length(subids);
for isub = 1:nsubs
    currsub = subids(isub);
    submask = strcmp(loopTable.subject_id, currsub);
    stimids = unique(loopTable.stimulus_id(submask)); %accounting for sub
    nstims = length(stimids);

    for istim = 1:nstims
        currstim = stimids(istim);
        if strcmp(currstim, 'prA_4_3i_1v_107bpm') %will figure out how to deal with issues in this stim later; ignore for now.
            continue
        else
        end
        stimmask = strcmp(loopTable.stimulus_id, currstim);
        compmask1 = submask & stimmask;

        allprobeids = unique(loopTable.probe_id(compmask1)); %accounting for sub and stim
        nodev = strcmp(allprobeids, 'no_deviant');
        probeids = allprobeids(~nodev);
        nprobes = length(probeids);

        %mask pup data
        subdatamask = strcmp(currsub, pupdata.subject_id);
        stimdatamask = strcmp(currstim, pupdata.stimulus_id);
        compmask = subdatamask & stimdatamask;
        currdata = pupdata(compmask,:);
        currdata = cell2mat(currdata.pupNorm);

        if isempty(currdata) % in the event that this sub/stim combo got thrown out of pupdata due to too much interpolation
            continue
        else
        end

        for iprobe = 1:nprobes

            currprobe = probeids(iprobe);

            probemask = strcmp(currprobe, loopTable.probe_id);
            compIOImask = submask & stimmask & probemask;

            %set sample extraction params, surrounding deviant onset
            preSamps = -250; % secs before dev
            postSamps = 1500/2;

            if strcmp(currprobe, 'no_deviant') %irrelevant for this analysis
                continue

            else %dev


                %find dB contrast and pup mean for every dev trial
                dBIdxs = find(compIOImask == 1);
                probeIdxs = loopTable.probe_idx(compIOImask);
                ntrials = length(probeIdxs);
                for itrial = 1:ntrials-1 % -1 because not enough samples for post index in last trial
                    nr = nr+1;
                    currIdx = probeIdxs(itrial); %is this right? no! this is start of loop
                    pre = currIdx - preSamps;
                    post = currIdx + postSamps;
                    pupDbTbl.subject_id(nr,1) = currsub;
                    pupDbTbl.stimulus_id(nr,1) = currstim;
                    pupDbTbl.probe_time(nr,1) = currprobe;
                    pupDbTbl.probeCond(nr,1) = loopTable.maxProbeCond(dBIdxs(itrial));
                    pupDbTbl.obsNum(nr,1) = loopTable.maxObs_num(dBIdxs(itrial)); % output max_obs num in case trial num matters?
                    pupDbTbl.meanPup(nr,1) = mean(currdata(pre:post));
                    pupDbTbl.maxPup(nr,1) = max(currdata(pre:post));
                    pupDbTbl.currdB(nr,1) = loopTable.curr_dB_lev(dBIdxs(itrial));
                    if loopTable.maxSubResp(dBIdxs(itrial)) == 1 %in case hit/ miss matters
                        pupDbTbl.hit(nr,1) = 1;
                    else
                        pupDbTbl.hit(nr,1) = 0;
                    end %checking if hit
                    pupDbTbl.RT(nr,1) = loopTable.RT(dBIdxs(itrial));

                end %itrial

            end %if dev
        end
    end
end

%save
fpath = params.paths.matpath;
fstub = 'pupDbTbl';
outfname = fullfile(fpath,[fstub '.mat']);
fprintf('Saving mat file: %s\n', outfname)
save(outfname,'pupDbTbl')


%% Figure out probe thresholds
% Creates very small table called PDF. Useful for looking at average PDF
% per sub, otherwise, pupDbTbl (next section) is likely more useful.

stimids = unique(IOIpup.stimulus_id);
PDF = table;
nr = 1;
for istim = 1:length(stimids)
    currstim = stimids(istim);
    stimmask = strcmp(IOIpup.stimulus_id, currstim);
    devids = unique(IOIpup.dev_label(stimmask));

    for idev = 1:length(devids)
        currdev = devids(idev);
        if strcmp(currdev, 'no_deviant')
            continue
        else
            devmask = strcmp(IOIpup.dev_label, currdev);
            compmask = stimmask & devmask;
            PDF.stimulus_id(nr,1) = currstim;
            PDF.dev_label(nr,1) = currdev;
            PDF.meanPDF(nr,1) = mean(IOIpup.meanPDF(compmask));
            PDF.stdPDF(nr,1) = std(IOIpup.meanPDF(compmask));
            PDF.semPDF(nr,1) = std(IOIpup.meanPDF(compmask))/sqrt(length(IOIpup.meanPDF(compmask)));

            pup = IOIpup.hitMean(compmask);
            maxes = ones(length(pup),1);
            means = ones(length(pup),1);
            for i = 1:length(pup)
                if isnan(pup{i})
                    continue
                else
                    maxSize = max(pup{i}(1000:end)); % might want to adjust this to look even later after dev
                    maxes(i) = maxSize;

                    meanSize = mean(pup{i}(1000:end));
                    means(i) = meanSize;

                end
            end

            PDF.maxPup(nr,1) = mean(maxes);
            PDF.meanPup(nr,1) = mean(means);

        end %making sure it's dev nd not no dev
        nr = nr+1;

    end %dev


end %stim


% Want to also add model values to this table
% need to load model predicted values from previous BTB analysis. Currently
% have them saved in matfiles as 'an'

fpath = params.paths.matpath;
fstub = 'an';
fname = fullfile(fpath,[fstub '.mat']);
load(fname)


% Code to get model prediction values appended to PDF table
% assumes that an.mat is already loaded

% append .wav to stim labels for ease later
s2 = '.wav';
for i = 1:length(PDF.stimulus_id)
    s1 = PDF.stimulus_id{i};
    PDF.stimulus_id{i} = strcat(s1,s2);
end


% % Get model time series of interest
model_output = an{1,3}.results.data{1,2};

% Get stim labels of model output
model_labels = an{1,3}.results.data{1,1};

% Loop over stims/devs and find appropriate location in model data to
% extract value
stimids = params.stimnames;
nstims = length(stimids);
for istim = 1:nstims
    currstim = stimids(istim);

    modelstimmask = strcmpi(currstim, model_labels);
    modelData = model_output{modelstimmask};

    devStims = params.stim_probeIds;
    stimmask = strcmp(currstim, devStims);
    ind = find(stimmask == 1);
    devLabs = params.stim_probeIds{ind,2};

    for i = 1:numel(devLabs)
        currdevLab = devLabs{i};
        labelmask = strcmpi(currdevLab, PDF.dev_label);
        currprobeTime = regexp(currdevLab,'\d{1,4}','match');
        currprobeTime = str2double(currprobeTime);
        currprobeTime = currprobeTime/10; %to get in 100Hz samples (currently in ms)
        if currprobeTime == 0
            currprobeTime = 1; % for case of dev_hi_0 which should be the first sample of model data (matlab can't index at 0)
        else
        end

        % Find value at specific (dev) point in time.
        modelVal = modelData(round(currprobeTime));
        stimmask = strcmp(currstim, PDF.stimulus_id);
        compmask = stimmask & labelmask;
        ind = find(compmask == 1);
        PDF.modelVal(ind,1) = modelVal;

    end %dev

end %stim



s2 = '.wav';
for i = 1:length(pupDbTbl.stimulus_id)
    s1 = pupDbTbl.stimulus_id{i};
    pupDbTbl.stimulus_id{i} = strcat(s1,s2);
end


% add mean RT to PDF table (using data from pupDbTbl)
stimids = unique(pupDbTbl.stimulus_id);
for istim = 1:length(stimids)
    currstim = stimids(istim);
    stimmask = strcmp(currstim, pupDbTbl.stimulus_id);
    probeTimes = unique(pupDbTbl.probe_time(stimmask));
    for iprobe = 1:length(probeTimes)
        currprobe = probeTimes(iprobe);
        probemask = strcmp(currprobe, pupDbTbl.probe_time);

        hitMask = logical(pupDbTbl.hit);

        % now get mean RT for each probe and add to PDF
        meanRT = mean(pupDbTbl.RT(hitMask & probemask & stimmask));   %if not working, remove PJ row: pupDbTbl(3573,:) = [];

        % need to match condition to way formatted in PDF...


        stimPDFmask = strcmp(currstim, PDF.stimulus_id);
        probePDFmask = strcmp(PDF.dev_label, currprobe);
        ind = find(stimPDFmask & probePDFmask);

        PDF.meanRT(ind,1) = meanRT;
    end %probe

end %stim

[r,p] = corr(PDF.meanRT, PDF.modelVal);


fpath = params.paths.matpath;
fstub = 'PDF';
outfname = fullfile(fpath,[fstub '.mat']);
fprintf('Saving mat file: %s\n', outfname)
save(outfname,'PDF')




%% Plot IOIpup Across subs
% this still is not code used for ICMPC poster -- where is that?


% if not working, remove PJ's data

% outMeans = cell(nsubs,nstims,nprobes);  % just going to hard code this
% for now: 5 stims, 20 probes
outMeans = table;

stimids = unique(IOIpup.stimulus_id);
figure() %initialize figure
pi = 1;
nr = 1;

for istim = 1:length(stimids)

    currStim = stimids(istim);
    stimmask = strcmp(IOIpup.stimulus_id, currStim);


    alldevids = unique(IOIpup.dev_label(stimmask));
    nodevmask = strcmp(alldevids, 'no_deviant');
    devids = alldevids(~nodevmask);
    probetimes = regexp(devids,'\d{1,4}','match');
    probetimes = [probetimes{:}];
    for i = 1:length(probetimes)
        probetimes{i} = str2double(probetimes{i});
    end
    probetimes = cell2mat(probetimes);
    probetimes = sort(probetimes, 'ascend'); %now probe times sorted numerically


    % isolate and average no dev data for this stim
    controlmask = strcmp(IOIpup.dev_label, 'no_deviant');
    noDevData = IOIpup.noDevMean(stimmask & controlmask);
    nsubs = length(noDevData);
    noDevData = cell2mat(noDevData);
    noDevMean = mean(noDevData);
    noDevSEM = std(noDevData)/sqrt(nsubs);
    xpointsND = 1:length(noDevMean);
    NDUpper = noDevMean + noDevSEM;
    NDLower = noDevMean - noDevSEM;


    for idev = 1:length(devids)
        currdev = devids(idev);
        probe_mask = strcmp(IOIpup.dev_label, currdev);

        outMeans.stimulus_id(nr,1) = currStim;
        outMeans.dev_label(nr,1) = currdev;

        % Hit - what is deal with hit 1530 and ? - nan seems to solve it
        outHitData = IOIpup.hitMean(stimmask & probe_mask);
        nsubs = length(outHitData);
        outHitData = cell2mat(outHitData);
        outHitMean = nanmean(outHitData);
        outMeans.hitMean{nr,1} = outHitMean;
        outHitSEM = nanstd(outHitData)/sqrt(nsubs);
        outMeans.hitSEM{nr,1} = outHitSEM;

        xpointsHit = 1:length(outHitMean);
        hitUpper = outHitMean + outHitSEM;
        hitLower = outHitMean - outHitSEM;


        % Miss
        outMissData = IOIpup.missMean(stimmask & probe_mask);
        for i = 1:length(outMissData)
            if outMissData{i} == 0
                outMissData{i} = zeros(1,3001); % hard coding...
            else
            end
        end
        nsubs = length(outMissData);
        outMissData = cell2mat(outMissData);
        outMissMean = nanmean(outMissData);
        outMeans.missMean{nr,1} = outMissMean;
        outMissSEM = nanstd(outMissData)/sqrt(nsubs);
        outMeans.missSEM{nr,1} = outMissSEM;

        xpointsMiss = 1:length(outMissMean);
        missUpper = outMissMean + outMissSEM;
        missLower = outMissMean - outMissSEM;

        % plot this stim this probe
        r = length(stimids);
        c = length(devids);

        probetime = regexp(currdev,'\d{1,4}','match');
        probetime = [probetime{:}];
        probetime = str2num(probetime{:});
        probetime = probetime/2; %divide by 2 to get in samples, add 70 to account for timing issue
        probetime = probetime+1000; %nsamps pre loop start

        subplot(r,c,pi)
        plot(outHitMean, 'g'); % should specify color for case when no hits, miss ends up getting plotted in hit color
        hold on
        hHit = jbfill(xpointsHit,hitUpper,hitLower,'g','g',1,.5);
        hold on

        plot(outMissMean, 'r')
        hold on
        hMiss = jbfill(xpointsMiss,missUpper,missLower,'r','r',1,.5);
        hold on

        plot(noDevMean, 'k')
        hold on
        hND = jbfill(xpointsND,NDUpper,NDLower,'k','k',1,.5);
        hold on

        ylim([-.5 1]);
        xlim([0 3000]);
        y1 = get(gca, 'ylim');
        plot([1000 1000], y1, 'k') % nsamps 1000 pre/2000 post - this is start of loop
        hold on
        plot([probetime probetime], y1, ':r', 'LineWidth', 2)
        hold on
        xlabel('Time (msecs)')
        ylabel('Normalized Pupil Size')
        title(currdev, 'interpreter','none')
        legend([hHit hMiss hND],{'Hit','Miss', 'No Deviant'},'Location','northwest')
        set(gca,'XTickLabel',{'-2000','0', '2000','4000'})
        set(gca, 'fontsize', 14)

        pi=pi+1;
        nr = nr+1;
    end %probes for this stim

    outMeans.noDevMean{nr,1} = noDevMean;
    outMeans.noDevSEM{nr,1} = noDevSEM;



end % stim
suptitle('Mean pupillary response to each deviant of each stim, across all participants, time-locked to loop onset')





%% bar plot PDFs
% This plots bar plot of threshold for each probe cond in each stim, in
% four subplots. This is using high/low categories for probes. I think it
% is more useful to treat model-predicted salience continuously, since all
% probes in the "high" vs "low" categories are not equal.

stimids = unique(IOIpup.stimulus_id);
figure() %initialize figure


for istim = 1:length(stimids)
    currStim = stimids(istim);
    pdfstimmask = strcmp(PDF.stimulus_id, currStim);
    devids = PDF.dev_label(pdfstimmask);
    subplot(2,2,istim)
    %   errorbar(X,Y,L,U) plots the graph of vector X vs. vector Y with
    %     error bars specified by the vectors L and U.  L and U contain the
    %     lower and upper error ranges for each point in Y.  Each error bar
    %     is L(i) + U(i) long and is drawn a distance of U(i) above and L(i)
    %     below the points in (X,Y).  The vectors X,Y,L and U must all be
    %     the same length.  If X,Y,L and U are matrices then each column
    %     produces a separate line.

    b = bar(PDF.meanPDF(pdfstimmask));
    devids2 = strrep(devids,'_',' ');
    set(gca,'XTickLabel',devids2)
    xlabel('Probe Condition')
    ylabel('Mean Intensity Threshold (dB SPL)')
    title(currStim, 'interpreter','none')
    hold on
    errorbar(1:length(PDF.meanPDF(pdfstimmask)),PDF.meanPDF(pdfstimmask), PDF.semPDF(pdfstimmask), PDF.semPDF(pdfstimmask),'.');
    set(gca, 'fontsize', 23)
    ylim([0 18]);
    %
    % Error bars indicate SEM

end
suptitle('Detection thresholds for each stim and each probe, across all participants')






%% hist plot PDFs
% Just used for visual inspection of data - to check number of participants
% with each threshold for each probe/stim

stimids = unique(IOIpup.stimulus_id);


for istim = 1:length(stimids)
    currStim = stimids(istim);
    pdfstimmask = strcmp(IOIpup.stimulus_id, currStim);
    devids = unique(IOIpup.dev_label(pdfstimmask));
    figure()
    for idev = 1:length(devids)
        currdev = devids(idev);
        if strcmp(currdev, 'no_deviant')
            continue
        else
            devmask = strcmp(IOIpup.dev_label, currdev);
            subplot(1,4,idev)
            hist(IOIpup.meanPDF(devmask));
            xlabel('Mean Intensity Threshold (dB SPL)')
            ylabel('# participants')
            ylim([0 8])
            xlim([0 20])
            title(currdev, 'interpreter','none')
            set(gca, 'fontsize', 14)

        end

    end

    suptitle(currStim);

end


