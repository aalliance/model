function mu = train(t)

period = 0.2;
start_mu = [1; 3];
end_mu = [1; 1];
mu = start_mu + (end_mu - start_mu)/period*t;


