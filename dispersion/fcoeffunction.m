function f = fcoeffunction(region,state)

N = 1; % Number of equations
nr = length(region.x); % Number of columns
f = zeros(N,nr); % Allocate f

% Now the particular functional form of f
% Gaussian source
mu = train(state.time);
mux = mu(1);
muy = mu(2);
sigmax = 0.2;
sigmay = 0.2;
A = 1;
% Wind vector
w = wind(state.time);
vx = w(1);
vy = w(2);
f(1,:) = A*exp(-( (region.x-mux).^2 / (2*sigmax^2) + ...
                  (region.y-muy).^2 / (2*sigmay^2))) - ... % source
                  (state.ux * vx + ...
                   state.uy * vy); % wind advection
                                   % TODO add term for wind divergence