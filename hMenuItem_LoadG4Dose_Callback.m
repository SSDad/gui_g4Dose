function hMenuItem_LoadG4Dose_Callback(src, evnt)
hFig_main = ancestor(src, 'Figure');
data_main = guidata(hFig_main);
ctInfo = data_main.tps.ctInfo;

% dicomDoseFile = readtable('averagedDose_ninefield_1to2_100m.csv');
% machine = computer;
% if strcmp(machine, 'MACI64')
%     rrfd = '/Users/dad/Box Sync/Virtual Linac Project for Halcyon/Ruirui/ResultAnalysis';
% else
% %     rrfd = 'C:\Users\zji\Box\Virtual Linac Project for Halcyon\Ruirui\ResultAnalysis';
% %     rrfd = 'C:\Users\liuru\Box\Virtual Linac Project for Halcyon\Ruirui\ResultAnalysis';
%    rrfd = 'C:\Users\zhen_\Box Sync\Virtual Linac Project for Halcyon\Ruirui\ResultAnalysis';
% end

rrfd = fullfile(data_main.ptfd, 'G4Dose');

% read from g4 dose file
[g4DoseFile, pth] = uigetfile(fullfile(rrfd, '*.csv'));
ffn = fullfile(pth, g4DoseFile);
g4csvDose = readtable(ffn);
g4Dose = table2array(g4csvDose);
g4DoseCol = g4Dose(:, 4);
data_main.g4DoseCol = single(g4DoseCol/max(g4DoseCol(:)));

downSampling = 4;
if contains(g4DoseFile, '1to2')
    downSampling = 2;
elseif contains(g4DoseFile, '1to1')
    downSampling = 1;
end
data_main.G4.downSampling = downSampling;

data_main.G4DoseLoaded = true;
data_main.hMenuItem.ViewG4Dose.Enable = 'on';

%%
guidata(hFig_main, data_main);