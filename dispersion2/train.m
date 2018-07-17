function mu = train(t)
global t_begin;
global train_end;
period = train_end - t_begin;
start_mu = [180000; 280000];
end_mu = [220000; 265000];
mu = start_mu + (end_mu - start_mu)/period*(t-t_begin);


