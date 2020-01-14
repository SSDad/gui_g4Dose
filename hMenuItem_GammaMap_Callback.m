function hMenuItem_GammaMap_Callback(src, evnt)

hFig_main = ancestor(src, 'Figure');
data_main = guidata(hFig_main);

% gamma
dose_vol_1 = data_main.tps.Dose;
dose_vol_2 = data_main.G4.iDose;
voxel_sizes(1) = data_main.xxTPSDose(2) - data_main.xxTPSDose(1);
voxel_sizes(2) = data_main.yyTPSDose(2) - data_main.yyTPSDose(1);
voxel_sizes(3) = data_main.zzTPSDose(2) - data_main.zzTPSDose(1);

str1 = data_main.hpp.GMP(1).String;
idx1 = data_main.hpp.GMP(1).Value;
gamma_dist = str2num(str1{idx1});
str2 = data_main.hpp.GMP(2).String;
idx2 = data_main.hpp.GMP(2).Value;
gamma_percentage = str2num(str2{idx2});
% gamma_percentage = 5;

[data_main.pp, data_main.gm, ~, ~] = gamma3D_general(dose_vol_1,dose_vol_2,voxel_sizes,gamma_dist,gamma_percentage);

data_main.GammaMap = true;
data_main.hText.pp.String = ['Gamma Pass Percentage: ', num2str(data_main.pp), '%'];
data_main.hText.pp.Visible = 'on';

% save data
guidata(hFig_main, data_main);

initTPSDoseImages(hFig_main);
updateXImages(hFig_main, 'G4Dose');
updateXImages(hFig_main, 'DoseDiff');
updateXImages(hFig_main, 'GammaMapFail');