%% Plot avg pupil trace for all trial types
% Generates a single plot with hit, miss, no dev pupil traces, averaged
% across all subs and stims

% Lauren Fink
% Janata Lab
% UC Davis Center for Mind & Brain
% Last edited: 20180215

params = attmap_eyes_globals;
LOAD_DATA = 0;
BW = 0; % Specify whether plot should be black and white or color
DEV_0 = 0; % Specify whether to use no dev data for only the dev 0 case, or all no dev data

% Variables below must be loaded
if LOAD_DATA
    % Pupil data
    fpath = params.paths.matpath;
    fstub = 'loopTable2.mat';
    sprintf('Loading %s', fstub)
    load(fullfile(fpath, fstub))
    fprintf('Finished loading data')
    
    % Sorted no deviant pupil data
    fstub = 'nd_probes.mat';
    sprintf('Loading %s', fstub)
    load(fullfile(fpath, fstub))
    fprintf('Finished loading data')
end 



%-------------------------------------------------------------------------%
                         % Organize data to plot %
%-------------------------------------------------------------------------%
% Create masks
devoccured_mask = ~isnan(loopTable2.probe_idx);
hitmask = logical(loopTable2.hit);
hitmask = hitmask & devoccured_mask;
missmask = ~hitmask;

% Hit data, averages, and SEM
hitdata = cell2mat(loopTable2.trialPup(hitmask));
nHit = length(hitdata(:,1));
hitMean = mean(hitdata);
hitSEM = std(hitdata)/sqrt(nHit);
hitUpper = hitMean + hitSEM;
hitLower = hitMean - hitSEM;

% Miss data, averages, and SEM
missdata = cell2mat(loopTable2.trialPup(missmask));
nMiss = length(missdata(:,1));
missMean = mean(missdata);
missSEM = std(missdata)/sqrt(nMiss);
missUpper = missMean + missSEM;
missLower = missMean - missSEM;

% No deviant data, averages, and SEM
nodevmean = nanmean(cell2mat(nd_probes.ndmean));
ndUpper = nanmean(cell2mat(nd_probes.upperSEM));
ndLower = nanmean(cell2mat(nd_probes.lowerSEM));

% Plot no dev mean for case where probe time = 0 (this is the most possible
% clean data to take).
if DEV_0
    probeid = 'dev_hi_0';
    probemask = strcmp(nd_probes.probe, probeid);
    nodevmean = nd_probes.ndmean{probemask};
    ndUpper = nd_probes.upperSEM{probemask};
    ndLower = nd_probes.lowerSEM{probemask};
end

%-------------------------------------------------------------------------%
                                 % Plot %
%-------------------------------------------------------------------------%

% Scale time (for x axis)
fs = 500;
plotlim = length(hitmean);
secs = plotlim/fs;
x = 1:(fs*secs);
xaxis = x/fs*1000;

% Initialize figure
figure()

% Plot in black & white
if BW
    plot(xaxis, hitMean, 'Color', [0,0,0])
    hold on
    hHit = jbfill(xaxis,hitUpper,hitLower,[0,0,0],[0,0,0],1,.75);
    hold on
    plot(xaxis, missMean, 'Color', [0,0,0]+.5)
    hMiss = jbfill(xaxis,missUpper,missLower,[0,0,0]+.5,[0,0,0]+.5,1,.75);
    hold on
    plot(xaxis, nodevmean, 'Color', [0,0,0]+.8)
    hND = jbfill(xaxis,ndUpper,ndLower,[0,0,0]+.8,[0,0,0]+.8,1,.75);
    hold on
end

% Plot in color
if ~BW
    plot(xaxis, hitMean, 'b')
    hold on
    hHit = jbfill(xaxis,hitUpper,hitLower,'b','b',1,.5);
    hold on
    plot(xaxis, missMean, 'r')
    hMiss = jbfill(xaxis,missUpper,missLower,'r','r',1,.5);
    hold on
    plot(xaxis, nodevmean, 'k', 'LineWidth', 2)
    hND = jbfill(xaxis,ndUpper,ndLower,'k','k',1,.5);
    hold on
end

% Set figure properties
legend([hHit, hMiss, hND], 'Detected Deviant', 'Undetected Deviant', 'No Deviant Occured')
ylim([-.4,1]);
xlim([0 plotlim*2]);
xlabel('Time (msecs)')
ylabel('Norm. Pup Size (arb. units)')
%title('Avg. pupil trace for detected, undetected, and no deviant trials')
set(gca, 'fontsize', 12)
set(gca, 'FontName', 'Helvetica')