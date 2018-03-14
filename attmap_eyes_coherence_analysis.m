%% Frequency domain analysis
% attmap_eyes project
% LF started - 20180209 
% look at mscoherence between pupil and model predicted spectra for each
% sub, stim combo

% Specifically, test whether the distributions of stim/pupil coherences for 
% each stim (pooled across subjects) differ from the distribution of null 
% CSDM coherences (pooled across subjects)

params = attmap_eyes_globals;
fpath = params.paths.matpath;
LOAD_DATA = 0;
LOAD_ANALYSIS = 1;

% Variables below must be loaded to run coherence analysis
if LOAD_DATA
    % Load pupil data table
    fstub = 'pupdata.mat';
    sprintf('Loading %s', fstub)
    load(fullfile(fpath, fstub))
    fprintf('Finished loading: %s', fstub)
    
    fstub = 'LoopTable2.mat';
    sprintf('Loading %s', fstub)
    load(fullfile(fpath, fstub))
    fprintf('Finished loading: %s', fstub)
    
    % Load model data
    fstub = 'MPP_pup.mat'; % the mat is called rp
    sprintf('Loading %s', fstub)
    load(fullfile(fpath, fstub))
    fprintf('Finished loading: %s', fstub)
end 


%% Create new table that is pupil and model data we want
nloops = 160; % number of pupil loops we want to take for each stim
% NOTE: number of loops not equal for each stim. This is safe number to
% take. 
subs =  unique(loopTable2.subject_id);
pup_mod_cohere = table;
nr = 1;
for isub = 1:length(subs)
    currsub = subs(isub);
    submask = strcmp(currsub, loopTable2.subject_id);
    
    for istim = 1:length(params.stimnames2)
        currstim = params.stimnames2{istim};
        stimmask = strcmp(currstim, loopTable2.stimulus_id);
        
        compmask = submask & stimmask;
        
        % Get appropriate loop start and end indices
        start_loop_num = 3;
        end_loop_num = nloops+start_loop_num;
        
        loop_start_ind = find(loopTable2.loop_num(compmask) == start_loop_num);
        loop_start_time = loopTable2.loop_start(loop_start_ind);
        
        loop_end_ind = find(loopTable2.loop_num(compmask) == end_loop_num);
        loop_end_time = loopTable2.loop_start(loop_end_ind);
        
        % Now mask pupdata
        stimmask_pup = strcmp(currstim, pupdata.stimulus_id);
        submask_pup = strcmp(currsub, pupdata.subject_id);
        compmask_pup = stimmask_pup & submask_pup;
        
        % Get pupil data for this sub
        % check that data for this sub was discarded due to 
        % too much interpolation
        if isempty(pupdata.pupNorm(compmask_pup)) 
            continue
        else
            thissub_pup = pupdata.pupNorm{compmask_pup};
        end
        
        % Downsample pupil to 100 Hz for comparison with model predictions
        desiredFs = 100;
        originalFs = params.eyetracker.Fs;
        [p,q] = rat(desiredFs / originalFs);
        thissub_pup_downsampled = resample(thissub_pup,p,q);
        
        % Mask model data for this stim
        stimmask_mod = strcmp(currstim, rp.stim);
        mod_pred = rp.meanSig_peakTseries{stimmask_mod};
        
        % Extend model data for nloops
        mod_pred_ext = repmat(mod_pred, 1, nloops+1);
        
        % Make all pup and model data the same length
        % TODO: CHECK: is this ok? or will it interfere with coherence
        % estimate? mscohere requires vectors to be same length...
        % NOTE: Have tested a few different lengths here and it does not 
        % seem to change the ultimate cpsd. 35500 is safe number of samps
        % to take for all sub / stim / combos
        thissub_pup_downsampled = thissub_pup_downsampled(1:35500);
        mod_pred_ext = mod_pred_ext(1:35500);
        
        % Add necessary data to table
        pup_mod_cohere.subject(nr,1) = currsub;
        pup_mod_cohere.stim{nr,1} = currstim;
        pup_mod_cohere.pup{nr,1} = thissub_pup_downsampled;
        pup_mod_cohere.model{nr,1} = mod_pred_ext;
        
        nr = nr+1;
        
    end % stim
