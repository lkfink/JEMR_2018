function globals = attmap_eyes_globals

% attmap_eyes_globals.m
% parameters for attmap_eyes experiment
%
% 29May2015 - adapted from attmap_globals

globals.experiment_name = 'attmap_v1p2_eyetrack';

% Paths to add
addpath(path,'/Users/matrpcuser/svn/thirdparty/matlab');
javaaddpath('/Users/matrpcuser/svn/thirdparty/matlab/miditoolbox/');
addpath(path,genpath('/Users/matrpcuser/svn/thirdparty/matlab/plot'));
addpath(path,'/Users/finklk/svn/private/matlab/jlmt/plots'); 
addpath(path,'/Users/finklk/svn/private/matlab/jlmt'); 

% file paths
globals.paths.project_root = fullfile('/data1/attmap/', globals.experiment_name);
globals.paths.data_path = fullfile(globals.paths.project_root,'data');
globals.paths.analysis_path = fullfile(globals.paths.project_root,'analyses');
globals.paths.fig_path = fullfile(globals.paths.project_root,'figures');
globals.paths.matpath = fullfile(globals.paths.project_root,'matfiles');
globals.paths.vdc_stim_path = '/data1/stimuli/audio/vdc/'; 
globals.paths.maxdata_path = fullfile(globals.paths.project_root,'MaxOutput'); %changed this
globals.paths.stim_path = '/data0/stimuli/audio/attmap';
globals.paths.stim_rp_plotPath = fullfile(globals.paths.fig_path,'stim_rp');
globals.paths.rp_behave_plotPath = fullfile(globals.paths.fig_path,'rp_behave');
globals.paths.expanded_stim_path = fullfile(globals.paths.stim_path,'rp_expanded');
globals.paths.tablepath = fullfile(globals.paths.project_root,'tables');
globals.paths.rp_analysis = fullfile(globals.paths.matpath, 'attmap_v1p2_stim_rp_analysis.mat');
% globals.paths.vdc_preproc_stim_path = fullfile(globals.paths.stim_path,'preprocessed');


%% specify stimuli

globals.stimnames = {
    'prA_4_3i_1v_107bpm.wav',...   
    'prA_74_3i_1v_107bpm.wav',...    
    'prC_54_3i_1v_107bpm.wav',...
    'prC_74_3i_1v_107bpm.wav',...
    'prC_124_3i_1v_107bpm.wav',...      
    };

globals.stimnames2 = {
    'prC_74_3i_1v_107bpm',...
    'prA_74_3i_1v_107bpm',... 
    'prC_54_3i_1v_107bpm',...
    'prA_4_3i_1v_107bpm',...   
    'prC_124_3i_1v_107bpm',... 
    };


globals.plot_stimnames = cell(5,2);
globals.plot_stimnames(:,1) = globals.stimnames2;
%globals.plot_stimnames(:,2) = {'complex4'; 'complex2'; 'complex3'; 'complex1'; 'complex5'};
globals.plot_stimnames(:,2) = {'complex1'; 'complex2'; 'complex3'; 'complex4'; 'complex5'};

globals.stim_dur = {
    'prA_4_3i_1v_107bpm.wav',2.240;...
    'prA_74_3i_1v_107bpm.wav',2.234;...
    'prC_54_3i_1v_107bpm.wav',2.248;...
    'prC_74_3i_1v_107bpm.wav',2.229;...
    'prC_124_3i_1v_107bpm.wav',2.240;...
    };

globals.stim_probetimes = {
'prA_4_3i_1v_107bpm.wav', [263 820 1250 2086];...
'prA_74_3i_1v_107bpm.wav', [263 542 973 1807];...
'prC_54_3i_1v_107bpm.wav', [123 541 1111 1947];...
'prC_74_3i_1v_107bpm.wav', [124 542 961 1795];...
'prC_124_3i_1v_107bpm.wav', [0 404 1099 1530];...
};


