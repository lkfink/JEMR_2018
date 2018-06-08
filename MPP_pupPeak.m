% MPP - pup peak freq analysis
% 20171206 - LF started
% 20180139 - LF edited

% load pupdata, looptable 2, rp analyses

params = attmap_eyes_globals;
fpath = params.paths.matpath;

fstub = 'pupdata.mat';
load(fullfile(fpath, fstub))

fstub = 'loopTable2.mat';
load(fullfile(fpath, fstub))

fstub = 'attmap_v1p2_stim_rp_analysis.mat';
load(fullfile(fpath, fstub))


%% Add FFTs to pupdata table

subs = unique(pupdata.subject_id);
stims = unique(pupdata.stimulus_id);
j = 1;
fs = params.eyetracker.Fs;
clear epochdata
clear epochmean


CREATE_FIG = 1;
if CREATE_FIG
    figure(1)
    des_sub = 'sse';
    des_stim = 'prC_74_3i_1v_107bpm';
end

for isub = 1:length(subs)
    currsub = subs(isub);
    submask = strcmp(pupdata.subject_id, currsub);
    
    for istim = 1:length(stims)
        currstim = stims(istim);
        stimmask = strcmp(pupdata.stimulus_id, currstim);
        
        pupdata_substim = pupdata.pupNorm(submask & stimmask);
        if isempty(pupdata_substim)
            continue
        else
            % Break data out of cell
            pupdata_substim = pupdata.pupNorm{submask & stimmask};
            
            
            % Plot data for full run, if desired
            if CREATE_FIG
                if strcmp(currsub, des_sub) % only want to make this plot for one sub, one stim
                    if strcmp(currstim, des_stim)
                        figure(1)
                        subplot(2,2,1)
                        
                        secs = length(pupdata_substim)/fs;
                        x = 1:(fs*secs);
                        xaxis = x/fs*1000;
                        
                        plot(xaxis, pupdata_substim, 'k', 'LineWidth', 2)
                        ylabel('Norm. pup. (arb. units)')
                        xlabel('Time (msecs)')
                        title('Pupil signal over the course of one run')
                        % TODO scale xaxis axes
                    else
                    end
                else
                end
            end
            
            % Create masks for looptable
            submask_loop = strcmp(currsub, loopTable2.subject_id);
            stimmask_loop = strcmp(currstim, loopTable2.stimulus_id);
            % Take 8 loop epochs
            nloops = max(loopTable2.loop_num(submask_loop & stimmask_loop));
            
            % Epoch the data
            if isempty(nloops)
                continue
            else
                
                substim_loops = loopTable2.loop_start(submask_loop & stimmask_loop);
                epochlen = 8;
                nepochs = floor(nloops/epochlen);
                for iloop = 1:nepochs
                    start = substim_loops(iloop);
                    stop = substim_loops(iloop+epochlen)-1;
                    epochdata{j,1} = pupdata_substim(start:stop);
                    lens(j) = length(epochdata{j,1});
                    j = j+1;
                end
                
                % find min length & fix trim all data
                minlen = min(lens);
                for idata = 1:numel(epochdata)
                    epochdata{idata} = epochdata{idata}(1:minlen);
                end
                epochdata = cell2mat(epochdata);
                epochmean = mean(epochdata);
                
                % Plot epoched data, if desired
                if CREATE_FIG
                    if strcmp(currsub, des_sub)
                        if strcmp(currstim, des_stim)
                            %                             figure(1)
                            %                             subplot(2,2,1)
                            %                             % Add nloop epcohs to previous sublot as dotted
                            %                             % vertical lines
                            %                             avg_ep_len = length(pupdata_substim) / nepochs;
                            %                             y1 = get(gca, 'YLim');
                            %                             for iep = 1:nepochs
                            %                                 xind = iep + avg_ep_len;
                            %                                 plot([xind xind], y1, ':k', 'LineWidth', 1)
                            %                                 hold on
                            %                             end
                            
                            
                            % Create subplot showing epoched data
                            figure(1)
                            subplot(2,2,3)
                            
                            secs = length(epochmean)/fs;
                            x = 1:(fs*secs);
                            xaxis = x/fs*1000;
                            plot(xaxis, epochmean, 'k', 'LineWidth', 2)
                            
                            
                            ylabel('Norm. pup. (arb. units)')
                            xlabel('Time (msecs)')
                            title('Avg. pupil signal of 8-loop epochs')
                        else
                        end
                    else
                    end
                end
                
                
                
                % Perform fft on epoched data
                % Plot if desired
                if CREATE_FIG
                    if strcmp(currsub, des_sub)
                        if strcmp(currstim, des_stim)
                            toplot = 1;
                            figure(1)
                            subplot(2,2,4)
                            FFTresult = getFFT(epochmean, fs, toplot);
                        end
                    end
                end
                toplot = 0;
                FFTresult = getFFT(epochmean, fs, toplot);
                
                
                % save to table for future use
                pupdata.epoch_avg{submask & stimmask} = epochmean;
                pupdata.epoched_FFT{submask & stimmask} = FFTresult;
                
                
                
                % Also take fft of full signal
                % go from first loop until start of last loop
                start = substim_loops(1);
                stop = substim_loops(end);
                pupdata_full = pupdata_substim(start:stop);
                
                % Plot fft of full sig if desired
                if CREATE_FIG
                    if strcmp(currsub, 'sa')
                        if strcmp(currstim, 'prC_74_3i_1v_107bpm')
                            toplot = 1;
                            figure(1)
                            subplot(2,2,2)
                            FFT_full = getFFT(pupdata_full, fs, toplot);
                        end
                    end
                end
                toplot = 0;
                FFT_full = getFFT(pupdata_full, fs, toplot);
                
                % Save to table
                pupdata.full_FFT{submask & stimmask} = FFT_full;
                
                clear epochdata
                clear epochmean
                j = 1;
            end % is empty nloops (this subs got thrown out for some reason in creation of looptable)
        end % if isempty
    end % stim
    
    
