function [l, gd] = coordinates(filename)
    points = csvread(filename);
    gd = [points(:,1);points(:,2)];
    l = length(gd)/2;
end