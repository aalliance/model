function v = wind(t)
% WIND Get the wind vector at a given time
% v = WIND(T) gets the column vector for th

mag = 2;
period = 0.1;
v = zeros(2,1);
lp = (t / period) - floor(t / period);
if lp < 0.5
    v(1) = mag*cos(lp*pi);
    v(2) = mag*sin(lp*pi);
else
    v(1) = mag*sin((lp-0.5)*pi);
    v(2) = mag*cos((lp-0.5)*pi);
end
