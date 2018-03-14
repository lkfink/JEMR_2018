function DIST = getSimilarity(data1, data2, TYPE)

% Quick and dirty function to get similarity between two cell arrays of data
% Input:
% - Two data arrays. Data arrays must be same length
% - Type of similarity calculation to perform: dtw or corrcoef
% 
% Output:
% - Disimilarity Matrix containing either Euclidean distances or
% correlation coefficients, depending on type input

% LF - 20180202
DIST = zeros(5,5);

if strcmp(TYPE, 'dtw')
    
    for i = 1:length(data1)
        for j = 1:length(data1)
            DIST(i, j) = dtw(data1{i},data2{j});
        end
    end
    
elseif strcmp(TYPE, 'corrcoef')
    
    for i = 1:length(data1)
        for j = 1:length(data1)
             r = corrcoef(data1{i},data2{j});
             DIST(i, j) = r(2); % take second val because first is 0 of identity matrix
        end
    end
    
else
error('Unrecognized type')    

end