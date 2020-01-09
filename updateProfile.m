function updateProfile(hFig_main)

data_main = guidata(hFig_main);
hPlotObj = data_main.Profile.hPlotObj;
hAxis = data_main.Profile.hAxis;

xx = data_main.xxTPSDose;
yy = data_main.yyTPSDose;
zz = data_main.zzTPSDose;
[xg, yg, zg] = meshgrid(xx, yy, zz);

% % dose
% for n = 1:3
%     sV = data_main.hSlider.D1dX.Value;
%     x = xx(sV);
%     data_main.hPlotObj.xLineY(n).XData = [x x];
% 
%     sV = data_main.hSlider.D1dY.Value;
%     y = yy(sV);
%     data_main.hPlotObj.xLineX(n).YData = [y y];
% 
% end
% sV = data_main.hSlider.CT.Value;
% z = zz(sV);
% data_main.hPlotObj.xLineZ.XData = x;
% data_main.hPlotObj.xLineZ.YData = y;
% 
% % XLine

% 1 - tps, 2 - G4
DD{1} = data_main.tps.Dose;
DD{2} = data_main.G4.iDose;

x = data_main.x;
y = data_main.y;
z = data_main.z;

% x
[xg1d, yg1d, zg1d] = meshgrid(xx, y, z);
pdd{1, 1} = interp3(xg, yg, zg, DD{1}, xg1d, yg1d, zg1d);
pdd{1, 2} = interp3(xg, yg, zg, DD{2}, xg1d, yg1d, zg1d);

set(hPlotObj.prof(1).red, 'xdata', xx, 'ydata', pdd{1, 1})
set(hPlotObj.prof(1).green, 'xdata', xx, 'ydata', pdd{1, 2})
set(hPlotObj.prof(1).diff, 'xdata', xx, 'ydata', flip(pdd{1, 2})-flip(pdd{1, 1}))

% y
[xg1d, yg1d, zg1d] = meshgrid(x, yy, z);
pdd{2, 1} = interp3(xg, yg, zg, DD{1}, xg1d, yg1d, zg1d);
pdd{2, 2} = interp3(xg, yg, zg, DD{2}, xg1d, yg1d, zg1d);

% set(hPlotObj.prof(2).red, 'xdata', -yy, 'ydata', flip(pdd{2,1}))
% set(hPlotObj.prof(2).green, 'xdata', -yy, 'ydata', flip(pdd{2,2}))
% set(hPlotObj.prof(2).diff, 'xdata', -yy, 'ydata', flip(pdd{2,2})-flip(pdd{2,1}))
set(hPlotObj.prof(2).red, 'xdata', yy, 'ydata', (pdd{2,1}))
set(hPlotObj.prof(2).green, 'xdata', yy, 'ydata', (pdd{2,2}))
set(hPlotObj.prof(2).diff, 'xdata', yy, 'ydata', (pdd{2,2})-(pdd{2,1}))

% z
[xg1d, yg1d, zg1d] = meshgrid(x, y, zz);
pdd{3,1} = interp3(xg, yg, zg, DD{1}, xg1d, yg1d, zg1d);
pdd{3,2} = interp3(xg, yg, zg, DD{2}, xg1d, yg1d, zg1d);

set(hPlotObj.prof(3).red, 'xdata', zz, 'ydata', pdd{3,1})
set(hPlotObj.prof(3).green, 'xdata', zz, 'ydata', pdd{3,2})
set(hPlotObj.prof(3).diff, 'xdata', zz, 'ydata', fliplr(pdd{3,1})-fliplr(pdd{3,2}))