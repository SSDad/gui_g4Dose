function initTPSDoseImages(hFig_main)

data_main = guidata(hFig_main);
hAxis = data_main.hAxis;
iso = data_main.tps.iso;

dsInfo = data_main.tps.dsInfo;
data_main.xxTPSDose = dsInfo.xx-iso(1);
data_main.yyTPSDose = dsInfo.yy-iso(2);
data_main.zzTPSDose = dsInfo.zz-iso(3);

guidata(hFig_main, data_main);

%% Dose
for r = 1:3
%     for c = 1:4
        linkprop([hAxis.ct(r, :), hAxis.dose(r, :)], 'Position');
        linkaxes([hAxis.ct(r, :), hAxis.dose(r, :)]);
%     end
end

initCTImages(hFig_main);
updateXImages(hFig_main, 'TPSDose');

% %%
% iniSlider(hFig_main);
% updateXLine(hFig_main);

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

%guidata(hFig_main, data_main);