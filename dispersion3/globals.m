global XMIN XMAX YMIN YMAX ROI fits_vx fits_vy
global t_begin t_end train_end tlist t_step tinterp
global begin_r end_r croi sft2m windf
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

load fits_vx.mat fits_vx
load fits_vy.mat fits_vy
windf = windfunction(fits_vx, fits_vy);
load census.mat croi
