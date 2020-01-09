function hMenuItem_gMap_Callback(src, evnt)

hFig_main = ancestor(src, 'Figure');
data_main = guidata(hFig_main);

if strcmp(data_main.hMenuItem.gMapAll.Checked, 'off') && strcmp(src.Label, 'All')
    data_main.hMenuItem.gMapAll.Checked = 'on';
    data_main.hMenuItem.gMapFail.Checked = 'off';
    data_main.hMenuItem.gMapPass.Checked = 'off';
end

if strcmp(data_main.hMenuItem.gMapFail.Checked, 'off')  && strcmp(src.Label, 'Fail')
    data_main.hMenuItem.gMapAll.Checked = 'off';
    data_main.hMenuItem.gMapFail.Checked = 'on';
    data_main.hMenuItem.gMapPass.Checked = 'off';
end

if strcmp(data_main.hMenuItem.gMapPass.Checked, 'off')  && strcmp(src.Label, 'Pass')
    data_main.hMenuItem.gMapAll.Checked = 'off';
    data_main.hMenuItem.gMapFail.Checked = 'off';
    data_main.hMenuItem.gMapPass.Checked = 'on';
end

updateGM(hFig_main)