end



%% Save pupdata
outfname = fullfile(fpath,'pupdata');
fprintf('Saving mat file: %s\n', outfname)
save(outfname,'pupdata', '-v7.3')
fprintf('Matfile saved')


%% load model data
model = load(params.paths.rp_analysis);
model = model.an;
resondata = model{1, 3}.results.data;
stimnames = model{1, 3}.results.data{1,1};
%vars = model{1, 3}.results.vars;
rp = table;
nr = 1;

%%
rp_varmask = strcmp(model{1,1}.results.vars, 'rp');
rpdata = model{1,1}.results.data(rp_varmask);
rpdata = rpdata{:};
for irp = 1:length(rpdata)
    thisStim_rp = load(rpdata{irp});
    
    
    peakFreq_varMask = strcmp(thisStim_rp.rp.data{1, 19}.vars, 'peakFreq');
    thisStim_peaks = thisStim_rp.rp.data{1, 19}.data(peakFreq_varMask);
    thisStim_peaks = thisStim_peaks{:};
    
    peakFreqNorm_varMask = strcmp(thisStim_rp.rp.data{1, 19}.vars, 'normPeakFreq');
    thisStim_peaksNorm = thisStim_rp.rp.data{1, 19}.data(peakFreqNorm_varMask);
    thisStim_peaksNorm = thisStim_peaksNorm{:};
    
    peakRatio_varMask = strcmp(thisStim_rp.rp.data{1, 19}.vars, 'approxRatio');
    thisStim_ratio = thisStim_rp.rp.data{1, 19}.data(peakRatio_varMask);
    thisStim_ratio = thisStim_ratio{:};
    
    width_varMask = strcmp(thisStim_rp.rp.data{1, 19}.vars, 'width');
    thisStim_width = thisStim_rp.rp.data{1, 19}.data(width_varMask);
    thisStim_width = thisStim_width{:};
    
    height_varMask = strcmp(thisStim_rp.rp.data{1, 19}.vars, 'peakHeight');
    thisStim_height = thisStim_rp.rp.data{1, 19}.data(height_varMask);
    thisStim_height = thisStim_height{:};
    
    mppBand_mask = strcmp(thisStim_rp.rp.vars, 'mppByBand');
    thisStim_mppBand = thisStim_rp.rp.data(mppBand_mask);
    thisStim_mppBand = thisStim_mppBand{:};
    
    meanResonEnergy_mask = strcmp(thisStim_rp.rp.vars, 'meanResonatorEnergy');
    thisStim_meanResonatorEnergy = thisStim_rp.rp.data(meanResonEnergy_mask);
    thisStim_meanResonatorEnergy = thisStim_meanResonatorEnergy{:};
    
    stdResonEnergy_mask = strcmp(thisStim_rp.rp.vars, 'stdResonatorEnergy');
    thisStim_stdResonatorEnergy = thisStim_rp.rp.data(stdResonEnergy_mask);
    thisStim_stdResonatorEnergy = thisStim_stdResonatorEnergy{:};
    
    resonatorFreqs_mask = strcmp(thisStim_rp.rp.vars, 'resonatorFreqs');
    thisStim_resonatorFreqs = thisStim_rp.rp.data(resonatorFreqs_mask);
    thisStim_resonatorFreqs = thisStim_resonatorFreqs{:};
    
    
    rp.file{nr,1} = rpdata{irp};
    rp.peakFreqs{nr,1} = thisStim_peaks;
    rp.peakFreqsNorm{nr,1} = thisStim_peaksNorm;
    rp.ratios{nr,1} = thisStim_ratio;
    rp.peakHeight{nr,1} = thisStim_height;
    rp.width{nr,1} = thisStim_width;
    rp.mppBands{nr,1} = thisStim_mppBand;
    rp.meanResonEnergy{nr,1} = thisStim_meanResonatorEnergy;
    rp.stdResonEnergy{nr,1} = thisStim_stdResonatorEnergy;
    rp.resonatorFreqs{nr,1} = thisStim_resonatorFreqs;
    rp.meanSig_peakTseries{nr,1} = resondata{2}{irp};
    
    %
    %     % Put peaks in impulse train of zeros
    %     train = zeros(numel(rp.meanSig_peakTseries{nr,1}),1);
    %     train(rp.peakIdxs{nr,1}) = rp.peakHeights{nr,1};
    %
    %     %add zeros to the end of this and replicate 3 times
    %     %     n = 33; % number of trials without deviants
    %     %     train(end+27) = 0;
    %     %     train = repmat(train,n,1);
    %
    %     rp.train{nr,1} = train;
    
    % TODO: CHECK: should trains only be from 0:1? right now neg
    % values (consider scaling / normalizing)
    
    %     % Convolve PRF with peak idxs and heights
    %     rp.prediction_train{nr,1} = conv(rp.train{nr,1}, PRF, 'valid');
    %     rp.prediction_series{nr,1} = conv(rp.meanSig_peakTseries{nr,1}, PRF, 'valid');
    %     %[rp.FFT{nr,1}, rp.power{nr,1}, rp.fVals{nr,1}, rp.pks{nr,1}, rp.locs{nr,1}] = getFFT(rp.prediction{nr,1}, 100, 0);
    
    nr = nr+1;
