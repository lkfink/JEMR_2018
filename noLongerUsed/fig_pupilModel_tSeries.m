% Plot pupil time series against model-predicted time series
% Figure ? in JEMR paper
% LF - 20180817

params = attmap_eyes_globals;

% Load required data
LOAD_DATA = 0;
fpath = params.paths.matpath;
if LOAD_DATA
    fstub = 'pupdata.mat';
    load(fullfile(fpath, fstub))
    
    fstub = 'MPP_pup.mat';
    load(fullfile(fpath, fstub))
end

%-------------------------------------------------------------------------%

%% Organize pupil and model data

stims = params.stimnames2;

nstims = length(stims);
sim_data = cell(nstims, 3);
for istim = 1:nstims
    currstim = stims{istim};
    
    % Create masks for pupil and model data
    stim_mask_rp = strcmp(currstim, rp.stim);
    stim_mask_pup = strcmp(currstim, pupdata.stimulus_id);
    
    % Avg. pupil data
    pup_mean = mean(shortenCell2Mat(pupdata.epoch_avg(stim_mask_pup)));
    
    % Save data to matrix for future use
    sim_data{istim, 1} = pup_mean;
    sim_data{istim, 2} = resample(pup_mean, 100, 500);
    sim_data{istim, 3} = rp.modelTseries_extend{stim_mask_rp};
    
end % stim

% get all downsampled and model output cells to same length
sizes = cellfun(@size, sim_data(:,2:3), 'UniformOutput', 0);
sizes = cell2mat(sizes);
lengths = unique(sizes);
mask = logical(lengths > 1);
lengths = lengths(mask);
minlen = min(lengths);
for irow = 1:length(sim_data)
    sim_data{irow, 2} = sim_data{irow, 2}(1:minlen);
    sim_data{irow, 3} = sim_data{irow, 3}(1:minlen);
end


%-------------------------------------------------------------------------%

%% Load PRF for convolution with model output

% Hooks & Levelt PRF with McCloy adaptation
% 512 for no button press
Fs = 100;
tscale = 0:1000/Fs:2500; %should be specified in ms
tmax = 512; % latency of response maximum
n = 10.1; % shape parameter of Erlang gamma dist. (proposed to be number of
% signaling steps in neural pathway transmitting attentional pulse to pupil
PRF = tscale.^n .* exp(1).^(-10.1*tscale/930); % expect maximal resp at 930ms
PRF(end) = 0;

%-------------------------------------------------------------------------%

%% Generate Figure 

figure()
set(gca, 'fontsize', 12)
set(gca, 'FontName', 'Helvetica')

nstims = length(sim_data);
for istim = 1:length(sim_data)
    
    % Scale xaxis
    fs = 100;
    secs = length(sim_data{istim, 3})/fs;
    x = 1:(fs*secs);
    xaxis = x/fs*1000;
    
    % Plot pupil
    subplot(nstims,1, istim)
    yyaxis left
    plot(xaxis, sim_data{istim, 2}, 'k', 'LineWidth', 2)
    ylabel('Recorded pupil size (z-score)')
    ylim([-.2 .2])
    xlabel('Time (msecs)')
    ax1 = gca;
    ax1.XColor = 'k';
    ax1.YColor = 'k';
    hold on 
    
    % Plot model
    yyaxis right
    y = conv(sim_data{istim, 3},PRF, 'same');
    y = (y - mean(y)) / std(y);
    plot(xaxis, y, 'Linewidth', 2)
    ylabel('Predicted pupil size (z-score)')
    ylim([-2.5 2.5])
    
    
    title(params.plot_stimnames{istim,2});
    set(gca, 'fontsize', 12)
    set(gca, 'FontName', 'Helvetica')
    
    params.plot_stimnames{istim,1}
    params.plot_stimnames{istim,2}
end



fname = fullfile(params.paths.fig_path, 'pupModConv_20180817.eps');
%print('-dpsc', '-fillpage', fname)