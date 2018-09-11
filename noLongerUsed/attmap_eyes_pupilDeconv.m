% Pupil Deconvolution
% Make sure IOIpup2 loaded


%% Create pupil response functions for each sub, each stim (trial)
%load('IOIpup2.mat')

PRF = table;
nr = 1;
% Create participant specific pupillary response function
subids = unique(IOIpup2.subject_id);
for isub = 1:length(subids)
    currsub = subids(isub);
    submask = strcmp(IOIpup2.subject_id, currsub);
    
    stimids = unique(IOIpup2.stimulus_id(submask));
    for istim = 1:length(stimids)
        currstim = stimids(istim);
        stimmask = strcmp(IOIpup2.stimulus_id, currstim);
        
        compmask = submask & stimmask;
        % doi = cat(1,IOIpup2.hitMean(compmask),IOIpup2.missMean(compmask));
        % want to create PRF from only hit trials
        doi = cat(1,IOIpup2.hitMean(compmask));
        for i = 1:length(doi)
            if doi{i} == 0
                doi{i} = [];
            elseif isnan(doi{i})
                doi{i} = [];
            else
            end
        end
        

        bad = cellfun('isempty', doi);
        doi = doi(~bad);
        for j = 1:length(doi)
            doi{j} = doi{j}(900:end); % HARD CODING because previously took 1000 samples pre dev onset
            % might want to go back and recreate pupIOI, taking more post
            % loop samps because pupil seems to still not return to baseline by
            % the end of this. 
            % --- changed pupIOI to go out to 2200, rather than 2000
            % samples. Also changed creation of IOIpup to be around dev onset, rather than trial onset. 11-30-16
            % -- changed this to take 900:end so that we have 200ms before
            % dev onset to baseline with. 1-11-17
            
        end
        
        doi = cell2mat(doi);
        
        % calculate prf
        prf = mean(doi);
        PRF.subject_id(nr,1) = currsub;
        PRF.stimulus_id(nr,1) = currstim;
        PRF.prf{nr,1} = prf;
        
        nr = nr+1;
    end % stim
    
end %sub


% Now calculate mean PRF for each subject and add it to PRF table
% get avg sub PRF from PRF.mat
subids = unique(PRF.subject_id);
nsubs = length(subids);

for isub = 1:nsubs  
    currsub = subids(isub);
    submaskPRF = strcmp(PRF.subject_id, currsub);
    idxs = find(submaskPRF == 1);
    meanTemp = PRF(idxs,'prf'); %subsets table
    meanTemp.prf = cell2mat(meanTemp.prf);
    submeanPRF = mean(meanTemp.prf);
    
    % subtrack baseline (avg of 200ms preceding dev onset) from PRF -
    % 1/11/17
    baseline = mean(submeanPRF(1:100));
    submeanCorrectedPRF = submeanPRF-baseline;
    
    %low pass at 2hz
    [b,a] = butter(5,2/250,'low'); %seems good
    %freqz(b,a) %if want to image filter
    lfilteredPRF = filtfilt(b,a,submeanPRF);
    
    %highpass at .2Hz
    [b,a] = butter(5,.2/250,'high');
    hfilteredPRF = filtfilt(b,a,lfilteredPRF);

    % added the below on 1-11-17
    %downsample all pupil data
    newPRF = decimate(hfilteredPRF,5); %factor of 5 because want to go from 500->100Hz
    
    %save
    PRF.meanPRF{idxs(end),1} = newPRF;

end %sub




fpath = params.paths.matpath;
fstub = 'PRF';
outfname = fullfile(fpath,[fstub '.mat']);
fprintf('Saving mat file: %s\n', outfname) 
save(outfname,'PRF') 



% to image transformations
figure()
subplot(151)
plot(submeanPRF)
title('submeanPRF')
subplot(152)
plot(submeanCorrectedPRF)
title('baselined')
subplot(153)
plot(lfilteredPRF)
title('lowpass')
subplot(154)
plot(hfilteredPRF)
title('high pass')
subplot(155)
plot(newPRF)
title('downsampled')





%% Print individiual trial PRFs (these have not been cleaned) for each sub (for inspection purposes)

subids = unique(PRF.subject_id);
nsubs = length(subids);
figure()
for isub = 1:nsubs
    currsub = subids(isub);
    submaskPRF = strcmp(PRF.subject_id, currsub);
    
    idxs = find(submaskPRF == 1);
    nidxs = length(idxs);
    
    subplot(2,9,isub)
    legendmatrix = cell(1,nidxs);
    for iidx = 1:length(idxs)
        curridx = idxs(iidx);
        plot(PRF.prf{curridx})
        hold on
        title(currsub)
        xlabel('Time (in samples)')
        ylabel('Normalized Pupil Size')
        ylim([-1 1.5])
        
        
        legendmatrix{iidx} = PRF.stimulus_id{curridx};
        
    end
    legend(legendmatrix, 'Location', 'SouthEast');
    % print to file if desired
