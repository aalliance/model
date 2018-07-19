global ROI sft2m
cdat = shaperead('ACS/ACS5Yr_BlockLevel');

% filter out block groups that are not inside the region of interest
[roix, roiy] = boundary(ROI);
inidx = [];
for i = 1:length(cdat)
    bgbb = cdat(i).BoundingBox*sft2m; % block group bounding box
    [bgbbx, bgbby] = boundary(bb2poly(bgbb));
    inroi = all(inpolygon(bgbbx, bgbby, roix, roiy));
    if inroi
        inidx = [inidx i];
    end
end
croi = cdat(inidx);
%TOTAL_POP = [croi(:).TOTAL_POP];
save census.dat croi