function hMenuItem_LoadCTImages_Callback(src, evnt)

hFig_main = ancestor(src, 'Figure');
data_main = guidata(hFig_main);

machine = computer;
if strcmp(machine, 'MACI64')
    testfd = '/Users/dad/Box Sync/Virtual Linac Project for Halcyon/Ruirui/ClinicalPlan';
else
     testfd = 'C:\Users\liuru\Box\Virtual Linac Project for Halcyon\Ruirui\ClinicalPlan';
end
matfd = uigetdir(testfd);

if ~isempty(matfd)
    data_main.matfd = matfd;
    [ptfd, ~] = fileparts(matfd);
    
    % CT
    fn_matCT = fullfile(matfd, 'CT.mat');
    load(fn_matCT)
    data_main.tps.CT = single(CT);
    fn_ctInfo = fullfile(matfd, 'ctInfo.mat');
    load(fn_ctInfo)
    data_main.tps.ctInfo = ctInfo;

    % iso
    fn_iso = fullfile(matfd, 'planInfo.mat');
    load(fn_iso);
    data_main.tps.iso = iso;
    
    data_main.ptfd = ptfd;
    data_main.hMenuItem.LoadTPSDose.Enable = 'on';
    data_main.CTImagesLoaded = true;

    guidata(hFig_main, data_main);

    initCTImages(hFig_main);
end