end % one sitm rp


rp.stim{1} = 'prA_4_3i_1v_107bpm';
rp.stim{2} = 'prA_74_3i_1v_107bpm';
rp.stim{3} = 'prC_54_3i_1v_107bpm';
rp.stim{4} = 'prC_74_3i_1v_107bpm';
rp.stim{5} = 'prC_124_3i_1v_107bpm';

%% Add pupil mean PSD for each stim to rp table

stims = unique(pupdata.stimulus_id);
for istim = 1:length(stims)
    currstim = stims(istim);
    stimmask = strcmp(pupdata.stimulus_id, currstim);
    
    % Get data in working order
    FFTdata = pupdata.epoched_FFT(stimmask);
    FFTdata = removeEmptyCell2Mat(FFTdata);
    
    % Take mean FFT
    fs = params.eyetracker.Fs;
    [outFFT,power,fVals] = meanFFT(FFTdata, fs);
    
    % Add this to table with model predictions
    stimmask_rp = strcmp(currstim, rp.stim);
    rp.meanFFT_epoch{stimmask_rp} = outFFT;
    rp.power_epoch{stimmask_rp} = power;
    rp.fVals_epoch{stimmask_rp} = fVals;
    
    % Do same thing for full fft
    FFTdata = pupdata.full_FFT(stimmask);
    FFTdata = removeEmptyCell2Mat(FFTdata);
    
    % Take mean FFT
    [outFFT,power,fVals] = meanFFT(FFTdata, fs);
    
    % Add this to table with model predictions
    rp.meanFFT_full{stimmask_rp} = outFFT;
    rp.power_full{stimmask_rp} = power;
    rp.fVals_full{stimmask_rp} = fVals;
    
    
