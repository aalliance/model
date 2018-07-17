cdat = shaperead('ACS/ACS5Yr_BlockLevel');

% filter out block groups that are not inside the region of interest
mconv = 1200/3937; % 1 survey foot = 1200/3937 meters
global ROI
[roix, roiy] = boundary(ROI);
inidx = [];
for i = 1:length(cdat)
    bgbb = cdat(i).BoundingBox*mconv; % block group bounding box
    [bgbbx, bgbby] = boundary(bb2poly(bgbb));
    inroi = all(inpolygon(bgbbx, bgbby, roix, roiy));
    if inroi
        inidx = [inidx i];
    end
end
croi = cdat(inidx);
%TOTAL_POP = [croi(:).TOTAL_POP];