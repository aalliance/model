function f = SourceCoefficient()
    points = csvread('blocks.csv');
    gd = [points(:,1);points(:,2)];
    l = length(gd)/2;
end