% Correlations between all predictor and outcome variables

% TODO - clean this up and find way to do this dynamically
    
% ------------------------------------------------------------------------%
%                 Baseline pup -> mean/ max/ vel/ latency pup
% ------------------------------------------------------------------------%
fprintf('\n\n\nBaseline Pupil correlations\n\n:')
% Baseline pupil and max evoked pup size
basePupMask = ~isnan(loopTable2.baselinePupMean200);
trialPupMask = ~isnan(loopTable2.trialPupMax);
figure();
subplot(1,4,1);
[r, p] = corr(loopTable2.baselinePupMean200(basePupMask), loopTable2.trialPupMax(trialPupMask), 'tail', 'left');
fprintf('The correlation between baseline pupil size and max evoked pupil size is: %04f\n. p = %04f\n. N = %d', r, p, sum(~isnan(loopTable2.trialPupMax(trialPupMask))));
scatter(loopTable2.baselinePupMean200(basePupMask), loopTable2.trialPupMax(trialPupMask), 'k');
xlabel('Mean baseline pupil size (arb. units)');
ylabel('Max evoked pupil size (arb. units)');
title('Correlation between baseline and max evoked pupil size');

% % Baseline pupil and mean evoked pup size
subplot(1,4,2);
[r, p] = corr(loopTable2.baselinePupMean200(basePupMask), loopTable2.trialPupMean(trialPupMask), 'tail', 'left');
fprintf('The correlation between baseline pupil size and mean evoked pupil size is: %04f\n. p = %04f\n. N = %d', r, p, sum(~isnan(loopTable2.trialPupMax(trialPupMask))));
scatter(loopTable2.baselinePupMean200(basePupMask), loopTable2.trialPupMean(trialPupMask), 'k');
xlabel('Mean baseline pupil size (arb. units)');
ylabel('Mean evoked pupil size (arb. units)');
title('Correlation between baseline pupil size and mean evoked pupil size');

% % Baseline pupil and pup velocity
subplot(1,4,3);
[r, p] = corr(loopTable2.baselinePupMean200(basePupMask), loopTable2.trialPupSlope(basePupMask), 'tail', 'right');
fprintf('The correlation between baseline pupil size and mean evoked pupil size is: %04f\n. p = %04f\n. N = %d', r, p, sum(~isnan(loopTable2.trialPupMax(trialPupMask))));
scatter(loopTable2.baselinePupMean200(basePupMask), loopTable2.trialPupSlope(basePupMask), 'k');
xlabel('Mean baseline pupil size (arb. units)');
ylabel('Pupil Slope (arb. units)');
title('Correlation between baseline pupil size and mean evoked pupil size');

% % Baseline pupil and max latency
subplot(1,4,4);
[r, p] = corr(loopTable2.baselinePupMean200(basePupMask), loopTable2.trialPupMaxLatency(basePupMask), 'tail', 'right');
fprintf('The correlation between baseline pupil size and pupil max latency size is: %04f\n. p = %04f\n. N = %d', r, p, sum(~isnan(loopTable2.trialPupMax(trialPupMask))));
scatter(loopTable2.baselinePupMean200(basePupMask), loopTable2.trialPupMaxLatency(basePupMask), 'k');
xlabel('Mean baseline pupil size (arb. units)');
ylabel('Pupil max latency (ms)');
title('Correlation between baseline pupil size and latency to pupil maximum');
% ------------------------------------------------------------------------%

% TODO - add print statements here
[r, p] = corr(loopTable2.baselinePupMean200(basePupMask), loopTable2.resonOut(basePupMask))%, 'tail', 'left');
[r, p] = corr(loopTable2.baselinePupMean200(basePupMask), loopTable2.curr_dB_lev(basePupMask))%, 'tail', 'left');

figure();
scatter(loopTable2.curr_dB_lev(trialPupMask), loopTable2.trialPupMax(trialPupMask));
[r, p] = corr(loopTable2.curr_dB_lev(trialPupMask), loopTable2.trialPupMax(trialPupMask), 'tail', 'right');
fprintf('The correlation between dB level and max evoked pupil size is: %04f\n. p = %04f\n. N = %d', r, p, length(loopTable2.trialPupMax(trialPupMask)));
% ------------------------------------------------------------------------%



% ------------------------------------------------------------------------%
%                                   RT
% ------------------------------------------------------------------------%
% RT-related
fprintf('\n\n\nRT correlations\n\n:');
% Baseline pupil mean and RT
figure();
hitmask = logical(loopTable2.hit);
compmask = hitmask & ~isnan(loopTable2.baselinePupMean200);
% TODO -- why does this corr return nan? %%%%%%%%%%%
% Left off here 20180124
scatter(loopTable2.baselinePupMean200(compmask), loopTable2.RT(compmask));
r = corr(loopTable2.baselinePupMean200(compmask), loopTable2.RT(compmask));
fprintf('The correlation between baseline pupil size and reaction time is: %04f\n, p = %04f\n. N = %d', r, p, length(loopTable2.RT(compmask)));

[r, p] = corr(loopTable2.trialPupMaxLatency(compmask), loopTable2.RT(compmask))

% dB level and RT
figure();
scatter(loopTable2.curr_dB_lev(compmask), loopTable2.RT(compmask));
r = corr(loopTable2.curr_dB_lev(compmask), loopTable2.RT(compmask));
fprintf('The correlation between dB level and reaction time is: %04f\n', r)

figure();
scatter(loopTable2.trialPupMax(compmask), loopTable2.RT(compmask));
[r, p] = corr(loopTable2.trialPupMax(compmask), loopTable2.RT(compmask), 'tail', 'right');
fprintf('The correlation between max evoked pupil size and reaction is: %04f\n', r);

