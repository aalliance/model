% Suceptibility Model
blocks = croi;
concentrations = Cinteg;
[n,~] = size(blocks);
I = cell(t_frames,1);
P = cell(t_frames,1);
I = zeros(1,t_frames);
P = zeros(1,t_frames);
block_max_conc = 0;
for i=1:n
    infect = [];
    prod = [];
    M = M + blocks(i).TOTAL_POP;
    c = 0;
    for j=1:t_frames
        c = c + concentrations(i,j);
        [in, pro] = SuceptibilityBlock(tlist(j), concentrations(i,j), blocks(i).TOTAL_POP);
        infect = [infect, in];
        prod = [prod, pro];
    end
    c = c/t_frames;
    if(c>block_max_conc)
        block_max_conc = c;
        block_max_conc_pos = i;
    end
    I = I + infect;
    P = P + prod;
end
plot(tlist,I,tlist,P);
legend('Asymtomatic infected','Symptomatic');
xlabel('Time') % x-axis label
ylabel('Number of Individuals') % y-axis label