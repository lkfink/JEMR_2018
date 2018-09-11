% attmap_plot_eye_data
% Oct. 2015 - LF

% need to run proc_eye_data first
% - eventually will have outdata saved to be loaded here (when more final)

% Only deal with good data
gooddataMask = outdata.perc_interp <= 24.9999; % removes anything requiring 25% interpolation or above

% issue w 08blr trial 5 (55) and cym trial 3 (23)
gooddataMask(23) = 0;
gooddataMask(55) = 0;

outdata = outdata(gooddataMask,:);

%% Obtain avgs of interest
stimids = unique(params.stimnames);

%Pupil
pupControl = avg_loop_data(outdata,outdata.controlLoops,params);
pupHit = avg_loop_data(outdata,outdata.hitLoops,params);
pupMiss = avg_loop_data(outdata,outdata.missLoops,params);

%compile into one cell
pupCell = {pupControl; pupHit; pupMiss};

%sort by stimid
pupStimCell = {};
nr = 1;
for iType = 1:length(pupCell)
    currType = pupCell{iType};
    for i = 1:length(unique(stimids))
        pupStimCell{nr,i} = currType{i};        
    end
    nr = nr+1;
end


%Blinks
blinkControl = avg_loop_data(outdata,outdata.blinkControlLoops,params);
blinkHit = avg_loop_data(outdata,outdata.blinkHitLoops,params);
blinkMiss = avg_loop_data(outdata,outdata.blinkMissLoops,params);

blinkCell = {blinkControl; blinkHit; blinkMiss};

blinkStimCell = {};
nr = 1;
for iType = 1:length(blinkCell)
    currType = blinkCell{iType};
    for i = 1:length(unique(stimids))
        blinkStimCell{nr,i} = currType{i};        
    end
    nr = nr+1;
end

%% Plot

figure()
suptitle('Mean pupillary and blink responses to each stimulus across all participants')
nr = 2;
nc = size(pupStimCell, 2);
p = 1;
for i = 1:size(pupStimCell, 2);
    for j = 1:size(pupStimCell,1);      
        subplot(nr,nc,p)
        plot(mean(pupStimCell{j,i}))
        ylim([-.02 .02]);
        xlim([0 1200]);
        y = get(gca,'ylim');
        % need to underlay probe time lines
        probeTimes = params.stim_probetimes{j,2};
        probeTimes = probeTimes/2; % to put in sample time
        hold on
        for pt = 1:length(probeTimes)
            plot([probeTimes(pt) probeTimes(pt)], y)
            hold on
        end
        
        xlabel('Time (in samples)')
        ylabel('Normalized pupil size') 
        legend('control','hit','miss','location','SouthEast')
        title(stimids{i},'interpreter','none') 
               
        hold on
    end
    p = p+1;
end



hold on
p=6;
for i = 1:size(blinkStimCell, 2);   
    for j = 1:size(blinkStimCell,1);
        subplot(nr,nc,p)
        plot(mean(blinkStimCell{j,i}))
        ylim([0 .12]);
        xlim([0 1200]);
        xlabel('Time (in samples)')
        ylabel('Blink likelihood (between 0:1)')
        legend('control','hit','miss','location','NorthWest')
        title(stimids{i},'interpreter','none')
        hold on
    end  
    p = p+1;
end
% want supylabel (row) that says 'Pupil' and 'Blink


%% Plot blink data

%average blinks per trial per sub
subids = unique(outdata.subject_id);
meanBRtrial = zeros(length(subids),1);
for isub = 1:length(subids)
    currSub = subids(isub);
    subMask = strcmp(outdata.subject_id, currSub);
    meanBRtrial(isub) = mean(outdata.meanBR(subMask));
end
figure()
hist(meanBRtrial);
xlabel('Mean BR per trial')
ylabel('Number of Subjects')


% could bin by 10ms windows (or something like that) to make it a little
% more obvious? 

