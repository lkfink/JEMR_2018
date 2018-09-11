% Correlations between all predictor and outcome variables on 'hit' trials
% Last edited - 20180816 - - Lauren Fink (lkfink@ucdavis)
% Janata Lab, UC Davis, Center for Mind & Brain 

params = attmap_eyes_globals; 
fpath = params.paths.matpath;
LOAD_DATA = 1;

if LOAD_DATA
    fstub = 'LoopTable2.mat';
    sprintf('Loading %s', fstub)
    load(fullfile(fpath, fstub))
    fprintf('Finished loading: %s', fstub) 
end

%% make matrix of all possible variables and compute correlation table on trial level
hit = 0; % specify whether want to look at correlations for hit vs. missed trials
basePupMask = ~isnan(loopTable2.baselinePupMean200);
trialPupMask = ~isnan(loopTable2.trialPupMax);
hitmask = logical(loopTable2.hit);
dev_occurred = logical(~isnan(loopTable2.probe_idx));
missmask = ~hitmask & dev_occurred;

if hit
    compmask = basePupMask & trialPupMask & hitmask;
else
    compmask = basePupMask & trialPupMask & missmask;
end

% Mean baseline pup
% dB contrast
% Reson out
% Mean evoked pup
% Max evoked pup
% Max latency
% Pup velocity
% Reaction 

corrvars = [loopTable2.baselinePupMean200(compmask), ...
    loopTable2.curr_dB_lev(compmask), ...
    loopTable2.resonOut(compmask), ...
    loopTable2.trialPupMean(compmask), ...
    loopTable2.trialPupMax(compmask), ...
    loopTable2.trialPupMaxLatency(compmask), ...
    loopTable2.trialPupSlope(compmask), ...
    loopTable2.RT(compmask)];

[r,p] = corrcoef(corrvars);

% fstub  = 'corrTable.txt';
% fname = fullfile(params.paths.tablepath, fstub);
fprintf('Correlation coefficients between all variables on "hit" trials\n\n');
fprintf('Mean baseline pup\t\tdB contrast\t\tReson out\t\tMean evoked pup\t\tMax evoked pup\t\tMax latency\t\tPup velocity\t\tRT\n');
[rows, cols] = size(r);
sig_sym = '*';
sig_sym2 = '**';
for ir = 1:rows
    for ic = 1:cols
        curr_r = r(ir, ic);
        curr_p = p(ir, ic);
        if curr_p < .001
            fprintf('%.3f%s', curr_r, sig_sym2) % add three asterisks
        elseif curr_p < .05
            sig = 1;
            %fprintf(fileID, '%.3f%s', curr_r, sig_sym); % add asterisk
            fprintf('%.3f%s', curr_r, sig_sym) % add asterisk
        else
            %fprintf(fileID, '%.3f', curr_r);
            fprintf('%.3f', curr_r)
        end
        fprintf('\t\t')
    end % col
    fprintf('\n')
end
% ------------------------------------------------------------------------%

%% Correlation table on averages

% first need numbers for subs and stims
stims = unique(loopTable2.stimulus_id);
for istim = 1:length(stims)
    currstim = stims{istim};
    stimmask = strcmp(loopTable2.stimulus_id, currstim);
    loopTable2.stimnum(stimmask, 1) = istim;
end

subs = unique(loopTable2.subject_id);
for isub = 1:length(subs)
    currsub = subs{isub};
    submask = strcmp(loopTable2.subject_id, currsub);
    loopTable2.subnum(submask, 1) = isub;
end
% ------------------------------------------------------------------------%


T = table(loopTable2.baselinePupMean200(compmask), ...
    loopTable2.curr_dB_lev(compmask), ...
    loopTable2.resonOut(compmask), ...
    loopTable2.trialPupMean(compmask), ...
    loopTable2.trialPupMax(compmask), ...
    loopTable2.trialPupMaxLatency(compmask), ...
    loopTable2.trialPupSlope(compmask), ...
    loopTable2.RT(compmask),...
    loopTable2.subnum(compmask));

