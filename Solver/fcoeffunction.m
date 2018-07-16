function f = fcoeffunction(region,state)

N = 1; % Number of equations
nr = length(region.x); % Number of columns
f = zeros(N,nr); % Allocate f

% Now the particular functional form of f
% Gaussian source
mu = train(state.time);
mux = mu(1);
muy = mu(2);
% Wind vector
[w, wv] = wind2(state.time);
vx = w(1);
vy = w(2);
wvx = wv(1);
wvy = wv(2);
% f(1,:) = A*exp(-( (region.x-mux).^2 / (2*sigmax^2) + ...
%                   (region.y-muy).^2 / (2*sigmay^2))) - ... % source
%                   (state.ux * vx + ...
%                    state.uy * vy); % wind advection
%                                    % TODO add term for wind divergence
                                   
f(1,:) = Rfunction(region.x,region.y,mux,muy)- ...
            state.ux*vx + state.uy*vy + ...
            state.u*(differentiate(wvx{1},region.x) + differentiate(wvy{1},region.y));
end