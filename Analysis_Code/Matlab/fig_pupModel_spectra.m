% Plot pupil spectrum against model-predicted spectrum
% Figures 5 & 6 in JEMR paper
% 20180817 - Lauren Fink (lkfink@ucdavis)
% Janata Lab, UC Davis, Center for Mind & Brain 

% Also plot avg pupil time series to 8 loop epochs against model predicted
% time series 

params = attmap_eyes_globals;

% Load required data
LOAD_DATA = 1;
fpath = params.paths.matpath;
if LOAD_DATA
    fstub = 'pupdata.mat';
    load(fullfile(fpath, fstub))
    
    fstub = 'MPP_pup.mat';
    load(fullfile(fpath, fstub))
    
    fstub = 'stim_ampEnv.mat';
    load(fullfile(fpath, fstub))
end

minlen = 1776; % pup vs. model preds for each stim are off by a few samples. take minimum that all have
%-------------------------------------------------------------------------%
%% Load PRF for convolution with model output
Fs = 100;
motor = 0;
PRF = genPRF(Fs, motor);

%-------------------------------------------------------------------------%
%% Organize pupil and model data

stims = params.stimnames2;
nstims = length(stims);
psdTbl = table;
nr = 1;
for istim = 1:nstims
    currstim = stims{istim};
    
    % Create masks for pupil and model data
    stim_mask_rp = strcmp(currstim, rp.stim);
    stim_mask_pup = strcmp(currstim, pupdata.stimulus_id);
    
    % Avg. pupil data
    pup_mean = mean(shortenCell2Mat(pupdata.epoch_avg(stim_mask_pup)));
    
    % Save data to table for future use
    psdTbl.stim{nr,1} = currstim;
    psdTbl.pupMean{nr, 1} = pup_mean;
    ds = resample(pup_mean, 100, 500);
    ds = ds(1:minlen);
    psdTbl.pupDS{nr, 1} = ds;
    %winDs = ds .* hanning(length(ds));
    [~, psdTbl.power{nr, 1}, psdTbl.fVals{nr, 1}] = getFFT(ds, 100, 0);
    
    % Add model data to table
    rp_conv = conv(rp.modelTseries_extend{stim_mask_rp}, PRF, 'same');
    rp_conv = rp_conv(1:minlen);
    psdTbl.model{nr,1} = rp_conv;
    %winRp = rp_conv .* hanning(length(rp_conv));
    [~, psdTbl.model_power{nr,1}, psdTbl.model_fVals{nr,1}] = getFFT(rp_conv, 100, 0);
    
    % Add emp env data to table
    stimmask_env = strcmp(strcat(currstim, '.wav'), ampEnv.stim);
    env_conv = ampEnv.conv_env{stimmask_env}(1:minlen);
    psdTbl.env{nr,1} = env_conv;
    %winEnv = env_conv .* hanning(length(env_conv));
    [~, psdTbl.env_power{nr,1}, psdTbl.env_fVals{nr,1}] = getFFT(env_conv, 100, 0);
    
    
    nr = nr+1;
end % stim


%-------------------------------------------------------------------------%
%% Generate figure of pupil and model spectra
plot_log = 1;
lineWidth_pup = 1.5;
lineWidth_mod = 1.5;
fname = fullfile(params.paths.fig_path, 'pupMod_spectra_20181023.ps');
stims = params.stimnames2;
nstims = length(stims);


