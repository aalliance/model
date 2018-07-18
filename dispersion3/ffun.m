function f = ffun(x,y,u,ux,uy,time)
    global train_end t_begin windf
    N = 1; % Number of equations
    nr = length(u); % Number of columns
    f = zeros(N,nr); % Allocate f

    % Now the particular functional form of f
    % Gaussian source
    mu = train(time);
    mux = mu(1);
    muy = mu(2);
    % Wind vector
    [vx, vy, dxv, dyv] = windf(time, x, y);
    wind_advection = ux .* vx + uy .* vy;
    wind_divergence = u .* (dxv + dyv);
    if time >= t_begin && time < train_end
        w = 9*10^21;
        %r = 4.8765*10^8;
        r = 4.8765*10^6;
        D = 2.3*10^-16;
        source = r/(4*pi*D*w)* ... 
                 exp(-(((x-mux).^2 + ...
                        (y-muy).^2)/(4*D*w)));
    else
        source = 0;
    end
    f(1,:) = source - wind_advection - wind_divergence;
end
