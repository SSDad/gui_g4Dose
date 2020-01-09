function initCTImages(hFig_main)

data_main = guidata(hFig_main);
ctInfo = data_main.tps.ctInfo;
hPlotObj = data_main.hPlotObj;
hText = data_main.hText;
hAxis = data_main.hAxis;

data_main.xx = ctInfo.xx-data_main.tps.iso(1);
data_main.yy = ctInfo.yy-data_main.tps.iso(2);
data_main.zz = ctInfo.zz-data_main.tps.iso(3);

data_main.x = 0;
data_main.y = 0;
data_main.z = 0;

guidata(hFig_main, data_main);

%% CT
hAxis = data_main.hAxis;
for r = 1:3
    for c = 1:4
%         hAxis.ct(r, c).Position = [0 0 1 1];
    end
end

%updateCTImages(hFig_main)
updateXImages(hFig_main, 'CT')
initSlider(hFig_main);
updateXLines(hFig_main);

guidata(hFig_main, data_main);