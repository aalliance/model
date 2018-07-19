global XMIN XMAX YMIN YMAX tlist windf
%% Create Model and Geometry
model = createpde();

W = (XMAX - XMIN)*.5;
R1 = [3;4;XMIN;XMAX;XMAX;XMIN;YMAX;YMAX;YMIN;YMIN];
R2 = [3;4;XMIN-W;XMAX+W;XMAX+W;XMIN-W;YMAX+W;YMAX+W;YMIN-W;YMIN-W];
gd = [R1, R2];
sf = 'R1+R2';
ns = char('R1','R2')';
g = decsg(gd,sf,ns);
geometryFromEdges(model,g);
%pdegplot(model,'EdgeLabels','on','SubdomainLabels','on')

c = 1e7;
d = 1;
%specifyCoefficients(model,'m',0,'d',d,'c',c,'a',0,'f',ffun);

%% Set Boundary Conditions
%applyBoundaryCondition(model,'dirichlet','Edge',[3,4,5,8],'r',0,'h',1);
% Define the boundary condition vector, b, 
% for the boundary condition u = 0.
% For each exterior boundary segment, the boundary 
% condition vector is
bo = [1 1 1 1 1 1 '0' '0' '1' '0']';
bi = [0 1 1 1 1 1 '0' '0' '1' '0']';
% Create a boundary condition matrix that 
% represents all of the boundary segments.
b = [bi, bi, bo, bo, bo, bi, bi, bo];
%b = full(assemb(bv,p2,e2));

%% Set Initial Conditions
%setInitialConditions(model,0);

%% Generate and Plot Mesh
msh1 = generateMesh(model,'Hmax',2100,'GeometricOrder','linear');
[p1,e1,t1] = meshToPet(model.Mesh);
[p2,e2,t2] = refinemesh(g,p1,e1,t1,1);
pdemesh(p2,e2,t2);
%[p2,e2,t2] = refinemesh(g,p2,e2,t2,1);
%figure;
%pdemesh(model);
%axis equal


%% Find and Plot Solution
%model.SolverOptions.ReportStatistics ='on';
%result = solvepde(model,tlist);
%U = result.NodalSolution;
U = parabolic(0,tlist,b,p2,e2,t2,c,0,'ffun(x,y,u,ux,uy,t)',d,1e-2,1e-5);

%%
% Plot the solution.
%figure
Umax = max(max(U));
Umin = min(min(U));

for j = 1:length(tlist)
    %pdeplot(model,'XYData',U(:,j));
    pdeplot(p2,e2,t2,'XYData',U(:,j));
    hold on;
    plot(R1([3,4,5,6,3]), R1([7,8,9,10,7]), 'b-');
    hold off;
    caxis([Umin Umax]);
    Mv(j) = getframe;
end
% fig = figure; movie(fig,Mv,1);
save pdesol.mat U