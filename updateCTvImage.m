function updateCTvImage(hFig_main)

data_main = guidata(hFig_main);
hPlotObj = data_main.hPlotObj;
hText = data_main.hText;
hAxis = data_main.hAxis;

CT = data_main.VL.CTv;
ctInfo = data_main.VL.ctInfo;

minCT = min(CT(:));
maxCT = max(CT(:));
maxWindow = maxCT-minCT;
CLim(1) = minCT+maxWindow*0.;
CLim(2) = maxCT-maxWindow*0.;

%% z (My, Nx)
[~, zSlice] = min(abs(data_main.z-ctInfo.zz));
I = CT(:,:,zSlice);

for c = 2
    set(hPlotObj.ct(1, c), 'XData', ctInfo.xx, 'YData', ctInfo.yy, 'CData', I);

    if diff(CLim) > 0
        set(hAxis.ct(1, c), 'CLim', CLim);
    end
end

%% x (-P-z, -M-y)
[~, xSlice] = min(abs(data_main.x-ctInfo.xx));
I = squeeze(CT(:, xSlice,:)); %(M, P)

I = rot90(I); %(-P, M)
I = fliplr(I); % (-P, -M);
zz = fliplr(ctInfo.zz);
yy = fliplr(ctInfo.yy);

for c = 2
    set(hPlotObj.ct(2, c), 'XData', yy, 'YData', zz, 'CData', I);
    if diff(CLim) > 0
        set(hAxis.ct(2, c), 'CLim', CLim);
    end
end

%% y (-P-z, Nx)
[~, ySlice] = min(abs(data_main.y-ctInfo.yy));
I = squeeze(CT(ySlice, :,:)); % (N, P)
I = rot90(I); %(-P, N)
zz = fliplr(ctInfo.zz);
xx = ctInfo.xx;

for c = 2
    set(hPlotObj.ct(3, c), 'XData', xx, 'YData', zz, 'CData', I);
    if diff(CLim) > 0
        set(hAxis.ct(3, c), 'CLim', CLim);
    end
end