figure();
scatter(loopTable2.trialPupMean(compmask), loopTable2.RT(compmask));
[r, p] = corr(loopTable2.trialPupMean(compmask), loopTable2.RT(compmask), 'tail', 'right');
fprintf('The correlation between mean evoked pupil size and reaction is: %04f\n', r);

figure();
scatter(loopTable2.trialPupSlope(compmask), loopTable2.RT(compmask));
[r, p] = corr(loopTable2.trialPupSlope(compmask), loopTable2.RT(compmask), 'tail', 'right');
fprintf('The correlation between pupil slope and reaction is: %04f\n', r);


% ------------------------------------------------------------------------%
%                                  dB
% ------------------------------------------------------------------------%
% dB and pupil
% Relationship between pup and dB level
% sorted by hit / missed to control for attentional effects
hitmask = logical(loopTable2.hit);
nanmask = isnan(loopTable2.trialPupMax);
compmask = hitmask & ~nanmask;
subplot(121);
scatter(loopTable2.curr_dB_lev(~nanmask), loopTable2.trialPupMax(~nanmask));
[r,p] = corr(loopTable2.curr_dB_lev(~nanmask), loopTable2.trialPupMax(~nanmask));
title('dB and Max pup')
subplot(122)
scatter(loopTable2.curr_dB_lev(~nanmask), loopTable2.trialPupMean(~nanmask));
[r,p] = corr(loopTable2.curr_dB_lev(~nanmask), loopTable2.trialPupMean(~nanmask));
title('dB and Mean pup')


[r,p] = corr(loopTable2.curr_dB_lev(~nanmask), loopTable2.trialPupMaxLatency(~nanmask));

% ------------------------------------------------------------------------%
%                              reson model
% ------------------------------------------------------------------------%
% Reson Val - related
fprintf('\n\n\n Reson Output Correlations\n\n:');
trialPupMask = ~isnan(loopTable2.trialPupMax);
figure();
subplot(3,1,1);
[r, p] = corr(loopTable2.resonOut(trialPupMask), loopTable2.trialPupMax(trialPupMask), 'tail', 'right');
fprintf('The correlation between reson out val and max evoked pupil size is: %04f\n. p = %04f\n. N = %d', r, p, sum(~isnan(loopTable2.trialPupMax(trialPupMask))));
scatter(loopTable2.resonOut(trialPupMask), loopTable2.trialPupMax(trialPupMask), 'k');
xlabel('Mean Resonator Output (arb. units)');
ylabel('Max evoked pupil size (arb. units)');
title('Correlation between resonator output and max evoked pupil size');

subplot(3,1,2);
[r, p] = corr(loopTable2.resonOut(trialPupMask), loopTable2.trialPupMean(trialPupMask), 'tail', 'right');
fprintf('The correlation between reson out val and mean evoked pupil size is: %04f\n. p = %04f\n. N = %d', r, p, sum(~isnan(loopTable2.trialPupMax(trialPupMask))));
scatter(loopTable2.resonOut(trialPupMask), loopTable2.trialPupMean(trialPupMask), 'k');
xlabel('Mean Resonator Output (arb. units)');
ylabel('Mean evoked pupil size (arb. units)');
title('Correlation between resonator output and mean evoked pupil size');

subplot(3,1,3);
[r, p] = corr(loopTable2.resonOut(hitmask), loopTable2.RT(hitmask), 'tail', 'left');
fprintf('The correlation between reson out val and RT is: %04f\n. p = %04f\n. N = %d', r, p, sum(~isnan(loopTable2.trialPupMax(trialPupMask))));
scatter(loopTable2.resonOut(hitmask), loopTable2.RT(hitmask), 'k');
xlabel('Mean Resonator Output (arb. units)');
ylabel('Reaction Time(msecs)');
title('Correlation between resonator output and reaction time');



[r, p] = corr(loopTable2.resonOut(trialPupMask), loopTable2.trialPupMaxLatency(trialPupMask), 'tail', 'right');
% ------------------------------------------------------------------------%


% ------------------------------------------------------------------------%
%                                 Slope
% ------------------------------------------------------------------------%

[r, p] = corr(loopTable2.resonOut(trialPupMask), loopTable2.trialPupSlope(trialPupMask), 'tail', 'left');

[r, p] = corr(loopTable2.curr_dB_lev(trialPupMask), loopTable2.trialPupSlope(trialPupMask), 'tail', 'left');
figure();
scatter(loopTable2.curr_dB_lev(trialPupMask), loopTable2.trialPupSlope(trialPupMask));

[r, p] = corr(loopTable2.curr_dB_lev(trialPupMask), loopTable2.resonOut(trialPupMask), 'tail', 'right');


% ------------------------------------------------------------------------%
%                  % Correlations between pupil measures
% ------------------------------------------------------------------------%
[r, p] = corr(loopTable2.trialPupMax(trialPupMask), loopTable2.trialPupSlope(trialPupMask))%, 'tail', 'left');
[r, p] = corr(loopTable2.trialPupMean(trialPupMask), loopTable2.trialPupSlope(trialPupMask))%, 'tail', 'left');
[r, p] = corr(loopTable2.trialPupMean(trialPupMask), loopTable2.trialPupMax(trialPupMask))%, 'tail', 'left');
[r, p] = corr(loopTable2.trialPupMean(trialPupMask), loopTable2.trialPupMaxLatency(trialPupMask))%, 'tail', 'left');
[r, p] = corr(loopTable2.trialPupMax(trialPupMask), loopTable2.trialPupMaxLatency(trialPupMask))
[r, p] = corr(loopTable2.trialPupSlope(trialPupMask), loopTable2.trialPupMaxLatency(trialPupMask))
% -----------------------------------------------------------------------------%