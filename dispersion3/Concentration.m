function conc = Concentration(interFunction, RelTol)
global sft2m;
global croi;
X = rmmissing(croi(50).X*sft2m);
Y = rmmissing(croi(50).Y*sft2m);
polygon = polyshape(X,Y);
A = min(X);
B = max(X);
[Cfun, Dfun] = poly2yrange(polygon);
f = interFunction;
conc = quad2d(f,A,B,Cfun,Dfun,'RelTol',RelTol);
end