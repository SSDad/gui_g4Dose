function hMenuItem_LoadCTImages_Callback(src, evnt)

hFig_main = ancestor(src, 'Figure');
data_main = guidata(hFig_main);

machine = computer;
if strcmp(machine, 'MACI64')
    testfd = '/Users/dad/Box Sync/Virtual Linac Project for Halcyon/Ruirui/ClinicalPlan';
else
     testfd = 'C:\Users\liuru\Box\Virtual Linac Project for Halcyon\Ruirui\ClinicalPlan';
%      testfd = 'C:\Users\zji\Box\Virtual Linac Project for Halcyon\TestPlans';
%    matfd = 'C:\Users\zhen_\Box Sync\Virtual Linac Project for Halcyon\TestPlans\matlabData';
end
ptfd = uigetdir(testfd);
%matfd = 'mat_square_zCut50';
matfd = 'mat';
data_main.ctFolder = matfd;

if ~isempty(ptfd)
%     [ptfd, data_main.planID] = fileparts(planfd);
%     [~, data_main.ptID] = fileparts(ptfd);
    
    % CT
    fn_matCT = fullfile(ptfd, matfd, 'CT.mat');
    load(fn_matCT)
    data_main.tps.CT = single(CT);
    fn_ctInfo = fullfile(ptfd, matfd, 'ctInfo.mat');
    load(fn_ctInfo)
    data_main.tps.ctInfo = ctInfo;

    % iso
    fn_iso = fullfile(ptfd, matfd, 'planInfo.mat');
    load(fn_iso);
    data_main.tps.iso = iso;
    
    data_main.ptfd = ptfd;
%     data_main.planfd = planfd;
    data_main.hMenuItem.LoadTPSDose.Enable = 'on';
    data_main.CTImagesLoaded = true;

    guidata(hFig_main, data_main);

    initCTImages(hFig_main);
end