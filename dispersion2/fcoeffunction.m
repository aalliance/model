function ff = fcoeffunction(windf)
global train_end;
global t_begin;
    function f = fcfun(region,state)
        N = 1; % Number of equations
        nr = length(region.x); % Number of columns
        f = zeros(N,nr); % Allocate f

        % Now the particular functional form of f
        % Gaussian source
        mu = train(state.time);
        mux = mu(1);
        muy = mu(2);
        sigmax = 2000;
        sigmay = 2000;
        A = 1;
        % Wind vector
        [vx, vy, ~, ~] = windf(state.time, region.x, region.y);
        wind_advection = state.ux .* vx + state.uy .* vy;
        % wind_divergence = ;
        
        if state.time >= t_begin && state.time < train_end
            source = A*exp(-( (region.x-mux).^2 / (2*sigmax^2) + ...
                              (region.y-muy).^2 / (2*sigmay^2)));
        else
            source = 0;
        end
        f(1,:) = source - wind_advection; % TODO add term for wind divergence
    end
    ff = @fcfun;
end