end % stim


%% Extend meanPeakTseries and take FFT

for irow = 1:length(rp.file)
    
    % Replicate Tseries 8 times
    extended_Tseries = repmat(rp.meanSig_peakTseries{irow},[1,8]);
    
    % Take FFT
    [fft_model, power, fvals] = getFFT(extended_Tseries, 100, 0);
    
    % Save to rp table
    rp.modelTseries_extend{irow} = extended_Tseries;
    rp.modelTseries_FFT{irow} = fft_model;
    rp.modelTseries_power{irow} = power;
    rp.modelTseries_fVals{irow} = fvals;
end %row

%%  save this table
outfname = fullfile(fpath,'MPP_pup');
fprintf('Saving mat file: %s\n', outfname)
save(outfname,'rp', '-v7.3')
fprintf('Matfile saved')


%% Plot avg pupil PSD for each stim against model predicted
% Probably fig 4 in JEMR paper
% TODO: break this out into its own script
fname = fullfile(params.paths.fig_path, 'pupMod_spectra.ps');
stims = params.stimnames2;
nstims = length(stims);
figure()
for istim = 1:nstims
    
    currstim = stims(istim);
    stimmask = strcmp(rp.stim, currstim);
    
    % Highest req of interest
    lowestFreq = .25;
    highestFreq = 2;
    
    % Plot pupil
    subplot(nstims, 1, istim)
    yyaxis left
    %     plot(rp.fVals_epoch{istim},log10(rp.power_epoch{istim}),'k','LineWidth',2);
    plot(rp.fVals_epoch{stimmask},rp.power_epoch{stimmask},'k','LineWidth',2);
    %plot(rp.fVals_full{istim},rp.power_full{istim},'k','LineWidth',2);
    ax1 = gca; % current axes
    ax1.XColor = 'k';
    ax1.YColor = 'k';
    hold on
    xlabel('Frequency (Hz)')
    ylabel('Pupil PSD');
    xlim([lowestFreq highestFreq]);
    %ylim([-10 log10(30)])
    ylim([0 30])
    %stimstr = strcat(rp.stim{istim}, '.wav');
    plot_stim_ind = find(strcmp(params.plot_stimnames, rp.stim{stimmask}));
    plot_stim_lab = params.plot_stimnames{plot_stim_ind,2};
    titlestr = sprintf('%s', plot_stim_lab);
    set(gca, 'fontsize', 12)
    set(gca, 'FontName', 'Helvetica')
    
    % Plot model prediction
    yyaxis right
    plot(rp.modelTseries_fVals{stimmask}, rp.modelTseries_power{stimmask}, 'LineWidth', 2) %, 'Parent',ax2,'Color','r');
    
    %     plot(rp.resonatorFreqs{istim}, log10(rp.meanResonEnergy{istim}), 'LineWidth', 2) %, 'Parent',ax2,'Color','r');
    %     plot(rp.resonatorFreqs{istim}, rp.meanResonEnergy{istim}, 'LineWidth', 2) %, 'Parent',ax2,'Color','r');
    ylabel('Model PSD')
    ylim([0 .03])
    %plot(rp.stdResonEnergy{istim});
    
    title(titlestr)
    
    set(gca, 'fontsize', 12)
    set(gca, 'FontName', 'Helvetica')
