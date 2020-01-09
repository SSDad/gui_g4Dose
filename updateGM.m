function updateGM(hFig_main)

data_main = guidata(hFig_main);
hPlotObj = data_main.hPlotObj;
hText = data_main.hText;
hAxis = data_main.hAxis;

CT = data_main.VL.GM;
ctInfo = data_main.tps.dsInfo;
ctInfo.zz = ctInfo.ipp(3)+ctInfo.zOS;

minCT = min(CT(:));
maxCT = max(CT(:));
maxWindow = maxCT-minCT;
CLim(1) = minCT+maxWindow*0.;
CLim(2) = maxCT-maxWindow*0.;

col = 4;

%% z (My, Nx)
[~, zSlice] = min(abs(data_main.z-ctInfo.zz));
I = CT(:,:,zSlice);

if strcmp(data_main.hMenuItem.gMapFail.Checked, 'on')
    I(I<=1) = 0;
elseif strcmp(data_main.hMenuItem.gMapPass.Checked, 'on')
    I(I>1) = 0;
end

set(hPlotObj.dose(1, col), 'XData', ctInfo.xx, 'YData', ctInfo.yy, 'CData', I);

% CLim(1) = min(I(:));
% CLim(2) = max(I(:));
%     if diff(CLim) > 0
%         set(hAxis.dose(1, col), 'CLim', CLim);
%     end
    
    aa = single(I);
aa = aa/max(aa(:))*data_main.alpha;
set(hPlotObj.dose(1, col), 'AlphaData', aa);


%% x (-P-z, -M-y)
[~, xSlice] = min(abs(data_main.x-ctInfo.xx));
I = squeeze(CT(:, xSlice,:)); %(M, P)
CLim(1) = min(I(:));
CLim(2) = max(I(:));
zz = ctInfo.zz;
yy = ctInfo.yy;

I = rot90(I); %(-P, M)
I = fliplr(I); % (-P, -M);

if strcmp(data_main.hMenuItem.gMapFail.Checked, 'on')
    I(I<=1) = 0;
elseif strcmp(data_main.hMenuItem.gMapPass.Checked, 'on')
    I(I>1) = 0;
end

zz = fliplr(ctInfo.zz);
yy = fliplr(ctInfo.yy);

    set(hPlotObj.dose(2, col), 'XData', yy, 'YData', zz, 'CData', I);
    
% CLim(1) = min(I(:));
% CLim(2) = max(I(:));
%     if diff(CLim) > 0
%         set(hAxis.dose(2, col), 'CLim', CLim);
%     end
    aa = single(I);
aa = aa/max(aa(:))*data_main.alpha;
set(hPlotObj.dose(2, col), 'AlphaData', aa);

%% y (-P-z, Nx)
[~, ySlice] = min(abs(data_main.y-ctInfo.yy));
I = squeeze(CT(ySlice, :,:)); % (N, P)
I = rot90(I); %(-P, N)

if strcmp(data_main.hMenuItem.gMapFail.Checked, 'on')
    I(I<=1) = 0;
elseif strcmp(data_main.hMenuItem.gMapPass.Checked, 'on')
    I(I>1) = 0;
end

zz = fliplr(ctInfo.zz);
xx = ctInfo.xx;

    set(hPlotObj.dose(3, col), 'XData', xx, 'YData', zz, 'CData', I);

% CLim(1) = min(I(:));
% CLim(2) = max(I(:));
%     if diff(CLim) > 0
%         set(hAxis.dose(3, col), 'CLim', CLim);
%     end
    aa = single(I);
aa = aa/max(aa(:))*data_main.alpha;
set(hPlotObj.dose(3, col), 'AlphaData', aa);