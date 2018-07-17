%% Create Model and Geometry
model = createpde();

global XMIN XMAX YMIN YMAX tlist fits_vx fits_vy
memwind = windfunction(fits_vx, fits_vy);
ffun = fcoeffunction(memwind);
R1 = [3;4;XMIN;XMAX;XMAX;XMIN;YMAX;YMAX;YMIN;YMIN];
gd = R1;
sf = 'R1';
ns = [82;49];
g = decsg(gd,sf,ns);
geometryFromEdges(model,g);

c = 1000000;
d = 1;
specifyCoefficients(model,'m',0,'d',d,'c',c,'a',0,'f',ffun);

%% Set Boundary Conditions
applyBoundaryCondition(model,'dirichlet','Edge',1:4,'r',0,'h',1);

%% Set Initial Conditions
setInitialConditions(model,0);

%% Generate and Plot Mesh
msh = generateMesh(model,'Hmax',2000);
figure;
pdemesh(model); 
axis equal

%% Find and Plot Solution
model.SolverOptions.ReportStatistics ='on';
result = solvepde(model,tlist);
U = result.NodalSolution;

%%
% Plot the solution.
figure
Umax = max(max(U));
Umin = min(min(U));
for j = 1:length(tlist)
    pdeplot(model,'XYData',U(:,j));
    caxis([Umin Umax]);
    Mv(j) = getframe;
end