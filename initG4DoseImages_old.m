function initG4DoseImages(hFig_main)

%%
data_main = guidata(hFig_main);
hAxis = data_main.hAxis;

dsInfo = data_main.tps.dsInfo;
xxd = dsInfo.xx;
yyd = dsInfo.yy;
zzd = dsInfo.ipp(3)+dsInfo.zOS';

%% 
xxv = data_main.VL.ctInfo.xx;
yyv = data_main.VL.ctInfo.yy;
zzv = data_main.VL.ctInfo.zz;
nx = data_main.VL.nx;
ny = data_main.VL.ny;
nz = data_main.VL.nz;

d3 = single(data_main.VL.d3);
d3 = d3/max(d3);
junk = single(reshape(d3, [nz ny nx]));
DSv = permute(junk, [1 3 2]);

%% DSi
% [xgv, ygv, zgv] = meshgrid(xxv, yyv, zzv);
% [xgd, ygd, zgd] = meshgrid(xxd, yyd, zzd);

% DSi = interp3(xgv, ygv, zgv, DSv, xgd, ygd, zgd);

ind = data_main.tps.doseInd;
DSi = DSv(ind{2}(1):ind{2}(2), ind{1}(1):ind{1}(2), ind{3}(1):ind{3}(2));


[maxDSi, idx] = max(DSi(:));
[mMax, nMax, pMax] = ind2sub(size(DSi), idx);
junk = DSi(mMax-1:mMax+1, nMax-1:nMax+1, pMax-1:pMax+1);
avgMax = sum(junk(:))/27;
DSi = DSi/avgMax;
voxel_sizes = [dsInfo.dx dsInfo.dy zzd(2)-zzd(1)];

data_main.VL.DSi = DSi;
data_main.VL.voxel_sizes = voxel_sizes;

% if peelDM
%     aa = 2;
%     [dM, dN, dP] = size(DS);
%     junk = zeros(size(DS));
%     junk(aa+1:dM-aa, aa+1:dN-aa, aa+1:dP-aa) = DS(aa+1:dM-aa, aa+1:dN-aa, aa+1:dP-aa);
%     DS = junk;
%     
%     junk = zeros(size(DS));
%     junk(aa+1:dM-aa, aa+1:dN-aa, aa+1:dP-aa) = DSi(aa+1:dM-aa, aa+1:dN-aa, aa+1:dP-aa);
%     DSi = junk;
% end

%% gamma
DS = squeeze(data_main.tps.DS);
[maxDS, idx] = max(DS(:));
[mMax, nMax, pMax] = ind2sub(size(DS), idx);
junk = DS(mMax-1:mMax+1, nMax-1:nMax+1, pMax-1:pMax+1);
avgMax = sum(junk(:))/27;
DS = DS/avgMax;

[pp, GM, xout, histout] = gamma3D_general(DS, DSi, voxel_sizes, 3, 3, 0.1);
data_main.VL.GM = GM;
data_main.VL.pp = pp;

%% diff
data_main.diffD = DSi-DS;

%% slider
data_main.xx = xxd;
data_main.yy = yyd;
data_main.zz = zzd;
guidata(hFig_main, data_main);

iniSlider(hFig_main);

updateDoseVImage(hFig_main);
updateDoseDiff(hFig_main);
updateGM(hFig_main);

for r = 1:3
    data_main.hPlotObj.cb_dose(r, 3).Visible = 'on';
    data_main.hPlotObj.cb_dose(r, 3).Limits = [-0.1 0.1];
    caxis(hAxis.dose(r, 3), [-0.1 0.1]);
    colormap(hAxis.dose(r, 3), jet);

    data_main.hPlotObj.cb_dose(r, 4).Visible = 'on';
    data_main.hPlotObj.cb_dose(r, 4).Limits = [0.5 1.5];
    caxis(hAxis.dose(r, 4), [0.5 1.5]);
    colormap(hAxis.dose(r, 4), jet);
end