T.Properties.VariableNames{'Var1'} = 'BasePup';
T.Properties.VariableNames{'Var2'} = 'Curr_dB';
T.Properties.VariableNames{'Var3'} = 'Reson_Out';
T.Properties.VariableNames{'Var4'} = 'TrialPupMean';
T.Properties.VariableNames{'Var5'} = 'TrialPupMax';
T.Properties.VariableNames{'Var6'} = 'TrialPupLatency';
T.Properties.VariableNames{'Var7'} = 'TrialPupSlope';
T.Properties.VariableNames{'Var8'} = 'RT';
T.Properties.VariableNames{'Var9'} = 'SubID';

% do corrceof with sub avgs instead
submeans = varfun(@mean,T,'GroupingVariables','SubID');



corrvars = [submeans.mean_BasePup, ...
    submeans.mean_Curr_dB, ...
    submeans.mean_Reson_Out, ...
    submeans.mean_TrialPupMean, ...
    submeans.mean_TrialPupMax, ...
    submeans.mean_TrialPupSlope, ...
    submeans.mean_TrialPupLatency, ...
    submeans.mean_RT];

[r,p] = corrcoef(corrvars);


fstub  = 'corrTable.txt';
fname = fullfile(params.paths.tablepath, fstub);
fprintf('Correlation coefficients between all variables on "hit" trials\n\n');
fprintf('Mean baseline pup\t\tdB contrast\t\tReson out\t\tMean evoked pup\t\tMax evoked pup\t\tMax latency\t\tPup velocity\t\tRT\n');
[rows, cols] = size(r);
sig_sym = '*';
sig_sym2 = '**';
for ir = 1:rows
    for ic = 1:cols
        curr_r = r(ir, ic);
        curr_p = p(ir, ic);
        if curr_p < .001
            fprintf('%.3f%s', curr_r, sig_sym2) % add three asterisks
        elseif curr_p < .05
            sig = 1;
            %fprintf(fileID, '%.3f%s', curr_r, sig_sym); % add asterisk
            fprintf('%.3f%s', curr_r, sig_sym) % add asterisk
        else
            %fprintf(fileID, '%.3f', curr_r);
            fprintf('%.3f', curr_r)
        end
        fprintf('\t\t')
    end % col
    fprintf('\n')
end


% Subjects with low baseline pupil tend to have high max evoked pupil size

% NOTE
% An decrease in baseline pupil size within an individual was associated with an
% increase in max evoked pupil size in that individual 


%% Other basic stats on pupil data

% Check if sig diff between baseline pupil size on no hit vs miss trials
baseMeans = table;
evokedMeans = table;
nr = 1;
for isub = 1:length(subs)
    currsub = subs{isub};
    submask = strcmp(loopTable2.subject_id, currsub);
    baseMeans.sub{nr,1} = currsub;
    baseMeans.hit(nr,1) = nanmean(loopTable2.baselinePupMean200(hitmask & submask));
    baseMeans.miss(nr,1) = nanmean(loopTable2.baselinePupMean200(missmask & submask));
    evokedMeans.sub{nr,1} = currsub;
    evokedMeans.hit(nr,1) = nanmean(loopTable2.trialPupMean(hitmask & submask));
    evokedMeans.miss(nr,1) = nanmean(loopTable2.trialPupMean(missmask & submask));
    evokedMeans.noDev(nr,1) = nanmean(nanmean(shortenCell2Mat(loopTable2.loopPup(~missmask & ~hitmask & submask))));
    nr = nr+1;
    
end % sub

[h,p,ci,stats] = ttest(baseMeans.hit, baseMeans.miss);
[h,p,ci,stats] = ttest(evokedMeans.hit, evokedMeans.miss);
[h,p,ci,stats] = ttest(evokedMeans.miss, evokedMeans.noDev);

    

