function updateCTImages(hFig_main)

data_main = guidata(hFig_main);
hPlotObj = data_main.hPlotObj;
hText = data_main.hText;
hAxis = data_main.hAxis;

CT = data_main.tps.CT;
% data_main = data_main.tps.ctInfo;

minCT = min(CT(:));
maxCT = max(CT(:));
maxWindow = maxCT-minCT;
CLim(1) = minCT+maxWindow*0.;
CLim(2) = maxCT-maxWindow*0.;

%% z (My, Nx)
[~, zSlice] = min(abs(data_main.z-data_main.zz));
I = CT(:,:,zSlice);

for c = [1 2 3 4]
    set(hPlotObj.ct(1, c), 'XData', data_main.xx, 'YData', data_main.yy, 'CData', I);

    if diff(CLim) > 0
        set(hAxis.ct(1, c), 'CLim', CLim);
    end
end

% text
hText.pos(1).String = ['Y: ', num2str(data_main.z/10), ' cm'];
hText.pos(1).Visible = 'on';

%% x (-P-z, -M-y)
[~, xSlice] = min(abs(data_main.x-data_main.xx));
I = squeeze(CT(:, xSlice,:)); %(M, P)

I = rot90(I); %(-P, M)
I = flip(I, 2); % (-P, -M);
yy = flip(data_main.zz);
xx = flip(data_main.yy);

for c = [1 2 3 4]
    set(hPlotObj.ct(2, c), 'XData', xx, 'YData', yy, 'CData', I);
    if diff(CLim) > 0
        set(hAxis.ct(2, c), 'CLim', CLim);
    end
end

% text
hText.pos(2).String = ['X: ', num2str(data_main.x/10), '  cm'];
hText.pos(2).Visible = 'on';

%% y (-P-z, Nx)
[~, ySlice] = min(abs(data_main.y-data_main.yy));
I = squeeze(CT(ySlice, :,:)); % (N, P)
I = rot90(I); %(-P, N)
zz = flip(data_main.zz);
xx = data_main.xx;

for c = [1 2 3 4]
    set(hPlotObj.ct(3, c), 'XData', xx, 'YData', zz, 'CData', I);
    if diff(CLim) > 0
        set(hAxis.ct(3, c), 'CLim', CLim);
    end
end

% text
hText.pos(3).String = ['Z: ', num2str(-data_main.y/10), ' cm'];
hText.pos(3).Visible = 'on';