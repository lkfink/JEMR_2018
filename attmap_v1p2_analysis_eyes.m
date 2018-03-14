% analysis job stack for attmap_v1p2 eyetrack experiment
% modeled after attmap_v1p2_analyses - May 1, 2015  BH
% June 15, 2015 LF
% edited Oct. 21, 2015 LF

globals = attmap_eyes_globals;
addpath /Users/finklk/svn/private/matlab/projects/attmap/attmap_v1p2
addpath /Users/finklk/svn/private/matlab/projects/attmap/attmap_v1
addpath /Users/finklk/svn/private/matlab/utils

LOAD_EXISTING = 0;  % Load existing mat-files to circumvent rerunning analyses

fstub = 'attmap_v1p2_analysis_eyes.mat';
matfname = fullfile(globals.paths.matpath,fstub);

if LOAD_EXISTING
    load(matfname);
end

% Create an array of analysis structures
%clear an;
na = 0;

% load ensemble analysis job stack (9 jobs in stack)
attmap_v1p2_eyetrack_ensemble_analyses; %having issue with ensemble connection

% import response data from max-generated subject files
na=na+1; %10
an{na}.name = 'load_max_data'; % change this!! - actually just need to change globals maxdata path. should be good 
an{na}.fun  = @attmap_v1_load_max_data;
an{na}.params = globals;

% append ensemble data to make one master data table
na=na+1; %11
an{na}.name = 'combine_max_ensemble_resps';
an{na}.fun  = @attmap_v1p2_combine_max_ensemble_resps;
an{na}.params = globals;
an{na}.params.writedatatbl = 1;
an{na}.params.report_thresh_data.fname = fullfile(globals.paths.tablepath,'attmap_v1p2_eyetrack_thresh_data.csv');
an{na}.params.report_trial_data.fname = fullfile(globals.paths.tablepath,'attmap_v1p2_eyetrack_trial_data.csv');
an{na}.requires = {
    struct('name','sMESS_STOMP_musicianBkgnd_listenerBkgnd')
    struct('name','load_max_data')
    };

% plots
na = na+1; %12
an{na}.name = 'plots';
an{na}.fun = @attmap_v1p2_resp_plots;
an{na}.params = globals;
an{na}.params.plot.bar_means = 1;
an{na}.params.plot.subj_traj = 0;
an{na}.params.plot.mean_traj = 0;   
an{na}.params.plot.subscollapsed = 1;
an{na}.params.plot.musicianship = 0;
an{na}.params.writedatatbl = 1;
an{na}.params.report_meanData.fname = fullfile(globals.paths.tablepath,'attmap_v1p2_mean_stim_probe_thresh.txt');
an{na}.params.report_meanData.write2file = 1;
% NOTE: thresh plotting function is set up to plot either mean_sig OR
% denv_sig, not both simultaneously. Must flag one or the other (or neither).
an{na}.params.plot.rp_behave.mean_sig = 1;
an{na}.params.plot.rp_behave.denv_sig = 0;
an{na}.requires = {...
    struct('name','combine_max_ensemble_resps')...
    };


jobmanParams.ensemble = globals.ensemble; % doesn't matter which group. only looks at conn_id.
jobmanParams.run_analyses = 1:11; %allows you to run just one of the above jobs

an = ensemble_jobman(an,jobmanParams);

save(matfname,'an');