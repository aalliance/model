NBLOCK = 4;                    % Num of blocks
TOTAL = [100; 1000; 1000; 2000];% Total population
INCUB = [20; 175; 300; 400];   % Num infected in incubation (asymptomatic)
PRODR = [10; 50; 50; 70];       % Num infected in prodromal (symptomatic)
UNINF = TOTAL - PRODR - INCUB; % Num of uninfected (asymptomatic)
ASYMP = TOTAL - PRODR;         % Num of asymptomatics 
APCTI = INCUB ./ ASYMP;        % Pct of asymptomatic that are infected
EFF_INCUB = 0.9;   % Effectiveness of antibiotic in incubation stage
EFF_PRODR = 0.25;  % Effectiveness of antibiotic in prodromal stage
SUP_ANTIB = 1000;  % Total doses of antibiotic available
EV_ASYMP = EFF_INCUB .* APCTI; % expected number saved per antibiotic dose
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
c1 = 1:NINDS; % column indices of indicator variables
c2 = (NINDS+1):(NINDS+NBLOCK); % column indices of antibiotics used
c3 = (NINDS+NBLOCK+1):NVARS; % column indices of lives saved
intcon = 1:NINDS; % integer variables
lb = zeros(NVARS, 1);
ub = ones(NVARS, 1);
ub((NINDS+1):end) = Inf; % No upper bound on noninteger variables
f = zeros(NVARS, 1);
f((end-NBLOCK+1):end) = -1; % maximized lives saved

% equality conditions
NBEQ = NBLOCK;
beq = zeros(NBEQ, 1);
Aeq = zeros(NBEQ, NVARS);
% set constraints for triage indicator variables
% TRI_ASYMP + TRI_PRODR + TRI_FIRST = 1
beq(1:NBLOCK) = 1;
INDS_DIAG = diag(ones(NBLOCK, 1));
Aeq(1:NBLOCK, 1:NINDS) = [INDS_DIAG, INDS_DIAG, INDS_DIAG];

% inequality conditions
NB = 1 + NINDS*2;
b = zeros(NB, 1);
A = zeros(NB, NVARS);
% total antibiotic supply
% ? TRT_ANTIB <= SUP_ANTIB
b(1) = SUP_ANTIB;
A(1, c2) = 1;
% number of persons to give antibitics to
% BIGNUM*TRI_ASYMP + TRT_ANTIB  <= BIGNUM + ASYMP
% BIGNUM*TRI_PRODR + TRT_ANTIB  <= BIGNUM + PRODR
% BIGNUM*TRI_FIRST + TRT_ANTIB  <= BIGNUM + TOTAL
b(2:(1+NINDS)) = BIGNUM + [ASYMP; PRODR; TOTAL];
r1 = 2:(1+NINDS);

A(sub2ind(size(A), r1, c1)) = BIGNUM;
A(sub2ind(size(A), r1, repmat(c2, 1, 3))) = 1;
% number saved
% BIGNUM*TRI_ASYMP - EV_ASYMP .* TRT_ANTIB + NUM_SAVED <= BIGNUM
% BIGNUM*TRI_PRODR - EV_PRODR .* TRT_ANTIB + NUM_SAVED <= BIGNUM
% BIGNUM*TRI_FIRST - EV_FIRST .* TRT_ANTIB + NUM_SAVED <= BIGNUM
b((2+NINDS):end) = BIGNUM;
r2 = (1+NINDS+1):(1+2*NINDS);
A(sub2ind(size(A),r2,c1)) = BIGNUM;
A(sub2ind(size(A),r2,repmat(c2,1,3))) = -[EV_ASYMP; EV_PRODR; EV_FIRST];
A(sub2ind(size(A),r2,repmat(c3,1,3))) = 1;

x0 = [0;0;0;0; 0;0;0;0; 1;1;1;1; 100;1000;1000;2000; 10;10;10;10];
x = intlinprog(f, intcon, A, b, Aeq, beq, lb, ub, x0);