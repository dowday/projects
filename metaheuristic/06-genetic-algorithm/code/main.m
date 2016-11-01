function fit = main(pc,pm,pop_size,g_max,population)
% pc = 0.6;
% pm = 0.1;%0.01
% pop_size = 100;
% g_max = (10^3)/pop_size;
generation = 0;
%initialize population
%2 columns : x,y 
% population = round(rand(pop_size,2)*990)+10;
%new_population = Inf(100,2);

while generation ~= g_max
    generation = generation +1;
    
    %compute the fitness of each member of the population
    for i=1:pop_size
        fitnesses(i) = fitness(population(i,1),population(i,2));
    end
    
   %selection
   %the tournament selects 5 individuals and returns the winner
   for j=1:pop_size
        [xs ys] = tournament(population,fitnesses,pop_size,5);
        new_population(j,1) = xs;
        new_population(j,2) = ys;
   end
   population = new_population;
   
    for i=1:pop_size-1
        rndc = rand();
        if rndc <= pc
%             [xc, yc] = crossover(population(i,1), population(i+1,2));
%             population(i,1) = xc;
%             population(i,2) = yc;
            [x1, x2] = crossover(population(i,1), population(i+1,1));
            [y1, y2] = crossover(population(i+1,2), population(i,2));
            population(i,1) = x1;
            population(i,2) = y1;
            population(i+1,1) = x2;
            population(i+1,2) = y2;
        end 
    end
    for i=1:pop_size
        %rndm = rand();
        %if rndm <= pm
        %prob is implemented in the function mutation.m
            population(i,1) = mutation(population(i,1),pm);
            population(i,2) = mutation(population(i,2),pm);
        %end 
    end
       
end

results = Inf(100,3);
%return the best fitness
for i=1:pop_size
    results(i,1) = population(i,1);
    results(i,2) = population(i,2);
    results(i,3) = fitness(population(i,1),population(i,2));
end

[best_fitness,pop_index] = min(results(:,3));

x = results(pop_index,1); %population(pop_index,1)
%px = population(pop_index,1)
y = results(pop_index,2); %population(pop_index,2)
%py = population(pop_index,2)
%winner_fitness = results(pop_index,3)

%disp('best fitness:');
fit = best_fitness;

end

