% attmap_proc_eye_data.m
% Pre-processing of attmap_v1p2_eyetrack data
% LF - 2015 

CONVERT_FROM_CSV = 0;
SAVE2MAT = 1;
LOAD_MATFILES = 1;

if CONVERT_FROM_CSV
  LOAD_MATFILES = 0;
end

% Load the globals file
params = attmap_eyes_globals;

% Load the subject info file
sinfo = attmap_eyes_subinfo;


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
    end
    
    % Write over the ds entry
    ds{ifile} = datatable;
  end
end % if CONVERT_FROM_CSV

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

% maybe save/output this step too
% each cell of ds has data for sub, consisting of: 
% RECORDING_SESSION_LABEL; TRIAL_INDEX; TRIAL_START_TIME; SAMPLE_MESSAGE;
% RIGHT_GAZE_X; RIGHT_GAZE_Y; RIGHT_IN_SACCADE; RIGHT_IN_BLINK;
% RIGHT_PUPIL_SIZE (maybe put this in globals file...)


%% Analyze data
nsubs = length(ds);
ntrials = zeros(nsubs,1);

% Prepare our output datatables
outdata = table; %table w pupil and blink data by run

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
  
  %add extra NaNs to deal with pupil size artifacts caused by blinks being
  %too short in duration - might not need this if using linear interp
%   nanIdx = find(diff(~isnan(pupRaw))==1); %this gives idx of last nan in series of nans
%   for inan = 1:numel(nanIdx)
%       currIdx = inan;
%       stopIdx = inan+20; %20 extra samples. 10 was not enough
%       pupRaw(currIdx:stopIdx) = NaN;
%   end

% if going to do ^ , thinkwe should find next peak and delete up until
% there. Some signal after NaN does not look spiking so seems wrong to
% delete more than necessary

% use diff to tell slope - look at next x samples after NaN, if positive,
% then increasing slope, want to cut off at peak - take that sample (if
% under threshold of length) and NaN out
% could do it with two masks
% get boolean for sign by putting together two element mask (logical &) x
% & y both > 0
  
  % Figure out which rows belong to which trial - is this doing something
  % weird with columns?? - make normal mask out of it later
  [trialmaskMtx, trial_idxs] = make_mask_mtx(currSubjectData.TRIAL_INDEX);
  
  % Loop over each of the stimulus trials for this subject
  for itrial = 1:ntrials(isub)
    nr = nr+1;
    
    % Figure out our stimulus ID
    stimid = currsubInfo.stimulus_order{itrial};
    
    outdata.subject_id{nr,1} = subid;
    outdata.trial_id(nr,1) = itrial;
    outdata.stimulus_id{nr,1} = stimid;
    
    trialmask = trialmaskMtx(:,itrial);
    trialdata = currSubjectData(trialmask,:);  % deal only with current trial
    
    rawdata = pupRaw(trialmask);
    pupMean = nanmean(rawdata); 
    outdata.pupMean(nr,1) = pupMean; %maybe this is too long of a period to normalize over - seems to be drift. 
    %THIS IS NOT WORKING!!!! Or something very weird about trial 1 for everyone
    % or normalize after filter?
    
    % Normalize by the mean size of the pupil
    fprintf('Norming pupil for trial: %d\n',itrial);
    pupNorm = (rawdata-pupMean)/pupMean; 
    outdata.pupNorm{nr,1} = pupNorm;
    %this might be weird!
    
    % Clean up pupil data  
    npts = size(pupNorm,1);
    timeVector = 1:npts;
    outdata.perc_interp(nr,1) = (sum(isnan(pupNorm))/npts)*100;
    good_mask = ~isnan(pupNorm);
    fprintf('Interpolating pupil data for trial: %d\n',itrial);
    interp_data = interp1(timeVector(good_mask),pupNorm(good_mask),timeVector); %spline was looking really artifactual
    
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
    outdata.pupInterp{nr,1} = interp_data(:);
    
    
    
    %now high pass filter to remove any large drift in trial data
    [b,a] = butter(3,0.05/250,'high'); %20 seconds
    % freqz(b,a) %if want to image filter
    hfiltered = filtfilt(b,a,interp_data);
    outdata.hfPup{nr,1} = hfiltered;
    
