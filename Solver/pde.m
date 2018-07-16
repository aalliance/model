%% Get data
geography = 'blocks.csv';
wind = 'wind.csv';
train_path = 'train.csv';

%% Create Model and Geometry
model = createpde();
shape = 3;
R1 = [shape;4;145775.217966;261891.430627;261891.430627;145775.217966;316146.384140;316146.384140;227638.059093;227638.059093];
gd = R1;
sf = 'R1';
ns = [82;49];
g = decsg(gd,sf,ns);
geometryFromEdges(model,g);

c = 0.05;
f = @(region,state) fcoeffunction(region,state);
specifyCoefficients(model,'m',0,'d',.1,'c',c,'a',0,'f',f);

%% Set Boundary Conditions
applyBoundaryCondition(model,'neumann','Edge',1:model.Geometry.NumEdges,'g',0,'q',1);

%% Set Initial Conditions
setInitialConditions(model,0);

%% Generate and Plot Mesh
msh = generateMesh(model,'Hmax',.15);
%msh = generateMesh(model);
figure;
pdemesh(model); 
axis equal

%% Find and Plot Solution
[~,~,tg] = Distances(train_path);
nframes = 20;
tlist = linspace(0,tg,nframes);

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
    %axis([-1 1 -1 1 0 1]);
    Mv(j) = getframe;
end