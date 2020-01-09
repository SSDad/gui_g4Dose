function hMenuItem_ViewG4Dose_Callback(src, evnt)
hFig_main = ancestor(src, 'Figure');
data_main = guidata(hFig_main);

iso = data_main.tps.iso;

downSampling = data_main.G4.downSampling;

[M_g4, N_g4, P_g4] = size(data_main.tps.CT);

dx_g4 = data_main.tps.ctInfo.dx*downSampling;
dy_g4 = dx_g4;
dz_g4 = data_main.tps.ctInfo.dz;
N_g4 = N_g4/downSampling;
M_g4 = M_g4/downSampling;

% geant4, process Geant4 dose
g4Dose = data_main.g4DoseCol;
g4Dose = reshape(g4Dose, [P_g4 M_g4 N_g4]);
g4Dose = permute(g4Dose, [3 2 1]);
g4Dose = flip(g4Dose, 1);
g4Dose = flip(g4Dose, 3);
    
% these are the corner coorindate of the geant4 dose matrix
x0_g4 = data_main.tps.ctInfo.xx(1);
y0_g4 = data_main.tps.ctInfo.yy(1);
z0_g4 = data_main.tps.ctInfo.zz(1); 

xx_g4 = x0_g4:dx_g4:x0_g4+dx_g4*(N_g4-1);
yy_g4 = y0_g4:dy_g4:y0_g4+dy_g4*(M_g4-1);
zz_g4 = z0_g4:dz_g4:z0_g4+dz_g4*(P_g4-1);    

data_main.G4.Dose = g4Dose;
data_main.G4.xx = xx_g4;
data_main.G4.yy = yy_g4;
data_main.G4.zz = zz_g4;
data_main.G4.downSampling = downSampling;
data_main.G4.dx = dx_g4;
data_main.G4.dy = dy_g4;
data_main.G4.dz = dz_g4;

data_main.xxG4Dose = xx_g4-iso(1);
data_main.yyG4Dose = yy_g4-iso(2);
data_main.zzG4Dose = zz_g4-iso(3);

%% shift
downSampling = data_main.G4.downSampling;
dx_CT = data_main.tps.ctInfo.dx;
dy_CT = data_main.tps.ctInfo.dy;
xshift = dx_CT/2*(downSampling - 1);
% yshift = dy_CT/2*(downSampling - 1);
yshift = dy_CT/2*(downSampling - 1);% - dy_CT/8;

data_main.xxG4Dose = data_main.xxG4Dose+xshift;
data_main.yyG4Dose = data_main.yyG4Dose+yshift;

%% interpolate
g4D = g4Dose/max(g4Dose(:));

[xg_g4, yg_g4, zg_g4] = meshgrid(data_main.xxG4Dose, data_main.yyG4Dose, data_main.zzG4Dose);
[xg_tps, yg_tps, zg_tps] = meshgrid(data_main.xxTPSDose, data_main.yyTPSDose, data_main.zzTPSDose);

g4Di = interp3(xg_g4, yg_g4, zg_g4, g4D, xg_tps,yg_tps, zg_tps);

%% apply body contour
fn_matRS = fullfile(data_main.matfd, 'RS.mat');
load(fn_matRS);
idx = find(contains(SS.sNames, 'Body'));
%idx = find(contains(SS.sNames, 'External'));
cont = SS.structures(idx).contours;
zzC = [cont.z]';

[M_Dose, N_Dose, P_Dose] = size(data_main.tps.Dose);
x0_Dose = data_main.tps.dsInfo.xx(1);
y0_Dose = data_main.tps.dsInfo.yy(1);
z0_Dose = data_main.tps.dsInfo.zz(1);
dx_Dose = data_main.tps.dsInfo.dx;
dy_Dose = data_main.tps.dsInfo.dy;
dz_Dose = data_main.tps.dsInfo.dz;

nSliceDose = length(data_main.zzTPSDose);
SE = strel('disk', 2);  % erode
for iSliceDose = 1:nSliceDose
    [~, iSliceC] = min(abs(data_main.tps.dsInfo.zz(iSliceDose) - zzC));
    
    sgmt = cont(iSliceC).segments;
 
    xxC = [];
    yyC = [];
    for iS = 1:length(sgmt)
        points = sgmt(iS).points;
        x = points(:,1);
        y = points(:,2);
        
        xxC = [xxC; x]; 
        yyC = [yyC; y];
    end
    
    xxC = xxC-x0_Dose;
    yyC = yyC-y0_Dose;
    xxC = xxC/dx_Dose;
    yyC = yyC/dy_Dose;
    
    bwS = poly2mask(xxC, yyC, M_Dose, N_Dose );
    bwS = imerode(bwS, SE);

    g4Di(:,:,iSliceDose) = g4Di(:,:,iSliceDose).*bwS;
    data_main.tps.Dose(:,:,iSliceDose) = data_main.tps.Dose(:,:,iSliceDose).*bwS;
    
end

%% normalize dose
% g4
avM = 0;
avN = 0;
avP = 0;
[~, idx] = max(g4Di(:));
[m,n,p] = ind2sub(size(g4Di), idx);
junk = g4Di(m-avM:m+avM,n-avN:n+avN,p-avP:p+avP);
junk2 = sum(junk(:))/((2*avM +1)*(2*avN +1)*(2*avP +1));
data_main.G4.iDose = g4Di/junk2;

% % tps
% avM = 0;
% avN = 0;
% avP = 0;
% tpsD = data_main.tps.Dose;
% [~, idx2] = max(tpsD(:));
% [m,n,p] = ind2sub(size(tpsD), idx2);
% 
% junk = tpsD(m-avM:m+avM,n-avN:n+avN,p-avP:p+avP);
% junk2 = sum(junk(:))/((2*avM +1)*(2*avN +1)*(2*avP +1));
% data_main.tps.Dose = tpsD/junk2;

% diff
data_main.dd = data_main.G4.iDose - data_main.tps.Dose;

%% save data
guidata(hFig_main, data_main);
% initTPSDoseImages(hFig_main);
updateXImages(hFig_main, 'G4Dose');
updateXImages(hFig_main, 'DoseDiff');

data_main.hMenuItem.GammaMap.Enable = 'on';
data_main.hMenuItem.Profile.Enable = 'on';