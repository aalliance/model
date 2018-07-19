function [infect, prod] = SuceptibilityModelBlock(i)
blocks = load('blocks.mat');
blocks = blocks.croi;
concentrations = load('concentration.mat');
concentrations = concentrations.Cinteg;
infect = [];
prod = [];

t_begin = 1;
t_end = 3;
train_end = 1.2;
t_frames = 100;
tlist = linspace(t_begin,t_end,t_frames);

for j=1:t_frames
    [in, pro] = SuceptibilityBlock(tlist(j), concentrations(i,j), blocks(i).TOTAL_POP);
    infect = [infect, in];
    prod = [prod, pro];
end
plot(tlist,infect,tlist,prod);
legend('Asymtomatic infected','Symptomatic');
xlabel('Time') % x-axis label
ylabel('Number of Individuals') % y-axis label