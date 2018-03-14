% Script to create table containing peak T series (reson output) values for
% each probed location in each stimulus

% LF _20180131

% Load model predictions
params = attmap_eyes_globals;
fpath = params.paths.matpath;
fstub = 'an';
fname = fullfile(fpath,[fstub '.mat']);
load(fname)

model_output = an{1,3}.results.data{1,2};

% Get stim labels of model output
model_labels = an{1,3}.results.data{1,1};

% Loop through each stim, each probe and grab appropriate value
stimids = params.stimnames;
nstims = length(stimids);
nr = 1;
resonVals = table;
for istim = 1:nstims
    currstim = stimids(istim);

    modelstimmask = strcmpi(currstim, model_labels);
    modelData = model_output{modelstimmask};

    devStims = params.stim_probetimes;
    stimmask = strcmp(currstim, devStims);
    ind = find(stimmask == 1);
    devLabs = params.stim_probetimes{ind,2};

    for i = 1:numel(devLabs)
        currdevLab = devLabs(i);
        currprobeTime = currdevLab/10; %to get in 100Hz samples (currently in ms)
        currprobeTime = round(currprobeTime);
        if currprobeTime == 0
            currprobeTime = 1; % No zero indexing in matlab
        end
        fprintf('currprobetime: %04d', currprobeTime)
        
        % Find value at specific (dev) point in time.
        modelVal = modelData(currprobeTime);

        % Save to table
        resonVals.stim(nr,1) = currstim;
        resonVals.probe_time(nr,1) = currdevLab;
        resonVals.modelVal(nr,1) = modelVal;
        nr = nr+1;
        
    end %dev

end %stim

%% Save table
fpath = params.paths.matpath;
fstub = 'resonVals';
outfname = fullfile(fpath,[fstub '.mat']);
fprintf('Saving mat file: %s\n', outfname)
save(outfname,'resonVals')
fprintf('Matfile saved')