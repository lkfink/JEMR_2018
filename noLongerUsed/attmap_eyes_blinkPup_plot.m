% trying to make combined blink and pupil plot


%% Plot IOIpup Across subs
% if not working, remove PJ's data

% outPupMeans = cell(nsubs,nstims,nprobes);  % just going to hard code this
% for now: 5 stims, 20 probes
outPupMeans = table;
outMeans = table; %blink data

stimids = unique(IOIpup.stimulus_id);  
figure() %initialize figure 
pi = 1;
pe = 5;
nr = 1;    

for istim = 1:length(stimids)
    
    currStim = stimids(istim);
    stimmask = strcmp(IOIpup.stimulus_id, currStim);
    stimmask2 = strcmp(IOIblink.stimulus_id, currStim);

    alldevids = unique(IOIpup.dev_label(stimmask));
    alldevids2 = unique(IOIblink.dev_label(stimmask2));
    
    nodevmask = strcmp(alldevids, 'no_deviant');
    nodevmask2 = strcmp(alldevids2, 'no_deviant');
    
    devids = alldevids(~nodevmask);
    devids2 = alldevids(~nodevmask2);
    
    probetimes = regexp(devids,'\d{1,4}','match');
    probetimes2 = regexp(devids2,'\d{1,4}','match');
    
    probetimes = [probetimes{:}];
    probetimes2 = [probetimes2{:}];
    
    for i = 1:length(probetimes)
        probetimes{i} = str2double(probetimes{i});
    end
    probetimes = cell2mat(probetimes);
    probetimes = sort(probetimes, 'ascend'); %now probe times sorted numerically
    
    
    for i = 1:length(probetimes2)
        probetimes2{i} = str2double(probetimes2{i});
    end
    probetimes2 = cell2mat(probetimes2);
    probetimes2 = sort(probetimes2, 'ascend'); %now probe times sorted numerically
    
    
    % isolate and average no dev data for this stim
    controlmaskPup = strcmp(IOIpup.dev_label, 'no_deviant');
    noDevDataPup = IOIpup.noDevMean(stimmask & controlmaskPup);
    nsubs = length(noDevDataPup);
    noDevDataPup = cell2mat(noDevDataPup);
    noDevMeanPup = mean(noDevDataPup);
    noDevSEMPup = std(noDevDataPup)/sqrt(nsubs);
    xpointsNDPup = 1:length(noDevMeanPup);
    NDUpperPup = noDevMeanPup + noDevSEMPup;
    NDLowerPup = noDevMeanPup - noDevSEMPup;
    
    
    controlmask = strcmp(IOIblink.dev_label, 'no_deviant');
    noDevData = IOIblink.noDevMean(stimmask2 & controlmask);
    nsubs = length(noDevData);
    noDevData = cell2mat(noDevData);
    noDevMean = mean(noDevData);
    noDevSEM = std(noDevData)/sqrt(nsubs);
    xpointsND = 1:length(noDevMean);
    NDUpper = noDevMean + noDevSEM;
    NDLower = noDevMean - noDevSEM;
    
    
    for idev = 1:length(devids)
        currdev = devids(idev);
        probe_maskPup = strcmp(IOIpup.dev_label, currdev);
        probe_mask = strcmp(IOIblink.dev_label, currdev);
        
        outPupMeans.stimulus_id(nr,1) = currStim;
        outPupMeans.dev_label(nr,1) = currdev;
        
        outMeans.stimulus_id(nr,1) = currStim;
        outMeans.dev_label(nr,1) = currdev;
        
        % Hit - what is deal with hit 1530 and ? - nan seems to solve it
        outPupHitData = IOIpup.hitMean(stimmask & probe_maskPup);
        nsubs = length(outPupHitData);
        outPupHitData = cell2mat(outPupHitData);
        outPupHitMean = nanmean(outPupHitData);
        outPupMeans.hitMean{nr,1} = outPupHitMean;
        outPupHitSEM = nanstd(outPupHitData)/sqrt(nsubs);
        outPupMeans.hitSEM{nr,1} = outPupHitSEM;

        xpointsHitPup = 1:length(outPupHitMean);
        hitUpperPup = outPupHitMean + outPupHitSEM;
        hitLowerPup = outPupHitMean - outPupHitSEM;
        
        
        % Hit - blink
        outHitData = IOIblink.hitMean(stimmask2 & probe_mask);
        for i = 1:length(outHitData)
            if isnan(outHitData{i})
                 outHitData{i} = zeros(1,3001); % hard coding... 
            else
            end
        end  
        nsubs = length(outHitData);
        outHitData = cell2mat(outHitData);
        outHitMean = nanmean(outHitData);
        outMeans.hitMean{nr,1} = outHitMean;
        outHitSEM = nanstd(outHitData)/sqrt(nsubs);
        outMeans.hitSEM{nr,1} = outHitSEM;

        xpointsHit = 1:length(outHitMean);
        hitUpper = outHitMean + outHitSEM;
        hitLower = outHitMean - outHitSEM;
        
        
        % Miss
        outPupMissData = IOIpup.missMean(stimmask & probe_maskPup);
        for i = 1:length(outPupMissData)
            if outPupMissData{i} == 0
                outPupMissData{i} = zeros(1,3001); % hard coding... 
            else
            end
        end
        nsubs = length(outPupMissData);
        outPupMissData = cell2mat(outPupMissData);
        outPupMissMean = nanmean(outPupMissData);
        outPupMeans.missMean{nr,1} = outPupMissMean;
        outPupMissSEM = nanstd(outPupMissData)/sqrt(nsubs);
        outPupMeans.missSEM{nr,1} = outPupMissSEM;

        xpointsMissPup = 1:length(outPupMissMean);
        missUpperPup = outPupMissMean + outPupMissSEM;
        missLowerPup = outPupMissMean - outPupMissSEM;
        
        
        %blink miss
        outMissData = IOIblink.missMean(stimmask2 & probe_mask);
        for i = 1:length(outMissData)
            if outMissData{i} == 0
                outMissData{i} = zeros(1,3001); % hard coding... 
            else
            end
        end
        nsubs = length(outMissData);
        outMissData = cell2mat(outMissData);
        outMissMean = nanmean(outMissData);
        outMeans.missMean{nr,1} = outMissMean;
        outMissSEM = nanstd(outMissData)/sqrt(nsubs);
        outMeans.missSEM{nr,1} = outMissSEM;

        xpointsMiss = 1:length(outMissMean);
        missUpper = outMissMean + outMissSEM;
        missLower = outMissMean - outMissSEM;
        
        
        
        % plot this stim this probe
        r = 8; %because want to plot blinks too
        c = 4;
        
        probetime = regexp(currdev,'\d{1,4}','match');
        probetime = [probetime{:}];
        probetime = str2num(probetime{:});
        probetime = probetime/2; %divide by 2 to get in samples, add 70 to account for timing issue
        probetime = probetime+1000; %nsamps pre loop start 
        
        subplot(r,c,pi)
        
        plot(xaxis, outPupHitMean,'g');
        %[ax,h1,h2] = plotyy(1:length(outPupHitMean), outPupHitMean, 1:length(outHitMean), outHitMean, 'plot','plot');
        hold on
        hHit = jbfill(xpointsHitPup,hitUpperPup,hitLowerPup,'g','g',1,.5);
        hold on
        
        plot(outPupMissMean, 'r')
        hold on
        hMiss = jbfill(xpointsMissPup,missUpperPup,missLowerPup,'r','r',1,.5);
        hold on
        
        plot(noDevMeanPup, 'k')
        hold on
        hND = jbfill(xpointsNDPup,NDUpperPup,NDLowerPup,'k','k',1,.5);
        hold on
        
        ylabel('Normalized Pupil Size')
        xlim([0,3000]);
        ylim([-.5,1]);
        y1 = get(gca, 'ylim');
        plot([1000 1000], y1, 'k') % nsamps 1000 pre/2000 post - this is start of loop
        hold on
        plot([probetime probetime], y1, ':r', 'LineWidth', 2)
        hold on
        xlabel('Time (msecs)')
        %set(gca,'XTickLabel',{'-2000','0', '2000','4000'})
        set(gca, 'fontsize', 14)
        title(currdev, 'interpreter','none')
        %legend([hHit hMiss hND],{'Hit','Miss', 'No Deviant'},'Location','northwest')
        
        %now plot blink data

        subplot(r,c,pe)
        plot(outHitMean, 'g'); 
        hold on
        hHit = jbfill(xpointsHit,hitUpper,hitLower,'g','g',1,.5);
        hold on
        
        plot(outMissMean, 'r')
        hold on
        hMiss = jbfill(xpointsMiss,missUpper,missLower,'r','r',1,.5);
        hold on
        
        plot(noDevMean, 'k')
        hold on
        hND = jbfill(xpointsND,NDUpper,NDLower,'k','k',1,.5);
        hold on


        ylabel('Blink Frequency')
        xlim([0,3000]);
        ylim([0,.4]);
        y1 = get(gca, 'ylim');
        plot([1000 1000], y1, 'k') % nsamps 1000 pre/2000 post - this is start of loop
        hold on
        plot([probetime probetime], y1, ':r', 'LineWidth', 2)
        hold on
        xlabel('Time (msecs)')  
        %legend([hHit hMiss hND],{'Hit','Miss', 'No Deviant'},'Location','northwest')
        %set(gca,'XTickLabel',{'-2000','0', '2000','4000'})
        set(gca, 'fontsize', 14)


        pi=pi+1;
        pe=pe+1;
        nr = nr+1;     
    end %probes for this stim
    
    pi = pi+4;
    pe = pe+4;
    
    outPupMeans.noDevMean{nr,1} = noDevMeanPup;
    outPupMeans.noDevSEM{nr,1} = noDevSEMPup; 
    
    outMeans.noDevMean{nr,1} = noDevMean;
    outMeans.noDevSEM{nr,1} = noDevSEM; 
    

    
