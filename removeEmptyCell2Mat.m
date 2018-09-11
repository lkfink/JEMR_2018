% Lauren Fink (lkfink@ucdavis.edu)
% Janata Lab, UC Davis Center for Mind & Brain

function outputMat = removeEmptyCell2Mat(inputCell) 
% Function specific to fft data for attmap_eyes project
% will remove any data from cell array that is not the required length
% to shorten data, rather than remove, see shortenCell2Mat.m
% LF -20180129



% Get shortest length of all cells in input data, excluding empty

sizes = cellfun(@size, inputCell, 'UniformOutput', 0);
sizes = cell2mat(sizes);
lengths = unique(sizes);
mask = logical(lengths > 1);
lengths = lengths(mask);
minlen = min(lengths);

% Loop through all cells 
for irow = 1:length(inputCell)
    if isempty(inputCell{irow})
        continue
    elseif length(inputCell{irow}) > minlen
        inputCell{irow} = []; % remove this row because we need all data to be on same freq bin scale
    else
    end
end

% Remove empty rows
inputCell(cellfun('isempty',inputCell)) = [];

% Convert to mat
outputMat = cell2mat(inputCell);
    
    
        


end