figure()
for istim = 1:nstims
    
    currstim = stims(istim);
    stimmask = strcmp(psdTbl.stim, currstim);
    
    % Highest req of interest
    lowestFreq = 0; 
    highestFreq = 2;
    
    % Plot pupil
    subplot(nstims, 1, istim)
    yyaxis left
    pup_pwr = psdTbl.power{stimmask};
    if plot_log
        plot(psdTbl.fVals{stimmask},log10(pup_pwr),'k','LineWidth',lineWidth_pup);
        ylabel('Pupil PSD (dB/Hz)');
        ylim([-9 -1])
    else
        plot(psdTbl.fVals{stimmask},pup_pwr,'k','LineWidth',lineWidth_pup);
        ylabel('Pupil PSD');
    end
    
    ax1 = gca; 
    ax1.XColor = 'k';
    ax1.YColor = 'k';
    hold on
    xlabel('Frequency (Hz)')
    xlim([lowestFreq highestFreq]);
    
    
    % Plot model prediction
    yyaxis right
    model_pwr = psdTbl.model_power{stimmask};
    if plot_log
        plot(psdTbl.model_fVals{stimmask}, log10(model_pwr), 'LineWidth', lineWidth_mod) %, 'Parent',ax2,'Color','r');
        ylabel('Model PSD (dB/Hz)')
        ylim([40 48])
    else
        plot(psdTbl.model_fVals{stimmask}, model_pwr, 'LineWidth', lineWidth_mod) %, 'Parent',ax2,'Color','r');
        ylabel('Model PSD')
    end

    
    % Get appropriate stim label for title
    plot_stim_ind = find(strcmp(params.plot_stimnames, currstim));
    plot_stim_lab = params.plot_stimnames{plot_stim_ind,2};
    titlestr = sprintf('%s', plot_stim_lab);
    title(titlestr)
    
    set(gca, 'fontsize', 12)
    set(gca, 'FontName', 'Helvetica')
end

print('-dpsc', '-fillpage', fname)

%-------------------------------------------------------------------------%
%% Generate figure of pupil and model time series 
fname = fullfile(params.paths.fig_path, 'pupModConv_20180827.eps');
lineWidth_pup = 1.5;
lineWidth_mod = 1.5;
figure()
set(gca, 'fontsize', 12)
set(gca, 'FontName', 'Helvetica')

stims = params.stimnames2;
nstims = length(stims);
for istim = 1:nstims
    
    % Scale xaxis
    fs = 100;
    secs = length(psdTbl.pupDS{istim})/fs;
    x = 1:(fs*secs);
    xaxis = x/fs*1000;
    xaxis = xaxis(1:minlen);
    
    % Plot pupil
    subplot(nstims,1, istim)
    yyaxis left
    pup = psdTbl.pupDS{istim}(1:minlen);
    plot(xaxis, pup, 'k', 'LineWidth', lineWidth_pup)
    ylabel('Recorded pupil size (z-score)')
    ylim([-.15 .15])
    xlabel('Time (msecs)')
    ax1 = gca;
    ax1.XColor = 'k';
    ax1.YColor = 'k';
    hold on 
    
    % Plot model
    yyaxis right
    y = psdTbl.model{istim}(1:minlen);
    y = (y - mean(y)) / std(y);
    plot(xaxis, y, 'Linewidth', lineWidth_mod)
    ylabel('Predicted pupil size (z-score)')
    ylim([-2.5 2.5])
    
    
    title(params.plot_stimnames{istim,2});
    set(gca, 'fontsize', 12)
    set(gca, 'FontName', 'Helvetica')
    
end

print('-dpsc', '-fillpage', fname)




%% Generate figure of pupil and model time series, with AMP ENV 
fname = fullfile(params.paths.fig_path, 'pupModEnvConv_20181023_leg.eps');
lineWidth_pup = 1.5;
lineWidth_mod = 1.5;
figure()
set(gca, 'fontsize', 12)
set(gca, 'FontName', 'Helvetica')

