function hMenuItem_Profile_Callback(src, evnt)

fH = findall(groot, 'Type', 'figure');
for n = 1:length(fH)
    if strcmp(fH(n).Name, 'Profile')
        figure(fH(n))
        return;
    end
end

hFig_main = ancestor(src, 'Figure');
data_main = guidata(hFig_main);

% if strcmp(data_main.hMenuItem.Profile.Checked, 'off')

%data_main.hMenuItem.Profile.Checked = 'on';

%% dose fig
hFig_Profile = figure('HandleVisibility',  'callback', ...
                    'Name',                'Profile', ...
                    'NumberTitle',      'off', ...
                    'Units',                 'normalized',...
                    'Position',             [0.1 0.1 0.4 0.8],...
                    'Color',                 'black', ...
                    'Visible',               'on');
%                 , ...
% 'MenuBar',            'none', ...
%                     'Toolbar',              'auto', ...
%                     'CloseRequestFcn', @fig1d_closereq);


%% panel, axis                
w(1:3) = 1;
h(1:3) = 1/3;

x0(1) = 0;
x0(2) = 0;
x0(3) = 0;

y0(1) = 1-h(1);
y0(2) = h(1);
y0(3) = 0;
                
tt{1} = 'X';
tt{2} = 'Y';
tt{3} = 'Z';
CLR = 'rgb'; 

for n = 1:3
    hPanel(n) = uipanel('Parent',                    hFig_Profile,...    
                                 'FontSize',                 12,...
                                'Units',                     'normalized', ...
                                'Position',                  [x0(n) y0(n) w(n) h(n)],...
                                            'Visible',                          'on',...
                                'ForegroundColor',       'white',...
                                'BackgroundColor',       'black', ...
                                'HighlightColor',          'black',...
                                'ShadowColor',            'black');

% dose                            
    hAxis(n) = axes('Parent',                   hPanel(n), ...
                                'color',        'none',...
                                'xcolor', 'w',...
                                'ycolor', 'w', ...
                                'gridcolor',   'w',...
                                'Units',                    'normalized', ...
                                'HandleVisibility',     'callback', ...
                                'Position',                 [0.05 0.1 0.9 0.85]);

                                
    hold(hAxis(n), 'on')
    hAxis(n).YLim = [-0.2 1.2];
    
    hPlotObj.prof(n).green = line(hAxis(n), 'XData', [], 'YData', [],  'Marker', 'o',  'MarkerSize', 6, 'Color', 'g', 'LineStyle', '-');
    hPlotObj.prof(n).red = line(hAxis(n), 'XData', [], 'YData', [],  'Marker', 'o',  'MarkerSize', 6, 'Color', 'r', 'LineStyle', '-');
    hPlotObj.prof(n).diff = line(hAxis(n), 'XData', [], 'YData', [],  'Marker', 'd',  'MarkerSize', 6, 'Color', 'w', 'LineStyle', '-');

    % title
    aT = hAxis(n).Title;
    aT.String = tt{n};
    aT.Color = CLR(n);
    aT.Position = [0.9 0.75 0];
    aT.Units = 'normalized';
end
data_main.Profile.hPlotObj = hPlotObj;
data_main.Profile.hAxis = hAxis;

data_main.ProfileFig = true;
guidata(hFig_main, data_main);

updateProfile(hFig_main);


% %% cross line 
% xxd = data_main.tps.dsInfo.xx;
% yyd = data_main.tps.dsInfo.yy;
% zzd = data_main.tps.dsInfo.ipp(3)+data_main.tps.dsInfo.zOS;
% 
% % 1d profile
% x = (xxd(1)+xxd(end))/2;
% y = (yyd(1)+yyd(end))/2;
% 
% for n = 1:3
% data_main.hPlotObj.xLineX(n).XData = [xxd(1) xxd(end)];
% data_main.hPlotObj.xLineX(n).YData = [y y];
% data_main.hPlotObj.xLineX(n).Visible = 'on';
% 
% data_main.hPlotObj.xLineY(n).XData = [x x];
% data_main.hPlotObj.xLineY(n).YData = [yyd(1) yyd(end)];
% data_main.hPlotObj.xLineY(n).Visible = 'on';
% end
% data_main.hPlotObj.xLineZ.XData = x;
% data_main.hPlotObj.xLineZ.YData = y;
% data_main.hPlotObj.xLineZ.Visible = 'on';
% 
% %% x y slider
% hSlider = data_main.hSlider;
% [~, sV] = min(abs(x-xxd));
% set(hSlider.D1dX, 'Min', 1, 'Max', length(xxd), 'SliderStep',...
%     [1 5]./(length(xxd)-1), 'Value', sV);
% 
% [~, sV] = min(abs(y-yyd));
% set(hSlider.D1dY, 'Min', 1, 'Max', length(yyd), 'SliderStep',...
%     [1 5]./(length(yyd)-1), 'Value', sV);
% 
% data_main.hPanel.slider.D1dX.Visible = 'on';
% data_main.hPanel.slider.D1dY.Visible = 'on';
% 
% %% save data
% data_main.Dose1d.x = x;
% data_main.Dose1d.y = y;
% 

% else
%     fH = findall(groot, 'Type', 'figure');
%     for n = 1:length(fH)
%         if strcmp(fH(n).Name, 'Profile')
%             close(fH(n));
%         end
%     end
%     
%     data_main.hMenuItem.p1d.Checked = 'off';
%     
%     for n = 1:3
%         data_main.hPlotObj.xLineX(n).XData = [];
%         data_main.hPlotObj.xLineX(n).YData = [];
% 
%         data_main.hPlotObj.xLineY(n).XData = [];
%         data_main.hPlotObj.xLineY(n).YData = [];
%     end
%     
%     data_main.hPlotObj.xLineZ.XData = [];
%     data_main.hPlotObj.xLineZ.YData = [];
% 
%     data_main.hPanel.slider.D1dX.Visible = 'off';
%     data_main.hPanel.slider.D1dY.Visible = 'off';
% 
% end
