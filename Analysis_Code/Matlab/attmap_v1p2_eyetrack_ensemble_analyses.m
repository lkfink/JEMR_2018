% Ensemble analysis job stack for attmap_v1p2_eyetrack
% Modeled after attmap_v1p2_ensemble_analyses (BH)
%
% Oct 21, 2015 LF - this file needed to be duplicated and placed into my
% svn folder so that globals would refer to attmap_eyes_globals

globals = attmap_eyes_globals;

% Create an array of analysis structures
%clear an;
na = 0;

% get experiment info from Ensemble
na=na+1; %1
an{na}.name = 'expinfo';
an{na}.fun  = @ensemble_load_expinfo;
an{na}.params = globals;
an{na}.params.ensemble = globals.ensemble;
an{na}.params.mysql = globals.mysql;
an{na}.params.ensemble.remove_incomplete_sessions = 1;

% Add a MESS analysis job
na = na+1; %2
an{na}.name = 'sMESS';
an{na}.fun = @ensemble_analyze_short_mess;
an{na}.requires = {struct('name','expinfo','vars','response_data')};
an{na}.params.mysql = globals.mysql;

% % Export the MESS data
% na = na+1;
% an{na}.name = 'exportMess';
% an{na}.fun = @ensemble_print_datast;
% an{na}.requires = {struct('name','MESS')};
% an{na}.params.export.write2file = 1;
% an{na}.params.export.fname = fullfile(globals.paths.analysis_path,'MESS.csv');

% Add a STOMP analysis job
na = na+1; %3
an{na}.name = 'STOMP';
an{na}.fun = @ensemble_analyze_stomp_v2;
an{na}.requires = {struct('name','expinfo','vars','response_data')};
an{na}.params.mysql = globals.mysql;

% Report subject ages and gender
na = na+1; %4
an{na}.name = 'subjectMeta';
an{na}.fun = @ensemble_report_subject_meta;
an{na}.requires = {struct('name','expinfo','vars','subject_info'), ...
  struct('name','expinfo','vars','session_info')};

% Combine the sMESS and STOMP output structures
na = na+1; %5
an{na}.name = 'sMESS_STOMP';
an{na}.fun = @ensemble_combine_datastructs;
an{na}.requires = {struct('name','sMESS'), struct('name','STOMP')};

% Get listener background data
na = na+1; %6
an{na}.name = 'listener_bkgnd';
an{na}.fun = @ensemble_analyze_listener_bkgnd;
an{na}.params = globals;
an{na}.params.ensemble = globals.ensemble;
an{na}.params.mysql = globals.mysql;
an{na}.requires = {struct('name','expinfo','vars','response_data')};

% Get musician background data
na = na+1; %7
an{na}.name = 'musician_bkgnd';
an{na}.fun = @attmap_v1_musician_bkgnd;
an{na}.params = globals;
an{na}.params.ensemble = globals.ensemble;
an{na}.params.mysql = globals.mysql;
an{na}.params.training_thresh = 3; % years training >= 3 considered musician
an{na}.requires = {struct('name','expinfo','vars','response_data'),...
    struct('name','listener_bkgnd')};

% Combine musician_bkgnd with sMESS and STOMP
na = na+1; %8
an{na}.name = 'sMESS_STOMP_musicianBkgnd';
an{na}.fun = @ensemble_combine_datastructs;
an{na}.requires = {struct('name','sMESS_STOMP'), struct('name','musician_bkgnd')};

% Combine listener background with sMESS, STOMP, and musician bkgnd
na = na+1; %9
an{na}.name = 'sMESS_STOMP_musicianBkgnd_listenerBkgnd';
an{na}.fun = @ensemble_combine_datastructs;
an{na}.requires = {struct('name','sMESS_STOMP_musicianBkgnd'), struct('name','listener_bkgnd')};

return
