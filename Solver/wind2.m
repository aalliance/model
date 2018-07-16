function [p,v] = wind2(t)
% WIND Get the wind vector at a given time
% v = WIND(T) gets the column vector for th

[x,y] = Interp_wind();
p = [x{1}(t),y{1}(t)];
v = [x,y];
end
