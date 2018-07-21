% Susceptibility by dose convolution
global respiratory_rate t_frames t_step

p = 0.5;
N = C*p;
lambda = 5*10^-6;
theta = 0.07;

TOTAL_POP = [croi(:).TOTAL_POP]';
F = repmat(TOTAL_POP,1,t_frames).*(1-exp((-p*Cinteg*lambda)/(lambda+theta)));

% concentration convolution
convvec = 1-exp(-(lambda+theta)*(((1:t_frames)-1)*t_step));
P = zeros(size(F));
for bidx = 1:size(C, 1)
    for tidx = 2:size(C,2)
        esum = -lambda/(lambda+theta)*respiratory_rate*p*t_step* ...
               sum(C(bidx, 1:(tidx-1)) .* convvec(tidx:(-1):2));
        P(bidx, tidx) = TOTAL_POP(bidx) * (1 - exp(esum));
    end
end
I = Total - P;
Ftot = sum(F, 1);
Ptot = sum(P, 1);
Itot = sum(I, 1);
