function initSlider(hFig_main)

data_main = guidata(hFig_main);
hSliderX = data_main.hSliderX;
hSliderY = data_main.hSliderY;
hSliderZ = data_main.hSliderZ;

hSliderZ.Min = 1;
hSliderZ.Max = length(data_main.zz);
[~, iSlice] = min(abs(data_main.z-data_main.zz));
hSliderZ.Value = iSlice;
hSliderZ.SliderStep = [1 10]/(length(data_main.zz)-1);

hSliderX.Min = 1;
hSliderX.Max = length(data_main.xx);
[~, iSlice] = min(abs(data_main.x-data_main.xx));
hSliderX.Value = iSlice;
hSliderX.SliderStep = [1 10]/(length(data_main.xx)-1);

hSliderY.Min = 1;
hSliderY.Max = length(data_main.yy);
[~, iSlice] = min(abs(data_main.y-data_main.yy));
hSliderY.Value = iSlice;
hSliderY.SliderStep = [1 10]/(length(data_main.yy)-1);

for r = 1:3
    data_main.hPanel.slider(r).Visible = 'on';
end