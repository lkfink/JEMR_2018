% compare similarity of no dev avgs to model stims
% 06.13.2016 - LF (with some help from SA)

loadData = 1;
if loadData
    %load IOIpup and attmap_v1p2_stim_rp_analysis.mat
    load('IOIpup.mat');
    load('an.mat');
    % /Volumes/CorpusData1/attmap/attmap_v1p2/matfiles
    %load('/Volumes/CorpusData1/attmap/attmap_v1p2/matfiles/attmap_v1p2_stim_rp_analysis.mat');
else
end

% find similarity between model and pup time course
nperm = 1000;

brm = cellfun(@isempty, IOIpup.noDevMean);
labels = IOIpup.stimulus_id(~brm);
trials = IOIpup.noDevMean(~brm);

for k = 1:numel(trials)
    %NOTE hard coding the time range to [0ms,2200ms], n.b. pre/post samps
   trials{k} = trials{k}(1000:2200); 
end

ulab = unique(labels);
nstim = numel(ulab);

dataSimilarity = nan(nstim,1);

x = cell(nstim,1);

ntrial = zeros(nstim,1);



model_labels = {'prA_4_3i_1v_107bpm';'prA_74_3i_1v_107bpm';'prC_54_3i_1v_107bpm';'prC_74_3i_1v_107bpm';'prC_124_3i_1v_107bpm'};
% hard coding because labelled differently (need to figure out how to remove ".wav" if want
% to do this dynamically - come back to later
janata_model = an{1,3}.results.data{1,2};
for j = 1:length(janata_model)
    janata_model{j} = janata_model{j}';
end



%inititialize filter 
[b,a] = butter(8,0.16,'low'); %40/250
freqz(b,a) %if want to image filter
    
%Compute correlation between pupil time series and model output for each stim    
for k = 1:nstim

    i = strcmpi(model_labels, ulab{k});
    x{k} = janata_model{i};
    
    %x{k} = reshape(rand(size(trials{1})),[],1);
    
    curTrials = trials(strcmpi(ulab{k},labels));
    ntrial(k) = numel(curTrials);
    
    curTrials = reshape(curTrials,[],1);
    y = reshape(mean(cat(1,curTrials{:})),[],1);
    
    %NEED to get two time series to same length and Fs

    %lowpass filter
    y = filtfilt(b,a,y);
    
    %downsample to 100Hz (to match model
    y = downsample(y,5);
    
    %make it same length as model
    y = y(1:length(x{k}));
    
    
    dataSimilarity(k) = corr(x{k},y);
    
    [var.xcorr(:,istim), var.lags(:,istim)] = 
    variable(k)[a,b] = 
end

%take avg of corrcoefs
realSimilarity = mean(dataSimilarity);



%Compute null similarity by shuffling labels on pup data nperm times
nullSimilarity = nan(nperm,1);
for k = 1:nperm
    tmpSim = nan(nstim,1);
    for kS = 1:nstim
        shuffed = randperm(numel(labels), ntrial(kS));
        
        tmp = reshape(trials(shuffed),[],1);
        yshuff = reshape(mean(cat(1,tmp{:})),[],1);
        
        %lowpass filter
        yshuff = filtfilt(b,a,yshuff);
        
        %downsample to 100Hz (to match model
        yshuff = downsample(yshuff,5);
        
        %make it same length as model
        yshuff = yshuff(1:length(x{kS}));
    
        tmpSim(kS) = corr(x{kS}, yshuff);
    end
    %take avg
    nullSimilarity(k) = mean(tmpSim);
end


%%
%plot

h = figure();
ax = axes('Parent',h);
hist(ax, nullSimilarity, 100);
line([realSimilarity realSimilarity],ylim(), 'Color',[1,0,0],'LineWidth',3, 'Parent',ax);