%     [b,a] = butter(3,50/250,'low'); %K&W low passed at 10Hz to remove spikes. Wierda used 50Hz
%     lfiltered = filtfilt(b,a,hfiltered);
%     outdata.lowfiltPup{nr,1} = lfiltered;
%     
    
    
    % Extract the blink data
    fprintf('Saving blink data for trial: %d\n',itrial);
    outdata.blinkData{nr,1} = trialdata.RIGHT_IN_BLINK;
    
    %might want to do more here - probably should output only good blinks
    % still need to do something to remove bad data.. e.g. mariah
    clear temp;
    temp = diff(outdata.blinkData{nr,1});
    onsetIdx = find(temp == 1);
    offsetIdx = find(temp == -1);
    if numel(offsetIdx) < numel(onsetIdx) %sometimes 1 extra onset if trial ends in blink
        onsetIdx = onsetIdx(1:end-1); %remove this blink because don't have dur data, etc.
    else
    end
    clear blinkTemp;
    clear blinkDurs;
    blinkTemp(:,1) = offsetIdx;
    blinkTemp(:,2) = onsetIdx;
    blinkTemp(:,3) = blinkTemp(:,1) - blinkTemp(:,2); %number of samples for blink
    blinkDurs = blinkTemp(:,3)*2; %2ms per sample = duration of blink - might want to add limits here
    for iduridx = 1:numel(blinkDurs)
        if blinkDurs(iduridx) >= 500 % above this considered micro-sleep
            blinkDurs(iduridx) = NaN;
        else %add lower limit?
        end
    end
    outdata.BlinkDurs{nr,1} = blinkDurs;
    outdata.meanBDur(nr,1) = nanmean(blinkDurs);
    nsamps = numel(outdata.blinkData{nr,1});
    ttime = ((nsamps*2)/1000)/60; % convert from samples to ms to secs to mins
    outdata.meanBR(nr,1) = length(blinkDurs)/ttime;
    outdata.totalNumBlinks(nr,1) = length(blinkDurs); % get total num blinks
    
    
    %
    % Figure out stuff for sorting loops
    % use make_mtx_mask??
    % maybe should not do loop length thing and instead do by stim?
    
    
    % Probe mask
    probe_mask = ismember(trialdata.SAMPLE_MESSAGE, params.eyetracker.messages.probe_id);
    
    % Null message mask
    nullMsgMask = ismember(trialdata.SAMPLE_MESSAGE, params.eyetracker.messages.null);
    
    % Deviant masks
    hiDevMask = ismember(trialdata.SAMPLE_MESSAGE, params.eyetracker.messages.dev_hi);
    lowDevMask = ismember(trialdata.SAMPLE_MESSAGE, params.eyetracker.messages.dev_low);
    compDevMask = hiDevMask | lowDevMask;
    
    % Hit message mask
    hitMsgMask = ismember(trialdata.SAMPLE_MESSAGE, params.eyetracker.messages.hit);
    
    % Miss message mask 
    missMsgMask = ismember(trialdata.SAMPLE_MESSAGE, params.eyetracker.messages.miss);
    
    % Get a mask of loop onset indices
    loopmask = ismember(trialdata.SAMPLE_MESSAGE, params.eyetracker.messages.loop_start);
    loopIdxs = find(loopmask == 1);
    nloops = length(loopIdxs);
    
    % Figure out the normative loop length. There is some jitter, so just
    % go with the median
    loopLength = median(diff(loopIdxs));
    
    % Initialize output variables
    outdata.controlLoops{nr,1} = []; % Initialize our control loop mtx 
    outdata.allDevLoops{nr,1} = []; % Initialize our deviance containing loops
    
    % probably also want to output loop by specific deviant probe
    % output based on hit or missed 
    outdata.hitLoops{nr,1} = [];
    outdata.missLoops{nr,1} = [];
    outdata.allDevHits{nr,1} = [];
    outdata.allDevMisses{nr,1} = [];
    
    
    outdata.blinkControlLoops{nr,1} = [];
    outdata.blinkHitLoops{nr,1} = [];
    outdata.blinkMissLoops{nr,1} = [];  
    
    outdata.hiHitLoops{nr,1} = [];
    outdata.lowHitLoops{nr,1} = [];
    outdata.hiMissLoops{nr,1} = [];
    outdata.lowMissLoops{nr,1} = [];



    
    % Copy some parameters to make things more legible - both currently set
    % at 0
    nsamps_pre = params.eyetracker.nsamps_preloop;
    nsamps_post = params.eyetracker.nsamps_postloop; 
    
    % Loop through loop indices and create averages of interest 
    % BE SURE TO UPDATE WHAT EXTRACTING FROM (currently hfiltered)
    % put in if statement about loops not being same length. some off by 1
    % sample. 
    for iloop = 2:nloops-1 %added this because last loop always has issue. first loop getting acclimated
        start_idx = loopIdxs(iloop); 
        ideal_stop_idx = start_idx + loopLength - 1;
        stop_idx = min(ideal_stop_idx, length(loopmask));
        
        if stop_idx < ideal_stop_idx
            fprintf('Fewer samples to extract than available for loop %d/%d\n', iloop, nloops);
            continue
        end
            
        if start_idx-nsamps_pre < 1
            fprintf('Error obtaining desired number of preloop samples\n')
            continue
        end
        
        extract_samps = start_idx-nsamps_pre:min(stop_idx+nsamps_post, length(hfiltered)); %this..?
        
            
        
        %CONTROL
        if all(nullMsgMask(start_idx+1:stop_idx)) % nothing occurs during loop
            outdata.controlLoops{nr,1}(:,end+1) = hfiltered(extract_samps); 
            outdata.blinkControlLoops{nr,1}(:,end+1) = trialdata.RIGHT_IN_BLINK(extract_samps);
            
        else
            outdata.allDevLoops{nr,1}(:,end+1) = hfiltered(extract_samps); 
            
        end
        
        %adding this... Still need to output deviant idx so can time lock
        %to it? - no we know onset time of dev within loop
        
        %HIT
        if numel(unique(hitMsgMask(start_idx+1:stop_idx))) > 1
           outdata.hitLoops{nr,1}(:,end+1) = hfiltered(extract_samps); % detected deviant
           outdata.blinkHitLoops{nr,1}(:,end+1) = trialdata.RIGHT_IN_BLINK(extract_samps);
           
           % high vs. low
           if numel(unique(hiDevMask(start_idx+1:stop_idx))) > 1 %high res dev occured
               outdata.hiHitLoops{nr,1}(:,end+1) = hfiltered(extract_samps);
           else
               outdata.lowHitLoops{nr,1}(:,end+1) = hfiltered(extract_samps);
           end
          
           
           
        %MISS        
        elseif numel(unique(missMsgMask(start_idx+1:stop_idx))) > 1 % deviant but no response
           outdata.missLoops{nr,1}(:,end+1) = hfiltered(extract_samps);
           outdata.blinkMissLoops{nr,1}(:,end+1) = trialdata.RIGHT_IN_BLINK(extract_samps);
           
           % high vs. low
           if numel(unique(hiDevMask(start_idx+1:stop_idx))) > 1 %high res dev occured
               outdata.hiMissLoops{nr,1}(:,end+1) = hfiltered(extract_samps);
           else
               outdata.lowMissLoops{nr,1}(:,end+1) = hfiltered(extract_samps);
           end
           
        else
        end
        

