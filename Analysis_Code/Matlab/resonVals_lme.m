% Lauren Fink (lkfink@ucdavis.edu)
% Janata Lab, UC Davis Center for Mind & Brain

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

