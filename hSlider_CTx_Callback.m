function hSlider_CTx_Callback(src, evnt)

hFig_main = ancestor(src, 'Figure');
data_main = guidata(hFig_main);

sV = round(get(src, 'Value'));
src.Value = sV;

data_main.x = data_main.xx(sV);
guidata(hFig_main, data_main)

updateXImages(hFig_main, 'CT');
updateXLines(hFig_main);

if data_main.TPSDoseLoaded
    updateXImages(hFig_main, 'TPSDose');
end
if data_main.G4DoseLoaded
    updateXImages(hFig_main, 'G4Dose');
    updateXImages(hFig_main, 'DoseDiff');
end

if data_main.GammaMap
    updateXImages(hFig_main, 'GammaMapFail');
end

fH = findall(groot, 'Type', 'figure');
for n = 1:length(fH)
    if strcmp(fH(n).Name, 'Profile')
        updateProfile(hFig_main);
        break;
    end
end

% if strcmp(data_main.hMenuItem.LoadVLP.Checked, 'on')
%     updateCTvImage(hFig_main);
% end
% 
% if strcmp(data_main.hMenuItem.LoadVLD.Checked, 'on')
%     updateDoseVImage(hFig_main);
%     updateDoseDiff(hFig_main);
%     updateGM(hFig_main);
% end