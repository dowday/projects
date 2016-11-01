function s = succRate(optimal_value, succ_rate, max_runs,pc,pm,pop_size,g_max,population)
% optimal_value = -1356;%value observed graphically by plotting the function
% succ_rate = 0;
% max_runs=25;

for nb_run=1:max_runs
    val = main(pc,pm,pop_size,g_max,population);
    if val <= optimal_value
        succ_rate = succ_rate +1;
    end
end
SRATE = succ_rate/max_runs;
s =SRATE;
end

