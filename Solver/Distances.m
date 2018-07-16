function [distances, positions,t] = Distances(filename)
v = 49*1609.34;
points = csvread(filename);
n = length(points(:,1));
positions = [];

for i=1:n-1
    if(points(i,1)==points(i+1,1) && points(i,2)==points(i+1,2))
        positions = [positions,i];
    end
end

distances = [];

k = 1;
% for j=1:length(positions)
%     distances = [distances, norm(points(k,:)-points(positions(j),:))];
%     if(j == length(positions))
%         distances = [distances, norm(points(positions(j),:)-points(end))];
%     end
%     k = positions(j);
% end

for j=1:length(positions)
    distances = [distances, sqrt((points(positions(j),1)-points(k,1))^2+(points(positions(j),2)-points(k,2))^2)];
    if(j == length(positions))
        distances = [distances, sqrt((points(end,1)-points(positions(j),1))^2+(points(end,2)-points(positions(j),2))^2)];
    end
    k = positions(j);
end
d = sum(distances);
t = d/v;
end

