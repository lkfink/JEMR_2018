% Plots useful for attmap_eyes project
% LF - 11-29-16

%% Good Plots at the Moment



%% Pup - dB correlations by subject 
% This section prints plots with correlations between the dB level and mean
% pupil size on every trial


% compute correlation for each sub 
subids = unique(pupDbTbl.subject_id);
nsubs = length(subids);
corrs = zeros(1,nsubs);

% print to file
fname = fullfile(params.paths.fig_path, 'subjectCorrelations.ps');
line(0:20, 0:20) % just to start off file until figure out something better
print('-dpsc', fname)

for isub = 1:nsubs
    close all
    
    currsub = subids(isub);
    submask = strcmp(pupDbTbl.subject_id, currsub);
    hitmask = logical(pupDbTbl.hit);
    missmask = ~hitmask;
    
    % First plot overall correlation for this sub, all stims/probes
    figure()
    scatter(pupDbTbl.currdB(submask & hitmask), pupDbTbl.meanPup(submask & hitmask),'g', 'filled')
    [r1,p1] = corr(pupDbTbl.currdB(submask & hitmask), pupDbTbl.meanPup(submask & hitmask));
    text(10, 4.5, sprintf('HIT: r = %.3f, p = %.3f', r1, p1), ...
        'horizontalalign','right', ...
        'fontsize', 12)
    h = lsline;
    set(h,'color','g')
    hold on
    
    scatter(pupDbTbl.currdB(submask & missmask), pupDbTbl.meanPup(submask & missmask),'r', 'filled')
    [r2,p2] = corr(pupDbTbl.currdB(submask & missmask), pupDbTbl.meanPup(submask & missmask));
    text(10, -2.5, sprintf('MISS: r = %.3f, p = %.3f', r2, p2), ...
        'horizontalalign','left', ...
        'fontsize', 12)
    lsline

    
    set(gca, 'fontsize', 12)
    legend('hit','hit','miss','miss')
    title('Correlation between dB and pupil size across all stimuli and probes')
    suptitle(currsub)
    xlabel('deviant dB contrast')
    ylabel('Mean Pupil Size')
    ylim([-3 5]);
    xlim([0 20]);
    
    print('-dpsc','-append', fname)
    close all
    
    
    stims = unique(pupDbTbl.stimulus_id(submask));
    for istim = 1:length(nstims)
        currstim = stims(istim);
        stimmask = strcmp(pupDbTbl.stimulus_id, currstim);
        
        % Now plot pup/db correlation for this sub, this stim
        figure()
        scatter(pupDbTbl.currdB(submask & hitmask & stimmask), pupDbTbl.meanPup(submask & hitmask & stimmask),'g', 'filled')
        [r1,p1] = corr(pupDbTbl.currdB(submask & hitmask & stimmask), pupDbTbl.meanPup(submask & hitmask & stimmask));
        text(10, 4.5, sprintf('HIT: r = %.3f, p = %.3f', r1, p1), ...
            'horizontalalign','right', ...
            'fontsize', 12)
        h = lsline;
        set(h,'color','g')
        hold on
        
        scatter(pupDbTbl.currdB(submask & missmask & stimmask), pupDbTbl.meanPup(submask & missmask & stimmask),'r', 'filled')
        [r2,p2] = corr(pupDbTbl.currdB(submask & missmask & stimmask), pupDbTbl.meanPup(submask & missmask & stimmask));
        text(10, -2.5, sprintf('MISS: r = %.3f, p = %.3f', r2, p2), ...
            'horizontalalign','left', ...
            'fontsize', 12)
        lsline
        
        set(gca, 'fontsize', 12)
        legend('hit','hit','miss','miss')
        title(currstim) % can you do this?
        xlabel('deviant dB contrast')
        ylabel('Mean Pupil Size')
        ylim([-3 5]);
        xlim([0 20]);
        
        print('-dpsc','-append', fname)
        close all
        
        probes = unique(pupDbTbl.probe_time(submask & stimmask));
        nprobes = length(probes);
        figure()
        for iprobe = 1:nprobes
            currprobe = probes(iprobe);
            probemask = pupDbTbl.probe_time == currprobe;

            
            % Now compute correlation between dB changes for this probe and
            % pupil data
            
            subplot(2,2,iprobe)
            scatter(pupDbTbl.currdB(submask & hitmask & stimmask & probemask), pupDbTbl.meanPup(submask & hitmask & stimmask & probemask),'g', 'filled')
            [r1,p1] = corr(pupDbTbl.currdB(submask & hitmask & stimmask & probemask), pupDbTbl.meanPup(submask & hitmask & stimmask & probemask));
            text(10, 4.5, sprintf('HIT: r = %.3f, p = %.3f', r1, p1), ...
                'horizontalalign','right', ...
                'fontsize', 12)
            lsline
            hold on
            
            scatter(pupDbTbl.currdB(submask & missmask & stimmask & probemask), pupDbTbl.meanPup(submask & missmask & stimmask & probemask),'r', 'filled')
            [r2,p2] = corr(pupDbTbl.currdB(submask & missmask & stimmask & probemask), pupDbTbl.meanPup(submask & missmask & stimmask & probemask));
            text(10, -2.5, sprintf('MISS: r = %.3f, p = %.3f', r2, p2), ...
                'horizontalalign','left', ...
                'fontsize', 12)
            lsline
            set(gca, 'fontsize', 12)
            legend('hit','hit','miss','miss')
            title(currprobe) % can you do this?
            xlabel('deviant dB contrast')
            ylabel('Mean Pupil Size')
            ylim([-3 5]);
            xlim([0 20]);
            suptitle(currstim)
            hold on

        end % probes
        print('-dpsc','-append', fname)
         
    end % stim
    