globals.stim_probeIds = {
'prA_4_3i_1v_107bpm.wav', {'dev_low_263', 'dev_hi_820', 'dev_low_1250', 'dev_hi_2086','dev_hi_2086;loop'};...
'prA_74_3i_1v_107bpm.wav', {'dev_low_263','dev_hi_542', 'dev_low_973', 'dev_hi_1807'};...
'prC_54_3i_1v_107bpm.wav', {'dev_low_123', 'dev_low_541', 'dev_hi_1111', 'dev_hi_1947'};...
'prC_74_3i_1v_107bpm.wav', {'dev_low_124', 'dev_hi_542', 'dev_low_961', 'dev_hi_1795'};...
'prC_124_3i_1v_107bpm.wav', {'dev_hi_0', 'dev_low_404', 'dev_hi_1099', 'dev_low_1530'};...
};

globals.stim_probe_convert = {
    'dev_low_263', {263};...
    'dev_hi_820',  {820};...
    'dev_low_1250', {1250};...
    'dev_hi_2086', {2086};...
    'dev_hi_2086;loop', {2086};...
    'dev_low_263', {263};...
    'dev_hi_542', {542};...
    'dev_low_973', {973};...
    'dev_hi_1807', {1807};...
    'dev_low_123', {123};...
    'dev_low_541', {541};...
    'dev_hi_1111', {1111};...
    'dev_hi_1947', {1947};...
    'dev_low_124', {124};...
    'dev_hi_542', {542};...
    'dev_low_961', {961};...
    'dev_hi_1795', {1795};...
    'dev_hi_0', {0};...
    'dev_low_404', {404};...
    'dev_hi_1099', {1099};...
    'dev_low_1530', {1530};...
};

%% Stimulus - based models

% Event Density - should this be by timbre? or do we just care about
% overall density?
globals.stim_density = {
'prA_4_3i_1v_107bpm.wav', [2,1,2,0,2,2,0,1,2,1,2,0,0,2,1,2];...
'prA_74_3i_1v_107bpm.wav', [2,1,2,0,2,2,0,1,2,1,2,0,0,2,1,2];...
'prC_54_3i_1v_107bpm.wav', [2,1,0,2,2,0,2,1,2,1,0,2,0,2,2,1];...
'prC_74_3i_1v_107bpm.wav', [2,2,0,1,2,0,2,1,2,2,0,1,0,2,1,2];...
'prC_124_3i_1v_107bpm.wav', [2,2,0,1,2,1,2,0,2,2,0,1,0,2,1,2];...
};

% Meter
globals.stim_meter = [4,1,2,1,3,1,2,1,4,1,2,1,3,1,2,1]; % same for all stim (because all in 4/4)!

% Event Density + Meter
globals.stim_dense_meter{:,1} = globals.stim_density{:,1};
for i = 1:length(globals.stim_density)
    currDensity = globals.stim_density{i,2};
    globals.stim_dense_meter{i,1} = globals.stim_density{i,1};
    globals.stim_dense_meter{i,2} = currDensity+globals.stim_meter;
    
end %stim
%% Eyetracker params
globals.eyetracker.messages.null = {'.'};
globals.eyetracker.messages.loop_start = {'loop','dev_hi_2086;loop','loop;miss'};

globals.eyetracker.messages.dev_hi = {'dev_hi_0','dev_hi_1099','dev_hi_1111','dev_hi_1795', ...
    'dev_hi_1807','dev_hi_1947','dev_hi_2086','dev_hi_2086;loop','dev_hi_542','dev_hi_820'};

globals.eyetracker.messages.dev_low = {'dev_low_123','dev_low_124','dev_low_1250', ...
    'dev_low_1530','dev_low_263','dev_low_404','dev_low_541','dev_low_961','dev_low_973'};

globals.eyetracker.messages.probe_id = {'dev_hi_0','dev_hi_1099','dev_hi_1111','dev_hi_1795', ...
    'dev_hi_1807','dev_hi_1947','dev_hi_2086','dev_hi_2086;loop','dev_hi_542','dev_hi_820', ...
    'dev_low_123','dev_low_124','dev_low_1250','dev_low_1530','dev_low_263','dev_low_404', ...
    'dev_low_541','dev_low_961','dev_low_973'};