end

print('-dpsc', '-fillpage', fname)
close all

%% Look at one sub's pup response to each of the stims vs. model
figure()
subplot(511)
plot2xy(rp.modelTseries_extend{1}, pupdata.epoch_avg{1})

subplot(512)
plot2xy(rp.modelTseries_extend{2}, pupdata.epoch_avg{2})

subplot(513)
plot2xy(rp.modelTseries_extend{3}, pupdata.epoch_avg{3})

subplot(514)
plot2xy(rp.modelTseries_extend{4}, pupdata.epoch_avg{4})

subplot(515)
plot2xy(rp.modelTseries_extend{5}, pupdata.epoch_avg{5})


%% Plot avg stim pup vs. model

figure()
stims = unique(rp.stim);
nstims = length(stims);
sim_data = cell(nstims, 3);
for istim = 1:nstims
    currstim = stims{istim};
    
    % Create masks for pupil and model data
    stim_mask_rp = strcmp(currstim, rp.stim);
    stim_mask_pup = strcmp(currstim, pupdata.stimulus_id);
    
    % Avg. pupil data
    pup_mean = mean(shortenCell2Mat(pupdata.epoch_avg(stim_mask_pup)));
    
%     % Plot pupil avg. vs. model prediction
%     subplot(nstims, 1, istim);
%     h = plot2xy(rp.modelTseries_extend{stim_mask_rp}, pup_mean);
%     
%     stimstr = strcat(currstim, '.wav');
%     plot_stim_ind = find(strcmp(params.plot_stimnames, stimstr));
%     plot_stim_lab = params.plot_stimnames{plot_stim_ind,2};
%     title(plot_stim_lab)
    
    % Save data to mat for future use
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


%% Make cleaner version of above plot
% Likely JEMR fig 5
% TODO: break out

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
    plot(xaxis, sim_data{istim, 2}, 'LineWidth', 2)
    ylabel('Pup. size (a.u.)')
    ylim([-.2 .2])
    xlabel('Time (msecs)')
    
    % Plot model
    yyaxis right
    plot(xaxis, sim_data{istim, 3})
    ylabel('Mean reson output')
    
    
    
    title(params.plot_stimnames{istim,2});
    set(gca, 'fontsize', 12)
    set(gca, 'FontName', 'Helvetica')
    
end



fname = fullfile(params.paths.fig_path, 'pupModTseries.ps');
print('-dpsc', '-fillpage', fname)

%% Statistics for real pup vs. model, each stim
pup_pup_dist_dtw = getSimilarity(sim_data(:,2), sim_data(:,2), 'dtw');
pup_pup_dist_corr = getSimilarity(sim_data(:,2), sim_data(:,2), 'corrcoef');

mod_mod_dist_dtw = getSimilarity(sim_data(:,3), sim_data(:,3), 'dtw');
mod_mod_dist_corr = getSimilarity(sim_data(:,3), sim_data(:,3), 'corrcoef');

[pup_mod_dist_corr, corr_p] = corr(pup_pup_dist_corr, mod_mod_dist_corr, 'tail', 'right');
[pup_mod_dist_dtw, dtw_p] = corr(pup_pup_dist_dtw, mod_mod_dist_dtw, 'tail', 'right');

%% Plot pupil and model similarity matrices
figure()
subplot(3,1,1)
colormap('gray')
imagesc(pup_pup_dist_corr)
colorbar
title('Pupil similarity for each stim')
set(gca,'xtick',[1:5],'xticklabel',params.plot_stimnames(:,2))
set(gca,'ytick',[1:5],'yticklabel',params.plot_stimnames(:,2))

subplot(3,1,2)
imagesc(mod_mod_dist_corr)
colorbar
title('Model similarity for each stim')
set(gca,'xtick',[1:5],'xticklabel',params.plot_stimnames(:,2))
set(gca,'ytick',[1:5],'yticklabel',params.plot_stimnames(:,2))


