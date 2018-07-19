function mu = train(t)
global t_begin train_end begin_r end_r
period = train_end - t_begin;
%dist_miles = sqrt(sum((start_mu - end_mu).^2))*0.000621371
mu = begin_r + (end_r - begin_r)/period*(t-t_begin);


