save pdesol.mat result
pdefits = interp_pde(msh, U - min(U(:)));
save pdesol.mat pdefits