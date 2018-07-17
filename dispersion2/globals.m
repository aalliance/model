global XMIN;
global XMAX;
global YMIN;
global YMAX;
global t_begin;
global t_end;
global train_end;
global tlist;
global t_step;
global tinterp;
global fits_vx;
global fits_vy;
XMIN = 169000;
XMAX = 237000;
YMIN = 251000;
YMAX = 299000;
t_begin = 1;
t_end = 3;
train_end = 1.04;
t_frames = 100;
t_step = (t_end-t_begin)/(t_frames-1);
t_interp_frames = 24*(t_frames+t_begin/t_step);
tlist = linspace(t_begin,t_end,t_frames);
tinterp = linspace(0,t_end,t_interp_frames);
load fits_vx.mat fits_vx
load fits_vy.mat fits_vy