stims = params.stimnames2;
nstims = length(stims);
for istim = 1:nstims
    
    % Scale xaxis
    fs = 100;
    secs = length(psdTbl.pupDS{istim})/fs;
    x = 1:(fs*secs);
    xaxis = x/fs*1000;
    xaxis = xaxis(1:minlen);
    
    % Plot pupil
    subplot(nstims,1, istim)
    yyaxis left
    pup = psdTbl.pupDS{istim}(1:minlen);
    h1 = plot(xaxis, pup, 'k', 'LineWidth', lineWidth_pup)
    ylabel('Recorded pupil size (z-score)')
    ylim([-.15 .15])
    xlabel('Time (msecs)')
    ax1 = gca;
    ax1.XColor = 'k';
    ax1.YColor = 'k';
    hold on 
    
    % Plot model
    yyaxis right
    y = psdTbl.model{istim}(1:minlen);
    y = (y - mean(y)) / std(y);
    h2 = plot(xaxis, y, 'Linewidth', lineWidth_mod)
    ylabel('Predicted pupil size (z-score)')
    ylim([-2.5 2.5])
    
    % plot amp env
    hold on 
    currstim = psdTbl.stim{istim};
    y = psdTbl.env{istim}(1:minlen);
    y = (y - mean(y)) / std(y);
    h3 = plot(xaxis, y, '--', 'Linewidth', lineWidth_mod)
    ylabel('Predicted pupil size (z-score)')
    %ylim([-2.5 2.5])
   
    %legend([h2 h3], {'Oscillator Model Prediction', 'Amplitude Envelope Prediction'}, 'Location', 'NorthEastOutside')
    
    title(params.plot_stimnames{istim,2});
    set(gca, 'fontsize', 12)
    set(gca, 'FontName', 'Helvetica')
    
end

legend('Recorded pupil', 'Peak Reson Prediction', 'Amp Env Prediction')
print('-dpsc', '-fillpage', fname)








%% Generate figure of pupil and model spectra, with AMP ENV
plot_log = 1;
lineWidth_pup = 1.5;
lineWidth_mod = 1.5;
fname = fullfile(params.paths.fig_path, 'pupModEnv_spectra_20181025.ps');
stims = params.stimnames2;
nstims = length(stims);


figure()
for istim = 1:nstims
    
    currstim = stims(istim);
    stimmask = strcmp(psdTbl.stim, currstim);
    
    % Highest req of interest
    lowestFreq = 0; 
    highestFreq = 3;
    
    % Plot pupil
    subplot(nstims, 1, istim)
    yyaxis left
    pup_pwr = psdTbl.power{stimmask};
    if plot_log
        plot(psdTbl.fVals{stimmask},20*log10((pup_pwr/sum(pup_pwr))),'k','LineWidth',lineWidth_pup);
        ylabel('Pupil PSD (dB/Hz)');
        ylim([-150 0])
    else
        plot(psdTbl.fVals{stimmask},pup_pwr,'k','LineWidth',lineWidth_pup);
        ylabel('Pupil PSD');
    end
    
    ax1 = gca; 
    ax1.XColor = 'k';
    ax1.YColor = 'k';
    hold on
    xlabel('Frequency (Hz)')
    xlim([lowestFreq highestFreq]);
    
    
    % Plot model prediction
    yyaxis right
    model_pwr = psdTbl.model_power{stimmask};
    if plot_log
        plot(psdTbl.model_fVals{stimmask}, 20*log10((model_pwr/sum(model_pwr))), 'LineWidth', lineWidth_mod) %, 'Parent',ax2,'Color','r');
        ylabel('Model PSD (dBFS)')
        ylim([-150 0])
    else
        plot(psdTbl.model_fVals{stimmask}, model_pwr, 'LineWidth', lineWidth_mod) %, 'Parent',ax2,'Color','r');
        ylabel('Model PSD')
    end

    % Plot env prediction
    hold on 
    amp_pwr = psdTbl.env_power{stimmask};
    if plot_log
        plot(psdTbl.env_fVals{stimmask_env}, 20*log10((amp_pwr/sum(amp_pwr))), 'LineWidth', lineWidth_mod) %, 'Parent',ax2,'Color','r');
        ylabel('Model PSD (dBFS)')
        ylim([-150 0])
    else
        plot(psdTbl.env_fVals{stimmask_env}, amp_pwr, 'LineWidth', lineWidth_mod) %, 'Parent',ax2,'Color','r');
        ylabel('Model PSD')
    end
    
    % Get appropriate stim label for title
    plot_stim_ind = find(strcmp(params.plot_stimnames, currstim));
    plot_stim_lab = params.plot_stimnames{plot_stim_ind,2};
    titlestr = sprintf('%s', plot_stim_lab);
    title(titlestr)
    
    set(gca, 'fontsize', 12)
    set(gca, 'FontName', 'Helvetica')
end

legend('Recorded pupil', 'Peak Reson Prediction', 'Amp Env Prediction')
print('-dpsc', '-fillpage', fname)
