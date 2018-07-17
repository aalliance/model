function mu = train(t)
global t_begin;
global train_end;
period = train_end - t_begin;
start_mu = [185319; 284379]; % 608k, 933k
end_mu = [220980; 266701]; % 725k, 875k
%dist_miles = sqrt(sum((start_mu - end_mu).^2))*0.000621371
mu = start_mu + (end_mu - start_mu)/period*(t-t_begin);


