function     [xxs, ind, phCent] = fun_getPhantomGrid(ctInfo, dsInfo)

xxct{1} = ctInfo.xx;
xxct{2} = ctInfo.yy;
xxct{3} = ctInfo.zz;

xxds{1} = dsInfo.xx;
xxds{2} = dsInfo.yy;
xxds{3} = dsInfo.zz';

dxds(1) = dsInfo.dx;
dxds(2) = dsInfo.dy;
dxds(3) = dsInfo.dz;

for n = 1:3
    D1 = xxds{n}(1)-xxct{n}(1);
    D2 = xxct{n}(end)-xxds{n}(end);

    s1 = floor(D1/dxds(n));
    s2 = floor(D2/dxds(n));
  
    xxs{n} = [xxds{n}(1)-s1*dxds(n):dxds(n):xxds{n}(1)-dxds(n)...
                    xxds{n}...
                    xxds{n}(end)+dxds(n):dxds(n):xxds{n}(end)+s2*dxds(n)];

    ind{n}(1) = s1+1;
    ind{n}(2) = length(xxs{n})-s2;
    phCent(n) = (xxs{n}(1)+xxs{n}(end))/2;
end