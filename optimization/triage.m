NBLOCK = 3;                    % Num of blocks
TOTAL = [108; 1004; 1004];     % Total population
INCUB = [20; 175; 300];        % Num infected in incubation (asymptomatic)
PRODR = [8; 50; 50];             % Num infected in prodromal (symptomatic)
UNINF = TOTAL - PRODR - INCUB; % Num of uninfected (asymptomatic)
ASYMP = TOTAL - PRODR;         % Num of asymptomatics 
APCTI = INCUB ./ ASYMP;        % Pct of asymptomatic that are infected
EFF_INCUB = 0.9;   % Effectiveness of antibiotic in incubation stage
EFF_PRODR = 0.25;  % Effectiveness of antibiotic in prodromal stage
SUP_ANTIB = 1100;  % Total doses of antibiotic available
EV_ASYMP = EFF_INCUB .* APCTI;
EV_PRODR = EFF_PRODR .* ones(NBLOCK, 1);
EV_FIRST = EV_ASYMP .* ASYMP ./ TOTAL + EV_PRODR .* PRODR ./ TOTAL;
BIGNUM = 2^25;

% TRI_ASYMP
% TRI_PRODR
% TRI_FIRST
% TRT_ANTIB
% NUM_SAVED
NVARS = NBLOCK*5;
NINDS = NBLOCK*3;
intcon = 1:NINDS;
lb = zeros(NVARS,1);
ub = ones(NVARS,1);
ub((NINDS+1):end) = Inf; % No upper bound on noninteger variables
f = zeros(NVARS,1);
f((end-2):end) = -1;

% equality conditions
NBEQ = NBLOCK;
beq = zeros(NBEQ, 1);
Aeq = zeros(NBEQ, NVARS);
% set constraints for triage indicator variables
beq(1:NBLOCK) = 1;
INDS_DIAG = diag(ones(NBLOCK,1));
Aeq(1:NBLOCK, 1:NINDS) = horzcat(INDS_DIAG, INDS_DIAG, INDS_DIAG);

% inequality conditions
NB = 1 + NINDS*2;
b = zeros(NB, 1);
b(1) = SUP_ANTIB;
b(2:(1+NINDS)) = BIGNUM;
b((2+NINDS):end) = BIGNUM + vertcat(ASYMP,PRODR,TOTAL);
A = zeros(NB, NVARS);
% total antibiotic supply
A(1, 10:12) = 1;
% number saved
A(2, [1, 10, 13]) = [BIGNUM, -EV_ASYMP(1), 1];
A(3, [2, 11, 14]) = [BIGNUM, -EV_ASYMP(2), 1];
A(4, [3, 12, 15]) = [BIGNUM, -EV_ASYMP(3), 1];
A(5, [4, 10, 13]) = [BIGNUM, -EV_PRODR(1), 1];
A(6, [5, 11, 14]) = [BIGNUM, -EV_PRODR(2), 1];
A(7, [6, 12, 15]) = [BIGNUM, -EV_PRODR(3), 1];
A(8, [7, 10, 13]) = [BIGNUM, -EV_FIRST(1), 1];
A(9, [8, 11, 14]) = [BIGNUM, -EV_FIRST(2), 1];
A(10,[9, 12, 15]) = [BIGNUM, -EV_FIRST(3), 1];
%BIGNUM*TRI_ASYMP - EV_ASYMP .* TRT_ANTIB + NUM_SAVED <= BIGNUM
%BIGNUM*TRI_PRODR - EV_PRODR .* TRT_ANTIB + NUM_SAVED <= BIGNUM
%BIGNUM*TRI_FIRST - EV_FIRST .* TRT_ANTIB + NUM_SAVED <= BIGNUM
% number of persons to give antibitics to
A(11, [1, 10]) = [BIGNUM, 1];
A(12, [2, 11]) = [BIGNUM, 1];
A(13, [3, 12]) = [BIGNUM, 1];
A(14, [4, 10]) = [BIGNUM, 1];
A(15, [5, 11]) = [BIGNUM, 1];
A(16, [6, 12]) = [BIGNUM, 1];
A(17, [7, 10]) = [BIGNUM, 1];
A(18, [8, 11]) = [BIGNUM, 1];
A(19, [9, 12]) = [BIGNUM, 1];
%BIGNUM*TRI_ASYMP + TRT_ANTIB  <= BIGNUM + ASYMP
%BIGNUM*TRI_PRODR + TRT_ANTIB  <= BIGNUM + PRODR
%BIGNUM*TRI_FIRST + TRT_ANTIB  <= BIGNUM + TOTAL

%x0 = [0;0;0; 0;0;0; 1;1;1; 1000;1000;1000; 10;10;10];
x = intlinprog(f,intcon,A,b,Aeq,beq,lb,ub);