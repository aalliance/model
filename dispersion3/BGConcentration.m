global sft2m croi tlist
conc_factor = 0.2 * 2e15 / 4.8765e7 / 50;
respiratory_rate = 8.6; % m^3 / day

w = 10;
C = zeros(length(croi),length(tlist));
warning('off','MATLAB:polyshape:repairedBySimplify');
for i = 1:length(croi)
    bb = croi(i).BoundingBox*sft2m;
    xq = linspace(min(bb(:,1)), max(bb(:,1)), w);
    yq = linspace(min(bb(:,2)), max(bb(:,2)), w);
    x = croi(i).X*sft2m;
    y = croi(i).Y*sft2m;
    polygon = polyshape(x,y);
    [x2, y2] = boundary(polygon);
    [xq2, yq2] = meshgrid(xq, yq);
    mask = inpolygon(xq2, yq2, x2, y2);
    xq3 = xq2(mask);
    yq3 = yq2(mask);
    pdeinterp = pdeInterpolant(p2, t2, U);
    z = evaluate(pdeinterp, [xq3'; yq3']);
    z = fillmissing(z,'constant',0);
    z(z < 0) = 0;
    C(i, :) = mean(z, 1);
end
C = C*conc_factor;
warning('on','MATLAB:polyshape:repairedBySimplify');
save concentration.mat C % concentration in block by time

Cinteg = C*respiratory_rate;
for bidx = 1:size(C, 1)
    for tidx = 1:size(C,2)
        Cinteg(bidx, tidx) = ((tidx-1)*t_step)*mean(C(bidx, 1:tidx));
    end
end
save concentration.mat Cinteg % integral of concentration in block over time
