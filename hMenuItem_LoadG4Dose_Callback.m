function hMenuItem_LoadG4Dose_Callback(src, evnt)
hFig_main = ancestor(src, 'Figure');
data_main = guidata(hFig_main);
ctInfo = data_main.tps.ctInfo;

rrfd = fullfile(data_main.ptfd, 'G4Dose');

% read from g4 dose file
[g4DoseFile, pth] = uigetfile(fullfile(rrfd, '*.csv'));
ffn = fullfile(pth, g4DoseFile);

g4DoseDataFileList = fullfile(data_main.matfd, 'g4DoseFileList.mat');
if exist(g4DoseDataFileList, 'file')
    load(g4DoseDataFileList);
    idx = find(contains(g4DoseFileList, g4DoseFile));
    if ~isempty(idx)
        g4DoseDataFile = fullfile(data_main.matfd, ['g4Dose_', num2str(idx)]);
        load(g4DoseDataFile);
    else
        idx = length(g4DoseFileList)+1;
        g4DoseFileList(idx) = string(g4DoseFile);
        save(g4DoseDataFileList, 'g4DoseFileList');

        g4csvDose = readtable(ffn);
        g4Dose = table2array(g4csvDose);
        g4DoseCol = single(g4Dose(:, 4));

        g4DoseDataFile = fullfile(data_main.matfd, ['g4Dose_', num2str(idx)]); 
        save(g4DoseDataFile, 'g4DoseCol');
    end
else
    g4DoseFileList(1) = string(g4DoseFile);
    save(g4DoseDataFileList, 'g4DoseFileList');

    g4csvDose = readtable(ffn);
    g4Dose = table2array(g4csvDose);
    g4DoseCol = single(g4Dose(:, 4));

    g4DoseDataFile = fullfile(data_main.matfd, 'g4Dose_1'); 
    save(g4DoseDataFile, 'g4DoseCol');
end
    
data_main.g4DoseCol = g4DoseCol/max(g4DoseCol(:));
downSampling = 4;
if contains(g4DoseFile, '1to2')
    downSampling = 2;
elseif contains(g4DoseFile, '1to1')
    downSampling = 1;
end
data_main.G4.downSampling = downSampling;

data_main.G4DoseLoaded = true;
data_main.hMenuItem.ViewG4Dose.Enable = 'on';
data_main.hMenuItem.Param.Enable = 'on';

%%
guidata(hFig_main, data_main);