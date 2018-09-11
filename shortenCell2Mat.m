% Lauren Fink (lkfink@ucdavis.edu)
% Janata Lab, UC Davis Center for Mind & Brain

function outputMat = shortenCell2Mat(inputCell) 
% LF - 20180202
% Quick function to make all rows of cell array the same size by removing
% samples at the end of any given cell to equal the length of the shortest
% cell in the cell array. After this process, the cell is converted to a
% matrix. 


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
        inputCell{irow} = inputCell{irow}(1:minlen); % make this data same length as smallest data
    else
    end
end

% Remove empty rows
inputCell(cellfun('isempty',inputCell)) = [];

% Convert to mat
outputMat = cell2mat(inputCell);
    
    
        


end