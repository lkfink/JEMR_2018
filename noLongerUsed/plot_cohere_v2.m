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

fname = fullfile(params.paths.fig_path, 'singleSub_pupMod_cohere_v2.ps');
print('-dpsc', fname)
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
               
        % true coherence
        if sum(compmask_t) == 1
            % true coherence
            plot(pup_mod_cohere.F{compmask_t}, pup_mod_cohere.true_cohere{compmask_t}, 'k', 'Linewidth', 2);
            hold on
            % null coherence
            plot(pup_mod_cohere.F{compmask_t}, null.cohere{submask_n}, ':k', 'Linewidth', 2)
            hold on
            
            % stim label and axes
            plot_stim_ind = find(strcmp(params.plot_stimnames, cellstr(currstim)));
            plot_stim_lab = params.plot_stimnames{plot_stim_ind,2};
            title(plot_stim_lab)
            xlim([0 2])
            ylim([0 .05])
            xlabel('Freq. (Hz)')
            ylabel('Pup-Model Coherence')
            
            %plot peak freqs
            hold on
            y1 = get(gca, 'ylim');
            peaks = rp.peakFreqs{stimmask_rp};
            peaks = peaks(peaks < 2);
            for ipeak = 1:length(peaks)
                peak = peaks(ipeak);
                plot([peak peak], y1, ':r', 'Linewidth', 2)
                hold on
            end % peaks

            % legend
            if istim == 1
                legend('True Coherence', 'Null Coherence', 'Model Peak Freq.', 'Location', 'NorthWest')
            end
            set(gca, 'fontsize', 12)
            set(gca, 'FontName', 'Helvetica')
            
            % print to file
        else
            continue
        end
        
    end %stim
    

    print('-dpsc', '-fillpage', fname)
    close all
end %sub

