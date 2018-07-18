global XMIN XMAX YMIN YMAX ROI fits_vx fits_vy
global t_begin t_end train_end tlist t_step tinterp
global croi sft2m
XMIN = 169000;
XMAX = 237000;
YMIN = 251000;
YMAX = 299000;
BB = [XMIN, YMIN; XMAX, YMAX];
ROI = bb2poly(BB);
t_begin = 1;
t_end = 3;
train_end = 1.2;
t_frames = 100;
tlist = linspace(t_begin,t_end,t_frames);
t_step = (t_end-t_begin)/(t_frames-1);
t_interp_frames = 24*(t_frames+t_begin/t_step);
tinterp = linspace(0,t_end,t_interp_frames);
sft2m = 1200/3937; % 1 survey foot = 1200/3937 meters

load fits_vx.mat fits_vx
load fits_vy.mat fits_vy
load census.mat croi