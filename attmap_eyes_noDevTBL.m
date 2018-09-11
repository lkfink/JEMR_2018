% Create structure to hold all noDev trials for each sub - to be used in coherence analysis
% - Lauren Fink (lkfink@ucdavis)
% Janata Lab, UC Davis, Center for Mind & Brain 

noDevTBL = table;
preloopSamps = 0;
postloopSamps = 1200;

subids = unique(loopTable.subject_id);
nsubs = length(subids);

nr = 0;

% Fix cell/ char issue in loopTable so can use strcmpi
for i = 1:length(loopTable.probe_id)
    loopTable.probe_id{i} = char(loopTable.probe_id{i});
end


for isub = 1:nsubs
    currsub = subids(isub);
    submask = strcmp(loopTable.subject_id, currsub);
    
    stimids = unique(loopTable.stimulus_id(submask)); %accounting for sub
    nstims = length(stimids);
    
    % only take second of no dev trials 
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
        
        
        %mask pup data - create seperate masks to index pupdata
        subdatamask = strcmp(currsub, pupdata.subject_id);
        stimdatamask = strcmp(currstim, pupdata.stimulus_id);
        compmask = subdatamask & stimdatamask;
        currdata = pupdata(compmask,:);
        currdata = cell2mat(currdata.pupNorm);
        
    if isempty(currdata) % in the event that this sub/stim combo got thrown out of pupdata due to too much interpolation
            continue
    else
        compDevMask = submask & stimmask & noDev2ndMask;
        noDevIdxs = loopTable.loop_start(compDevMask); 
        ntrials = length(noDevIdxs);
        noDevData = zeros(ntrials, preloopSamps+postloopSamps+1);
        for i = 2:ntrials %first instance is at very begininng of run (no time to entrain)
            nr = nr+1;  % increment counter
            currIdx = noDevIdxs(i);
            pre = currIdx - preloopSamps;
            post = currIdx + postloopSamps;
            noDevTBL.subject_id(nr,1) = currsub;
            noDevTBL.stimulus_id(nr,1) = currstim;
            noDevTBL.noDevData{nr,1} = currdata(pre:post);
        end % individ trials
    end % end if statement
    
    end % istim
    
    
end % isub

%save('noDevTBL.mat', 'noDevTBL')