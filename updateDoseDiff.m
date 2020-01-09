function updateDoseDiff(hFig_main)

data_main = guidata(hFig_main);
hPlotObj = data_main.hPlotObj;
hText = data_main.hText;
hAxis = data_main.hAxis;

CT = data_main.diffD;
ctInfo = data_main.tps.dsInfo;
ctInfo.zz = ctInfo.ipp(3)+ctInfo.zOS;

minCT = min(CT(:));
maxCT = max(CT(:));
maxWindow = maxCT-minCT;
CLim(1) = minCT+maxWindow*0.;
CLim(2) = maxCT-maxWindow*0.;

%% z (My, Nx)
[~, zSlice] = min(abs(data_main.z-ctInfo.zz));
I = CT(:,:,zSlice);

    set(hPlotObj.dose(1, 3), 'XData', ctInfo.xx, 'YData', ctInfo.yy, 'CData', I);

% CLim(1) = min(I(:));
% CLim(2) = max(I(:));
%     if diff(CLim) > 0
%         set(hAxis.dose(1, 3), 'CLim', CLim);
%     end
    
    aa = single(I);
aa = aa/max(aa(:))*data_main.alpha;
set(hPlotObj.dose(1, 3), 'AlphaData', 1);


%% x (-P-z, -M-y)
[~, xSlice] = min(abs(data_main.x-ctInfo.xx));
I = squeeze(CT(:, xSlice,:)); %(M, P)
CLim(1) = min(I(:));
CLim(2) = max(I(:));
zz = ctInfo.zz;
yy = ctInfo.yy;

I = rot90(I); %(-P, M)
I = fliplr(I); % (-P, -M);
zz = fliplr(ctInfo.zz);
yy = fliplr(ctInfo.yy);

    set(hPlotObj.dose(2, 3), 'XData', yy, 'YData', zz, 'CData', I);
    
% CLim(1) = min(I(:));
% CLim(2) = max(I(:));
%     if diff(CLim) > 0
%         set(hAxis.dose(2, 3), 'CLim', CLim);
%     end
    aa = single(I);
aa = aa/max(aa(:))*data_main.alpha;
set(hPlotObj.dose(2, 3), 'AlphaData', 1);

%% y (-P-z, Nx)
[~, ySlice] = min(abs(data_main.y-ctInfo.yy));
I = squeeze(CT(ySlice, :,:)); % (N, P)
I = rot90(I); %(-P, N)
zz = fliplr(ctInfo.zz);
xx = ctInfo.xx;

    set(hPlotObj.dose(3, 3), 'XData', xx, 'YData', zz, 'CData', I);

% CLim(1) = min(I(:));
% CLim(2) = max(I(:));
%     if diff(CLim) > 0
%         set(hAxis.dose(3, 3), 'CLim', CLim);
%     end
    aa = single(I);
aa = aa/max(aa(:))*data_main.alpha;
set(hPlotObj.dose(3, 3), 'AlphaData', 1);