subplot(3,1,3)
colormap('gray')
imagesc(pup_mod_dist_corr)
colorbar
title('Correlation between pupil and model similarity matrices')
set(gca,'xtick',[1:5],'xticklabel',params.plot_stimnames(:,2))
set(gca,'ytick',[1:5],'yticklabel',params.plot_stimnames(:,2))

suptitle('Similarity assessed through Pearson correlation')

% Plot pupil and model disimilarity matrices
figure()
subplot(3,1,1)
colormap('gray')
imagesc(pup_pup_dist_dtw)
colorbar
title('Pupil dissimilarity for each stim')
set(gca,'xtick',[1:5],'xticklabel',params.plot_stimnames(:,2))
set(gca,'ytick',[1:5],'yticklabel',params.plot_stimnames(:,2))


subplot(3,1,2)
imagesc(mod_mod_dist_dtw)
colorbar
title('Model dissimilarity for each stim')
set(gca,'xtick',[1:5],'xticklabel',params.plot_stimnames(:,2))
set(gca,'ytick',[1:5],'yticklabel',params.plot_stimnames(:,2))


subplot(3,1,3)
colormap('gray')
imagesc(pup_mod_dist_dtw)
colorbar
title('Correlation between pupil and model dissimilarity matrices')
set(gca,'xtick',[1:5],'xticklabel',params.plot_stimnames(:,2))
set(gca,'ytick',[1:5],'yticklabel',params.plot_stimnames(:,2))

suptitle('Dissimilarity assessed through Dynamic Time Warping (Euclidean distance)')



%% Statistics for real (500Hz) vs. predicted data for each stim


%%
figure()
subplot(2,1,1)
colormap('gray')
imagesc(pup_pup_dist)
colorbar
title('Pupil disimilarity for each stim')

subplot(2,1,2)
colormap('gray')
imagesc(mod_mod_dist)
colorbar
title('Model disimilarity for each stim')

% C = xcorr2(pup_pup_dist, mod_mod_dist);
% figure()
% imagesc(C)
% colorbar
% title('Correlations between Pupil and Model RSMs')

figure()
colormap('gray')
imagesc(pup_mod_dist)
colorbar
title('disimilarity between pupil and model for each stim')

test = pup_pup_dist - pup_mod_dist;
figure()
colormap('gray')
imagesc(test)
colorbar
title('disimilarity between pupil - model for each stim')
%%
% downsample and shorten pupil data to same length as model to compute
% standard correlations




% TODO -
D = pdist(sim_data, 'correlation');
Dmat = squareform(D);

%% DELETE EVERYTHING BELOW HERE
%-------------------------------------------------------------------------%
%-------------------------------------------------------------------------%
%-------------------------------------------------------------------------%
%-------------------------------------------------------------------------%
%-------------------------------------------------------------------------%


% 20180130 - this currently not working because can't find
% plot_rhythmProfile.. why? potentially diff file paths when using 2017a?

% Set params for later plots
%globals = attmap_MSM_globals;
%params2.ipem = globals.stimIPEMParams;
%params2.ipem.glob.force_recalc = {};
%params2.ipem.glob.outputType = 'data';
params2.freqLegend = 1;
% an{na}.params.plot.legendParams.minHz = 1;
% an{na}.params.plot.legendParams.maxHz = 5;
% an{na}.params.plot.legendParams.numKeys = 8;
params2.overlayType = 'impulse';
params2.colorbar = 1;
params2.savePlot = 0;
%params2.savePath = globals.paths.stim_rp_plotPath;
params2.color = 1;
params2.timeTickRes = 5.0;
params2.numResonTicks = 6;
% an{na}.params.plot.fig.rectPlotWidth = 0.48;
% an{na}.params.plot.peakFinder = an{1}.params.rp.resonatorBank.peakFinder;
params2.perform = {'resonEnergy', 'meanEnergy', 'stdEnergy', 'findPeaks'};

