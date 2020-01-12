function hMenuItem_LoadTPSDose_Callback(src, evnt)

hFig_main = ancestor(src, 'Figure');
data_main = guidata(hFig_main);

dosefd = fullfile(data_main.ptfd, 'mat');

if ~isempty(dosefd)
    fn_Dose = fullfile(dosefd, 'Dose.mat');
    fn_dsInfo = fullfile(dosefd, 'dsInfo.mat');

    %% dose
    load(fn_Dose);
    Dose = squeeze(single(Dose));
        
    load(fn_dsInfo);
    
    % zCut
    zct1 = data_main.tps.ctInfo.zz(1);
    zct2 = data_main.tps.ctInfo.zz(end);
    zds1 = dsInfo.zz(1);
    zds2 = dsInfo.zz(end);
    
    idx1 = 1;
    idx2 = length(dsInfo.zz);
    if zct1 >  zds1
        [v1, idx1] = min(abs(dsInfo.zz-zct1));
        idx1 = idx1+1;
    end
    if zct2 < zds2
        [v2, idx2] = min(abs(dsInfo.zz-zct2));
        idx2 = idx2-1;
    end
    
    Dose = Dose(:,:,idx1:idx2);
    dsInfo.zz = dsInfo.zz(idx1:idx2);
    
    % save    
    data_main.tps.Dose = Dose/max(Dose(:));
   
    data_main.tps.dsInfo = dsInfo;
    data_main.tps.dsRes = [dsInfo.dx dsInfo.dy dsInfo.zOS(2)-dsInfo.zOS(1)];            

    data_main.TPSDoseLoaded = true;
    data_main.hMenuItem.LoadG4Dose.Enable = 'on';

     %%
    guidata(hFig_main, data_main);

    %%
    initTPSDoseImages(hFig_main);

end