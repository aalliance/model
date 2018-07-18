global sft2m croi tlist
w = 10;
C = zeros(length(croi),length(tlist));
warning('off','MATLAB:polyshape:repairedBySimplify');
for i = 1:length(croi)
    for tidx = 1:length(tlist)
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
        z = interpolateSolution(result,xq3,yq3,tidx);
        z = fillmissing(z,'constant',0);
        z(z < 0) = 0;
        C(i, tidx) = mean(z);
    end
end
warning('on','MATLAB:polyshape:repairedBySimplify');
save concentration.mat C