end %sub


%% Potentially useful plots

%%% RT related
hitMask = logical(pupDbTbl.hit);

corr(pupDbTbl.RT(hitMask), pupDbTbl.meanPup(hitMask));
corr(pupDbTbl.RT(hitMask), pupDbTbl.currdB(hitMask))

% would expect faster RT for high reson probes and vice versa. Mask and
% check this. 
highMask = strcmp('hi_reson', pupDbTbl.probeCond);
lowMask = strcmp('low_reson', pupDbTbl.probeCond);


hist(pupDbTbl.RT(hitMask & highMask))
mean(pupDbTbl.RT(hitMask & highMask))
mean(pupDbTbl.RT(lowMask & hitMask))


% do this from loopTable because at the moment something weird with
% pupDbTbl obs num - 1-23-17
stimmask = strcmp('prA_4_3i_1v_107bpm', loopTable.stimulus_id); %don't use data for this stim
lowMask = strcmp(loopTable.maxProbeCond, 'low_reson');
hiMask = strcmp(loopTable.maxProbeCond, 'hi_reson');
figure()
set(gca, 'fontsize', 12)
subplot(121)
hist(loopTable.RT(hiMask & ~stimmask),50)
title('RT to high salient devs')
xlabel('Reation time (in ms)')
ylabel('Number of trials')
subplot(122)
hist(loopTable.RT(lowMask & ~stimmask),50)
title('RT to low salient devs')
xlabel('Reation time (in ms)')
ylabel('Number of trials')

% plot RT by stim and probe

stims = unique(loopTable.stimulus_id);
for istim = 1:length(stims)
    figure()
    currstim = stims{istim};
    if strcmp(currstim, 'prA_4_3i_1v_107bpm') %will figure out how to deal with issues in this stim later; ignore for now.
        continue
    else
    end
    stimmask = strcmp(loopTable.stimulus_id, currstim);
    probeids = unique(loopTable.probe_id(stimmask));
    nodev = strcmp(probeids, 'no_deviant');
    probeids = probeids(~nodev);
    nprobes = length(probeids);
    for iprobe = 1:nprobes
        currprobe = probeids(iprobe);
        probemask = strcmp(currprobe, loopTable.probe_id);
        compmask = probemask & stimmask;
        
        subplot(nprobes,1,iprobe)
        hist(loopTable.RT(compmask))
        ylim([0 70]);
        xlim([0 1000]);
        title(currprobe)
        xlabel('Reation time (in ms)')
        ylabel('Number of trials')
        
        suptitle(currstim)

        
    
    end %probe
end

% ------------------------------------------------------------------------%
%%% correlation between meanPDF + meanPup (subplot 1) and model predicted
%%% salience + meanPup (subplot 2)

figure()
subplot(1,2,1)
scatter(PDF.meanPDF, PDF.meanPup, 'k', 'filled')
lsline
xlabel('Detection Threshold')
ylabel('Mean Pupil Size')
set(gca, 'fontsize', 14)
[r,p] = corr(PDF.modelVal, PDF.meanPup);
text(0.55, 0.76, sprintf('r = %.3f, p = %.3f', r, p), ...
    'horizontalalign','left', ...
    'fontsize', fontsize)

subplot(1,2,2)
scatter(PDF.modelVal, PDF.meanPup, 'k', 'filled')
lsline
xlabel('Model Output Value')
ylabel('Mean Pupil Size')
set(gca, 'fontsize', 14)
[r2,p2] = corr(PDF.modelVal, PDF.meanPup);
text(0.55, 0.76, sprintf('r = %.3f, p = %.3f', r2, p2), ...
    'horizontalalign','left', ...
    'fontsize', fontsize)

% ------------------------------------------------------------------------%
% Same as above but now for mean Max pupil size
figure()
subplot(1,2,1)
scatter(PDF.meanPDF, PDF.maxPup, 'k', 'filled')
lsline
xlabel('Detection Threshold')
ylabel('Mean Max Pupil Size')
set(gca, 'fontsize', 14)
[r2,p2] = corr(PDF.modelVal, PDF.maxPup);
text(0.55, 0.76, sprintf('r = %.3f, p = %.3f', r2, p2), ...
    'horizontalalign','left', ...
    'fontsize', fontsize)

