% LF - 5-17-16

% Get blink data
%load('ds.mat')

%find blinks
%check lengths

nsubs = length(ds);
ntrials = zeros(nsubs,1);

% Prepare our output datatables
blinkdata = table; %table w blink data by run

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
 
  % Figure out which rows belong to which trial - is this doing something
  % weird with columns?? - make normal mask out of it later
  [trialmaskMtx, trial_idxs] = make_mask_mtx(currSubjectData.TRIAL_INDEX);
  
  % Loop over each of the stimulus trials for this subject
  for itrial = 1:ntrials(isub)
    nr = nr+1;
    
    % Figure out our stimulus ID
    stimid = currsubInfo.stimulus_order{itrial};
    
    % Output basic info to table
    blinkdata.subject_id{nr,1} = subid;
    blinkdata.trial_id(nr,1) = itrial;
    blinkdata.stimulus_id{nr,1} = stimid;
    
    % Deal only with current trial data 
    trialmask = trialmaskMtx(:,itrial);
    trialdata = currSubjectData(trialmask,:);   
 
    
    % Extract the raw blink data
    fprintf('Saving blink data for trial: %d\n',itrial);
    blinkdata.blinkRaw{nr,1} = trialdata.RIGHT_IN_BLINK;
    
    
    % Do a few basic descriptive stats
    temp = diff(blinkdata.blinkRaw{nr,1});
    onsetIdxs = find(temp == 1);
    offsetIdxs = find(temp == -1);
    if numel(offsetIdxs) < numel(onsetIdxs) %sometimes 1 extra onset if trial ends in blink
        onsetIdxs = onsetIdxs(1:end-1); %remove this blink because don't have dur data, etc.
    else
    end
    blinkSamps = offsetIdxs - onsetIdxs;
    blinkDurs = blinkSamps*2; %sampling rate    
    blinkdata.blinkDurs{nr,1} = blinkDurs;

    for i = 1:length(blinkDurs)
%         blinks = find(blinkDurs(i) <= 300);
%         blinkdata.blinks(nr,1) = numel(blinks);
%         
%         slowBlinks = find(blinkDurs(i)>300 && blinkDurs(i)<500);
%         blinkdata.slowBlinks(nr,1) = numel(slowBlinks);
%         
%         microsleeps = find(blinkDurs(i)>=500 && blinkDurs(i)<1000);
%         blinkdata.microsleeps(nr,1) = numel(microsleeps);
        
        badIdxs = find(blinkDurs(i) > 1000);
        if any(badIdxs)
            blinkdata.flag(nr,1) = 1;
            fprintf('Flagged potential bad data for sub %s\n', subid)
        else
        end
    end
    
    
  end %itrial (stim)

end %isub


% could create goodmask where ~flagged

% now use loopTable (already created) to index into blinkdata

% create raster plots?


%%



% could create goodmask where ~flagged
badmask = logical(blinkdata.flag);
blinkdata = blinkdata(~badmask,:); 


% consider removing these subs/trials from pup data as well - and/or look
% into ways to clean blink data
%% now use loopTable (already created) to index into blinkdata

% create raster plots?





% This parses blink data by indices of interest from loopTable 
% A more condensed version of loopTable is created, with blink data included by sub.
IOIblink = table;
nr = 0;