end % stim
suptitle('Mean pupillary and blink response to each deviant of each stim, across all participants, time-locked to loop onset')




%% plot one stim at a time
% trying to make combined blink and pupil plot


%% Plot IOIpup Across subs
% if not working, remove PJ's data

% outPupMeans = cell(nsubs,nstims,nprobes);  % just going to hard code this
% for now: 5 stims, 20 probes
outPupMeans = table;
outMeans = table; %blink data

stimids = unique(IOIpup.stimulus_id);  


nr = 1;    

for istim = 1:length(stimids)
    figure()
    pi = 1;
    pe = 5;
    
    currStim = stimids(istim);
    stimmask = strcmp(IOIpup.stimulus_id, currStim);
    stimmask2 = strcmp(IOIblink.stimulus_id, currStim);

    alldevids = unique(IOIpup.dev_label(stimmask));
    alldevids2 = unique(IOIblink.dev_label(stimmask2));
    
    nodevmask = strcmp(alldevids, 'no_deviant');
    nodevmask2 = strcmp(alldevids2, 'no_deviant');
    
    devids = alldevids(~nodevmask);
    devids2 = alldevids(~nodevmask2);
    
    probetimes = regexp(devids,'\d{1,4}','match');
    probetimes2 = regexp(devids2,'\d{1,4}','match');
    
    probetimes = [probetimes{:}];
    probetimes2 = [probetimes2{:}];
    
    for i = 1:length(probetimes)
        probetimes{i} = str2double(probetimes{i});
    end
    probetimes = cell2mat(probetimes);
    probetimes = sort(probetimes, 'ascend'); %now probe times sorted numerically
    
    
    for i = 1:length(probetimes2)
        probetimes2{i} = str2double(probetimes2{i});
    end
    probetimes2 = cell2mat(probetimes2);
    probetimes2 = sort(probetimes2, 'ascend'); %now probe times sorted numerically
    
    
    % isolate and average no dev data for this stim
    controlmaskPup = strcmp(IOIpup.dev_label, 'no_deviant');
    noDevDataPup = IOIpup.noDevMean(stimmask & controlmaskPup);
    nsubs = length(noDevDataPup);
    noDevDataPup = cell2mat(noDevDataPup);
    noDevMeanPup = mean(noDevDataPup);
    noDevSEMPup = std(noDevDataPup)/sqrt(nsubs);
    xpointsNDPup = 1:length(noDevMeanPup);
    NDUpperPup = noDevMeanPup + noDevSEMPup;
    NDLowerPup = noDevMeanPup - noDevSEMPup;
    
    
    controlmask = strcmp(IOIblink.dev_label, 'no_deviant');
    noDevData = IOIblink.noDevMean(stimmask2 & controlmask);
    nsubs = length(noDevData);
    noDevData = cell2mat(noDevData);
    noDevMean = mean(noDevData);
    noDevSEM = std(noDevData)/sqrt(nsubs);
    xpointsND = 1:length(noDevMean);
    NDUpper = noDevMean + noDevSEM;
    NDLower = noDevMean - noDevSEM;
    
    
    for idev = 1:length(devids)
        currdev = devids(idev);
        probe_maskPup = strcmp(IOIpup.dev_label, currdev);
        probe_mask = strcmp(IOIblink.dev_label, currdev);
        
        outPupMeans.stimulus_id(nr,1) = currStim;
        outPupMeans.dev_label(nr,1) = currdev;
        
        outMeans.stimulus_id(nr,1) = currStim;
        outMeans.dev_label(nr,1) = currdev;
        
        % Hit - what is deal with hit 1530 and ? - nan seems to solve it
        outPupHitData = IOIpup.hitMean(stimmask & probe_maskPup);
        nsubs = length(outPupHitData);
        outPupHitData = cell2mat(outPupHitData);
        outPupHitMean = nanmean(outPupHitData);
        outPupMeans.hitMean{nr,1} = outPupHitMean;
        outPupHitSEM = nanstd(outPupHitData)/sqrt(nsubs);
        outPupMeans.hitSEM{nr,1} = outPupHitSEM;

        xpointsHitPup = 1:length(outPupHitMean);
        hitUpperPup = outPupHitMean + outPupHitSEM;
        hitLowerPup = outPupHitMean - outPupHitSEM;
        
        
        % Hit - blink
        outHitData = IOIblink.hitMean(stimmask2 & probe_mask);
        for i = 1:length(outHitData)
            if isnan(outHitData{i})
                 outHitData{i} = zeros(1,3001); % hard coding... 
            else
            end
        end  
        nsubs = length(outHitData);
        outHitData = cell2mat(outHitData);
        outHitMean = nanmean(outHitData);
        outMeans.hitMean{nr,1} = outHitMean;
        outHitSEM = nanstd(outHitData)/sqrt(nsubs);
        outMeans.hitSEM{nr,1} = outHitSEM;

        xpointsHit = 1:length(outHitMean);
        hitUpper = outHitMean + outHitSEM;
        hitLower = outHitMean - outHitSEM;
        
        
        % Miss
        outPupMissData = IOIpup.missMean(stimmask & probe_maskPup);
        for i = 1:length(outPupMissData)
            if outPupMissData{i} == 0
                outPupMissData{i} = zeros(1,3001); % hard coding... 
            else
            end
        end
        nsubs = length(outPupMissData);
        outPupMissData = cell2mat(outPupMissData);
        outPupMissMean = nanmean(outPupMissData);
        outPupMeans.missMean{nr,1} = outPupMissMean;
        outPupMissSEM = nanstd(outPupMissData)/sqrt(nsubs);
        outPupMeans.missSEM{nr,1} = outPupMissSEM;

        xpointsMissPup = 1:length(outPupMissMean);
        missUpperPup = outPupMissMean + outPupMissSEM;
        missLowerPup = outPupMissMean - outPupMissSEM;
        
        
        %blink miss
        outMissData = IOIblink.missMean(stimmask2 & probe_mask);
        for i = 1:length(outMissData)
            if outMissData{i} == 0
                outMissData{i} = zeros(1,3001); % hard coding... 
            else
            end
        end
        nsubs = length(outMissData);
        outMissData = cell2mat(outMissData);
        outMissMean = nanmean(outMissData);
        outMeans.missMean{nr,1} = outMissMean;
        outMissSEM = nanstd(outMissData)/sqrt(nsubs);
        outMeans.missSEM{nr,1} = outMissSEM;

        xpointsMiss = 1:length(outMissMean);
        missUpper = outMissMean + outMissSEM;
        missLower = outMissMean - outMissSEM;
        
        
        
        % plot this stim this probe
        r = 2; %because want to plot blinks too
        c = 4;
        
        probetime = regexp(currdev,'\d{1,4}','match');
        probetime = [probetime{:}];
        probetime = str2num(probetime{:});
        probetime = probetime/2; %divide by 2 to get in samples, add 70 to account for timing issue
        probetime = probetime+1000; %nsamps pre loop start 
        
        subplot(r,c,pi)
        
        

        plot(outPupHitMean,'g');
        %[ax,h1,h2] = plotyy(1:length(outPupHitMean), outPupHitMean, 1:length(outHitMean), outHitMean, 'plot','plot');
        hold on
        hHit = jbfill(xpointsHitPup,hitUpperPup,hitLowerPup,'g','g',1,.5);
        hold on
        
        
        plot(outPupMissMean, 'r')
        hold on
        hMiss = jbfill(xpointsMissPup,missUpperPup,missLowerPup,'r','r',1,.5);
        hold on
        
        plot(noDevMeanPup, 'k')
        hold on
        hND = jbfill(xpointsNDPup,NDUpperPup,NDLowerPup,'k','k',1,.5);
        hold on
        
        ylabel('Normalized Pupil Size')
        xlim([0,3000]);
        ylim([-.5,1]);
        y1 = get(gca, 'ylim');
        plot([1000 1000], y1, 'k') % nsamps 1000 pre/2000 post - this is start of loop
        hold on
        plot([2100 2100], y1, 'k') % approx start of next loop
        hold on
        plot([probetime probetime], y1, ':r', 'LineWidth', 2)
        hold on
        xlabel('Time (msecs)')
        set(gca,'XTickLabel',{'-2000','0', '2000','+2000'})
        set(gca, 'fontsize', 14)
        title(currdev, 'interpreter','none')
        %legend([hHit hMiss hND],{'Hit','Miss', 'No Deviant'},'Location','northwest')
        
        %now plot blink data

        subplot(r,c,pe)
        plot(outHitMean, 'g'); 
        hold on
        hHit = jbfill(xpointsHit,hitUpper,hitLower,'g','g',1,.5);
        hold on
        
        plot(outMissMean, 'r')
        hold on
        hMiss = jbfill(xpointsMiss,missUpper,missLower,'r','r',1,.5);
        hold on
        
        plot(noDevMean, 'k')
        hold on
        hND = jbfill(xpointsND,NDUpper,NDLower,'k','k',1,.5);
        hold on


        ylabel('Blink Frequency')
        xlim([0,3000]);
        ylim([0,.4]);
        y1 = get(gca, 'ylim');
        plot([1000 1000], y1, 'k') % nsamps 1000 pre/2000 post - this is start of loop
        hold on
        plot([2100 2100], y1, 'k') % approx start of next loop
        hold on
        plot([probetime probetime], y1, ':r', 'LineWidth', 2)
        hold on
        xlabel('Time (msecs)')  
        %legend([hHit hMiss hND],{'Hit','Miss', 'No Deviant'},'Location','northwest')
        set(gca,'XTickLabel',{'-2000','0', '2000','+2000'})
        set(gca, 'fontsize', 14)

       
        
        pi=pi+1;
        pe=pe+1;
        nr = nr+1;     
    end %probes for this stim
    
    pi = pi+4;
    pe = pe+4;
    
    outPupMeans.noDevMean{nr,1} = noDevMeanPup;
    outPupMeans.noDevSEM{nr,1} = noDevSEMPup; 
    
    outMeans.noDevMean{nr,1} = noDevMean;
    outMeans.noDevSEM{nr,1} = noDevSEM; 
    

    
end % stim
%suptitle('Mean pupillary and blink response to each deviant of each stim, across all participants, time-locked to loop onset')
