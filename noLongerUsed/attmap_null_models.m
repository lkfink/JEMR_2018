% Alternative Models for Attmap stimuli shared between Brian and Lauren
% Nov. 16, 2016 - LF

% Assuming this info could be added to the globals files of any relevant
% experiment.

% Meter
globals.stim_meter = [4,1,2,1,3,1,2,1,4,1,2,1,3,1,2,1]; % same for all stim (because all in 4/4)!


% Event Density - number of instruments playing at each point in time
globals.stim_density = {
'prA_4_3i_1v_107bpm.wav', [2,1,2,0,2,2,0,1,2,1,2,0,0,2,1,2];...
'prA_74_3i_1v_107bpm.wav', [2,1,2,0,2,2,0,1,2,1,2,0,0,2,1,2];...
'prC_54_3i_1v_107bpm.wav', [2,1,0,2,2,0,2,1,2,1,0,2,0,2,2,1];...
'prC_74_3i_1v_107bpm.wav', [2,2,0,1,2,0,2,1,2,2,0,1,0,2,1,2];...
'prC_124_3i_1v_107bpm.wav', [2,2,0,1,2,1,2,0,2,2,0,1,0,2,1,2];...
'simple1v2.wav', [2,0,1,0,2,0,1,0,2,0,1,0,2,0,1,0];...
'simple2v2.wav', [2,0,1,0,1,0,2,0,1,0,1,0,2,0,2,0];
};

% Magnitude of predictions doesn't matter but pos/neg does. Scale null
% models to be between -1 and 1



% Should we make one based on timbre (instrument playing)?



% want to add this to stim_impulse_trains

% for istim = 1:length(unique(stim_impulse_trains.stimulus_id))
%     currstim = stim_impulse_trains.stimulus_id{istim};
%     stimmask = strcmp(currstim, stim_impulse_trains.stimulus_id);
%     
%     ^ this is just dumb. just copy from globals into imp_trains, then upsample