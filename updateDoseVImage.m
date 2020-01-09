function updateDoseVImage(hFig_main)

data_main = guidata(hFig_main);
hPlotObj = data_main.hPlotObj;
hText = data_main.hText;
hAxis = data_main.hAxis;

CT = data_main.VL.DSi;
ctInfo = data_main.tps.dsInfo;
ctInfo.zz = ctInfo.ipp(3)+ctInfo.zOS;

CT = CT/max(CT(:));

minCT = min(CT(:));
maxCT = max(CT(:));
maxWindow = maxCT-minCT;
CLim(1) = minCT+maxWindow*0.;
CLim(2) = maxCT-maxWindow*0.;

%% z (My, Nx)
[~, zSlice] = min(abs(data_main.z-ctInfo.zz));
I = CT(:,:,zSlice);

    set(hPlotObj.dose(1, 2), 'XData', ctInfo.xx, 'YData', ctInfo.yy, 'CData', I);

    if diff(CLim) > 0
        set(hAxis.dose(1, 2), 'CLim', CLim);
    end
    
    aa = single(I);
aa = aa/max(aa(:))*data_main.alpha;
set(hPlotObj.dose(1,2), 'AlphaData', aa);


%% x (-P-z, -M-y)
[~, xSlice] = min(abs(data_main.x-ctInfo.xx));
I = squeeze(CT(:, xSlice,:)); %(M, P)
zz = ctInfo.zz;
yy = ctInfo.yy;

I = rot90(I); %(-P, M)
I = fliplr(I); % (-P, -M);
zz = fliplr(ctInfo.zz);
yy = fliplr(ctInfo.yy);

    set(hPlotObj.dose(2, 2), 'XData', yy, 'YData', zz, 'CData', I);
    
    if diff(CLim) > 0
        set(hAxis.dose(2, 2), 'CLim', CLim);
    end
    aa = single(I);
aa = aa/max(aa(:))*data_main.alpha;
set(hPlotObj.dose(2,2), 'AlphaData', aa);

%% y (-P-z, Nx)
[~, ySlice] = min(abs(data_main.y-ctInfo.yy));
I = squeeze(CT(ySlice, :,:)); % (N, P)
I = rot90(I); %(-P, N)
zz = fliplr(ctInfo.zz);
xx = ctInfo.xx;

    set(hPlotObj.dose(3, 2), 'XData', xx, 'YData', zz, 'CData', I);

    if diff(CLim) > 0
        set(hAxis.dose(3, 2), 'CLim', CLim);
    end
    aa = single(I);
aa = aa/max(aa(:))*data_main.alpha;
set(hPlotObj.dose(3,2), 'AlphaData', aa);