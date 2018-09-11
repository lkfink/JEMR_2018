% attmap eyes
% null model tests
% 29 Spet 2016

params = attmap_eyes_globals;

% Get null models to same length as pupil data

% check plots first
figure(6)
for i = 1:length(params.stim_density)
    subplot(2,3,i)
    line(1:16, params.stim_density{i,2},'Color','b')
    hold on
    line(1:16, params.stim_meter,'Color', 'k')
    hold on
    line(1:16, params.stim_dense_meter{i,2},'Color','g')
    title(params.stim_density{i,1})  
    legend('Event Density','Meter','Density + Meter')
    xlim([1 16])
    % add a line for our model output
    
    % plot all combos on final subplot
    subplot(2,3,6)
    for j = 1:length(params.stim_dense_meter)
        line(1:16, params.stim_dense_meter{j,2},'Color','g')
        hold on
        title('Density + Meter for all stimuli')
    end 
        
    
end
suptitle('Null Stimulus Models')



% get everything loaded in attmap_eyes_getModelVals
% example of plot..
% figure(90)
% plot(model_output{1})
% hold on
% plot(upTest)
% hold on
% plot(up2)
% hold on
% plot(up3)
% legend('BTB','meter','density','meter+density')