fname = fullfile(params.paths.fig_path, 'avgPSDs_attmap_eyes_20180130.ps');
for istim = 1:length(rp.stim)
    
    % print model prediction
    titlestr = sprintf('Stimulus: %s', rp.stim{istim});
    params2.fig.title = titlestr;
    h = plot_rhythmProfile(rp.file{istim},params2);
    print('-dpsc','-append', fname)
    close all
    
    % print pupil
    figure()
    %subplot(2,1,1)
    plot(rp.fVals_epoch{istim},rp.power_epoch{istim},'k','LineWidth',3);
    hold on
    xlabel('Frequency (Hz)')
    ylabel('PSD');
    xlim([.1 3]);
    ylim([0 30])
    titlestr = sprintf('Avg. pupil PSD from epoched data for stim: %s', rp.stim{istim});
    title(titlestr)
    
    % Add BTB peak freqs to fig
    y1 = get(gca, 'ylim');
    modelPeaks = rp.peakFreqsNorm{istim};
    mask = modelPeaks < 3;
    modelPeaks = modelPeaks(mask);
    modelWidths = rp.width{istim};
    modelWidths = modelWidths(mask);
    % find peak corresponding to beat freq
    peakRatios = rp.ratios{istim};
    beatmask = strcmp(peakRatios, '1');
    beatFreq = modelPeaks(beatmask);
    beatWidth = modelWidths(beatmask);
    plot([beatFreq beatFreq], y1, '-r','LineWidth',2);
    
    % add width to beat freq (eventually do this with something like
    % jbfill?
    plot([beatFreq+beatWidth beatFreq+beatWidth], y1, ':k','LineWidth',2);
    plot([beatFreq-beatWidth beatFreq-beatWidth], y1, ':k','LineWidth',2);
    
    %plot([modelPeaks(1) modelPeaks(1)], y1, ':r','LineWidth',2);
    % Legend
    %legend('Pupil PSD', 'BTB beat freq.', 'BTB peak freqs.')
    legend('Pupil PSD', 'BTB peak freqs.', 'BTB peak freq. width')
    
    
    for ipeak = 1:length(modelPeaks)
        currpeak = modelPeaks(ipeak);
        currwidth = modelWidths(ipeak);
        plot([currpeak currpeak], y1, '-r','LineWidth',2);
        plot([currpeak+currwidth currpeak+currwidth], y1, ':k','LineWidth',2);
        plot([currpeak-currwidth currpeak-currwidth], y1, ':k','LineWidth',2);
    end
    
    
    
    
    %     subplot(2,1,2)
    %     %plot(rp.fVals_full{istim},rp.power_full{istim},'k','LineWidth',3, 'Linesmoothing', 'on');
    %     plot(rp.fVals_full100{istim},rp.power_full100{istim},'k','LineWidth',3);
    %     hold on
    %     xlabel('Frequency (Hz)')
    %     ylabel('PSD');
    %     xlim([.1 3]);
    %     ylim([0 150])
    %     titlestr = sprintf('Avg. pupil PSD from full run data for stim: %s', rp.stim{istim});
    %     title(titlestr)
    %
    %     % Add BTB peak freqs to fig
    %     y1 = get(gca, 'ylim');
    %     modelPeaks = rp.peakFreqs{istim};
    %     % find peak corresponding to beat freq
    %     peakRatios = rp.ratios{istim};
    %     beatmask = strcmp(peakRatios, '1');
    %     beatFreq = modelPeaks(beatmask);
    %     plot([beatFreq beatFreq], y1, '*-r','LineWidth',2);
    %     %plot([modelPeaks(1) modelPeaks(1)], y1, ':r','LineWidth',2);
    %
    %     for ipeak = 1:length(modelPeaks)
    %         currpeak = modelPeaks(ipeak);
    %         plot([currpeak currpeak], y1, ':r','LineWidth',2);
    %     end
    %
    %     % Legend
    %     legend('Pupil PSD', 'BTB beat freq.', 'BTB peak freqs.')
    
    
    % [left bottom width height]
    set(gcf, 'PaperPositionMode', 'manual');
    set(gcf, 'PaperUnits', 'inches');
    set(gcf, 'PaperPosition', [.2 7.5 8 2]);
    
    print('-dpsc','-append', fname)
    close all
    
end
