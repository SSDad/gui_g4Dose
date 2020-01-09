function [pass_percentage,gammamap,xout,histout] = gamma3D_general(dose_vol_1,dose_vol_2,voxel_sizes,gamma_dist,gamma_percentage,cut_off,ref_dose)
%
% [pass_percentage,gammamap] = gamma3D_general(dose_vol_1,dose_vol_2,voxel_sizes=[3 3 3],gamma_dist=3,gamma_percentage=3,cut_off=0.1,ref_dose)
% [pass_percentage,gammamap] = gamma3D_general(dose_vol_1,dose_vol_2,voxel_sizes,3,3,0.1)
% [pass_percentage,gammamap] = gamma3D_general(dose_vol_1,dose_vol_2,voxel_sizes,3,3)
% [pass_percentage,gammamap] = gamma3D_general(dose_vol_1,dose_vol_2,voxel_sizes,3)
% [pass_percentage,gammamap] = gamma3D_general(dose_vol_1,dose_vol_2,voxel_sizes)
% [pass_percentage,gammamap] = gamma3D_general(dose_vol_1,dose_vol_2)
%
% 3D dose map gamma analysis
% According to Daniel A Low 1999 Med Phys paper
%
% Input:
%   dose_vol_1 - 3D dose volume #1
%   dose_vol_2 - 3D dose volume #2, in the same dimension as dose volume #1
%	voxel_sizes -	in mm x mm x mm
%	gamma_dist - in mm
%	gamma_percentage - in percentage
%
%
% Copyright: Deshan Yang, PhD, 2016
%

if ~exist('cut_off','var') || isempty(cut_off)
    cut_off = 0.1;
end

if ~exist('gamma_percentage','var') || isempty(gamma_percentage)
    gamma_percentage = 3;
end

if ~exist('gamma_dist','var') || isempty(gamma_dist)
    gamma_dist = 3;
end

if ~exist('voxel_sizes','var') || isempty(voxel_sizes)
    voxel_sizes = [3 3 3];
end

if ~isequal(size(dose_vol_1),size(dose_vol_2))
    pass_percentage = [];
    gammamap = zeros(size(dose_vol_1),'single');
    fprintf('Matrix sizes do not match, cannot perform gamma analysis\n');
    return;
end


%%

ranges_indices = ceil(gamma_dist./voxel_sizes);
dx_indices = -ranges_indices(1):ranges_indices(1);
dy_indices = -ranges_indices(2):ranges_indices(2);
dz_indices = -ranges_indices(3):ranges_indices(3);
if length(dx_indices)>5
    dx_indices = [-ranges_indices 0 ranges_indices(1)];
end
if length(dy_indices)>5
    dy_indices = [-ranges_indices(2) 0 ranges_indices(2)];
end

[xx_indices,yy_indices,zz_indices] = meshgrid(dx_indices,dy_indices,dz_indices);
xx_indices = xx_indices(:);
yy_indices = yy_indices(:);
zz_indices = zz_indices(:);

dr = sqrt((xx_indices*voxel_sizes(1)).^2 + (yy_indices*voxel_sizes(2)).^2 + + (zz_indices*voxel_sizes(3)).^2);
dr2 = dr.^2/gamma_dist^2;% Distance square
% dr2b = sqrt(dr2);% Distance square
dr2b = max(dr2,1);% Distance square
% dr2b(dr <= gamma_dist)=1;

N = length(xx_indices);



%%
dim = size(dose_vol_1);
% iy = 1:dim(1);
% ix = 1:dim(2);
% iz = 1:dim(3);

if ~exist('ref_dose','var') || isempty(ref_dose) || ~isnumeric(ref_dose) || isnan(ref_dose(1)) || ref_dose(1) == 0
	Dmax = max(dose_vol_1(:)); % the max Dose
	ref_dose = Dmax;
end

mask = (dose_vol_1>(ref_dose*cut_off)) | (dose_vol_2>(ref_dose*cut_off));
se = strel('arbitrary',ones(2,2,2));
mask = imdilate(imerode(mask,se),se);
xvals = sum(sum(mask,3),1);
yvals = sum(sum(mask,3),2);
zvals = sum(sum(mask,2),1);

ix = find(xvals>0,1,'first') : find(xvals>0,1,'last');
iy = find(yvals>0,1,'first') : find(yvals>0,1,'last');
iz = find(zvals>0,1,'first') : find(zvals>0,1,'last');

f = ((ref_dose*gamma_percentage/100)^2);

dose_vol_1_to_use = dose_vol_1(iy,ix,iz);
%%
for k =1:N
	ixx2 = ix+xx_indices(k); ixx2 = max(ixx2,1); ixx2 = min(ixx2,dim(2));
	iyy2 = iy+yy_indices(k); iyy2 = max(iyy2,1); iyy2 = min(iyy2,dim(1));
	izz2 = iz+zz_indices(k); izz2 = max(izz2,1); izz2 = min(izz2,dim(3));
    tmp2d = dose_vol_2(iyy2,ixx2,izz2);
    tmp3 = abs(dose_vol_1_to_use-tmp2d).^2/f;
%     tmp4 = sqrt(tmp3+dr2(k)) / dr2b(k);
    tmp4 = (tmp3+dr2(k)) / dr2b(k);
    
    if k == 1
        gammamap_s = tmp4;
    else
        gammamap_s = min(gammamap_s,tmp4);
    end
end

%%
dose_vol_2_to_use = dose_vol_2(iy,ix,iz);
idxes = find(dose_vol_1_to_use>ref_dose*cut_off | dose_vol_2_to_use>ref_dose*cut_off);
N = length(idxes);
N_pass = length(find(gammamap_s(idxes)<=1));
pass_percentage = N_pass/N*100;

GMax = max(gammamap_s(idxes));
GMax = min(GMax,10);
if GMax > 6.5
%     xbins = [0.25 0.75 1.25 1.75 2.25 (GMax-2)/2];
    xbins = 0:0.1:(GMax-2)/2;
else
%     xbins = [0.25 0.75 1.25 1.75 2.25 3];
    xbins = 0:0.05:2;
end
[histout,xout] = hist(gammamap_s(idxes),xbins);

%%
gammamap_s = sqrt(gammamap_s);

gammamap_s(dose_vol_1_to_use<=ref_dose*cut_off & dose_vol_2_to_use<=ref_dose*cut_off)=0;
gammamap = dose_vol_1*0;
gammamap(iy,ix,iz) = gammamap_s;

