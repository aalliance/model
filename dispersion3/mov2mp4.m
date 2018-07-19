function mov2mp4(mov, filename, framerate)
%MOV2MP4 Write the movie to an MPEG-4 video file
%   Detailed explanation goes here
v = VideoWriter(filename,'MPEG-4');
v.FrameRate = framerate;
open(v);
writeVideo(v,mov);
close(v);
end

