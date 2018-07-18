global tinterp fits_vx fits_vy

w = csvread('wind.csv');
u = unique(w(:, 1:2), 'rows'); % station locations
ns = size(u,1);                % number of stations
fits_sid_vx_t = cell(ns,1);
fits_sid_vy_t = cell(ns,1);
sdats = cell(ns,1);
for sid = 1:ns
    scoord = u(sid,:);
    sdat = w(w(:,1)==scoord(1) & w(:,2)==scoord(2), :);
    sdats{sid} = sdat;
    fvxt = fit(sdat(:,3), sdat(:,4), 'pchipinterp');
    fvyt = fit(sdat(:,3), sdat(:,5), 'pchipinterp');
    fits_sid_vx_t{sid} = fvxt;
    fits_sid_vy_t{sid} = fvyt;
end
%plot(fits_sid_vx_t{1}, sdats{1}(:,3), sdats{1}(:,4))

%t_begin = 1;
%t_end = 28;
%t_delta = 1;
%tvec = t_begin:t_delta:t_end;
nt = length(tlist);
fits_t_vx_xy = containers.Map('KeyType','double','ValueType','any');
fits_t_vy_xy = containers.Map('KeyType','double','ValueType','any');
for tq = tinterp
    sq = u;
    for sid = 1:ns
        fx = fits_sid_vx_t{sid};
        sq(sid, 4) = feval(fx, tq);
        fy = fits_sid_vy_t{sid};
        sq(sid, 5) = feval(fy, tq);
    end
    fvxxy = fit(sq(:,1:2), sq(:,4), 'thinplateinterp');
    fvyxy = fit(sq(:,1:2), sq(:,5), 'thinplateinterp');
    fits_t_vx_xy(tq) = fvxxy;
    fits_t_vy_xy(tq) = fvyxy;
end
%plot(fits_t_vx_xy{1});
%[fx, fy] = differentiate(fits_t_vx_xy{1}, 200000, 200000)
fits_vx = fits_t_vx_xy;
fits_vy = fits_t_vy_xy;

save fits_vx.mat fits_vx
save fits_vy.mat fits_vy

