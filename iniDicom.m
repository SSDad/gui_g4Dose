function iniDicom(hFig_main)

data_main = guidata(hFig_main);
ctInfo = data_main.tps.ctInfo;
hPlotObj = data_main.hPlotObj;
hText = data_main.hText;
hAxis = data_main.hAxis;

data_main.x = (ctInfo.xx(1)+ctInfo.xx(end))/2;
data_main.y = (ctInfo.yy(1)+ctInfo.yy(end))/2;
data_main.z = (ctInfo.zz(1)+ctInfo.zz(end))/2;

data_main.xx = ctInfo.xx;
data_main.yy = ctInfo.yy;
data_main.zz = ctInfo.zz;

guidata(hFig_main, data_main);

%% CT
hAxis = data_main.hAxis;
for r = 1:3
    for c = 1:4
%         hAxis.ct(r, c).Position = [0 0 1 1];
    end
end

updateCTImage(hFig_main)

%%
iniSlider(hFig_main);
updateXLine(hFig_main);

%%
% data_main.hMenuItem.CreatePhantom.Enable = 'on';
% data_main.hMenuItem.CT.Enable = 'on';
% data_main.hMenuItem.dose.Enable = 'on';
% 
% data_main.hText.CT.Visible = 'on';
% data_main.hText.CTcm.Visible = 'on';
% data_main.hPanel.slider.CT.Visible = 'on';
% data_main.hPanel.slider.dose.Visible = 'on';
% 
% data_main.hPanel.param.Visible = 'on';
% data_main.hPanel.dd.Visible = 'on';

guidata(hFig_main, data_main);