function hMenuItem_LoadISO_Callback(src, evnt)
hFig_main = ancestor(src, 'Figure');
data_main = guidata(hFig_main);
ctInfo = data_main.tps.ctInfo;

machine = computer;
if strcmp(machine, 'MACI64')
    fd_TestPlans = '/Users/dad/Box Sync/Virtual Linac Project for Halcyon/TestPlans';
else
%    fd_TestPlans = 'C:\Users\zji\Box\Virtual Linac Project for Halcyon\TestPlans';
    fd_TestPlans = 'C:\Users\zhen_\Box Sync\Virtual Linac Project for Halcyon\TestPlans';
end

[file, path] = uigetfile(fullfile(fd_TestPlans, 'RP*.dcm'));
pffn = fullfile(path, file);

data_main.ptfd = path;

%% read phantom
% M, N, P, dd, A
delimiterIn = ' ';
headerlinesIn = 4;
ID = importdata(pffn, delimiterIn, headerlinesIn);
A = ID.data;
txtData = ID.textdata;
    
for n = 1:length(txtData)
    if strfind(txtData{n}, 'Number of voxels')  % voxels
        k = strfind(txtData{n}, ':');
        str = txtData{n}(k+1:end);
        mnp = str2num(str);
        M = mnp(1);
        P = mnp(2);
        N = mnp(3);
    end
    if strfind(txtData{n}, 'Voxel size')  % voxels
        k1 = strfind(txtData{n}, ':');
        k2 = strfind(txtData{n}, 'm');

        str = txtData{n}(k1+1:k2-1);
        dd = str2num(str);
    end
end

%
v1 = (single(A(:,2)));
CTv = reshape(v1, [M, P, N]);
CTv = permute(CTv, [1 3 2]);  % for display purpose only


[xxs, ind, phCent] = fun_getPhantomGrid(ctInfo, data_main.tps.dsInfo);
xxv = xxs{1};
yyv = xxs{2};
zzv = xxs{3};
data_main.tps.doseInd = ind;

% dxv = dd(1);
% dyv = dd(3);
% dzv = dd(2);
% 
% rt = size(data_main.tps.CT)./[M N P];
% 
% junk = reshape(ctInfo.xx, rt(1), []);
% xxv = mean(junk, 1);
% junk = reshape(ctInfo.yy, rt(2), []);
% yyv = mean(junk, 1);
% zzv = ctInfo.zz;
% if rt(3) == 1
%     zzv = ctInfo.zz;
% end
% 
data_main.VL.CTv = CTv;
data_main.VL.ctInfo.xx = xxv;
data_main.VL.ctInfo.yy = yyv;
data_main.VL.ctInfo.zz = zzv;

data_main.xx = xxv;
data_main.yy = yyv;
data_main.zz = zzv;

%% save data
guidata(hFig_main, data_main)

%% slider
iniSlider(hFig_main)

%% Menu
data_main.hMenuItem.LoadVLP.Checked = 'on';

%% vis
updateCTvImage(hFig_main);