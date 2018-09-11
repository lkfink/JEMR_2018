% Plot PRFs for motor and non- motor flags

% Lauren Fink (lkfink@ucdavis)
% Janata Lab, UC Davis, Center for Mind & Brain 

params = attmap_eyes_globals;

lineWidth = 1.5;
fs = 100;
motor = 0;
PRF = genPRF(fs, motor);

figure()

secs = length(PRF)/fs;
if motor
    x = 0:(fs*secs);
else
    x = 1:(fs*secs);
end

xaxis = x/fs*1000;
    
plot(xaxis, PRF, 'k', 'LineWidth', lineWidth)
ylabel('Pupil Size')
xlabel('Time (ms)')
set(gca, 'fontsize', 12)
set(gca, 'FontName', 'Helvetica')

if motor
    fname = fullfile(params.paths.fig_path, 'PRF_motor.eps');
else
    fname = fullfile(params.paths.fig_path, 'PRF_nonMotor.eps');
end

print('-dpsc', fname)