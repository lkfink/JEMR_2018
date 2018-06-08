%% Logistic regression analysis
% to predict whether deviant is hit or missed on any given trial, given
% pupil and model predictors

% LF - edited 20180222

params = attmap_eyes_globals;
LOAD_DATA = 0;

% Variables below must be loaded
if LOAD_DATA
    % Load data table
    fpath = params.paths.matpath;
    fstub = 'loopTable2.mat';
    sprintf('Loading %s', fstub)
    load(fullfile(fpath, fstub))
    fprintf('Finished loading data')
end 

% Organize variables
devoccured_mask = ~isnan(loopTable2.probe_idx);

% Predictors
% Only take predictors that are not correlated with each other
% From previous correlation analysis, we know that baseline pupil is
% correlated with mean and max evoked pupil, and that mean and max evoked
% pup are correlated with each other. 
% predictors = [
%     loopTable2.baselinePupMean200(devoccured_mask), ...
%     loopTable2.trialPupMean(devoccured_mask), ... 
%     loopTable2.trialPupMax(devoccured_mask), ...
%     loopTable2.trialPupMaxLatency(devoccured_mask), ...
%     loopTable2.trialPupSlope(devoccured_mask), ...
%     loopTable2.resonOut(devoccured_mask), ...
%     loopTable2.curr_dB_lev(devoccured_mask)
%     ];

predictors = [
    loopTable2.trialPupMean(devoccured_mask), ... 
    loopTable2.trialPupMaxLatency(devoccured_mask), ...
    loopTable2.trialPupSlope(devoccured_mask), ...
    loopTable2.resonOut(devoccured_mask), ...
    loopTable2.curr_dB_lev(devoccured_mask)
    ];


% Binary outcome of trial
outcome = loopTable2.hit(devoccured_mask);

% Compute logistic regression
%[B,dev,stats] = glmfit(predictors, outcome, 'binomial', 'link', 'logit');
%mdl = fitglm(predictors, outcome, 'linear', 'distr', 'binomial');

% Use stepwise model 
mdl = stepwiseglm(predictors, outcome, 'constant', 'Distribution', 'binomial', 'upper', 'linear');

% Get confidence intervals
confint = coefCI(mdl);





