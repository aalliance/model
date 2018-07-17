function ff = fcoeffunction(windf)
global train_end t_begin
    function f = fcfun(region,state)
        N = 1; % Number of equations
        nr = length(region.x); % Number of columns
        f = zeros(N,nr); % Allocate f

        % Now the particular functional form of f
        % Gaussian source
        mu = train(state.time);
        mux = mu(1);
        muy = mu(2);
        % Wind vector
        [vx, vy, dxv, dyv] = windf(state.time, region.x, region.y);
        wind_advection = state.ux .* vx + state.uy .* vy;
        wind_divergence = state.u .* (dxv + dyv);
        if state.time >= t_begin && state.time < train_end
            w = 9*10^21;
            r = 4.8765*10^3;
            D = 2.3*10^-16;
            source = r/(4*pi*D*w)* ... 
                     exp(-(((region.x-mux).^2 + ...
                            (region.y-muy).^2)/(4*D*w)));
        else
            source = 0;
        end
        f(1,:) = source - wind_advection - wind_divergence;
    end
    ff = @fcfun;
end
