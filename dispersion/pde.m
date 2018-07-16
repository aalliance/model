%% Create Model and Geometry
model = createpde();
XW = 5;
YW = 7;
R1 = [3;4;0;XW;XW;0;YW;YW;0;0];
gd = R1;
sf = 'R1';
ns = [82;49];
g = decsg(gd,sf,ns);
geometryFromEdges(model,g);

c = 0.05;
specifyCoefficients(model,'m',0,'d',.1,'c',c,'a',0,'f',@fcoeffunction);

%% Set Boundary Conditions
applyBoundaryCondition(model,'dirichlet','Edge',1:4,'r',0,'h',1);

%% Set Initial Conditions
setInitialConditions(model,0);

%% Generate and Plot Mesh
msh = generateMesh(model,'Hmax',.2);
%msh = generateMesh(model);
figure;
pdemesh(model); 
axis equal

%% Find and Plot Solution
nframes = 20;
tlist = linspace(0,0.2,nframes);

model.SolverOptions.ReportStatistics ='on';
result = solvepde(model,tlist);
U = result.NodalSolution;

%%
% Plot the solution.
figure
Umax = max(max(U));
Umin = min(min(U));
for j = 1:nframes
    pdeplot(model,'XYData',U(:,j));
    caxis([Umin Umax]);
    Mv(j) = getframe;
end