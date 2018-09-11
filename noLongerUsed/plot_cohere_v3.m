% Plot coherence results
% LF started 20180227

params = attmap_eyes_globals;
fpath = params.paths.matpath;
LOAD_DATA = 1;
LOAD_FFT = 1;

if LOAD_DATA
    % Load model data
    fstub = 'MPP_pup.mat'; % the mat is called rp
    sprintf('Loading %s', fstub)
    load(fullfile(fpath, fstub))
    fprintf('Finished loading: %s', fstub)
    
    % Load coherence data
    fstub = 'pup_mod_cohere.mat';
    sprintf('Loading %s', fstub)
    load(fullfile(fpath, fstub))
    fprintf('Finished loading: %s', fstub)
    
    fstub = 'null_cpsds.mat';
    sprintf('Loading %s', fstub)
    load(fullfile(fpath, fstub))
    fprintf('Finished loading: %s', fstub)
end

fname = fullfile(params.paths.fig_path, 'singleSub_pupMod_cohere_v_20180705.eps');
line(0:20, 0:20) % just to start off file until figure out something better
print('-dpsc', fname)
fs = 100;
badsub = 'brian2'; % can't use this data because not enough to calculate null

%% Get model PSD to be same res as pupil
% See code in attmap_eyes_coherence_analysis.m
if LOAD_FFT
    stims = rp.stim;
    nr = 1;
    mod_fft = table;
    for istim = 1:length(stims)
        currstim = stims{istim};
        stimmask = strcmp(currstim, pup_mod_cohere.stim);
        
        % get extended model prediction for this stim
        currdata = pup_mod_cohere.model(stimmask);
        currdata = currdata{1}; % take first because all are the same
        
        % now do fft in same way as we did for coherence
        WINDOW = ceil(length(currdata)/160 * 2); % 160 = nloops
        NOVERLAP = ceil(WINDOW/4*3);
        NFFT = WINDOW;
        Fs = 100;
        
        FFTresult=fft(currdata,NFFT);
        L=length(currdata); % reset length of data
        power=FFTresult.*conj(FFTresult)/(NFFT*L); %Power of each positive freq component
        fVals=fs*(0:NFFT/2-1)/NFFT;
        power = power(1:NFFT/2);
        
        mod_fft.stim{nr,1} = currstim;
        mod_fft.fft{nr,1} = FFTresult;
        mod_fft.fvals{nr,1} = fVals;
        mod_fft.power{nr,1} = power;
        
        nr = nr+1;
    end % stim
end
%% Plot true and null coherence for each sub/stim
% include original pupil and model spectra as well
subs = unique(pup_mod_cohere.subject);
badind = strcmp(badsub, subs);
subs(badind) = [];


for isub = 1 %:numel(subs)
    figure()
    currsub = 'jr'; %subs(isub);
    submask_t = strcmp(pup_mod_cohere.subject, currsub);
    submask_n = strcmp(null.sub, currsub);
    
    for istim = 1:length(params.stimnames2)
        currstim = params.stimnames2{istim};
        stimmask_t = strcmp(pup_mod_cohere.stim, currstim);
        compmask_t = submask_t & stimmask_t;
        stimmask_mod = strcmp(mod_fft.stim, currstim);
        
        % Plot
        nstims = length(params.stimnames2);
        subplot(nstims, 1, istim)
        
        %model spectrum
        yyaxis right
        plot(mod_fft.fvals{stimmask_mod}, mod_fft.power{stimmask_mod}, 'Linewidth', 2)
        %ylim([0 .0007])
        ylabel('Model PSD')
        hold on
        
        % true coherence
        if sum(compmask_t) == 1
            yyaxis left
            plot(pup_mod_cohere.F{compmask_t}, pup_mod_cohere.true_cohere{compmask_t}, 'k', 'Linewidth', 2);
            hold on
            % null coherence
            plot(pup_mod_cohere.F{compmask_t}, null.cohere{submask_n}, 'k', 'Linewidth', 2)
            hold on
            
            plot_stim_ind = find(strcmp(params.plot_stimnames, cellstr(currstim)));
            plot_stim_lab = params.plot_stimnames{plot_stim_ind,2};
            title(plot_stim_lab)
            %title(currstim)
            xlim([0 2])
            ylim([0 .05])
            xlabel('Freq. (Hz)')
            ylabel('Pup-Model Coherence')
            
            % add legend to first subplot
            if istim == 1
                legend('True Coherence', 'Null Coherence', 'Location', 'NorthWest')
            end
            set(gca, 'fontsize', 12)
            set(gca, 'FontName', 'Helvetica')
            ax1 = gca;
            ax1.XColor = 'k';
            ax1.YColor = 'k';
            
            % print to file
        else
            continue
        end
        
    end %stim
    
    
   print('-dpsc', '-fillpage', fname)
   % close all
end %sub

