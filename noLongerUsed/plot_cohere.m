% Plot coherence results
% LF started 20180227

params = attmap_eyes_globals;
fpath = params.paths.matpath;
LOAD_DATA = 0;

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

fname = fullfile(params.paths.fig_path, 'singleSub_pupMod_cohere.ps');
%line(0:20, 0:20) % just to start off file until figure out something better
%print('-dpsc', fname)
fs = 100;
badsub = 'brian2'; % can't use this data because not enough to calculate null

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
        stimmask_rp = strcmp(rp.stim, currstim);
        
        % Plot
        nstims = length(params.stimnames2);
        subplot(nstims, 1, istim)
        % pupil spectrum
        % plot(rp.fVals_epoch{stimmask_rp},rp.power_epoch{stimmask_rp})
        % NO _ don't use this ! ^
        % get fft from new signal that was used in calculating coherence.
        %         FFTresult = fft(pup_mod_cohere.pup{compmask_t});
        %         L=length(pup_mod_cohere.pup{compmask_t});
        %         NFFT = length(pup_mod_cohere.pup{compmask_t});
        %         power=FFTresult.*conj(FFTresult)/(NFFT*L); %Power of each positive freq component
        %         fVals=fs*(0:NFFT/2-1)/NFFT;
        %         power = power(1:NFFT/2);
        %         plot(fVals,power)
        %         hold on
        %model spectrum
        yyaxis right
        plot(rp.modelTseries_fVals{stimmask_rp}, rp.modelTseries_power{stimmask_rp}, 'Linewidth', 2)
        ylim([0 .03])
        ylabel('Model PSD')
        hold on
        % true coherence
        if sum(compmask_t) == 1
            yyaxis left
            plot(pup_mod_cohere.F{compmask_t}, pup_mod_cohere.true_cohere{compmask_t}, 'Linewidth', 2);
            hold on
            % null coherence
            plot(pup_mod_cohere.F{compmask_t}, null.cohere{submask_n}, 'Linewidth', 2)
            hold on
            %legend('Pupil Spectrum', 'Model Spectrum', 'True Coherence', 'Null Coherence')
            
            plot_stim_ind = find(strcmp(params.plot_stimnames, cellstr(currstim)));
            plot_stim_lab = params.plot_stimnames{plot_stim_ind,2};
            %titlestr = strcat(currsub, ' - ', plot_stim_lab);
            %title(titlestr)
            title(plot_stim_lab)
            xlim([0 2])
            ylim([0 .05])
            xlabel('Freq. (Hz)')
            ylabel('Pup-Model Coherence')
            
            %plot peak freqs
%             hold on
%             yyaxis right
%             y1 = get(gca, 'ylim');
%             peaks = rp.peakFreqs{stimmask_rp};
%             for ipeak = 1:length(peaks)
%                 %height = rp.peakHeight{stimmask_rp}(ipeak)/10;
%                 peak = peaks(ipeak);
%                 peakind = find(rp.modelTseries_fVals{stimmask_rp} >= peak);
%                 peakind = peakind(1);
%                 plot([peak peak], [0 rp.modelTseries_power{stimmask_rp}(peakind)], ':k', 'Linewidth', 2)
%                 hold on
%             end % peaks
%             ylim([0 .03])
%             ylabel('Predicted Stim PSD')
%             hold on
            if istim == 1
                legend('True Coherence', 'Null Coherence', 'Location', 'NorthWest')
            end
            set(gca, 'fontsize', 12)
            set(gca, 'FontName', 'Helvetica')
            
            % print to file
        else
            continue
        end
        
    end %stim
    

    %print('-dpsc', '-fillpage', fname)
    %close all
end %sub

