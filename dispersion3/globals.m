global XMIN XMAX YMIN YMAX ROI fits_vx fits_vy
global t_begin t_end train_end tlist t_step tinterp
global begin_r end_r croi sft2m windf
global conc_factor respiratory_rate
sft2m = 1200/3937; % 1 survey foot = 1200/3937 meters
XMIN = 169000;
XMAX = 237000;
YMIN = 251000;
YMAX = 299000;
BB = [XMIN, YMIN; XMAX, YMAX];
ROI = bb2poly(BB);
begin_r = [185319; 284379]; % 608k, 933k starting point of release path
end_r = [220980; 266701];   % 725k, 875k ending point of release path
t_begin = 1;
t_end = 3;
train_end = 1.2;
t_frames = 101;
tlist = linspace(t_begin,t_end,t_frames);
t_step = (t_end-t_begin)/(t_frames-1);
%t_interp_frames = 10*(t_frames+t_begin/t_step);
%tinterp = linspace(0,t_end,t_interp_frames);
t_interp_frames = 4 * t_frames;
tinterp = linspace(t_begin,t_end,t_interp_frames);
% to convert concentrations --
% 100g ~= 10^14 spores, 20kg ~= 2*10^16
% 1 / (10^7)     % r from ffun
% * 0.2     ...  % 0.2 days release
% * 2*10^16 ...  % 20kg * 0.2 days release
% / 50           % spread out over m height
% respiration rate 8.6 m^3/day
conc_factor = (train_end - t_begin) / 1e7 * 2e16 / 50;
respiratory_rate = 8.6; % m^3 / day

load fits_vx.mat fits_vx
load fits_vy.mat fits_vy
windf = windfunction(fits_vx, fits_vy);
load census.mat croi
