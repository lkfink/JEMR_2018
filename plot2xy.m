function h = plot2xy(y1,y2)

% Plot x1, y1 in red
x1 = 1:length(y1);
line(x1, y1, 'Color','r')
ax1 = gca;
ax1.XColor = 'r';
ax1.YColor = 'r';
ax1_pos = ax1.Position; 

% Plot x2, y2 in black
ax2 = axes('Position',ax1_pos,...
    'XAxisLocation','top',...
    'YAxisLocation','right',...
    'Color','none');
x2 = 1:length(y2);
line(x2, y2, 'Parent',ax2,'Color','k')

% Return handle to axes
h = gcf;

end