%         if numel(unique(hiDevMask(start_idx+1:stop_idx))) > 1
%            outdata.hiDevLoops{nr,1}(:,end+1) = hfiltered(extract_samps);
%         elseif numel(unique(lowDevMask(start_idx+1:stop_idx))) > 1
%            outdata.lowDevLoops{nr,1}(:,end+1) = hfiltered(extract_samps);
%         else
%         end
   
        
    end %loop analysis
    
    
  end %trials
  
  ht = find(hitMsgMask == 1); % this is time of button press
  ht = ht(1:end-1);
  for i = 1:length(ht)
      startind = ht(i)-200; % probably shouldn't hard code this but diff from above
      endind = ht(i)+1115; %shortest loop length
      outdata.allDevHits{nr,1}(:,end+1) = hfiltered(startind:endind);
  end


end %subs

%% Estimate Pupillary response functions

%time locked to button press (probably bad)
b = cellfun(@isempty,outdata.allDevHits);
all_dev = outdata.allDevHits(~b);
all_dev = cellfun(@(x) mean(x,2),all_dev,'uni',false);
prf = mean(cat(2,all_dev{:}),2);
plot(prf)
title('Mean Pupillary Response Funtion to Detected Deviants')
ylabel('Normalized pupil size')
xlabel('Time (in samples)')








%%

% output separate files for each sub and stimulus and blink/pupil

% process stims through the model
% outData = jlmt_proc_series(stim_fnames,params.stimIPEMParams);
 

return



% 
% save sub pupil and blink to aud structure
% if SAVE2AUD
%   pa = params_aud('var_name',blinkData);
%   blink_aud = new_aud(pa);
%   pa2 = params_aud('var_name',pupNorm);
%   pup_ud = new_aud(pa2);
% end % saving pupil and blink all subs all trials in seperate rows/columns 




% process stims through the model
% outData = jlmt_proc_series(stim_fnames,params.stimIPEMParams);




        





