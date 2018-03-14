% LF - 20170729
% quick script to get reson_out vals into tables of interest for use in
% mixed effects models
params = attmap_eyes_globals;

% Load PDF.mat and pupDbTbl and probeTable.mat
fpath = params.paths.matpath;
fstub = 'pupDbTbl.mat';
fname = fullfile(fpath, fstub);
load(fname);
fstub = 'PDF.mat';
fname = fullfile(fpath, fstub);
load(fname);
fstub = 'probeTable.mat';
fname = fullfile(fpath, fstub);
load(fname);


% table for looking up reson output values corresponding to probe ids
% NOTE: will need to mask by stim id as well because probe ids are not
% all unique
prres = table;
prres.stimulus_id = PDF.stimulus_id;
prres.dev_label = PDF.dev_label;
prres.reson_out = PDF.modelVal;

tmp = ones(length(pupDbTbl.subject_id), 1);
% Loop through pupDbTBl and add model vals to each row
stims = unique(pupDbTbl.stimulus_id);
for istim = 1:length(stims)
    currstim = stims(istim);
    stimmask = strcmp(pupDbTbl.stimulus_id, currstim);
    stimmask2 = strcmp(prres.stimulus_id, currstim);
    
    devs = unique(pupDbTbl.probe_time(stimmask));
    for idev = 1:length(devs)
        currdev = devs(idev);
        devmask = strcmp(pupDbTbl.probe_time, currdev);
        devmask2 = strcmp(prres.dev_label, currdev);
        
        compmask = stimmask & devmask;
        compmask2 = stimmask2 & devmask2;
        
        resonVal = prres.reson_out(compmask2);
        tmp(compmask) = resonVal;
        
        
    end % dev 
    
    
end % stim
pupDbTbl.reson_out = tmp;

writetable(pupDbTbl, 'pupDbTbl.csv')

%TODO 
% get better pupil metric (baseline then avg)
% take avg for each sub such that have 20 rows for each sub (one for each
% dev.. or now it would be 16 since not using one stim).


% % Now do this for probe table
% tmp = ones(length(pt.sub_id), 1);
% ds = pt;
% 
% % remove prA_4 stim data
% mask = strcmp(ds.stim_id, 'prA_4_3i_1v_107bpm');
% idxs = find(mask == 1);
% ds(idxs, :) = [];
% 
% % Loop through pupDbTBl and add model vals to each row
% stims = unique(ds.stim_id); 
% 
% for istim = 1:length(stims)
%     currstim = stims(istim);
%     currstim = strcat(currstim, '.wav');
%     stimmask = strcmp(ds.stim_id, currstim);
%     stimmask2 = strcmp(prres.stimulus_id, currstim);
%     stimmask3 = strcmp(params.stim_probeIds, currstim);
%     idx = find(stimmask3 == 1);
%     
%     devs = params.stim_probeIds{idx, 2};
%     
%     for idev = 1:length(devs)
%         currdev = devs(idev);
%         devmask = strcmp(ds.probe_id, currdev); % FIX - UGH what are these entered as????? (not string cell like usual)
%         devmask2 = strcmp(prres.dev_label, currdev);
%         
%         compmask = stimmask & devmask;
%         compmask2 = stimmask2 & devmask2;
%         
%         resonVal = prres.reson_out(compmask2);
%         tmp(compmask) = resonVal;
%         
%         
%     end % dev 
%     
%     
% end % stim
% ds.reson_out = tmp;
% 
% writetable(pupDbTbl, 'pupDbTbl.csv')