end
suptitle({'Mean Pupillary Response Function for each Subject, each Stimulus.' 'Deviant onset at Time=20'})
% WRONG. it is loop onset at t=0, not deviant.. need to fix this!!!!
% 11-30-16 - fixed! Now it is deviant onset at t = 0. 
% 1-11-17 now since taking 100 samples (200ms) before dev onset, but then
% downsampling by factor of 5, dev onset should be at 20, correct??


%% Print mean PRF for each sub

subids = unique(PRF.subject_id);
nsubs = length(subids);
figure(2)
for isub = 1:nsubs
    currsub = subids(isub);
    submaskPRF = strcmp(PRF.subject_id, currsub);
    
    idxs = find(submaskPRF == 1);
    lastidx = idxs(end); %this is idx where mean will be
    
    subplot(2,9,isub)
    plot(PRF.meanPRF{lastidx})
    hold on
    title(currsub)
    xlabel('Time (in 100Hz samples)')
    ylabel('Normalized Pupil Size')
    ylim([-1 1.5])

    % print to file if desired
end
suptitle({'Mean Pupillary Response Function for each Subject, each Stimulus.' 'Deviant onset at Time=20'})


%% Calculate mean PRF across subs 
PRFmat = PRF.meanPRF;
PRFmat = cell2mat(PRFmat);
meanPRF = mean(PRFmat);
figure
plot(meanPRF)
title('Mean PRF to deviant (t = 20), across all subjects')
xlabel('Time (in 100Hz samples)')
ylabel('Normalized Pupil Size')

% think about adding error into all of this by grabbing SEM data from
% IOIpup earlier
% hND = jbfill(xpointsND,NDUpper,NDLower,'k','k',1,.5);




%% Compute Hooks & Levelt PRF

% set arbitrary (?) t-scale
Fs = 100;
tscale = 0:1000/Fs:2500; %should be specified in ms
tmax = 930;

HLmodel = tscale.^10.1 .* exp(1).^(-10.1*tscale/930)/tmax^10.1; % expect maximal resp at 930ms
HLmodel(end) = 0;
figure()
plot(HLmodel)

%% Now deconvolve each trial in pupdata.pupNorm
% --- or no... probably want to deconv avg no dev trial, avg hit, etc.

% this crashed "index exceeds.."
% not sure why doing all of this. need to revisit notes... 
% - LF 11-30-16

% deconvData = table;
% nr = 1;
% % Find participant specific pupillary response function for each run
% subids = unique(PRF.subject_id);
% for isub = 1:length(subids)
%     currsub = subids(isub);
%     submaskPup = strcmp(pupdata.subject_id, currsub);
%     submaskPRF = strcmp(PRF.subject_id, currsub);
%     
%     stimids = unique(PRF.stimulus_id(submaskPup));
%     for istim = 1:length(stimids)
%         currstim = stimids(istim);
%         stimmaskPup = strcmp(pupdata.stimulus_id, currstim);
%         stimmaskPRF = strcmp(PRF.stimulus_id, currstim);
%         
%         compmaskPup = submaskPup & stimmaskPup;
%         toDeconv = pupdata.pupNorm(compmaskPup);
%         toDeconv = cell2mat(toDeconv);
%         
%         compMaskPRF = submaskPRF & stimmaskPRF;
%         kernel = PRF.prf(compMaskPRF);
%         kernel = cell2mat(kernel);
%         
%         % now deconvolve
%         [Q,R] = deconv(toDeconv, kernel); %Q is signal of interest
%         
%         % downsample, average into bins (what kang + wierda do) ??
%         % seems like we might have vanishing coefficients - putting us in a
%         % division by almost zero situation - something needs to be done
%         
%         % sav all info of potential interest
%         deconvData.subject_id(nr,1) = currsub;
%         deconvData.stimulus_id(nr,1) = currstim;
%         deconvData.originalPup{nr,1} = toDeconv;
%         deconvData.prf{nr,1} = kernel;
%         deconvData.deconv{nr,1} = Q;
%         deconvData.resid{nr,1} = R;
%         
%         % WTF NONE OF THIS LOOKS RIGHT
%         
%         
%         nr = nr+1;
%     end %stim
%     
% end %sub



%% New method is to convolve PRF w impulse train (BASED ON OURS AND OTHERS' MODELS) and compare to noDev avg for each stim