subids = unique(loopTable.subject_id);
nsubs = length(subids);
for isub = 1:nsubs
    currsub = subids(isub);
    submask = strcmp(loopTable.subject_id, currsub);
    
    stimids = unique(loopTable.stimulus_id(submask)); %accounting for sub
    nstims = length(stimids);
    
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
        
        %mask blink data
        subdatamask = strcmp(currsub, blinkdata.subject_id);
        stimdatamask = strcmp(currstim, blinkdata.stimulus_id);
        compmask = subdatamask & stimdatamask;
        currdata = blinkdata(compmask,:);
        currdata = cell2mat(currdata.blinkRaw);
        
        if isempty(currdata) % in the event that this sub/stim combo got thrown out of blinkdata due to too much interpolation
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
                
                IOIblink.subject_id(nr,1) = currsub;
                IOIblink.stimulus_id(nr,1) = currstim;
                IOIblink.dev_label(nr,1) = currprobe;
                
                
                %set sample extraction params
                preloopSamps = 1000;
                postloopSamps = 2000; % HARD CORDING
                
                if strcmp(currprobe, 'no_deviant')
                    noDevIdxs = loopTable.loop_start(submask & stimmask & noDev2ndMask);
                    ntrials = length(noDevIdxs);
                    noDevData = zeros(ntrials, preloopSamps+postloopSamps+1);
                    for i = 2:ntrials-2 %first and last trials wont have enough samps
                        currIdx = noDevIdxs(i);
                        pre = currIdx - preloopSamps;
                        post = currIdx + postloopSamps;
                        noDevData(i,:) = currdata(pre:post);
                    end
                    noDevData(1,:) = [];
                    meanNoDev = mean(noDevData);
                    SEMnoDev = std(noDevData)/sqrt(ntrials-3); %because cutting off first and last loop
                    
                    % save mean and SEM to table
                    IOIblink.noDev{nr,1} = noDevData;
                    IOIblink.noDevMean{nr,1} = meanNoDev;
                    IOIblink.noDevSEM{nr,1} = SEMnoDev;
                    IOIblink.meanPDF(nr,1) = 0;
                    
                else %dev
                    % Save hit data
                    hitIdxs = loopTable.loop_start(compIOImask & hitmask);
                    ntrials = length(hitIdxs);
                    if ntrials == 0
                        IOIblink.hit{nr,1} = NaN;
                        IOIblink.hitMean{nr,1} = NaN;
                        IOIblink.hitSEM{nr,1} = NaN;
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
                        IOIblink.hit{nr,1} = hitData;
                        IOIblink.hitMean{nr,1} = meanHit;
                        IOIblink.hitSEM{nr,1} = SEMhit;
                    end
                    
                    %Save miss data
                    missIdxs = loopTable.loop_start(compIOImask & missmask);
                    ntrials = length(missIdxs);
                    if ntrials == 0
                        IOIblink.miss{nr,1} = NaN;
                        IOIblink.missMean{nr,1} = NaN;
                        IOIblink.missSEM{nr,1} = NaN;
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
                        IOIblink.miss{nr,1} = missData;
                        IOIblink.missMean{nr,1} = meanMiss;
                        IOIblink.missSEM{nr,1} = SEMmiss;
                    end
                    meanPDF = loopTable.maxMeanPDF(compIOImask & convergedMask);
                    if isempty(meanPDF)
                        IOIblink.meanPDF(nr,1) = 0;
                    else
                        IOIblink.meanPDF(nr,1) = meanPDF;
                    end % checking that this sub had this stim/probe combo and therefore a meanPDF
                end
            end
        end
    end
end




%% Plot IOIblnk Across subs


% outMeans = cell(nsubs,nstims,nprobes);  % just going to hard code this
% for now: 5 stims, 20 probes
outMeans = table;

stimids = unique(IOIblink.stimulus_id);  
figure() %initialize figure 
pi = 1;
nr = 1;    

for istim = 1:length(stimids)
    
    currStim = stimids(istim);
    stimmask = strcmp(IOIblink.stimulus_id, currStim);
    

    alldevids = unique(IOIblink.dev_label(stimmask));
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
    controlmask = strcmp(IOIblink.dev_label, 'no_deviant');
    noDevData = IOIblink.noDevMean(stimmask & controlmask);
    nsubs = length(noDevData);
    noDevData = cell2mat(noDevData);
    noDevMean = mean(noDevData);
    noDevSEM = std(noDevData)/sqrt(nsubs);
    xpointsND = 1:length(noDevMean);
    NDUpper = noDevMean + noDevSEM;
    NDLower = noDevMean - noDevSEM;
     
    
    for idev = 1:length(devids)
        currdev = devids(idev);
        probe_mask = strcmp(IOIblink.dev_label, currdev);
        
        outMeans.stimulus_id(nr,1) = currStim;
        outMeans.dev_label(nr,1) = currdev;
        
        % Hit - what is deal with hit 1530 and ? - nan seems to solve it
        outHitData = IOIblink.hitMean(stimmask & probe_mask);
        for i = 1:length(outHitData)
            if isnan(outHitData{i})
                 outHitData{i} = zeros(1,3001); % hard coding... 
            else
            end
        end
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
        outMissData = IOIblink.missMean(stimmask & probe_mask);
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
        
        ylim([0 .3]);
        xlim([0 3000]);
        y1 = get(gca, 'ylim');
        plot([1000 1000], y1, 'k') % nsamps 1000 pre/2000 post - this is start of loop
        hold on
        plot([probetime probetime], y1, ':r', 'LineWidth', 2)
        hold on
        xlabel('Time (msecs)')
        ylabel('Blink Frequency')
        title(currdev, 'interpreter','none')
        legend([hHit hMiss hND],{'Hit','Miss', 'No Deviant'},'Location','northwest')
        set(gca,'XTickLabel',{'0', '1000','2000', '3000'})
        set(gca, 'fontsize', 14)

        pi=pi+1;
        nr = nr+1;     
    end %probes for this stim
    
    outMeans.noDevMean{nr,1} = noDevMean;
    outMeans.noDevSEM{nr,1} = noDevSEM; 
    

    
end % stim
suptitle('Mean blink response to each deviant of each stim, across all participants, time-locked to loop onset (at time = 0) and deviant onset (red dotted line)')







