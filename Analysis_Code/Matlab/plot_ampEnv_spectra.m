% Plot spectra of amplitude envelopes for each stim

% Lauren Fink (lkfink@ucdavis.edu)
% Janata Lab, UC Davis Center for Mind & Brain

params = attmap_eyes_globals;
LOAD_ENV_DATA = 0;

if LOAD_ENV_DATA
    fpath = params.paths.matpath;
    fname = fullfile(fpath,'stim_ampEnv.mat');
    load(fname);
    
    % also load mod_env_peaks
    
end

for i = 1:length(ampEnv.stim)
    [~, ampEnv.power{i,1}, ampEnv.fVals{i,1}] = getFFT(ampEnv.ampEnv_downsampled_u{i}, 100, 0);
    [~, ampEnv.power_conv{i,1}, ampEnv.fVals_conv{i,1}] = getFFT(ampEnv.conv_env{i}, 100, 0);
end
%% Make plot
% Freqs of interest
highestFreq = 10; % in line with BTB
lw = 1.5;
conv = 1;

figure()
stims = params.stimnames2;
for istim = 1:length(stims)
    currstim = stims(istim);
    currstim_a = strcat(currstim, '.wav');
    stimmask = strcmp(currstim_a, ampEnv.stim);
    stimmask_rp = strcmp(currstim, rp.stim);
    freqmask = ampEnv.fVals{stimmask} < highestFreq;
    
    subplot(5,1,istim)
    yyaxis left
    
    plot(ampEnv.fVals{stimmask}(freqmask), ampEnv.power{stimmask}(freqmask), 'k', 'LineWidth', lw);
    ylim([0 .000005])
    ax1 = gca;
    ax1.XColor = 'k';
    ax1.YColor = 'k';
    
    hold on
    xlabel('Freq. (Hz)')
    ylabel('PSD')
    xlim([0 highestFreq])
    
    ylabel('Amp envelope')
    
    yyaxis right
    
    peaks = rp.peakFreqs{stimmask_rp};
    for ipeak = 1:length(peaks)
        plot([peaks(ipeak) peaks(ipeak)], [0 rp.peakHeight{stimmask_rp}(ipeak)], ':r', 'LineWidth', 2)
        hold on
        ylim([0 .8])
    end
    ylabel('Model')
    
    
    % Get appropriate stim label for title
    plot_stim_ind = find(strcmp(params.plot_stimnames, currstim));
    plot_stim_lab = params.plot_stimnames{plot_stim_ind,2};
    titlestr = sprintf('%s', plot_stim_lab);
    title(titlestr)
    
    set(gca, 'fontsize', 12)
    set(gca, 'FontName', 'Helvetica')
    
    %suptitle('Spectral peaks from amplitude envelope (black) vs. linear oscillator model (red)')
    
    
end % stim

fname = fullfile(params.paths.fig_path, 'ampVmodel_spectralPeaks.eps');
print('-dpsc', '-fillpage', fname)
