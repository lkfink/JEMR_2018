%% Plot pupil data by sub/stim/dev hit/miss - one plot for every sub
% generates 5 r, 4 col subplots for each subject, with hit and miss pupil
% traces (for each probe in each stim)

% Subjects
subs = unique(loopTable2.subject_id);

for isub=1:length(subs)
    currsub = subs(isub);
    submask = strcmp(loopTable2.subject_id, currsub);

    figure()
    pi = 1;
    % Stimuli
    stims = unique(loopTable2.stimulus_id(submask));
    for istim = 1:length(stims)
        currstim = stims(istim);
        stimmask = strcmp(loopTable2.stimulus_id, currstim);

        % Deviants (probe ids)
        devs = unique(loopTable2.probe_id(submask & stimmask));
        ndmask = strcmp(devs, 'no_deviant');
        badmask = strcmp(devs, 'dev_hi_2086;loop'); % remove this as unique dev id
        devs = devs(~ndmask & ~badmask);

        cols = length(devs);
        rows = length(stims);

        for idev = 1:length(devs)
            currdev = devs(idev);
            if strcmp(currdev, 'dev_hi_2086')
                devmask1 = strcmp(loopTable2.probe_id, currdev);
                devmask2 = strcmp(loopTable2.probe_id, 'dev_hi_2086;loop'); % combine this probe id with standard probe id
                devmask = devmask1 + devmask2;
            else
                devmask = strcmp(loopTable2.probe_id, currdev);
            end

            % Hit / Missed
            hitmask = logical(loopTable2.hit);
            missmask = devmask & ~hitmask;

            % Get data
            hitdata = loopTable2.trialPup(submask & stimmask & devmask & hitmask);
            missdata = loopTable2.trialPup(submask & stimmask & devmask & missmask);

            % Plot pupil
            subplot(rows,cols,pi)

            for ih = 1:length(hitdata)
                plot(hitdata{ih}, 'g');
                hold on
                xlim([0,2000]);
                ylim([-4,6]);
            end
            hold on
            for im = 1:length(missdata)
                plot(missdata{im}, 'r')
                hold on
                xlim([0,2000]);
                ylim([-4,6]);
            end
            xlabel('Time (samples). Dev onset at t=0.')
            ylabel('Norm Pup Size')
            title(currdev, 'Interpreter', 'None')


            pi = pi+1;

        end % dev

    end %stim

    suptitle(currsub)

end % sub

