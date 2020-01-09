function updateXImages(hFig_main, mode)

data_main = guidata(hFig_main);
hPlotObj = data_main.hPlotObj;
hText = data_main.hText;
hAxis = data_main.hAxis;

CT = data_main.tps.CT;
xxm = data_main.xx;
yym = data_main.yy;
zzm = data_main.zz;
plotObj = hPlotObj.ct;
plotAxis = hAxis.ct;
columnNo = 1:4;

if ~strcmp(mode, 'CT')
    xxm = data_main.xxTPSDose;
    yym = data_main.yyTPSDose;
    zzm = data_main.zzTPSDose;
    plotObj = hPlotObj.dose;
    plotAxis = hAxis.dose;
end

if strcmp(mode, 'TPSDose')
    CT = data_main.tps.Dose;
    columnNo = 1;
elseif strcmp(mode, 'G4Dose')
    CT = data_main.G4.iDose;
    columnNo = 2;
elseif strcmp(mode, 'DoseDiff')
    CT = data_main.dd;
    columnNo = 3;
elseif strcmp(mode, 'GammaMapFail')
    CT = data_main.gm;
    columnNo = 4;
end

minCT = min(CT(:));
maxCT = max(CT(:));
maxWindow = maxCT-minCT;
CLim(1) = minCT+maxWindow*0.;
CLim(2) = maxCT-maxWindow*0.;

if strcmp(mode, 'GammaMapFail')
    CLim(1) = 1;
    CLim(2) = 1.1;
end

%% z (My, Nx)
[~, zSlice] = min(abs(data_main.z-zzm));
I = CT(:,:,zSlice);
if strcmp(mode, 'GammaMapFail')
    I(I<=1) = 0;
end

for c = columnNo
    set(plotObj(1, c), 'XData', xxm, 'YData', yym, 'CData', I);

    if diff(CLim) > 0
        set(plotAxis(1, c), 'CLim', CLim);
    end
end

if strcmp(mode, 'CT')
    hText.pos(1).String = ['Y: ', num2str(data_main.z/10), ' cm'];
    hText.pos(1).Visible = 'on';
else
    aa = single(I);
    aa = aa/max(aa(:))*data_main.alpha;
    set(plotObj(1, columnNo), 'AlphaData', aa);
end

%% x (-P-z, -M-y)
[~, xSlice] = min(abs(data_main.x-xxm));
I = squeeze(CT(:, xSlice,:)); %(M, P)

I = rot90(I); %(-P, M)
I = flip(I, 2); % (-P, -M);
yy = flip(zzm);
xx = flip(yym);

if strcmp(mode, 'GammaMapFail')
    I(I<=1) = 0;
end

for c = columnNo
    set(plotObj(2, c), 'XData', xx, 'YData', yy, 'CData', I);
    if diff(CLim) > 0
        set(plotAxis(2, c), 'CLim', CLim);
    end
end

if strcmp(mode, 'CT')
    hText.pos(2).String = ['X: ', num2str(data_main.x/10), '  cm'];
    hText.pos(2).Visible = 'on';
else
    aa = single(I);
    aa = aa/max(aa(:))*data_main.alpha;
    set(plotObj(2,columnNo), 'AlphaData', aa);
end

%% y (-P-z, Nx)
[~, ySlice] = min(abs(data_main.y-yym));
I = squeeze(CT(ySlice, :,:)); % (N, P)
I = rot90(I); %(-P, N)
zz = flip(zzm);
xx = xxm;
if strcmp(mode, 'GammaMapFail')
    I(I<=1) = 0;
end

for c = columnNo
    set(plotObj(3, c), 'XData', xx, 'YData', zz, 'CData', I);
    if diff(CLim) > 0
        set(plotAxis(3, c), 'CLim', CLim);
    end
end

if strcmp(mode, 'CT')
    hText.pos(3).String = ['Z: ', num2str(-data_main.y/10), ' cm'];
    hText.pos(3).Visible = 'on';
else    aa = single(I);
    aa = aa/max(aa(:))*data_main.alpha;
    set(plotObj(3,columnNo), 'AlphaData', aa);
end

%% colorbar
if data_main.GammaMap
    for r = 1:3
        for c = 2:4
            hPlotObj.cb_dose(r, c).Visible = 'on';
        end
    end
end
        

