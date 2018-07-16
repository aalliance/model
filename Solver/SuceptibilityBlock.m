function [I, P] = SuceptibilityBlock(t, C, M)
%% Input:
% ti: time of interest
%% Output
% I: Number of asymptomatic people at time t
% P: Number of symptomatic people at time t
% Total: Total number of infected people in the block
% lambda: Spore germination rate 
% theta: Clearance rate
% N: Total number of spores deposited in the body
% f: Respiratory flow rate
% tExposure: total time of exposure to anthrax
% p: Proportion of inhaled spores that are deposited in the body
%%
f = 2;
tExposure = 20;
p = 0.2;
N = C*f*tExposure*p;
lambda = 10^-5;
theta = 0.07;

Total = M*(1-exp((-N*lambda)/(lambda+theta)));
P = M*(1-exp(((-N*lambda)/(lambda+theta))*(1-exp(-(lambda+theta)*t))));
I = Total - P;