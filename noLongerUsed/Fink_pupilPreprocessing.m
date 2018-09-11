% Lauren Fink, Janata Lab, UC Davis
% Unified pre-processing script for attmap_eyetrack
% 05-05-2016

% Sharing with Sarah Creel and Reina, UCSD, on 02-07-2017
% The "Preprocess pupil data" section is likely the most useful reference

% Sharing with Elke Lange, Franklenin, Alessandro, MPIEA, 09-18-2017

% ----------------------------------------------------------------------- %


% Use flags to specify which parts of code (below) you want to run
CONVERT_FROM_CSV = 0;
SAVE2MAT = 0;
LOAD_MATFILES = 0;
LOAD_pupdata = 0;

if CONVERT_FROM_CSV
  LOAD_MATFILES = 0;
end

% Load the globals file - this contains all file paths and relevant
% parameters for the experiment
params = attmap_eyes_globals;

% Load the subject info file - this contains relevant sub info for this
% experiment
sinfo = attmap_eyes_subinfo;

%% Convert eye-tracking data from CSV to mat files
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
    end
    
    % Write over the ds entry - all data now loaded in ds structure
    ds{ifile} = datatable;
  end
end % if CONVERT_FROM_CSV


%% Load in all .mat files
if LOAD_MATFILES
  dirlist = dir(fullfile(params.paths.data_path,'*.mat'));
  nfiles = length(dirlist);
  for ifile = 1:nfiles
    fname = fullfile(params.paths. data_path, dirlist(ifile).name);
    fprintf('Loading data from: %s\n', fname);
    tmp = load(sprintf('%s',fname));
    ds{ifile} = tmp.datatable; %structure containing all data
    clear tmp
  end
end % if LOAD_MATFILES


%% Preprocess pupil data

% remove blinks and interpolate any missing data
% highpass filter 
% normalize by trial mean/std
% remove trials requiring >25% interpolation


nsubs = length(ds);
ntrials = zeros(nsubs,1);

% Prepare our output datatable
pupdata = table; %table w pupil data by run

nr = 0;
for isub = 1:nsubs
  currSubjectData = ds{isub};
  subid = unique(currSubjectData.RECORDING_SESSION_LABEL);
  subid = subid{1};
  
  fprintf('Processing sub %d: %s\n',isub, subid);
  
  % Get the subject specific information
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
  
  % NOTE: CHECK: TODO
  %^ consider also flagging samples before/after blink -- this is common
  %in some of the literature, as pupil can exhibit artifact immediately
  %pre/post blink. 
  
  
  % Figure out which rows belong to which trial 
  [trialmaskMtx, trial_idxs] = make_mask_mtx(currSubjectData.TRIAL_INDEX);
  
  % Loop over each of the stimulus trials for this subject
  for itrial = 1:ntrials(isub)
    nr = nr+1;
    
    % Figure out our stimulus ID
    stimid = currsubInfo.stimulus_order{itrial};
    
    % Output basic info to table
    pupdata.subject_id{nr,1} = subid;
    pupdata.trial_id(nr,1) = itrial;
    pupdata.stimulus_id{nr,1} = stimid;
    
    % Deal only with current trial data 
    trialmask = trialmaskMtx(:,itrial);
    trialdata = currSubjectData(trialmask,:);   
    rawdata = pupRaw(trialmask);
 
    % CLEAN & INTERPOLATE pupil data for this trial 
    npts = size(rawdata,1);
    timeVector = 1:npts;
    pupdata.perc_interp(nr,1) = (sum(isnan(rawdata))/npts)*100;
    good_mask = ~isnan(rawdata);
    fprintf('Interpolating pupil data for trial: %d\n',itrial);
    interp_data = interp1(timeVector(good_mask),rawdata(good_mask),timeVector); %spline was looking really artifactual
    
    %check for NaNs
    if any(isnan(interp_data))
        if isnan(interp_data(end)) %NaNs at end
           interp_data(isnan(interp_data)) = [];
           fprintf('fixed NaNs at end of trial %d, sub %d\n',itrial,isub)
        else
            error('NaN in interp data!')
        end
 
    end
    fprintf('Saving pupil interpolation for trial: %d\n',itrial);
    pupdata.pupInterp{nr,1} = interp_data(:);
     
    % HIGH PASS FILTER to remove any large drift in trial data 
    [b,a] = butter(3,0.05/250,'high'); %20 seconds
    % freqz(b,a) %if want to image filter
    hfiltered = filtfilt(b,a,interp_data);
    pupdata.hfPup{nr,1} = hfiltered;
     
    % NORMALIZE % 
    pupMean = mean(hfiltered); 
    pupStd = std(hfiltered);
    pupdata.pupMean(nr,1) = pupMean;
    pupdata.pupStd(nr,1) = pupStd;
    
    % Normalize by the mean size of the pupil / std of pup
    fprintf('Norming pupil for trial: %d\n',itrial);
    pupNorm = (hfiltered-pupMean)/pupStd; 
    pupdata.pupNorm{nr,1} = pupNorm;
    
  end %itrial (stim)

end %isub


% Remove bad data (data requiring greater than 25% interpolation) from pupdata table 
badData = table;
nr = 1;
badIdxs = find(pupdata.perc_interp > 25);
for bi = 1:length(badIdxs)
    curri = badIdxs(bi);
    fprintf('Subject %s, trial %d required too much interpolation and was discarded\n', pupdata.subject_id{curri,1},pupdata.trial_id(curri,1))
    badData.subject_id{nr,1} = pupdata.subject_id{curri,1};
    badData.trial(nr,1) = pupdata.trial_id(curri,1);
    nr = nr+1;
end

% Only deal with good data
gooddataMask = pupdata.perc_interp <= 24.9999; % removes anything requiring 25% interpolation or above
pupdata = pupdata(gooddataMask,:);

% Save cleaned data
 fpath = params.paths.matpath;
 fstub = 'pupdata';
 fname = fullfile(fpath,[fstub '.mat']);
 save(fname, 'pupdata');
 
 
 %% load pupdata
if LOAD_pupdata
    
    fpath = params.paths.matpath;
    fstub = 'pupdata';
    fname = fullfile(fpath,[fstub '.mat']);
    load(fname)

end

