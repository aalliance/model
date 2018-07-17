function pdefits = interp_pde(msh, U)
n = size(U,2);
pdefits = cell(n,1);
for tidx = 1:n
    pdefit = fit(msh.Nodes', U(:,tidx), 'biharmonicinterp');
    pdefits{tidx} = pdefit;
end
% save pddefits.mat pdefits