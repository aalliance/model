function [I, P] = SuceptibilityBlock(t, C, M)
%% Input:
% ti: time of interest
% C: Average concentration of spores in the block
% M = Total population in the block
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
p = 0.5;
N = C*p;
lambda = 5*10^-6;
theta = 0.07;

Total = M*(1-exp((-N*lambda)/(lambda+theta)));
P = M*(1-exp(((-N*lambda)/(lambda+theta))*(1-exp(-(lambda+theta)*t))));
I = Total - P;