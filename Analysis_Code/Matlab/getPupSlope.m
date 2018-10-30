% Lauren Fink
% Janata Lab, UC Davis Center for Mind & Brain
% First created: 20180123
% Last edited: 20180123

% Function to calculate slope of pupil signal from beginning of signal to
% max value found in signal


% Input: 
% - Pupil data to find slope of

% Output:
% - Slope of line from beginning of pupil data to max value in pupil data

function slope = getPupSlope(data)

maxPup = max(data);
maxInd = find(data == maxPup);

x = 1:maxInd;
y = data(1:maxInd);
p = polyfit(x, y, 1);
slope = p(1);
f = polyval(p,x);

% To plot use
% plot(x,y,'o',x,f,'-')
% legend('data','linear fit')

end