%% extra
% 
% 
% figure()
% suptitle('Mean pupillary and blink responses to each stimulus across all participants')
% nr = 2;
% nc = size(pupStimCell, 2);
% p = 1;
% for i = 1:size(pupStimCell, 2);
%     for j = 1:size(pupStimCell,1);
%         subplot(nr,nc,p)
%         plot(mean(pupStimCell{j,i}))
%         ylim([-.02 .02]);
%         xlim([0 1200]);
%         xlabel('Time (in samples)')
%         ylabel('Normalized pupil size')
%         legend('control','hit','miss','location','SouthEast')
%         title(stimids{i},'interpreter','none')
%         hold on
%     end
%     
% %     for j = 1:size(blinkStimCell,1);
% %         subplot(nr,nc,p)
% %         plot(mean(blinkStimCell{j,i}))
% %         ylim([.01 .1]);
% %         xlim([0 1200]);
% %         xlabel('Time (in samples)')
% %         ylabel('Blink likelihood (between 0:1)')
% %         legend('control','hit','miss','location','NorthWest')
% %         title(stimids{i},'interpreter','none')
% %         hold on
% %     end
%     
%     if p > 5
%         p = 0;
%     end
%     p = p+1;
% end

% 
% %now plot blink row
% p = 1;
% for i = 1:size(blinkStimCell, 2);
%     for j = 1:size(blinkStimCell,1);
%         subplot(nr,nc,p)
%         plot(mean(blinkStimCell{j,i}))
%         ylim([.01 .1]);
%         xlim([0 1200]);
%         xlabel('Time (in samples)')
%         ylabel('Blink likelihood (between 0:1)')
%         legend('control','hit','miss','location','NorthWest')
%         title(stimids{i},'interpreter','none')
%         hold on
%     end
%     if p > 5
%         p = 0;
%     end
%     p = p+1;
% end


%% Old and unecessary 

