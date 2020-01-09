function updateXLines(hFig_main)

data_main = guidata(hFig_main);
hPlotObj = data_main.hPlotObj;
hAxis = data_main.hAxis;

x = data_main.x;
y = data_main.y;
z = data_main.z;

xx = data_main.xx;
yy = data_main.yy;
zz = data_main.zz;

for c = 1:3
    % z 
    hPlotObj.xLine(2,c).XData = [yy(1) yy(end)];
    hPlotObj.xLine(2,c).YData = [z z];
    hPlotObj.xLine(2,c).Color = 'b';
    
    hPlotObj.xLine(3,c).XData = [xx(1) xx(end)];
    hPlotObj.xLine(3,c).YData = [z z];
    hPlotObj.xLine(3,c).Color = 'b';

    % x 
    hPlotObj.yLine(1,c).XData = [x x];
    hPlotObj.yLine(1,c).YData = [yy(1) yy(end)];
    hPlotObj.yLine(1,c).Color = 'r';

    hPlotObj.yLine(3,c).XData = [x x];
    hPlotObj.yLine(3,c).YData = [zz(1) zz(end)];
    hPlotObj.yLine(3,c).Color = 'r';
    
    % y 
    hPlotObj.xLine(1,c).XData = [xx(1) xx(end)];
    hPlotObj.xLine(1,c).YData = [y y];
    hPlotObj.xLine(1,c).Color = 'g';

    hPlotObj.yLine(2,c).XData = [y y];
    hPlotObj.yLine(2,c).YData = [zz(1) zz(end)];
    hPlotObj.yLine(2,c).Color = 'g';
end