% 'dev_hi_0'
% 'dev_hi_1099'
% 'dev_hi_1111'
% 'dev_hi_1795'
% 'dev_hi_1807'
% 'dev_hi_1947'
% 'dev_hi_2086'
% 'dev_hi_2086;loop'
% 'dev_hi_542'
% 'dev_hi_820'
% 'dev_low_123'
% 'dev_low_124'
% 'dev_low_1250'
% 'dev_low_1530'
% 'dev_low_263'
% 'dev_low_404'
% 'dev_low_541'
% 'dev_low_961'
% 'dev_low_973'


globals.eyetracker.messages.hit = {'hit'};
globals.eyetracker.messages.miss = {'miss';'loop;miss'};
globals.eyetracker.nsamps_preloop = 0;
globals.eyetracker.nsamps_postloop = 0;
globals.eyetracker.Fs = 500;


%% Blink params

%% Ensemble params

% expt specific params
globals.filename = mfilename;
globals.attrib_names = {};
globals.resptbl_name = sprintf('response_%s', globals.experiment_name);

% filter 
globals.filt.exclude.any.subject_id = {'^04ttf.*','^01ttf.*'};
globals.export.by_subject.response_table = 1;
% 
% % database connectivity
% 
% mysql params TOT: uncomment this (something weird after new migration)
% [null,user] = unix('whoami');
% if ~ismember(deblank(user),{'bkhurley','petr','finklk'})                       
%     globals.mysql.login_type = 'subject';
% else
%     globals.mysql.login_type = 'researcher';
% end
% 
% % % log into Ensemble
% % 
% % mysql/ensemble defs
% globals.mysql = mysql_login(globals.mysql);
% globals.mysql.conn_id = mysql_make_conn(globals.mysql); %this line not working
% globals.ensemble = globals.mysql; %comment
% globals.ensemble.experiment_title = globals.experiment_name;
% globals.ensemble.filt = globals.filt;
% % 
% % % form name definitions
% [form_id_const, form_name_id_const_map, form_name_list] = make_form_name_defs(globals);
% globals.ensemble.form_defs.form_id_const = form_id_const;
% globals.ensemble.form_defs.form_name_id_const_map = form_name_id_const_map;
% globals.ensemble.form_defs.form_name_list = form_name_list;

%% stim RP params
% globals.stimIPEMParams.ensemble = globals.ensemble;
globals.stimIPEMParams.paths.stimulus_root = '/data0/stimuli';
globals.stimIPEMParams.paths.destroot = '/data0/stimuli'; 
globals.stimIPEMParams.paths.stimulus_ipem_analysis_root = '/data0/stimuli';
globals.stimIPEMParams.glob.process = {'ani','rp'};
globals.stimIPEMParams.glob.force_recalc = {};
globals.stimIPEMParams.glob.save_calc = {'ani','rp'};
globals.stimIPEMParams.glob.outputType = 'filepath';
%globals.stimIPEMParams.ani = ani_paramGroups; %% 2017a matlab throwing
%error on this 20180129
% globals.stimIPEMParams.rp =  rp_paramGroups_v2('input_type','ani',...
%     'gain_type','beta_distribution',...
%     'param_group','reson_filterQSpacing_periodBasedDecay');

% set parameters to calculate complex reson output,
% interpolated MPP, and temporal expectancy calculations
globals.stimIPEMParams.rp.perform.calcOnsetInfo = 1;
globals.stimIPEMParams.rp.perform.calcComplexExpectAtOnsets = 1;
globals.stimIPEMParams.rp.perform.interpMPP = 1;
globals.stimIPEMParams.rp.perform.calcVonMises = 1;
globals.stimIPEMParams.rp.perform.calcPhaseCoherence = 1;
globals.stimIPEMParams.rp.perform.calcMPPByFrame = 1;

globals.glob.matVarName = 'eyeblink_vector';

end
