% Unified pre-processing script for attmap_eyetrack
% Lauren Fink, Janata Lab, UC Davis Center for Mind & Brain 
% Last edited: 20180206

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

% Remove any other subjects with technical glitches
badData.subject_id{nr,1} = 'pj'; % there was a technical recording error during trial 1.
badData.trial(nr,1) = 1;
badind = find(strcmp(pupdata.subject_id, 'pj') & pupdata.trial_id == 1);
pupdata(badind,:) = [];

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
fprintf('\nMatfile saved')

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
                %   add 1 to iloop to account for loop discrepency
                %   (tracker never receives first loop message)
                if ismember(iloop+1, maxtrialdata.trial_num(maxprobemask))
                    rowIdx = find(maxtrialdata.trial_num == iloop+1);
                    loopTable.maxObs_num(nr,1) = maxtrialdata.obs_num(rowIdx);
                    loopTable.maxMeanPDF(nr,1) = maxtrialdata.mean_pdf(rowIdx);
                    loopTable.maxConverged(nr,1) = maxtrialdata.converged(rowIdx);
                    loopTable.maxProbeTime(nr,1) = maxtrialdata.probe_time(rowIdx);
                    loopTable.maxProbeCond(nr,1) = maxtrialdata.probe_cond(rowIdx);
                    loopTable.maxSubResp(nr,1) = maxtrialdata.sub_resp(rowIdx);
                    loopTable.maxSubID(nr,1) = maxtrialdata.subject_id(rowIdx);

                elseif ismember(iloop+2, maxtrialdata.trial_num(maxprobemask))
                    rowIdx = find(maxtrialdata.trial_num == iloop+2);
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
% -- so that we can eventually look at correlation between 
%    dB contrast and pupil response

% Initialize new column in loopTable
numObs = length(loopTable.maxObs_num);
loopTable.curr_dB_lev = zeros(numObs,1);

% Go through by subject and set curr dev = maxMeanPDF of prev dev (except
% for first instance, which is 10 dB)
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

            for ipIdx = 2:length(probeIdxs) % first is 10 dB
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
% This is most condensed version of trial information 
% No pupil data is currently appended

fpath = params.paths.matpath;
fstub = 'loopTable';
outfname = fullfile(fpath,[fstub '.mat']);
fprintf('Saving mat file: %s\n', outfname)
save(outfname,'loopTable')
fprintf('\nMatfile saved')
% -----------------------------------------------------------------------------%

%% Load loopTable
if LOAD_LOOPTABLE
    fpath = params.paths.matpath;
    fstub = 'loopTable';
    fname = fullfile(fpath,[fstub '.mat']); 
    load(fname)
    fprintf('\nloopTable loaded\n')
end
% -----------------------------------------------------------------------------%
%% Create larger version of loopTable that appends pupil data 
% This is a significantly larger version of the table above, with
% descriptive statistics and pupil traces for each trial added

% pupdata and loopTable must be loaded to create this table

loopTable2 = loopTable;
dl = length(loopTable2.loop_num);
loopTable2.baselinePupMean200 = NaN(dl,1);
loopTable2.trialPupMean = NaN(dl,1);
loopTable2.trialPupMax = NaN(dl,1);
loopTable2.trialPupSlope = NaN(dl,1);
loopTable2.trialPupMaxLatency = NaN(dl,1);

% Only add data to the table on dev trails

% Find dev trials
devtrials = find(~isnan(loopTable2.probe_idx));
for idevtrial = 1:length(devtrials)
    currdev = devtrials(idevtrial);

    if loopTable2.maxObs_num(currdev) == 20
        continue
        % Because the last trial will not have enough time after the
        % deviant to observe the full pupil dilation response and will skew
        % results
    else
    end

    % Isolate pupdata of interest
    % Need to get proper sub, stim, then index pupil data
    currsub = loopTable2.subject_id(currdev);
    submask = strcmp(pupdata.subject_id, currsub);
    currstim = loopTable2.stimulus_id(currdev);
    stimmask = strcmp(pupdata.stimulus_id, currstim);
    %currdata = pupdata.pupNorm(submask & stimmask); % TODO switch this here for revision illustration
    currdata = pupdata.pupInterp(submask & stimmask);
    currdata = cell2mat(currdata);

    % Now only take chunk of data we're interested in and save
    probeIdx = loopTable.probe_idx(currdev);
    baseline200 = 100; %200ms pre dev
    samps2take = 1500;

    % Save pupil data to loop table
    basemean = mean(currdata(probeIdx-baseline200:probeIdx-1));  
    loopTable2.baselinePupMean200(currdev) = basemean;
    trialPup = currdata(probeIdx:probeIdx+samps2take);
    basecorrected = trialPup-basemean;
    loopTable2.trialPup{currdev} = basecorrected;
    loopTable2.trialPupMean(currdev) = mean(basecorrected);
    maxPup = max(basecorrected);
    loopTable2.trialPupMax(currdev) = maxPup;
    %loopTable2.trialPupMaxLatency(currdev) = find(basecorrected == maxPup)*2; % to get in ms
    % comment ^ this out for review if using interp data because at least
    % one sub has multiple time points now at same max value
    loopTable2.trialPupSlope(currdev) = getPupSlope(basecorrected);

end %devtrials
fprintf('\nDone adding deviant pupil data to table')

% -----------------------------------------------------------------------------%
% Add pupil data for every loop to table
nr = 1;
for iloop = 1:length(loopTable2.loop_start)-1
    startind = loopTable2.loop_start(iloop);
    endind = loopTable2.loop_start(iloop+1) -1;
    
    if loopTable2.maxObs_num(iloop) == 20
        continue % there won't be enough data for this loop
    end
    
    % Mask pupdata
    currsub = loopTable2.subject_id(iloop);
    submask = strcmp(pupdata.subject_id, currsub);
    currstim = loopTable2.stimulus_id(iloop);
    stimmask = strcmp(pupdata.stimulus_id, currstim);
    currdata = pupdata.pupNorm(submask & stimmask);
    currdata = cell2mat(currdata);
    
    % baseline correct
    base_startind = startind-baseline200;
    base_endind = startind-1;
    basedata = currdata(base_startind:base_endind);
    basemean = mean(basedata);
    
    % baseline correct
    currdata = currdata(startind:endind) - basemean;
    
    % save
    loopTable2.loopPup{nr,1} = currdata;
    
    nr = nr+1;
end % loop
fprintf('\nDone adding loop pup data to table\n')


%% Clean RT and pup data

% Plot original RT data, if desired
% hist(loopTable2.RT)

% Find outlying data
badidxs = isoutlier(loopTable2.RT);
hist(loopTable2.RT(~badidxs))

% Remove trials with outliers from subsequent analysis
loopTable2(badidxs,:) = [];

% Remove outliers from baseline pup mean data
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
fprintf('\nDone adding reson output to table\n')


% -----------------------------------------------------------------------------%
%% Save table
fpath = params.paths.matpath;
fstub = 'loopTable2';
outfname = fullfile(fpath,[fstub '.mat']);
fprintf('Saving mat file: %s\n', outfname)
save(outfname,'loopTable2')
fprintf('\nMatfile saved')