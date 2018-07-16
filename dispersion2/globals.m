global XMIN;
global XMAX;
global YMIN;
global YMAX;
global t_begin;
global t_end;
global train_end;
global tlist;
global tstep;
global tinterp;
global fits_vx;
global fits_vy;
XMIN = 169000;
XMAX = 237000;
YMIN = 251000;
YMAX = 299000;
t_begin = 1;
t_end = 5;
train_end = 2;
t_frames = 5;
t_interp_frames = t_frames*24;
tlist = linspace(t_begin,t_end,t_frames);
tinterp = linspace(0,t_end,t_interp_frames+t_begin*(t_frames-1)/(t_end-t_begin));
tstep = 24*60*60; % one day, time step in seconds
load fits_vx.mat fits_vx
load fits_vy.mat fits_vy
