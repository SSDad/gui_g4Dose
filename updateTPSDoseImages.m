function updateTPSDoseImages(hFig_main)

data_main = guidata(hFig_main);
hPlotObj = data_main.hPlotObj;
hText = data_main.hText;
hAxis = data_main.hAxis;

CT = data_main.tps.Dose;
% ctInfo = data_main.tps.dsInfo;
% ctInfo.zz = ctInfo.ipp(3)+ctInfo.zOS;
iso = data_main.tps.iso;

ctInfo.xx = data_main.xxDose;
ctInfo.yy = data_main.yyDose;
ctInfo.zz = data_main.zzDose;

CT = CT/max(CT(:));

minCT = min(CT(:));
maxCT = max(CT(:));
maxWindow = maxCT-minCT;
CLim(1) = minCT+maxWindow*0.;
CLim(2) = maxCT-maxWindow*0.;

%% z (My, Nx)
[~, zSlice] = min(abs(data_main.z-ctInfo.zz));
I = CT(:,:,zSlice);

    set(hPlotObj.dose(1, 1), 'XData', ctInfo.xx, 'YData', ctInfo.yy, 'CData', I);

    if diff(CLim) > 0
        set(hAxis.dose(1, 1), 'CLim', CLim);
    end
    
    aa = single(I);
aa = aa/max(aa(:))*data_main.alpha;
set(hPlotObj.dose(1,1), 'AlphaData', aa);


%% x (-P-z, -M-y)
[~, xSlice] = min(abs(data_main.x-ctInfo.xx));
I = squeeze(CT(:, xSlice,:)); %(M, P)

I = rot90(I); %(-P, M)
I = fliplr(I); % (-P, -M);
yy = flip(ctInfo.zz);
xx = flip(ctInfo.yy);

    set(hPlotObj.dose(2, 1), 'XData', xx, 'YData', yy, 'CData', I);
    
    if diff(CLim) > 0
        set(hAxis.dose(2, 1), 'CLim', CLim);
    end
    aa = single(I);
aa = aa/max(aa(:))*data_main.alpha;
set(hPlotObj.dose(2,1), 'AlphaData', aa);

%% y (-P-z, Nx)
[~, ySlice] = min(abs(data_main.y-ctInfo.yy));
I = squeeze(CT(ySlice, :,:)); % (N, P)
I = rot90(I); %(-P, N)
zz = flip(ctInfo.zz);
xx = ctInfo.xx;

    set(hPlotObj.dose(3, 1), 'XData', xx, 'YData', zz, 'CData', I);

    if diff(CLim) > 0
        set(hAxis.dose(3, 1), 'CLim', CLim);
    end
    aa = single(I);
aa = aa/max(aa(:))*data_main.alpha;
set(hPlotObj.dose(3,1), 'AlphaData', aa);