subplot(1,2,2)
scatter(PDF.modelVal, PDF.maxPup, 'k', 'filled')
lsline
xlabel('Model Output Value')
ylabel('Mean Max Pupil Size')
set(gca, 'fontsize', 14)
[r2,p2] = corr(PDF.modelVal, PDF.maxPup);
text(0.55, 0.76, sprintf('r = %.3f, p = %.3f', r2, p2), ...
    'horizontalalign','left', ...
    'fontsize', fontsize)


%%%------------- correlations with dB data, all trials -----------------%%%

% correlation between 1) curr dB and average pupil (subplot 1)
% and 2) curr dB and max pupil size (subplot 2)

fontsize = 12;

% Plot correlation
figure()
subplot(1,2,1)
scatter(pupDbTbl.currdB, pupDbTbl.meanPup,'k', 'filled')
lsline
xlabel('deviant dB contrast (relative to baseline volume)')
ylabel('Avg Pupil Size')
set(gca, 'fontsize', 14)
[r,p] = corr(pupDbTbl.currdB, pupDbTbl.meanPup);
text(-0.75, 11, sprintf('r = %.3f, p = %.3f', r, p), ...
        'horizontalalign','left', ...
    'fontsize', fontsize)

subplot(1,2,2)
scatter(pupDbTbl.currdB, pupDbTbl.maxPup,'k', 'filled')
lsline
xlabel('deviant dB contrast (relative to baseline volume)')
ylabel('Max Pupil Size')
set(gca, 'fontsize', 14)
[r2,p2] = corr(pupDbTbl.currdB, pupDbTbl.meanPup);
text(-0.75, 11, sprintf('r2 = %.3f, p2 = %.3f', r2, p2), ...
        'horizontalalign','left', ...
    'fontsize', fontsize)
suptitle('Correlation between pup and dB level, every trial, every sub')

% ------------------------------------------------------------------------%
% Same plot as above but now looking just at HIT trials
hitmask = logical(pupDbTbl.hit);
t1mask = logical(pupDbTbl.currdB == 10);
compmask = hitmask & ~t1mask;

figure()
subplot(1,2,1)
scatter(pupDbTbl.currdB(compmask), pupDbTbl.meanPup(compmask),'k', 'filled')
lsline
xlabel('deviant dB contrast (relative to baseline volume)')
ylabel('Avg Pupil Size')
set(gca, 'fontsize', 14)
[r,p] = corr(pupDbTbl.currdB(compmask), pupDbTbl.meanPup(compmask));
text(-0.75, 11, sprintf('r = %.3f, p = %.3f', r, p), ...
        'horizontalalign','left', ...
    'fontsize', fontsize)

subplot(1,2,2)
scatter(pupDbTbl.currdB(compmask), pupDbTbl.maxPup(compmask),'k', 'filled')
lsline
xlabel('deviant dB contrast (relative to baseline volume)')
ylabel('Max Pupil Size')
set(gca, 'fontsize', 14)
[r2,p2] = corr(pupDbTbl.currdB(compmask), pupDbTbl.meanPup(compmask));
text(-0.75, 11, sprintf('r2 = %.3f, p2 = %.3f', r2, p2), ...
        'horizontalalign','left', ...
    'fontsize', fontsize)
suptitle('Correlation between pup and dB level, HIT trials, every sub')

% ------------------------------------------------------------------------%
% Same plot as above but now looking just at MISS trials
compmask = ~hitmask & ~t1mask;
figure()
subplot(1,2,1)
scatter(pupDbTbl.currdB(compmask), pupDbTbl.meanPup(compmask),'k', 'filled')
lsline
xlabel('deviant dB contrast (relative to baseline volume)')
ylabel('Avg Pupil Size')
set(gca, 'fontsize', 14)
[r,p] = corr(pupDbTbl.currdB(compmask), pupDbTbl.meanPup(compmask));
text(-0.75, 11, sprintf('r = %.3f, p = %.3f', r, p), ...
        'horizontalalign','left', ...
    'fontsize', fontsize)

subplot(1,2,2)
scatter(pupDbTbl.currdB(compmask), pupDbTbl.maxPup(compmask),'k', 'filled')
lsline
xlabel('deviant dB contrast (relative to baseline volume)')
ylabel('Max Pupil Size')
set(gca, 'fontsize', 14)
[r2,p2] = corr(pupDbTbl.currdB(compmask), pupDbTbl.meanPup(compmask));
text(-0.75, 11, sprintf('r2 = %.3f, p2 = %.3f', r2, p2), ...
        'horizontalalign','left', ...
    'fontsize', fontsize)
suptitle('Correlation between pup and dB level, MISS trials, every sub')
