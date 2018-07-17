function conc = Concentration(interFunction)
blocks = load('blocks.mat');
polygon = polyshape(blocks.croi(1).X,blocks.croi(1).Y);
X = polygon.Vertices(:,1);
A = min(X);
B = max(X);
[Cfun, Dfun] = poly2yrange(polygon);
f = interFunction;
conc = quad2d(f,A,B,Cfun,Dfun);
end