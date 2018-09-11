% Make plots needed for figure involving model stages
% Do this for complex 1
% Note that already have all necessary rp output in attmap_v1p2 rp plots
params = attmap_eyes_globals;
fs = 100;

% Load model data
fstub = 'MPP_pup.mat'; % the mat is called rp
sprintf('Loading %s', fstub)
load(fullfile(fpath, fstub))
fprintf('Finished loading: %s', fstub)
    
    
stim = params.stimnames2{1}; % this is 4th cell in rp data
stimmask = strcmp(rp.stim, stim);

ts = rp.meanSig_peakTseries{stimmask};
tse = repmat(ts, 1, 4);

% Plot peak time series
secs = length(tse)/fs;
x = 1:(fs*secs);
xaxis = x/fs;

figure()
plot(xaxis, tse, 'k', 'Linewidth', 1.5)
ylim([-1 1])
ylabel('Reson Amplitude')
xlabel('Time (s)')
fname = fullfile(params.paths.fig_path, 'complex1_peakTseries.eps');
print('-dpsc', fname)

% Plot conv of peak t series and PRF

PRF = genPRF(fs, 0); % 100 Hz, nonmotor
pred = conv(tse, PRF, 'same');



% Plot model
figure()
y = (pred - mean(pred)) / std(pred);
plot(xaxis, y, 'k', 'Linewidth', 1.5)
ylabel('Predicted pupil size (z-score)')
xlabel('Time (s)')
ylim([-2 2])
fname = fullfile(params.paths.fig_path, 'complex1_conv.eps');
print('-dpsc', fname)