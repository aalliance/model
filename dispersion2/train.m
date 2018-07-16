function mu = train(t)
global t_begin;
global train_end;
period = train_end - t_begin;
start_mu = [190000; 290000];
end_mu = [220000; 270000];
mu = start_mu + (end_mu - start_mu)/period*(t-t_begin);