%% Pupil Analysis 
% Look at loop lengths by stimulus
stimids = unique(outdata.stimulus_id);
controlData = {stimids'};
controlMean = {stimids'};

for istim = 1:length(stimids)
   stimmask = strcmp(outdata.stimulus_id, stimids{istim});
   npts = cellfun('length',outdata.controlLoops(stimmask));
   
   % check to see if same number of samples for each loop iteration
   if any(diff(npts))
       fprintf('Unequal number of samples across trials for stim %d: %s\n', istim, stimids{istim});
   end
   
   % make all loop lengths equal in num of samples
   currData = outdata.controlLoops(stimmask); %only control loops
   currData = cellfun(@transpose,currData,'UniformOutput', false);
   lengths = cellfun('length',currData); 
   
   fixidx = find(lengths > min(lengths));
   if any(fixidx)
       for i = 1:length(fixidx)
           currData{fixidx(i)} = currData{fixidx(i)}(:,1:min(lengths));
       end
   end
       
   
   % output fixed data for this stimulus        
   controlData{istim} = currData;
   
   % Move it out of a cell array of matrices into a single matrix
   % controlData{istim} = [currData{:}]; %this not working
   
   %controlMean{istim} = cellfun(@mean, controlData, 'UniformOutput', false);
   controlMean{istim} = cellfun(@mean,controlData{istim}(:,1),'UniformOutput',false);
   
   % plot mean of all control loops across all participants for this stimulus
   
end


% 
%% Get data into matrices
stim1mat = cell2mat(controlMean{1,1});
stim2mat = cell2mat(controlMean{1,2});
stim3mat = cell2mat(controlMean{1,3});
stim4mat = cell2mat(controlMean{1,4});
stim5mat = cell2mat(controlMean{1,5});

%% Figures

% figure()
% suptitle('Mean pupillary response to each stimulus across all participants, divided into control, hit, missed')
% n = 131;
% for iType = 1:length(pupCell)
%     currType = pupCell{iType};
%     for iStim = 1:length(currType)
%         subplot(n)
%         plot(mean(currType{iStim}))
%         hold on
%         legend(stimids,'interpreter','none')
%         xlabel('Time (in samples)')
%         ylabel('Normalized pupil size')
%         title(iType) %need to get string of variable name
%     end   
%     n = n+1;
% end
% 
% % plot by stim
% figure()
% suptitle('Mean pupillary response to each stimulus for hit, missed, and control trials, across all participants')
% nr = 3;
% nc = 5;
% 
% for iStim = 1:length(stimids)
%     currData = pupStimCell{:,iStim};
%     for i = 1:length(pupStimCell)
%         subplot(n)
%         plot(mean(currData{i}))
%         hold on
%         xlabel('Time (in samples)')
%         ylabel('Normalized pupil size')
%     end
%     n = n+1;
% end
% 
% nr = 5;
% nc = 3;
% figure;
% suptitle('Mean pupillary response to each stimulus for hit, missed, and control trials, across all participants')
% ax = gobjects(nc,nr);
% 
% for ii = 1:15
%     ax(ii) = subplot(nr,nc,ii);
%     plot(ax(ii), mean(pupStimCell{ii}))
%     grid on;
%     h(ii) = xlabel('Time (in samples)');
%     h(ii) = ylabel('Normalized pupil size');
% end
% 
% ax = ax';
% set(ax, 'ylim', [-.02 .02]);
% set(ax, 'xlim', [0 1200]);
% set(h, 'fontsize', 12)
% 
% figure(3)
% suptitle('Pupillary response to control, hit, and miss loops averaged over all subjects for each stimulus')
% subplot(151)
% %title(frpintf('stimulus: /n', stimids(1)))
% plot(mean(stim1mat))
% hold on
% plot(mean(stim1hit))
% hold on
% plot(mean(stim1miss))
% title('prA_4_3i_1v_107bpm')
% legend('control','hit','miss')
% hold on
% xlabel('Time (in samples)')
% ylabel('Normalized Pupil Size')
% 
% subplot(152)
% plot(mean(stim2mat))
% hold on
% plot(mean(stim2hit))
% hold on
% plot(mean(stim2miss))
% title('prA_74_3i_1v_107bpm')
% hold on
% 
% subplot(153)
% plot(mean(stim3mat))
% hold on
% plot(mean(stim3hit))
% hold on
% plot(mean(stim3miss))
% title('prC_124_3i_1v_107bpm')
% hold on
% 
% subplot(154)
% plot(mean(stim4mat))
% hold on
% plot(mean(stim4hit))
% hold on
% plot(mean(stim4miss))
% title('prC_54_3i_1v_107bpm')
% hold on
% 
% subplot(155)
% plot(mean(stim5mat))
% hold on
% plot(mean(stim5hit))
% hold on
% plot(mean(stim5miss))
% title('prC_74_3i_1v_107bpm')
% 
% % Blink
% figure(4)
% suptitle('Eyeblink response to control, hit, and miss loops averaged over all subjects for each stimulus')
% subplot(311)
% imagesc(mean(blinkStim1control))
% title('control')
% title('prA_4_3i_1v_107bpm')
% hold on
% subplot(312)
% imagesc(mean(blinkStim1hit))
% title('hit')
% hold on
% subplot(313)
% imagesc(mean(blinkStim1miss),1)
% title('miss')
% hold on
% xlabel('Time (in samples)')
% ylabel('Avg. blink occurance')
% colorbar;




%% Extra / notes
% size([d{:}])
% plot(mean([d{:}]))
% figure(gcf)
% imagesc([d{:}])
% plot(mean([d{:}])')




%convert all to z scores
% center them around mean across whole loop (if not normally distributed)

%or just subtract mean of what plotting to center things

% 9,10,13 all NaN for controlLoops?? why??
% jm trial 5

%to delete row - something wrong with trial 2 of petr...?
% should also use this to get rid of rows requiring > 25% interp - consider
% using 15% ?
%  outdata(52,:) = [];

% for isub = 1:nsub
%     
%     
%     
% end
% 
% 
% % will need to overlay dev time on loop 
% % timings for these somewhere? - yes, in globals
% % model output in background - brian plots somewhere?
% 


% might want to plot by trial number because 1st trial = big drift down.
% later trials, smaller drift at beginning
% - this should be taken care of by filtering

% %extra
% d = outdata.controlLoops(stimmask)
% d{:}
% size([d{:}])
% plot(mean([d{:}]))
% figure(gcf)
% imagesc([d{:}])
% plot(mean([d{:}])')
% size([d{:}])
% plot(mean([d{:}]'))
% imagesc([d{:}]')
% imagesc(detrend([d{:}])')
% plot(detrend([d{:}])')
% plot(mean(detrend([d{:}])'))
% help butter
% [b,a] = butter(4,.1/250,'high')
% help freqz
% freqz(b,a)
% [b,a] = butter(10,.1/250,'high')
% freqz(b,a)
% filtered = filtfilt(b,a,outdata.pupInterp{1,1});
% figure
% plot(outdata.pupInterp{1,1})
% hold on
% plot(filtered)

% dim = ndims(hittest{1});
% M = cat(dim+1,hittest{1});
% meanArrayHit = mean(M,dim+1);
