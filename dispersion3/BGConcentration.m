global sft2m croi tlist
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
    tidxs = tidx*ones(length(xq3),1);
    z = evaluate(pdeinterp, [xq3'; yq3']);
    z = fillmissing(z,'constant',0);
    z(z < 0) = 0;
    C(i, :) = mean(z, 1);
end
warning('on','MATLAB:polyshape:repairedBySimplify');
save concentration.mat C
