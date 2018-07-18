v = VideoWriter('pdemov.mp4','MPEG-4');
v.FrameRate = 8;
open(v);
writeVideo(v,Mv);
close(v);