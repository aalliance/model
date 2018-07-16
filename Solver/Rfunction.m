function F = Rfunction(x,y,x0,y0)
    w = 10^-3;
    r = 4.8765*10^3;
    D = 2.3*10^-16;
    
    F = (r/(4*pi*D*w))*exp(-(((x-x0).^2+(y-y0).^2)/(4*D*w)));
end