end % sub
        
    

%% Notes from Petr

% For the actual code, there are two options. One would be to use some 
% homegrown csdm and coherence code written by Ramesh Srinivasan that we used
% to use for EEG data. The other would be to use the cpsd() function in 
% MATLAB?s Signal Processing Toolbox. I would set window sizes to correspond 
% to 2 cycles, either with 0% overlap or 50% overlap. Obviously Fs has to be 
% identical for the Pupil and Stimulus data.



%% Calculate true and null cpsd for each sub/stim pair
subs = unique(pup_mod_cohere.subject);
nr = 1;
null = table;


for isub = 1:length(subs)
    currsub = subs(isub);
    submask = strcmp(pup_mod_cohere.subject, currsub);
    
    thissub_stims = pup_mod_cohere.stim(submask);
    thissub_mods = pup_mod_cohere.model(submask);
    
    null.pup{isub,1} = 0;
    null.mod{isub,1} = 0;
    null.pm{isub,1} = 0;
    
    for istim = 1:length(thissub_stims)
        currstim = thissub_stims(istim);
        stimmask = strcmp(pup_mod_cohere.stim, currstim);
        
        compmask_pup = submask & stimmask;
        currpup = pup_mod_cohere.pup{compmask_pup};
        
        for imod = 1:length(thissub_mods)
            currmod = thissub_mods{imod};
            
            % Calculate cpsd between this pup/stim and all others
            WINDOW = ceil(length(currpup)/nloops * 2);
            NOVERLAP = ceil(WINDOW/4*3);
            NFFT = WINDOW;
            Fs = 100;
            
            fprintf('Subject %d, Stimulus %d, Model %d\n', isub, istim, imod)
            [Ppm,Fpm] = cpsd(currpup,currmod,WINDOW,NOVERLAP,NFFT,Fs);
            [Ppp,Fpp] = cpsd(currpup,currpup,WINDOW,NOVERLAP,NFFT,Fs);
            [Pmm,Fmm] = cpsd(currmod,currmod,WINDOW,NOVERLAP,NFFT,Fs);
            
            % Save to table
            if istim == imod % true case
                pup_mod_cohere.true_cpsd_Ppm{nr,1} = Ppm;
                pup_mod_cohere.true_Ppp{nr,1} = Ppp;
                pup_mod_cohere.true_Pmm{nr,1} = Pmm; 
                pup_mod_cohere.true_cohere{nr,1} = (abs(Ppm).^2)./(Ppp.*Pmm); 
            else % all other cases
                pup_mod_cohere.null_cpsd_Ppm{nr,imod} = Ppm;
                pup_mod_cohere.null_Ppp{nr,imod} = Ppp;
                pup_mod_cohere.null_Pmm{nr,imod} = Pmm; 
                
                null.sub(isub,1) = currsub;
                null.pup{isub,1} = null.pup{isub,1} + Ppp;
                null.mod{isub,1} = null.mod{isub,1} + Pmm;
                null.pm{isub,1} = null.pm{isub,1} + Ppm;
                null.F{isub,1} = Fpm;
            end
           
            pup_mod_cohere.F{nr,1} = Fpm;
            
        end % mod
        
        nr = nr+1;

    end % stim
    null.cohere{isub,1} = (abs(null.pm{isub,1}).^2)./(null.pup{isub,1}.*null.mod{isub,1});
    
end % sub



%% Save table
fpath = params.paths.matpath;
outfname = fullfile(fpath,'pup_mod_cohere');
fprintf('\nSaving mat file: %s\n', outfname)
save(outfname,'pup_mod_cohere', '-v7.3');
fprintf('%s saved', outfname)

outfname = fullfile(fpath,'null_cpsds');
fprintf('\nSaving mat file: %s\n', outfname)
save(outfname,'null', '-v7.3');
fprintf('%s saved', outfname)


